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
  .orderStatus-update, .orderDetailStatus-update { cursor: pointer;  }
  .orderStatus-update:hover, .orderDetailStatus-update:hover { color: #0d6efd; }
  .text-line { text-decoration: line-through; }
  
  .right-PANEL {
 
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
.modal-backdrop {
	z-index: 9998 !important;
}

.modal {
	z-index: 9999 !important;
}
</style>
</head>
<body>

<header>
   <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container" style="z-index: 100">
   <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>

   <div class="right-PANEL">
      <div class="page-title" data-aos="fade-up" data-aos-delay="200">
         <h2>주문 현황</h2>
      </div>
		
      <hr>

	<div class="outside">
      <div class="section p-5" data-aos="fade-up" data-aos-delay="200">
         <div class="section-body p-5">
            <div class="row gy-4 m-0">
               <div class="col-lg-12 p-2 m-2" data-aos="fade-up" data-aos-delay="200">
                  <!-- 주문정보 -->
                  <div class="p-3 shadow bg-body rounded">
                     <p class="fs-6 fw-semibold mb-0">주문 정보</p> 
                  </div>
                  <div class="mt-3 p-2">
                     <table class="table table-bordered mb-1">
                        <tr>
                           <td class="table-light" width="100">주문번호</td>
                           <td width="160">${order.orderId}</td>
                           <td class="table-light" width="105">주문자</td>
                           <td width="160">${order.name}</td>
                           <td class="table-light" width="105">주문일자</td>
                           <td width="150">${order.orderDate}</td>
                           <td class="table-light" width="100">주문상태</td>
                           <td width="150">${order.orderStateInfo}</td>
                        </tr>
                        <tr>
                           <td class="table-light">총금액</td>
                           <td class="text-primary"><fmt:formatNumber value="${order.totalAmount}"/></td>
                           <td class="table-light">결제금액</td>
                           <td class="text-primary"><fmt:formatNumber value="${order.payment}"/></td>
                           <td class="table-light">취소금액</td>
                           <td class="text-warning order-cancelAmount" data-cancelAmount="${order.cancelAmount}">
                              <fmt:formatNumber value="${order.cancelAmount}"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="table-light">배송비</td>
                           <td class="text-primary"><fmt:formatNumber value="${order.deliveryCharge}"/></td>
                           <td class="table-light">배송업체</td>
                           <td>${order.deliveryName}</td>
                           <td class="table-light">송장번호</td>
                           <td>${order.invoiceNumber}</td>
                           <td class="table-light">상태변경일</td>
                           <td>${order.orderStateDate}</td>
                        </tr>
                        <tr>
                           <td class="table-light">결제고유ID</td>
                           <td>${order.imp_uid}</td>
                           <td class="table-light">결제구분</td>
                           <td>
                              ${order.payMethod}
                              <c:if test="${not empty order.cardName}">(${order.cardName})</c:if>
                           </td>
                           <td class="table-light">결제승인번호</td>
                           <td>${order.applyNum}</td>
                           <td class="table-light">승인일자</td>
                           <td>${order.applyDate}</td>
                        </tr>
                     </table>
                     <div class="row pt-1 mb-2">
                        <div class="col-md-6 align-self-center">
                           <c:if test="${order.orderState < 3 || order.orderState == 9}">
                              <button type="button" class="btn-default btn-cancel-order">판매취소</button>
                           </c:if>
                           <c:if test="${order.orderState >= 2 && order.orderState <= 5}">
                              <button type="button" class="btn-default btn-delivery-detail">배송지</button>
                           </c:if>
                        </div>   
                        <div class="col-md-6 align-self-center text-end">
                           <c:if test="${order.orderState == 1 || order.orderState == 9}">
                              <button type="button" class="btn-default btn-prepare-order">발송처리</button>
                           </c:if>
                        
                           <div class="row justify-content-end delivery-update-area">
                              <c:if test="${ (order.orderState > 1 && order.orderState < 5) }">
                                 <div class="col-auto">
                                    <select class="form-select delivery-select" style="width: 170px;">
                                       <option value="2" ${order.orderState==2?"selected":"" }>발송준비</option>
                                       <option value="3" ${order.orderState==3?"selected":"" }>배송시작</option>
                                       <option value="4" ${order.orderState==4?"selected":"" }>배송중</option>
                                       <option value="5" ${order.orderState==5?"selected":"" }>배송완료</option>
                                    </select>
                                 </div>
                                 <div class="col-auto">
                                    <button type="button" class="btn-default btn-delivery-order">배송변경</button>
                                 </div>
                              </c:if>
                              <c:if test="${order.orderState == 5}">
                                 <div class="col-auto">
                                    <label>배송완료 일자 : ${order.orderStateDate}</label>
                                 </div>
                              </c:if>
                           </div>
                        </div>
                     </div>                     
                  </div>
                  
                  <!-- 주문 상세정보 -->
                  <div class="mt-4 p-3 shadow bg-body rounded">
                     <p class="fs-6 fw-semibold mb-0">주문 상세 정보</p> 
                  </div>
                  <div class="mt-3 p-2">
                     <table class="table order-detail-list">
                        <thead class="table-light">
                           <tr align="center" class="border-top">
                              <th width="75">상세번호</th>
                              <th>상품명</th>
                              <th width="100">상품가격</th>
                              <th width="100">주문총금액</th>
                              <th width="120">주문상태</th>
                              <th width="60">변경</th>
                           </tr>
                        </thead>
                        <tbody>
                           <c:forEach var="dto" items="${listDetail}" varStatus="status">
                              <tr valign="middle" id="orderDetail-list${dto.gongguOrderDetailId}">
                                 <td align="center">${dto.gongguOrderDetailId}</td>
                                 <td class="text-start 
								  <c:if test="${dto.detailState==3 || dto.detailState==5}">text-line</c:if>">
								    ${dto.gongguProductName}
								</td>
                                 <td align="center" class="${dto.detailState==3||dto.detailState==5?'text-line':''}"><fmt:formatNumber value="${dto.price}"/></td>
                                 <td align="center" class="${dto.detailState==3||dto.detailState==5?'text-line':''}"><fmt:formatNumber value="${dto.productMoney}"/></td>
                                 <td align="center">
                                    ${(order.orderState==1||order.orderState==7||order.orderState==9) && dto.detailState==0?"상품준비중":dto.detailStateInfo}
                                 </td>
                                 <td align="center">
                                    <span class="orderDetailStatus-update" 
                                          data-orderId="${order.orderId}" 
                                          data-orderState="${order.orderState}"
                                          data-memberId="${order.memberId}"
                                          data-payment="${order.payment}"
                                          data-orderDate="${order.orderDate}"
                                          data-productMoney="${dto.productMoney}"
                                          gongguOrderDetailId="${dto.gongguOrderDetailId}"
                                          gongguProductId="${dto.gongguProductId}"
                                          data-detailState="${dto.detailState}">수정</span>
                                 </td>
                              </tr>
                           </c:forEach>
                        </tbody>
                     </table>
                  </div>

                  <div class="row pt-1 px-2 mb-2">
                     <div class="col-md-6 align-self-center">
                        <button type="button" class="btn-default" ${empty orderPrev.orderId ? 'disabled' :''} onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}/${orderPrev.orderId}?${query}';">이전주문</button>
                        <button type="button" class="btn-default" ${empty orderNext.orderId ? 'disabled' :''} onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}/${orderNext.orderId}?${query}';">다음주문</button>
                     </div>   
                     <div class="col-md-6 align-self-center text-end">
                        <button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}?${query}';">리스트</button>
                     </div>
                  </div>

               </div>
            </div>
         </div>
      </div>
   </div>
   </div>
