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

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>

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

#productStockDialogModal {
	z-index: 10000;
}

.main-container {
	z-index: 100;
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
										<button class="btn-accent" type="button" onclick="searchList();">조회</button>
										<button class="btn-accent" type="reset">초기화</button>
										<!-- 
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
										 -->
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
									<button type="button" class="addBtn" onclick="location.href='${pageContext.request.contextPath}/admin/products/write';">상품 등록</button>
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
										<th rowspan="2" width="30">상품코드</th>
										<th rowspan="2" width="70">상품사진</th>
										<th width="80">카테고리</th>
										<th width="80">최초 등록일</th>
										<th rowspan="2" width="70">판매가</th>
										<th rowspan="2" width="50">재고 수량</th>
										<th rowspan="2" width="50">진열</th>
										<th rowspan="2" width="70">관리</th>
									</tr>
									<tr class="table-light border-top text-center">
										<th width="80">상품명</th>
										<th width="80">최근 수정일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dto" items="${listProduct}">
										<tr class="text-center" valign="middle">
											<td rowspan="2">
												<input type="checkbox" class="form-check-input" name="nums" data-productId="${dto.productId}" value="${dto.productId}" 
														data-totalStock="${dto.totalStock}" ${dto.totalStock == 0 ? "disabled":""}>
											</td>
											<td rowspan="2">${dto.productCode}</td>
											<td rowspan="2" width="55">
												<img class="border rounded" width="50" height="50" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
											</td>
											<td>${dto.categoryName}</td>
											<td>${dto.reg_date}</td>
											<td rowspan="2">${dto.price} 원</td>
											<td rowspan="2">2</td>
											<td rowspan="2">
												<c:if test="${dto.productShow == 1}">
													표시
												</c:if>
												<c:if test="${dto.productShow == 0}">
													숨김
												</c:if>
											</td>
											<td rowspan="2">
												<c:url var="updateUrl" value="/admin/products/update">
													<c:param name="productId" value="${dto.productId}"/>
													<c:param name="productCode" value="${dto.productCode}"/>
													<c:param name="categoryId" value="${categoryId}"/>
													<c:param name="page" value="${page}"/>
												</c:url>
												<button type="button" class="btn-productStock" data-productId="${dto.productId}" data-productCode="${dto.productCode}" data-optionCount="${dto.optionCount}">재고</button>
												<button type="button" onclick="location.href='${updateUrl}';">수정</button>
											</td>
										</tr>
										<tr>
											<td>
												${dto.productName}
											</td>
											<td>
												${dto.update_date}
											</td>
										</tr>
									</c:forEach>
									<!-- 
									<tr>
										<td colspan="10" style="text-align: right; border-bottom: none;">
											<button type="button" onclick="deleteProductSelect();">선택상품삭제</button>
											<button type="button">전체상품삭제</button>
										</td>
									</tr>
									 -->
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

<!-- 재고 관리 대화상자  -->
<div class="modal fade" id="productStockDialogModal" tab-index="-1" aria-labelledby="productStockDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="productStockDialogModalLabel">재고관리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<div class="modal-productStock"></div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

// 검색
function searchList() {
	const f = document.productManageSearch;
	
	if(! f.kwd.value){
		f.kwd.focus();
		return;
	}
	
	if(! f.periodStart.value){
		f.periodStart.focus();
		return;
	}
	
	if(! f.periodEnd.value){
		f.periodEnd.focus();
		return;
	}
	
	if(! f.priceLowest.value){
		f.priceLowest.focus();
		return;
	}
	
	if(! f.priceHighest.value){
		f.priceHighest.focus();
		return;
	}
	
	if(! f.stockLowest.value){
		f.stockLowest.focus();
		return;
	}
	
	if(! f.stockHighest.value){
		f.stockHighest.focus();
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	console.log(params);
	let url = '${pageContext.request.contextPath}/admin/products/listProduct';
	location.href = url + '?' + params;
}

$(function(){	
	// 재고 관리 대화상자
	$('.btn-productStock').click(function(){
		let productId = $(this).attr('data-productId');
		let productCode = $(this).attr('data-productCode');
		let optionCount = $(this).attr('data-optionCount');
		let url = '${pageContext.request.contextPath}/admin/products/listProductStock?productId=' + productId + '&productCode=' + productCode + '&optionCount=' + optionCount;
		
		$('.modal-productStock').load(url);
		
		$('#productStockDialogModal').modal('show');
	});
	
	// 재고 일괄 변경
	$('.modal-productStock').on('click', '.btn-allStockUpdate', function(){
		if(! confirm('재고를 일괄 변경 하시겠습니까 ? ')) {
			return false;
		}
		
		let productId = $(this).attr('data-productId');
		let productCode = $(this).attr('data-productCode');
		let optionCount = $(this).attr('data-optionCount');
		let url = '${pageContext.request.contextPath}/admin/products/updateProductStock';
		let formData = 'productId=' + productId +'&productCode=' + productCode;
		
		let isValid = true;
		$('.productStcok-list tr').each(function(){
			let $input = $(this).find('input[name=totalStock]');
			let $btn = $(this).find('.btn-stockUpdate');
			
			if(!/^\d+$/.test($input.val())) {
				alert('재고량은 숫자만 가능합니다.');
				$input.focus();
				isValid = false;
				return false;
			}
			
			let stockNum = $btn.attr('data-stockNum');
			let optionDetailNum = $btn.attr('data-optionDetailNum');
			optionDetailNum = optionDetailNum ? optionDetailNum : 0;
			let optionDetailNum2 = $btn.attr('data-optionDetailNum2');
			optionDetailNum2 = optionDetailNum2 ? optionDetailNum2 : 0;
			let totalStock = $input.val().trim();
			
			formData += '&stockNums=' + stockNum;
			formData += '&optionDetailNums=' + optionDetailNum;
			formData += '&optionDetailNums2=' + optionDetailNum2;
			formData += '&totalStocks=' + totalStock;
		});
		
		if( ! isValid ) {
			return false;
		}
		
		const fn = function(data) {
			if(data.state === 'true') {
				alert('재고가 일괄 변경 되었습니다.');
			} else {
				alert('재고 일괄 변경이 실패 했습니다.');
			}
			

			let url = '${pageContext.request.contextPath}/admin/products/listProductStock?productId=' + productId + '&productCode=' + productCode + '&optionCount=' + optionCount;
			
			$('.modal-productStock').load(url);
			
			$('#productStockDialogModal').modal('show');
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn);
	});
	
	// 재고 변경	
	$('.modal-productStock').on('click', '.btn-stockUpdate', function(){
		let productId = $(this).attr('data-productId');
		let productCode = $(this).attr('data-productCode');
		let stockNum = $(this).attr('data-stockNum');
		let optionDetailNum = $(this).attr('data-optionDetailNum');
		optionDetailNum = optionDetailNum ? optionDetailNum : 0;
		let optionDetailNum2 = $(this).attr('data-optionDetailNum2');
		optionDetailNum2 = optionDetailNum2 ? optionDetailNum2 : 0;
		let totalStock = $(this).closest('tr').find('input[name=totalStock]').val();
		
		if(!/^\d+$/.test(totalStock)) {
			alert('재고량은 숫자만 가능합니다.');
			$(this).closest('tr').find('input[name=totalStock]').focus();
			return false;
		}
	
		let url = '${pageContext.request.contextPath}/admin/products/updateProductStock';
		let formData = {productId:productId, productCode:productCode, stockNums:stockNum, optionDetailNums:optionDetailNum, 
				optionDetailNums2:optionDetailNum2, totalStocks:totalStock};
		
		const fn = function(data) {
			if(data.state === 'true') {
				alert('재고가 변경 되었습니다.');
			} else {
				alert('재고 변경이 실패 했습니다.');
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn);
	});
});

const productStockModalEl = document.getElementById('productStockDialogModal');
productStockModalEl.addEventListener('show.bs.modal', function(){
	// 모달 대화상자가 보일때
});

productStockModalEl.addEventListener('hidden.bs.modal', function(){
	// 모달 대화상자가 안보일때
});

</script>

<script type="text/javascript">
// 상품 삭제
$(function(){
	let listSize = Number('${listProduct.size()}') || 0;
	console.log(listSize);
	if(listSize !== 0) {
		$('.product-chkAll').prop('checked', false);
		$('form input[name=nums]').prop('checked', false);
	}
	
    $('.product-chkAll').click(function() {
    	$('form input[name=nums]').prop('checked', $(this).is(':checked'));
    });
    
    $('form input[name=nums]').click(function() {
		$(".product-chkAll").prop("checked", $("form input[name=nums]").length === $("form input[name=nums]:checked").length);
   });
});

function deleteProductSelect() {
	// 선택된 항목 삭제
	let cnt = $('form input[name=nums]:checked').length;
    if (cnt === 0) {
		alert('삭제할 상품을 먼저 선택 하세요.');
		return;
    }
    
	if(! confirm('선택한 상품을 삭제하시겠습니까 ? ')) {
		return;
	}
	
	const f = document.productManageForm;
	f.action = '${pageContext.request.contextPath}/admin/products/deleteProductSelect;';
	f.submit();
}

</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

</body>
</html>