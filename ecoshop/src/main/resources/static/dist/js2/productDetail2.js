// 탭
$(function(){
    $('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		if(tab === '2') { // review
			listReview(1);
		} else if( tab === '3') { // qna
			listQuestion(1);
		}
    });	
});

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


function printReview(data) {
	const contextPath = document.getElementById('web-contextPath').value;
    const { dataCount, paging, summary, list } = data;

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

    $('.list-review').html(reviewsHtml);
}

function printSummary(summary) {
    // 요약 정보에서 필요한 값들을 구조 분해 할당
    const { count, ave, scoreRate1, scoreRate2, scoreRate3, scoreRate4, scoreRate5 } = summary;

    // 제품 리뷰 요약을 업데이트
    $('.product-reviewCount').text(count); // 총 리뷰 개수
    $('.product-score').text(`(${ave} / 5)`); // 평균 점수
	const starRatingHtml = Array.from({ length: 5 }, (_, i) => {
		if (i < Math.floor(ave)) {
			return '<i class="bi bi-star-fill"></i> ';
		} else if (i === Math.floor(ave) && ave % 1 >= 0.5) {
			return '<i class="bi bi-star-half"></i> ';
		} else {
			return '<i class="bi bi-star"></i> ';
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
    $('.review-score').text(`${ave} / 5`); // 리뷰 섹션의 평균 점수 (예: 4.5 / 5)
    $('.review-score-star').html(starRatingHtml);

    // 리뷰 점수 비율을 업데이트
    $('.review-rate .one-space').removeClass('on'); // 모든 비율 바를 비활성화
    // 각 점수(5점~1점)별 비율 데이터를 배열로 만든다.
    const scoreRates = [scoreRate5, scoreRate4, scoreRate3, scoreRate2, scoreRate1];

    // 5점부터 1점까지의 비율을 반복하여 업데이트
    for (let i = 0; i < scoreRates.length; i++) {
        const score = 5 - i; // 현재 처리할 점수(5, 4, 3, 2, 1)
        const rate = scoreRates[i]; // 해당 점수의 비율
        // 해당 점수의 jQuery 요소를 선택
        const $scoreElement = $(`.review-rate .score-${score}`);

        // 비율에 따라 그래프 바를 활성화(10% 당 하나).
        for (let j = 0; j < Math.floor(rate / 10); j++) {
            $scoreElement.find('.one-space').eq(j).addClass('on');
        }
        // 해당 점수의 비율 텍스트를 업데이트
        $scoreElement.find('.graph-rate').text(`${rate}%`);
    }
}

$(function(){
	$('body').on('click', '.notifyReview', function(){
		let num = $(this).attr('data-num');
		alert(num);
	});
});

// question
function listQuestion(page) {
	const contextPath = document.getElementById('web-contextPath').value;
	const productCode = document.getElementById('product-productCode').value;
	
	let url = contextPath + '/inquiry/list';
	let params = {productCode:productCode, pageNo:page};
	
	const fn = function(data) {
		printQuestion(data);
	};

	ajaxRequest(url, 'get', params, 'json', fn);
}

function printQuestion(data) {
	/*
	const contextPath = document.getElementById('web-contextPath').value;	
    // 데이터를 구조 분해 할당으로 추출
    const { dataCount, pageNo, total_page, size, paging, list } = data;

    // 전체 문의 개수 업데이트
    $('.title-qnaCount').html(`(${dataCount})`);

    let out = '';

    if (dataCount > 0) {
        // list 배열의 각 항목을 HTML 문자열로 변환
        out = list.map(item => {
            // 각 문의 항목에서 필요한 데이터를 추출
            const { num, name, question, question_date, answer, answer_date, listFilename, secret } = item;
            // 답변 상태를 설정
            const answerState = answer_date ? '<span class="text-primary">답변완료</span>' : '<span class="text-secondary">답변대기</span>';

            // 첨부 파일이 있을 경우 HTML을 생성
            const filenamesHtml = listFilename && listFilename.length > 0
                ? `<div class="row gx-1 mt-2 mb-1 p-1">
                    ${listFilename.map(f => `
                        <div class="col-md-auto md-img">
                            <img class="border rounded" src="${contextPath}/uploads/qna/${f}">
                        </div>
                    `).join('')}
                  </div>`
                : ''; // 파일이 없으면 빈 문자열

            // 비밀글이 아닐 경우에 신고 링크를 추가
            const reportLink = secret === 0 ? ` |<span class="notifyQuestion" data-num="${num}">신고</span>` : '';

            // 답변이 있을 경우 답변 보기 버튼을 추가
            const answerButton = answer
                ? `<div class="col pt-2 text-end"><button class="btn-default btnAnswerView"> <i class="bi bi-chevron-down"></i> </button></div>`
                : '';

            // 답변 내용이 있을 경우 답변 섹션을 추가
            const answerContent = answer
                ? `
                <div class="p-3 pt-0 answer-content" style="display: none;">
                    <div class="bg-light">
                        <div class="p-3 pb-0">
                            <label class="text-bg-primary px-2"> 관리자 </label> <label>${answer_date}</label>
                        </div>
                        <div class="p-3 pt-1">${answer}</div>
                    </div>
                </div>`
                : '';

            // 각 문의 항목에 대한 전체 HTML 구조를 반환
            return `
                <div class="mt-1 border-bottom">
                    <div class="mt-2 p-2">${question}</div>
                    ${filenamesHtml}
                    <div class="row p-2">
                        <div class="col-auto pt-2 pe-0">${answerState}</div>
                        <div class="col-auto pt-2 px-0">&nbsp;|&nbsp;${name}</div>
                        <div class="col-auto pt-2 px-0">&nbsp;|&nbsp;<span>${question_date}</span>${reportLink}</div>
                        ${answerButton}
                    </div>
                    ${answerContent}
                </div>
            `;
        }).join(''); // 모든 항목의 HTML을 하나의 문자열로 합친다.

        out += `<div class="page-navigation">${paging}</div>`;
    }

    $('.list-question').html(out);
	*/
}

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
	
	// 상품문의 대화상자
	$('.btnQuestion').click(function(){
		$('#questionDialogModal').modal('show');
	});

	$('.btnQuestionSendOk').click(function(){
		const f = document.questionForm;
		let s;
		
		s = f.question.value.trim();
		if( ! s ) {
			alert('문의 사항을 입력하세요.');
			f.question.focus();
			return false;
		}
		
		if(f.selectFile.files.length > 5) {
			alert('이미지는 최대 5개까지 가능합니다.');
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
				$('.qna-form .img-item').each(function(){
					$(this).remove();
				});
				sel_files.length = 0;
				
				$('#questionDialogModal').modal('hide');
				
				listQuestion(1);
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true);
	});
	
	$('.btnQuestionSendCancel').click(function(){
		const f = document.questionForm;
		f.reset();
		$('.qna-form .img-item').each(function(){
			$(this).remove();
		});
		sel_files.length = 0;
		
		$('#questionDialogModal').modal('hide');
	});	
	
	$('.btnMyQuestion').click(function(){
		const contextPath = document.getElementById('web-contextPath').value;
		location.href = contextPath + '/myPage/review?mode=qna';
	});	
});
