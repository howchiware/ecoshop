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
}

html {
  overflow-y: scroll;
}

body { 
  background-color: var(--color-bg); 
}
* { 
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif; 
  box-sizing: border-box; 
}
@font-face {
  font-family: 'Pretendard-Regular';
  src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
  font-style: normal;
}

.right-panel { 
  padding: 1.5rem 2rem; 
}
.page-title h2 {
  position: relative; 
  display: inline-block;
  padding-bottom: 10px;
}
.page-title h2::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 4px;

  background: linear-gradient(to right, var(--color-primary), transparent);
  border-radius: 2px;
}
.board-container { 
  background-color: var(--color-content-bg); 
  padding: 2rem; 
  border-radius: 12px; 
  border: 1px solid var(--color-border);
  box-shadow: 0 8px 16px rgba(132, 146, 166, 0.07);
}
.board-controls { 
  display: flex; 
  justify-content: space-between; 
  align-items: center; 
  gap: 1rem; 
  margin-bottom: 2rem; 
}

.search-form .form-control:focus {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 0.2rem rgba(74, 105, 189, 0.2);
}

.btn-primary {
  background-color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
  font-weight: 500;
}
.btn-primary:hover {
  background-color: var(--color-primary-darker) !important;
  border-color: var(--color-primary-darker) !important;
}
.btn-outline-primary {
  color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
  font-weight: 500;
}
.btn-outline-primary:hover {
  background-color: var(--color-primary) !important;
  color: white !important;
}
.btn-outline-danger {
  color: var(--color-danger) !important;
  border-color: var(--color-danger) !important;
}
.btn-outline-danger:hover {
  background-color: var(--color-danger) !important;
  color: white !important;
}

.nav-pills .nav-link { 
  color: var(--color-text-secondary); 
  font-weight: 500;
  border-radius: 6px;
  margin-bottom: 4px;
  transition: all 0.2s ease;
}
.nav-pills .nav-link:hover {
  background-color: var(--color-primary-lighter);
  color: var(--color-primary);
}
.nav-pills .nav-link.active {
  background-color: var(--color-primary) !important;
  color: white;
  font-weight: 600;
  box-shadow: 0 4px 8px rgba(74, 105, 189, 0.2);
}
.tab-content { 
  min-height: 400px; 
  padding-left: 1.5rem; 
}

.accordion-item {
  border: none;
  border-radius: 8px;
  margin-bottom: 0.75rem;
  background-color: #fff;
  border: 1px solid var(--color-border);
  overflow: hidden;
  transition: box-shadow 0.2s ease;
}
.accordion-item:hover {
  box-shadow: 0 8px 16px rgba(132, 146, 166, 0.1);
}
.accordion-button {
  font-weight: 600;
  background-color: #fff;
  color: var(--color-text-primary);
}
.accordion-button:not(.collapsed) {
  color: var(--color-primary) !important;
  background-color: var(--color-primary-lighter) !important;
  box-shadow: inset 0 -1px 0 var(--color-border);
}
.accordion-button:focus {
  box-shadow: 0 0 0 0.2rem rgba(74, 105, 189, 0.2);
}
.accordion-body {
  padding: 1.25rem;
  font-size: 0.95rem;
  color: #333;
}
.accordion-body .row {
  border: none !important;
}
.faq-content {
  white-space: pre-line;
  line-height: 1.6;
  color: var(--color-text-primary);
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px dashed var(--color-border);
}

.write-form td {
    vertical-align: middle;
}
.write-form td:first-child {
    text-align: center;
    font-weight: 600;
    width: 120px;
    background-color: #fcfcfc;
    border-right: 1px solid var(--color-border);
}
textarea.form-control {
    resize: none;
    min-height: 200px;
}
.modal-body .btn-accent {
  background-color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
  color: white;
}
.modal-body .btn-default {
  background-color: #f8f9fa;
  border-color: #dee2e6;
  color: #343a40;
}

.modal-backdrop { z-index: 9998 !important; }
.modal { z-index: 9999 !important; }
body.modal-open { overflow: hidden; padding-right: 0 !important; }
.modal-dialog {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
}

.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px; /* 버튼 사이 간격 */
  margin-top: 2rem;
}

.page-navigation a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 36px;
  height: 36px;
  padding: 0 10px;
  border-radius: 6px;
  border: 1px solid var(--color-border);
  background-color: var(--color-content-bg);
  color: var(--color-text-secondary);
  font-weight: 500;
  text-decoration: none;
  transition: all 0.2s ease;
}

.page-navigation a:hover {
  background-color: var(--color-primary-lighter);
  color: var(--color-primary);
  border-color: var(--color-primary-lighter);
}

