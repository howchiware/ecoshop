// 관리자 - 리뷰 디테일 보기
$(function(){
	$('div#content-area').on('click', 'tr.reviewTr', function(){
		const $table = $(this).closest('table');
		const $reviewDetailTr = $(this).next();
		
		if($reviewDetailTr.hasClass('d-none')){
			$table.children().find('tr.reviewDetailTr').addClass('d-none');
			
			$reviewDetailTr.removeClass('d-none');
		} else {
			$table.children().find('tr.reviewDetailTr').addClass('d-none');
			
			$reviewDetailTr.addClass('d-none');
		}
		
		let reviewDetailAnswerAddEl = $reviewDetailTr.find('div.reviewDetailAnswerAdd');
		textareaEl = reviewDetailAnswerAddEl.find('textarea#answerTA');
		
		let reviewDetailAnswerAddEls = $table.find('textarea#answerTA');
		if(reviewDetailAnswerAddEls.length != 0){
			reviewDetailAnswerAddEls.remove();
		}
	
		if(reviewDetailAnswerAddEl.length != 0 && textareaEl.length === 0){
			const textareaTag = document.createElement("textarea");
			textareaTag.setAttribute('id', 'answerTA');
			textareaTag.setAttribute('class', 'answerTA');
			textareaTag.setAttribute('name', 'answer');
			textareaTag.setAttribute('placeholder', '답변을 입력해주세요.');
			reviewDetailAnswerAddEl.prepend(textareaTag);
		} else if(reviewDetailAnswerAddEl.length != 0 && textareaEl.length != 0){
			textareaEl.remove();
		}
	});	
})

/////////// 공구 리뷰 ////////////
// 공구 답변 등록
$(function(){
	$('div#content-area').on('click', 'button.addAnswer', function(){
		const f = document.reviewAnswerForm;
		
		const answerEL = $(this).parent().children('textarea');
		console.log(answerEL);
		if(! answerEL.val() ) {
			alert('답변을 입력하세요. ');
			answerEL.focus();
			return;
		}
		
		// name 넣어주기
		const gongguOrderDetailId = $(this).attr('data-gongguOrderDetailId');
		const answerId = $(this).attr('data-managerId');
		const answerName = $(this).attr('data-managerName');
		console.log(gongguOrderDetailId);
		console.log(answerId);
		console.log(answerName);
		
		let inputTag1 = document.createElement("input");
				
		inputTag1.classList.add('gongguOrderDetailIdIdInput');
		inputTag1.setAttribute('type', 'hidden');
		inputTag1.setAttribute('name', 'gongguOrderDetailId');
		inputTag1.value = gongguOrderDetailId;
		
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
		
		const reviewDetailAnswerAddEl = $(this).closest('div.reviewDetailAnswerAdd');
		reviewDetailAnswerAddEl.append(inputTag1);
		reviewDetailAnswerAddEl.append(inputTag2);
		reviewDetailAnswerAddEl.append(inputTag3);
		
		answerEL.prop('name', 'answer');

		// 등록
		f.action = 'writeAnswer';
		f.submit();
	});
});

// 공구 답변 수정 시작
$(function(){
	$('div#content-area').on('click', 'button.updateAnswer', function(){
		const answerEL = $(this).parent().prev().children('p');
		const updateAnswerBtnEl = $(this);
		const removeAnswerBtnEl = $(this).next('button');
		const reviewDetailAnswerContentEl = $(this).closest('div').prev();
		const reviewDetailAnswerNDEl = reviewDetailAnswerContentEl.prev();
		
		answerEL.prop('style', 'display: none');
		updateAnswerBtnEl.prop('style', 'display: none');
		removeAnswerBtnEl.prop('style', 'display: none');
		reviewDetailAnswerNDEl.prop('style', 'display: none');
		
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
		reviewDetailAnswerContentEl.append(textareaTag);
		
		const btnArea = reviewDetailAnswerContentEl.next();
		btnArea.append(btnTag1);
		btnArea.append(btnTag2);
		
		// name 넣어주기
		const gongguOrderDetailId = $(this).attr('data-gongguOrderDetailId');
		const answerId = $(this).attr('data-managerId');
		const answerName = $(this).attr('data-managerName');
		console.log(gongguOrderDetailId);
		console.log(answerId);
		console.log(answerName);
		
		let inputTag1 = document.createElement("input");
				
		inputTag1.classList.add('gongguOrderDetailIdIdInput');
		inputTag1.setAttribute('type', 'hidden');
		inputTag1.setAttribute('name', 'gongguOrderDetailId');
		inputTag1.value = gongguOrderDetailId;
		
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
		const f = document.reviewAnswerForm;

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
		let reviewDetailNDCEl = $(this).parent().parent();
		
		let reviewDetailAnswerNDEl = reviewDetailNDCEl.find('div.reviewDetailAnswerND');
		let answerEl = reviewDetailNDCEl.find('p.answerP');
		let textareaEl = reviewDetailNDCEl.find('textarea.answerTA');
		let hiddenInputs = $(this).parent().find('input[type=hidden]');
		let updateBtn = $(this).parent().find('button.updateAnswer');
		let removeBtn = $(this).parent().find('button.removeAnswer');
		let updateSubmitBtn = $(this).prev();
		let updateCancelBtn = $(this);
			
		hiddenInputs.each(function(){
			$(this).remove();
		});
		
		reviewDetailAnswerNDEl.prop('style', 'display: inline-flex');
		answerEl.prop('style', 'display: block');
		updateBtn.prop('style', 'display: inline-block');
		removeBtn.prop('style', 'display: inline-block');
		
		updateSubmitBtn.remove();
		updateCancelBtn.remove();
		textareaEl.remove();
		
	});
});

$(function(){
	// 공구 리뷰 삭제
	$('div#content-area').on('click', 'button.deleteReview', function(){
		let gongguOrderDetailId = $(this).attr('data-gongguOrderDetailId');

		if(! confirm('해당 리뷰를 삭제하시겠습니까 ?')){
			return false;
		}

		location.href = 'deleteReview?gongguOrderDetailId=' + gongguOrderDetailId;
	});
});
