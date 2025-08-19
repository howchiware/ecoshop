// 관리자 - 문의사항 디테일 보기
$(function(){
	$('div#content-area').on('click', 'tr.inquiryTr', function(){
		const $table = $(this).closest('table');
		const $inquiryDetailTr = $(this).next();
		
		if($inquiryDetailTr.hasClass('d-none')){
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.removeClass('d-none');
		} else {
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.addClass('d-none');
		}
		
		let inquireDetailAnswerAddEl = $inquiryDetailTr.find('div.inquireDetailAnswerAdd');
		textareaEl = inquireDetailAnswerAddEl.find('textarea#answerTA');
		
		let inquireDetailAnswerAddEls = $table.find('textarea#answerTA');
		if(inquireDetailAnswerAddEls.length != 0){
			inquireDetailAnswerAddEls.remove();
		}
	
		if(inquireDetailAnswerAddEl.length != 0 && textareaEl.length === 0){
			const textareaTag = document.createElement("textarea");
			textareaTag.setAttribute('id', 'answerTA');
			textareaTag.setAttribute('class', 'answerTA');
			textareaTag.setAttribute('name', 'answer');
			textareaTag.setAttribute('placeholder', '답변을 입력해주세요.');
			inquireDetailAnswerAddEl.prepend(textareaTag);
		} else if(inquireDetailAnswerAddEl.length != 0 && textareaEl.length != 0){
			textareaEl.remove();
		}
	});	
})

// 답변 등록
$(function(){
	$('div#content-area').on('click', 'button.addAnswer', function(){
		const f = document.inquiryAnswerForm;
		
		const answerEL = $(this).parent().children('textarea');
		console.log(answerEL);
		if(! answerEL.val() ) {
			alert('답변을 입력하세요. ');
			answerEL.focus();
			return;
		}
		
		// name 넣어주기
		const inquiryId = $(this).attr('data-inquiryId');
		const answerId = $(this).attr('data-managerId');
		const answerName = $(this).attr('data-managerName');
		console.log(inquiryId);
		console.log(answerId);
		console.log(answerName);
		
		let inputTag1 = document.createElement("input");
				
		inputTag1.classList.add('inquiryIdInput');
		inputTag1.setAttribute('type', 'hidden');
		inputTag1.setAttribute('name', 'inquiryId');
		inputTag1.value = inquiryId;
		
		let inputTag2 = document.createElement("input");
				
		inputTag2.classList.add('answerIdInput');
		inputTag2.setAttribute('type', 'hidden');
		inputTag2.setAttribute('name', 'answerId');
		inputTag2.value = answerId;
		
		let inputTag3 = document.createElement("input");
				
		inputTag3.classList.add('answerNameInput');
		inputTag3.setAttribute('type', 'hidden');
		inputTag3.setAttribute('name', 'answerName');
		inputTag3.value = answerName;
		
		const inquireDetailAnswerAddEl = $(this).closest('div.inquireDetailAnswerAdd');
		inquireDetailAnswerAddEl.append(inputTag1);
		inquireDetailAnswerAddEl.append(inputTag2);
		inquireDetailAnswerAddEl.append(inputTag3);
		
		answerEL.prop('name', 'answer');

		// 등록
		f.action = 'writeAnswer';
		f.submit();
	});
});

