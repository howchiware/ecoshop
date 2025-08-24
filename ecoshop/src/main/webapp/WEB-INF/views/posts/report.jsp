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
						<select name="reason_code" class="form-select">
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
						<textarea name="reason_detail" class="form-control" style="height: 130px;" placeholder="상세한 신고 내용을 입력해주세요"></textarea>
						<input type="hidden" name="target" value="">
						<input type="hidden" name="target_num" value="">
						<input type="hidden" name="content_type" value="">
						<input type="hidden" name="content_title" value="">
						<input type="hidden" name="contextPath" value="${pageContext.request.contextPath}">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-accent" onclick="sendReports();"> 등록 </button>
				<button type="button" class="btn-default" data-bs-dismiss="modal"> 취소 </button>
			</div>			
		</div>
	</div>
</div>

<script type="text/javascript">
function reports(target, target_num, content_type, content_title) {
	if(! target || ! target_num || ! content_type || ! content_title) {
		alert('신고 게시글이 선택되지 않은 상태입니다.');
		return;
	}
	
	const f = document.reportsForm;
	f.reason_code.value = '';
	f.reason_detail.value = '';
	
	f.target.value = target;
	f.target_num.value = target_num;
	f.content_type.value = content_type;
	f.content_title.value = content_title;
	
	$('#reportDialogModal').modal('show');
}

function sendReports() {
	const f = document.reportsForm;
	
	if(! f.reason_code.value.trim()) {
		alert('신고 사유를 선택하세요.');
		f.reason_code.focus();
		return;
	}

	const contextPath = f.contextPath.value.trim();
	const url = contextPath + '/roports/saved';
	const formData = new FormData(f);
	const params = new URLSearchParams(formData).toString();

	const fn = function(data) {
		const state = data.state;
		if(state === 'true') {
			alert('신고사항이 접수되었습니다.');
		} else if(state === 'liked') {
			alert('신고는 한번만 가능합니다.');
		} else {
			alert('신고사항 처리가 실패했습니다.');
		}
		
		$('#reportDialogModal').modal('hide');
	};
	
	ajaxRequest(url, 'post', params, 'json', fn);
}
</script>
