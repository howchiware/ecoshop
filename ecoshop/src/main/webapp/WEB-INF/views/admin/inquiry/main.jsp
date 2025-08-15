<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<style>
:root {
  --color-primary: #4a69bd;
  --color-primary-darker: #3b5496;
  --color-primary-lighter: #eef2f9;
  --color-bg: #f8f9fa;
  --color-content-bg: #ffffff;
  --color-text-primary: #2c3e50;
  --color-text-secondary: #8492a6;
  --color-border: #e0e6ed;
  --color-danger: #e74c3c;
  --color-warning: #f39c12;
}
html { overflow-y: scroll; }
body { background-color: var(--color-bg); }
* { font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif; box-sizing: border-box; }
@font-face {
  font-family: 'Pretendard-Regular';
  src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
  font-style: normal;
}
.right-panel { padding: 1.5rem 2rem; }
.page-title h2 { display: flex; align-items: center; gap: 10px; font-size: 1.8rem; font-weight: 700; color: var(--color-text-primary); margin-bottom: 0.5rem; }
.page-title h2 .bi { color: var(--color-primary); }
.page-subtitle { color: var(--color-text-secondary); padding-left: 42px; }
.board-container { background-color: var(--color-content-bg); padding: 2rem; border-radius: 12px; border: 1px solid var(--color-border); box-shadow: 0 8px 16px rgba(132, 146, 166, 0.07); }
.board-controls { display: flex; justify-content: space-between; align-items: center; gap: 1rem; margin-bottom: 2rem; }
.btn-primary { background-color: var(--color-primary) !important; border-color: var(--color-primary) !important; }
.btn-primary:hover { background-color: var(--color-primary-darker) !important; border-color: var(--color-primary-darker) !important; }

/* 왼쪽 카테고리 탭 */
.nav-pills .nav-link { color: var(--color-text-secondary); font-weight: 500; border-radius: 6px; margin-bottom: 4px; transition: all 0.2s ease; }
.nav-pills .nav-link:hover { background-color: var(--color-primary-lighter); color: var(--color-primary); }
.nav-pills .nav-link.active { background-color: var(--color-primary) !important; color: white; font-weight: 600; box-shadow: 0 4px 8px rgba(74, 105, 189, 0.2); }

/* 상단 목록 필터 탭 */
.list-filter-tabs { border-bottom: 2px solid var(--color-border); margin-bottom: 1.5rem; }
.list-filter-tabs .nav-link { border: none; border-bottom: 2px solid transparent; color: var(--color-text-secondary); font-weight: 600; padding: 0.8rem 0.2rem; margin-right: 1.5rem; margin-bottom: -2px; cursor: pointer; }
.list-filter-tabs .nav-link.active { color: var(--color-primary); border-bottom-color: var(--color-primary); background-color: transparent; }

