<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css"type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<style type="text/css">
.tab-pane {
	min-height: 300px;
}

.md-img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.payment-dropdown, .payment-delete {
	cursor: pointer;
}

.payment-dropdown:hover, .payment-delete:hover {
	color: #0d6efd;
}

.payment-menu {
	display: none;
	position: absolute;
	width: 100px;
	min-height: 65px;
	background: #fff;
	border: 1px solid #d5d5d5;
	border-radius: 3px;
	z-index: 9999;
}

.payment-menu-item {
	text-align: center;
	cursor: pointer;
	padding: 7px;
}

.payment-menu-item:nth-child(1) {
	border-bottom: 1px solid #d5d5d5;
}

.payment-menu-item:hover {
	color: #0d6efd;
	font-weight: 500;
}

.review-form textarea {
	width: 100%;
	height: 75px;
	resize: none;
}

.review-form .star {
	font-size: 0;
	letter-spacing: -4px;
}

.review-form .star a {
	font-size: 22px;
	letter-spacing: 1px;
	display: inline-block;
	color: #ccc;
	text-decoration: none;
}

.review-form .star a:first-child {
	margin-left: 0;
}

.star a.on {
	color: #FFBB00;
}

.review-form .img-grid {
	display: grid;
	grid-gap: 2px;
	grid-template-columns: repeat(auto-fill, 54px);
}

