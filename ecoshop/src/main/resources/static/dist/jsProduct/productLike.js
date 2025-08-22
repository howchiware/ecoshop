$(function(){
	// 상품 리스트에서 찜을 클릭한 경우
	$('.list-container').on('click', '.product-item-heart', function(){
		const $item = $(this).closest('.product-item');
		const productCode = $item.attr('data-productCode');
		/*
		const bLogin = Number('${empty sessionScope.member ? 0 : 1}') || 0;
		if(! bLogin) {
			location.href = '/member/login';
			return false;
		}
		*/
		
		sendProductLike(productCode, $(this));
	});
	
	// 상품 상세 보기에서 찜을 선택한 경우
	$('.btn-productLike').on('click', function(){
		const productCode = $(this).attr('data-productCode');
		
		/*
		const bLogin = Number('${empty sessionScope.member ? 0 : 1}') || 0;
		if(! bLogin) {
			location.href = '/member/login';
			return false;
		}
		*/
		
		sendProductLike(productCode, $(this));
	});
});

// 찜 등록 및 해제
function sendProductLike(productCode, $el){
	const bFlag = $el.find('i').hasClass('bi-heart-fill');
	
	let method, msg;
	if(bFlag){
		method = 'delete';
		msg = '상품에 대한 찜을 해제하시겠습니까 ? ';
	} else {
		method = 'post';
		msg = '상품을 찜 목록에 추가하시겠습니까 ? ';
	}
	
	if(! confirm(msg)){
		return;
	}
	
	const params = {productCode:productCode};
	let url = '/myShopping/productLike/' + productCode;
	
	console.log(url);

	const fn = function(data){
		const state = data.state;
		
		if(state === 'false'){
			return false;
		}
		
		if(bFlag){
			$el.find('i').removeClass('bi-heart-fill text-danger').addClass('bi-heart');
		} else {
			$el.find('i').removeClass('bi-heart').addClass('bi-heart-fill text-danger');
		}
	};
	
	ajaxRequest(url, method, params, 'json', fn);
}