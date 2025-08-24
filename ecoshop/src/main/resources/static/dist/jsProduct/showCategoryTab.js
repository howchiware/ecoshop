// 카테고리 ajax
function showCategoryTab(clickButton) {
	let categoryId = clickButton.getAttribute('data-cat-id');
	
	console.log($('#productsSortBy option:eq(0)'));
	$('#productsSortBy option:eq(0)').prop('selected', true);
	let sortBy = $("#productsSortBy option:selected").val();

	if(! sortBy){
		sortBy = 0;
	}
	
	let url = 'products';
	let requestParams = {categoryId:categoryId, page:1, sortBy:sortBy};
	document.querySelectorAll('.category-container .nav-tab').forEach(div => {
		div.classList.remove('active');
	});
	clickButton.classList.add('active');
	
	let selector = 'div.list-container';
		
	const fn = function(data) {
		$(selector).html(data);
	};

	ajaxRequest(url, 'get', requestParams, 'text', fn);
}

$(document).ready(function() {
	const initialCategoryTab = document.querySelector('.category-container .nav-tab.active');
	if (initialCategoryTab) {
		showCategoryTab(initialCategoryTab);
	}
});
		
// 캐러셀
$('.owl-carousel').owlCarousel({
	loop : true,
	margin : 10,
	nav : true,
	center : true,
	autoplay:true,
	autoplayTimeout:4000,
	autoplayHoverPause:true,
	responsive : {
		0 : {
			items : 1
		},
		1000 : {
			items : 3
		}
	}
});

$(function(){
	$('.list-container').on('click', '.card-img', function(){
		let productIdStr = $(this).attr('data-productId');

		let productId = Number(productIdStr);
		
		location.href = productId;
	});
});

function changeSortSelect(){
	let sortBy = $("#productsSortBy option:selected").val();
	listProducts(1);
}

function listProducts(page) {
	let categoryId = '';
	document.querySelectorAll('.category-container .nav-tab').forEach(div => {
		if(div.classList.contains('active')){
			categoryId = div.getAttribute('data-cat-id');
		}
	});
	let sortBy = $("#productsSortBy option:selected").val();

	if(! sortBy){
		sortBy = 0;
	}
	console.log(categoryId);
	
	let url = 'products';
	let requestParams = {categoryId:categoryId, page:page, sortBy:sortBy};
	let selector = 'div.list-container';
	
	const fn = function(data) {
		$(selector).html(data);
	};

	ajaxRequest(url, 'get', requestParams, 'text', fn);
}