.page-navigation strong,
.page-navigation span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 36px;
  height: 36px;
  padding: 0 10px;
  border-radius: 6px;
  border: 1px solid var(--color-primary);
  background-color: var(--color-primary);
  color: white;
  font-weight: 600;
  box-shadow: 0 4px 8px rgba(74, 105, 189, 0.2);
}

.page-navigation .disabled {
    pointer-events: none; 
    background-color: var(--color-bg);
    color: #ced4da;
}
</style>
</head>
<body>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  <div class="right-panel">

		<div class="page-title" data-aos="fade-up">
		    <h2><i class="bi bi-check-circle-fill"></i> 자주하는 질문</h2>
		    <p class="page-subtitle">정확한 정보 제공은 고객 만족의 첫걸음입니다. 내용을 신중하게 등록 및 수정해 주세요.</p>
		</div>

		<div class="board-container" data-aos="fade-up" data-aos-delay="100">
			<div class="board-controls">
				<form name="searchForm" class="search-form">
				    <div class="input-group">
				        <input type="text" name="kwd" value="" class="form-control" placeholder="검색어를 입력하세요">
				        <input type="hidden" id="searchValue" value="">
				        <button type="button" class="btn btn-primary" onclick="searchList();"><i class="bi bi-search"></i></button>
				    </div>
				</form>
				<div class="action-buttons">
					<button type="button" class="btn btn-outline-primary btn-sm btnCategoryManage">카테고리 관리</button>
					<button type="button" class="btn btn-primary btn-sm" onclick="writeForm()">
						<i class="bi bi-plus-lg"></i> 새로 등록
					</button>
				</div>
			</div>

			<div class="row mt-4">
				<div class="col-md-2">
					<div class="nav flex-column nav-pills" id="categoryTab" role="tablist" aria-orientation="vertical">
						<button class="nav-link active" id="tab-0" data-bs-toggle="pill" data-bs-target="#nav-content" 
								type="button" role="tab" data-categoryId="0">전체</button>
						<c:forEach var="dto" items="${listCategory}" varStatus="status">
							<button class="nav-link" id="tab-${status.count}" data-bs-toggle="pill" data-bs-target="#nav-content" 
									type="button" role="tab" data-categoryId="${dto.categoryId}">
								${dto.categoryName}
							</button>
						</c:forEach>
					</div>
				</div>
			
				<div class="col-md-10">
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="nav-content" role="tabpanel">
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">자주하는질문</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-2"></div>
		</div>
	</div>
</div>

<div class="modal fade" id="faqCategoryDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="faqCategoryDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="faqCategoryDialogModalLabel">FAQ 카테고리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-3">
				<form name="categoryForm" method="post" onsubmit="return false;">
					<table class="table table-bordered">
						<thead class="table-light">
							<tr class="text-center">
								<th>카테고리</th>
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
// --- SCRIPT IS UNCHANGED ---
$(function(){
	listPage(1);
	
    $('button[role="tab"]').on('click', function(e){
		searchReset();
    	listPage(1);
    });
});

function searchReset() {
	const f = document.searchForm;
	f.kwd.value = '';
	$('#searchValue').val('');
}

function listPage(page) {
	const $tab = $('button[role="tab"].active');
	
	let categoryId = $tab.attr('data-categoryId');
	let kwd = $('#searchValue').val();
	
	let url = '${pageContext.request.contextPath}/admin/faq/list';
	let params = 'pageNo=' + page + '&categoryId=' + categoryId;
	if( kwd ) {
		params += '&schType=all&kwd=' + encodeURIComponent(kwd);
	}
	
	const fn = function(data){
		let selector = '#nav-content';
		$(selector).html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
	    if(evt.key === 'Enter') {
	    	evt.preventDefault();
	    	searchList();
	    }
	});
});

function searchList() {
	const f = document.searchForm;
	let kwd = f.kwd.value.trim();
	$('#searchValue').val(kwd);
	listPage(1);
}

function reloadFaq() {
	searchReset();
	listPage(1);
}

function writeForm() {
	$('#myDialogModalLabel').text('자주하는 질문 등록');
	let url = '${pageContext.request.contextPath}/admin/faq/write';
	const fn = function(data){
		$('#myDialogModal .modal-body').html(data);
		$('#myDialogModal').modal("show");
	};
	ajaxRequest(url, 'get', null, 'text', fn);
}

