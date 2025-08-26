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
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
  .product-card { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 8px;
      display: flex; align-items: center; gap: 15px; }
  img.product-img { flex-shrink: 0; width: 120px; height: 120px; object-fit: cover; border-radius: 6px; 
      cursor: pointer; transition: transform 0.3s ease, box-shadow 0.3s ease; }
  img.product-img:hover { transform: scale(1.05); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); }
  .product-info { flex-grow: 1; }
  .product-title { font-size: 1.1rem; font-weight: bold; }
  .product-price { margin-top: 5px; }
  .product-price .original-price { text-decoration: line-through; color: #888; margin-right: 10px;
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

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>찜한 상품</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 bg-white box-shadow my-4 p-5 recentProductView">
					<c:choose>
						<c:when test="${list.size() == 0 }">
							<p class="text-center">찜한 상품 목록이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<div class="text-end pb-2"><button type="button" class="btn-default" onclick="productDeleteAll();"> 전체삭제 </button></div>
						</c:otherwise>
					</c:choose>
					
					<div class="row">
						<c:forEach var="dto" items="${list}">
						    <div class="col-md-6">
							    <div class="product-card">
							        <img class="product-img btn-productCart" data-productNum="${dto.productNum}" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
							        <div class="product-info">
							            <div class="product-title">${dto.productName}</div>
							            <div class="product-price">
							                <span class="discounted-price"><fmt:formatNumber value="${dto.salePrice}"/>원</span>
							                <span class="original-price"><fmt:formatNumber value="${dto.price}"/>원</span>
							            </div>
							            <div class="product-actions">
							                <button class="btn btn-sm btn-outline-primary btn-productCart" data-productNum="${dto.productNum}" title="장바구니 담기">
							                    <i class="bi bi-cart-plus"></i>
							                </button>
						                    <button class="btn btn-sm btn-outline-danger btn-productDelete" data-productNum="${dto.productNum}" title="삭제">
						                        <i class="bi bi-trash"></i>
					                        </button>
							            </div>
							        </div>
							    </div>
						    </div>
						</c:forEach>
					</div>
						
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
function productDeleteAll() {
	if(confirm('찜한 상품 목록을 전체 삭제하시겠습니까 ? ')) {
		const params = null;
		let url = '${pageContext.request.contextPath}/myShopping/wish';
		
		const fn = function(data) {
			const state = data.state;
			
			if(state === 'false') {
				return false;
			}
			
			$('.recentProductView').html('<p class="text-center">찜한 상품 목록이 없습니다.</p>');
		};
		
		ajaxRequest(url, 'delete', params, 'json', fn);
	}
}

$(function(){
	$('.recentProductView').on('click', '.btn-productCart', function(){
		const productNum = $(this).attr('data-productNum');
		let url = '${pageContext.request.contextPath}/products/' + productNum;
		location.href = url;
	});

	$('.recentProductView').on('click', '.btn-productDelete', function(){
		if(confirm('선택한 상품 목록을 삭제하시겠습니까 ? ')) {
			const $el = $(this);
			const productNum = $(this).attr('data-productNum');
			
			const params = {productNum: productNum};
			let url = '${pageContext.request.contextPath}/myShopping/wish/' + productNum;
			
			const fn = function(data) {
				const state = data.state;
				
				if(state === 'false') {
					return false;
				}
				
				$el.closest('.col-md-6').remove();
				
				if($el.closest('.row').find('.col-md-6').length === 0) {
					$('.recentProductView').html('<p class="text-center">찜한 상품 목록이 없습니다.</p>');
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

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>