</main>

<!-- 주문상세정보-상태변경/상태확인 대화상자  -->
<div class="modal fade" id="orderDetailStateDialogModal" tabindex="-1" aria-labelledby="orderDetailStateDialogModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="orderDetailStateDialogModalLabel">주문상세정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body pt-1">
            <div class="mt-1 p-1">
               <div class="p-1"><p class="form-control-plaintext optionDetail-value"></p></div>
               <table class="table board-list">
                  <thead class="table-light">
                     <tr>
                        <td width="50">코드</td>
                        <td width="120">구분</td>
                        <td width="90">작성자</td>
                        <td width="150">날짜</td>
                        <td>설명</td>
                     </tr>
                  </thead>
                  <tbody class="detailState-list"></tbody>   
               </table>
            </div>
            
            <div class="p-1 detailStateUpdate-form">
               <form name="detailStateForm" class="row justify-content-center">
                  <div class="col-auto p-1">
                        <select name="detailState" class="form-select" style="width: 170px;"></select>
                     </div>
                  <div class="col-8 p-1">
                     <input type="text" name="stateMemo" class="form-control" placeholder="상태 메시지 입력">
                  </div>
                  <div class="col-auto p-1">
                     <input type="hidden" name="orderId">
                     <input type="hidden" name="gongguOrderDetailId">
                     <input type="hidden" name="gongguProductId">
                     <input type="hidden" name="payment">
                     <input type="hidden" name="memberId">
                     <input type="hidden" name="orderDate">
                     <input type="hidden" name="qty">
                     <input type="hidden" name="productMoney">
                     <input type="hidden" name="cancelAmount">
                     
                     <button type="button" class="btn-default btnDetailStateUpdateOk"> 변경 </button>
                  </div>
               </form>
            </div>
            
         </div>
      </div>
   </div>