/*
// 장바구니 클릭할 시 구매 창 띄우기
// 리뷰 클릭시 모달 띄우기
$(function(){
	$('div.list-container').on('click', 'button.product-item-cart', function(){
		// ajax
		
		console.log(111);
		
		let productCode = $(this).attr('data-productCode');
		const selector = '#productDetailDialogModal' + productCode;
		
		console.log($(selector));
		
		$(selector).modal('show');
		

		const contextPath = document.getElementById('web-contextPath').value;
		let productCode = $(this).attr('data-productCode');

		let url = '/products/viewProductDetail?productCode=' + productCode;

		const fn = function(data) {
			
			let reviewId = data.detailReview.reviewId;
			let name = data.detailReview.name;
			let rate = data.detailReview.rate;
			let content = data.detailReview.content;
			let regDate = data.detailReview.regDate;
			let answer = data.detailReview.answer;
			let answerDate = data.detailReview.answerDate;
			let listReviewImg = data.detailReview.listReviewImg;
			let reviewHelpfulCount = data.detailReview.reviewHelpfulCount;
			let userReviewHelpful = data.detailReview.userReviewHelpful;
			
			let productDetailHtml = ''; // 전체 리뷰 목록을 담을 변수

			// 첨부 파일이 있을 경우 이미지 HTML 생성
			const listPhotoHtml = listPhoto && listPhoto.length > 0
			    ? `
			    <div class="row gx-1 mt-2 mb-1 p-1">
					<div class="row gx-1 p-1">
						<div class="col border rounded lg-img lg-img-modal p-0">
							<img class="w-100 h-100 rounded" src="${contextPath}/uploads/review/${listReviewImg[0]}">
						</div>
			        </div>
					<div class="row gx-1 mt-2 p-1">
						${listPhoto.map(f => `
							<div class="col-md-auto sm-img sm-img-modal">
								<img class="border rounded" src="${contextPath}/uploads/products/${f}">
							</div>
						`).join('')}
					</div>
			    </div>`
			    : ''; // 파일이 없으면 빈 문자열

			const stockAvailable = 	totalStock < 1 ? `	<div class="border rounded mt-2 mb-2 p-2 text-center" style="background: ">
															<label class="text-black-50 fw-bold">상품 재고가 없습니다.</label>
														</div>` : '';

			// 옵션
			const optionHeaderHtml = optionCount > 0 ? `	<div class="row mt-2" style="font-weight: 500">
																* 필수 옵션
															</div>` : '';
															
			const optionSelectHtml = optionCount > 1 ? `<div class="option-select-area" style="padding: 3px 6px;">
																<div class="row mt-2">
																	<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																		<option value="">${listOption[0].optionName}</option>
																		<c:forEach var="vo" items="${listOptionDetail}">
																			<c:if test="${dto.optionCount == 1}">
																				<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
																			</c:if>
																			<c:if test="${dto.optionCount != 1}">
																				<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</div>
											
																<div class="row mt-2">
																	<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																		<option value="">${listOption[1].optionName}</option>
																	</select>
																</div>
															</div>
														</div>` : optionCount > 0 ? `` : ``;

			const answerHtml = answer
			    ? `<div class="p-3 pt-0" style="width: 600px">
				    <div class="bg-light">
				        <div class="p-3 pb-0" style="display: inline-flex; align-items:center;">
							<img src="/dist/images/person.png" class="answer-icon" style="margin: 0px 5px">
				            <label class="px-2 fw-semibold"> 관리자 </label> <label>${answerDate}</label>
				        </div>
				        <div class="p-3 ps-4 pt-2">${answer}</div>
				    </div>
				</div>` : ''; // 답변이 없으면 빈 문자열

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
														<img class="w-100 h-100 rounded" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
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
															${productName}
														</div>
														<div class="price">
															<fmt:formatNumber value="${price}"/>원
														</div>
													</div>
													
													<div class="row infoArea">
														<p class="content">${content}</p>
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
																	<td>${point} 포인트 적립예정</td>
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
														<c:if test="${dto.optionCount > 0}">
															<div class="row mt-2" style="font-weight: 500">
																* 필수 옵션
															</div>
														</c:if>
														
														<div class="option-select-area" style="padding: 3px 6px;">
															<c:if test="${dto.optionCount > 0}">
																<div class="row mt-2">
																	<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																		<option value="">${listOption[0].optionName}</option>
																		<c:forEach var="vo" items="${listOptionDetail}">
																			<c:if test="${dto.optionCount == 1}">
																				<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
																			</c:if>
																			<c:if test="${dto.optionCount != 1}">
																				<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</div>
															</c:if>
										
															<c:if test="${dto.optionCount > 1}">
																<div class="row mt-2">
																	<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																		<option value="">${listOption[1].optionName}</option>
																	</select>
																</div>
															</c:if>
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
														<input type="hidden" name="mode" value="buy">
														<button type="button" class="btn-accent btn-lg w-100 btn-buySend" onclick="sendOk('buy');" ${dto.totalStock < 1 ? 'disabled':''} ${empty sessionScope.member ? 'disabled' : ''}>구매하기</button>
													</div>
													
													<div class="row mt-2 mb-2">
														<div class="col pe-1">
															<button type="button" class="btn-default btn-lg w-100 btn-productLike" data-productCode="${dto.productCode}" ${empty sessionScope.member.memberId ? "disabled" : ""}>찜하기&nbsp;&nbsp;<i class="bi ${dto.userProductLike==1 ? 'bi-heart-fill text-danger':'bi-heart'}"></i></button>
														</div>
														<div class="col ps-1">
															<button type="button" class="btn-default btn-lg w-100 btn-productCart" onclick="sendOk('cart');" ${empty sessionScope.member.memberId || dto.totalStock < 1 ? "disabled" : ""}>장바구니&nbsp;&nbsp;<i class="bi bi-cart-plus"></i></button>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
									
								</div>
							</div>`;
			
			
			$('#productDetailDialogModal .modal-body').html(productDetailHtml);
			$('#productDetailDialogModal').modal('show');

		};

		ajaxRequest(url, 'get', null, 'json', fn);

	});
	
});
*/