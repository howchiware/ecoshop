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
								<th width="85">구매적립</th>
								<th width="65">수량</th>
								<th width="125">상품금액</th>
								<th width="125">총금액</th>
							</tr>
							
							<c:forEach var="dto" items="${listProduct}" varStatus="status">
								<tr class="text-center" valign="middle">
									<td>
										<img class="border rounded md-img" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
									</td>
									<td>
										<div class="fw-semibold">${dto.productName}</div>
										<div>
											<c:if test="${dto.optionCount==1}">
												${dto.optionName} : ${dto.optionValue}
											</c:if>
											<c:if test="${dto.optionCount==2}">
												${dto.optionName} : ${dto.optionValue} / 
												${dto.optionName2} : ${dto.optionValue2}
											</c:if>
										</div>
										
										<input type="hidden" name="productCodes" value="${dto.productCode}">
										<input type="hidden" name="optionDetailNums" value="${empty dto.optionDetailNum ? 0 : dto.optionDetailNum}">
										<input type="hidden" name="optionDetailNums2" value="${empty dto.optionDetailNum2 ? 0 : dto.optionDetailNum2}">
										<input type="hidden" name="stockNums" value="${dto.stockNum}">
										<input type="hidden" name="buyQtys" value="${dto.qty}">
										<input type="hidden" name="productMoneys" value="${dto.productMoney}">
										<input type="hidden" name="prices" value="${dto.price}">
										<input type="hidden" name="points" value="${dto.point}">
									</td>
									<td>
										<fmt:formatNumber value="${dto.point}"/>
									</td>
									<td>
										${dto.qty}
									</td>
									<td >
										<div>
											<label class="fw-light">
												<fmt:formatNumber value="${dto.price}"/>원
											</label>
										</div>
									</td>
									<td>
										<label class="fw-semibold">
											<fmt:formatNumber value="${dto.productMoney}"/>원
										</label>
									</td>
								</tr>
							</c:forEach>
						</table>
						
						<input type="hidden" name="orderId" value="${productOrderNumber}">
						<input type="hidden" name="totalAmount" value="${totalAmount}">
						<input type="hidden" name="deliveryCharge" value="${deliveryCharge}">
						<input type="hidden" name="payment" value="${totalPayment}">
		
						<input type="hidden" name="mode" value="${mode}">
		
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
									<label class="text-primary selected-defaultDest">${destination.defaultDest == 1 ? "기본배송지" : ""}</label>
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

						<div class="p-3 border mt-3">
							<div class="fs-6 fw-semibold border-bottom pb-1">포인트</div>
							<div class="ps-2 pt-2">
								<div class="pt-2 fw-semibold">보유 <fmt:formatNumber value="${empty userPoint ? 0 : userPoint.balance}"/>원</div>
							</div>
							<div class="row ps-2 pt-2">
								<div class="col-6">
									<div class="input-group">
										<input type="number" class="form-control" name="usedPoint" value="0" min="0" max="${empty userPoint ? 0 : userPoint.balance}">
										<button type="button" class="input-group-text btn-usedPoint" data-balance="${empty userPoint ? 0 : userPoint.balance}">전액사용</button>
									</div>
								</div>
							</div>
						</div>				
						
						<div class="pt-3">
							<div class="text-end">
								<label class="fs-6 fw-semibold">총 결제금액 : </label>
								<label class="product-totalAmount fs-4 fw-bold text-primary">
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
							<div class="ps-2 pt-1 text-end">
								<label>포인트사용액 : </label>
								<label class="point-usedPoint">
									0원
								</label>
							</div>
						</div>
						
						<div class="pt-3">
							<div class="text-end">
								<label class="fs-6">포인트 적립 : </label>
								<label class="fs-5">
									<fmt:formatNumber value="${totalSavedMoney}"/>원
								</label>
							</div>
						</div>
						
						<div class="pt-3 pb-3 text-center">
							<button type="button" class="btn-accent btn-lg" style="width: 250px;" onclick="sendOk()">결제하기</button>
							<button type="button" class="btn-default btn-lg" style="width: 250px;" onclick="location.href='${pageContext.request.contextPath}/';">결제취소</button>
						</div>
					</form>

				</div>
			</div>
			
		</div>
	</div>
