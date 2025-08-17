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

    const searchBtn = document.getElementById("searchBtn");
    const resetBtn = document.getElementById("resetBtn");
    
    if (searchBtn) {
        searchBtn.setAttribute('data-url', url);
    }
    if (resetBtn) {
        resetBtn.setAttribute('data-url', url);
    }
}

// 리뷰랑 문의 탭 클릭시
$(document).ready(function() {
    const initialReviewTab = document.querySelector('.nav-tab.active');
    if (initialReviewTab) {
        showReviewTab(initialReviewTab);
    }
    
    $('.review-manage-nav .nav-tab').on('click', function() {
        showReviewTab(this);
    });

    // 검색
    $("#searchBtn").click(function() {
        const url = $(this).attr('data-url');
        const searchType = $("#searchType").val();
        const searchValue = $("#searchValue").val();
        const data = {};
        
        if (!searchType) {
            data['gongguProductName'] = searchValue;
        } else {
            data[searchType] = searchValue;
        }
        
        $.ajax({
            url: url,
            type: "GET",
            data: data,
            success: function(response) {
                $("#content-area").html(response);
            },
            error: (xhr, status, error) => {
                console.error("search Error: ", error);
            }
        });
    });
    
    // 초기화
    $("#resetBtn").click(function() {
        $("#searchValue").val("");
        const url = $(this).attr('data-url');
        
        $.ajax({
            url: url,
            type: "GET",
            data: {},
            success: function(response) {
                $("#content-area").html(response);
            },
            error: (xhr, status, error) => {
                console.error("searchReset Error: ", error);
            }
        });
    });
});