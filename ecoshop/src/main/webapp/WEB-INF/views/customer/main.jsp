<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND - 고객센터</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    :root {
        --primary-color: #234d3c; /* Ecobrand's primary green */
        --secondary-color: #f8f9fa;
        --border-color: #dee2e6;
        --text-dark: #212529;
        --text-light: #6c757d;
    }

    /* Main Layout */
    .customer-center-container {
        display: flex;
        gap: 30px;
    }
    .page-header h2 {
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 2rem;
    }

    /* Sidebar Navigation */
    .sidebar {
        width: 220px;
        flex-shrink: 0;
    }
    .sidebar-nav h4 {
        font-size: 1.1rem;
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 1rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--primary-color);
    }
    .sidebar-nav ul {
        list-style: none;
        padding-left: 0;
        margin-bottom: 2.5rem;
    }
    .sidebar-nav a {
        display: block;
        padding: 0.75rem 1rem;
        text-decoration: none;
        color: var(--text-dark);
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    .sidebar-nav a:hover {
        background-color: var(--secondary-color);
        color: var(--primary-color);
    }
    .sidebar-nav a.active {
        background-color: var(--primary-color);
        color: #fff;
        font-weight: 600;
    }
    
    /* Content Area */
    .content {
        flex-grow: 1;
    }
    .content-header h3 {
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 1.5rem;
    }
    
    /* FAQ Accordion */
    .accordion-button:not(.collapsed) {
        background-color: var(--primary-color);
        color: #fff;
    }
    .accordion-button:focus {
        box-shadow: 0 0 0 0.25rem rgba(35, 77, 60, 0.25);
    }

    /* Inquiry Tabs */
    .nav-tabs .nav-link {
        font-weight: 600;
        color: var(--text-light);
    }
    .nav-tabs .nav-link.active {
        color: var(--primary-color);
        border-color: var(--border-color) var(--border-color) #fff;
        border-bottom: 3px solid var(--primary-color);
    }
    
    /* Inquiry List Table */
    .inquiry-list td .status-badge {
        font-size: 0.8em;
        padding: 0.4em 0.7em;
    }
</style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">
    <div class="page-header">
        <h2>고객센터</h2>
    </div>
    
    <div class="customer-center-container">
        <aside class="sidebar">
            <nav class="sidebar-nav">
                <h4>1:1 문의</h4>
                <ul>
                    <li><a href="#" data-view="inquiry">문의하기 / 내역확인</a></li>
                </ul>
            </nav>
            
            <nav class="sidebar-nav">
                <h4>자주 묻는 질문</h4>
                <ul>
                    <li><a href="#" class="active" data-view="faq" data-category="0">전체</a></li>
                    <li><a href="#" data-view="faq" data-category="1">회원/계정</a></li>
                    <li><a href="#" data-view="faq" data-category="2">결제/환불</a></li>
                    <li><a href="#" data-view="faq" data-category="3">이벤트/챌린지</a></li>
                    <li><a href="#" data-view="faq" data-category="4">포인트</a></li>
                    <li><a href="#" data-view="faq" data-category="5">프로그램/워크숍</a></li>
                </ul>
            </nav>
        </aside>
        
        <section class="content" id="customer-center-content">
            <%-- AJAX로 콘텐츠가 로드될 영역 --%>
        </section>
    </div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
$(function() {
    // 페이지 첫 로드 시 'FAQ 전체' 목록을 불러옴
    loadContent('faq', 0);

    // 사이드바 메뉴 클릭 이벤트
    $('.sidebar-nav a').on('click', function(e) {
        e.preventDefault();

        // 모든 메뉴의 active 클래스 제거 후, 클릭한 메뉴에만 추가
        $('.sidebar-nav a').removeClass('active');
        $(this).addClass('active');

        const view = $(this).data('view');
        const category = $(this).data('category');

        loadContent(view, category);
    });
});

function loadContent(view, category) {
    let url = "";
    let params = {};

    if (view === 'faq') {
        url = "${pageContext.request.contextPath}/support/faq";
        params.category = category;
    } else if (view === 'inquiry') {
        url = "${pageContext.request.contextPath}/support/inquiry";
    }

    $.ajax({
        url: url,
        type: 'GET',
        data: params,
        success: function(data) {
            $('#customer-center-content').html(data);
        },
        error: function(err) {
            $('#customer-center-content').html('<p>콘텐츠를 불러오는 중 오류가 발생했습니다.</p>');
            console.error(err);
        }
    });
}

// 1:1 문의 폼 제출 이벤트 (AJAX로 로드된 후의 이벤트는 이와 같이 처리)
$(document).on('submit', 'form[name="inquiryForm"]', function(e) {
    e.preventDefault();
    
    // 폼 유효성 검사 등...
    
    const formData = $(this).serialize();
    
    $.ajax({
        url: '${pageContext.request.contextPath}/support/inquiry/submit',
        type: 'POST',
        data: formData,
        success: function(response) {
            alert('문의가 성공적으로 등록되었습니다.');
            // 등록 후 '내 문의내역' 탭으로 이동
            loadContent('inquiry');
        },
        error: function(err) {
            alert('문의 등록 중 오류가 발생했습니다.');
        }
    });
});
</script>
</body>
</html>