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
						<div class="item">
							<img src="${pageContext.request.contextPath}/dist/images/Group 303.png" alt="Image 1">
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/dist/images/Group 313.png" alt="Image 2">
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/dist/images/Group 308.png" alt="Image 3">
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
							<option value="0">최신순</option>
							<option value="1">인기순</option>
							<option value="2">리뷰순</option>
							<option value="3">마감임박순</option>
						</select>
					</div>
					<div class="row row-cols-1 row-cols-md-4 g-4 list-container">
						<c:choose>
						    <c:when test="${not empty listGongguProduct}">
						        <c:forEach var="dto" items="${listGongguProduct}">
								    <div class="col">
								        <div class="card h-100">
								            <a href="${pageContext.request.contextPath}/gonggu/${dto.gongguProductId}">
								                <img src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}" class="card-img-top" alt="${dto.gongguProductName}">
								            </a>
								            <div class="card-body">
								                <h5 class="card-title">${dto.gongguProductName}</h5>
								                <p class="card-text">
								                    <span class="original-price"><fmt:formatNumber value="${dto.originalPrice}"/>원</span>
								                    <span class="sale-price"><fmt:formatNumber value="${dto.gongguPrice}"/>원</span>
								                    <span class="sale-percentage">(${dto.sale}%)</span>
								                </p>
								                <p class="card-text">남은 기간: ${dto.endDate}까지</p>
								                <p class="card-text">참여자: ${dto.participantCount}명 / <span class="limit-count">${dto.limitCount}</span>명</p>
								                <div class="wish-info">
								                    <c:if test="${dto.userWish == 1}">
								                        <i class="bi bi-heart-fill liked"></i>
								                    </c:if>
								                    <c:if test="${dto.userWish == 0}">
								                        <i class="bi bi-heart"></i>
								                    </c:if>
								                </div>
								            </div>
								        </div>
								    </div>
								</c:forEach>
						    </c:when>
						    <c:otherwise>
						        <div class="col-12 text-center">
						            <p>해당 카테고리의 상품이 없습니다.</p>
						        </div>
						    </c:otherwise>
						</c:choose>
						<div class="paging-container mt-4">
                            ${paging}
                        </div>
					</div>
				</div>
			</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/sendAjaxRequest.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsGonggu/showCategoryTab.js"></script>

    <script>
        $(document).ready(function() {
            $('.owl-carousel').owlCarousel({
                loop : true,
                margin : 10,
                nav : true,
                center : true,
                autoplay:true,
                autoplayTimeout:4000,
                autoplayHoverPause:true,
                responsive : {
                    0 : {
                        items : 1
                    },
                    1000 : {
                        items : 3
                    }
                }
            });

            $('.filter-style').on('change', function() {
                const selectedSortBy = $(this).val();
                const currentCategoryId = $('.category-container .nav-tab.active').data('cat-id');
                const contextPath = '${pageContext.request.contextPath}';
                const url = contextPath + '/gonggu/list?categoryId=' + currentCategoryId + '&sortBy=' + selectedSortBy;
                
                sendAjaxRequest(url, 'GET', null, 'html', function(data) {
                    const listContainer = document.querySelector('.list-container');
                    if (listContainer) {
                        listContainer.innerHTML = data;
                    }
                }, {'X-Requested-With': 'XMLHttpRequest'});
            });
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
