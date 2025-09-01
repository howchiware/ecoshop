<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/home.css"
	type="text/css">
<style>
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<!-- Hero Section -->
	<section class="hero">
		<div class="hero-overlay"></div>
		<div class="hero-content">
			<h1>당신의 선택이 변화를 만듭니다.</h1>
			<p>지속 가능한 삶, 지금 이곳에서 시작하세요.</p>
		</div>
	</section>

	<!-- 베스트 상품 Section -->
	<section class="section">
		<div class="container">
			<h2 class="section-title text-start mb-4">많이 찾는 제품</h2>
			<div class="row g-4">
				<c:forEach var="dto" items="${bestProductList}">
					<div class="col-md-4">
						<div class="card card-hover border-0 shadow-sm"
							onClick="location.href='${pageContext.request.contextPath}/products/${dto.productCode}'">
							<img alt="Image${dto.productCode}" class="card-img-top"
								src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}" />
							<div class="card-body">
								<h5 class="card-title">${dto.productName}</h5>
								<p class="card-text">${dto.content}</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- 공동구매 Section -->
	<section class="section gonggu-section">
    <div class="container">
        <div class="d-flex gonggu-flex-container">
            <div class="gonggu-title-area">
                <h2 class="section-title text-start mb-4">함께 사서 더 저렴하게</h2>
                <p class="section-subtitle">친환경 상품으로 지구를 지켜요</p>
            </div>
            <div class="row g-0 flex-grow-1">
                <c:forEach var="dto" items="${gongguList}" end="1">
                    <div class="col-gonggu-2">
                        <div class="card card-hover border-0 shadow-sm"
                             onClick="location.href='${pageContext.request.contextPath}/gonggu/${dto.gongguProductId}'">
                            <img alt="상품 이미지" class="card-img-top"
                                 src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}" />
                            <div class="card-body">
                                <h5 class="card-title">${dto.gongguProductName}</h5>
                                <p class="card-text">${dto.content}</p>
                                <div class="d-flex justify-content-between align-items-center">
								    <small class="text-muted">
								        <c:choose>
								            <c:when test="${dto.remainingDays > 5}">
								                <span class="text-secondary fw-bold me-2">진행중</span> 남은 시간: ${dto.remainingDays}일
								            </c:when>
								            <c:when test="${dto.remainingDays < 5}">
								                <span class="text-danger fw-bold me-2">마감 임박!</span> 남은 시간: ${dto.remainingDays}일
								            </c:when>
								            <c:otherwise>
								                <span class="text-dark-subtle fw-bold me-2">마감</span> 마감되었습니다.
								            </c:otherwise>
								        </c:choose>
								    </small>
								</div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
	</section>

	<!-- 감성 콘텐츠 카드 Section -->
	<section class="section">
		<div class="container">
			<h2 class="section-title">일상에서 시작하는 습관</h2>
			<div class="row g-4">
				<div class="col-md-4">
					<c:url var="defaultImg" value="/dist/images/noimage.png" />
					<c:if test="${not empty mainWorkshop}">
						<a
							href="${pageContext.request.contextPath}/workshop/detail?workshopId=${mainWorkshop.workshopId}"
							class="text-decoration-none">
							<div class="ratio ratio-4x3">
								<c:choose>
									<c:when test="${not empty mainWorkshop.thumbnailPath}">
										<img alt="워크샵" class="card-img"
											src="${pageContext.request.contextPath}/uploads/workshop/${mainWorkshop.thumbnailPath}"
											loading="lazy" decoding="async" />
									</c:when>
									<c:otherwise>
										<img alt="워크샵" class="card-img" src="${defaultImg}"
											loading="lazy" decoding="async" />
									</c:otherwise>
								</c:choose>
								<div class="card-img-overlay d-flex align-items-end">
									<div>
										<h5 class="card-title">워크샵</h5>
										<p class="card-text">배우고, 만드는 지속 가능성</p>
									</div>
								</div>
							</div>
						</a>
					</c:if>
				</div>
				<div class="col-md-4">
				  <a href="${pageContext.request.contextPath}/challenge/detail/${todayDaily.challengeId}" class="text-decoration-none">
				    <div class="ratio ratio-4x3">
				      <img alt="챌린지" class="card-img"
				           src="${pageContext.request.contextPath}/uploads/challenge/${todayDaily.thumbnail}"
				           loading="lazy" decoding="async" />
				      <div class="card-img-overlay d-flex align-items-end">
				        <div>
				          <h5 class="card-title">챌린지</h5>
				          <p class="card-text">오늘 할 수 있는 한 가지</p>
				        </div>
				      </div>
				    </div>
				  </a>
				</div>
				<div class="col-md-4">
					<div class="ratio ratio-4x3">
						<img alt="매거진" class="card-img"
							src="https://source.unsplash.com/600x400/?newsletter,reading" />
						<div class="card-img-overlay d-flex align-items-end">
							<div>
								<h5 class="card-title">매거진</h5>
								<p class="card-text">조용히 읽고, 가볍게 실천하기</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section> 
	
	<section class="py-5">
  <div class="container">
    <div class="promotion-carousel-wrapper border rounded shadow-sm overflow-hidden" 
         style="background-color: #f8f9fa; height: 160px;">

      <div id="carouselExampleIndicators" class="carousel slide h-100" data-bs-ride="carousel">

        <div class="carousel-indicators">
          <c:forEach var="vo" items="${bannerList}" varStatus="status">
            <button type="button" data-bs-target="#carouselExampleIndicators" 
                    data-bs-slide-to="${status.index}" 
                    class="${status.index == 0 ? 'active' : '' }"
                    aria-current="${status.index == 0 ? 'true' : 'false'}"
                    aria-label="${vo.subject}"></button>
          </c:forEach>
        </div>

        <div class="carousel-inner h-100">
          <c:forEach var="vo" items="${bannerList}" varStatus="status">
			  <div class="carousel-item ${status.index == 0 ? 'active' : '' } h-100">
			    <a href="${pageContext.request.contextPath}/admin/advertisement/list?page=1"> 
			      <img src="${pageContext.request.contextPath}/uploads/advertisement/${vo.imageFilename}"
			           class="d-block w-100 h-100" style="object-fit: cover;" alt="${vo.subject}">
			     </a>
			  </div>
			</c:forEach>

          <c:if test="${empty bannerList}">
            <div class="carousel-item active h-100">
			    <a href="${pageContext.request.contextPath}/advertisement/write" title="광고">
			        <img src="${pageContext.request.contextPath}/uploads/promotion/adversting.png"
			             class="d-block w-1294 h-158" 
			             style="object-fit: cover;" 
			             alt="기본 배너">
			    </a>
			</div>
          </c:if>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>

      </div>
    </div>
  </div>
</section>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>