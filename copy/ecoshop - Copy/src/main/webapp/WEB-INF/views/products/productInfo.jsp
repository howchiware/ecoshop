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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style type="text/css">
  .myNavTab {
    min-width: 170px;
    margin-right: 4px;
    color: #8E8D8D !important;
    font-weight: 500;
    text-align: center;
    border-radius: 4px 4px 0 0;
    transition: all 0.2s ease-in-out;
    margin-bottom: none;
    border: none !important;
  }
  
  .myNavTab .linkBtn:hover {
    color: black !important;
    background: none;
    /*box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15); /* hover 시 그림자 */
  }
  
  .myNavTab .linkBtn.active {
    color: black !important;
    background: none;
    /*box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2); /* 활성 탭 강조된 그림자 */
  }
  
  .linkBtn {
  	padding: 15px; font-size: 15px; color: #8E8D8D !important; border: none !important;
  }
  
  .item-div {border-bottom: 1px solid #E6E6E6;}
  
  .tab-pane { min-height: 300px; }

  .lg-img {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    transition: box-shadow 0.3s ease;
  }
  .lg-img:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); /* 호버 시 약간 강조 */
  }
  
  .lg-img img { min-height: 420px; max-height: 420px;}
  .md-img img { width: 150px; height: 150px; cursor: pointer; object-fit: cover; }
  .sm-img img { width: 50px; height: 50px; cursor: pointer; object-fit: cover; }
  .sm-img img {
    /* 기본 상태: 전환 효과 준비 */
    transition: transform 0.3s ease-in-out; /* 0.3초 동안 부드럽게 변환 */
  }
  .sm-img img:hover {
    transform: scale(1.05); /* 호버 시 1.05배 확대 */
    image-rendering: -webkit-optimize-contrast;  /* 확대 시 주변 픽셀이 깨지는 것 방지 */ 
  }

  .qty-plus, .qty-minus, .qty-remove { cursor: pointer; }
  .qty-plus:hover, .qty-minus:hover, .qty-remove:hover { color: #0b83e6; }

  .score-star i {
    margin-right: -4px;
    color: #f54a4c;
    font-size: 1.1rem;
    vertical-align: middle;
  }

  .graph { font-size: 0;  letter-spacing: 0; word-spacing: 0; }
  .graph-title { padding-right: 3px; }
  .graph .one-space { font-size:13px; background:#eee;}
  .graph .one-space:after { content: ''; display: inline-block; width:17px; }
  .graph .one-space.on{ background:  #f54a4c; }
  .graph .one-space:first-child{ border-top-left-radius:5px;  border-bottom-left-radius:5px; }
  .graph .one-space:last-child{ border-top-right-radius:5px; border-bottom-right-radius:5px; }
  .graph-rate { padding-left: 5px; display: inline-block; width: 60px; text-align: left; }

  .deleteReview, .notifyReview { cursor: pointer; padding-left: 5px; }
  .deleteReview:hover, .notifyReview:hover { font-weight: 500; color: #2478FF; }

  .qna-form textarea { width: 100%; height: 75px; resize: none; }
  .qna-form .img-grid { display: grid; grid-gap: 2px;
	  grid-template-columns:repeat(auto-fill, 54px); }
  .qna-form .img-grid .item { object-fit:cover; width: 50px; height: 50px; 
	  border-radius: 10px; border: 1px solid #c2c2c2; cursor: pointer; }

  .deleteQuestion, .notifyQuestion { cursor: pointer; padding-left: 5px; }
  .deleteQuestion:hover, .notifyQuestion:hover { font-weight: 500; color: #2478FF; }

  .product-content img { max-width: 100%; }
  
  .namePrice{ padding-bottom: 35px;}
  
  .infoArea {margin-top: 25px; margin-bottom: 25px;}
  
  .stockPrice {display: flex;}
  
  .order-area {background: #F7F7F7; margin-top: 30px; margin-bottom: 30px;}
  .order-box {padding: 15px 20px 0px 20px;}
  .total-div {padding: 0px 15px 10px 15px; display: flex}
  
  .text-primary {color: #87A78D !important}
  
  .btn-buySend {background: #87A78D; color:#fff; padding: 10px; border: none; border-radius: 5px; font-size: 15px;}
  .btn-buySend:hover{background: #7b9580;}
  
  .btn-productLike, .btn-productCart {border: 1px solid #E6E6E6; color: #000; padding: 8px; border-radius: 5px; font-size: 15px;}
  /*
  .row {--bs-gutter-x: 0rem !important;}
  */
  
  .section {font-size: 13px;}
  .productName {font-size: 15px; font-weight: 600}
  
  .info-table td:first-child{font-weight: 600; width: 100px;}
  
  .info-table td {padding: 5px 0px; vertical-align: top}
  
  .option-area {margin-top: 30px;}
  
  .option-select-area {padding: 3px 6px;}
  
  .form-select {font-size: 13px;}
  
  .total {font-size: 15px;}
  
  .refundInfo-div, .deliveryInfo-div {
  	padding: 15px;
  }
</style>

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
								<c:forEach var="vo" items="${listFile}">
									<div class="col-md-auto sm-img">
										<img class="border rounded" src="${pageContext.request.contextPath}/uploads/products/${vo.filename}">
									</div>
								</c:forEach>
							</div>
						</div>
						
						<!-- 우측 화면-->
						<div class="col-md-6 ps-4">
							<form name="buyForm">
								<c:if test="${dto.totalStock < 1}">
									<div class="border rounded bg-light mt-2 p-2 text-center">
										<label class="text-black-50 fw-bold">상품 재고가 없습니다.</label>
									</div>
								</c:if>
								
								<div class="row pt-2 border-bottom namePrice">
									<div class="col productName mb-2">
										스테인리스 칫솔걸이
									</div>
									<div class="price">
										<fmt:formatNumber value="30000"/>원
									</div>
								</div>
								<!-- 
								<div class="row pt-1 pb-1 border-bottom">
									<div class="col">
										<label class="align-middle">리뷰수 <span class="fs-5 fw-semibold product-reviewCount">${dto.reviewCount}</span></label>
										<label class="align-middle pt-0 ps-2 score-star product-star">
											<fmt:parseNumber var="intScore" value="${dto.score}" integerOnly="true" type="number"/>
											<c:forEach var="i" begin="1" end="${intScore}">
												<i class="bi bi-star-fill"></i>
											</c:forEach>
											<c:if test="${dto.score -  intScore >= 0.5}">
												<i class="bi bi bi-star-half"></i>
												<c:set var="intScore" value="${intScore+1}"/>
											</c:if>
											<c:forEach var="i" begin="${intScore + 1}" end="5">
												<i class="bi bi-star"></i>
											</c:forEach>
										</label>
										<label class="align-middle "><span class="product-score ps-1">(${dto.score} / 5)</span></label>
									</div>
								</div>
								-->
								
								<div class="row infoArea">
									<p class="content">칫솔의 위생적 건조가 가능한 스테인레스 칫솔걸이입니다.<br>특히 물기에 취약한 대나무 칫솔과 함께 사용하면 좋아요.</p>
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
												<td>64 포인트 적립예정</td>
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
												<option value="${vo.detailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
											</c:if>
											<c:if test="${dto.optionCount != 1}">
												<option value="${vo.detailNum}">${vo.optionValue}</option>
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
									<div class="row mt-2" style="font-weight: 500">
										* 필수 옵션
									</div>
									
									<div class="option-select-area" style="padding: 3px 6px;">
										<div class="row mt-2">
											<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
												<option value="">사이즈</option>
												<option value="S">S</option>
												<option value="M">M</option>
												<option value="L">L</option>
											</select>
										</div>
					
										<div class="row mt-2">
											<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
												<option value="">색상</option>
												<option value="">빨강</option>
												<option value="">노랑</option>
											</select>
										</div>
									</div>
								</div>
														
								<div class="row pb-2 order-area">
									<div class="order-box">
										<p>S / 빨강</p>
										<div class="stockPrice">
											
											<div class="col" style="display: inline-block">
							                    <div class="input-group">
							                        <i class="bi bi-dash input-group-text bg-white qty-minus"></i>
							                        <input type="text" name="buyQtys" class="form-control" value="1" style="flex:none; width: 60px; text-align: center;" readonly>
							                        <input type="hidden" name="productNums" value="${gvProductNum}">
							                        <input type="hidden" name="stockNums" value="${stockNum}">
							                        <input type="hidden" name="detailNums" value="${detailNum}" disabled>
							                        <input type="hidden" name="detailNums2" value="${detailNum2}" disabled>
							                        <i class="stockNumsbi bi-plus input-group-text bg-white qty-plus"></i>
							                    </div>
							                </div>
		                	                <div class="col text-end product-salePrice" data-salePrice="${salePrice}" style="display: inline-block">
							                    <label class="pt-2 fs-6 fw-semibold item-totalPrice">30,000원</label>
							                </div>
							            </div>
									</div>
									<div class="order-box">
										<p>S / 빨강</p>
										<div class="stockPrice">
											
											<div class="col" style="display: inline-block">
							                    <div class="input-group">
							                        <i class="bi bi-dash input-group-text bg-white qty-minus"></i>
							                        <input type="text" name="buyQtys" class="form-control" value="1" style="flex:none; width: 60px; text-align: center;" readonly>
							                        <input type="hidden" name="productNums" value="${gvProductNum}">
							                        <input type="hidden" name="stockNums" value="${stockNum}">
							                        <input type="hidden" name="detailNums" value="${detailNum}" disabled>
							                        <input type="hidden" name="detailNums2" value="${detailNum2}" disabled>
							                        <i class="stockNumsbi bi-plus input-group-text bg-white qty-plus"></i>
							                    </div>
							                </div>
		                	                <div class="col text-end product-salePrice" data-salePrice="${salePrice}" style="display: inline-block">
							                    <label class="pt-2 fs-6 fw-semibold item-totalPrice">30,000원</label>
							                </div>
							            </div>
									</div>
									
							        <div class="order-qty"></div>
							        
							        <div style="display: flex; justify-content: center; padding: 10px 10px 5px 10px;">
								        <hr style="width: 98%">
							        </div>
									<div class="total-div">
										<div class="col-auto fw-semibold pt-1 total">총상품금액 (1개)</div>
										<div class="col text-end">
											<label><span class="product-totalAmount fs-5 fw-semibold text-primary">30,000</span><span class="fw-semibold fs-6 text-primary">원</span></label>
										</div>
									</div>
								</div>
								
			
								<div class="mt-2">
									<input type="hidden" name="mode" value="buy">
									<button type="button" class="btn-accent btn-lg w-100 btn-buySend" onclick="sendOk('buy');" ${dto.totalStock < 1 ? 'disabled':''}>구매하기</button>
								</div>
								
								<div class="row mt-2 mb-2">
									<div class="col pe-1">
										<button type="button" class="btn-default btn-lg w-100 btn-productLike" data-productNum="${dto.productNum}" ${empty sessionScope.member.member_id ? "disabled" : ""}>찜하기&nbsp;&nbsp;<i class="bi ${dto.userWish==1 ? 'bi-heart-fill text-danger':'bi-heart'}"></i></button>
									</div>
									<div class="col ps-1">
										<button type="button" class="btn-default btn-lg w-100 btn-productCart" onclick="sendOk('cart');" ${empty sessionScope.member.member_id || dto.totalStock < 1 ? "disabled" : ""}>장바구니&nbsp;&nbsp;<i class="bi bi-cart-plus"></i></button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			</div>
							
			<div class="row gy-4">
				<div class="col-md-12">
					<c:import url="/WEB-INF/views/products/detailTab.jsp"/>
				</div>
			</div>
			
		</div>
	</div>
</main>

<div id="product-template">
	<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
	<input type="hidden" id="product-productNum" value="${dto.productNum}">
	<input type="hidden" id="product-productName" value="${dto.productName}">
	<input type="hidden" id="product-optionCount" value="${dto.optionCount}">
	<input type="hidden" id="product-price" value="${dto.price}">
	<input type="hidden" id="product-salePrice" value="${dto.salePrice}">
	<input type="hidden" id="product-stockNum" value="${dto.stockNum}">
	<input type="hidden" id="product-totalStock" value="${dto.totalStock}">
	<input type="hidden" id="product-thumbnail" value="${dto.thumbnail}">
	<input type="hidden" id="product-endDate" value="${dto.endDate}">
	<input type="hidden" id="product-classify" value="${dto.classify}">
</div>

<script src="${pageContext.request.contextPath}/dist/js2/productDetail.js"></script>
<script src="${pageContext.request.contextPath}/dist/js2/productDetail2.js"></script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>