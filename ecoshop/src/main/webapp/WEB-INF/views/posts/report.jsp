<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- 신고 -->
<div class="modal fade" id="reportDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="reportDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportDialogModalLabel">신고 사유</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="reportsForm" method="post">
					<div class="px-1">
						<select name="reasonCode" class="form-select">
							<option value="">-- 사유를 선택하세요 --</option>
							<option value="스팸/광고">스팸 및 광고</option>
							<option value="욕설/비방">욕설 및 비방</option>
							<option value="음란물">음란물</option>
							<option value="부적절한 콘텐츠">부적절한 콘텐츠</option>
							<option value="저작권침해">저작권 침해</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div class="row reply-form m-1">
						<textarea name="reasonDetail" class="form-control my-txt" style="height: 130px;" placeholder="상세한 신고 내용을 입력해주세요"></textarea>
						<input type="hidden" name="target" value="">
						<input type="hidden" name="targetNum" value="">
						<input type="hidden" name="contentType" value="">
						<input type="hidden" name="contentTitle" value="">
						<input type="hidden" name="contextPath" value="${pageContext.request.contextPath}">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-accent btn-action" onclick="sendReports();"> 등록 </button>
				<button type="button" class="btn-default btn-action" data-bs-dismiss="modal"> 취소 </button>
			</div>			
		</div>
	</div>
</div>