</div>

<!-- 발송처리 대화상자 -->
<div class="modal fade" id="prepareDialogModal" tabindex="-1" aria-labelledby="prepareDialogModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" style="max-width: 600px;">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="prepareDialogModalLabel">발송처리</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body pt-1">
            <div class="row">
               <div class="col">
                  <p class="form-control-plaintext">
                     배송지 : (${delivery.zip}) ${delivery.addr1} ${delivery.addr2}
                  </p>
                  <p class="form-control-plaintext">
                     배송요청 : ${delivery.requestMemo}
                  </p>
               </div>
            </div>
            <form class="row text-center" name="invoiceNumberForm" method="post">
               <div class="col-auto p-1">
                  <select name="deliveryName" class="form-select" style="width: 170px;">
                     <c:forEach var="vo" items="${listDeliveryCompany}">
                        <option>${vo.DELIVERYNAME}</option>
                     </c:forEach>
                  </select>
               </div>
               <div class="col p-1">
                  <input name="invoiceNumber" type="text" class="form-control" placeholder="송장번호입력">
               </div>
               <div class="col-auto p-1">
                  <input type="hidden" name="orderId" value="${order.orderId}">
                  <input type="hidden" name="orderState" value="2">
                                 
                  <button type="button" class="btn-default btnInvoiceNumberOk">등록완료</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>

<!-- 배송지 대화상자 -->
<div class="modal fade" id="deliveryDialogModal" tabindex="-1" aria-labelledby="deliveryDialogModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" style="max-width: 700px;">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="deliveryDialogModalLabel">배송지 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body pt-3">
            <table class="table table-bordered">
               <tr valign="middle">
                  <th class="table-light text-center" width="100">주문번호</th>
                  <td width="250">
                     <p class="form-control-plaintext">${order.orderId}</p>
                  </td>
                  <th class="table-light text-center" width="100">주문자</th>
                  <td width="250">
                     <p class="form-control-plaintext">${order.name}</p>
                  </td>
               </tr>
               <tr valign="middle">
                  <th class="table-light text-center" width="100">구매상품</th>
                  <td colspan="3">
                     <c:forEach var="dto" items="${listDetail}" varStatus="status">
                        <c:if test="${dto.detailState < 3 || dto.detailState > 5 }">
                           <p class="form-control-plaintext">
                              ${dto.gongguProductName}
                           </p>                           
                        </c:if>
                     </c:forEach>
                  </td>
               </tr>
               <tr valign="middle">
                  <th class="table-light text-center">받는사람</th>
                  <td>
                     <p class="form-control-plaintext">${delivery.recipientName}</p>
                  </td>
                  <th class="table-light text-center">전화번호</th>
                  <td>
                     <p class="form-control-plaintext">${delivery.tel}</p>
                  </td>
               </tr>
               <tr valign="middle">
                  <th class="table-light text-center">주 소</th>
                  <td colspan="3">
                     <p class="form-control-plaintext">(${delivery.zip}) ${delivery.addr1} ${delivery.addr2}</p>
                  </td>
               </tr>
               <tr valign="middle">
                  <th class="table-light text-center">수령장소</th>
                  <td colspan="3">
                     <p class="form-control-plaintext">
                        ${delivery.pickup}, 
                        <c:if test="${empty delivery.passcode}">
                           ${delivery.accessInfo}
                        </c:if>
                        <c:if test="${not empty delivery.passcode}">
                           공동현관비밀번호 : ${delivery.passcode}
                        </c:if>
                     </p>
                  </td>
               </tr>
               <tr valign="middle">
                  <th class="table-light text-center">배송메모</th>
                  <td colspan="3">
                     <p class="form-control-plaintext">${delivery.requestMemo}</p>
                  </td>
               </tr>
            </table>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn-default btn-delivery-print">배송지 인쇄</button>
         </div>            
      </div>
   </div>
</div>

