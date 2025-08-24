$(function(){
    $('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		if(tab === '2') { 
			listReview(1);
		} else if( tab === '3') { 
			listInquiry(1);
		}
    });	

	// 리뷰 정렬 기준 클릭 시
	$('ul.reviewSortBy li').click(function(){
		let liEls = $('ul.reviewSortBy li');
		
		liEls.each(function(){
			if($(this).hasClass('clicked')){
				$(this).removeClass('clicked');
			}
		});
		
		$(this).addClass('clicked');
		listReview(1);
	});

	// 상품 문의 대화상자 열기 버튼 클릭 시
	$('.inquiry-add-btn').click(function(){
		$('#inquiryDialogModal').modal('show');
	});

	// 문의사항 디테일 보기 - 제목 클릭 시 디테일 창 토글
	$('div.detailTabList').on('click', 'td.inquiryTitle', function(){
		const $inquiryDetailTr = $(this).parent().next();
		const $table = $(this).closest('table');
		
		let isSecret = $(this).parent().hasClass('secret-inquiry');
		let isMyInquiry = $(this).parent().hasClass('myInquiry');
		
		if($inquiryDetailTr.hasClass('d-none') && (! isSecret || isMyInquiry)){
			$table.children().find('tr.inquiryDetailTr').addClass('d-none'); 
			$inquiryDetailTr.removeClass('d-none'); 
		} else if(! $inquiryDetailTr.hasClass('d-none') && (! isSecret || isMyInquiry)) {
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			$inquiryDetailTr.addClass('d-none');
		} else if (isSecret && !isMyInquiry) {
			alert('비밀글은 작성자만 확인할 수 있습니다.');
		}
	});

	// 리뷰 상세 보기 모달 띄우기
	$('div.detailTabList').on('click', 'span.viewReviewDetail-span', function(){
		const contextPath = document.getElementById('web-contextPath').value;
		let reviewId = $(this).attr('data-reviewId');

		let url = contextPath + '/gongguReview/viewReviewDetail?reviewId=' + reviewId; 

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
			
			let reviewsHtml = ''; 

			const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
				if (i < Math.floor(rate)) {
					return '<i class="bi bi-star-fill text-warning"></i> ';
				} else if (i === Math.floor(rate) && rate % 1 !== 0) {
					return '<i class="bi bi-star-half text-warning"></i> ';
				} else {
					return '<i class="bi bi-star text-warning"></i> ';
				}
			}).join('');

			const imgNamesHtml = listReviewImg && listReviewImg.length > 0
			    ? `
			    <div class="row gx-1 mt-2 mb-1 p-1">
					<div class="row gx-1 p-1">
						<div class="col border rounded lg-img lg-img-modal p-0">
							<img class="w-100 h-100 rounded" src="${contextPath}/uploads/review/${listReviewImg[0]}">
						</div>
			        </div>
					<div class="row gx-1 mt-2 p-1">
						${listReviewImg.map(f => `
				            <div class="col-md-auto sm-img sm-img-modal">
				                <img class="border rounded" src="${contextPath}/uploads/review/${f}">
				            </div>
				        `).join('')}
					</div>
			    </div>`
			    : '';

			const answerHtml = answer
			    ? `<div class="p-3 pt-0" style="width: 600px">
				    <div class="bg-light">
				        <div class="p-3 pb-0" style="display: inline-flex; align-items:center;">
							<img src="/dist/images/person.png" class="answer-icon" style="margin: 0px 5px">
				            <label class="px-2 fw-semibold"> 관리자 </label> <label>${answerDate}</label>
				        </div>
				        <div class="p-3 ps-4 pt-2">${answer}</div>
				    </div>
				</div>` : '';

			reviewsHtml =  `
						<div class="reviewTd" data-reviewId="${reviewId}">
							<div class="row ms-1 me-1 mt-3 border-bottom">
					            <div class="col-9 p-2">
					            	<div class="row">
					                    <div class="col-auto pt-0 ps-2 pe-2 rate-star">
									    	${starRatingHtml}
					                    </div>
									</div>
					            	<div class="row">
						                <div class="mt-2 p-2">${content}</div>
						                ${imgNamesHtml}               		
					            	</div>
					            	<div class="row">
					            		<div class="p-2" style="display: inline-flex; align-items: center;" data-userReviewHelpful="${userReviewHelpful}">
					            			<p style="margin: 0px; margin-right: 10px;">${reviewHelpfulCount}명에게 도움된 리뷰</p>
										<button type="button" class="btnSendHelpful" data-reviewId=${reviewId} data-reviewHelpful="1"><i class="bi bi-hand-thumbs-up" style="${userReviewHelpful===1? 'color:#0d6efd;':''}"></i>&nbsp;<span>도움이 돼요</span></button>
										<button type="button" class="btnSendHelpful" data-reviewId=${reviewId} data-reviewHelpful="0"><i class="bi bi-hand-thumbs-down" style="${userReviewHelpful==0? 'color:red;':''}"></i>&nbsp;<span>도움이 안돼요</span></button>
					            		</div>
					            	</div>
					            </div>
					            <div class="col-3 p-2">
					            	<div class="row" style="display: inline">
					                	<i class="bi bi-person-circle text-muted icon"></i>
					                    <span class="col pt-3 ps-0 fw-semibold">${name}</span>
					                </div>
					                <div class="row pt-3">
					                    <span>${regDate}</span>
					                </div>
					            </div>
					            ${answerHtml}
					        </div>
						</div>
					</div>`;
			
			$('#reviewDetailDialogModal .modal-body').html(reviewsHtml);
			$('#reviewDetailDialogModal').modal('show');

		};

		ajaxRequest(url, 'get', null, 'json', fn);
	});
	
	// 리뷰 상세 모달 내 이미지 확대
	$('div.detailTabList').on('click', '#reviewDetailDialogModal .sm-img-modal img', function(){
		let url = $(this).attr('src');
		$('#reviewDetailDialogModal .lg-img-modal img').attr('src', url);
	});
	
	// 리뷰 도움돼요/안돼요
	$('div.detailTabList').on('click', '.btnSendHelpful', function(){
		const contextPath = document.getElementById('web-contextPath').value;
		const $btn = $(this);
		const $i = $(this).find('i');
		let reviewId = $btn.attr('data-reviewId');
		let reviewHelpful = $btn.attr('data-reviewHelpful');
		let isReviewHelpful = $btn.parent('div').attr('data-userReviewHelpful') === '1';
		let isNotReviewHelpful = $btn.parent('div').attr('data-userReviewHelpful') === '0';
		
		if(reviewHelpful == 1 && isNotReviewHelpful || reviewHelpful == 0 && isReviewHelpful){
			alert('리뷰 도움여부가 이미 등록되어 있습니다.'); 
			return;
		}
		
		let msg = '리뷰가 도움이 되지 않으십니까 ? ';
		if(reviewHelpful === '1' && ! isReviewHelpful){
			msg = '리뷰가 도움이 되십니까 ? ';
		} else if (reviewHelpful === '1' && isReviewHelpful){
			msg = '리뷰 도움돼요를 취소하시겠습니까 ? ';
		} else if (reviewHelpful === '0' && isNotReviewHelpful){
			msg = '리뷰 도움 안돼요를 취소하시겠습니까 ? ';
		}
		
		if(! confirm(msg)){ 
			return false;
		}
		
		let url = contextPath + '/gongguReview/insertReviewHelpful'; 
		let params = {reviewId:reviewId, reviewHelpful:reviewHelpful, isReviewHelpful:isReviewHelpful, isNotReviewHelpful:isNotReviewHelpful};
		
		const fn = function(data){
			let state = data.state;
			if(state === 'true'){
				if(isReviewHelpful || isNotReviewHelpful){
					$i.css('color', '');
				} else if(reviewHelpful === '1') {
					$i.css('color', '#0d6efd');
				} else if(reviewHelpful === '0'){
					$i.css('color', 'red');
				}
				
				console.log(data.helpfulCount);
				console.log(data.userReviewHelpful);
				let helpfulCount = data.helpfulCount;
				let userReviewHelpful = data.userReviewHelpful;
				
				$btn.parent('div').find('p').html(helpfulCount + '명에게 도움된 리뷰');
				$btn.parent('div').attr('data-userReviewHelpful', userReviewHelpful);

			} else if(state === 'liked'){
				alert('리뷰 도움 여부는 한번만 가능합니다.'); 
			} else if(state === 'noLogin'){
				alert('로그인 후 가능합니다.'); 
			} else {
				alert('리뷰 도움 여부 처리가 실패했습니다.'); 
			}
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});


window.addEventListener('DOMContentLoaded', () => {
	// 리뷰 작성 모달 관련
	var sel_files = []; 
	const reviewImageListEL = document.querySelector('form[name="reviewForm"] .image-upload-list');
	const reviewInputEL = document.querySelector('form[name="reviewForm"] input[name=selectFile]');
	
	const transferReviewFiles = () => {
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		reviewInputEL.files = dt.files;
	}

	// 리뷰 이미지 파일 선택 변경 시
	reviewInputEL.addEventListener('change', ev => {
		if(! ev.target.files || ! ev.target.files.length) {
			transferReviewFiles();
			return;
		}
		
		for(let file of ev.target.files) {
			if(! file.type.match('image.*')) {
				continue;
			}

			sel_files.push(file);
        	
			let node = document.createElement('img');
			node.classList.add('image-item');
			node.setAttribute('data-filename', file.name);

			const reader = new FileReader();
			reader.onload = e => {
				node.setAttribute('src', e.target.result);
			};
			reader.readAsDataURL(file);
        	
			reviewImageListEL.appendChild(node);
		}
		
		transferReviewFiles();		
	});
	
	// 리뷰 이미지 클릭 시 삭제
	reviewImageListEL.addEventListener('click', (e)=> {
		if(e.target.matches('.image-item')) {
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) { 
				return false;
			}
			
			let filename = e.target.getAttribute('data-filename');
			
			for(let i = 0; i < sel_files.length; i++) {
				if(filename === sel_files[i].name){
					sel_files.splice(i, 1);
					break;
				}
			}
		
			transferReviewFiles();
			
			e.target.remove();
		}
	});
	
	// 리뷰 작성 폼 제출 버튼 클릭 시
	$('.btnReviewSendOk').click(function(){
		const f = document.reviewForm;
		let s;
		
		if(f.orderDetailId.value === '0') { 
			alert('구매일을 선택해주세요.');
			return false;
		}
		if(f.rate.value === '0') {
			alert('평점은 1점부터 가능합니다.'); 
			return false;
		}
		s = f.content.value.trim();
		if( ! s ) {
			alert('리뷰 내용을 입력하세요.'); 
			f.content.focus();
			return false;
		}
		
		if(f.selectFile.files.length > 5) {
			alert('이미지는 최대 5개까지 가능합니다.'); 
			return false;
		}
		
		const contextPath = document.getElementById('web-contextPath').value;
		const url = contextPath + '/gongguReview/write'; 
		
		let formData = new FormData(f); 
		
		const fn = function(data) {
			if(data.state === 'true') {
				f.reset();
				$('.review-form .image-item').each(function(){ 
					$(this).remove();
				});
				sel_files.length = 0; 
				
				$('#reviewDialogModal').modal('hide');
				
				listReview(1); 
			} else {
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true);
	});
	
	// 리뷰 작성 폼 취소 버튼 클릭 시
	$('.btnReviewSendCancel').click(function(){
		const f = document.reviewForm;
		f.reset();
		$('.review-form .image-item').each(function(){ 
			$(this).remove();
		});
		sel_files.length = 0;
		
		$('#reviewDialogModal').modal('hide');
	});		

	// 별점 기능 
	$('.review-form .star a').click(function(e){
		let b = $(this).hasClass('on');
		$(this).parent().children('a').removeClass('on');
		$(this).addClass('on').prevAll('a').addClass('on');
		
		if (b) { 
			$(this).removeClass('on');
		}
		
		let s = $(this).closest('.review-form').find('.star .on').length;
		$(this).closest('.review-form').find('input[name=rate]').val(s);
		
		return false; 
	});

	// 문의 작성 폼 제출 버튼 클릭 시
	$('.btnInquirySendOk').click(function(){
		const f = document.inquiryForm;
		let title = f.title.value.trim();
		if( ! title ){
			alert('문의 제목을 입력하세요.');
			f.title.focus();
			return false;
		}
		
		let content = f.content.value.trim();
		if( ! content ) {
			alert('문의 사항을 입력하세요.'); 
			f.content.focus();
			return false;
		}
		
		const contextPath = document.getElementById('web-contextPath').value;
		const url = contextPath + '/gongguInquiry/write'; 
		
		let formData = new FormData(f); 
		
		const fn = function(data) {
			if(data.state === 'true') {
				f.reset();
				$('#inquiryDialogModal').modal('hide');
				listInquiry(1); 
			} else if(data.state === 'noLogin'){
				alert('로그인 후 문의 가능합니다.'); 
				$('#inquiryDialogModal').modal('hide');
			} else {
				alert('문의 등록에 실패했습니다.'); 
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true);
	});
	
	// 문의 작성 폼 취소 버튼 클릭 시
	$('.btnInquirySendCancel').click(function(){
		const f = document.inquiryForm;
		f.reset();
		$('#inquiryDialogModal').modal('hide');
	});	
});

// 리뷰 목록 조회 및 출력 
function listReview(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const gongguProductId = document.getElementById('gonggu-gongguProductId').value; 
	
	let clickedLiEl = $('ul.reviewSortBy li.clicked');
	let clickedAEl = clickedLiEl.children().first();
	let sortBy = clickedAEl.attr('data-value');

	if(! sortBy){
		sortBy = 0; 
	}
	
	let url = contextPath + '/gongguReview/list';
	let requestParams = {gongguProductId:gongguProductId, pageNo:page, sortBy:sortBy}; 
	
	const fn = function(data) {
		printReview(data);
	};

	ajaxRequest(url, 'get', requestParams, 'json', fn);
}

function printReview(data) {
	const contextPath = document.getElementById('web-contextPath').value;
    const { dataCount, paging, summary, list } = data;
	$('.list-review').show();
 
    printSummary(summary); 

    let reviewsHtml = '';

    if (dataCount > 0) {
        reviewsHtml = list.map(item => {
            const { reviewId, name, rate, content, regDate, answer, answerDate, listReviewImg, reviewHelpfulCount, userReviewHelpful } = item;

            const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
				if (i < Math.floor(rate)) {
					return '<i class="bi bi-star-fill text-warning"></i> ';
				} else if (i === Math.floor(rate) && rate % 1 !== 0) {
					return '<i class="bi bi-star-half text-warning"></i> ';
				} else {
					return '<i class="bi bi-star text-warning"></i> ';
				}
			}).join('');

            const imgNamesHtml = listReviewImg && listReviewImg.length > 0
                ? `
                <div class="row gx-1 mt-2 mb-1 p-1">
                    ${listReviewImg.map(f => `
                        <div class="col-md-auto md-img">
                            <img class="border rounded" src="${contextPath}/uploads/review/${f}">
                        </div>
                    `).join('')}
                </div>`
                : '';

            const answerHtml = answer
                ? `<div class="p-3 pt-0" style="width: 700px">
				    <div class="bg-light">
				        <div class="p-3 pb-0" style="display: inline-flex; align-items:center;">
							<img src="/dist/images/person.png" class="answer-icon" style="margin: 0px 5px">
				            <label class="px-2 fw-semibold"> 관리자 </label> <label>${answerDate}</label>
				        </div>
				        <div class="p-3 ps-4 pt-2">${answer}</div>
				    </div>
				</div>` : '';

            return `
				<div class="reviewTd" data-reviewId="${reviewId}">
					<div class="row ms-1 me-1 mt-3 border-bottom">
		                <div class="col-10 p-2">
		                	<div class="row">
			                    <div class="col-auto pt-0 ps-2 pe-2 rate-star">
							    	${starRatingHtml}
			                    </div>
							</div>
		                	<div class="row">
				                <div class="mt-2 p-2">${content}</div>
				                ${imgNamesHtml}           
								<div class="mt-2 mb-2"><span class="viewReviewDetail-span" data-reviewId=${reviewId}>리뷰 상세 보기</span></div>   		
		                	</div>
		                	<div class="row">
		                		<div class="p-2" style="display: inline-flex; align-items: center;" data-userReviewHelpful="${userReviewHelpful}">
		                			<p style="margin: 0px; margin-right: 10px;">${reviewHelpfulCount}명에게 도움된 리뷰</p>
									<button type="button" class="btnSendHelpful" data-reviewId=${reviewId} data-reviewHelpful="1"><i class="bi bi-hand-thumbs-up" style="${userReviewHelpful===1? 'color:#0d6efd;':''}"></i>&nbsp;<span>도움이 돼요</span></button>
									<button type="button" class="btnSendHelpful" data-reviewId=${reviewId} data-reviewHelpful="0"><i class="bi bi-hand-thumbs-down" style="${userReviewHelpful==0? 'color:red;':''}"></i>&nbsp;<span>도움이 안돼요</span></button>
		                		</div>
		                	</div>
		                </div>
		                <div class="col-2 p-2">
	                    	<div class="row" style="display: inline">
		                    	<i class="bi bi-person-circle text-muted icon"></i>
			                    <span class="col pt-3 ps-0 fw-semibold">${name}</span>
			                </div>
		                    <div class="row pt-3">
		                        <span>${regDate}</span>
		                    </div>
		                </div>
		                ${answerHtml}
		            </div>
				</div>`;
        }).join('');

        reviewsHtml += `<div class="page-navigation">${paging}</div>`;
    }

	if (dataCount > 0) {
	    $('.list-review').html(reviewsHtml);
	} else {
		let pTag = '<p>해당 평점의 리뷰가 존재하지 않습니다.</p>';
	    $('.list-review').html(pTag);
	}
}

