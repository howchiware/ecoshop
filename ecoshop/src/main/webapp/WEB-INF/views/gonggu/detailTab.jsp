<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
		
<div class="nav nav-tabs mt-5 myNavTab" id="myTab" role="tablist">
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn active w-100" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane-1" type="button" role="tab" aria-controls="1" aria-selected="true">상세정보</button>
	</div>
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn w-100" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane-2" type="button" role="tab" aria-controls="2" aria-selected="false">구매후기 <span class="title-reviewCount">(${dto.reviewCount})</span></button>
	</div>
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn w-100" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane-3" type="button" role="tab" aria-controls="3" aria-selected="false">Q&A <span class="title-qnaCount">(${dto.inquiryCount})</span></button>
	</div>
</div>

<div class="tab-content pt-2" id="myTabContent">
	<!-- 상품 설명 탭 Content -->
	<div class="tab-pane fade show active" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
		<div class="mt-4 mb-5 pb-4 product-content border-bottom">
			${dto.detailInfo}
		</div>
		<div class="mt-4 mb-5 product-deliveryInfo border-bottom">
			<div class="border-bottom delivery-header">
				<p>배송 정보</p>
			</div>
			<div class="deliveryInfo-div">
				<p>${deliveryRefundInfo.deliveryInfo}</p>
			</div>
		</div>
		<div class="mt-4 mb-5 product-refundInfo border-bottom">
			<div class="border-bottom refund-header">
				<p>환불 안내</p>
			</div>
			<div class="refundInfo-div">
				<p>${deliveryRefundInfo.refundInfo}</p>
			</div>
		</div>
	</div>
	
	<!-- 상품 리뷰 탭 Content -->
	<div class="tab-pane fade" id="tab-pane-2" role="tabpanel" aria-labelledby="tab-2" tabindex="0">
	    <div class="row mt-3 pt-3">
	        <p class="fs-6">구매평(${dto.reviewCount})</p>
	        <div class="col" style="display: inline-flex">
				<div class="rate-star review-rate-star" style="font-size: 30px;">
					<fmt:parseNumber var="intRate" value="${dto.rate}" integerOnly="true" type="number"/>
					<c:forEach var="i" begin="1" end="${intRate}">
						<i class="bi bi-star-fill text-warning"></i>
					</c:forEach>
					<c:if test="${dto.rate -  intRate >= 0.5}">
						<i class="bi bi bi-star-half text-warning"></i>
						<c:set var="intRate" value="${intRate+1}"/>
					</c:if>
					<c:forEach var="i" begin="${intRate + 1}" end="5">
						<i class="bi bi-star text-warning"></i>
					</c:forEach>
				</div>
				<div class="fs-2">
					<label class="review-rate">${dto.rate} / 5</label> 
				</div>
	        </div>
	        <c:if test="${leaveReview}">
		        <div class="col">
		            <p style="text-align: right; text-decoration: underline;" class="reviewWrite-pTag" onclick="reviewWrite();" data-gongguProductId="${dto.gongguProductId}">구매평 작성하기</p>
		        </div>
	        </c:if>
	    </div>
	
	    <div class="image-grid">
	    	<c:forEach var="vo" items="${imgList}" varStatus="status" begin="0" end="4">
	    		<c:if test="${status.index < 4}">
			        <div class="img-div reviewImgView-div" data-gongguOrderDetailId="${vo.gongguOrderDetailId}">
		                <img src="${pageContext.request.contextPath}/uploads/review/${vo.reviewImg}" class="image-photo" alt="" style="height: 210px;">
			        </div>
	    		</c:if>
	    		<c:if test="${status.index == 4}">
	    		<div class="item-box">
				    <div class="image">
				      <img src="${pageContext.request.contextPath}/uploads/review/${vo.reviewImg}" alt="" class="image-photo" style="height: 210px;">
				    </div>
				    <div class="img-div moreBtn" data-productCode="${dto.productCode}">
				      <p>더보기</p>
				    </div>
				 </div>
				</c:if>
	    	</c:forEach>
	    </div>
	    <div class="row mt-3 reviewSort-area">
	        <div class="col onlyPhotoReview" id="onlyPhotoReview">
	            <i class="bi bi-image"></i> <span>포토 구매평만 보기</span>
	        </div>
	        <div class="col-auto text-end">
	            <div class="dropdown">
	                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
	                    전체 평점 보기
	                </button>
	                <ul class="dropdown-menu reviewSortBy">
	                    <li><a class="dropdown-item" href="#" data-value="0">전체 평점 보기</a></li>
	                    <li><a class="dropdown-item" href="#" data-value="5">최고&nbsp; 
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                    </a></li>
	                    <li><a class="dropdown-item" href="#" data-value="4">좋음&nbsp; 
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                    </a></li>
	                    <li><a class="dropdown-item" href="#" data-value="3">보통&nbsp; 
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                    </a></li>
	                    <li><a class="dropdown-item" href="#" data-value="2">별로&nbsp; 
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                    </a></li>
	                    <li><a class="dropdown-item" href="#" data-value="1">나쁨&nbsp; 
	                        <i class="bi bi-star-fill text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                        <i class="bi bi-star text-warning"></i>
	                    </a></li>
	                </ul>
	            </div>
	        </div>
	    </div>
	    <hr>
	    <div class="list-review"></div>
	</div>
	
	<!-- 상품 문의 탭 Content -->
	<div class="tab-pane fade inquiry-total-area" id="tab-pane-3" role="tabpanel" aria-labelledby="tab-3" tabindex="0">
		<div class="pt-3 pb-3 inquiry-add-area">
			<p style="margin: 15px 0px;">구매하시려는 상품에 대해 궁금한 점이 있으면 문의해주세요.</p> 
			<button type="button" class="inquiry-add-btn">상품 문의</button>
		</div>

		<div class="mt-4 p-2 list-inquiry">
			<table class="inquiry-table table">
				<tbody>
					<tr>
						<td class="table-header" width="150px">상태</td>
						<td class="table-header">제목</td>
						<td class="table-header" width="150px">작성자</td>
						<td class="table-header" width="230px">등록일</td>
					</tr>
					<tr class="inquiryTr" data-inquiryId="1">
						<td class="inquiryStatus" data-inquiryId="1" width="150px">답변완료</td>
						<td class="inquiryTitle" data-inquiryId="1">가격?</td>
						<td class="inquiryName" data-inquiryId="1" width="150px">정**</td>
						<td class="inquiryDate" data-inquiryId="1" width="230px">2025-07-04 13:21</td>
					</tr>
					<tr class="inquiryDetailTr d-none">
						<td colspan="4">
							<div class="">
								<div id="inquiryDetail1" class="inquiry-detailInfo">
									<div class="inquiryDetailHeader">
										<img src="/dist/images/person.png" class="user-icon">
										<div class="inquiryDetailNTD">
											<p class="inquiryDetailTitle">가격?</p>
											<div class="inquiryDetailTD">
												<p class="inquiryDetailName">정**</p>
												<p class="inquiryDetailDate">2025-07-04 13:21</p>
											</div>
										</div>
									</div>
									<hr class="inquireDivider">
									<div class="inquiryDetailBody">
										<div class="inquireDetailContent">
											<p class="content">타임세일이라 1990원이라고 되어 있는데<br>장바구니에 담으면 5990원으로 바뀌는 이유가 뭘까요?<br>아직 세일기간이 남았는데요...</p>
										</div>
										<hr class="inquireDivider">
										<div class="inquireDetailAnswer">
											<img src="/dist/images/person.png" class="answer-icon">
											<div class="inquiryDetailNDC">
												<div class="inquiryDetailAnswerND">
													<p class="inquiryDetailAnswerName">관리자</p>
													<p class="inquiryDetailAnswerDate">2025-04-05 12:09</p>
												</div>
												<div class="inquireDetailAnswerContent">
													<p class="answerContent">안녕하세요, OO 샵입니다.<br>장바구니에 담으신 후 화면에서 5,990원으로 표기되나,<br>실제 결제단계에서 할인이 적용되는 것을 확인하실 수 있습니다.<br>결제화면에서 확인 부탁드리며, 할인이 적용되지 않을 경우 고객센터로 연락주시면 친절히 안내해드리겠습니다.<br>감사합니다 :-)</p>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr class="inquiryTr secret-inquiry" data-inquiryId="2">
						<td class="inquiryStatus" width="150px">답변완료</td>
						<td class="inquiryTitle secret">비밀글입니다.<i class="bi bi-lock"></i></td>
						<td class="inquiryName" width="150px">이**</td>
						<td class="inquiryDate" width="230px">2025-07-01 13:21</td>
					</tr>
					<tr class="inquiryDetailTr d-none">
						<td colspan="4">
							<div class="border rounded">
								<div id="inquiryDetail2" class="inquiry-detailInfo">
									3456
								</div>
							</div>
						</td>
					</tr>
					<tr class="inquiryTr secret-inquiry" data-inquiryId="3">
						<td class="inquiryStatus" width="150px">답변완료</td>
						<td class="inquiryTitle secret">비밀글입니다.<i class="bi bi-lock"></i></td>
						<td class="inquiryName" width="150px">정**</td>
						<td class="inquiryDate" width="230px">2025-07-04 13:21</td>
					</tr>
					<tr class="inquiryDetailTr d-none">
						<td colspan="4">
							<div class="border rounded">
								<div id="inquiryDetail3" class="inquiry-detailInfo"></div>
							</div>
						</td>
					</tr>
					<tr class="inquiryTr" data-inquiryId="4">
						<td class="inquiryStatus" width="150px">답변완료</td>
						<td class="inquiryTitle">환불하고 싶을 때는 어떻게 하나요?</td>
						<td class="inquiryName" width="150px">정**</td>
						<td class="inquiryDate" width="230px">2025-07-04 13:21</td>
					</tr>
					<tr class="inquiryDetailTr d-none">
						<td colspan="4">
							<div class="border rounded">
								<div id="inquiryDetail4" class="inquiry-detailInfo"></div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="page-navigation">
			${dataCount==0 ? "등록된 상품이 없습니다." : paging}
		</div>
	</div>
	
