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
<!-- Vendor CSS Files -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<style type="text/css">
  .detailState-form textarea { width: 100%; height: 75px; resize: none; }
  textarea::placeholder{ opacity: 1; color: #333; text-align: center; line-height: 60px; }
  
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
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

.main-container {
	display: flex;
}

.right-PANEL {
	flex-grow: 1;
	padding: 2rem;
	overflow-y: auto;
}

.outside {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.search-area tr {
font-size: 13px;
}

.search-area td.select-area {
	text-align: left;
}

p.small-title {
font-weight: 500;
}

.search-list {
	border: 1px solid black;
}

.search-list td {
	padding: 10px;
}

.search-list tbody, td, tfoot, th, thead, tr {
  border-color: black;
  border-style: solid;
  border-width: 0;
}

td.select-title-area {
border-right: 1px solid black;
}

select, input {
	padding: 3px;
	margin: -2px;
}

button {
	background: #fff;
	border: 1px solid black;
	color: black;
	padding: 3px;
}

.btn-area {
margin-top: 30px;
text-align: center;
}

.btn-accent {
	background: silver;
	border: none;
	color: black; 
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>

	<div class="right-PANEL">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>주문 상세정보</h2>
		</div>
		<hr>

		<div class="outside">

			<div class="section p-5" data-aos="fade-up" data-aos-delay="200" style="padding-top:0px">
				<div class="section-body p-5">
					<div class="row gy-4 m-0">
						<div class="col-lg-12 p-2 m-2" data-aos="fade-up" data-aos-delay="200">
							
							<div class="mt-3">
								<div class="p-3 shadow bg-body rounded mb-2">
									<p class="fs-6 fw-semibold mb-0">구매 상품</p> 
								</div>
								
								<table class="table table-bordered mb-1">
									<tr>
										<td class="table-light" width="140">상품명</td>
										<td colspan="5">
											${dto.productName}
										</td>
									</tr>
				
									<tr>
										<td class="table-light" width="140">옵 션</td>
										<td width="180">
											<c:choose>
												<c:when test="${dto.optionCount==0}">옵션 없음</c:when>
												<c:when test="${dto.optionCount==1}">${dto.optionValue}</c:when>
												<c:when test="${dto.optionCount==2}">${dto.optionValue} / ${dto.optionValue2}</c:when>
											</c:choose>
										</td>
										<td class="table-light" width="140">주문상태</td>
										<td width="180">${dto.detailStateInfo}</td>
										<td class="table-light" width="140">상품가격</td>
										<td width="180"><fmt:formatNumber value="${dto.price}"/></td>
									</tr>
									
									<tr>
										<td class="table-light" width="140">주문수량</td>
										<td width="180">${dto.qty}</td>
										<td class="table-light" width="140">구매총금액</td>
										<td width="180"><fmt:formatNumber value="${dto.productMoney}"/></td>
										<td class="table-light" width="140">적립금</td>
										<td width="180"><fmt:formatNumber value="${dto.savedPoint}"/></td>
									</tr>
									
									<tr>
										<td class="table-light" width="140">구매자</td>
										<td width="180">${dto.name}</td>
										<td class="table-light" width="140">회원번호</td>
										<td width="180">${dto.memberId}</td>
										<td class="table-light" width="140">아이디</td>
										<td width="180">${dto.userId}</td>
									</tr>
				
									<tr>
										<td class="table-light" width="140">구매일자</td>
										<td width="180">${dto.orderDate}</td>
										<td class="table-light" width="140">택배사</td>
										<td width="180">${dto.deliveryName}</td>
										<td class="table-light" width="140">송장번호</td>
										<td width="180">${dto.invoiceNumber}</td>
									</tr>
								</table>
								
								<table class="table table-borderless">
									<tr>
										<td width="50%">
										</td>
										<td class="text-end">
											<button type="button" class="btn-default" onclick="listDetailState();">상태확인</button>
											<c:if test="${!(dto.orderState==6 || dto.orderState==8 || dto.detailState==1 || dto.detailState==2 || dto.detailState==3)}">
												<button type="button" class="btn-default" onclick="detailStateUpdate();">상태변경</button>
											</c:if>
										</td>
									</tr>
								</table>
							</div>
						
							<c:if test="${listBuy.size() > 1}">
								<div class="mt-3">
									<div class="p-3 shadow bg-body rounded mb-2">
										<p class="fs-6 fw-semibold mb-0">함께 구매한 상품</p> 
									</div>
									
									<table class="table table-bordered mb-1">
										<c:forEach var="vo" items="${listBuy}">
											<c:if test="${dto.orderDetailId != vo.orderDetailId}">
												<tr>
													<td class="table-light" width="140">상품명</td>
													<td colspan="3">
														${vo.productName}
														<c:choose>
															<c:when test="${vo.optionCount==1}">(${vo.optionValue})</c:when>
															<c:when test="${vo.optionCount==2}">(${vo.optionValue} / ${vo.optionValue2})</c:when>
														</c:choose>,
														&nbsp;수량 : ${vo.qty}
													</td>
													<td class="table-light" width="140">금 액</td>
													<td width="180">
														<fmt:formatNumber value="${vo.productMoney}"/>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</table>
								</div>
							</c:if>
				
							<div class="mt-4">
								<div class="p-3 shadow bg-body rounded mb-2">
									<p class="fs-6 fw-semibold mb-0">결제 정보</p> 
								</div>
								
								<table class="table table-bordered mb-1">
									<tr>
										<td class="table-light" width="140">결제카드</td>
										<td width="180">${payDetail.CARDNAME}</td>
										<td class="table-light" width="140">승인일자</td>
										<td colspan="3">${payDetail.AUTHDATE}</td>
									</tr>
									<tr>
										<td class="table-light" width="140">총금액</td>
										<td width="180"><fmt:formatNumber value="${dto.totalMoney + dto.deliveryCharge}"/></td>
										<td class="table-light" width="140">포인트사용액</td>
										<td width="180"><fmt:formatNumber value="${dto.usedPoint}"/></td>
										<td class="table-light" width="140">결제금액</td>
										<td width="180"><fmt:formatNumber value="${dto.payment}"/></td>
									</tr>
								</table>
							</div>
							
							<table class="table table-borderless">
								<tr>
									<td width="50%">
										<button type="button" class="btn-default">이전주문</button>
										<button type="button" class="btn-default">다음주문</button>
									</td>
									<td class="text-end">
										<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/order/detailManage/${itemId}?${query}';">리스트</button>
									</td>
								</tr>
							</table>
	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<!-- 주문상세정보-상태확인 대화상자  -->
<div class="modal fade" id="detailStateInfoDialogModal" tabindex="-1" aria-labelledby="detailStateInfoDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="detailStateInfoDialogModalLabel">주문상세정보 상태 확인</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-3">
				<table class="table board-list">
					<thead>
						<tr>
							<th width="60">코드</th>
							<th width="120">구분</th>
							<th width="90">작성자</th>
							<th width="140">날짜</th>
							<th>설명</th>
						</tr>
					</thead>
					<tbody class="detailState-list"></tbody>	
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 주문상세정보-수정 대화상자 -->
<div class="modal fade" id="detailStateUpdateDialogModal" tabindex="-1" aria-labelledby="detailStateUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="detailStateUpdateDialogModalLabel">주문상세정보 상태 변경</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<form name="detailStateForm" class="justify-content-center detailState-form">
					<div class="row">
						<div class="col-auto p-1">
							<select name="detailState" class="form-select" style="width: 170px;">
								<c:choose>
									<c:when test="${(dto.detailState>=1 && dto.detailState<=3) || dto.detailState==5 || dto.detailState==8 || dto.detailState==12}">
										<option value="14">기타</option>
									</c:when>
									<c:when test="${dto.detailState==4}">
										<option value="5">주문취소완료</option>
									</c:when>
									<c:when test="${dto.detailState==6}">
										<option value="7">교환접수</option>
										<option value="8">교환발송완료</option>
										<option value="9">교환불가</option>
									</c:when>
									<c:when test="${dto.detailState==7}">
										<option value="8">교환발송완료</option>
										<option value="9">교환불가</option>
									</c:when>
									<c:when test="${dto.detailState==10}">
										<option value="11">반품접수</option>
										<option value="12">반품완료</option>
										<option value="13">반품불가</option>
									</c:when>
									<c:when test="${dto.detailState==11}">
										<option value="12">반품완료</option>
										<option value="13">반품불가</option>
									</c:when>
									<c:otherwise>
										<c:if test="${dto.orderState==5}">
											<option value="2">자동구매확정</option>
										</c:if>
										<c:if test="${dto.orderState!=5}">
											<option value="3">판매취소</option>
										</c:if>
										<option value="14">기타</option>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col p-1">
							<textarea class="form-control" name="stateMemo" placeholder="상태 메시지 입력"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col p-1 text-end">
							<input type="hidden" name="orderId" value="${dto.orderId}">
							<input type="hidden" name="orderDetailId" value="${dto.orderDetailId}">
							<input type="hidden" name="productCode" value="${dto.productCode}">
							<input type="hidden" name="usedPoint" value="${dto.usedPoint}">
							<input type="hidden" name="payment" value="${dto.payment}">
							<input type="hidden" name="memberId" value="${dto.memberId}">
							<input type="hidden" name="orderDate" value="${dto.orderDate}">
							<input type="hidden" name="optionCount" value="${dto.optionCount}">
							<input type="hidden" name="optionDetailNum" value="${dto.optionDetailNum}">
							<input type="hidden" name="optionDetailNum2" value="${dto.optionDetailNum2}">
							<input type="hidden" name="qty" value="${dto.qty}">
							<input type="hidden" name="productMoney" value="${dto.productMoney}">
							<input type="hidden" name="savedPoint" value="${dto.savedPoint}">
							<input type="hidden" name="cancelAmount" value="${dto.cancelAmount}">
							
							<button type="button" class="btn-default btnDetailStateUpdateOk"> 변경 </button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function detailStateUpdate() {
	$('#detailStateUpdateDialogModal').modal('show');
}

$(function(){
	$('.btnDetailStateUpdateOk').click(function(){
		const f = document.detailStateForm;
		
		if(! f.stateMemo.value.trim()) {
			alert('상태 메시지를 등록하세요');
			f.stateMemo.focus();
			return false;
		}
		
		let params = $('form[name=detailStateForm]').serialize();
		let url = '${pageContext.request.contextPath}/admin/order/updateDetailState';
		
		const fn = function(data) {
			let reloadUrl = '${pageContext.request.contextPath}/admin/order/detailManage/${itemId}/${dto.orderDetailId}?${query}';
			location.href = reloadUrl;
		};
	
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

function listDetailState() {
	$('.detailState-list').empty();
	$('#detailStateInfoDialogModal').modal('show');
	
	let orderDetailId = '${dto.orderDetailId}';
	
	let params = 'orderDetailId=' + orderDetailId;
	let url = '${pageContext.request.contextPath}/admin/order/listDetailState';

	const fn = function(data) {
		let out = '';
		for (let item of data.list) {
			  out += `
			    <tr>
			      <td>\${item.DETAILSTATE}</td>
			      <td>\${item.DETALSTATEINFO}</td>
			      <td>\${item.NAME}</td>
			      <td>\${item.DETAILSTATEDATE}</td>
			      <td align="left">\${item.STATEMEMO}</td>
			    </tr>
			  `;
			}
		if(out) {
			$('.detailState-list').append(out);
		}
	};
	
	ajaxRequest(url, 'get', params, 'json', fn);
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<!-- Vendor JS Files -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<script type="text/javascript">
AOS.init();
</script>

</body>
</html>