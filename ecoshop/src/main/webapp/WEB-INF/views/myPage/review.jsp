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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<!-- Vendor JS Files -->
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>

<style type="text/css">
  .tab-pane { min-height: 300px; }

  .score-star { font-size: 0; letter-spacing: -4px; }
  .score-star .item { font-size: 22px; letter-spacing: 1px; display: inline-block;
	color: #ccc; text-decoration: none; vertical-align: middle; }
  .score-star .item:first-child{ margin-left: 0; }
  .score-star .on { color: #95D9F1; }

  .md-img img { width: 150px; height: 150px; cursor: pointer; object-fit: cover; }
  .deleteReview, .deleteQuestion { cursor: pointer; padding-left: 5px; }
  .deleteReview:hover, .deleteQuestion:hover { font-weight: 500; color: #2478FF; }
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<main class="main-container">
<div class="row">

	<div class="col-md-2">
        <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
	<div class="col-md-10">
	    <div class="contentsArea">
	  	    <h3 class="pb-2 mb-4 border-bottom sub-title">리뷰 및 상품문의</h3>

		
			<div class="row justify-content-center">

					<ul class="nav nav-tabs mt-5" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${mode=='review'?'active':'' }" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane-1" type="button" role="tab" aria-controls="1" aria-selected="false"> 리뷰 </button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${mode=='inquiry'?'active':'' }" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane-2" type="button" role="tab" aria-controls="2" aria-selected="false"> 상품문의 </button>
						</li>
					</ul>
					
					<div class="tab-content pt-2" id="myTabContent">
						<div class="tab-pane fade ${mode=='review'?'active show':'' }" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
							<div class="mt-3 pt-3 border-bottom">
								<p class="fs-4 fw-semibold">상품 리뷰</p> 
							</div>
							
							<div class="mt-2 list-review"></div>
						</div>
						
						<div class="tab-pane fade ${mode=='inquiry'?'active show':'' }" id="tab-pane-2" role="tabpanel" aria-labelledby="tab-2" tabindex="0">
							<div class="mt-3 pt-3 border-bottom">
								<p class="fs-4 fw-semibold">상품 문의 사항</p> 
							</div>
					
							<div class="mt-1 p-2 list-question"></div>
						</div>
					</div>		
			</div>
			
		</div>
	</div>
</div>
</main>

<script type="text/javascript">
$(function(){
	$('button[role="tab"]').on('click', function(){
		const tab = $(this).attr('aria-controls');
		
		if(tab === '1') {
			listReview(1);
		} else if(tab === '2'){
			listQuestion(1);
		}
	});
	
	let mode = '${mode}';
	if(mode === 'inquiry') {
		listQuestion(1);
	} else {
		listReview(1);
	}
});

//review -
function listReview(page) {
	let url = '${pageContext.request.contextPath}/review/list2';
	let requstParams = 'pageNo='+page;
	
	const fn = function(data) {
		printReview(data);
	};
	
	ajaxRequest(url, 'get', requstParams, 'json', fn);
}

function printReview(data) {
	const { dataCount, paging, list } = data;

	let out = '';

	for (const item of list) {
		const { // 구조 분해 할당
			reviewId, rate, content, regDate, answer, answerDate, listReviewImg,
			productName, optionValue, optionValue2,
		} = item;

		// 옵션 문자열
		const opt = [optionValue, optionValue2].filter(Boolean).join(' / ');
		const formattedOpt = opt ? `(\${opt})` : '';

		out += `
			<div class="mt-3 border-bottom">
				<div class="p-2 fw-semibold">
					\${productName}\${formattedOpt}
				</div>
				<div class="row p-2">
					<div class="col-auto pt-0 ps-2 pe-1 score-star">
						\${Array.from({ length: 5 }, (_, i) => `
							<span class="item fs-6 \${rate >= i + 1 ? 'on' : ''}">
								<i class="bi bi-star-fill"></i>
							</span>
						`).join('')}
					</div>
					<div class="col text-end">
						<span>\${regDate}</span> |
						<span class="deleteReview" data-reviewId="\${reviewId}">삭제</span>
					</div>
				</div>
				<div class="mt-2 p-2">\${content}</div>
		`;

		// 이미지 파일 목록 처리
		if (listReviewImg?.length > 0) { // 선택적 체이닝
			out += `
				<div class="row gx-1 mt-2 mb-1 p-1">
					\${listReviewImg.map(f => `
						<div class="col-md-auto md-img">
							<img class="border rounded" src="${pageContext.request.contextPath}/uploads/review/\${f}">
						</div>
	          		`).join('')}
				</div>
			`;
		}

		// 관리자 답변
		if (answer) {
			out += `
				<div class="p-3 pt-0">
					<div class="bg-light">
						<div class="p-3 pb-0">
							<label class="text-bg-primary px-2"> 관리자 </label> <label>\${answerDate}</label>
						</div>
						<div class="p-3 pt-1">\${answer}</div>
					</div>
				</div>
			`;
		}
		out += `</div>`;
	}

	// 페이지네이션 추가
	if (dataCount > 0) {
		out += `
			<div class="page-navigation">\${paging}</div>
		`;
	}

	$('.list-review').html(out);
}

$(function(){
	// 리뷰 삭제
	$('.list-review').on('click', '.deleteReview', function(){
		if(! confirm('해당 리뷰를 삭제하시겠습니까 ? ')){
			return;
		}
		let reviewId = $(this).attr('data-reviewId');
		let url = '${pageContext.request.contextPath}/review/delete';
		let requestParams = 'reviewId=' + reviewId;		
		
		const fn = function(data){
			listReview(1);
		}
		
		ajaxRequest(url, 'get', requestParams, 'json', fn);
	});
});

// question -
function listQuestion(page) {
	let url = '${pageContext.request.contextPath}/inquiry/list2';
	let requstParams = 'pageNo='+page;
	
	const fn = function(data) {
		printQuestion(data);
	};
	
	ajaxRequest(url, 'get', requstParams, 'json', fn);
}

function printQuestion(data) {
	const { dataCount, paging, list } = data;

	let out = '';
	for (const item of list) { 
		const {
			inquiryId, title, content, regDate, answer, answerDate, productName,
		} = item;

		const answerState = answerDate
			? '<span class="text-primary">답변완료</span>'
			: '<span class="text-secondary">답변대기</span>';

		out += `
			<div class="mt-1 border-bottom">
				<div class="mt-2 p-2 fw-semibold">\${productName}</div>
				<div class="p-2">\${title}</div>
				<div class="p-2">\${content}</div>
		`;

		out += `
			<div class="row p-2">
				<div class="col-auto pt-2 pe-0">\${answerState}</div>
				<div class="col-auto pt-2 px-0">&nbsp;|&nbsp;<span>\${regDate}</span>
					|<span class="deleteQuestion" data-inquiryId="\${inquiryId}">삭제</span>
				</div>
			`;

		// 답변이 있을 경우 답변 보기 버튼 추가
		if (answer) {
			out += `
				<div class="col pt-2 text-end">
					<button class="btn btnAnswerView"> <i class="bi bi-chevron-down"></i> </button>
				</div>
			`;
		}
		out += `</div>`; // row 닫기

		// 답변이 있을 경우 답변 내용 추가
	    if (answer) {
			out += `
				<div class="p-3 pt-0 answer-content" style="display: none;">
					<div class="bg-light">
						<div class="p-3 pb-0">
							<label class="text-bg-primary px-2"> 관리자 </label> <label>\${answerDate}</label>
						</div>
						<div class="p-3 pt-1">\${answer}</div>
					</div>
				</div>
			`;
		}
		out += `</div>`; // 각 질문 항목의 div 닫기
	}

	// 페이지네이션 추가
	if (dataCount > 0) {
		out += `
			<div class="page-navigation">\${paging}</div>
		`;
	}

	$('.list-question').html(out);
}

$(function(){
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

$(function(){
	$('.list-question').on('click', '.deleteQuestion', function(){
		if(! confirm('해당 문의를 삭제하시겠습니까 ? ')){
			return;
		}
		
		let inquiryId = $(this).attr('data-inquiryId');
		
		let url = '${pageContext.request.contextPath}/inquiry/delete';
		let requestParams = 'inquiryId=' + inquiryId;		
		
		const fn = function(data){
			listQuestion(1);
		}
		
		ajaxRequest(url, 'get', requestParams, 'json', fn);
	});
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>

<!-- Vendor JS Files -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>


</body>
</html>