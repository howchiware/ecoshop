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


// 장바구니 클릭할 시 구매 창 띄우기
// 리뷰 클릭시 모달 띄우기
$(function(){
	$('div.list-container').on('click', 'button.product-item-cart', function(){
		// ajax
		/*
		let productCode = $(this).attr('data-productCode');
		const $sel = '#productDetailDialogModal' + productCode;
		
		console.log($sel);
		$($sel).modal('show');
		*/

		const contextPath = document.getElementById('web-contextPath').value;
		const memberId = document.getElementById('web-memberId').value;
		let productCode = $(this).attr('data-productCode');

		let url = '/products/viewProductDetail?productCode=' + productCode;

		const fn = function(data) {
			console.log(data);
			
			let dto = data.dto;
			let listPhoto = data.listPhoto;
			let listOptionDetail = data.listOptionDetail;
			let listOption = data.listOption;
			
			let productDetailHtml = ''; // 전체 리뷰 목록을 담을 변수

			// 첨부 파일이 있을 경우 이미지 HTML 생성
			const listPhotoHtml = listPhoto && listPhoto.length > 0
			    ? `
			    <div class="row gx-1 mt-2 mb-1 p-1">
					<div class="row gx-1 mt-2 p-1">
						${listPhoto.map(f => `
							<div class="col-3 sm-img sm-img-modal">
								<img class="w-100 h-100 border rounded" src="${contextPath}/uploads/products/${f.photoName}">
							</div>
						`).join('')}
					</div>
			    </div>`
			    : ''; // 파일이 없으면 빈 문자열

			const stockAvailable = 	dto.totalStock < 1 ? `	<div class="border rounded mt-2 mb-2 p-2 text-center" style="background: ">
															<label class="text-black-50 fw-bold">상품 재고가 없습니다.</label>
														</div>` : '';
			// 옵션
			const optionHeaderHtml = dto.optionCount > 0 ? `	<div class="row mt-2" style="font-weight: 500">
																* 필수 옵션
															</div>` : '';

			const disabled = dto.totalStock < 1 || ! memberId ? 'disabled' : '';
															
			const optionFirstHtml1 = dto.optionCount > 0 && dto.optionCount == 1 ? `<div class="row mt-2">
																						<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${disabled}>
																							<option value="">${listOption[0].optionName}</option>
																							${listOptionDetail.map(vo => `
																								<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}</option>
																							`).join('')}
																						</select>
																					</div>` : '';
																					
			const optionFirstHtml2 = dto.optionCount > 0 && dto.optionCount != 1 ? `<div class="row mt-2">
																						<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${disabled}>
																							<option value="">${listOption[0].optionName}</option>
																							${listOptionDetail.map(vo => `
																								<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
																							`).join('')}
																						</select>
																					</div>` : '';
			
			const optionSecondHtml = dto.optionCount > 1 ? `<div class="row mt-2">
																<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${disabled}>
																	<option value="">${listOption[1].optionName}</option>
																</select>
															</div>` : '';											


			// 각 리뷰 항목에 대한 전체 HTML 구조를 반환
			productDetailHtml =  `
							<div>
								<div class="row gy-4" >
							
									<div class="col-md-12">
										<div class="row">
											<!-- 좌측 이미지 -->
											<div class="col-md-6 p-2 pe-5">
												<div class="row gx-1 p-1">
													<div class="col border rounded lg-img p-0">
														<img class="w-100 h-100 rounded" src="${contextPath}/uploads/products/${dto.thumbnail}">
													</div>
												</div>
												${listPhotoHtml}
											</div>
											
											<!-- 우측 화면-->
											<div class="col-md-6 ps-4">
												<form name="buyForm">
													${stockAvailable}
													<div class="row pt-2 border-bottom namePrice">
														<div class="col productName mb-2">
															${dto.productName}
														</div>
														<div class="price">
															<fmt:formatNumber value="${dto.price}"/>${dto.price}원
														</div>
													</div>
													
													<div class="row infoArea">
														<p class="content">${dto.content}</p>
													</div>
													
													<div class="row mt-2">
														<table class="info-table">
															<tbody>
																<tr>
																	<td>브랜드</td>
																	<td>ecobrand 샵</td>
																</tr>
																<tr>
																	<td>구매혜택</td>
																	<td>${dto.point} 포인트 적립예정</td>
																</tr>
																<tr>
																	<td>배송 방법</td>
																	<td>택배</td>
																</tr>
																<tr>
																	<td>배송비</td>
																	<td>3,000원 (30,000원 이상 무료배송)<br>도서산간 배송비 추가</td>
																</tr>
															</tbody>
														</table>
													</div>
															
													<div class="option-area">
														${optionHeaderHtml}
														
														<div class="option-select-area" style="padding: 3px 6px;">
															${optionFirstHtml1}
															${optionFirstHtml2}
															${optionSecondHtml}										
															
														</div>
													</div>
																			
													<div class="row pb-2 order-area">
														<div class="order-box">
															
														</div>
												        
														<div class="total-div">
															<div class="col-auto fw-semibold pt-1 total">총상품금액 (<span class="product-totalQty">0</span>개)</div>
															<div class="col text-end">
																<label><span class="product-totalAmount fs-5 fw-semibold text-primary">0</span><span class="fw-semibold fs-6 text-primary">원</span></label>
															</div>
														</div>
													</div>
													
								
													<div class="mt-2">
														<button type="button" class="btn-default btn-lg w-100 btn-productCart" onclick="sendOk('cart');" ${disabled}>장바구니&nbsp;&nbsp;<i class="bi bi-cart-plus"></i></button>
													</div>
				
												</form>
											</div>
										</div>
									</div>
									
								</div>
							</div>`;
							
			const inputHtml = `
								<input type="hidden" id="product-productCode" value="${dto.productCode}">
								<input type="hidden" id="product-productName" value="${dto.productName}">
								<input type="hidden" id="product-optionCount" value="${dto.optionCount}">
								<input type="hidden" id="product-price" value="${dto.price}">
								<input type="hidden" id="product-salePrice" value="${dto.sale}">
								<input type="hidden" id="product-stockNum" value="${dto.stockNum}">
								<input type="hidden" id="product-totalStock" value="${dto.totalStock}">
								<input type="hidden" id="product-thumbnail" value="${dto.thumbnail}">
								`;
			
			
			$('#productDetailDialogModal .modal-body').html(productDetailHtml);
			$('#product-template').html(inputHtml);
			$('#productDetailDialogModal').modal('show');
			func();

		};

		ajaxRequest(url, 'get', null, 'json', fn);
	});
	
});

function func(){
		
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
	$('.sm-img img').click(function(){
		let url = $(this).attr('src');
		$('.lg-img img').attr('src', url);
	});

}

$(function(){
	// 이미지 확대
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