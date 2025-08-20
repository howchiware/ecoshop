// 탭
$(function(){
    $('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		if(tab === '2') { // review
			listReview(1);
		} else if( tab === '3') { // qna
			listInquiry(1);
		}
    });	
});

/*
// 리뷰
$(function(){
	$('.reviewSortBy').change(function(){
		listReview(1);
	});
});

function listReview(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const productCode = document.getElementById('product-productCode').value;
	
	let sortBy = $('.reviewSortBy').val();
	let url = contextPath + '/review/list';
	let requestParams = {productCode:productCode, pageNo:page, sortBy:sortBy};
	
	const fn = function(data) {
		printReview(data);
	};

	ajaxRequest(url, 'get', requestParams, 'json', fn);
}
*/

// 리뷰
$(function(){
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
});

function listReview(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const productCode = document.getElementById('product-productCode').value;
	
	let clickedLiEl = $('ul.reviewSortBy li.clicked');
	let clickedAEl = clickedLiEl.children().first();
	let sortBy = clickedAEl.attr('data-value');

	if(! sortBy){
		sortBy = 0;
	}
	
	let url = contextPath + '/review/list';
	let requestParams = {productCode:productCode, pageNo:page, sortBy:sortBy};
	
	const fn = function(data) {
		printReview(data);
	};

	ajaxRequest(url, 'get', requestParams, 'json', fn);
}
/*
$(function(){
	$('ul.reviewSortBy li').click(function(){
		const sortBy = $(this).attr('data-value');
		
		console.log(sortBy);
	});
});
*/

