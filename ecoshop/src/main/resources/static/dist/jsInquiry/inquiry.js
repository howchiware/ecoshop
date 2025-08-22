$(function(){
	$('#categoryTab').on('click', '.nav-link', function() {
		if ($(this).hasClass('active')) return;
		$('#categoryTab .nav-link').removeClass('active');
		$(this).addClass('active');
		searchReset();
		listPage(1);
	});

	$('#statusTab').on('click', '.nav-link', function() {
		if ($(this).hasClass('active')) return;
		$('#statusTab .nav-link').removeClass('active');
		$(this).addClass('active');
		searchReset();
		listPage(1);
	});
	
	const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
			searchList();
		}
	});

	$('.btnCategoryManage').click(function(){
		const modal = new bootstrap.Modal(document.getElementById('inquiryCategoryDialogModal'));
		modal.show();
	});

	const categoryModal = document.getElementById('inquiryCategoryDialogModal');
	categoryModal.addEventListener('show.bs.modal', listAllCategory);
	categoryModal.addEventListener('hidden.bs.modal', function(){
		location.href = CONTEXT_PATH + '/admin/inquiry/main';
	});
	
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryAddOk', function(){
		const $tr = $(this).closest('tr');
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		if(!categoryName) { $tr.find('input[name=categoryName]').focus(); return false; }
		let url = CONTEXT_PATH + '/admin/inquiry/insertCategory';
		ajaxRequest(url, 'post', {categoryName:categoryName}, 'json', function(data) {
			$('form[name=categoryForm]')[0].reset();
			listAllCategory();
		});
	});

	let $cloneTr = null;
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryUpdate', function(){
		const $tr = $(this).closest('tr');
		$cloneTr = $tr.clone(true);
		$tr.find('input').prop('disabled', false);
		$tr.find('input[name=categoryName]').focus();
		$tr.find('.category-modify-btn').hide();
		$tr.find('.category-modify-btnOk').show();		
	});
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryUpdateOk', function(){
		const $tr = $(this).closest('tr');
		let categoryId = $tr.find('input[name=categoryId]').val();
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		if(!categoryName) { $tr.find('input[name=categoryName]').focus(); return false; }
		let url = CONTEXT_PATH + '/admin/inquiry/updateCategory';
		let params = {categoryId:categoryId, categoryName:categoryName};
		ajaxRequest(url, 'post', params, 'json', function(data){
			if(data.state === 'false') { alert('카테고리 수정이 불가능합니다.'); return false; }
			$cloneTr = null;
			listAllCategory();
		});
	});
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryUpdateCancel', function(){
		const $tr = $(this).closest('tr');
		if( $cloneTr ) { $tr.replaceWith($cloneTr); }
		$cloneTr = null;
	});
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryDeleteOk', function(){
		if(!confirm('카테고리를 삭제하시겠습니까?')) { return false; }
		const $tr = $(this).closest('tr');
		let categoryId = $tr.find('input[name=categoryId]').val();
		let url = CONTEXT_PATH + '/admin/inquiry/deleteCategory';
		ajaxRequest(url, 'post', {categoryId:categoryId}, 'json', listAllCategory);
	});

	listPage(1);
});

function searchReset() {
	document.searchForm.kwd.value = '';
}

function listPage(page) {
	const categoryId = $('#categoryTab .nav-link.active').attr('data-categoryId');
	const status = $('#statusTab .nav-link.active').attr('data-status');
	const kwd = document.searchForm.kwd.value.trim();

	let url = CONTEXT_PATH + '/admin/inquiry/list';
	let params = 'pageNo=' + page + '&categoryId=' + categoryId;
	
	if(status !== 'all') {
		params += '&status=' + status;
	}
	if(kwd) {
		params += '&schType=all&kwd=' + encodeURIComponent(kwd);
	}

	const fn = function(data){
		$('#nav-content').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function searchList() {
	listPage(1);
}

function viewInquiry(inquiryId, page) {
	let url = CONTEXT_PATH + '/admin/inquiry/update';
	let params = 'inquiryId=' + inquiryId + '&pageNo=' + page; 
	ajaxRequest(url, 'get', params, 'text', function(data) {
		$('#myDialogModal .modal-body').html(data);
		const modal = new bootstrap.Modal(document.getElementById('myDialogModal'));
		modal.show();
	});
}

function sendAnswer(form) {
	const f = form;
	const answer = f.questionAnswer.value.trim();
	if(!answer) {
		alert('답변 내용을 입력하세요.');
		f.questionAnswer.focus();
		return false;
	}
	
	if(!confirm("답변을 등록하시겠습니까?\n등록 후에는 수정할 수 없습니다.")) {
		return false;
	}

	let url = CONTEXT_PATH + '/admin/inquiry/update';
	let params = $(f).serialize();
	
	const fn = function(data) {
		const modal = bootstrap.Modal.getInstance(document.getElementById('myDialogModal'));
		if(modal) modal.hide();
		listPage(f.pageNo.value);
	};
	
	ajaxRequest(url, 'post', params, 'json', fn);
	return false;
}

function listAllCategory() {
	let url = CONTEXT_PATH + '/admin/inquiry/listAllCategory';
	ajaxRequest(url, 'get', null, 'text', function(data) {
		$('.category-list').html(data);
	});
}
