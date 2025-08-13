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

.category-modify-btn {
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
		
		<form name="categoryManageForm">
			<div class="outside">
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
												<input class="category-input" name="categoryName">
											</td>
										</tr>
										<tr>
											<td>순서</td>
											<td>
												<input class="category-input" name="categoryOrder">
											</td>
										</tr>
									</table>
									<div class="addCategory">
										<button class="addCategoryBtn">등록</button>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
				
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
											
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리1"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="1"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="1">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리2"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="2"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="2">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리3"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="3"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="3">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리3"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="3"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="3">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리3"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="3"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="3">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
												<tr>
													<td> <input type="text" name="category" class="form-control" disabled value="카테고리3"> </td>
													<td>
														<select name="enabled" class="form-select" disabled>
															<option value="1" selected>활성</option>
															<option value="0">비활성</option>
														</select>
													</td>
													<td> <input type="text" name="orderNo" class="form-control" disabled value="3"> </td>
													<td align="center">
														<input type="hidden" name="categoryNum" value="3">
														<div class="category-modify-btn">
															<span class="span-icon btnCategoryUpdate" title="수정"><i class="bi bi-pencil-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryDeleteOk" title="삭제"><i class="bi bi-trash"></i></span>
														</div>
														<div class="category-modify-btnOk" style="display:none">
															<span class="span-icon btnCategoryUpdateOk" title="수정완료"><i class="bi bi-check2-square"></i></span>&nbsp;&nbsp;
															<span class="span-icon btnCategoryUpdateCancel" title="수정취소"><i class="bi bi-arrow-clockwise"></i></span>
														</div>
													</td>
												</tr>
																				
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>				
			</div>
		</form>
	</div>
</main>

<script type="text/javascript">

</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>