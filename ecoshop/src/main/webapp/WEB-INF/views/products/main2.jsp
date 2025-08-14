<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/" type="text/css">
<!-- Owl Carousel을 위한 CSS CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Owl Carousel의 javascript CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<style type="text/css">
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
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

.title {
	padding-top: 70px;
	padding-bottom: 50px;
	font-size: 20px;
	padding-left: 50px;
}

.sub-title {
	padding-top: 70px;
	font-size: 14px;
	color: #7E906E;
	padding-left: 160px;
}

.owl-carousel .owl-stage {
	display: flex;
	align-items: flex-end;
}

.owl-carousel .owl-item {
	display: flex;
	justify-content: center;
	transition: all 0.3s ease-in-out;
}

.owl-carousel .item {
	width: 350px;
	height: 250px;
	background-color: #eee;
	border-radius: 10px;
	overflow: hidden;
	transition: all 0.3s ease-in-out;
	margin-bottom: 30px;
}

.owl-carousel .owl-item.center .item {
	width: 450px;
	height: 300px;
	margin-bottom: 0;
}

.carousel-container {
	align-content: center;
}

.category-container {
	padding-top: 100px;
}

.category {
	color: #949393;
	text-align: center;
	padding-bottom: 10px;
}

.filter-border {
	text-align: right;
	padding-top: 20px;
	padding-bottom: 40px;
	position: relative;
  	z-index: 10;
}

.card {
	width: 220px;
	height: 220px;
	margin-top: 50px;
	position:relative;
}

.card-body {
	background: #f7f6f3;
	text-align: left;
	padding: 0;
	margin-top: 30px;
	width: 200px;
}

.card-name {
	color: #808080;
}

.card-price {
	color: #9DB492;
}

.product-card {
	margin: 0;
	
}

.list-container {
	padding-bottom: 120px;
	padding-left: 50px;
}

.filter-style {
  	border: 1px solid #c6c6c6;	
  	border-radius: 4px;
}

.heart-icon {
  color: #bbb;
  font-size: 18px;
  cursor: pointer;
}

.heart-icon:hover {
  color: #e74c3c;
}


</style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="header-section">
				<div class="row">
					<div class="title col-md-4">🍀 BEST</div>
					<div class="sub-title col-md-4 offset-md-4">지구를 위한 착한 소비, 이웃과
						함께해요</div>
				</div>
				<div class="carousel-container">
					<div class="owl-carousel owl-theme">
						<div class="item">
							<img
								src="${pageContext.request.contextPath}/dist/images/Group 303.png"
								alt="Image 1">
						</div>
						<div class="item">
							<img
								src="${pageContext.request.contextPath}/dist/images/Group 313.png"
								alt="Image 2">
						</div>
						<div class="item">
							<img
								src="${pageContext.request.contextPath}/dist/images/Group 308.png"
								alt="Image 3">
						</div>
					</div>
				</div>
				<div class="category-container">
					<div class="row">
						<div class="col category">식품</div>
						<div class="col category">욕실</div>
						<div class="col category">주방</div>
						<div class="col category">리빙</div>
						<div class="col category">기타</div>
					</div>
					<hr>
					<div class="filter-border">
						<select name="filter" class="filter-style">
							<option value="insertdate">등록순</option>
							<option value="popular">인기순</option>
							<option value="lowPrice">낮은가격순</option>
							<option value="highPrice">낮은가격순</option>
							<option value="manyReviews">상품평 많은 순</option>
						</select>
					</div>

					<div class="row row-cols-1 row-cols-md-4 g-4 list-container">
						<div class="col product-card" data-productCode="1">
							<div class="card">
								<img
									src="${pageContext.request.contextPath}/dist/images/Group 303.png"
									class="card-img-top"
									style="position: absolute; width: 100%; height: 100%;"
									alt="...">
							</div>
							<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-name">리바이브 칫솔</h5>
								<i class="bi bi-heart heart-icon"></i>
							</div>
							<p class="card-price">6000원</p>
								<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
							</div>
						</div>
						<div class="col product-card" data-productCode="2">
							<div class="card">
								<img
									src="${pageContext.request.contextPath}/dist/images/Group 308.png"
									class="card-img-top"
									style="position: absolute; width: 100%; height: 100%;"
									alt="...">
							</div>
							<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-name">리바이브 칫솔</h5>
								<i class="bi bi-heart heart-icon"></i>
							</div>
							<p class="card-price">6000원</p>
								<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
							</div>
						</div>
						<div class="col product-card" data-productCode="3">
							<div class="card">
								<img
									src="${pageContext.request.contextPath}/dist/images/Group 313.png"
									class="card-img-top"
									style="position: absolute; width: 100%; height: 100%;"
									alt="...">
							</div>
							<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-name">리바이브 칫솔</h5>
								<i class="bi bi-heart heart-icon"></i>
							</div>
							<p class="card-price">6000원</p>
								<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
							</div>
						</div>
						<div class="col product-card" data-productCode="4">
							<div class="card">
								<img
									src="${pageContext.request.contextPath}/dist/images/Group 303.png"
									class="card-img-top"
									style="position: absolute; width: 100%; height: 100%;"
									alt="...">
							</div>
							<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-name">리바이브 칫솔</h5>
								<i class="bi bi-heart heart-icon"></i>
							</div>
							<p class="card-price">6000원</p>
								<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
							</div>
						</div>
						<div class="col product-card" data-productCode="5">
							<div class="card">
								<img
									src="${pageContext.request.contextPath}/dist/images/Group 313.png"
									class="card-img-top"
									style="position: absolute; width: 100%; height: 100%;"
									alt="...">
							</div>
							<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-name">리바이브 칫솔</h5>
								<i class="bi bi-heart heart-icon"></i>
							</div>
							<p class="card-price">6000원</p>
								<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<header>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</header>
	<script>
		$('.owl-carousel').owlCarousel({
			loop : true,
			margin : 10,
			nav : true,
			center : true,
			responsive : {
				0 : {
					items : 1
				},
				1000 : {
					items : 3
				}
			}
		})
	</script>
</body>
</html>
