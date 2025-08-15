	function sendAjaxRequest(url, method, params, responseType, fn, file = false) {
		const settings = {
			url,
			type: method,
			data: params,
			dataType: responseType,
			success: fn,
			beforeSend: xhr => xhr.setRequestHeader('AJAX', true),
			error: xhr => {
				console.log('AJAX error', xhr.status, xhr.responseText);
				if (xhr.status === 403) {
					alert('error: ', e);
				}
			}
		};
		if (file) {
			settings.processData = false;
			settings.contentType = false;
		}
		$.ajax(settings);
	}

	// 리뷰랑 문의 탭 ajax
	function showReviewTab(clickButton) {
		const url = clickButton.getAttribute('data-url');
		
		document.querySelectorAll('.review-manage-nav .nav-tab').forEach(btn => {
			btn.classList.remove('active');
		});
		clickButton.classList.add('active');

		sendAjaxRequest(url, 'GET', null, 'html', function(data) {
			const contentArea = document.querySelector("#content-area");
			if (contentArea) {
				contentArea.innerHTML = data;
			}
		}, false);
	}
	
	$(document).ready(function() {
		const initialButton = document.querySelector('.nav-tab.active');
		if (initialButton) {
			showReviewTab(initialButton);
		}
	});
	
	