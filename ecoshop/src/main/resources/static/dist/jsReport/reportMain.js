/* 신고 main */
$(function(){
	let page = PAGE_NUM;
	listPage(page);
	
    $('button[role="tab"]').on('click', function(e){
    	const tab = $(this).attr('aria-controls');
    	
    	const f = document.searchForm;
    	f.status.value = '0';
    	f.schType.value = 'all';
    	f.kwd.value = '';
    	
    	if(tab === 'all') {
    		$('.reports-search').show();
    	} else {
    		$('.reports-search').hide();
    	}
    	
    	listPage(1);
    });
    
    $('#selectStatus').change(function(){
    	const status = $(this).val();
    	const f = document.searchForm;
    	
    	f.status.value = status;
    	
    	listPage(1);
    });
});

function listPage(page) {
	const tab = $('button[role="tab"].active').attr('aria-controls');
	const f = document.searchForm;
	
	let params = 'status=' + f.status.value + '&pageNo=' + page;
	if(tab === 'all' && f.kwd.value.trim()) {
		const formData = new FormData(f);
		params += '&' + new URLSearchParams(formData).toString();
	}
	
	const url = CONTEXT_PATH + '/admin/reportsManage/list/' + tab;
	const fn = function(data){
		const selector = '.reports-list';
		$(selector).html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);	
}

window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	if (inputEL) {
		inputEL.addEventListener('keydown', function (evt) {
			if(evt.key === 'Enter') {
				evt.preventDefault();
				listPage(1);
			}
		});
	}
});

function searchList() {
	listPage(1);
}