</div>

<!-- 상품리뷰 대화상자 -->
<div class="modal fade" id="reviewDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="reviewDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewDialogModalLabel">상품 리뷰 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="review-form p-2">
					<form name="reviewForm" class="reviewForm">
						<div class="row">
							<div class="col">
								<span class="fw-bold">상품 리뷰 쓰기</span>
							</div>
						</div>
						<div class="myOrderList">
							<div class="row p-1">
								<c:if test="${not empty didIBuyThis}">
									<div class="col">
										<span class="pe-3">나의 상품 구매 내역</span>
										<select name="reviewId" class="myOrder-select" style="border: 1px solid #dee2e6; color: #333">
										</select>
									</div>
								</c:if>
							</div>
						</div>
						<div class="p-1">
							<p class="star">
								<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
								<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
								<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
								<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
								<a href="#" class="on"><i class="bi bi-star-fill"></i></a>
								<input type="hidden" name="rate" value="5">
								<input type="hidden" name="gongguProductId" value="${dto.gongguProductId}">
							</p>
						</div>
						<div class="p-1">
							<textarea name="content" class="form-control"></textarea>
						</div>
						<div class="p-1">
							<div class="preview-session">
								<label for="selectFile" class="me-2" tabindex="0" title="이미지 업로드">
									<img class="image-upload-btn" src="${pageContext.request.contextPath}/dist/images/add_photo.png">
									<input type="file" name="selectFile" id="selectFile" hidden="" multiple accept="image/png, image/jpeg">
								</label>
								<div class="image-upload-list"></div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-accent btnReviewSendOk">리뷰등록 <i class="bi bi-check2"></i> </button>
				<button type="button" class="btn-default btnReviewSendCancel" data-bs-dismiss="modal">취소</button>
			</div>			
		</div>
	</div>
