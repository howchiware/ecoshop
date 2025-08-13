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

.right-panel {
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

textarea[name=deliveryInfoContent], textarea[name=refundInfoContent] {
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

</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>

	<div class="right-panel">
		<div class="title">
			<h3>배송 정책 및 배송비</h3>
		</div>
		
		<hr>
		
		<div class="outside">
			<form name="deliveryAllInfo">
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
												<textarea name="deliveryInfoContent">
ex) 
- 모든 제품 배송은 종이재질로 발송됩니다.       
- 수령하신 택배박스는 운송장을 제거한 후 종이로 분리배출해주세요.
- 결제완료 후 제품을 수령하시기까지 약 2~5일 소요됩니다.      
- 배송이 늦어지거나 일부 제품이 품절인 경우 개별적으로 연락을 드리겠습니다.
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
												<textarea name="refundInfoContent">
ex) 
- 공동구매 상품은 교환 및 환불이 불가합니다.
- 상품에 문제가 있을경우 문의를 남겨주시기 바랍니다.
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
												<input type="text" name="deliveryFee"> 원
											</td>
										</tr>
										<tr>
											<td>배송 가능 지역</td>
											<td colspan="2">
												<select name="deliveryArea" id="deliveryArea" onclick="changeDeliveryArea();">
											        <option value="전국">전국</option>
											        <option value="도서산간지역">도서산간지역</option>
											        <option value="direct">직접 입력</option>
										    	</select>
										    	<input name="deliveryAreaRs" id="deliveryAreaRs" readonly>
											</td>
										</tr>
										<tr>
											<td>추가 설명</td>
											<td>
												<input type="text" name="deliveryDetailInfo">
											</td>
											<td>
												<button type="button" class="addBtn">추가</button>
											</td>
										</tr>
									</table>
								</div>
								<hr>
								<div class="deliveryAreaResult"></div>
							</div>
						</div>
					</div>
					
					<div style="text-align: center">
						<button type="button" class="saveInfo">저장</button>
					</div>
					
				</div>
				
			</form>
		</div>
	</div>
</main>

<script type="text/javascript">
function changeDeliveryArea(){
	const f = document.deliveryAllInfo;
	let s = f.deliveryArea.value;
	
	if( !s ){
		f.deliveryArea.value = '';
		f.deliveryAreaRs.value = '';
		f.deliveryAreaRs.readOnly = true;
	} else if(s !== 'direct'){
		f.deliveryAreaRs.value = s;
		f.deliveryAreaRs.readOnly = true;
		f.deliveryArea.focus();
	} else {
		f.deliveryAreaRs.value = '';
		f.deliveryAreaRs.readOnly = false;
		f.deliveryArea.focus();
	}
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>