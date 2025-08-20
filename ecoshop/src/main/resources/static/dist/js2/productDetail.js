$(function(){
	const gvContextPath = document.getElementById('web-contextPath').value;
	const gvProductCode = document.getElementById('product-productCode').value;
	const gvOptionCount = Number(document.getElementById('product-optionCount').value) || 0;
	const gvTotalStock = Number(document.getElementById('product-totalStock').value) || 0;
	const gvPrice = Number(document.getElementById('product-price').value) || 0;
	const gvStockNum = Number(document.getElementById('product-stockNum').value) || 0;

	// 옵션이 없는 경우
	if(gvOptionCount === 0) {
		$('.order-box').attr('data-totalStock', gvTotalStock);
		
		buyQuantity(gvStockNum, gvPrice, 0, 0);
	}
	
	// 옵션-1 선택
	$('.requiredOption').change(function(){
		let optionDetailNum = $(this).val();
		if(! optionDetailNum) {
			return false;
		}
		
		// let optionNum = $('.requiredOption').attr('data-optionNum');
		
		// 옵션이 1개인 경우 
		if (gvOptionCount === 1) {
		    const selectedOptionDetailNum = optionDetailNum;
		
		    // 이미 주문 영역에 동일한 detailNum이 있는지 확인
		    const isOptionAlreadyAdded = $('.order-box input[name="optionDetailNums"]').toArray().some(function(input) {
		        return $(input).val() === selectedOptionDetailNum;
		    });
		
		    if (isOptionAlreadyAdded) {
		        // 이미 추가된 옵션이라면 함수 실행을 중단
		        return false;
		    }
		
		    // 선택된 옵션의 재고 번호와 판매 가격을 가져온다.
		    let stockNum = $('.requiredOption :selected').attr('data-stockNum');
		
		    // buyQuantity 함수를 호출하여 상품을 추가
		    buyQuantity(stockNum, gvPrice, selectedOptionDetailNum, 0);
		
		    return false;
		}		
		
		// 옵션이 2개인 경우 -
		$('.requiredOption2 option').each(function(){
			if($(this).is(':first-child')) {
				return true; // continue
			}
			
        	$(this).remove();
        });
		
		// let optionNum2 = $('.requiredOption2').attr('data-optionNum2');
		
		// 재고
		let url = gvContextPath + '/products/listOptionDetailStock';
		const fn = function(data) {
			$(data).each(function(_, item){
				let optionDetailNum = item.optionDetailNum2;
				let optionValue = item.optionValue2;
				let stockNum = item.stockNum;
				let totalStock = parseInt(item.totalStock);
				
				let s;
				s = `<option 
			        value="${optionDetailNum}" 
			        data-optionValue="${optionValue}" 
			        data-stockNum="${stockNum}" 
			        data-totalStock="${totalStock}">
			        ${optionValue}${totalStock < 5 ? ` - 재고 ${totalStock}` : ''}
			    </option>`;		
				
				$('.requiredOption2').append(s);
			});
		};
		
		ajaxRequest(url, 'get', {productId: gvProductCode, productCode:gvProductCode, optionDetailNum:optionDetailNum}, 'json', fn);
	});
	
	// 옵션-2 선택
	$('.requiredOption2').change(function(){
		if(! $(this).val()) {
			return false;
		}

		let optionDetailNum = $('.requiredOption').val();
		let optionDetailNum2 = $(this).val();
		
		let b = true;
		$('.order-box input[name=optionDetailNums2]').each(function(){
			let dnum = $(this).closest('.input-group').find('input[name=optionDetailNums]').val();
			let dnum2 = $(this).val();
			if(optionDetailNum === dnum && optionDetailNum2 === dnum2) {
				alert('선택된 옵션입니다.');
				
				$('.requiredOption').val('');
				$('.requiredOption').trigger('change');
				b = false;
				
				return false;
			}
		});
		
		if(! b) {
			return false;
		}
		
		let stockNum = $('.requiredOption2 :selected').attr('data-stockNum');
		
		buyQuantity(stockNum, gvPrice, optionDetailNum, optionDetailNum2);
	});
	
	
	// 구매 개수
	function buyQuantity(stockNum, price, optionDetailNum, optionDetailNum2) {
		
	    const totalPrice = price.toLocaleString();
	
	    let buyOption = '';
	
	    if (gvOptionCount === 1) {
	        buyOption = $('.requiredOption :selected').attr('data-optionValue');
	    } else if (gvOptionCount === 2) {
	        const optionValue1 = $('.requiredOption :selected').text();
	        const optionValue2 = $('.requiredOption2 :selected').attr('data-optionValue');
	        buyOption = `${optionValue1} / ${optionValue2}`;
	    }
	
	    const itemHtml = `
	        <div class="order-qty">
	            ${gvOptionCount > 0 ? `
	                <div class="mt-2 pb-1">
	                    <label>${buyOption}</label>
	                </div>
	            ` : ''}
	            <div class="row border-bottom mt-1 mb-3 pb-3" style="border-bottom: ">
	                <div class="col">
	                    <div class="input-group">
	                        <i class="bi bi-dash input-group-text bg-white qty-minus"></i>
	                        <input type="text" name="buyQtys" class="form-control" value="1" style="flex:none; width: 60px; text-align: center;" readonly>
	                        <input type="hidden" name="productCodes" value="${gvProductCode}">
	                        <input type="hidden" name="stockNums" value="${stockNum}">
	                        <input type="hidden" name="optionDetailNums" value="${optionDetailNum}" disabled>
	                        <input type="hidden" name="optionDetailNums2" value="${optionDetailNum2}" disabled>
	                        <i class="stockNumsbi bi-plus input-group-text bg-white qty-plus"></i>
	                    </div>
	                </div>
	                <div class="col text-end product-price" data-price="${price}">
	                    <label class="pt-2 fs-6 fw-semibold item-totalPrice">${totalPrice}원</label>
	                    ${gvOptionCount > 0 ? `
	                        <label class="pt-2 ps-1"><i class="bi bi-x qty-remove"></i></label>
	                    ` : ''}
	                </div>
	            </div>
	        </div>
	    `;
	
	    $('.order-box').append(itemHtml);
	
	    totalProductPrice();
		
	}
	
	
	// 수량 더하기
	$('.order-box').on('click', '.qty-plus', function() {
		let totalStock = 0;
		
		if(gvOptionCount === 0) {
			totalStock = parseInt($('.order-box').attr('data-totalStock'));
		} else if(gvOptionCount === 1) {
			totalStock = parseInt($('.requiredOption :selected').attr('data-totalStock'));
		} else if(gvOptionCount === 2) {
			totalStock = parseInt($('.requiredOption2 :selected').attr('data-totalStock'));
		}
		
		let $order = $(this).closest('.order-qty');
		let qty = Number($order.find('input[name=buyQtys]').val()) || 0;
		
		if(qty >= totalStock) {
			alert('재고가 부족합니다.');
			
			return false;
		}
		
		qty++;
		$order.find('input[name=buyQtys]').val(qty);
		let price = $order.find('.product-price').attr('data-price');
		let item = qty * price;
		let totalPrice = item.toLocaleString();
		$order.find('.item-totalPrice').text(totalPrice + '원');
		
		totalProductPrice();
	});

	// 수량 빼기
	$('.order-box').on('click', '.qty-minus', function() {
		let $order = $(this).closest('.order-qty');
		let qty = parseInt($order.find('input[name=buyQtys]').val()) - 1;
		if(qty <= 0) {
			alert('구매 수량은 한개 이상입니다.');
			
			if(gvOptionCount === 0) {
				return false;			
			}
			
			$('.requiredOption').val('');
			$('.requiredOption').trigger('change');
			$order.remove();
			
			totalProductPrice()
			
			return false;
		}
		
		$order.find('input[name=buyQtys]').val(qty);
		let price = $order.find('.product-price').attr('data-price');
		let item = qty * price;
		let totalPrice = item.toLocaleString();
		$order.find('.item-totalPrice').text(totalPrice + '원');
		
		totalProductPrice();
	});
	
	// 수량 제거
	$('.order-box').on('click', '.qty-remove', function() {
		if(gvOptionCount === 0) {
			return false;			
		}
		
		let $order = $(this).closest('.order-qty');
		$('.requiredOption').val('');
		$('.requiredOption').trigger('change');
		$order.remove();
		
		totalProductPrice();
	});
	
	function totalProductPrice() {
		let totalQty = 0;
		let totalPrice = 0;
		$('.order-qty').each(function(){
			let qty = parseInt($(this).find('input[name=buyQtys]').val());
			let price = parseInt($(this).find('.product-price').attr('data-price'));
			
			totalQty += qty;
			totalPrice += (price * qty);
		});
		
		let s = totalPrice.toLocaleString();
		
		$('.product-totalQty').text(totalQty);
		$('.product-totalAmount').text(s);
	}
});

