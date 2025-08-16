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
		});
	}
	
	$(document).ready(function() {
		const initialReviewTab = document.querySelector('.nav-tab.active');
		if (initialReviewTab) {
			showReviewTab(initialReviewTab);
		}
	});
	
	
		