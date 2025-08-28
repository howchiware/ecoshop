$(function(){
	$('.sm-img img').click(function(){
		let url = $(this).attr('src');
		$('.lg-img img').attr('src', url);
	});

	// 리뷰쓰기 버튼 클릭 시
	$('.btn-writeReview').on('click', function() {
		requestWriteReview();
	});

	// 오늘 본 상품 목록 저장 
	const pclassify = '2';
	const pnum = document.getElementById('gonggu-gongguProductId').value;
	const pname = document.getElementById('gonggu-gongguProductName').value;
	const pimg = document.getElementById('gonggu-gongguThumbnail').value;
	const price = Number(document.getElementById('gonggu-gongguPrice').value) || 0;
	
	let recentGongguProducts = JSON.parse(localStorage.getItem('recentProduct')) || [];
	
	recentGongguProducts = recentGongguProducts.filter(function(data){
		return data.pnum !== pnum;
	});

	if(recentGongguProducts.length >= 20) {
		recentGongguProducts.splice(recentGongguProducts.length-1, 1);
	}
	
	let obj = {
		pclassify: pclassify,
		pnum: pnum,
		pname: pname,
		pimg: pimg,
		price: price
	};
	recentGongguProducts.unshift(obj); 
	
	localStorage.setItem('recentProduct', JSON.stringify(recentGongguProducts));
});

function loginCheck(){
	const memberLogin = document.getElementById('memberLogin').value;
		
	if(	memberLogin == "" || memberLogin == null || memberLogin == undefined || ( memberLogin != null && typeof memberLogin == "object" && !Object.keys(memberLogin).length )){
		return false;
	}
	
	return true;
	}

// 공동구매 예약 결제 요청 
function requestGongguPayment() {
	const contextPath = document.getElementById('web-contextPath').value;
	const gongguProductId = document.getElementById('gonggu-gongguProductId').value;
	const gongguProductName = document.getElementById('gonggu-gongguProductName').value;
	const gongguPrice = document.getElementById('gonggu-gongguPrice').value;
	const limitCount = document.getElementById('gonggu-limitCount').value;
	const participantCount = document.getElementById('gonggu-participantCount').value;

	const buyQty = 1; 

	if (! confirm('선택한 공동구매 상품을 예약 결제하시겠습니까 ?')) {
		return;
	}

	location.href = contextPath + '/gongguOrder/payment?' + 
	                'gongguProductId=' + gongguProductId + 
	                '&gongguProductName=' + encodeURIComponent(gongguProductName) + 
	                '&gongguPrice=' + gongguPrice +
	                '&qty=' + buyQty; 
}

// 리뷰쓰기 버튼 클릭 시
function requestWriteReview() {
	const contextPath = document.getElementById('web-contextPath').value;
	const gongguProductId = document.getElementById('gonggu-gongguProductId').value;

    if(! confirm('리뷰를 작성하시겠습니까? 리뷰 작성 페이지로 이동합니다.')) { 
        return;
    }
    location.href = contextPath + '/gongguReview/write?gongguProductId=' + gongguProductId;
}

