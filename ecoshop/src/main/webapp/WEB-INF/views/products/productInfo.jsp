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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css"> 
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_product/productInfo_css.css">

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
						<!-- 좌측 이미지 -->
						<div class="col-md-6 p-2 pe-5">
							<div class="row gx-1 p-1">
								<div class="col border rounded lg-img p-0">
									<img class="w-100 h-100 rounded" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
								</div>
							</div>
							<div class="row gx-1 mt-2 p-1">
								<c:forEach var="vo" items="${listPhoto}">
									<div class="col-md-auto sm-img">
										<img class="border rounded" src="${pageContext.request.contextPath}/uploads/products/${vo.photoName}">
									</div>
								</c:forEach>
							</div>
						</div>
						
						<!-- 우측 화면-->
						<div class="col-md-6 ps-4">
							<form name="buyForm">
								<c:if test="${dto.totalStock < 1}">
									<div class="border rounded mt-2 mb-2 p-2 text-center" style="background: ">
										<label class="text-black-50 fw-bold">상품 재고가 없습니다.</label>
									</div>
								</c:if>
								<div class="row pt-2 border-bottom namePrice">
									<div class="col productName mb-2">
										${dto.productName}
									</div>
									<div class="price">
										<fmt:formatNumber value="${dto.price}"/>원
									</div>
								</div>
								<!-- 
								<div class="row pt-1 pb-1 border-bottom">
									<div class="col">
										<label class="align-middle">리뷰수 <span class="fs-5 fw-semibold product-reviewCount">${dto.reviewCount}</span></label>
										<label class="align-middle pt-0 ps-2 rate-star product-star">
											<fmt:parseNumber var="intRate" value="${dto.rate}" integerOnly="true" type="number"/>
											<c:forEach var="i" begin="1" end="${intRate}">
												<i class="bi bi-star-fill"></i>
											</c:forEach>
											<c:if test="${dto.rate -  intRate >= 0.5}">
												<i class="bi bi bi-star-half"></i>
												<c:set var="intRate" value="${intRate+1}"/>
											</c:if>
											<c:forEach var="i" begin="${intRate + 1}" end="5">
												<i class="bi bi-star"></i>
											</c:forEach>
										</label>
										<label class="align-middle "><span class="product-rate ps-1">(${dto.rate} / 5)</span></label>
									</div>
								</div>
								-->
								
								<div class="row infoArea">
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
												<td>구매혜택</td>
												<td>${dto.point} 포인트 적립예정</td>
											</tr>
											<tr>
												<td>배송 방법</td>
												<td>택배</td>
											</tr>
											<tr>
												<td>배송비</td>
												<td>3,000원 (30,000원 이상 무료배송)<br>도서산간 배송비 추가</td>
											</tr>
										</tbody>
									</table>
								</div>
		
								<!--<c:if test="${dto.optionCount > 0}">
								<div class="mt-2">
									* 필수 옵션
								</div>
								</c:if>
								
								<c:if test="${dto.optionCount > 0}">
								<div class="mt-2">
									<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
										<option value="">${listOption[0].optionName}</option>
										<c:forEach var="vo" items="${listOptionDetail}">
											<c:if test="${dto.optionCount == 1}">
												<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
											</c:if>
											<c:if test="${dto.optionCount != 1}">
												<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								</c:if>
			
								<c:if test="${dto.optionCount > 1}">
								<div class="mt-2 border-bottom pb-2">
									<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
										<option value="">${listOption[1].optionName}</option>
									</select>
								</div>
								</c:if>-->
								
								<div class="option-area">
									<c:if test="${dto.optionCount > 0}">
										<div class="row mt-2" style="font-weight: 500">
											* 필수 옵션
										</div>
									</c:if>
									
									<div class="option-select-area" style="padding: 3px 6px;">
										<c:if test="${dto.optionCount > 0}">
											<div class="row mt-2">
												<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
													<option value="">${listOption[0].optionName}</option>
													<c:forEach var="vo" items="${listOptionDetail}">
														<c:if test="${dto.optionCount == 1}">
															<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
														</c:if>
														<c:if test="${dto.optionCount != 1}">
															<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
										</c:if>
					
										<c:if test="${dto.optionCount > 1}">
											<div class="row mt-2">
												<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
													<option value="">${listOption[1].optionName}</option>
												</select>
											</div>
										</c:if>
									</div>
								</div>
														
								<div class="row pb-2 order-area">
									<div class="order-box">
										<!-- 
										<p>S / 빨강</p>
										<div class="stockPrice">
											
											<div class="col" style="display: inline-block">
							                    <div class="input-group">
							                        <i class="bi bi-dash input-group-text bg-white qty-minus"></i>
							                        <input type="text" name="buyQtys" class="form-control" value="1" style="flex:none; width: 60px; text-align: center;" readonly>
							                        <input type="hidden" name="productCodes" value="${gvProductCodes}">
							                        <input type="hidden" name="stockNums" value="${stockNum}">
							                        <input type="hidden" name="optionDetailNums" value="${optionDetailNum}" disabled>
							                        <input type="hidden" name="optionDetailNums2" value="${optionDetailNum2}" disabled>
							                        <i class="stockNumsbi bi-plus input-group-text bg-white qty-plus"></i>
							                    </div>
							                </div>
		                	                <div class="col text-end product-salePrice" data-salePrice="${salePrice}" style="display: inline-block">
							                    <label class="pt-2 fs-6 fw-semibold item-totalPrice">30,000원</label>
							                </div>
							            </div>
							             -->
									</div>
							        
									<div class="total-div">
										<div class="col-auto fw-semibold pt-1 total">총상품금액 (<span class="product-totalQty">0</span>개)</div>
										<div class="col text-end">
											<label><span class="product-totalAmount fs-5 fw-semibold text-primary">0</span><span class="fw-semibold fs-6 text-primary">원</span></label>
										</div>
									</div>
								</div>
								
			
								<div class="mt-2">
									<input type="hidden" name="mode" value="buy">
									<button type="button" class="btn-accent btn-lg w-100 btn-buySend" onclick="sendOk('buy');" ${dto.totalStock < 1 ? 'disabled':''}>구매하기</button>
								</div>
								
								<div class="row mt-2 mb-2">
									<div class="col pe-1">
										<button type="button" class="btn-default btn-lg w-100 btn-productLike" data-productCode="1" ${empty sessionScope.member.memberId ? "disabled" : ""}>찜하기&nbsp;&nbsp;<i class="bi ${dto.userWish==1 ? 'bi-heart-fill text-danger':'bi-heart'}"></i></button>
									</div>
									<div class="col ps-1">
										<button type="button" class="btn-default btn-lg w-100 btn-productCart" onclick="sendOk('cart');" ${empty sessionScope.member.memberId || dto.totalStock < 1 ? "disabled" : ""}>장바구니&nbsp;&nbsp;<i class="bi bi-cart-plus"></i></button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			</div>
							
			<div class="row gy-4 detailTabList">
				<div class="col-md-12">
					<c:import url="/WEB-INF/views/products/detailTab.jsp"/>
				</div>
			</div>
			
		</div>
	</div>
</main>

<div id="product-template">
	<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
	<input type="hidden" id="product-productCode" value="${dto.productCode}">
	<input type="hidden" id="product-productName" value="${dto.productName}">
	<input type="hidden" id="product-optionCount" value="${dto.optionCount}">
	<input type="hidden" id="product-price" value="${dto.price}">
	<input type="hidden" id="product-salePrice" value="${dto.sale}">
	<input type="hidden" id="product-stockNum" value="${dto.stockNum}">
	<input type="hidden" id="product-totalStock" value="${dto.totalStock}">
	<input type="hidden" id="product-thumbnail" value="${dto.thumbnail}">
</div>

<script src="${pageContext.request.contextPath}/dist/js2/productDetail.js"></script>
<script src="${pageContext.request.contextPath}/dist/js2/productDetail2.js"></script>

<footer>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</footer>

</body>
</html>