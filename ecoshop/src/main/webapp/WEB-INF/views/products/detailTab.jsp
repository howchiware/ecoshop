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
		<div class="mt-4 mb-5 pb-4 product-content border-bottom">
			${dto.content}상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보<br>
			상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보<br>
			상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보<br>
			상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보<br>
			상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보상품 정보<br>
		</div>
		<div class="mt-4 mb-5 product-deliveryInfo border-bottom">
			<div class="border-bottom delivery-header">
				<p>배송 정보</p>
			</div>
			<div class="deliveryInfo-div">
				<p>- 모든 제품의 배송은 Plastic Free 원칙으로 종이재질로 발송됩니다. (종이박스, 종이완충재, 종이테이프)<br>- 수령하신 택배박스는 운송장을 제거한 후 종이로 분리배출 해주세요.<br>- 결제완료 후 제품을 수령하시기까지 약 2~5일 소요됩니다.<br>- 배송이 늦어지거나 일부 제품이 품절인 경우 개별적으로 연락을 드립니다.<br>- 40,000원 이상 주문 건의 경우 무료배송됩니다.</p>
			</div>
		</div>
		<div class="mt-4 mb-5 product-refundInfo border-bottom">
			<div class="border-bottom refund-header">
				<p>환불 안내</p>
			</div>
			<div class="refundInfo-div">
				<p>- 구매자의 단순 변심에 의한 반품 요청은 제품 수령 후 7일 이내에 가능합니다. (이때 발생하는 왕복배송비는 구매자 부담입니다.)<br>- 반품을 원하시는 경우 소비자상담실(01-0235-0342)로 문의 부탁드립니다.<br>- 제품을 개봉하여서 사용하셨을 경우 반품이 불가합니다. (제품 하자에 의한 환불은 가능합니다.)</p>
			</div>
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
							<input type="hidden" name="productCode" value="1">
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