function printReview(data) {
	const contextPath = document.getElementById('web-contextPath').value;
    const { dataCount, paging, summary, list } = data;
	$('.list-review').show();
 

    // 요약 정보를 출력하는 함수를 호출
    printSummary(summary);

    let reviewsHtml = ''; // 전체 리뷰 목록을 담을 변수

    if (dataCount > 0) {
        reviewsHtml = list.map(item => {
            const { reviewId, name, rate, content, regDate, answer, answerDate, listReviewImg } = item;

            // 별점 아이콘 HTML 생성
			const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
				if (i < Math.floor(rate)) {
					// rate의 정수 부분까지는 채워진 별
					return '<i class="bi bi-star-fill text-warning"></i> ';
				} else if (i === Math.floor(rate) && rate % 1 !== 0) {
					// rate가 실수이고 현재 인덱스가 정수 부분과 같으면 반쪽 별 (옵션)
					return '<i class="bi bi-star-half text-warning"></i> ';
				} else {
					// 나머지는 빈 별
					return '<i class="bi bi-star text-warning"></i> ';
				}
			}).join('');

            // 첨부 파일이 있을 경우 이미지 HTML 생성
            const imgNamesHtml = listReviewImg && listReviewImg.length > 0
                ? `
                <div class="row gx-1 mt-2 mb-1 p-1">
                    ${listReviewImg.map(f => `
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
                            <label class="text-bg-primary px-2"> 관리자 </label> <label>${answerDate}</label>
                        </div>
                        <div class="p-3 pt-1">${answer}</div>
                    </div>
                </div>`
                : ''; // 답변이 없으면 빈 문자열

            // 각 리뷰 항목에 대한 전체 HTML 구조를 반환
            return `
				<div class="row mt-3 border-bottom">
	                <div class="col-10 p-2">
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
	                		<div class="mt-2 p-2" style="display: inline-flex;">
	                			<p>3명에게 도움된 리뷰</p>
	                			<button type="button">도움이 돼요</button>
	                			<button type="button">도움이 안돼요</button>
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
	            </div>`;
        }).join(''); // 모든 리뷰 항목의 HTML을 하나의 문자열로 결합

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
    // 요약 정보에서 필요한 값들을 구조 분해 할당
    const { count, ave } = summary;

    // 제품 리뷰 요약을 업데이트
    $('.product-reviewCount').text(count); // 총 리뷰 개수
    $('.product-rate').text(`(${ave} / 5)`); // 평균 점수
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
    
    // 평균 점수에 따라 별 활성화
    const roundAve = Math.round(ave); // 평균 점수 반올림
    for (let i = 0; i < roundAve; i++) {
        $('.product-star .item').eq(i).addClass('on'); // 반올림한 점수만큼 별을 'on' 상태로
    }

    // 전체 리뷰 요약 업데이트
    $('.title-reviewCount').text(`(${count})`); // 제목의 리뷰 개수
    $('.review-reviewCount').text(count); // 리뷰 섹션의 총 리뷰 개수
    $('.review-rate').text(`${ave} / 5`); // 리뷰 섹션의 평균 점수 (예: 4.5 / 5)
    $('.review-rate').addClass('ps-3'); // 리뷰 섹션의 평균 점수 (예: 4.5 / 5)
    $('.review-rate-star').html(starRatingHtml);

    // 리뷰 점수 비율을 업데이트
    $('.review-rate .one-space').removeClass('on'); // 모든 비율 바를 비활성화
    // 각 점수(5점~1점)별 비율 데이터를 배열로 만든다.

}

// 상품리뷰 대화상자
function reviewWrite(){
	$('#reviewDialogModal').modal('show');
}

window.addEventListener('DOMContentLoaded', () => {
	var sel_files = [];
	
	const imageListEL = document.querySelector('form .image-upload-list');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	// sel_files[] 에 저장된 file 객체를 <input type="file">로 전송하기
	const transfer = () => {
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		inputEL.files = dt.files;
	}

	inputEL.addEventListener('change', ev => {
		if(! ev.target.files || ! ev.target.files.length) {
			transfer();
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
        	
			imageListEL.appendChild(node);
		}
		
		transfer();		
	});
	
	imageListEL.addEventListener('click', (e)=> {
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
		
			transfer();
			
			e.target.remove();
		}
	});
	
	$('.btnReviewSendOk').click(function(){
		const f = document.reviewForm;
		let s;
		
		console.log(f.rate.value);
		if(f.rate.value === '0') {
			alert('평점은 1점부터 가능합니다.');
			return false;
		}
		console.log(f.content.value);
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
		const url = contextPath + '/review/write';
		console.log(url);
		// FormData : form 필드와 그 값을 나타내는 일련의 key/value 쌍을 쉽게 생성하는 방법을 제공 
		// FormData는 Content-Type을 명시하지 않으면 multipart/form-data로 전송
		let formData = new FormData(f); 
		
		const fn = function(data) {
			if(data.state === 'true') {
				f.reset();
				$('.review-form .img-item').each(function(){
					$(this).remove();
				});
				sel_files.length = 0;
				
				$('#reviewDialogModal').modal('hide');
				
				listReview(1);
			}
			
			console.log(222);
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true);
	});
	
	$('.btnReviewSendCancel').click(function(){
		const f = document.reviewForm;
		f.reset();
		$('.review-form .img-item').each(function(){
			$(this).remove();
		});
		sel_files.length = 0;
		
		$('#reviewDialogModal').modal('hide');
	});		
});

$(function(){
	// 별
	$('.review-form .star a').click(function(e){
		console.log($(this));
		let b = $(this).hasClass('on');
		$(this).parent().children('a').removeClass('on');
		$(this).addClass('on').prevAll('a').addClass('on');
		
		if( b ) {
			$(this).removeClass('on');
		}
		
		let s = $(this).closest('.review-form').find('.star .on').length;
		$(this).closest('.review-form').find('input[name=rate]').val(s);
		
		// e.preventDefault(); // 화면 위로 이동 안되게
		return false;
	});
});

$(function(){
	$('body').on('click', '.notifyReview', function(){
		let num = $(this).attr('data-num');
		alert(num);
	});
});

// 문의
function listInquiry(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const productCode = document.getElementById('product-productCode').value;
	
	let url = contextPath + '/inquiry/list';
	let params = {productCode:productCode, pageNo:page};
	
	const fn = function(data) {
		printInquiry(data);
	};

	ajaxRequest(url, 'get', params, 'json', fn);
}

function printInquiry(data) {

	const contextPath = document.getElementById('web-contextPath').value;	
    // 데이터를 구조 분해 할당으로 추출
    const { dataCount, pageNo, total_page, size, paging, list } = data;

    // 전체 문의 개수 업데이트
    $('.title-qnaCount').html(`(${dataCount})`);

    let out = '';

    if (dataCount > 0) {
        // list 배열의 각 항목을 HTML 문자열로 변환
        out = `<table class="inquiry-table table">
					<tbody>
						<tr>
							<td class="table-header" width="150px">상태</td>
							<td class="table-header">제목</td>
							<td class="table-header" width="150px">작성자</td>
							<td class="table-header" width="230px">등록일</td>
						</tr>`;
		
		out += list.map(item => {
            // 각 문의 항목에서 필요한 데이터를 추출
            const { inquiryId, name, title, content, regDate, answer, answerDate, secret, deletePermit } = item;
            // 답변 상태를 설정
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
													<img src="/dist/images/person.png" class="answer-icon">
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

			// const isMyInquiry = ;																				
			const inquiryDetail = `<tr class="inquiryDetailTr d-none">
										<td colspan="4">
											<div class="">
												<div id="inquiryDetail${inquiryId}" class="inquiry-detailInfo">
													<div class="inquiryDetailHeader">
														<img src="/dist/images/person.png" class="user-icon">
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

            // 각 문의 항목에 대한 전체 HTML 구조를 반환
            return `
				<tr class="inquiryTr ${isSecretInquiry} ${isMyInquiry}" data-inquiryId="${inquiryId}">
					${inquirySimple}
				</tr>
				${inquiryDetail}
            `;
        }).join(''); // 모든 항목의 HTML을 하나의 문자열로 합친다.

        out += `</tbody></table></div><div class="page-navigation">${paging}</div>`;
    }

    $('.list-inquiry').html(out);
}

