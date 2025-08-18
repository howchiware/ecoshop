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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
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
												<select name="schType" id="schType">
											        <option value="all">전체</option>
											        <option value="productName">상품명</option>
											        <option value="productCode">상품코드</option>
											    </select>
											    <input type="text" name="kwd" id="kwd">
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">카테고리</td>
											<td class="select-area">
												<select name="categoryId" id="categoryId">
											        <option value="0">전체</option>													
													<c:forEach var="vo" items="${listCategory}">
												        <option value="${vo.categoryId}">${vo.categoryName}</option>													
													</c:forEach>
											    </select>
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">기간 검색</td>
											<td class="select-area">
												<select name="period" id="period">
											        <option value="reg_date">최초등록일</option>
											        <option value="update_date">최근수정일</option>
											    </select>
											    <input type="date" name="periodStart" id="periodStart"> ~ 
											    <input type="date" name="periodEnd" id="periodEnd">
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
											    <input type="number" name="priceLowest" id="priceLowest"> 원 이상 ~ 
											    <input type="number" name="priceHighest" id="priceHighest"> 원 이하
											</td>
										</tr>
										<tr>
											<td class="select-title-area" width="10%">재고 수량 범위</td>
											<td class="select-area" width="160">
											    <input type="number" name="stockLowest" id="stockLowest"> 개 이상 ~ 
											    <input type="number" name="stockHighest" id="stockHighest"> 개 이하
											</td>
										</tr>
									</table>
	
									<div class="btn-area">
										<button class="btn-accent searchBtn" type="button">조회</button>
										<button class="btn-accent" type="reset">초기화</button>
										
										<input type="hidden" name="size" value="${size}">
										<input type="hidden" name="categoryId" value="${categoryId}">
										<input type="hidden" name="schType" value="${schType}">
										<input type="hidden" name="kwd" value="${kwd}">
										<input type="hidden" name="period" value="${period}">
										<input type="hidden" name="periodStart" value="${periodStart}">
										<input type="hidden" name="periodEnd" value="${periodEnd}">
										<input type="hidden" name="priceLowest" value="${priceLowest}">
										<input type="hidden" name="priceHighest" value="${priceHighest}">
										<input type="hidden" name="stockLowest" value="${stockLowest}">
										<input type="hidden" name="stockHighest" value="${stockHighest}">
										
										<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<hr>

		<div class="productListTab">
			<c:import url="/WEB-INF/views/admin/products/productListTab.jsp"/>
		</div>
	</div>
</main>

<script type="text/javascript">
// 검색
/*
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
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	console.log(params);
	
	let url = '${pageContext.request.contextPath}/admin/products/listProduct';
	location.href = url + '?' + params;
}
*/

/*
window.addEventListener('DOMContentLoaded', () => {
	listAllProduct();
});

// 리스트
function listAllProduct() {
	let url = '${pageContext.request.contextPath}/admin/products/searchProduct';
	
	const fn = function(data) {
		$('.productListTab').html(data);
	};
	
	ajaxRequest(url, 'get', null, 'text', fn);
}


// 검색
/*
function searchList() {
	let url = '${pageContext.request.contextPath}/admin/products/searchProduct';
	
	const fn = function(data) {

		console.log(data);
		$('.productListTab').html(data);
	};
	
	ajaxRequest(url, 'get', null, 'text', fn);
}
*/

/*
// 검색
$(function(){
	$('.searchBtn').on('click', function(){
		/*
		const $div = $(this).closest('div').parent();
		
		let categoryName = $div.find('input[name=categoryName]').val().trim();
		let orderNo = $div.find('input[name=orderNo]').val().trim();
		
		if(! categoryName){
			$div.find('input[name=categoryName]').focus();
			return false;
		}
		
		if(! /^\d+$/.test(orderNo)) {
			$div.find('input[name=orderNo]').focus();
			return false;
		}

		let url = '${pageContext.request.contextPath}/admin/products/searchProduct';
		let params = {schType:schType, kwd:kwd, categoryId:categoryId, period:period, 
						periodStart:periodStart, periodEnd:periodEnd, priceLowest:priceLowest, 
						priceHighest:priceHighest, stockLowest:stockLowest, stockHighest:stockHighest};
		
		const fn = function(data){
			console.log(data);
			$('form[name=productManageSearch]')[0].reset();
			
			searchList();
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});
*/

window.addEventListener('DOMContentLoaded', () => {
	const buttonEL = document.querySelector('.searchBtn'); 
	buttonEL.addEventListener('click', function (evt) {
	    	searchList();
	    }
	});
});

function searchList() {
	const f = document.productManageSearch;
	/*
	if(! f.kwd.value.trim()) {
		return;
	}
	*/
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	console.log(params);
	
	let url = '${pageContext.request.contextPath}/products/listProduct';
	location.href = url + '?' + params;
}	
	
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

</body>
</html>