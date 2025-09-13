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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css"> 
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<style type="text/css">
  .left { text-align: left; padding-left: 7px; }
  .right { text-align: right; padding-right: 7px; }

  .product-title{ font-weight: 600; }
  .product-options { color: #777; font-size: 12px; }

  .cart-delete, .cart-deleteCheck { cursor: pointer; }
  .cart-delete:hover, .cart-deleteCheck:hover { color: #1712AB; }

  .select-count-label { color: #777; font-size: 12px; }
  .cart-list > thead tr:first-child { border-top: 2px solid #212529; }
  .cart-list td { padding: 3px; }
  .btn-main {     
    background: #7b9580;
    border-radius: 5px;
    padding: 3px 7px 3px 7px;
    color: #ffffff;
    border: 1px solid #ffffff;}
    
  .btnMinus, .btnPlus, .cart-delete {border: none;}
  .form-check-input:checked {
  	background-color: #c7ddcb !important;
    border-color: #c7ddcb !important;}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up" style="padding-top: 40px;">
			<h2 style="text-align: center;">장바구니</h2>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section" style="padding-top: 20px;">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
		
			<div class="row justify-content-center">
				<div class="col-md-10 bg-white box-shadow my-4 p-5">

					<form name="cartForm" method="post">
						<div style="padding: 15px 0 5px;">
							<button type="button" class="btn-default cart-deleteCheck btn-main" onclick="deleteCartSelect()();">선택삭제</button>
						</div>
						<table class="table cart-list">
							<thead>
								<tr class="table-light border-top text-center">
									<th width="35">
										<input type="checkbox" class="form-check-input cart-chkAll" name="chkAll">
									</th>
									<th colspan="2">
										상품명
									</th>
									<th width="140">수량</th>
									<th width="110">상품가격</th>
									<th width="120">합계</th>
									<th width="55">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list}">
									<tr class="text-center" valign="middle">
										<td>
											<input type="checkbox" class="form-check-input" name="nums" value="${dto.stockNum}" 
													data-totalStock="${dto.totalStock}" ${dto.totalStock == 0 ? "disabled":""}>
										</td>
										<td width="55">
											<img class="border rounded" width="50" height="50" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
										</td>
										<td>
											<p class="product-title p-1 mb-0 left">${dto.productName}</p>
											<p class="product-options p-1 mb-0 left">
												<c:if test="${dto.optionCount == 1}">
													선택사항 : ${dto.optionValue}
												</c:if>
												<c:if test="${dto.optionCount == 2}">
													선택사항 : ${dto.optionValue}, ${dto.optionValue2}
												</c:if>
												<c:if test="${dto.totalStock <= 5}">
													&nbsp;&nbsp;&nbsp;재고 : ${dto.totalStock}
												</c:if>
											</p>
											<input type="hidden" name="productCodes" value="${dto.productCode}">
											<input type="hidden" name="stockNums" value="${dto.stockNum}">
										</td>
										<td>
											<div class="input-group">
												<button type="button" class="btn-default btnMinus"><i class="bi bi-dash"></i></button>
												<input type="text" name="buyQtys" value="${dto.qty}" readonly class="form-control" style="width: 40px; text-align: center;">
												<button type="button" class="btn-default btnPlus"><i class="bi bi-plus"></i></button>
											</div>
										</td>
										<td>
											<label><fmt:formatNumber value="${dto.price}"/></label><label>원</label>
											<input type="hidden" name="prices" value="${dto.price}">
										</td>
										<td>
											<label class="productMoneys"><fmt:formatNumber value="${dto.productMoney}"/></label><label>원</label>
											<input type="hidden" name="productMoneys" value="${dto.productMoney}">
										</td>
										<td>
											<button type="button" class="btn-default cart-delete" onclick="deleteCartItem('${dto.stockNum}')"><i class="bi bi-x"></i></button>
										</td>
									</tr>
								
								</c:forEach>
							</tbody>
						</table>
						
						<c:choose>
							<c:when test="${list.size() == 0}">
								<div class="mt-3 p-3 text-center">
									등록된 상품이 없습니다.
								</div>
							</c:when>
							<c:otherwise>
								<div class="mt-3 p-3 text-end">
									<input type="hidden" name="mode" value="cart">
									<button type="button" class="btn-accent btn-main" style="width: 200px;" onclick="sendOk();"> 선택상품 구매하기 </button>
									<button type="button" class="btn-default btn-main" onclick="deleteCartAll();"> 장바구니 모두 비우기 </button>
								</div>
							</c:otherwise>
						</c:choose>
					</form>

				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
$(function(){
	let cartSize = Number('${list.size()}') || 0;
	if(cartSize !== 0) {
		$('.cart-chkAll').prop('checked', true);
		$('form input[name=nums]').prop('checked', true);
	}
	
    $('.cart-chkAll').click(function() {
    	$('form input[name=nums]').prop('checked', $(this).is(':checked'));
    });
    
    $('form input[name=nums]').click(function() {
		$(".cart-chkAll").prop("checked", $("form input[name=nums]").length === $("form input[name=nums]:checked").length);
   });
});

function sendOk() {
	// 구매하기
	const f = document.cartForm;
	
	let cnt = $('form input[name=nums]:checked').length;
    if (cnt === 0) {
		alert('구매할 상품을 먼저 선택 하세요 !!!');
		return;
    }
    
    let b = true;
    $('form input[name=nums]').each(function(index, item) {
		if($(this).is(':checked')) {
			let totalStock = Number($(this).attr('data-totalStock'));
			let $tr = $(this).closest('tr');
			let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
			if(qty > totalStock) {
				b = false;
				return false;
			}
		}
	});
    
    if( ! b) {
		alert('상품 재고가 부족합니다.')
		return;
    }
    
    $('form input[name=nums]').each(function(index, item){
		if(! $(this).is(':checked')) {
			$(this).closest('tr').remove();
		}
	});
    
	f.action = '${pageContext.request.contextPath}/productsOrder/payment';
	f.submit();
}

function deleteCartAll() {
	// 장바구니 비우기
	if(! confirm('장바구니를 비우시겠습니까 ? ')) {
		return;
	}

	location.href = '${pageContext.request.contextPath}/myShopping/deleteCartAll';	
}

function deleteCartSelect() {
	// 선택된 항목 삭제
	let cnt = $('form input[name=nums]:checked').length;
    if (cnt === 0) {
		alert('삭제할 상품을 먼저 선택 하세요 !!!');
		return;
    }
    
	if(! confirm('선택한 상품을 장바구니에서 비우시겠습니까 ? ')) {
		return;
	}
	
	const f = document.cartForm;
	f.action = '${pageContext.request.contextPath}/myShopping/deleteListCart';
	f.submit();
}

function deleteCartItem(stockNum) {
	// 하나의 항목 삭제
	if(! confirm('선택한 상품을 장바구니에서 비우시겠습니까 ? ')) {
		return;
	}

	location.href = '${pageContext.request.contextPath}/myShopping/deleteCart?stockNum=' + stockNum;	
}

$(function(){
	$('.btnMinus').click(function() {
		const $tr = $(this).closest('tr');
		let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
		let price = Number($tr.find('input[name=prices]').val()) || 0;
		
		if(qty <= 1) {
			return false;
		}
		
		qty--;
		$tr.find('input[name=buyQtys]').val(qty);
		let total = price * qty;
		
		$tr.find('.productMoneys').text(total.toLocaleString());
		$tr.find('input[name=productMoneys]').val(total);
	});

	$('.btnPlus').click(function(){
		const $tr = $(this).closest('tr');
		let totalStock = Number($tr.find('input[name=nums]').attr('data-totalStock'));
		
		let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
		let price = Number($tr.find('input[name=prices]').val()) || 0;
		
		if(totalStock <= qty) {
			alert('상품 재고가 부족 합니다.');
			return false;
		}
		
		if(qty >= 99) {
			return false;
		}
		
		qty++;
		$tr.find('input[name=buyQtys]').val(qty);
		let total = price * qty;
		
		$tr.find('.productMoneys').text(total.toLocaleString());
		$tr.find('input[name=productMoneys]').val(total);
	});
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
	<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</footer>

</body>
</html>