.review-form .img-grid .item {
	object-fit: cover;
	border: 1px solid #c2c2c2;
	width: 50px;
	height: 50px;
	border-radius: 10px;
	cursor: pointer;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<main class="main-container">
		<div class="row">
			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
			</div>

			<div class="col-md-10">
				<div class="contentsArea container">
					<h3 class="pb-2 mb-4 border-bottom sub-title">온라인샵 주문 내역</h3>
					<div class="col-md-10 bg-white box-shadow my-4 p-5 pt-2">
						

						<div class="tab-content pt-2" id="myTabContent">
							<div class="tab-pane fade show active" id="tab-pane-1"
								role="tabpanel" aria-labelledby="tab-1" tabindex="0">
								<div class="mt-3 pt-3 border-bottom">
									<p class="fs-4 fw-semibold">주문 내역</p>
								</div>
								<div class="mt-3">
									<c:forEach var="dto" items="${list}">
										<div class="mt-3 p-2 border-bottom payment-list">
											<div class="row pb-2">
												<div class="col-6">
													<div class="fs-6 fw-semibold text-black-50">
														<label>${dto.stateProduct}</label><label></label>
													</div>
												</div>
												<div class="col-6 text-end">
													<label class='payment-delete' title="주문내역삭제"
														data-orderDetailId="${dto.orderDetailId}"><i
														class="bi bi-x-lg"></i></label>
												</div>
											</div>
											<div class="row">
												<div class="col-auto">
													<img class="border rounded md-img"
														src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
												</div>
												<div class="col">
													<div class="pt-1">
														<label class="text-black-50">${dto.orderDate} 구매</label>
													</div>
													<div class="fw-semibold pt-2">${dto.productName}</div>
													<div class="pt-1">
														<label>주문수량 : ${dto.qty}</label>
														<label class="fw-semibold ps-3"><fmt:formatNumber value="${dto.productMoney}" />원</label>
													</div>
													<div class="pt-1">
														<c:choose>
															<c:when test="${dto.optionCount==1}">옵션 : ${dto.optionValue}</c:when>
															<c:when test="${dto.optionCount==2}">옵션 : ${dto.optionValue} / ${dto.optionValue2}</c:when>
														</c:choose>
													</div>
												</div>
											</div>
											<div class="mt-3 p-3 text-end">
												<c:if test="${dto.reviewWrite==0 && (dto.detailState==1 || dto.detailState==2)}">
													<button type="button" class="btn-default btnReviewWriteForm" style="width: 130px;">리뷰쓰기</button>
												</c:if>
												<c:if test="${(dto.orderState!=0 && dto.orderState!=1 && dto.orderState!=6 && dto.orderState!=8)}">
													<button type="button" class="btn-default stateViewBtn" style="width: 130px;" data-orderDetailId="${dto.orderDetailId}">배송조회</button>
												</c:if>
												<c:if test="${dto.detailState==0 || dto.detailState==8}">
													<button type="button" class="btn border payment-confirmation" style="width: 130px;" data-orderDetailId="${dto.orderDetailId}">구매확정
													</button>
												</c:if>
												<button type="button" class="btn-default" style="width: 130px;" onclick="location.href='${pageContext.request.contextPath}/products/${dto.productCode}';"> 재구매</button>

												<button type="button" class="btn-default payment-dropdown" title="주문상세">
													<i class="bi bi-three-dots"></i>
												</button>
												<div class="payment-menu">
													<div class="payment-menu-item order-details" data-orderId="${dto.orderId}" data-orderDetailId="${dto.orderDetailId}">주문상세</div>
													<c:if test="${dto.detailState==0 && dto.orderState==1}">
														<div class="payment-menu-item order-cancel" data-orderDetailId="${dto.orderDetailId}">구매취소</div>
													</c:if>
													<c:if test="${dto.detailState==0 && dto.orderState==5 && dto.afterDelivery < 3}">
														<div class="payment-menu-item return-request" data-orderDetailId="${dto.orderDetailId}">반품요청</div>
														<div class="payment-menu-item exchange-request" data-orderDetailId="${dto.orderDetailId}">교환요청</div>
													</c:if>
												</div>

											</div>

											<c:if test="${dto.reviewWrite == 0}">
												<div class="review-form border border-secondary p-3 mt-2"
													style="display: none;">
													<form name="reviewForm">
														<div class="p-1">
															<p class="star">
																<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
																<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
																<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
																<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
																<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
																<input type="hidden" name="rate" value="5"> 
																<input type="hidden" name="productCode" value="${dto.productCode}">
															</p>
														</div>
														<div class="p-1">
															<textarea name="content" class="form-control"></textarea>
														</div>
														<div class="p-1">
															<div class="img-grid">
																<img class="item img-add"
																	src="${pageContext.request.contextPath}/dist/images/add_photo.png">
															</div>
															<input type="file" name="selectFile" accept="image/*"
																multiple class="form-control" style="display: none;">
														</div>
														<div class="p-1 text-end">
															<input type="hidden" name="orderDetailId"
																value="${dto.orderDetailId}">
															<input type="hidden" name="reviewId"
																value="${dto.orderDetailId}">
															<button type="button"
																class="btn-accent btnReviewSend ps-5 pe-5">등록하기</button>
														</div>
													</form>
												</div>
											</c:if>
										</div>
									</c:forEach>

									<div class="page-navigation mt-3">${dataCount == 0 ? "주문 내역이 없습니다." : paging }
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>
		</div>

	</main>

	<div class="modal fade" id="orderDetailUpdateDialogModal" tabindex="-1"
		aria-labelledby="orderDetailUpdateDialogModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderDetailUpdateDialogModalLabel">구매취소</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body pt-1">

					<div class="p-1">
						<form name="userOrderDetailForm" method="post"
							class="row justify-content-center">
							<div class="col-7 p-1">
								<input type="text" name="stateMemo" class="form-control"
									placeholder="사유를 입력 하세요">
							</div>
							<div class="col-auto p-1">
								<input type="hidden" name="page" value="${page}"> <input
									type="hidden" name="orderDetailId"> <input
									type="hidden" name="detailState">
								<button type="button"
									class="btn-default btnUserOrderDetailUpdateOk">요청하기</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="orderDetailViewDialogModal" tabindex="-1"
		aria-labelledby="orderDetailViewDialogModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderDetailViewDialogModalLabel">주문상세정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body order-detail-view"></div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="stateDetailViewDialogModal" tabindex="-1"
		aria-labelledby="stateDetailViewDialogModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="stateDetailViewDialogModalLabel">배송 조회</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body state-detail-view"></div>
			</div>
		</div>
	</div>

<script type="text/javascript">
// 배송 조회
$(function(){
	$('.tab-content').on('click', '.stateViewBtn', function(){
		const orderDetailId = $(this).attr('data-orderDetailId');
		
		let params = 'orderDetailId=' + orderDetailId;
		let url = '${pageContext.request.contextPath}/productsOrder/stateView'; 
		/*
		const fn = function(data) {
		    const { list } = data;

		    let out = `<table class="table board-list table-hover">
							<thead>
							<tr>
								<th width="130">번호</th>
								<th width="130">상태</th>
								<th width="150">일자</th>
								<th width="130">메모</th>
							</tr>
						</thead>
						<tbody>`; // 전체 리뷰 목록을 담을 변수

		    if (list.size() > 0) {
		    	out += list.map((item, index) => {
		            const { detailState, detailStateDate, stateMemo } = item;

		            return `<tr>
								<td>${index + 1}</td>
								<td>${detailState}</td>
								<td>${detailStateDate}</td>
								<td>${stateMemo}</td>
							</tr>`;
		        }).join(''); // 모든 리뷰 항목의 HTML을 하나의 문자열로 결합

		        reviewsHtml += `	</tbody>
								</table>`;
		    }
			
			$('.state-detail-view').html(out);
			
		};
		*/
		const fn = function(data){
			const payment = data.payment;
			const orderStateInfo = payment.orderStateInfo;
			const orderStateDate = payment.orderStateDate;
			const deliveryName = payment.deliveryName;
			const invoiceNumber = payment.invoiceNumber;
			
			let out = '';

			out += `<table class="table board-list table-hover">
						<thead>
							<tr>
								<th width="130">번호</th>
								<th width="130">송장번호</th>
								<th width="130">배송회사</th>
								<th width="130">상태</th>
								<th width="150">일자</th>
							</tr>
						</thead>
						<tbody>
							<td>1</td>
							<td>\${invoiceNumber}</td>
							<td>\${deliveryName}</td>
							<td>\${orderStateInfo}</td>
							<td>\${orderStateDate}</td>
						</tbody>
					</table>
							`;
			
			$('.state-detail-view').html(out);
		}
		ajaxRequest(url, 'get', params, 'json', fn);		
		
		$('#stateDetailViewDialogModal').modal('show');
	});
});
	
	
// 주문상세, 주문취소, 반품, 교환 메뉴
$(function(){
	$('.tab-content').on('click', '.payment-dropdown', function(){
		const $menu = $(this).next('.payment-menu');
		
		if($menu.is(':visible')) {
			$menu.fadeOut(100);
		} else {
			$('.payment-menu').hide();
			$menu.fadeIn(100);

			let pos = $(this).offset();
			$menu.offset( {left:pos.left-90, top:pos.top+40} );
		}
	});
	
	$('.tab-content').on('click', function(evt) {
		if($(evt.target.parentNode).hasClass('payment-dropdown')) {
			return false;
		}
		
		$('.payment-menu').hide();
	});
});

$(function(){
	// 주문 내역 삭제 - 주문자화면에 보이지 않게 설정(userDelete 컬럼을 1로 설정)
	$('.payment-delete').click(function(){
		if(! confirm('주문내역을 삭제하시겠습니까 ?')) {
			return false;
		}		
		
		let orderDetailId = $(this).attr('data-orderDetailId'); 

		let params = 'orderDetailId=' + orderDetailId + '&page=${page}';
		location.href = '${pageContext.request.contextPath}/productsOrder/updateOrderHistory?' + params; 
	});
});

$(function(){
	// 구매 확정
	$('.payment-confirmation').click(function() {
		if(! confirm('구매확정을 진행하시겠습니까 ?')) {
			return false;
		}
		
		let orderDetailId = $(this).attr('data-orderDetailId'); 
		let url = '${pageContext.request.contextPath}/productsOrder/confirmation?orderDetailId=' + orderDetailId + '&page=${page}'; 
		location.href = url;
	});
});

$(function(){
	// 주문 상세 정보
	$('.order-details').click(function(){
		let orderId = $(this).attr('data-orderId'); 
		let orderDetailId = $(this).attr('data-orderDetailId');
		
		let params = 'orderId=' + orderId + '&orderDetailId=' + orderDetailId;
		let url = '${pageContext.request.contextPath}/productsOrder/detailView'; 
		
		const fn = function(data) {
			$('.order-detail-view').html(data);
		};
		ajaxRequest(url, 'get', params, 'text', fn);		
		
		$('#orderDetailViewDialogModal').modal('show');
	});
});

$(function(){
	// 구매(주문) 취소
	$(".order-cancel").click(function(){
		console.log($(this).attr('data-orderDetailId'));
		let orderDetailId = $(this).attr('data-orderDetailId'); 

		const f = document.userOrderDetailForm;
		f.orderDetailId.value = orderDetailId; 
		f.detailState.value = 4; 

		$('#orderDetailUpdateDialogModalLabel').text('구매취소');
		$('#orderDetailUpdateDialogModal').modal('show');
	});
});

$(function(){
	// 반품 요청
	$(".return-request").click(function(){
		let orderDetailId = $(this).attr('data-orderDetailId'); 
		
		const f = document.userOrderDetailForm;
		f.orderDetailId.value = orderDetailId; 
		f.detailState.value = 10; 
		
		$('#orderDetailUpdateDialogModalLabel').text('반품요청');
		$('#orderDetailUpdateDialogModal').modal('show');
	});
});

$(function(){
	// 교환 요청
	$(".exchange-request").click(function() {
		let orderDetailId = $(this).attr('data-orderDetailId'); 

		const f = document.userOrderDetailForm;
		f.orderDetailId.value = orderDetailId; 
		f.detailState.value = 6; 
		
		$('#orderDetailUpdateDialogModalLabel').text('교환요청');
		$('#orderDetailUpdateDialogModal').modal('show');
	});
});

$(function(){
	// 주문취소/교환요청/반품요청 완료
	$('.btnUserOrderDetailUpdateOk').click(function(){
		const f = document.userOrderDetailForm;

		if(! f.stateMemo.value.trim()) {
			alert('요청 사유를 입력 하세요');
			f.stateMemo.focus();
			return false;
		}
		
		f.action = '${pageContext.request.contextPath}/productsOrder/orderDetailUpdate'; 
		f.submit();
	});
});
</script>

	<script type="text/javascript">
$(function(){
	// 리뷰 쓰기 버튼
	$('.btnReviewWriteForm').click(function(){
		const $review = $(this).closest('.payment-list').find('.review-form');
		if($review.is(':visible')) {
			$review.fadeOut(100);
		} else {
			$review.fadeIn(100);
		}
	});
});

$(function(){
	// 별
	$('.review-form .star a').click(function(e){
		let b = $(this).hasClass('on');
		$(this).parent().children('a').removeClass('on');
		$(this).addClass('on').prevAll('a').addClass('on');
		
		if( b ) {
			$(this).removeClass('on');
		}
		
		let s = $(this).closest('.review-form').find('.star .on').length;
		$(this).closest('.review-form').find('input[name=rate]').val(s); 
		
		return false;
	});
});

$(function(){
	// 리뷰 등록 완료
	$('.btnReviewSend').click(function(){
		let $plist = $(this).closest('.payment-list');
		
		const f = this.closest('form');
		let s;
		
		if(f.rate.value === '0') { 
			alert('평점은 1점부터 가능합니다.');
			return false;
		}
		
		s = f.content.value.trim(); 
		if( ! s ) {
			alert('리뷰를 입력하세요.')	;
			f.content.focus(); 
			return false;
		}
		
		if(f.selectFile.files.length > 5) {
			alert('이미지는 최대 5개까지 가능합니다.');
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/review/write'; 
		let formData = new FormData(f); 
		
		const fn = function(data) {
			if(data.state === 'true') {
				$plist.find('.btnReviewWriteForm').remove();
				$plist.find('.review-form').remove();
				alert('리뷰가 성공적으로 등록되었습니다.');
				location.reload(); 
			} else if (data.message === '로그인이 필요합니다.') {
				alert(data.message);
				location.href = '${pageContext.request.contextPath}/member/login';
			} else {
				alert('리뷰 등록 중 오류가 발생했습니다.');
			}
		};
		
		ajaxRequest(url, 'post', formData, 'json', fn, true); 
	});
});

// 이미지
$(function(){
	var sel_files = [];
	
	$(".tab-content").on('click', '.review-form .img-add', function(){
		$(this).closest('.review-form').find('input[name=selectFile]').trigger('click');
	});
	
	$('.tab-content').on('change', 'form[name=reviewForm] input[name=selectFile]', function(e){ 
		if(! this.files) {
			let dt = new DataTransfer();
			for(let f of sel_files) {
				dt.items.add(f);
			}
			
			this.files = dt.files;
			
			return false;
		}
		
		let $form = $(this).closest('form');
		
		const fileArr = Array.from(this.files);
		
		fileArr.forEach((file, index) => {
			sel_files.push(file);
			
			const reader = new FileReader();
			const $img = $('<img>', {'class': 'item img-item'});
			$img.attr('data-filename', file.name);
			reader.onload = e => {
				$img.attr('src', e.target.result);		
			};
			reader.readAsDataURL(file);
			$form.find('.img-grid').append($img);
		});
		
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		
		this.files = dt.files;
	});
	
	$('.tab-content').on('click', '.review-form .img-item', function(){ 
		if(! confirm('선택한 파일을 삭제 하시겠습니까 ? ')) {
			return false;
		}
		
		let filename = $(this).attr('data-filename');
		
		for(let i=0; i<sel_files.length; i++) {
			if(filename === sel_files[i].name) {
				sel_files.splice(i, 1);
				break;
			}
		}
		
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		
		const f = this.closest('form');
		f.selectFile.files = dt.files;
		
		$(this).remove();
	});
});
</script>
	<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>
	<script
		src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>
