<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>전체상품리스트</title>
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
/*
.right-panel {
margin-left: 250px;
padding: 30px;
}
*/
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
			<h3>전체 상품 관리</h3>
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
								
								<form name="productManageSearch">
									<table class="table search-list">
										<tr>
											<td class="select-title-area" width="10%">검색어</td>
											<td class="select-area">
												<select name="schType1" id="schType1">
											        <option value="productName">상품명</option>
											        <option value="productCode">상품코드</option>
											    </select>
											    <input type="text" name="kwd1" id="kwd1">
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">카테고리</td>
											<td class="select-area">
												<select name="schType2" id="schType2">
											        <option value="food">식품</option>
											        <option value="bathroom">욕실</option>
											        <option value="kitchen">주방</option>
											        <option value="living">리빙</option>
											        <option value="etc">기타</option>
											    </select>
											    <input type="text" name="kwd2" id="kwd2">
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">기간 검색</td>
											<td class="select-area">
												<select name="schType3" id="schType3">
											        <option value="insertDate">최초등록일</option>
											        <option value="recentUpdateDate">최근수정일</option>
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
											<td class="select-title-area" width="10%">판매가 범위</td>
											<td class="select-area" width="160">
											    <input type="date" name="lowestPrice" id="lowestPrice"> 원 이상 ~ 
											    <input type="date" name="highestPrice" id="highestPrice"> 원 이하
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">재고 수량 범위</td>
											<td class="select-area" width="160">
											    <input type="date" name="lowestQty" id="lowestQty"> 개 이상 ~ 
											    <input type="date" name="highesQty" id="highesQty"> 개 이하
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
									<span class="small-title">전체</span> <span class="dataCount">${dataCount}건 조회</span>
								</div>	
								<div class="col-md-6 align-self-center text-end">
									<button type="button" class="addBtn">상품 등록</button>
								</div>
							</div>
							
							<form name="productManageForm" method="post">
							<div style="padding: 5px 0 5px; border-top:1px solid #dee2e6; margin: 0px; background: #fcfcfc">
								<button type="button" class="btn-default product-deleteCheck" onclick="deleteProductSelect();">선택삭제</button>
							</div>
							<table class="table product-list">
								<thead>
									<tr class="table-light border-top text-center">
										<th width="35" rowspan="2">
											<input type="checkbox" class="form-check-input product-chkAll" name="chkAll">
										</th>
										<th rowspan="2" width="70">상품 번호</th>
										<th rowspan="2" width="140">상품사진</th>
										<th width="70">카테고리</th>
										<th rowspan="2" width="100">상품코드</th>
										<th width="70">최초 등록일</th>
										<th rowspan="2" width="80">판매가</th>
										<th rowspan="2" width="55">재고 수량</th>
										<th rowspan="2" width="55">진열</th>
										<th rowspan="2" width="55">관리</th>
									</tr>
									<tr class="table-light border-top text-center">
										<th width="70">상품명</th>
										<th width="70">최근 수정일</th>
									</tr>
								</thead>
								<tbody>
								
										<tr class="text-center" valign="middle">
											<td rowspan="2">
												<input type="checkbox" class="form-check-input" name="nums" value="${dto.stockNum}" 
														data-totalStock="${dto.totalStock}" ${dto.totalStock == 0 ? "disabled":""}>
											</td>
											<td rowspan="2">10</td>
											<td rowspan="2" width="55">
												<img class="border rounded" width="50" height="50" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
											</td>
											<td>리빙</td>
											<td rowspan="2">123456</td>
											<td>2025-02-05</td>
											<td rowspan="2">10,000 원</td>
											<td rowspan="2">3</td>
											<td rowspan="2">표시</td>
											<td rowspan="2">
												<button type="button">재고</button>
												<button type="button">수정</button>
											</td>
										</tr>
										<tr>
											<td>
												수저세트
											</td>
											<td>
												2025-07-04
											</td>
										</tr>
										<tr>
											<td colspan="10" style="text-align: right; border-bottom: none;">
												<button type="button">선택상품삭제</button>
												<button type="button">전체상품삭제</button>
											</td>
										</tr>
								</tbody>
							</table>
						</form>
							
							<div class="page-navigation">
								${dataCount==0 ? "등록된 상품이 없습니다." : paging}
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
	
	let url = '${pageContext.request.contextPath}/admin/order/orderManage/${itemId}';
	location.href = url + '?' + params;
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>