// 답변 수정 시작
$(function(){
	$('div#content-area').on('click', 'button.updateAnswer', function(){
		const answerEL = $(this).parent().prev().children('p');
		const updateAnswerBtnEl = $(this);
		const removeAnswerBtnEl = $(this).next('button');
		const inquireDetailAnswerContentEl = $(this).closest('div').prev();
		const inquiryDetailAnswerNDEl = inquireDetailAnswerContentEl.prev();
		
		answerEL.prop('style', 'display: none');
		updateAnswerBtnEl.prop('style', 'display: none');
		removeAnswerBtnEl.prop('style', 'display: none');
		inquiryDetailAnswerNDEl.prop('style', 'display: none');
		
		let btnTag1 = document.createElement("button");
		
		btnTag1.classList.add('small-btn');
		btnTag1.classList.add('updateSubmitAnswer');
		btnTag1.setAttribute('type', 'button');
		btnTag1.textContent = '수정';

		let btnTag2 = document.createElement("button");
		
		btnTag2.classList.add('small-btn');
		btnTag2.classList.add('updateCancelAnswer');
		btnTag2.setAttribute('type', 'button');
		btnTag2.textContent = '수정취소';
		
		const textareaTag = document.createElement("textarea");
		textareaTag.setAttribute('id', 'answerTA');
		textareaTag.setAttribute('class', 'answerTA');
		textareaTag.setAttribute('name', 'answer');
		textareaTag.setAttribute('placeholder', '답변을 입력해주세요.');
		inquireDetailAnswerContentEl.append(textareaTag);
		
		const btnArea = inquireDetailAnswerContentEl.next();
		btnArea.append(btnTag1);
		btnArea.append(btnTag2);
		
		// name 넣어주기
		const inquiryId = $(this).attr('data-inquiryId');
		const answerId = $(this).attr('data-managerId');
		const answerName = $(this).attr('data-managerName');
		console.log(inquiryId);
		console.log(answerId);
		console.log(answerName);
		
		let inputTag1 = document.createElement("input");
				
		inputTag1.classList.add('inquiryIdInput');
		inputTag1.setAttribute('type', 'hidden');
		inputTag1.setAttribute('name', 'inquiryId');
		inputTag1.value = inquiryId;
		
		let inputTag2 = document.createElement("input");
				
		inputTag2.classList.add('answerIdInput');
		inputTag2.setAttribute('type', 'hidden');
		inputTag2.setAttribute('name', 'answerId');
		inputTag2.value = answerId;
		
		let inputTag3 = document.createElement("input");
				
		inputTag3.classList.add('answerNameInput');
		inputTag3.setAttribute('type', 'hidden');
		inputTag3.setAttribute('name', 'answerName');
		inputTag3.value = answerName;
		
		btnArea.append(inputTag1);
		btnArea.append(inputTag2);
		btnArea.append(inputTag3);
		
	});
	
	// 수정 완료
	$('div#content-area').on('click', 'button.updateSubmitAnswer', function(){
		const f = document.inquiryAnswerForm;

		let answerEL = $(this).parent().prev().children('textarea');
		console.log(answerEL);
		if(! answerEL.val()) {
			alert('답변을 입력하세요. ');
			answerEL.focus();
			return;
		}
		
		f.action = 'writeAnswer';
		f.submit();
	});
	
	// 수정 취소
	$('div#content-area').on('click', 'button.updateCancelAnswer', function(){
		let inquiryDetailNDCEl = $(this).parent().parent();
		
		let inquiryDetailAnswerNDEl = inquiryDetailNDCEl.find('div.inquiryDetailAnswerND');
		let answerEl = inquiryDetailNDCEl.find('p.answerP');
		let textareaEl = inquiryDetailNDCEl.find('textarea.answerTA');
		let hiddenInputs = $(this).parent().find('input[type=hidden');
		let updateBtn = $(this).parent().find('button.updateAnswer');
		let removeBtn = $(this).parent().find('button.removeAnswer');
		let updateSubmitBtn = $(this).prev();
		let updateCancelBtn = $(this);
			
		hiddenInputs.each(function(){
			$(this).remove();
		});
		
		inquiryDetailAnswerNDEl.prop('style', 'display: inline-flex');
		answerEl.prop('style', 'display: block');
		updateBtn.prop('style', 'display: inline-block');
		removeBtn.prop('style', 'display: inline-block');
		
		updateSubmitBtn.remove();
		updateCancelBtn.remove();
		textareaEl.remove();
		
	});
});

$(function(){
	// 답변 삭제
	$('div#content-area').on('click', 'button.removeAnswer', function(){
		let inquiryId = $(this).attr('data-inquiryId');
		
		if(! confirm('해당 문의에 대한 답변을 삭제하시겠습니까 ?')){
			return false;
		}

		location.href = 'deleteAnswer?inquiryId=' + inquiryId;
	});
})

$(function(){
	// 문의 삭제
	$('div#content-area').on('click', 'button.deleteInquiry', function(){
		let inquiryId = $(this).attr('data-inquiryId');

		if(! confirm('해당 문의를 삭제하시겠습니까 ?')){
			return false;
		}

		location.href = 'deleteInquiry?inquiryId=' + inquiryId;
	});
});