function printSummary(summary) {
    const { count, ave } = summary;

    $('.product-reviewCount').text(count);
    $('.product-rate').text(`(${ave} / 5)`);
	const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
		if (i < Math.floor(ave)) {
			return '<i class="bi bi-star-fill text-warning"></i> ';
		} else if (i === Math.floor(ave) && ave % 1 >= 0.5) {
			return '<i class="bi bi-star-half text-warning"></i> ';
		} else {
			return '<i class="bi bi-star text-warning"></i> ';
		}
	}).join('');    
    $('.product-star').html(starRatingHtml);
    $('.title-reviewCount').text(`(${count})`);
    $('.review-reviewCount').text(count);
    $('.review-rate').text(`${ave} / 5`);
    $('.review-rate').addClass('ps-3');
    $('.review-rate-star').html(starRatingHtml);
}

// 리뷰 작성 모달
function reviewWrite(){
	const contextPath = document.getElementById('web-contextPath').value;
	let gongguProductId = document.getElementById('gonggu-gongguProductId').value; 
	
	let url = contextPath + '/gongguReview/listMyOrder?gongguProductId=' + gongguProductId; 
	
	const fn = function(data) {
		const { didIBuyThis } = data;
		
		let optionsHtml = '';

		if (didIBuyThis.length !== 0) {
			optionsHtml = didIBuyThis.map(item => {
	            const { orderDate, gongguOrderDetailId } = item; 
				return `<option value="${gongguOrderDetailId}">${orderDate} 구매</option>`;
			}).join('');
		}
		
		let firstOption = `<option value="0">선택</option>`;
		$('.myOrder-select').html(firstOption + optionsHtml);
		$('#reviewDialogModal').modal('show');
	};

	ajaxRequest(url, 'get', null, 'json', fn);
}

