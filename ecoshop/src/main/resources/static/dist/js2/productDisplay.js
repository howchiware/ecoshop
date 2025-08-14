// 탭
$(function(){
    $('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		listProducts(tab);
    });	
});


// 카테고리에 맞게 리스트 불러오기
function listProducts(categoryNum) {

	const contextPath = document.getElementById('web-contextPath').value;
	
	let sortBy = $('.productsSortBy').val();
	let url = contextPath + '/products/list';
	
	let requestParams = {categoryNum:categoryNum, sortBy:sortBy};
	
	const fn = function(data) {
		printProducts(data);
	};

	ajaxRequest(url, 'get', requestParams, 'json', fn);
}

function printProducts(data){
	/*
	const contextPath = document.getElementById('web-contextPath').value;
	const { dataCount, summary, list } = data;

	if (dataCount > 0) {
	    $('.reviewSort-area').show();
	} else {
	    $('.reviewSort-area').hide();
	}

	// 요약 정보를 출력하는 함수를 호출
	printSummary(summary);

	let reviewsHtml = ''; // 전체 리뷰 목록을 담을 변수

	if (dataCount > 0) {
	    reviewsHtml = list.map(item => {
	        const { num, name, score, review, review_date, answer, answer_date, listFilename } = item;

	        // 별점 아이콘 HTML 생성
			const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
				if (i < Math.floor(score)) {
					// score의 정수 부분까지는 채워진 별
					return '<i class="bi bi-star-fill"></i> ';
				} else if (i === Math.floor(score) && score % 1 !== 0) {
					// score가 실수이고 현재 인덱스가 정수 부분과 같으면 반쪽 별 (옵션)
					return '<i class="bi bi-star-half"></i> ';
				} else {
					// 나머지는 빈 별
					return '<i class="bi bi-star"></i> ';
				}
			}).join('');

	        // 첨부 파일이 있을 경우 이미지 HTML 생성
	        const filenamesHtml = listFilename && listFilename.length > 0
	            ? `
	            <div class="row gx-1 mt-2 mb-1 p-1">
	                ${listFilename.map(f => `
	                    <div class="col-md-auto md-img">
	                        <img class="border rounded" src="${contextPath}/uploads/review/${f}">
	                    </div>
	                `).join('')}
	            </div>`
	            : ''; // 파일이 없으면 빈 문자열

	        // 관리자 답변이 있을 경우 해당 HTML 생성
	        const answerHtml = answer
	            ? `
	            <div class="p-3 pt-0">
	                <div class="bg-light">
	                    <div class="p-3 pb-0">
	                        <label class="text-bg-primary px-2"> 관리자 </label> <label>${answer_date}</label>
	                    </div>
	                    <div class="p-3 pt-1">${answer}</div>
	                </div>
	            </div>`
	            : ''; // 답변이 없으면 빈 문자열

	        // 각 리뷰 항목에 대한 전체 HTML 구조를 반환
	        return `
	            <div class="mt-3 border-bottom">
	                <div class="row p-2">
	                    <div class="col-auto fs-2"><i class="bi bi-person-circle text-muted icon"></i></div>
	                    <div class="col pt-3 ps-0 fw-semibold">${name}</div>
	                    <div class="col pt-3 text-end">
	                        <span>${review_date}</span>
	                        |<span class="notifyReview" data-num="${num}">신고</span>
	                    </div>
	                </div>
	                <div class="row p-2">
	                    <div class="col-auto pt-0 ps-2 pe-2 score-star">
	                        ${starRatingHtml}
	                    </div>
	                    <div class="col-auto ps-0 fs-6"><span class="align-middle">${score}점<span></div>
	                </div>
	                <div class="mt-2 p-2">${review}</div>
	                ${filenamesHtml}
	                ${answerHtml}
	            </div>
	        `;
	    }).join(''); // 모든 리뷰 항목의 HTML을 하나의 문자열로 결합

	    reviewsHtml += `<div class="page-navigation">${paging}</div>`;
	}
	*/
	
	out = `	<div class="col product-card" data-productCode="1">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/dist/images/Group 303.png"
							class="card-img-top"
							style="position: absolute; width: 100%; height: 100%;"
							alt="...">
					</div>
					<div class="card-body">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-name">리바이브 칫솔</h5>
						<i class="bi bi-heart heart-icon"></i>
					</div>
					<p class="card-price">6000원</p>
						<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
					</div>
				</div>
				<div class="col product-card" data-productCode="2">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/dist/images/Group 308.png"
							class="card-img-top"
							style="position: absolute; width: 100%; height: 100%;"
							alt="...">
					</div>
					<div class="card-body">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-name">리바이브 칫솔</h5>
						<i class="bi bi-heart heart-icon"></i>
					</div>
					<p class="card-price">6000원</p>
						<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
					</div>
				</div>
				<div class="col product-card" data-productCode="3">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/dist/images/Group 313.png"
							class="card-img-top"
							style="position: absolute; width: 100%; height: 100%;"
							alt="...">
					</div>
					<div class="card-body">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-name">리바이브 칫솔</h5>
						<i class="bi bi-heart heart-icon"></i>
					</div>
					<p class="card-price">6000원</p>
						<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
					</div>
				</div>
				<div class="col product-card" data-productCode="4">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/dist/images/Group 303.png"
							class="card-img-top"
							style="position: absolute; width: 100%; height: 100%;"
							alt="...">
					</div>
					<div class="card-body">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-name">리바이브 칫솔</h5>
						<i class="bi bi-heart heart-icon"></i>
					</div>
					<p class="card-price">6000원</p>
						<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
					</div>
				</div>
				<div class="col product-card" data-productCode="5">
					<div class="card">
						<img
							src="${pageContext.request.contextPath}/dist/images/Group 313.png"
							class="card-img-top"
							style="position: absolute; width: 100%; height: 100%;"
							alt="...">
					</div>
					<div class="card-body">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-name">리바이브 칫솔</h5>
						<i class="bi bi-heart heart-icon"></i>
					</div>
					<p class="card-price">6000원</p>
						<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
					</div>
				</div>`;

	$('.list-container').html(out);
}

