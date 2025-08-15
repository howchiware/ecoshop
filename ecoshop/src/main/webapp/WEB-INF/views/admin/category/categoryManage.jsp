<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hShop</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">

body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

.main-container {
	display: flex;
}

.right-PANEL {
	flex-grow: 1;
	padding: 2rem;
	overflow: hidden;
}

.outside {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	display: flex;
	justify-content: center;
	overflow: auto;
}

.small-title {
font-weight: 500;
width: 300px;
}

td.select-title-area {
border-right: 1px solid black;
}

select, input {
	padding: 3px;
	margin: -2px;
}

button {
	background: #fff;
	border: 1px solid black;
	color: black;
	padding: 3px;
}

.btn-area {
margin-top: 30px;
text-align: center;
}

.btn-accent {
	background: silver;
	border: none;
	color: black; 
}

.input-table, .input-table2 {
	margin: 30px 0px 10px 0px;
}

.input-table td, .input-table2 td {
	padding: 5px;
	border: 1px solid #DEE2E6;
}

.input-table2 th {
	font-weight: 400;
}

.input-table2 td:last-child {
	padding-top: 13px;
}

.input-table td:first-child {
	width: 150px;
	text-align: center;
	background: #F8F9FA;
}

.category-input {
	margin: 4px 7px;
}

.addCategory {
    position: relative;
    right: 17px;
}

.addCategoryBtn {
	padding: 3px 13px;
}

.hr-vertical {
	width: 0.5px;
	background: #E9ECEF;
}

.left {
	padding-right: 10px;
}

.right {
	padding-left: 10px;
}

.input-area {
	text-align: right;
}

.category-modify-btn, .category-modify-btnOk {
	font-size: 20px;
}


</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>

	<div class="right-PANEL">
		<div class="title">
			<h3>카테고리 관리</h3>
		</div>
		
		<hr>
		
		<div class="outside">
			<form method="post" name="categoryManageForm" enctype="multipart/form-data">
				<div class="section ps-5 pe-5 left">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2">
								<div class="small-title">
									<h5>카테고리 등록</h5>
								</div>
								
								<div class="input-area">
									<table class="input-table">
										<tr>
											<td>카테고리명</td>
											<td>
												<input type="text" class="category-input" name="categoryName">
											</td>
										</tr>
										<tr>
											<td>순서</td>
											<td>
												<input type="text" class="category-input" name="orderNo">
											</td>
										</tr>
									</table>
									<div class="addCategory">
										<button type="button" class="addCategoryBtn">등록</button>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</form>

				
				<div class="hr-vertical"></div>
				
				<div class="section ps-5 pe-5 right">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2">
								<div class="small-title">
									<h5>카테고리 수정 / 삭제</h5>
								</div>
								
								<div class="input-area">
									<table class="table table-bordered input-table2" style="width: 550px;">
										<thead class="table-light">
											<tr align="center">
												<th width="170">카테고리</th>
												<th width="120">활성화 여부</th>
												<th width="80">출력순서</th>
												<th width="100">변경</th>
											</tr>
										</thead>
										<tbody class="category-list">						
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>				
			</div>
		</div>
</main>

<script type="text/javascript">
window.addEventListener('DOMContentLoaded', () => {
	listAllCategory();
});

//카테고리 리스트
function listAllCategory() {
	let url = '${pageContext.request.contextPath}/admin/category/listAllCategory';
	
	const fn = function(data) {
		$('.category-list').html(data);
	};
	
	ajaxRequest(url, 'get', null, 'text', fn);
}

// 카테고리 등록
$(function(){
	$('.addCategoryBtn').on('click', function(){
		const $div = $(this).closest('div').parent();
		
		let categoryName = $div.find('input[name=categoryName]').val().trim();
		let orderNo = $div.find('input[name=orderNo]').val().trim();
		
		if(! categoryName){
			$div.find('input[name=categoryName]').focus();
			return false;
		}
		
		if(! /^\d+$/.test(orderNo)) {
			$div.find('input[name=orderNo]').focus();
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/admin/category/insertCategory';
		let params = {categoryName:categoryName, orderNo:orderNo};
		
		const fn = function(data){
			$('form[name=categoryManageForm]')[0].reset();
			
			listAllCategory();
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

//카테고리 수정
$(function(){
	let $cloneTr = null;
	
	$('.input-area').on('click', '.btnCategoryUpdate', function(){
		const $tr = $(this).closest('tr');
		
		$cloneTr = $tr.clone(true); // clone
		
		$tr.find('input').prop('disabled', false);
		$tr.find('select').prop('disabled', false);
		$tr.find('input[name=categoryName]').focus();
		
		$tr.find('.category-modify-btn').hide();
		$tr.find('.category-modify-btnOk').show();		
	});

	// 카테고리 수정 완료
	$('.input-area').on('click', '.btnCategoryUpdateOk', function(){
		const $tr = $(this).closest('tr');
		
		let categoryId = $tr.find('input[name=categoryId]').val();
		let categoryName = $tr.find('input[name=categoryName]').val().trim();
		let enabled = $tr.find('select[name=enabled]').val();
		let orderNo = $tr.find('input[name=orderNo]').val();
		
		if(! categoryName) {
			$tr.find('input[name=categoryName]').focus();
			return false;
		}
		
		if(! /^[0-9]+$/.test(orderNo)) {
			$tr.find('input[name=orderNo]').focus();
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/admin/category/updateCategory';
		let params = {categoryId:categoryId, categoryName:categoryName, enabled:enabled, orderNo:orderNo};
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

	// 카테고리 수정 취소
	$('.input-area').on('click', '.btnCategoryUpdateCancel', function(){
		const $tr = $(this).closest('tr');

		if( $cloneTr ) {
			$tr.replaceWith($cloneTr);
		}
		
		$cloneTr = null;
	});
});

// 카테고리 삭제
$(function(){
	$('.input-area').on('click', '.btnCategoryDeleteOk', function(){
		if(! confirm('카테고리를 삭제하시겠습니까 ? ')) {
			return false;
		}
		
		const $tr = $(this).closest('tr');
		let categoryId = $tr.find('input[name=categoryId]').val();
		
		let url = '${pageContext.request.contextPath}/admin/category/deleteCategory';
		const fn = function(data) {
			listAllCategory();
		};
		
		ajaxRequest(url, 'post', {categoryId:categoryId}, 'json', fn);
	});
});

</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<!-- Vendor JS Files -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

</body>
</html>