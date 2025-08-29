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
			<h3>주문 상태 관리</h3>
		</div>
		
		<hr>
		
		<div class="outside">
			<div class="section ps-5 pe-5">
				<div>
					<div class="row gy-4 m-0">
						<div class="col-lg-12 p-2 m-2">
							<div class="search-area row mb-2">
								<div class="col-md-6 align-self-center">
									<p class="small-title">기본 검색</p>
								</div>
								
								<form name="orderManageSearch">
									<table class="table search-list">
										<tr>
											<td class="select-title-area" width="10%">검색어</td>
											<td class="select-area">
												<select name="schType" id="schType">
											        <option value="all">전체</option>
											        <option value="orderId">주문번호</option>
											        <option value="orderName">주문자</option>
											        <c:if test="${itemId==110}">
														<option value="invoiceNumber" ${schType=="invoiceNumber"?"selected":""}>송장번호</option>
													</c:if>
											    </select>
											    <input type="text" name="kwd1" id="kwd1">
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">기간 검색</td>
											<td class="select-area">
												<select name="period" id="period">
											        <option value="orderDate">주문일</option>
											        <option value="cancelDate">취소일</option>
											    </select>
											    <input type="date" name="startDate" id="startDate"> ~ 
											    <input type="date" name="endDate" id="endDate">
											    <button type="button" name="today" class="dateBtn today">오늘</button>
											    <button type="button" name="yesterday" class="dateBtn yesterday">어제</button>
											    <button type="button" name="week" class="dateBtn week">일주일</button>
											    <button type="button" name="oneMonth" class="dateBtn oneMonth">1개월</button>
											    <button type="button" name="threeMonths" class="dateBtn threeMonths">3개월</button>
											    <button type="button" name="total" class="dateBtn total">전체</button>
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">주문 상태</td>
											<td class="select-area" width="160">
											    <input type="radio" id="all" name="orderStatus" value="all" checked/>
											    <label for="all">전체</label>
											    <input type="radio" id="payComplete" name="orderStatus" value="payComplete" />
											    <label for="payComplete">결제완료</label>
											    <input type="radio" id="send" name="orderStatus" value="send" />
											    <label for="send">발송처리</label>
											    <input type="radio" id="deliver" name="orderStatus" value="deliver" />
											    <label for="deliver">배송중</label>
											    <input type="radio" id="complete" name="orderStatus" value="complete" />
											    <label for="complete">배송완료</label>
											</td>
										</tr>
									</table>
	
									<div class="btn-area">
										<button class="btn-accent" type="button">조회</button>
										<button class="btn-accent" type="reset">초기화</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<hr>

		<div class="outside">
			<div class="section ps-5 pe-5" data-aos="fade-up" data-aos-delay="200" style="padding-top:0px">
				<div>
					<div class="row gy-4 m-0">
						<div class="col-lg-12 p-2 m-2" data-aos="fade-up" data-aos-delay="200">
							
							<div class="row mb-2">
								<div class="col-md-6 align-self-center">
									<span class="small-title">전체</span> <span class="dataCount">${dataCount}건 조회</span><span class="totalOrderMoney"> | 총 주문액: 3000원</span>
								</div>	
								<div class="col-md-6 align-self-center text-end">
								</div>
							</div>
							
							<table class="table board-list table-hover">
								<thead>
									<tr>
										<th>주문번호</th>
										<th width="130">주문구분</th>
										<th width="95">주문자</th>
										<th width="160">송장번호</th>
										<th width="130">총주문금액</th>
										<th width="150">주문일자</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr class="hover-cursor" 
												onclick="location.href='${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}/${dto.orderNum}?${query}';">
											<td>${dto.orderId}</td>
											<td>${dto.orderStateInfo}</td>
											<td>${dto.name}</td>
											<c:if test="itemId=110">
												<td>${dto.invoiceNumber}</td>
											</c:if>
											<td><fmt:formatNumber value="${dto.payment}"/></td>
											<td>${dto.orderDate}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="page-navigation">
								${dataCount==0 ? "등록된 주문정보가 없습니다." : paging}
							</div>
	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 검색
window.addEventListener('load', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	f.kwd.value = f.kwd.value.trim();
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/gongguOrder/orderManage/${itemId}';
	location.href = url + '?' + params;
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>