/*
$(function(){
	// 문의 답변 보기/숨기기
	$('.list-question').on('click', '.btnAnswerView', function(){
		const $btn = $(this);
		const $EL = $(this).closest('.row').next('.answer-content');
		if($EL.is(':visible')) {
			$btn.html(' <i class="bi bi-chevron-down"></i> ');
			$EL.hide(100);
		} else {
			$btn.html(' <i class="bi bi-chevron-up"></i> ');
			$EL.show(100);
		}
	});
});
*/

// 문의 삭제
$(function(){
	$('div.detailTabList').on('click', 'p.myInquiryDelete', function(){
		const $tr = $(this).closest('tr').prev();
		let inquiryId = $tr.attr('data-inquiryId');
		
		console.log(inquiryId);
		
		if(! confirm('해당 문의를 삭제하시겠습니까 ? ')){
			return;
		}
		
		const contextPath = document.getElementById('web-contextPath').value;
		const url = contextPath + '/inquiry/delete?inquiryId=' + inquiryId;
		
		const fn = function(data) {
			if(data.state === 'true') {
				listInquiry(1);
			}
		};
				
		ajaxRequest(url, 'post', null, 'json', fn, true);
	});
});


window.addEventListener('DOMContentLoaded', () => {	
	// 상품문의 대화상자
	$('.inquiry-add-btn').click(function(){
		$('#inquiryDialogModal').modal('show');
	});

	$('.btnInquirySendOk').click(function(){
		const f = document.inquiryForm;
		let s;
		
		title = f.title.value.trim();
		if( ! title ){
			alert('문의 제목을 입려하세요.');
			f.title.focus();
			return false;
		}
		
		s = f.content.value.trim();
		if( ! s ) {
			alert('문의 사항을 입력하세요.');
			f.content.focus();
			return false;
		}
		
		const contextPath = document.getElementById('web-contextPath').value;
		const url = contextPath + '/inquiry/write';
		
		// FormData : form 필드와 그 값을 나타내는 일련의 key/value 쌍을 쉽게 생성하는 방법을 제공 
		// FormData는 Content-Type을 명시하지 않으면 multipart/form-data로 전송
		let formData = new FormData(f); 
		
		const fn = function(data) {
			if(data.state === 'true') {
				f.reset();
				
				$('#inquiryDialogModal').modal('hide');
				
				listInquiry(1);
			} else if(data.state === 'onlyMember'){
				alert('오직 회원만 문의 가능합니다.');
				
				$('#inquiryDialogModal').modal('hide');
				
				listInquiry(1);				
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true);
	});
	
	$('.btnInquirySendCancel').click(function(){
		const f = document.inquiryForm;
		f.reset();
		
		$('#inquiryDialogModal').modal('hide');
	});	
	
	/*
	$('.btnMyQuestion').click(function(){
		const contextPath = document.getElementById('web-contextPath').value;
		location.href = contextPath + '/myPage/review?mode=qna';
	});	
	*/
});

/*
// 문의사항 디테일 보기 -- tr 전체 누르면 디테일 창 보임
$(function(){
	$('div.detailTabList').on('click', 'tr.inquiryTr', function(){
		const $inquiryDetailTr = $(this).next();
		const $table = $(this).closest('table');
		
		let isHidden = $inquiryDetailTr.hasClass('d-none');
		let isSecret = $(this).hasClass('secret-inquiry');
		let inquiryId = $(this).attr('data-inquiryId');
		
		if($inquiryDetailTr.hasClass('d-none') && ! isSecret){
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.removeClass('d-none');
		} else if(! $inquiryDetailTr.hasClass('d-none') && ! isSecret) {
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.addClass('d-none');
		}
		
	});
});
*/

// 문의사항 디테일 보기 -- title 눌러야지만 디테일 창 보임
$(function(){
	$('div.detailTabList').on('click', 'td.inquiryTitle', function(){
		const $inquiryDetailTr = $(this).parent().next();
		const $table = $(this).closest('table');
		
		let isHidden = $inquiryDetailTr.hasClass('d-none');
		let isSecret = $(this).parent().hasClass('secret-inquiry');
		let isMyInquiry = $(this).parent().hasClass('myInquiry');
		let inquiryId = $(this).attr('data-inquiryId');
		
		if($inquiryDetailTr.hasClass('d-none') && (! isSecret || isMyInquiry)){
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.removeClass('d-none');
		} else if(! $inquiryDetailTr.hasClass('d-none') && (! isSecret || isMyInquiry)) {
			$table.children().find('tr.inquiryDetailTr').addClass('d-none');
			
			$inquiryDetailTr.addClass('d-none');
		}
		
	});
});