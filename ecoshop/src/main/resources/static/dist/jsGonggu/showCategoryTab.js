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
	nav : false,
	dots: false,
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

$(function(){
	$('.list-container').on('click', '.card-img', function(){
		let productIdStr = $(this).attr('data-gongguProductId');

		let gongguProductId = Number(productIdStr);
		
		location.href = gongguProductId;
	});
});

function changeSortSelect(){
	let sortBy = $("#gongguSortBy option:selected").val();
	listProducts(1);
}

function listProducts(page) {
	let categoryId = '';
	document.querySelectorAll('.category-container .nav-tab').forEach(div => {
		if(div.classList.contains('active')){
			categoryId = div.getAttribute('data-cat-id');
		}
	});
	let sortBy = $("#gongguSortBy option:selected").val();

	if(! sortBy){
		sortBy = 0;
	}
	console.log(categoryId);
	
	let url = '/gonggu/list';
	let requestParams = {categoryId:categoryId, page:page, sortBy:sortBy};
	let selector = 'div.list-container';
	
	const fn = function(data) {
		$(selector).html(data);
	};

	sendAjaxRequest(url, 'get', requestParams, 'text', fn);
}