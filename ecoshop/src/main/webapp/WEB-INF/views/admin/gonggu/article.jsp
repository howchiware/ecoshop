<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>패키지 상세</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
								<p class="cardText">기간 : ${dto.startDate} ~ ${dto.endDate}</p>
								<p class="cardText">재고 : ${dto.limitCount}개</p>
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
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/update?gongguProductId=${dto.gongguProductId}&categoryId=${dto.categoryId}&page=${page}';">수정</button>
						<button type="button" class="btn-default btn-gongguDelete"
							onclick="deleteOk();">삭제</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn-default"
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/listProduct?${query}';">리스트</button>
					</div>
					<hr>
					<div class="row packageList-container">
						<div class="col-md-6">[  패키지 상품구성  ]  할인율 : ${dto.sale}% -> 총 패키지가격 : <span id="gongguPriceDisplay">${dto.gongguPrice}</span></div>
						<div class="col-md-6 text-end">
							<button type="button" class="btn-default btn-append">상품등록</button>
						</div>
					</div>
					<table class="table table-hover board-list">
						<thead>
						    <tr>
						        <th width="110">상품코드</th>
						        <th width="80">상품사진</th>
						        <th>상품명</th>
						        <th width="80">가격</th>
						        <th width="80">삭제</th> </tr>
						</thead>
						<tbody class="product-list">
						    
						</tbody>
					</table>

					<div class="page-navigation">${dataCount == 0 ? "등록된 정보가 없습니다." : paging}
					</div>
				</div>
			</div>
		</div>
	</main>

	<div class="modal fade" id="prodectSearchModal" tabindex="-1"
		aria-labelledby="prodectSearchModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="prodectSearchModalLabel">상품 검색</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col">
							<form name="searchForm" class="search-form form-inline">
								<select name="schType" class="form-select w-25">
									<option value="productName">상품명</option>
									<option value="productCode">상품코드</option>
								</select> <input type="text" name="kwd" class="form-control"
									placeholder="검색어를 입력하세요">
								<button type="button" class="btn btn-primary btn-productSearch">검색</button>
							</form>
						</div>
					</div>
					<hr>
					<table class="table table-hover board-list">
						<thead>
						    <tr>
						        <th width="110">상품코드</th>
						        <th width="80">상품사진</th>
						        <th>상품명</th>
						        <th width="80">가격</th> <th width="80">등록</th> 
						   </tr>
						</thead>
						<tbody class="product-search-list">
						</tbody>
					</table>
					</div>
			</div>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/dist/jsGonggu/sendAjaxRequest.js"></script>

	<script type="text/javascript">
        function fetchPackageProducts() {
            let gongguProductId = '${dto.gongguProductId}';
            let url = '${pageContext.request.contextPath}/admin/gonggu/listPackage';
            let params = { gongguProductId: gongguProductId };

            const fn = function(data) {
                let out = '';
                if (data.list && data.list.length > 0) {
                    for(let item of data.list) {
                    	let productCode = item.productCode;
                        let productName = item.productName;
                        let price = item.price;
                        let thumbnail = item.thumbnail;
                        out += `
                            <tr>
                                <td>\${item.productCode}</td>
                                <td><img src="${pageContext.request.contextPath}/uploads/products/\${item.thumbnail}" style="width:50px; height:auto;"></td> 
                                <td class="left">\${item.productName}</td>
                                <td>\${item.price}</td>
                                <td>
                                    <button type="button" class="btn btn-default btn-sm btn-delete"
                                            title="삭제" data-packageNum="\${item.packageNum}">삭제</button>
                                </td>
                            </tr>
                        `;
                    }
                } else {
                    out = '<tr><td colspan="5">등록된 상품이 없습니다.</td></tr>';
                }
                $('.product-list').html(out);
            };

            sendAjaxRequest(url, 'get', params, 'json', fn);
        }

		function deleteOk() {
			let params = 'gongguProductId=${dto.gongguProductId}&${query}&gongguThumbnail=${dto.gongguThumbnail}';
			let url = '${pageContext.request.contextPath}/admin/gonggu/delete?' + params;
			if (confirm('패키지를 삭제 하시겠습니까 ? ')) {
				location.href = url;
			}
		}

		window.addEventListener('load', () => {
			const inputEL = document.querySelector('#keyword'); 
			if (inputEL) {
				inputEL.addEventListener('keydown', function (evt) {
					if(evt.key === 'Enter') {
						searchList();
					}
				});
			}
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
            fetchPackageProducts();
			
			$('.btn-append').on('click', function(){
				$('.search-form select[name=schType]').val('productName');
				$('.search-form input[name=kwd]').val('');
				$('.product-search-list').empty(); 
				$('#prodectSearchModal').modal('show');
			});
			let gongguProductId = '${dto.gongguProductId}'; 
			
			$('.btn-productSearch').on('click', function(){
				$('.product-search-list').empty(); 
				
				let schType = $('.search-form select[name=schType]').val();
				let kwd = $('.search-form input[name=kwd]').val();
				
				let params = {schType:schType, kwd:kwd, gongguProductId: gongguProductId};
				let url = '${pageContext.request.contextPath}/admin/gonggu/listProduct/search';

				const fn = function(data) {
				    let out = '';
				    if (data.list && data.list.length > 0) {
					    for(let item of data.list) {
					        let productCode = item.productCode;
					        let productName = item.productName;
					        let price = item.price;
                            let thumbnail = item.thumbnail;
					        out += `
					            <tr>
					                <td>\${productCode}</td>
                                    <td><img src="${pageContext.request.contextPath}/uploads/products/\${thumbnail}" style="width:50px; height:auto;"></td>
					                <td class="left">\${productName}</td>
					                <td>\${price}</td>
					                <td>
					                    <button type="button" class="btn btn-default btn-sm btn-direct-register" 
					                            data-productCode="\${productCode}" 
					                            data-thumbnail="\${thumbnail}"
					                            data-productName="\${productName}"
					                            data-price="\${price}">등록</button>
					                </td>
					            </tr>
					        `;
					    }
				    } else {
				    	out = '<tr><td colspan="5">검색 결과가 없습니다.</td></tr>';
				    }
				    $('.product-search-list').html(out); 
				};
				
				sendAjaxRequest(url, 'get', params, 'json', fn);
			});
			
			$('.product-search-list').on('click', '.btn-direct-register', function(){
				let $row = $(this).closest('tr');
				let productCode = $(this).data('productcode');
			    
			    let params = {
			    	productCode: productCode,
			    	gongguProductId: '${dto.gongguProductId}'
			    };
			    
			    let url = '${pageContext.request.contextPath}/admin/gonggu/insertPackage';
				
			    const fn = function(data) {
			        if(data.state === 'true') {
                        $row.hide();
                        
                        $('#originalPrice').text(data.originalPrice);
                        $('#gongguPrice').text(data.gongguPrice);

                        fetchPackageProducts();
                        
                        $('#prodectSearchModal').modal('hide');
                        
			        } else {
			            alert(data.message || '상품 등록이 실패 했습니다.');
			        }
			    };
				
				sendAjaxRequest(url, 'post', params, 'json', fn);
			});
				
			$('body').on('click', '.btn-delete', function(){
			    let packageNum = $(this).attr('data-packageNum');
			    
			    if(confirm('해당 상품을 패키지 구성에서 삭제하시겠습니까?')) {
			        let url = '${pageContext.request.contextPath}/admin/gonggu/deletePackage';
			        $.ajax({
			            url: url,
			            type: 'POST',
			            data: {
			                packageNum: packageNum
			            },
			            dataType: 'json',
			            success: function(data) {
			                if(data.state === 'true') {
			                    fetchPackageProducts();
			                    
			                    $('#gongguPriceDisplay').text(data.gongguPrice);
			                } else {
			                    alert(data.message || '삭제에 실패했습니다.');
			                }
			            },
			            error: function() {
			                alert('삭제 중 오류가 발생했습니다.');
			            }
			        });
			    }
			});
		}); 
	</script>
</body>
</html>