$(function(){
	// 상품명을 클릭한 경우
	$('.product-section').on('click', '.product-item-detial', function(){
		const $item = $(this).closest('.product-item');
		const productNum = $item.attr('data-productNum');
		
		let url = '${pageContext.request.contextPath}/products/' + productNum;
		location.href = url;
	});
	
	// 장바구니를 클릭한 경우
	$('.product-section').on('click', '.product-item-cart', function(){
		const $item = $(this).closest('.product-item');
		const productNum = $item.attr('data-productNum');
		
		let url = '${pageContext.request.contextPath}/products/' + productNum;
		location.href = url;
	});
});

// 찜
$(function(){
	// 상품 리스트에서 찜을 클릭한 경우
	$('.product-section').on('click', '.product-item-heart', function(){
		const $item = $(this).closest('.product-item');
		const productNum = $item.attr('data-productNum');
		
		const bLogin = Number('${empty sessionScope.member ? 0 : 1}') || 0;
		if(! bLogin) {
			location.href = '${pageContext.request.contextPath}/member/login';
			return false;
		}
		
		sendWish(productNum, $(this));
	});
	
	// 상품 상세 보기에서 찜을 클릭한 경우
	$('.btn-productBlind').on('click', function(){
		const productNum = $(this).attr('data-productNum');
		
		const bLogin = Number('${empty sessionScope.member ? 0 : 1}') || 0;
		if(! bLogin) {
			location.href = '${pageContext.request.contextPath}/member/login';
			return false;
		}
		
		sendWish(productNum, $(this));
	});
});

//  찜 등록 또는 해제
function sendWish(productNum, $el) {
	const bFlag = $el.find('i').hasClass('bi-heart-fill');
	
	let method, msg;
	if(bFlag) {
		method = 'delete';
		msg = '상품에 대한 찜을 해제 하시겠습니까 ?';
	} else {
		method = 'post';
		msg = '상품을 찜 목록에 등록하시겠습니까 ?';
	}
	
	if(! confirm(msg)) {
		return;
	}
	
	const params = {productNum: productNum};
	let url = '${pageContext.request.contextPath}/myShopping/wish/' + productNum;
	
	const fn = function(data) {
		const state = data.state;
		
		if(state === 'false') {
			return false;
		}
		
		if(bFlag) {
			$el.find('i').removeClass('bi-heart-fill text-danger').addClass('bi-heart');
		} else {
			$el.find('i').removeClass('bi-heart').addClass('bi-heart-fill text-danger');
		}
	};
	
	ajaxRequest(url, method, params, 'json', fn);	
}