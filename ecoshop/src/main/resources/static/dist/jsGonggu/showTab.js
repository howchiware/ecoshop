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
		const initialReviewTab = document.querySelector('.nav-tab.active');
		if (initialReviewTab) {
			showReviewTab(initialReviewTab);
		}
	});
	
	// 공동구매 페이지 카테고리 ajax
		function showCategoryTab(clickButton) {
			const url = clickButton.getAttribute('data-url');
			document.querySelectorAll('.category-container .nav-tab').forEach(div => {
				div.classList.remove('active');
			});
			clickButton.classList.add('active');
			sendAjaxRequest(url, 'GET', null, 'html', function(data) {
				const listContainer = document.querySelector('.list-container');
				if (listContainer) {
					listContainer.innerHTML = data;
				}
			});
		}

		$(document).ready(function() {
			const initialCategoryTab = document.querySelector('.category-container .nav-tab.active');
			if (initialCategoryTab) {
				showCategoryTab(initialCategoryTab);
			}
		});
		
	// 캐러셀
		$('.owl-carousel').owlCarousel({
			loop : true,
			margin : 10,
			nav : true,
			center : true,
			autoplay:true,
			autoplayTimeout:4000,
			autoplayHoverPause:true,
			responsive : {
				0 : {
					items : 1
				},
				1000 : {
					items : 3
				}
			}
		});
		