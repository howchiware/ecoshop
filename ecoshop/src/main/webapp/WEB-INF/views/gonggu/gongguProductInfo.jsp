<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hShop - 공동구매 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css"> 
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/gongguProductInfo.css"> 

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="section" style="background: #fff">
		<div class="container">

			<div class="row gy-4" >
	
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 p-2 pe-5">
							<div class="row gx-1 p-1">
								<div class="col border rounded lg-img p-0">
									<img id="main-product-image" class="w-100 h-100 rounded" 
									     src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}" 
									     alt="${dto.gongguProductName} 대표 이미지">
								</div>
							</div>
							<div class="sm-img-container">
								<div class="sm-img">
									<img src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}" 
									     alt="${dto.gongguProductName} 썸네일">
								</div>

								<c:forEach var="photo" items="${listPhoto}" varStatus="loop">
									<div class="sm-img">
										<img src="${pageContext.request.contextPath}/uploads/gonggu/${photo.detailPhoto}">
									</div>
								</c:forEach>
							</div>
						</div>
						
						<div class="col-md-6 ps-4">
							<form name="buyForm">
								<div class="row pt-2 border-bottom namePrice">
									<div class="col productName mb-2">
										${dto.gongguProductName}
									</div>
									<div class="price">
										<fmt:formatNumber value="${dto.gongguPrice}"/>원
										<c:if test="${dto.sale > 0}">
											<span class="text-decoration-line-through text-muted ms-2"><fmt:formatNumber value="${dto.originalPrice}"/>원</span>
											<span class="text-danger ms-2">${dto.sale}%</span>
										</c:if>
									</div>
								</div>
								
								<div class="row infoArea mt-3">
									<p class="content">${dto.content}</p>
								</div>
								
								<div class="row mt-2">
									<table class="info-table">
										<tbody>
											<tr>
												<td>브랜드</td>
												<td>ecobrand 샵</td>
											</tr>
											<tr>
												<td>공동구매 기간</td>
												<td>${dto.startDate} ~ ${dto.endDate}</td>
											</tr>
											
											<tr>
												<td>배송비</td>
												<td>
													<c:choose>
														<c:when test="${!empty deliveryFeeList}">
															<c:forEach var="fee" items="${deliveryFeeList}" varStatus="status">
																<fmt:formatNumber value="${fee.deliveryFee}"/>원
																<c:if test="${fee.deliveryLocation != null && fee.deliveryLocation != ''}">
																	(${fee.deliveryLocation})
																</c:if>
																<br>
															</c:forEach>
														</c:when>
														<c:otherwise>
															배송비 정보 없음
														</c:otherwise>
													</c:choose>
												</td>
											<tr>
												<td><span class="fw-semibold text-primary">${participantCount}명 참여 / ${limitCount}명</span></td>
											</tr>
											<tr>
												<td><span>남은 인원 : ${remainCount}</span><td>
											</tr>
										</tbody>
									</table>
								</div>
								<hr>
								
								<div class="row mt-2 mb-2">
									<div class="col pe-1">
										<button type="button" class="btn-default btn-lg w-100 btn-gongguLike" data-gongguProductId="${dto.gongguProductId}" 
												${empty sessionScope.member.memberId ? "disabled" : ""}>
												찜하기&nbsp;&nbsp;<i class="bi ${dto.userWish==1 ? 'bi-heart-fill text-danger':'bi-heart'}"></i>
										</button>
									</div>
									<div class="col ps-1">
										<input type="hidden" name="mode" value="buy">
										<input type="hidden" name="gongguOrderDetailId" value="${dto.gongguOrderDetailId}">
											<button type="button" class="btn-accent btn-lg w-100 btn-gongguBuy" onclick="requestGongguPayment();" 
											${remainCount < 1 ? 'disabled':''} 
											${empty sessionScope.member ? 'disabled' : ''}>
											예약 결제하기
									</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			</div>
							
			<div class="row gy-4 detailTabList">
				<div class="col-md-12">
					<c:import url="/WEB-INF/views/gonggu/detailTab.jsp"/>
				</div>
			</div>
			
		</div>
	</div>
</main>

<div id="gonggu-template"> 
	<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
	<input type="hidden" id="gonggu-gongguProductId" value="${dto.gongguProductId}"> 
	<input type="hidden" id="gonggu-gongguProductName" value="${dto.gongguProductName}"> 
	<input type="hidden" id="gonggu-originalPrice" value="${dto.originalPrice}"> 
	<input type="hidden" id="gonggu-sale" value="${dto.sale}"> 
	<input type="hidden" id="gonggu-gongguThumbnail" value="${dto.gongguThumbnail}"> 
	<input type="hidden" id="gonggu-limitCount" value="${dto.limitCount}"> 
	<input type="hidden" id="gonggu-participantCount" value="${participantCount}"> 
	<input type="hidden" id="gonggu-gongguPrice" value="${dto.gongguPrice}">
</div>

<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductDetail.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductDetail2.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductLike.js"></script> 
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text-javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</footer>
</body>
</html>