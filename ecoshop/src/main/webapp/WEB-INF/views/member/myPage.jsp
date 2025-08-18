<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND - 마이페이지</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<style>
    :root {
        --primary-color: #234d3c;
        --border-color: #e9ecef;
        --text-dark: #2c3e50;
        --text-light: #8492a6;
        --body-bg: #f5f7f9;
    }
    body {
        background-color: var(--body-bg);
    }
    .page-header h1 {
        font-weight: 800;
        color: var(--text-dark);
    }
    
    .my-page-panel {
        display: flex;
        background-color: #fff;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        min-height: 700px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.04);
    }

    .sidebar-nav {
        width: 240px;
        flex-shrink: 0;
        padding: 30px 20px;
        border-right: 1px solid var(--border-color); 
    }
    .sidebar-nav .nav-section {
        margin-bottom: 1.5rem;
        padding-bottom: 1.5rem;
        border-bottom: 1px solid var(--border-color);
    }
    .sidebar-nav .nav-section:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    .sidebar-nav .nav-title {
        font-size: 1.25rem;
        font-weight: 800;
        color: var(--text-dark);
        margin-bottom: 1rem;
    }
    .sidebar-nav ul {
        list-style: none;
        padding-left: 0;
        margin: 0;
    }
    .sidebar-nav li {
        margin-bottom: 0.5rem;
    }
    .sidebar-nav a {
        font-size: 1rem;
        font-weight: 500;
        color: var(--primary-color);
        text-decoration: none;
        transition: all 0.2s ease;
        cursor: pointer;
        display: inline-block;
        padding: 5px 0;
    }
    .sidebar-nav a:hover {
        color: var(--primary-color);
    }
    .sidebar-nav a.active {
    color: var(--primary-color);
    font-weight: 700;
    background-color: #e6f4ea; 
    position: relative; 
}


    .content-panel {
        flex-grow: 1;
        padding: 30px 40px;
    }
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    
    <main class="container my-5">
        <div class="page-header mb-4">
            <h1>마이페이지</h1>
        </div>
        
        <div class="my-page-panel">
            <aside class="sidebar-nav">
                <div class="nav-section">
                    <h3 class="nav-title">마이쇼핑</h3>
                    <ul>
                        <li><a class="active" data-view="orders">주문/배송 조회</a></li>
                        <li><a data-view="returns">취소/반품 내역</a></li>
                    </ul>
                </div>
                
                <div class="nav-section">
                    <ul>
                        <li><a data-view="cart">장바구니</a></li>
                        <li><a data-view="likes">좋아요</a></li>
                    </ul>
                </div>
                
                <div class="nav-section">
                    <ul>
                        <li><a data-view="points">포인트</a></li>
                    </ul>
                </div>

                <div class="nav-section">
                    <h3 class="nav-title">마이활동</h3>
                    <ul>
                        <li><a data-view="challenges">챌린지</a></li>
                        <li><a data-view="workshops">워크숍</a></li>
                        <li><a data-view="inquiries">1:1 문의내역</a></li>
                        <li><a data-view="reviews">리뷰</a></li>
                        <li><a data-view="qna">상품Q&A 내역</a></li>
                        <li><a data-view="events">이벤트 참여 현황</a></li>
                    </ul>
                </div>

                <div class="nav-section">
                    <h3 class="nav-title">마이정보</h3>
                    <ul>
                        <li><a data-view="profile">회원정보 수정</a></li>
                        <li><a data-view="shipping">배송지/환불계좌</a></li>
                        <li><a data-view="withdraw">회원탈퇴</a></li>
                    </ul>
                </div>
            </aside>

            <section class="content-panel" id="myPageContent"></section>
        </div>
    </main>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function() {
            loadMyPageContent('orders');

            $('.sidebar-nav a').on('click', function(e) {
                e.preventDefault();

                $('.sidebar-nav a').removeClass('active');
                $(this).addClass('active');

                const view = $(this).data('view');
                loadMyPageContent(view);
            });
        });

        function loadMyPageContent(view) {
            if (!view) return;

            const url = "${pageContext.request.contextPath}/mypage/" + view;

            $.ajax({
                url: url,
                type: 'GET',
                success: function(data) {
                    $('#myPageContent').html(data);
                },
                error: function(jqXHR) {
                    if (jqXHR.status === 401) {
                        location.href = "${pageContext.request.contextPath}/member/login";
                    } else {
                        $('#myPageContent').html('<p>콘텐츠를 불러오는 중 오류가 발생했습니다.</p>');
                    }
                }
            });
        }
    </script>
</body>
</html>