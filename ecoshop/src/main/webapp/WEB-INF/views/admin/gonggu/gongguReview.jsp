<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>문의</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/productReview.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>
	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
			<div class="title">
				<h4>리뷰 및 Q&A 관리</h4>
			</div>
			<hr>
			<div class="outside review-manage">
				<div class="review-manage-nav">
					<button class="nav-tab active" data-url="/admin/gonggu/reviewList" onclick="showReviewTab(this)">상품리뷰</button>
					<button class="nav-tab" data-url="/admin/gonggu/inquiryList" onclick="showReviewTab(this)">상품문의</button>
				</div>
			
			<div class="row select-two">
				<div class="row d-flex justify-content-center">
				    <div class="searchSelect col-2">
				        <select id="searchType" class="form-control search-select">
				            <option value="gongguProductName">상품명</option>
				            <option value="kwd">내용 + 작성자</option>
				        </select>
				    </div>
				    <div class="searchContainer col-6">
				        <div class="col input-group mb-3">
				            <input type="text" id="searchValue" class="form-control search-input" placeholder="검색어 입력" aria-label="search">
				            <button class="btn btn-outline-secondary" type="button" id="searchBtn">🔍</button>
				            <button class="btn btn-outline-secondary" type="button" id="resetBtn"><i class="bi bi-arrow-counterclockwise"></i></button>
				        </div>	
				    </div>
				</div>
			</div>
			<div id="content-area"></div>
			</div>
		</div>
	</main>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/sendAjaxRequest.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/showReviewTab.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguAdminReview.js"></script>
</body>
</html>