// 문의 목록 조회 및 출력 
function listInquiry(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const gongguProductId = document.getElementById('gonggu-gongguProductId').value; 
	
	let url = contextPath + '/gongguInquiry/list'; 
	let params = {gongguProductId:gongguProductId, pageNo:page}; 
	
	const fn = function(data) {
		printInquiry(data);
	};

	ajaxRequest(url, 'get', params, 'json', fn);
}

function printInquiry(data) {

	const contextPath = document.getElementById('web-contextPath').value;	
    const { dataCount, paging, list } = data;

    $('.title-qnaCount').html(`(${dataCount})`); 

    let out = '';

    if (dataCount > 0) {
        out = `<table class="inquiry-table table">
					<tbody>
						<tr>
							<td class="table-header" width="150px">상태</td>
							<td class="table-header">제목</td>
							<td class="table-header" width="150px">작성자</td>
							<td class="table-header" width="230px">등록일</td>
						</tr>`;
		
		out += list.map(item => {
            const { inquiryId, name, title, content, regDate, answer, answerDate, secret, deletePermit } = item;
            const answerState = answerDate ? `<td class="inquiryStatus" data-inquiryId="${inquiryId}" width="150px">답변완료</td>` : `<td class="inquiryStatus" data-inquiryId="${inquiryId}" width="150px">답변대기</td>`;
			
			const isMyInquiry = deletePermit === 1 ? 'myInquiry' : '';
			const isSecretInquiry = secret === 1 ? 'secret-inquiry' : '';
			const isSecretTitle = secret === 1 ? 'secret' : '';
			
			const inquirySimple = answerState + `<td class="inquiryTitle ${isSecretTitle}" data-inquiryId="${inquiryId}">${title}</td>
									<td class="inquiryName" data-inquiryId="${inquiryId}" width="150px">${name}</td>
									<td class="inquiryDate" data-inquiryId="${inquiryId}" width="230px">${regDate}</td>`;
			
			const deleteAvailable = deletePermit === 1 ? `<p class="myInquiryDelete">삭제</p>` : '';

			const answerContent = answer ? `<hr class="inquireDivider">
												<div class="inquireDetailAnswer">
													<img src="${contextPath}/dist/images/person.png" class="answer-icon">
													<div class="inquiryDetailNDC">
														<div class="inquiryDetailAnswerND">
															<p class="inquiryDetailAnswerName">관리자</p>
															<p class="inquiryDetailAnswerDate">${answerDate}</p>
														</div>
														<div class="inquireDetailAnswerContent">
															<p class="answerContent">${answer}</p>
														</div>
													</div>
												</div>` : '';

			const inquiryDetail = `<tr class="inquiryDetailTr d-none">
										<td colspan="4">
											<div class="">
												<div id="inquiryDetail${inquiryId}" class="inquiry-detailInfo">
													<div class="inquiryDetailHeader">
														<img src="${contextPath}/dist/images/person.png" class="user-icon">
														<div class="inquiryDetailNTD">
															<p class="inquiryDetailTitle">${title}</p>
															<div class="inquiryDetailTD">
																<p class="inquiryDetailName">${name}</p>
																<p class="inquiryDetailDate">${regDate}</p>
																${deleteAvailable}
															</div>
														</div>
													</div>
													<hr class="inquireDivider">
													<div class="inquiryDetailBody">
														<div class="inquireDetailContent" style="color: black">
															<p class="content">${content}</p>
														</div>
														${answerContent}
													</div>
												</div>
											</div>
										</td>
									</tr>`;	

            return `
				<tr class="inquiryTr ${isSecretInquiry} ${isMyInquiry}" data-inquiryId="${inquiryId}">
					${inquirySimple}
				</tr>
				${inquiryDetail}
            `;
        }).join('');

        out += `</tbody></table></div><div class="page-navigation">${paging}</div>`;
    }

    $('.list-inquiry').html(out);
}

// 문의 삭제 버튼 클릭 시
$(function(){
	$('div.detailTabList').on('click', 'p.myInquiryDelete', function(){
		const contextPath = document.getElementById('web-contextPath').value;
		const $tr = $(this).closest('tr').prev(); 
		let inquiryId = $tr.attr('data-inquiryId');
		
		if(! confirm('해당 문의를 삭제하시겠습니까 ?')){ 
			return;
		}
		
		const url = contextPath + '/gongguInquiry/delete?inquiryId=' + inquiryId; 
		
		const fn = function(data) {
			if(data.state === 'true') {
				listInquiry(1); 
			} else {
				alert('문의 삭제에 실패했습니다.'); 
			}
		};
				
		ajaxRequest(url, 'post', null, 'json', fn, true);
	});
});