<script type="text/javascript">
// 발송처리 대화상자(송장번호 입력)
$(function(){
   $('.btn-prepare-order').on('click', function() {
      $('#prepareDialogModal').modal('show');
   });

   // 송장번호 등록
   $('.btnInvoiceNumberOk').click(function() {
      let requestCount = '${order.cancelRequestCount}';
      
      if(requestCount !== '0') {
         alert('주문취소를 처리한 후 발송처리가 가능합니다.');
         return false;
      }
      
      const f = document.invoiceNumberForm;
      if(! f.invoiceNumber.value.trim()) {
         alert('송장 번호를 입력하세요');
         return false;
      }
      
      let params = $('form[name=invoiceNumberForm]').serialize();
      let url = '${pageContext.request.contextPath}/admin/gongguOrder/invoiceNumber';
      
      const fn = function(data) {
         if(data.state === 'true') {
            $("#prepareDialogModal").modal("hide");
            
            let reloadUrl = '${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}?${query}';
            location.href = reloadUrl;
         } else {
            alert('발송처리가 실패 했습니다.');
         }
      };
      
      ajaxRequest(url, 'post', params, 'json', fn);
   });
});

// 배송 변경(배송중/배송완료)
$(function(){
   $('.btn-delivery-order').on('click', function() {
      const $EL = $(this);
      let orderId = '${order.orderId}';
      let preState = '${order.orderState}';
      
      let orderState = $EL.closest('.delivery-update-area').find('select').val();
      let orderStateInfo = $EL.closest('.delivery-update-area').find('select option:selected').text();
      
      if(preState >= orderState) {
         alert('배송 변경은 현 배송 단계보다 적거나 같을수 없습니다.');
         return false;
      }
      
      let params = 'orderId=' + orderId + '&orderState=' + orderState;
      let url = '${pageContext.request.contextPath}/admin/gongguOrder/delivery';

      const fn = function(data) {
         if(data.state === 'true') {
            
            let reloadUrl = '${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}?${query}';
            location.href = reloadUrl;
         }
      };
      
      ajaxRequest(url, 'post', params, 'json', fn);
   });
});

// 모든 구매 내역 판매 취소
$(function(){
   $('.btn-cancel-order').on('click', function(){
      let orderId = '${order.orderId}';
      
      if(confirm('모든 구매내역을 판매 취소 하시겠습니까 ? ')) {
         
      }
   });
});

