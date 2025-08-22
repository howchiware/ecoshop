<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 등록/수정</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/paginate.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css_gonggu/article.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>
	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
			<div class="title">
				<h3>패키지 상세(패키지 구성)</h3>
			</div>
			<hr>
			<div class="outside">
				<div class="card-box mb-4"
					style="max-width: 80%; background: #F2F2F2; margin: 0 auto;">
					<div class="row g-0 cardContainer">
						<div class="col-md-4 image-box">
							<img
								src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}"
								alt="...">
						</div>
						<div class="col-md-6">
							<div class="cardBody">
								<h5 class="cardTitle">${dto.gongguProductName}</h5>
								<p class="cardText">기간 : ${dto.startDate} - ${dto.endDate}</p>
								<p class="cardText">내용 : ${dto.content}</p>
								<p class="cardText">
									<small class="text-body-secondary">등록일 : ${dto.regDate}</small>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row mb-2">
					<div class="col">
						<button type="button" class="btn-default"
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/update?gongguProductId=${dto.gongguProductId}&page=${page}';">수정</button>
						<button type="button" class="btn-default btn-gongguDelete"
							onclick="deleteOk();">삭제</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn-default"
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/listProduct?${query}';">리스트</button>
					</div>
					<hr>
					<div class="row packageList-container">
						<div class="col-md-4">패키지 상품구성</div>
						<div class="btn col-md-4 offset-md-4">
							<button type="button" class="btn-default btn-append">상품등록</button>
						</div>
						<table class="table table-hover board-list">
							<thead>
								<tr>
									<th width="110">상품코드</th>
									<th>상품명</th>
									<th width="110">가격</th>
									<th width="80">변경</th>
								</tr>
							</thead>
							<tbody class="product-list">
								<c:forEach var="vo" items="${productList}">
									<tr>
										<td data-productCode="${vo.productCode}">${vo.productCode}</td>
										<td class="left" data-productName="${vo.productName}">${vo.productName}</td>
										<td data-price="${vo.price}">${vo.price}</td>										
										<td>
											<button type="button" class="btn-default btn-sm btn-delete" title="삭제" data-packageNum="${vo.packageNum}">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>					
						</table>
						
						<div class="page-navigation">
							${dataCount == 0 ? "등록된 정보가 없습니다." : paging}
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</main>
	<script type="text/javascript">
		function deleteOk() {
			let params = 'gongguProductId=${dto.gongguProductId}&${query}&gongguThumbnail=${dto.gongguThumbnail}';
			let url = '${pageContext.request.contextPath}/admin/gonggu/delete?'
					+ params;
			if (confirm('위 자료를 삭제 하시 겠습니까 ? ')) {
				location.href = url;
			}
		}
	</script>
	<script type="text/javascript">
	window.addEventListener('load', () => {
		const inputEL = document.querySelector('#keyword'); 
		inputEL.addEventListener('keydown', function (evt) {
			if(evt.key === 'Enter') {
				searchList();
			}
		});
	});
	
	function searchList() {
		let kwd = document.querySelector('#keyword').value.trim();
		if(! kwd) {
			return;
		}
		
		let params = 'kwd=' + encodeURIComponent(kwd);
		
		let url = '${pageContext.request.contextPath}/admin/listProduct/${gongguProductId}';
		location.href = url + '?' + params;
	}
	
	$(function(){
		// 상품 검색 대화상자
		$('.btn-search').on('click', function(){
			$('.search-form select[name=schType]').val('prodectName');
		    $('.search-form input[name=kwd]').val('');
			$('.product-search-list').empty();
			
			$('#prodectSearchModal').modal('show');		
		});
		
		$('.btn-productSearch').on('click', function(){
			$('.product-search-list').empty();
			
			let schType = $('.search-form select[name=schType]').val();
		    let kwd = $('.search-form input[name=kwd]').val();
		    
		    let params = {schType:schType, kwd:kwd};
		    let url = '${pageContext.request.contextPath}/admin/listProduct/search';

		    const fn = function(data) {
		    	let out = '';
		    	for(let item of data.list) {
		    		let productCode = item.productCode;
		    		let productName = item.productName;
		    		
		    		out += `
		    			<div class="row mb-2 p-2 border-bottom">
		    				<div class="col-3 text-center">\${productCode}</div>
		    				<div class="col ps-2 search-productName" data-productCode="\${productCode}">\${productName}</div>
		    			</div>
		    		`;
		    	}
		    	
		    	$('.product-search-list').html(out);
			};
			
			ajaxRequest(url, 'get', params, 'json', fn);
		});
		
		$('.product-search-list').on('click', '.search-productName', function(){
			let productCode = $(this).attr('data-productCode');
			let productName = $(this).text().trim();
			
			$('.saveProduct-form input[name=productCode]').val(productCode);
			$('.saveProduct-form input[name=productName]').val(productName);
			
			$('#prodectSearchModal').modal('hide');
		});
		
		// 상품 등록 대화상자
		$('.btn-append').on('click', function(){
			$('.saveProduct-form input[name=productCode]').val('');
			$('.saveProduct-form input[name=productName]').val('');
			$('.saveProduct-form input[name=packageNum]').val('0');
			
			$('.saveProduct-form input[name=mode]').val('insert');
			
			$('.saveProduct-form .btn-productSave').text('등록');

			$('#prodectSaveModal').modal('show');		
		});
		
		// 상품 등록 완료
		$('.btn-productSave').on('click', function(){
			let productCode = $('.saveProduct-form input[name=productCode]').val();
			let productName = $('.saveProduct-form input[name=productName]').val();

			if( ! productCode ) {
				return false;
			}

			const fn = function(data) {
				if(data.state === 'true') {
					let reloadUrl = '${pageContext.request.contextPath}/admin/listProduct/${gongguProductId}';
					location.href = reloadUrl;
				} else {
					alert('상품 등록이 실패 했습니다.');
				}
			};
			
		// 상품 삭제 버튼
		$('.btn-delete').on('click', function(){
			let packageNum = $(this).attr('data-packageNum');
			
			let url = '${pageContext.request.contextPath}/admin/gonggu/deletePackage?gongguProductId=${dto.gongguProductId}&packageNum=' + packageNum;
			if(confirm('해당 상품을 패키지 구성에서 삭제하시겠습니까?')) {
				location.href = url;
			}
		});

	});

	</script>
</body>
</html>