.table-responsive { min-height: 450px; }
.table { border-top: 2px solid var(--color-text-primary); }
.table th { background-color: #fcfcfd; font-weight: 600; color: var(--color-text-secondary); text-align: center; vertical-align: middle; }
.table td { text-align: center; vertical-align: middle; }
.table .subject-cell { text-align: left; }
.status-badge { display: inline-block; padding: 0.4em 0.7em; font-size: .8em; font-weight: 600; line-height: 1; text-align: center; border-radius: 0.375rem; }
.status-badge.answered { color: #fff; background-color: var(--color-primary); }
.status-badge.pending { color: var(--color-warning); background-color: #fffbe6; border: 1px solid var(--color-warning); }
.page-navigation { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 2rem; }
.page-navigation a, .page-navigation strong, .page-navigation span { display: inline-flex; align-items: center; justify-content: center; min-width: 36px; height: 36px; padding: 0 10px; border-radius: 6px; border: 1px solid var(--color-border); text-decoration: none; }
.page-navigation a { background-color: var(--color-content-bg); color: var(--color-text-secondary); font-weight: 500; transition: all 0.2s ease; }
.page-navigation a:hover { background-color: var(--color-primary-lighter); color: var(--color-primary); border-color: var(--color-primary-lighter); }
.page-navigation strong, .page-navigation span.current { background-color: var(--color-primary); border-color: var(--color-primary); color: white; font-weight: 600; }
.page-navigation .disabled { pointer-events: none; background-color: var(--color-bg); color: #ced4da; }
.modal-backdrop { z-index: 9998 !important; }
.modal { z-index: 9999 !important; }
body.modal-open { overflow: hidden; padding-right: 0 !important; }
.modal-dialog {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
}
</style>
</head>
<body>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  <div class="right-panel">
		<div class="page-title" data-aos="fade-up">
		    <h2><i class="bi bi-chat-left-text-fill"></i> 1:1 문의 답변 관리</h2>
		    <p class="page-subtitle">고객의 질문에 신속하고 친절하게 답변하여 긍정적인 경험을 제공해 주세요.</p>
		</div>

		<div class="board-container" data-aos="fade-up" data-aos-delay="100">
            <div class="board-controls">
                <form name="searchForm" class="search-form" style="max-width: 400px; width: 100%;">
                    <div class="input-group">
                        <input type="text" name="kwd" class="form-control" placeholder="제목, 작성자 검색">
                        <button type="button" class="btn btn-primary" onclick="searchList();"><i class="bi bi-search"></i></button>
                    </div>
                </form>
                <button type="button" class="btn btn-outline-secondary btn-sm btnCategoryManage">카테고리 관리</button>
            </div>
            
            <div class="row">
                <div class="col-md-2">
                    <div class="nav flex-column nav-pills" id="categoryTab">
						<button class="nav-link active" type="button" data-categoryId="0">전체</button>
						<c:forEach var="dto" items="${listCategory}">
							<button class="nav-link" type="button" data-categoryId="${dto.categoryId}">${dto.categoryName}</button>
						</c:forEach>
					</div>
                </div>

                <div class="col-md-10">
                    <ul class="nav list-filter-tabs" id="statusTab">
                        <li class="nav-item"><a class="nav-link active" data-status="-1">전체</a></li>
                        <li class="nav-item"><a class="nav-link" data-status="0">답변 대기</a></li>
                        <li class="nav-item"><a class="nav-link" data-status="1">답변 완료</a></li>
                    </ul>

                    <div class="table-responsive" id="nav-content">
                    </div>
                </div>
            </div>
		</div>
	</div>
</main>

<%-- 모달 영역 --%>
<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">1:1 문의 확인 및 답변</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4"></div>
		</div>
	</div>
</div>
<div class="modal fade" id="inquiryCategoryDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">1:1 문의 카테고리 관리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body pt-3">
				<form name="categoryForm" onsubmit="return false;">
					<table class="table table-bordered">
						<thead class="table-light">
							<tr class="text-center">
								<th>카테고리명</th>
								<th style="width: 90px;">작업</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td><input type="text" name="categoryName" class="form-control form-control-sm"></td>
								<td><button type="button" class="btn btn-sm btn-primary btnCategoryAddOk">등록</button></td>
							</tr>
						</tbody>
						<tfoot class="category-list"></tfoot>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
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
		location.href = '${pageContext.request.contextPath}/admin/inquiry/main';
	});
	
	$('#inquiryCategoryDialogModal').on('click', '.btnCategoryAddOk', function(){
		const $tr = $(this).closest('tr');
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		if(!categoryName) { $tr.find('input[name=categoryName]').focus(); return false; }
		let url = '${pageContext.request.contextPath}/admin/inquiry/insertCategory';
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
		let url = '${pageContext.request.contextPath}/admin/inquiry/updateCategory';
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
		let url = '${pageContext.request.contextPath}/admin/inquiry/deleteCategory';
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

	let url = '${pageContext.request.contextPath}/admin/inquiry/list';
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
	let url = '${pageContext.request.contextPath}/admin/inquiry/update';
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

	let url = '${pageContext.request.contextPath}/admin/inquiry/update';
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
	let url = '${pageContext.request.contextPath}/admin/inquiry/listAllCategory';
	ajaxRequest(url, 'get', null, 'text', function(data) {
		$('.category-list').html(data);
	});
}
</script>

</body>
</html>