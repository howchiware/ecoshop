<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GONGGU</title>
<link rel="icon" href="data:;base64,iVB1w0KGgo=">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/productList_view.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="header-section">
				<div class="row">
					<div class="title col-md-4">🍀마감임박</div>
					<div class="sub-title col-md-4 offset-md-4">지구를 위한 착한 소비, 이웃과
						함께해요</div>
				</div>
				<div class="carousel-container">
					<div class="owl-carousel owl-theme">
						<c:forEach var="dto" items="${listFiveProduct}">
							<div class="item bestItems" onClick="location.href='${pageContext.request.contextPath}/gonggu/${dto.gongguProductId}'">
								<img src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}" alt="Image${dto.gongguProductId}">
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="category-container">
				<div class="row">
					<c:forEach var="dto" items="${listCategory}" varStatus="status">
						<div class="col category nav-tab<c:if test="${status.first}"> active</c:if>" 
							data-cat-id="${dto.categoryId}" data-url="${pageContext.request.contextPath}/gonggu/list?categoryId=${dto.categoryId}" onclick="showCategoryTab(this)">
							${dto.categoryName}
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="filter-border">
				<select name="filter" class="filter-style">
					<option value="0">등록순</option>
					<option value="1">인기순</option>
					<option value="2">높은가격순</option>
					<option value="3">낮은가격순</option>
					<option value="4">상품평 많은 순</option>
				</select>
			</div>
			<div class="row row-cols-1 row-cols-md-4 g-4 list-container"></div>
		</div>
		<div id="gongguProduct-template">
			<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
			<input type="hidden" id="web-memberId" value="${sessionScope.member.memberId}">
			<input type="hidden" id="memberLogin" value="${sessionScope.member}">
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/sendAjaxRequest.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/showCategoryTab.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductLike.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
	<script>
	$(document).ready(function() {
	    var owl = $('.owl-carousel');
	    owl.owlCarousel({
	        loop: true,
	        margin: 10,
	        nav: true,
	        center: true,
	        autoplay: true,
	        autoplayTimeout: 4000,
	        autoplayHoverPause: true,
	        responsive: {
	            0: {
	                items: 1
	            },
	            1000: {
	                items: 3
	            }
	        }
	    });


		function showCategoryTab(clickButton) {
			const url = clickButton.getAttribute('data-url');
			document.querySelectorAll('.category-container .nav-tab').forEach(div => {
				div.classList.remove('active');
			});
			clickButton.classList.add('active');

			sendAjaxRequest(url, 'GET', null, 'html', function(data) {
				const listContainer = document.querySelector('.list-container');
				if (listContainer) {
					listContainer.innerHTML = data;
				}
			}, {'X-Requested-With': 'XMLHttpRequest'});
		}
	</script>
</body>
</html>