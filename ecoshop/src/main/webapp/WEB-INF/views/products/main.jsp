<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOP</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_product/productList_view.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="header-section">
				<div class="row">
					<div class="title col-md-4">🍀Best</div>
					<div class="sub-title col-md-4 offset-md-4">지구를 위한 착한 소비, 이웃과
						함께해요</div>
				</div>
				<div class="carousel-container">
					<div class="owl-carousel owl-theme">
						<c:forEach var="dto" items="${listProduct}">
							<div class="item">
								<img src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}" alt="Image${dto.productCode}">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="category-container">
					<div class="row">
						<c:forEach var="dto" items="${listCategory}" varStatus="status">
							<div class="col category nav-tab <c:if test="${status.first}"> active</c:if>" 
								data-cat-id="${dto.categoryId}" data-url="/products/products?categoryId=${dto.categoryId}" onclick="showCategoryTab(this)">
								${dto.categoryName}
							</div>
						</c:forEach>
					</div>
				</div>
					<div class="filter-border">
						<select name="filter" id="productsSortBy" class="filter-style productsSortBy" onchange="changeSortSelect();">
							<option value="0">등록순</option>
							<option value="1">인기순</option>
							<option value="2">높은가격순</option>
							<option value="3">낮은가격순</option>
							<option value="4">상품평 많은 순</option>
						</select>
					</div>
					<div class="col col-rows-1 col-rows-md-4 g-4 list-container"></div>
				</div>
			</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsProduct/sendAjaxRequest.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsProduct/showCategoryTab.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsProduct/productLike.js"></script>
	
</body>
</html>