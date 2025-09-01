<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hShop</title>
<!-- Vendor CSS Files -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/board.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin_paginate.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
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
	overflow-y: auto;
}

.outside {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.search-area tr {
	font-size: 13px;
}

.search-area td.select-area {
	text-align: left;
}

p.small-title {
	font-weight: 500;
}

.search-list {
	border: 1px solid black;
}

.search-list td {
	padding: 10px;
}

.search-list tbody, td, tfoot, th, thead, tr {
	border-color: black;
	border-style: solid;
	border-width: 0;
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

.dateBtn {
	background: #fff;
	border: 1px solid black;
	color: black;
	padding: 3px;
}

.form-search .btn-default {
  border-radius: 3px !important;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 2px 4px;
  border: 1px solid #d9d9d9;
}
.form-search .btn-default:hover,
.form-search .btn-default:focus {
  color: #c9c9c9;
}

</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>

	<main class="main-container" style="z-index: 100">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="right-PANEL">
			<div class="page-title title" data-aos="fade-up" data-aos-delay="200">
				<h2>${title}</h2>
			</div>

			<hr>

			<div class="outside">
				<div class="section ps-5 pe-5" data-aos="fade-up"
					data-aos-delay="200" style="padding-top: 0px">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2" data-aos="fade-up"
								data-aos-delay="200">

								<div class="row mb-2">
									<div class="col-md-6 align-self-center">
										<span class="small-title">목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page}
											페이지)</span>
									</div>
									<div class="col-md-6 align-self-center text-end"></div>
								</div>

								<table class="table table-hover board-list">
									<thead class="table-light">
										<tr>
											<th width="170">주문번호</th>
											<th width="100">주문자</th>
											<th>상품명</th>
											<th width="100">주문총금액</th>
											<th width="110">주문상태</th>
											<th width="100">주문일자</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="dto" items="${list}" varStatus="status">
											<tr class="hover-cursor"
												onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/detailManage/${itemId}/${dto.gongguOrderDetailId}?${query}';">
												<td>${dto.orderId}</td>
												<td>${dto.name}</td>
												<td class="left"><div class="text-wrap">${dto.gongguProductName}</div></td>
												<td><fmt:formatNumber value="${dto.productMoney}" /></td>
												<td>${dto.detailStateInfo}</td>
												<td>${fn:substring(dto.orderDate, 0, 10)}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<div class="page-navigation">${dataCount == 0 ? "등록된 주문정보가 없습니다." : paging}
								</div>

								<div class="row mt-3">
									<div class="col-md-12 text-center">
										<form name="searchForm"
											class="form-search d-inline-flex align-items-center justify-content-center gap-1">

											<select name="schType"
												class="form-select form-select-sm w-auto">
												<option value="orderId" ${schType=="orderId"?"selected":""}>주문번호</option>
												<option value="name" ${schType=="name"?"selected":""}>주문자</option>
												<option value="orderDate"
													${schType=="orderDate"?"selected":""}>주문일자</option>
												<option value="productName"
													${schType=="gongguProductName"?"selected":""}>상품이름</option>
											</select> <input type="text" name="kwd" value="${kwd}"
												class="form-control form-control-sm w-auto">

											<button type="button" class="btn-default"
												onclick="searchList();" aria-label="검색">
												<i class="bi bi-search"></i>
											</button>

											<button type="button" class="btn-default"
												onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/detailManage/${itemId}';"
												title="새로고침" aria-label="새로고침">
												<i class="bi bi-arrow-clockwise"></i>
											</button>
										</form>
									</div>
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
	f.kwd.value = f.kwd.value.trim();
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/gongguOrder/detailManage/${itemId}';
	location.href = url + '?' + params;
}
</script>

	<footer>
		<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp" />
	</footer>

	<!-- Vendor JS Files -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

	<script type="text/javascript">
AOS.init();
</script>
</body>
</html>