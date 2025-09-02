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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tabs.css" type="text/css">
<style type="text/css">
  .md-img { width: 80px; height: 80px; }
  .original-price { text-decoration: line-through; color: #999; font-size: 0.9em; }
  .btn-lg { background: #AEBFA2; border-radius: 10px; padding: 4px; 0 4px 0; color: #ffffff; border: 1px solid #ffffff;}
  .product-totalAmount{ color:#7b9580;}
  .selected-defaultDest{ color:#7b9580; }
  .btnUpdateDelivery { border-radius: 6px; border: 1px solid #ffffff; color: #5C5C5C;}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="section services light-background">
		<div class="container section-title" data-aos="fade-up">
			<h2>주문 / 결제</h2>
		</div>	
	
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-12 bg-white p-5">
				
					<form name="paymentForm" method="post">
						<table class="table">
							<tr class="table-light border-top text-center">
								<th width="120">&nbsp;</th>
								<th>상품정보</th>
								<th width="65">수량</th>
								<th width="125">상품금액</th>
								<th width="125">총금액</th>
							</tr>
							
							<c:set var="dto" value="${listGongguProduct[0]}" /> <tr class="text-center" valign="middle">
								<td>
									<img class="border rounded md-img" src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}">
								</td>
								<td>
									<div class="fw-semibold">${dto.gongguProductName}</div>
									<input type="hidden" name="gongguProductId" value="${dto.gongguProductId}">
									<input type="hidden" name="prices" value="${dto.salePrice}">
									<input type="hidden" name="cnt" value="${dto.cnt}">
									<input type="hidden" name="usedPoint" value="0">										
									<input type="hidden" name="classify" value="2">
								</td>
								<td>
									${dto.cnt}
								</td>
									<td >
										<div>
											<label class="original-price">
												<fmt:formatNumber value="${dto.originalPrice}"/>원
											</label>
										</div>
										<div>
											<label class="fw-semibold">
												<fmt:formatNumber value="${dto.salePrice}"/>원
											</label>
										</div>
									</td>
									<td>
										<label class="fw-semibold">
												<fmt:formatNumber value="${dto.salePrice}"/>원
										</label>
									</td>
								</tr>						
						</table>
						
						<input type="hidden" name="orderId" value="${gongguOrderNumber}">
						<input type="hidden" name="totalAmount" value="${totalAmount}">
						<input type="hidden" name="deliveryCharge" value="${deliveryCharge}">
						<input type="hidden" name="payment" value="${totalPayment}">
		
						<input type="hidden" name="imp_uid" value="">
						<input type="hidden" name="payMethod" value="">
						<input type="hidden" name="cardName" value="">
						<input type="hidden" name="cardNumber" value="">
						<input type="hidden" name="applyNum" value="">
						<input type="hidden" name="applyDate" value="">
		
						<div class="p-3 border">
							<div class="fs-6 fw-semibold border-bottom pb-1">배송지 정보</div>
							<div class="row ps-2 pt-2">
								<div class="col-auto pe-2 mt-2">
									<label class="fw-semibold selected-recipientName">
										${empty destination ? "배송지를 입력하세요" : ""}
										<c:if test="${empty destination.addressName}">
											${destination.recipientName}
										</c:if>
										<c:if test="${not empty destination.addressName}">
											${destination.recipientName}(${destination.addressName})
										</c:if>
									</label>
									<label class="selected-defaultDest">${destination.defaultDest == 1 ? "기본배송지" : ""}</label>
								</div>
								<div class="col-auto">
									<button type="button" class="btn-default btnUpdateDelivery"> 배송지변경 </button>
								</div>
							</div>
							<div class="ps-2 pt-2">
								<div class="pt-2 selected-addr">${destination.addr1} ${destination.addr2}</div>
								<div class="pt-2 selected-tel">${destination.tel}</div>
								<div class="pt-2 w-50">
									<input type="hidden" name="recipientName" value="${destination.recipientName}">
									<input type="hidden" name="tel" value="${destination.tel}">
									<input type="hidden" name="zip" value="${destination.zip}">
									<input type="hidden" name="addr1" value="${destination.addr1}">
									<input type="hidden" name="addr2" value="${destination.addr2}">
									<input type="hidden" name="pickup" value="${destination.pickup}">
									<input type="hidden" name="accessInfo" value="${destination.accessInfo}">
									<input type="hidden" name="passcode" value="${destination.passcode}">
									<input type="text" name="requestMemo" class="form-control" placeholder="요청사항을 입력합니다.">
								</div>
							</div>
						</div>

						<div class="pt-3">
							<div class="text-end">
								<label class="fs-6 fw-semibold">총 결제금액 : </label>
								<label class="product-totalAmount fs-4 fw-bold">
									<fmt:formatNumber value="${totalPayment}"/>원
								</label>
							</div>
							<div class="ps-2 pt-2 text-end">
								<label>상품금액 : </label>
								<label>
									<fmt:formatNumber value="${totalAmount}"/>원
								</label>
							</div>
							<div class="ps-2 pt-1 text-end">
								<label>배송비 : </label>
								<label>
									<fmt:formatNumber value="${deliveryCharge}"/>원
								</label>
							</div>
						</div>	
						
						<div class="pt-3 pb-3 text-center">
							<button type="button" class="btn-accent btn-lg" style="width: 250px;" onclick="sendOk()">결제하기</button>
							<button type="button" class="btn-default btn-lg" style="width: 250px;" onclick="goBack()">결제취소</button>
						</div>
					</form>

				</div>
			</div>
			
		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.paymentForm;
	
	if(! f.recipientName.value) {
		alert('먼저 배송지를 등록하세요.');
		return;
	}
	
	// 결제 API에서 응답 받을 파라미터
	let imp_uid = 'ID-1234';
	let pay_method = '카드결제';
	let card_name = 'BC 카드';
	let card_number = '1234567890';
	let apply_num = '1234567890';
	let apply_date = '';
	apply_date = new Date().toISOString().replace('T', ' ').slice(0, -5);

	// 결제 성공 시 폼 데이터 설정
    f.imp_uid.value = imp_uid;
    f.payMethod.value = pay_method;
    f.cardName.value = card_name || '';
    f.cardNumber.value = card_number;
    f.applyNum.value = apply_num;
    f.applyDate.value = apply_date;
	
	f.action = '${pageContext.request.contextPath}/gongguOrder/paymentOk';
	f.submit();
}
function goBack() {
    history.back();
}
</script>

<c:import url="/WEB-INF/views/gongguOrder/deliveryInfo.jsp"/>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</footer>

</body>
</html>