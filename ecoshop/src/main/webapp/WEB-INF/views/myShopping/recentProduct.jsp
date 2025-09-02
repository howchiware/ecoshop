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
		  	    <h3 class="pb-2 mb-4 border-bottom sub-title">최근에 본 상품</h3>
	
	    
				<!-- Page Content -->    
				<div class="row justify-content-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-md-10 bg-white box-shadow my-4 recentProductView"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
window.addEventListener('DOMContentLoaded', () => {
	recentProductView();
});

function recentProductView() {
	$('.recentProductView').empty();
	
	let product = JSON.parse(localStorage.getItem('recentProduct')) || [];
	let out = '';

	if(product.length === 0) {
		$('.recentProductView').html('<p class="text-center">최근에 본 상품 목록이 없습니다.</p>');
		return;
	}
	
	out = '<div class="text-end pb-2"><button type="button" class="btn-default" onclick="productDeleteAll();"> 전체삭제 </button></div>';
	out +='  <div class="row">'; 
	for(let item of product) {
		let productClassify = item.pclassify;
		console.log(productClassify);
		let productNum = item.pnum;
		let productName = item.pname;
		let img = item.pimg;
		let price = Number(item.price) || 0;
		price = price.toLocaleString() + '원';
		
		out += `
		    <div class="col-md-6">
			    <div class="product-card">
			        <img class="product-img btn-productCart" data-classify="\${productClassify}" data-productNum="\${productNum}" src="${pageContext.request.contextPath}/uploads/products/\${img}">
			        <div class="product-info">
			            <div class="product-title">\${productName}</div>
			            <div class="product-price">
			                <span class="original-price">\${price}</span>
			            </div>
			            <div class="product-actions">
			                <button class="btn btn-sm btn-outline-primary btn-productCart" data-classify="\${productClassify}" data-productNum="\${productNum}" title="장바구니 담기">
			                    <i class="bi bi-cart-plus"></i>
			                </button>
		                    <button class="btn btn-sm btn-outline-danger btn-productDelete" data-productNum="\${productNum}" title="삭제">
		                        <i class="bi bi-trash"></i>
	                        </button>
			            </div>
			        </div>
			    </div>
		    </div>
		`;
	}
	out += '  </div>';
	
	$('.recentProductView').html(out);
}

function productDeleteAll() {
	if(confirm('최근 본 상품 목록을 전체 삭제하시겠습니까 ? ')) {
		localStorage.removeItem('recentProduct');
		
		$('.recentProductView').empty();
		$('.recentProductView').html('<p class="text-center">최근에 본 상품 목록이 없습니다.</p>');
	}
}

$(function(){
	$('.recentProductView').on('click', '.btn-productCart', function(){
		const productNum = $(this).attr('data-productNum');
		if($(this).attr('data-classify') === '1'){
			let url = '${pageContext.request.contextPath}/products/' + productNum;
			location.href = url;			
		} else if($(this).attr('data-classify') === '2'){
			let url = '${pageContext.request.contextPath}/gonggu/' + productNum;
			location.href = url;			
		}
	});

	$('.recentProductView').on('click', '.btn-productDelete', function(){
		if(confirm('선택한 상품 목록을 삭제하시겠습니까 ? ')) {
			const productNum = $(this).attr('data-productNum');
			
			let product = JSON.parse(localStorage.getItem('recentProduct')) || [];
			product.forEach(function(data){
				if(data.pnum === productNum) {
					let idx = product.indexOf(data);
					if(idx > -1) product.splice(idx, 1);
					return;
				}
			});
			
			let p = JSON.stringify(product);
			localStorage.setItem('recentProduct', p);
			
			if(product.length === 0) {
				$('.recentProductView').html('<p class="text-center">최근에 본 상품 목록이 없습니다.</p>');
			} else {
				$(this).closest('.col-md-6').remove();
			}
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