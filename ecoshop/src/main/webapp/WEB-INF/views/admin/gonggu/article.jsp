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
					<div class="row mb-2 packageList-container">
						<div class="col">패키지 상품구성</div>
						<div class="col text-end">
							<button type="button" class="btn-default btn-append">상품등록</button>
						</div>
					</div>
					
					<table class="table table-hover board-list">
							<thead>
								<tr>
									<th width="110">상품코드</th>
									<th width="150">카테고리</th>
									<th>상품명</th>
									<th width="80">출력순서</th>
									<th width="80">출력</th>
									<th width="150">변경</th>
								</tr>
							</thead>
							<tbody class="product-list">
								<c:forEach var="vo" items="${productList}">
									<tr>
										<td data-productNum="${vo.productNum}">${vo.productNum}</td>
										<td data-categoryName="${vo.categoryName}">${vo.categoryName}</td>
										<td class="left" data-productName="${vo.productName}">${vo.productName}</td>
										<td data-displayOrder="${vo.displayOrder}">${vo.displayOrder}</td>
										<td data-displayStatus="${vo.displayStatus}">${vo.displayStatus==1 ? "출력":"숨김"}</td>
										<td>
											<button type="button" class="btn-default btn-sm btn-update" title="수정" data-displayNum="${vo.displayNum}">수정</button>
											<button type="button" class="btn-default btn-sm btn-delete" title="삭제" data-displayNum="${vo.displayNum}">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>					
						</table>
						
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
	
	<!-- 등록/수정 대화상자 -->
<div class="modal fade modal-lg" id="prodectSaveModal" aria-labelledby="prodectSaveModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prodectSaveModalLabel">${title} 상품</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1 saveProduct-form">
				<table class="table ">
					<tr>
						<td class="text-center align-middle bg-light border-top">상품명</td>
						<td class="border-top">
							<div class="input-group">
								<input type="text" name="productName" class="form-control" readonly>
								<button type="button" class="btn-default btn-search ms-1" title="검색"><i class="bi bi-search"></i></button>
							</div>						
						</td>
					</tr>
					<tr>
						<td class="text-center align-middle bg-light">상품코드</td>
						<td>
							<input type="text" name="productNum" class="form-control border-0 w-50" readonly>
						</td>
					</tr>
					<tr>
						<td class="text-center align-middle bg-light">출력순서</td>
						<td>
							<input type="text" name="displayOrder" class="form-control w-50">
							<small class="form-control-plaintext help-block">큰수가 먼저 출력됩니다.</small>
						</td>
					</tr>
					<tr>
						<td class="text-center align-middle bg-light">출력</td>
						<td>
							<select name="displayStatus" class="form-select w-50">
								<option value="1">표시</option>
								<option value="0">숨김</option>
							</select>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td class="text-end">
							<input type="hidden" name="mode">
							<input type="hidden" name="displayClassify" value="${itemId}">
							<input type="hidden" name="specialNum" value="${dto.specialNum}">
							<input type="hidden" name="displayNum" value="0">
							
							<button type="button" class="btn-accent btn-productSave">등록</button>
			    				<button type="button" class="btn-default btn-productCancel">취소</button>
						</td>
					</tr>
				</table>				
			</div>
		</div>
	</div>
</div>

