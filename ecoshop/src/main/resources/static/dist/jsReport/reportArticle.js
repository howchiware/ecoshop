/* 신고 article */
$(function(){
	listPage(1);
});

function listPage(page) {
	// 동일 게시물 신고리스트
	const url = CONTEXT_PATH + '/admin/reportsManage/listRelated';
	const params = 'reportId=' + REPORT_ID + '&targetNum=' + TARGET_NUM + '&target=' + TARGET + '&pageNo=' + page;
	const fn = function(data){
		const selector = '.reports-list';
		$(selector).html(data);
	};

	ajaxRequest(url, 'get', params, 'text', fn);	
}

function reportProcess(mode) {
	// 신고처리 대화상자 출력
	const f = document.reportsForm;
	
	f.mode.value = mode;
	f.actionTaken.value = '';
	f.reportStatus.value = '2'
	f.reportAction.value = 'blind';
	
	if(mode === 'one') {
		$('#reportHandledDialogModalLabel').html('신고처리');
	} else {
		$('#reportHandledDialogModalLabel').html('동일게시글 일괄처리');
	}
	
	$('#reportHandledDialogModal').modal('show');
}

function reportProcessSaved() {
	const f = document.reportsForm;
	
	if(! f.actionTaken.value.trim()) {
		alert('조치사항을 입력 하세요.');
		return;
	}
	
	f.action = CONTEXT_PATH + '/admin/reportsManage/update';
	f.submit();
}

function postsView() {
	$('#postsDialogModal').modal('show');
}

$(function(){
	$('#report-status').change(function(){
		let value = $(this).val();
		
		if(value === '3') {
			$('#report-action').val('none');
		} else {
			$('#report-action').val('blind');
		}
	});
});