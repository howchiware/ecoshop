<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<!-- Vendor JS Files -->
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>

<style type="text/css">
  .product-card { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 8px;
      display: flex; align-items: center; gap: 15px; }
  img.product-img { flex-shrink: 0; width: 120px; height: 120px; object-fit: cover; border-radius: 6px; 
      cursor: pointer; transition: transform 0.3s ease, box-shadow 0.3s ease; }
  img.product-img:hover { transform: scale(1.05); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); }
  .product-info { flex-grow: 1; }
  .product-title { font-size: 1.1rem; font-weight: bold; }
  .product-price { margin-top: 5px; }
  .product-price .original-price { color: #888; margin-right: 10px;
      font-size: 0.95rem; }
  .product-price .discounted-price { color: #dc3545; font-weight: bold; font-size: 1.05rem; }
  .product-actions { margin-top: 10px; }
  .product-actions .btn { margin-right: 8px; }
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="main-container">
<div class="row">

	<div class="col-md-2">
        <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
	<div class="col-md-10">
	    <div class="contentsArea">
	  	    <h3 class="pb-2 mb-4 border-bottom sub-title">찜한 상품</h3>

		
			<div class="row justify-content-center">

					<ul class="nav nav-tabs mt-5" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${mode=='productLike'?'active':'' }" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane-1" type="button" role="tab" aria-controls="1" aria-selected="false"> 온라인샵 </button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${mode=='gongguProductLike'?'active':'' }" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane-2" type="button" role="tab" aria-controls="2" aria-selected="false"> 공동구매 </button>
						</li>
					</ul>
					
					<div class="tab-content pt-2" id="myTabContent">
						<div class="tab-pane fade ${mode=='productLike'?'active show':'' }" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
							<div class="mt-3 pt-3 border-bottom">
								<p class="fs-4 fw-semibold">온라인샵</p> 
							</div>
							
							<div class="row mt-2 list-productLike"></div>
						</div>
						
						<div class="tab-pane fade ${mode=='gongguProductLike'?'active show':'' }" id="tab-pane-2" role="tabpanel" aria-labelledby="tab-2" tabindex="0">
							<div class="mt-3 pt-3 border-bottom">
								<p class="fs-4 fw-semibold">공동구매</p> 
							</div>
					
							<div class="row mt-1 p-2 list-question"></div>
						</div>
					</div>		
			</div>
			
		</div>
	</div>
</div>
</main>


<script type="text/javascript">
$(function(){
	$('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		if(tab === '1') {
			listProductLike(1);
		} else if(tab === '2'){
			listGongguProductLike(1);
		}
	});
	
	let mode = '${mode}';
	if(mode === 'gongguProductLike') {
		listGongguProductLike(1);
	} else {
		listProductLike(1);
	}
});

// 온라인샵 -
function listProductLike(page) {
	let url = '${pageContext.request.contextPath}/myShopping/list2';
	let requstParams = 'pageNo='+page;
	
	const fn = function(data) {
		printProductLike(data);
	};
	
	ajaxRequest(url, 'get', requstParams, 'json', fn);
}

function printProductLike(data) {
	const { dataCount, paging, size, pageNo, total_page, list } = data;

	let out = '';

	if(list.length === 0){
		out += `<p class="text-center">찜한 상품 목록이 없습니다.</p>`;
	} else {
		out += `<div class="text-end pb-2"><button type="button" class="btn-default" onclick="productDeleteAll();"> 전체삭제 </button></div>`;
		
		for (const item of list) {
			const { // 구조 분해 할당
				productLikeNum, memberId, productCode, productLikeDate,
				productName, price, point, thumbnail
			} = item;
			
			out += `<div class="col-md-6">
					    <div class="product-card">
					        <img class="product-img btn-productCart" data-productCode="\${productCode}" src="${pageContext.request.contextPath}/uploads/products/\${thumbnail}">
					        <div class="product-info">
					            <div class="product-title">\${productName}</div>
					            <div class="product-price">
					                <span class="original-price">\${price}원</span>
					            </div>
					            <div class="product-actions">
					                <button class="btn btn-sm btn-outline-primary btn-productCart" data-productCode="\${productCode}" title="장바구니 담기">
					                    <i class="bi bi-cart-plus"></i>
					                </button>
				                    <button class="btn btn-sm btn-outline-danger btn-productDelete" data-productCode="\${productCode}" title="삭제">
				                        <i class="bi bi-trash"></i>
				                    </button>
					            </div>
					        </div>
					    </div>
				    </div>`;
		}
		
	}

	// 페이지네이션 추가
	if (dataCount > 0) {
		out += `
			<div class="page-navigation">\${paging}</div>
		`;
	}

	$('.list-productLike').html(out);
}


function productDeleteAll() {
	if(confirm('찜한 상품 목록을 전체 삭제하시겠습니까 ? ')) {
		const params = null;
		let url = '${pageContext.request.contextPath}/myShopping/productLike';
		
		const fn = function(data) {
			const state = data.state;
			
			if(state === 'false') {
				return false;
			}
			
			$('.list-productLike').html('<p class="text-center">찜한 상품 목록이 없습니다.</p>');
		};
		
		ajaxRequest(url, 'delete', params, 'json', fn);
	}
}

$(function(){
	$('.list-productLike').on('click', '.btn-productCart', function(){
		const productCode = $(this).attr('data-productCode');
		let url = '${pageContext.request.contextPath}/products/' + productCode;
		location.href = url;
	});

	$('.list-productLike').on('click', '.btn-productDelete', function(){
		if(confirm('선택한 상품 목록을 삭제하시겠습니까 ? ')) {
			const $el = $(this);
			const $row = $el.closest('.row');
			const productCode = $(this).attr('data-productCode');
			
			const params = {productCode: productCode};
			let url = '${pageContext.request.contextPath}/myShopping/productLike/' + productCode;
			
			const fn = function(data) {
				const state = data.state;
				
				if(state === 'false') {
					return false;
				}
				
				$el.closest('.col-md-6').remove();

				if($row.find('.col-md-6').length === 0) {
					$('.list-productLike').html('<p class="text-center">찜한 상품 목록이 없습니다.</p>');
				}
			};
			
			ajaxRequest(url, 'delete', params, 'json', fn);
		}
	});
});

</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
<!-- Vendor JS Files -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>


</body>
</html>