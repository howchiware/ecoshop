$(function(){
	// 공동구매 상품 목록에서 찜을 클릭한 경우
	$('.list-container').on('click', '.product-item-heart', function(){
		const $item = $(this).closest('.product-item'); 
		const gongguProductId = $item.attr('data-gongguProductId'); 
		
		sendGongguLike(gongguProductId, $(this));
	});

	// 공동구매 상품 상세 보기에서 찜을 선택한 경우
	$('.btn-gongguLike').on('click', function(){ 
		const gongguProductId = $(this).attr('data-gongguProductId'); 
		
		sendGongguLike(gongguProductId, $(this));
	});
});

// 찜 등록 및 해제 
function sendGongguLike(gongguProductId, $el){ 
	const bFlag = $el.find('i').hasClass('bi-heart-fill'); // 찜이 이미 되어있는지 확인 (하트가 채워져 있으면 true)
	
	let method, msg;
	if(bFlag){ // 이미 찜이 되어있다면 삭제 요청
		method = 'DELETE'; // HTTP DELETE 메서드 사용
		msg = '이 공동구매 상품에 대한 찜을 해제하시겠습니까 ? ';
	} else { // 찜이 안 되어있다면 추가 요청
		method = 'POST'; // HTTP POST 메서드 사용
		msg = '이 공동구매 상품을 찜 목록에 추가하시겠습니까 ? ';
	}
	
	if(! confirm(msg)){ // 사용자에게 확인 메시지 표시
		return;
	}
	
	// 요청에 필요한 파라미터는 이미 URL PathVariable로 전달되므로, params 객체는 빈 값으로 설정
	const params = {}; 
	// URL 경로를 MyGongguShoppingController에 맞게 수정
	// ${pageContext.request.contextPath}는 JSP에서만 사용 가능하므로, 
	// hidden input으로 받아온 web-contextPath를 사용합니다.
	let url = document.getElementById('web-contextPath').value + '/myGongguShopping/gongguLike/' + gongguProductId;
	
	console.log("찜 요청 URL:", url);
	console.log("찜 요청 메서드:", method);

	const fn = function(data){ // AJAX 요청 성공 시 호출될 콜백 함수
		const state = data.state; // 서버에서 반환된 처리 결과 상태
		
		if(state === 'false'){
			alert(data.message || '찜 처리 중 오류가 발생했습니다.'); // 오류 메시지 표시 (로그인 필요 등)
			return false;
		}
		
		// 찜 상태에 따라 아이콘 변경
		if(bFlag){ // 찜 해제 성공 시
			$el.find('i').removeClass('bi-heart-fill text-danger').addClass('bi-heart');
			alert('찜이 해제되었습니다.');
		} else { // 찜 추가 성공 시
			$el.find('i').removeClass('bi-heart').addClass('bi-heart-fill text-danger');
			alert('찜 목록에 추가되었습니다.');
		}
	};
	
	// ajaxRequest 함수 호출 (util-jquery.js에 정의된 것으로 추정)
	ajaxRequest(url, method, params, 'json', fn);
}