</main>

<script type="text/javascript">
$(function(){
	$('.btn-usedPoint').click(function(){
		const f = document.paymentForm;
		
		let balance = Number($(this).attr('data-balance')) || 0;
		f.usedPoint.value = balance;
		
		let payment = Number(f.payment.value) - balance;
		
		$('.product-totalAmount').text(payment.toLocaleString() + '원');
		$('.point-usedPoint').text(balance.toLocaleString() + '원');
	});
	
	$('form[name=paymentForm] input[name=usedPoint]').on('keyup mouseup', function() {                                                                                                                     
		const f = document.paymentForm;
		let balance = Number($('.btn-usedPoint').attr('data-balance')) || 0;
		let usedPoint = Number(f.usedPoint.value);
		
		if(usedPoint > balance) {
			usedPoint = balance;
			f.usedPoint.value = balance;
		}
		
		let payment = Number(f.payment.value) - usedPoint;
		
		$('.product-totalAmount').text(payment.toLocaleString() + '원');
		$('.point-usedPoint').text(usedPoint.toLocaleString() + '원');
	});
});

function sendOk() {
	const f = document.paymentForm;
	
	if(! f.recipientName.value) {
		alert('먼저 배송지를 등록하세요.');
		return;
	}
	
	if(! /^\d+$/.test(f.usedPoint.value)) {
		alert('숫자만 입력 가능합니다.');
		return;
	}

	let balance = Number($('.btn-usedPoint').attr('data-balance')) || 0;
	let usedPoint = Number(f.usedPoint.value);

	if(usedPoint > balance) {
		alert('사용 가능 포인터는 보유 포인터를 초과 할수 없습니다.');
		return;
	}
	
	// 결제 금액 = 총금액 - 포인트사용금액
	let p = Number(f.payment.value) - usedPoint;
	f.payment.value = p;
	
	// 결제 API에서 응답 받을 파라미터
	let imp_uid = 'ID-1234';
	let pay_method = '카드결제'; // 결제유형
	let card_name = 'BC 카드';  // 카드 이름
	let card_number = '1234567890'; // 카드번호
	let apply_num = '1234567890'; // 승인번호
	let apply_date = ''; // 승인 날짜
	// toISOString() : 'YYYY-MM-DDTHH:mm:ss.sssZ' 형식
	apply_date = new Date().toISOString().replace('T', ' ').slice(0, -5); // YYYY-MM-DD HH:mm:ss

	// 결제 API에 요청할 파라미터
	let payment = f.payment.value; // 결제할 금액
	let merchant_uid = '${productOrderNumber}';  // 고유 주문번호
	let productName = '${productOrderName}';  // 주문상품명
	let buyer_email = '${orderUser.email}';  // 구매자 이메일
	let buyer_name = '${orderUser.name}';  // 구매자 이름
	let buyer_tel = '${orderUser.tel}';   // 구매자 전화번호(필수)
	let buyer_addr = '${orderUser.addr1}' + ' ' + '${orderUser.addr2}';  // 구매자 주소
	buyer_addr = buyer_addr.trim();
	let buyer_postcode = '${orderUser.zip}'; // 구매자 우편번호
	
	// 결제 API로 결제 진행
	
	
	
	// 결제가 성공한 경우 ------------------------
	
	// 결제 방식, 카드번호, 승인번호, 결제 날짜
    f.imp_uid.value = imp_uid;
    f.payMethod.value = pay_method;
    f.cardName.value = card_name || '';
    f.cardNumber.value = card_number;
    f.applyNum.value = apply_num;
    f.applyDate.value = apply_date;
	
	f.action = '${pageContext.request.contextPath}/productsOrder/paymentOk';
	f.submit();
}
</script>

<c:import url="/WEB-INF/views/productsOrder/deliveryInfo.jsp"/>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</footer>



</body>
</html>