</div>

<!-- 상품문의 대화상자 -->
<div class="modal fade" id="inquiryDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="inquiryDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="inquiryDialogModalLabel">상품 문의 하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<div class="qna-form p-2">
					<form name="inquiryForm">
						<div class="row">
							<div class="col">
								<span class="fw-bold">문의사항 쓰기</span><span> - 상품 및 상품 구매 과정과 관련없는 글은 삭제 될 수 있습니다.</span>
							</div>
							<div class="col-3 text-end">
								<input type="checkbox" name="secret" id="secret1" class="form-check-input" value="1">
								<label class="form-check-label" for="secret1">비공개</label>
							</div>
						</div>
						<div class="p-1">
							<input type="hidden" name="gongguProductId" value="${dto.gongguProductId}">
							<input type="text" name="title" placeholder="제목">
							<textarea name="content" id="content" class="form-control" placeholder="문의 내용을 입력하세요."></textarea>
						</div>
					</form>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn-accent btnInquirySendOk">문의등록 <i class="bi bi-check2"></i> </button>
				<button type="button" class="btn-default btnInquirySendCancel" data-bs-dismiss="modal">취소</button>
			</div>			
		</div>
	</div>
</div>

<!-- 상품리뷰 상세 모달 -->
<div class="modal fade" id="reviewDetailDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="reviewDetailDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewDetailDialogModalLabel">리뷰 상세 보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			</div>			
		</div>	
			
	</div>
</div>

<!-- 상품리뷰 사진 모달 -->
<div class="modal fade" id="imgViewDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="imgViewDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="imgViewDialogModalLabel">리뷰 사진 보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body" id="reviewImgModal">
				<div class="row reviewImg-row" id="reviewImgModal-row">
				</div>			
			</div>			
		</div>	

	</div>
</div>
