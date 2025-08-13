<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
		
<div class="nav nav-tabs mt-5 myNavTab" id="myTab" role="tablist">
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn active w-100" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane-1" type="button" role="tab" aria-controls="1" aria-selected="true">상세정보</button>
	</div>
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn w-100" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane-2" type="button" role="tab" aria-controls="2" aria-selected="false">구매후기 <span class="title-reviewCount">(10)</span></button>
	</div>
	<div class="nav-item item-div col-4" role="presentation">
		<button class="nav-link linkBtn w-100" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane-3" type="button" role="tab" aria-controls="3" aria-selected="false">Q&A <span class="title-qnaCount">(3)</span></button>
	</div>
</div>

<div class="tab-content pt-2" id="myTabContent">
	<!-- 상품 설명 탭 Content -->
	<div class="tab-pane fade show active" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
		<div class="mt-3 pt-3 border-bottom">
			<p class="fs-4 fw-semibold">${dto.productName}</p> 
		</div>
		<div class="mt-3 product-content">
			${dto.content}
		</div>
	</div>
	
	<!-- 상품 리뷰 탭 Content -->
	<div class="tab-pane fade" id="tab-pane-2" role="tabpanel" aria-labelledby="tab-2" tabindex="0">
		<div class="mt-3 pt-3 border-bottom">
			<p class="fs-4 fw-semibold">상품 리뷰</p> 
		</div>

		<div class="row border-bottom">
			<div class="col p-3 text-center">
				<div class="fs-6 fw-semibold">상품만족도</div>
				<div class="score-star review-score-star">
					<fmt:parseNumber var="intScore" value="${dto.score}" integerOnly="true" type="number"/>
					<c:forEach var="i" begin="1" end="${intScore}">
						<i class="bi bi-star-fill"></i>
					</c:forEach>
					<c:if test="${dto.score -  intScore >= 0.5}">
						<i class="bi bi bi-star-half"></i>
						<c:set var="intScore" value="${intScore+1}"/>
					</c:if>
					<c:forEach var="i" begin="${intScore + 1}" end="5">
						<i class="bi bi-star"></i>
					</c:forEach>
				</div>
				<div class="fs-2">
					<label class="review-score">${dto.score} / 5</label> 
				</div>
			</div>
			
			<div class="col p-3 text-center">
				<div class="fs-6 fw-semibold">리뷰수</div>
				<div class="fs-2"><i class="bi bi-chat-right-text"></i></div>
				<div class="fs-2 review-reviewCount">${dto.reviewCount}</div>
			</div> 
			
			<div class="col p-3 text-center review-rate">
				<div class="fs-6 fw-semibold">평점비율</div>
				<div class="p-1 score-5">
					<span class="graph-title">5점</span>
					<span class="graph">
						<c:forEach var="n" begin="1" end="10">
							<label class="one-space"></label>
						</c:forEach>
					</span>
					<span class="graph-rate">0%</span>
				</div>
				<div class="p-1 score-4">
					<span class="graph-title">4점</span>
					<span class="graph">
						<c:forEach var="n" begin="1" end="10">
							<label class="one-space"></label>
						</c:forEach>
					</span>
					<span class="graph-rate">0%</span>
				</div>
				<div class="p-1 score-3">
					<span class="graph-title">3점</span>
					<span class="graph">
						<c:forEach var="n" begin="1" end="10">
							<label class="one-space"></label>
						</c:forEach>
					</span>
					<span class="graph-rate">0%</span>
				</div>
				<div class="p-1 score-2">
					<span class="graph-title">2점</span>
					<span class="graph">
						<c:forEach var="n" begin="1" end="10">
							<label class="one-space"></label>
						</c:forEach>
					</span>
					<span class="graph-rate">0%</span>
				</div>
				<div class="p-1 score-1">
					<span class="graph-title">1점</span>
					<span class="graph">
						<c:forEach var="n" begin="1" end="10">
							<label class="one-space"></label>
						</c:forEach>
					</span>
					<span class="graph-rate">0%</span>
				</div>
			</div>
		</div>

		<div class="row mt-3 reviewSort-area">
			<div class="col">&nbsp;</div>
			<div class="col-auto text-end">
				<select class="form-select reviewSortBy" style="width: 180px;">
					<option value="0"> 출력 순서 </option>
					<option value="1"> 최신 글 </option>
					<option value="2"> 평점 높은순 </option>
					<option value="3"> 평점 낮은순 </option>
				</select>
			</div>
		</div>
		<div class="mt-2 list-review"></div>
	</div>
	
	<!-- 상품 문의 탭 Content -->
	<div class="tab-pane fade" id="tab-pane-3" role="tabpanel" aria-labelledby="tab-3" tabindex="0">
		<div class="mt-3 pt-3 border-bottom">
			<p class="fs-4 fw-semibold">상품 문의 사항</p> 
		</div>

		<div class="mt-3 p-2 text-end">
			<button type="button" class="btnMyQuestion btn-default" ${empty sessionScope.member ? "disabled":""}> 내 문의 보기  </button>
			<button type="button" class="btnQuestion btn-accent" ${empty sessionScope.member ? "disabled":""}> 상품 문의 작성 </button>
		</div>
		<div class="mt-1 p-2 list-question"></div>
	</div>
	
	<!-- 배송 및 환불 정책 탭 Content -->
	<div class="tab-pane fade" id="tab-pane-4" role="tabpanel" aria-labelledby="tab-4" tabindex="0">
		<div class="mt-3 pt-3 border-bottom">
			<p class="fs-4 fw-semibold">배송 및 환불정책</p> 
		</div>
		<div class="mt-3">
			<p> 배송 및 환불 정책 입니다. </p>
		</div>				
	</div>
</div>

<!-- 상품문의 대화상자 -->
<div class="modal fade" id="questionDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="questionDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="questionDialogModalLabel">상품 문의 하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<div class="qna-form p-2">
					<form name="questionForm">
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
							<input type="hidden" name="productNum" value="${dto.productNum}">
							<textarea name="question" id="question" class="form-control"></textarea>
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
				<button type="button" class="btn-accent btnQuestionSendOk">문의등록 <i class="bi bi-check2"></i> </button>
				<button type="button" class="btn-default btnQuestionSendCancel" data-bs-dismiss="modal">취소</button>
			</div>			
		</div>
	</div>
</div>
