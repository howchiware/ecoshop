window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = CONTEXT_PATH + '/admin/inquiryManage/list';
	location.href = url + '?' + params;
}

function deleteOk(element, mode) {
	let s = mode === 'question' ? '질문' : '답변';
	
	if(confirm(s + '을 삭제 하시 겠습니까?')) {
		let params = 'num=${dto.num}&${query}&mode=' + mode;
		let url = CONTEXT_PATH + '/admin/inquiryManage/delete?' + params;
		location.href = url;
	}
}

function answerOk() {
	const modal = new bootstrap.Modal('#myDialogModal');
	modal.show();
}
  
window.addEventListener('DOMContentLoaded', ev => {
    const myModalEl = document.getElementById('myDialogModal');
	myModalEl.addEventListener('shown.bs.modal', function () {
		const f = document.answerForm;
		f.answer.focus();
	});
    
	const btnSendEL = document.querySelector('.btnAnswerSend');
	const btnCancelEL = document.querySelector('.btnAnswerCancel');

	btnSendEL.addEventListener('click', e => {
		const f = document.answerForm;
		if(! f.answer.value.trim()) {
			f.answer.focus();
			return false;
		}
		
		f.action = CONTEXT_PATH + '/admin/inquiryManage/answer';
		f.submit();
	});

	btnCancelEL.addEventListener('click', function(e) {
		const f = document.answerForm;
		f.answer.value = `${dto.answer}`;
		
	    const modal = bootstrap.Modal.getInstance(myModalEl);
	    modal.hide();
	});
});