function sendOk(mode, page) {
    const f = document.faqForm;

    if(! f.categoryId.value) {
        alert('카테고리를 선택하세요.');
        f.categoryId.focus();
        return;
    }
    
	let str = f.subject.value.trim();
    if(!str) {
        alert('제목을 입력하세요.');
        f.subject.focus();
        return;
    }

	str = f.content.value.trim();
    if(!str) {
        alert('내용을 입력하세요.');
        f.content.focus();
        return;
    }
    
    let url = '${pageContext.request.contextPath}/admin/faq/' + mode;
    let params = $('form[name=faqForm]').serialize();
    
    const fn = function(data) {
    	$('#myDialogModal .modal-body').empty();
    	$('#myDialogModal').modal("hide");
    	
    	if(mode === 'write') {
    		searchReset();
    		listPage(1);
    	} else {
    		listPage(page);
    	}
    };
    
    ajaxRequest(url, 'post', params, 'json', fn);
}

function sendCancel() {
	$('#myDialogModal .modal-body').empty();
	$('#myDialogModal').modal("hide");
}

function updateFaq(faqId, page) {
	$('#myDialogModalLabel').text('자주하는 질문 수정');
	let url = '${pageContext.request.contextPath}/admin/faq/update';
	let params = 'faqId=' + faqId + '&pageNo=' + page; 
    const fn = function(data) {
    	$('#myDialogModal .modal-body').html(data);
    	$('#myDialogModal').modal("show");
    };
    ajaxRequest(url, 'get', params, 'text', fn);
}

function deleteFaq(faqId, page) {
	var url = '${pageContext.request.contextPath}/admin/faq/delete';
	var params = 'faqId=' + faqId;
	if(! confirm('위 게시글을 삭제 하시 겠습니까?')) {
		return;
	}
	const fn = function(data){
		listPage(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
}

$(function(){
	$('.btnCategoryManage').click(function(){
	   	$('#faqCategoryDialogModal').modal('show');
	});
});

function listAllCategory() {
	let url = '${pageContext.request.contextPath}/admin/faq/listAllCategory';
	const fn = function(data) {
		$('.category-list').html(data)
	};
	ajaxRequest(url, 'get', null, 'text', fn);
}

$(function(){
	$('#faqCategoryDialogModal').on('click', '.btnCategoryAddOk', function(){
		const $tr = $(this).closest('tr');
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		if(! categoryName) {
			$tr.find('input[name=categoryName]').focus();
			return false;
		}
		let url = '${pageContext.request.contextPath}/admin/faq/insertCategory';
		let params = {categoryName:categoryName};
		const fn = function(data) {
			$('form[name=categoryForm]')[0].reset();
			listAllCategory();
		};
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

$(function(){
	let $cloneTr = null;
	
	$('#faqCategoryDialogModal').on('click', '.btnCategoryUpdate', function(){
		const $tr = $(this).closest('tr');
		$cloneTr = $tr.clone(true);
		$tr.find('input').prop('disabled', false);
		$tr.find('select').prop('disabled', false);
		$tr.find('input[name=categoryName]').focus();
		$tr.find('.category-modify-btn').hide();
		$tr.find('.category-modify-btnOk').show();		
	});

	$('#faqCategoryDialogModal').on('click', '.btnCategoryUpdateOk', function(){
		const $tr = $(this).closest('tr');
		let categoryId = $tr.find('input[name=categoryId]').val();
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		if(! categoryName) {
			$tr.find('input[name=categoryName]').focus();
			return false;
		}
		let url = '${pageContext.request.contextPath}/admin/faq/updateCategory';
		let params = {categoryId:categoryId, categoryName:categoryName};
		const fn = function(data){
			let state = data.state;
			if(state === 'false') {
				alert('카테고리 수정이 불가능합니다.');
				return false;
			}
			$cloneTr = null;
			listAllCategory();
		};
		ajaxRequest(url, 'post', params, 'json', fn);
	});

	$('#faqCategoryDialogModal').on('click', '.btnCategoryUpdateCancel', function(){
		const $tr = $(this).closest('tr');
		if( $cloneTr ) {
			$tr.replaceWith($cloneTr);
		}
		$cloneTr = null;
	});
});

$(function(){
	$('#faqCategoryDialogModal').on('click', '.btnCategoryDeleteOk', function(){
		if(! confirm('카테고리를 삭제하시겠습니까?')) {
			return false;
		}
		const $tr = $(this).closest('tr');
		let categoryId = $tr.find('input[name=categoryId]').val();
		let url = '${pageContext.request.contextPath}/admin/faq/deleteCategory';
		const fn = function(data) {
			listAllCategory();
		};
		ajaxRequest(url, 'post', {categoryId:categoryId}, 'json', fn);
	});
});

$(function(){
	const myModalEl = document.getElementById('faqCategoryDialogModal');
	myModalEl.addEventListener('show.bs.modal', function(){
	   	listAllCategory();
	});
	myModalEl.addEventListener('hidden.bs.modal', function(){
		location.href = '${pageContext.request.contextPath}/admin/faq/main';
	});
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

</body>
</html>