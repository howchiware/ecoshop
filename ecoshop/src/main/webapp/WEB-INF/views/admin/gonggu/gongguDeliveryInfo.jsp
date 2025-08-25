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
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">

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

textarea[name=deliveryInfo], textarea[name=refundInfo] {
	resize: none;
	width: 700px;
	height: 150px;
}

.input-table td {
	padding: 20px;
}

.input-table td:first-child {
	padding: 20px;
	width: 150px;
}

.minus-deliveryFee {
	margin-left: 50px;
}

.minus-deliveryFee:hover, .minus-deliveryFee:active {
	cursor: pointer;
	
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
		<div class="title">
			<h3>배송 정책 및 배송비</h3>
		</div>
		
		<hr>
		
		<div class="outside">
			<form name="deliveryAllInfo" method="post">
				<div class="section ps-5 pe-5">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2">
								<div class="small-title">
									<h5>| 배송 정보</h5>
								</div>
								
								<div class="input-area">
									<table class="input-table">
										<tr>
											<td>배송 정보</td>
											<td>
												<textarea name="deliveryInfo" id="deliveryInfoContent">
													${listDeliveryRefundInfo.deliveryInfo}
												</textarea>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div class="section ps-5 pe-5">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2">
								<div class="small-title">
									<h5>| 환불 정보</h5>
								</div>
								
								<div class="input-area">
									<table class="input-table">
										<tr>
											<td>환불 안내</td>
											<td>
												<textarea name="refundInfo" id="refundInfoContent">
													${listDeliveryRefundInfo.refundInfo}
												</textarea>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				
				<div class="section ps-5 pe-5">
					<div>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 p-2 m-2">
								<div class="small-title">
									<h5>| 배송비</h5>
								</div>
								
								<div class="input-area">
									<table class="input-table">
										<tr>
											<td>배송비</td>
											<td colspan="2">
												<input type="text" id="deliveryFee"> 원
											</td>
										</tr>
										<tr>
											<td>배송 가능 지역</td>
											<td colspan="2">
												<select id="deliveryLocation" onclick="changeDeliveryArea();">
											        <option value="">:: 선택 ::</option>
													<c:forEach var="dto" items="${listDeliveryFee}">
												        <option value="${dto.deliveryLocation}">${dto.deliveryLocation}</option>
													</c:forEach>
										    	</select>
										    	<input id="deliveryAreaRs" readonly>
											</td>
										</tr>
										<tr>
											<td>배송 지역</td>
											<td>
												<input type="text" id="deliveryLocationAdd">
											</td>
											<td>
												<button type="button" class="locationAddBtn" onclick="locationAdd();">추가</button>
											</td>
										</tr>
										<tr>
											<td>
												<button type="button" class="feeAddBtn" onclick="feeAdd();">추가</button>
											</td>
										</tr>
									</table>
								</div>
								<hr>
								<div class="deliveryAreaResult" id="deliveryAreaResult">
									<div id="deliveryFee-div">
										<c:forEach var="dto" items="${listDeliveryFee}">	
											<p>
												<input class="border-none" name="deliveryLocation" value="${dto.deliveryLocation}">
												<span> | </span> 
												<input class="border-none" name="fee" value="${dto.fee}">
												<span class="minus-deliveryFee">X</span>
											</p>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div style="text-align: center" id="deliveryAllInfo-form">
						<c:if test="${mode == 'update' }">
							<button type="button" class="udBtn updateBtn">수정</button>
						</c:if>
						<button type="button" class="saveInfo" onclick="sendOk();">저장</button>
					</div>
					
				</div>
				
			</form>
		</div>
	</div>
</main>

<script type="text/javascript">
const divEl = document.getElementById('deliveryFee-div');
let cloneNode = divEl.cloneNode(true);

function changeDeliveryArea(){
	
	const deliveryLocationEl = document.getElementById('deliveryLocation');
	const deliveryAreaRsEl = document.getElementById('deliveryAreaRs');
	
	if( ! deliveryLocationEl.value ){
		deliveryLocationEl.value = '';
		deliveryAreaRsEl.value = '';
		deliveryAreaRsEl.setAttribute('readonly', 'readonly');
	} else if(deliveryLocationEl.value !== 'direct'){
		deliveryAreaRsEl.value = deliveryLocationEl.value;
		deliveryAreaRsEl.setAttribute('readonly', 'readonly');
		deliveryLocationEl.focus();
	} else {
		deliveryAreaRsEl.value = '';
		deliveryAreaRsEl.setAttribute('readonly', false);
		deliveryLocationEl.focus();
	}
}

$(function(){
	let mode = '${mode}';
	
	if(mode === 'update') {
		// 수정인 경우
		$('#deliveryInfoContent').prop('readonly', 'readonly');
		$('#refundInfoContent').prop('readonly', 'readonly');
		$('#deliveryLocation').prop('readonly', 'readonly');
		$('#deliveryLocationAdd').prop('readonly', 'readonly');
		$('#deliveryFee').prop('readonly', 'readonly');
		$('.minus-deliveryFee').removeClass('minus-deliveryFee-enabled');
	}
});

$(function(){
	   $('#deliveryAllInfo-form').on('click', '.udBtn', function(){
	      if($(this).hasClass('updateBtn')){
	         $('#deliveryInfoContent').removeAttr('readonly');
	         $('#refundInfoContent').removeAttr('readonly');
	         $('#deliveryLocation').removeAttr('readonly');
	         $('#deliveryLocationAdd').removeAttr('readonly');
	         $('#deliveryFee').removeAttr('readonly');
	         $('.minus-deliveryFee').addClass('minus-deliveryFee-enabled');
	         
	         $('.udBtn').html('수정취소');
	         $('.udBtn').addClass('updateCancelBtn');
	         $('.udBtn').removeClass('updateBtn');
	         
	      } else if($(this).hasClass('updateCancelBtn')){
	         /*
	         $('#deliveryInfoContent').prop('readonly', 'readonly');
	         $('#refundInfoContent').prop('readonly', 'readonly');
	         $('#deliveryLocation').prop('readonly', 'readonly');
	         $('#deliveryLocationAdd').prop('readonly', 'readonly');
	         $('#deliveryFee').prop('readonly', 'readonly');
	         
	         $('.minus-deliveryFee').removeClass('minus-deliveryFee-enabled');
	         
	         $('.udBtn').html('수정');
	         $('.udBtn').addClass('updateBtn');
	         $('.udBtn').removeClass('updateCancelBtn');
	         
	         $('textarea[name="deliveryInfoContent"]').val(deliveryInfoValue);
	         $('textarea[name="refundInfoContent"]').val(refundInfoValue);
	         $('#outerDeliveryFee').html(cloneEl);
	         */
	         location.href= '${pageContext.request.contextPath}/admin/products/deliveryWrite';
	      }
	   });
	});

// 지역 옵션 추가
function locationAdd(){
	const deliveryAreaEl = document.getElementById('deliveryLocation');
	const textEl = document.getElementById('deliveryLocationAdd');
	const locationText = textEl.value.trim();
	
	if(! locationText){
		textEl.focus();
		return false;
	}
	
	let optionTag = document.createElement("option");
	optionTag.textContent = locationText;
	deliveryAreaEl.appendChild(optionTag);

	textEl.value = '';	
}

function feeAdd(){
	const feeEl = document.getElementById('deliveryFee');
	const locationEl = document.getElementById('deliveryLocation');
	const locationRsEl = document.getElementById('deliveryAreaRs');
	const deliveryAreaResultEl = document.getElementById('deliveryAreaResult');
	
	if(! feeEl.value.trim()){
		feeEl.focus();
		return false;
	}
	
	if(! locationRsEl.value.trim()){
		alert('배송 지역 옵션을 선택해주세요.');
		return false;
	}
	
	locationText = locationEl.value.trim();
	fee = feeEl.value.trim();
	
	let pTag = document.createElement("p");
	let locationInputTag = document.createElement("input");
	locationInputTag.classList.add('border-none');
	locationInputTag.setAttribute('name', 'deliveryLocation');
	locationInputTag.setAttribute('readonly', 'readonly');
	locationInputTag.value = locationText;
	
	let feeInputTag = document.createElement("input");
	feeInputTag.classList.add('border-none');
	feeInputTag.setAttribute('name', 'fee');
	feeInputTag.setAttribute('readonly', 'readonly');
	feeInputTag.value = fee;
	
	let spanTag = document.createElement("span");
	spanTag.innerText = ' | ';

	let minusSpanTag = document.createElement("span");
	minusSpanTag.innerText = ' X ';
	minusSpanTag.classList.add('minus-deliveryFee');

	pTag.appendChild(locationInputTag);
	pTag.appendChild(spanTag);
	pTag.appendChild(feeInputTag);
	pTag.appendChild(minusSpanTag);

	// pTag.innerHtml = locationSpanTag + ' | ' + feeSpanTag + '원';

	deliveryAreaResultEl.appendChild(pTag);
	feeEl.value = '';

}

function sendOk(){
	const deliveryInfoEl = document.getElementById('deliveryInfoContent');
	const refundInfoEl = document.getElementById('refundInfoContent');
	const deliveryAreaEl = document.getElementById('deliveryAreaResult');
	
	if(! deliveryInfoEl.value.trim()){
		deliveryInfoEl.focus();
		return;
	}
	
	if(! refundInfoEl.value.trim()){
		refundInfoEl.focus();
		return;
	}

	if(! deliveryAreaEl.innerHTML.trim()){
		alert('배송비 정보를 입력해주세요.');
		return false;
	}

	let mode = '${mode}';
	let url = '${pageContext.request.contextPath}/admin/gonggu/';
	if(mode === 'write'){
		url += 'deliveryWrite';
	} else if(mode === 'update'){
		url += 'deliveryUpdate';
	}
	
	const f = document.deliveryAllInfo;
	f.action = url;
	f.submit();
}


$(function(){	
	$('.deliveryAreaResult').on('click', '.minus-deliveryFee-enabled', function(){
		let $el = $(this).closest('p');
		
		$el.remove();
	});
});

</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>