$(function(){
	// 이미지 확대
	$('.sm-img img').click(function(){
		let url = $(this).attr('src');
		$('.lg-img img').attr('src', url);
	});
});

function sendOk(mode) {
	const contextPath = document.getElementById('web-contextPath').value;
	
	let totalQty = 0;
	$('.order-qty').each(function(){
		let qty = parseInt($(this).find('input[name=buyQtys]').val());
		
		totalQty += qty;
	});
	
	if(totalQty <= 0) {
		alert('구매 상품의 수량을 선택하세요 !!! ');
		return;
	}

	const f = document.buyForm;
	if(mode === 'buy') {
		// GET 방식으로 전송. 로그인 후 결제화면으로 이동하기 위해
		// 또는 자바스크립트 sessionStorage를 활용 할 수 있음
		f.method = 'get';
		f.action = contextPath + '/productsOrder/payment';
	} else {
		if(! confirm('선택한 상품을 장바구니에 담으시겠습니까 ? ')) {
			return false;
		}
		
		f.method = 'post';
		f.action = contextPath + '/myShopping/saveCart';
	}
	
	f.submit();
}

// 오늘본 상품 목록
$(function(){
	const pnum = document.getElementById('product-productCode').value;
	const pname = document.getElementById('product-productName').value;
	const pimg = document.getElementById('product-thumbnail').value;
	const price = Number(document.getElementById('product-price').value) || 0;
	
	// localStorage.clear(); // localStorage 전체 지우기
	
	let product = JSON.parse(localStorage.getItem('recentProduct')) || [];
	
	// 동일한 상품이면 삭제
	product.forEach(function(data){
		if(data.pnum === pnum) {
			let idx = product.indexOf(data);
			if(idx > -1) product.splice(idx, 1);
			return;
		}
	});
	/*
	// 필터를 사용한 경우
	let result = product.filter(function(item, index, self){
		return pnum !== item.pnum;
	});
	product = result;
	*/
	
	// 20개 이상이면 마지막 데이터 삭제
	if(product.length >= 20) {
		product.splice(product.length-1, 1);
	}
	
	// 저장할 데이터
	let obj = {pnum:pnum, pname:pname, pimg:pimg, price:price};
	product.unshift(obj); // 배열 가장 앞에 추가
	
	// 웹스트로지에 저장
	let p = JSON.stringify(product);
	localStorage.setItem('recentProduct', p);
});
