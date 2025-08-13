<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GONGGU</title>
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
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-style: normal;
}

.title {
	padding-top : 70px;
	padding-bottom: 50px;
	font-size: 20px;
	padding-left : 50px;
}

.sub-title {
	padding-top : 70px;
	font-size: 14px;
	color: #7E906E;
	padding-left : 160px;
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

.list-container {
	padding-top: 100px;
}

.col {
	color: #949393;
	text-align: center;
	padding-bottom: 10px;
}

.filter-border {
	text-align: right;
	padding-top: 6px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	
	<main>
		<div class="container">
			<div class="header-section">
				<div class="row">
					<div class="title col-md-4">🍀마감임박</div> 
					<div class="sub-title col-md-4 offset-md-4">지구를 위한 착한 소비, 이웃과 함께해요</div>
				</div>
		<div class="carousel-container">
	        <div class="owl-carousel owl-theme">
	            <div class="item"><img src="${pageContext.request.contextPath}/dist/images/Group 303.png" alt="Image 1"></div>
	            <div class="item"><img src="${pageContext.request.contextPath}/dist/images/Group 308.png" alt="Image 2"></div>
	            <div class="item"><img src="${pageContext.request.contextPath}/dist/images/Group 313.png" alt="Image 3"></div>
	        </div>
	    </div>        
        <div class="list-container">
        	<div class="row category">
        		<div class="col">
        			식품
        		</div>
        		<div class="col">
        			욕실
        		</div>
        		<div class="col">
        			주방
        		</div>
        		<div class="col">
        			리빙
        		</div>
        		<div class="col">
        			기타
        		</div>
        	</div>
        	<hr>
        	<div class="filter-border">
        		<select name="filter">
        			<option value="popular">인기순</option>
        			<option value="deadline">마감임박순</option>
        		</select>
        	</div>
        	
       </div>
        
        
        
        
        
        
        
          
			</div>
		</div>
	</main>
<script>
$('.owl-carousel').owlCarousel({
   loop:true,
   margin:10,
   nav:true,
   center: true,
   responsive:{
   0:{items:1},
   1000:{items:3}
   }
})
</script>    	
</body>
</html>