// 주문상세 - 상태확인/변경
$(function(){
   $('.orderDetailStatus-update').on('click', function(){
      const $EL = $(this);
      
      const f = document.detailStateForm;
      f.reset();
      
      let orderId = $EL.attr('data-orderId');
      let orderState = $EL.attr('data-orderState');
      let detailState = $EL.attr('data-detailState');
      let productMoney = $EL.attr('data-productMoney');
      let cancelAmount = $('.order-cancelAmount').attr('data-cancelAmount');
      let payment = $EL.attr('data-payment');
      let memberId = $EL.attr('data-memberId');
      let orderDate = $EL.attr('data-orderDate');
      
      // 상품 상세 정보 -
      let gongguOrderDetailId = $EL.attr('data-gongguOrderDetailId');
      let gongguProductId = $EL.attr('data-gongguProductId');
      let qty = $EL.attr('data-qty');
      
      f.orderId.value = orderId;
      f.gongguOrderDetailId.value = gongguOrderDetailId;
      f.gongguProductId.value = gongguProductId;
      f.memberId.value = memberId;
      f.orderDate.value = orderDate;
      f.qty.value = qty;
      f.productMoney.value = productMoney;
      f.payment.value = payment;
      f.cancelAmount.value = cancelAmount;
      
      let pname = $(this).closest('tr').find('td').eq(1).text().trim();
      let opt = $(this).closest('tr').find('td').eq(4).text().trim();

      let $SELECT = $('form[name=detailStateForm] select[name=detailState]');
      $('form[name=detailStateForm] select[name=detailState] option').remove();
      
      if(orderState === '6' || orderState === '8' || orderState === '10') {
         // 주문상태-판매자전체판매취소,주문자전체주문취소,주문자전체반품취소
         $('.detailStateUpdate-form').hide();
      } else if(detailState==='1' || detailState==='2' || detailState==='3' || detailState==='12' ) {
         // 주문상세상태- 구매확정완료,자동구매확정,판매취소,반품완료
         // $SELECT.append('<option value="14">기타</option>');
         $('.detailStateUpdate-form').hide();
      } else if(detailState==='4') { // 주문상세상태-주문취소요청
         $SELECT.append('<option value="5">주문취소완료</option>');
      } else if(detailState==='6'){ // 주문상세상태-교환요청
         $SELECT.append('<option value="7">교환접수</option>');
         $SELECT.append('<option value="8">교환발송완료</option>');
         $SELECT.append('<option value="9">교환불가</option>');
      } else if(detailState==='7'){ // 주문상세상태-교환접수
         $SELECT.append('<option value="8">교환발송완료</option>');
         $SELECT.append('<option value="9">교환불가</option>');
      } else if(detailState==='10'){ // 주문상세상태-반품요청
         $SELECT.append('<option value="11">반품접수</option>');
         $SELECT.append('<option value="12">반품완료</option>');
         $SELECT.append('<option value="13">반품불가</option>');
      } else if(detailState==='11'){ // 주문상세상태-반품접수
         $SELECT.append('<option value="12">반품완료</option>');
         $SELECT.append('<option value="13">반품불가</option>');
      } else {
          // 배송완료
         if(orderState==="5") {
            $SELECT.append('<option value="2">자동구매확정</option>');
         } else {
            $SELECT.append('<option value="3">판매취소</option>');
         }
         $SELECT.append('<option value="14">기타</option>');
      }
      
      $('.optionDetail-value').text(pname + '(' + opt + ')');
      
      $('#orderDetailStateDialogModal').modal('show');
   });
   
   function listDetailState() {
      $('.detailState-list').empty();
      
      const f = document.detailStateForm;
      let gongguOrderDetailId = f.gongguOrderDetailId.value;
      
      let params = 'gongguOrderDetailId=' + gongguOrderDetailId;
      let url = '${pageContext.request.contextPath}/admin/gongguOrder/listDetailState';

      const fn = function(data) {
         let out = '';
         for(let item of data.list) {
            out += '<tr>';
            out += '  <td>' + item.DETAILSTATE + '</td>';
            out += '  <td>' + item.DETALSTATEINFO + '</td>';
            out += '  <td>' + item.NAME + '</td>';
            out += '  <td>' + item.DETAILSTATEDATE + '</td>';
            out += '  <td align="left">' + item.STATEMEMO + '</td>';
            out += '</tr>';
         }
         if(out) {
            $('.detailState-list').append(out);
         }
      };
      
      ajaxRequest(url, 'get', params, 'json', fn);
   }
   
   const orderDetailStateModalEl = document.getElementById('orderDetailStateDialogModal');
   orderDetailStateModalEl.addEventListener('show.bs.modal', function(){
      // 모달 대화상자가 보일때
      listDetailState();
   });
   
   orderDetailStateModalEl.addEventListener('hidden.bs.modal', function(){
      // 모달 대화상자가 안보일때
   });
   
   $('.btnDetailStateUpdateOk').click(function(){
      // 주문상세 상태정보변경 등록
      const f = document.detailStateForm;
      let gongguOrderDetailId = f.gongguOrderDetailId.value;
      let productMoney = f.productMoney.value;
      let cancelAmount = f.cancelAmount.value;
      
      // 이전상태 : 판매취소(관리자), 주문취소완료(관리자), 반품완료(관리자)
      let preDetailState = $('#orderDetail-list' + gongguOrderDetailId).find('td').eq(9).find('span').attr('data-detailState');
      if(preDetailState === '3' || preDetailState === '5' || preDetailState === '12') {
         alert('판매취소 또는 반품완료 상품은 변경이 불가능합니다.');
         return false;
      }

      let changeStateInfo = $('form[name=detailStateForm] select option:selected').text();
      
      if(! f.stateMemo.value.trim()) {
         alert('상태 메시지를 등록하세요');
         f.stateMemo.focus();
         return false;
      }
      
      let params = $('form[name=detailStateForm]').serialize();
      let url = '${pageContext.request.contextPath}/admin/gongguOrder/updateDetailState';

      const fn = function(data) {
         if(data.state === 'true') {
            let detailState = Number(data.detailState);
            
            // 주문취소완료인 경우
            if(detailState === 3 || detailState === 5 || detailState === 12) {
               /*
               cancelAmount = parseInt(cancelAmount) + parseInt(productMoney);
               $('.order-cancelAmount').attr('data-cancelAmount', cancelAmount);
               $('.order-cancelAmount').text(cancelAmount.toLocaleString());
               */
               
               let reloadUrl = '${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}?${query}';
               location.href = reloadUrl;
               return;
            }
            
            listDetailState();
            
            $('#orderDetail-list' + gongguOrderDetailId).find('td').eq(8).html(changeStateInfo);
            $('#orderDetail-list' + gongguOrderDetailId).find('td').eq(9).find('span').attr('data-detailState', detailState);
            
            alert('주문 정보가 변경되었습니다.');
            
            f.reset();
         }
      };
      
      ajaxRequest(url, 'post', params, 'json', fn);
   });
});

$(function(){
   $('.btn-delivery-detail').click(function(){
      $('#deliveryDialogModal').modal('show');
   });
});
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