<!-- 상품 검색 대화상자 -->
<div class="modal fade" id="prodectSearchModal" tabindex="-1" aria-labelledby="prodectSearchModalLabel"
				aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prodectSearchModalLabel">상품검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
                <div class="row search-form">
					<div class="col-4 pe-1">
						<select name="schType" class="form-select">
							<option value="prodectName">상품명</option>
							<option value="prodectNum">상품코드</option>
						</select>
					</div>
					<div class="col ps-0 pe-1">
						<input type="text" name="kwd" class="form-control">
						<input type="hidden" name="displayClassify" value="${itemId}">
					</div>
					<div class="col-auto ps-0 pe-2">
						<button type="button" class="btn-default btn-productSearch" title="검색"><i class="bi bi-search"></i></button>
					</div>
                </div>
               	<div class="row mt-2 border-top border-bottom bg-light p-2">
               	 	<div class="col-3 text-center">상품코드</div>
               	 	<div class="col ps-2">상품명</div>
               	</div>
                <div class="product-search-list"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	// 상품 등록 대화상자
	$('.btn-append').on('click', function(){
		$('.saveProduct-form input[name=productNum]').val('');
		$('.saveProduct-form input[name=productName]').val('');
		$('.saveProduct-form input[name=displayOrder]').val('');
		$('.saveProduct-form select[name=displayStatus]').val('1');
		$('.saveProduct-form input[name=displayNum]').val('0');
		
		$('.saveProduct-form input[name=mode]').val('insert');
		
		$('.saveProduct-form .btn-productSave').text('등록');

		$('#prodectSaveModal').modal('show');		
	});

	// 상품 수정 대화상자
	$('.btn-update').on('click', function(){
		let displayNum = $(this).attr('data-displayNum')
		let productNum = $(this).closest('tr').find('td:first-child').attr('data-productNum');
		let productName = $(this).closest('tr').find('td:nth-child(3)').attr('data-productName');
		let displayOrder = $(this).closest('tr').find('td:nth-child(4)').attr('data-displayOrder');
		let displayStatus = $(this).closest('tr').find('td:nth-child(5)').attr('data-displayStatus');
		
		$('.saveProduct-form input[name=productNum]').val(productNum);
		$('.saveProduct-form input[name=productName]').val(productName);
		$('.saveProduct-form input[name=displayOrder]').val(displayOrder);
		$('.saveProduct-form select[name=displayStatus]').val(displayStatus);
		$('.saveProduct-form input[name=displayNum]').val(displayNum);
		
		$('.saveProduct-form input[name=mode]').val('update');
		
		$('.saveProduct-form .btn-productSave').text('수정');

		$('#prodectSaveModal').modal('show');		
	});

	// 상품 등록/수정 완료
	$('.btn-productSave').on('click', function(){
		let productNum = $('.saveProduct-form input[name=productNum]').val();
		let productName = $('.saveProduct-form input[name=productName]').val();
		let displayOrder = $('.saveProduct-form input[name=displayOrder]').val();
		let displayStatus = $('.saveProduct-form select[name=displayStatus]').val();
		let displayNum = $('.saveProduct-form input[name=displayNum]').val();
		let displayClassify = '${itemId}';
		let specialNum = '${dto.specialNum}';
		
		let mode = $('.saveProduct-form input[name=mode]').val();
		
		if( ! productNum ) {
			return false;
		}
		
		if( ! /^\d{1,5}$/.test(displayOrder) ) {
			alert("5자리 이하 정수만 가능합니다.")
			$(".saveProduct-form input[name=displayOrder]").focus();
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/admin/display/product';
		const fn = function(data) {
			if(data.state === 'true') {
				let reloadUrl = '${pageContext.request.contextPath}/admin/display/specials/${itemId}/${dto.specialNum}';
				if(mode === 'update') {
					reloadUrl += '?${query}';
				} else {
					reloadUrl += '?page=1';
				}			
				location.href = reloadUrl;
			}
		};
		
		if(mode === 'insert') {
			let params = {displayClassify:displayClassify, specialNum:specialNum, 
					 productNum:productNum, displayOrder:displayOrder, 
					 displayStatus:displayStatus};
			
			ajaxRequest(url, 'post', params, 'json', fn);
		} else if(mode === 'update') {
			let params = {displayNum:displayNum, displayOrder:displayOrder, 
					productNum:productNum, displayStatus:displayStatus};
			
			ajaxRequest(url, 'put', JSON.stringify(params), 'json', fn, false, 'json');
		}
		
	});

	// 상품 등록/수정 취소
	$('.btn-productCancel').on('click', function(){
		$('#prodectSaveModal').modal('hide');
	});
});

$(function(){
	// 등록 상품 삭제
	$('.btn-delete').on('click', function(){
		if( ! confirm('등록된 상품을 삭제 하시겠습니까 ? ') ) {
			return false;	
		}
		const $tr = $(this).closest('tr');
		
		let displayNum = $(this).attr('data-displayNum');
		
		let url = '${pageContext.request.contextPath}/admin/display/product/' + displayNum;
		let requestParams = null;
		const fn = function(data){
			if(data.state === 'true') {
				$tr.remove();
			}
		};
		
		ajaxRequest(url, 'delete', requestParams, 'json', fn);
	});
});

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
	    let classify = '${itemId}';
	    let specialNum = '${dto.specialNum}';
		
	    let params = {classify:classify, specialNum:specialNum, schType:schType, kwd:kwd};
	    let url = '${pageContext.request.contextPath}/admin/display/search';

		const fn = function(data) {
		    	let out = '';
		    	for(let item of data.list) {
		    		let productNum = item.productNum;
		    		let productName = item.productName;

		    		out += `
		    			<div class="row mb-2 p-2 border-bottom">
		    				<div class="col-3 text-center">\${productNum}</div>
		    				<div class="col ps-2 search-productName" data-productNum="\${productNum}">\${productName}</div>
		    			</div>
		    		`;		    	
		    	}
		    	
		    	$('.product-search-list').html(out);
		};
		
		ajaxRequest(url, 'get', params, 'json', fn);
	});
	
	$('.product-search-list').on('click', '.search-productName', function(){
		let productNum = $(this).attr('data-productNum');
		let productName = $(this).text().trim();
		
		$('.saveProduct-form input[name=productNum]').val(productNum);
		$('.saveProduct-form input[name=productName]').val(productName);
		
		$('#prodectSearchModal').modal('hide');
		
		$('.saveProduct-form input[name=displayOrder]').focus();
	});
});
</script>
</body>
</html>