<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
		
<div class="nav nav-tabs mt-5 myNavTab" id="myTab" role="tablist">
	<div class="nav-item item-div " role="presentation" style="width: 20%">
		<button class="nav-link linkBtn active w-100" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane-1" type="button" role="tab" aria-controls="1" aria-selected="true">식품</button>
	</div>
	<div class="nav-item item-div " role="presentation" style="width: 20%">
		<button class="nav-link linkBtn w-100" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane-2" type="button" role="tab" aria-controls="2" aria-selected="false">욕실</button>
	</div>
	<div class="nav-item item-div " role="presentation" style="width: 20%">
		<button class="nav-link linkBtn w-100" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane-3" type="button" role="tab" aria-controls="3" aria-selected="false">주방</button>
	</div>
	<div class="nav-item item-div " role="presentation" style="width: 20%">
		<button class="nav-link linkBtn w-100" id="tab-4" data-bs-toggle="tab" data-bs-target="#tab-pane-4" type="button" role="tab" aria-controls="4" aria-selected="false">리빙</button>
	</div>
	<div class="nav-item item-div" role="presentation" style="width: 20%">
		<button class="nav-link linkBtn w-100" id="tab-5" data-bs-toggle="tab" data-bs-target="#tab-pane-5" type="button" role="tab" aria-controls="5" aria-selected="false">기타</button>
	</div>
</div>


<div class="tab-content pt-2 category-container" id="myTabContent">
	<div class="category tab-pane fade show active" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
		
		<div class="filter-border">
			<select name="filter" class="filter-style productsSortBy">
				<option value="0">등록순</option>
				<option value="1">인기순</option>
				<option value="2">낮은가격순</option>
				<option value="3">낮은가격순</option>
				<option value="4">상품평 많은 순</option>
			</select>
		</div>
	
		<div class="row row-cols-1 row-cols-md-4 g-4 list-container">
			<div class="col product-card" data-productCode="1">
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/dist/images/Group 303.png"
						class="card-img-top"
						style="position: absolute; width: 100%; height: 100%;"
						alt="...">
				</div>
				<div class="card-body">
				<div class="d-flex justify-content-between align-items-center">
					<h5 class="card-name">리바이브 칫솔</h5>
					<i class="bi bi-heart heart-icon"></i>
				</div>
				<p class="card-price">6000원</p>
					<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
				</div>
			</div>
			<div class="col product-card" data-productCode="2">
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/dist/images/Group 308.png"
						class="card-img-top"
						style="position: absolute; width: 100%; height: 100%;"
						alt="...">
				</div>
				<div class="card-body">
				<div class="d-flex justify-content-between align-items-center">
					<h5 class="card-name">리바이브 칫솔</h5>
					<i class="bi bi-heart heart-icon"></i>
				</div>
				<p class="card-price">6000원</p>
					<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
				</div>
			</div>
			<div class="col product-card" data-productCode="3">
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/dist/images/Group 313.png"
						class="card-img-top"
						style="position: absolute; width: 100%; height: 100%;"
						alt="...">
				</div>
				<div class="card-body">
				<div class="d-flex justify-content-between align-items-center">
					<h5 class="card-name">리바이브 칫솔</h5>
					<i class="bi bi-heart heart-icon"></i>
				</div>
				<p class="card-price">6000원</p>
					<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
				</div>
			</div>
			<div class="col product-card" data-productCode="4">
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/dist/images/Group 303.png"
						class="card-img-top"
						style="position: absolute; width: 100%; height: 100%;"
						alt="...">
				</div>
				<div class="card-body">
				<div class="d-flex justify-content-between align-items-center">
					<h5 class="card-name">리바이브 칫솔</h5>
					<i class="bi bi-heart heart-icon"></i>
				</div>
				<p class="card-price">6000원</p>
					<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
				</div>
			</div>
			<div class="col product-card" data-productCode="5">
				<div class="card">
					<img
						src="${pageContext.request.contextPath}/dist/images/Group 313.png"
						class="card-img-top"
						style="position: absolute; width: 100%; height: 100%;"
						alt="...">
				</div>
				<div class="card-body">
				<div class="d-flex justify-content-between align-items-center">
					<h5 class="card-name">리바이브 칫솔</h5>
					<i class="bi bi-heart heart-icon"></i>
				</div>
				<p class="card-price">6000원</p>
					<a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
				</div>
			</div>
		</div>
	</div>
<!-- 
	<!-- 상품 설명 탭 Content
	<div class="category tab-pane fade show active" id="tab-pane-1" role="tabpanel" aria-labelledby="tab-1" tabindex="0">
		
	</div>
	
	<!-- 상품 리뷰 탭 Content
	<div class="category tab-pane fade" id="tab-pane-2" role="tabpanel" aria-labelledby="tab-2" tabindex="0">
		
	</div>
	
	<!-- 상품 문의 탭 Content
	<div class="category tab-pane fade inquiry-total-area" id="tab-pane-3" role="tabpanel" aria-labelledby="tab-3" tabindex="0">
		
	</div>

	<!-- 상품 문의 탭 Content
	<div class="category tab-pane fade inquiry-total-area" id="tab-pane-3" role="tabpanel" aria-labelledby="tab-3" tabindex="0">
		
	</div>

	<!-- 상품 문의 탭 Content
	<div class="category tab-pane fade inquiry-total-area" id="tab-pane-3" role="tabpanel" aria-labelledby="tab-3" tabindex="0">
		
	</div>
-->
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
