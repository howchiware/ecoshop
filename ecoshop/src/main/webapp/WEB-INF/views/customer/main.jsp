<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/home.css"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    :root {
        --primary-color: #234d3c;
        --secondary-color: #f8f9fa;
        --border-color: #e9ecef;
        --text-dark: #2c3e50;
        --text-light: #8492a6;
        --body-bg: #f5f7f9;
    }
    body {
        background-color: var(--body-bg);
    }
    .page-header h2 {
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 3px solid var(--text-dark);
    }
    .customer-center-container {
        display: flex;
        align-items: flex-start;
        gap: 30px;
    }
    .sidebar {
        width: 240px;
        flex-shrink: 0;
        background-color: #fff;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        padding: 20px;
    }
    .sidebar-nav h4 {
        font-size: 1.1rem;
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 1rem;
        padding-bottom: 0.75rem;
        border-bottom: 1px solid var(--border-color);
    }
    .sidebar-nav ul {
        list-style: none;
        padding-left: 0;
        margin-bottom: 2rem;
    }
    .sidebar-nav li {
        margin-bottom: 5px;
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
	color: #fff !important; 
	font-weight: 600;
}
    .content {
        flex-grow: 1;
        background-color: #fff;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        padding: 30px;
        min-height: 500px;
    }
    .sidebar-nav a:visited {
    color: var(--text-dark); 
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
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
						<li><a data-view="inquiry">문의하기 / 내역</a></li>
					</ul>
				</nav>

				<nav class="sidebar-nav">
					<h4>자주 묻는 질문</h4>
					<ul class="list-group">
						<li><a class="active" data-view="faq" data-category="0">전체</a></li>
						<c:forEach var="dto" items="${faqListCategory}">
							<li><a data-view="faq" data-category="${dto.categoryId}">${dto.categoryName}</a></li>
						</c:forEach>
					</ul>
				</nav>
			</aside>

			<section class="content" id="customer-center-content"></section>

		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
    $(function() {
        loadContent('faq', 0);

        $('.sidebar-nav a').on('click', function(e) {
            e.preventDefault();
            $('.sidebar-nav a').removeClass('active');
            $(this).addClass('active');
            const view = $(this).data('view');
            const category = $(this).data('category');
            loadContent(view, category);
        });
    });

    function loadContent(view, category) {
        let url = "";
        let params =  {};

        if (view === 'faq') {
            url = "${pageContext.request.contextPath}/customer/faqList";
            params.categoryId = category;
        } else if (view === 'inquiry') {
            url = "${pageContext.request.contextPath}/customer/inquiry";
        } else {
            return;
        }

        $.ajax({
            url : url,
            type : 'GET',
            data : params,
            success : function(data) {
                $('#customer-center-content').html(data);
            },
            error : function(jqXHR) {
                if(jqXHR.status === 401) {
                    location.href = "${pageContext.request.contextPath}/member/login";
                } else {
                    $('#customer-center-content').html('<p>콘텐츠를 불러오는 중 오류가 발생했습니다.</p>');
                }
            }
        });
    }

    $(document).on('submit', 'form[name="inquiryForm"]', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();
        $.ajax({
            url: '${pageContext.request.contextPath}/customer/inquiry',
            type: 'POST',
            data: formData,
            success: function(response) {
                if(response.state === 'true') {
                    alert('문의가 등록되었습니다.');
                    loadContent('inquiry'); 
                } else if(response.state === 'loginRequired') {
                    location.href = "${pageContext.request.contextPath}/member/login";
                } else {
                    alert('문의 등록에 실패했습니다.');
                }
            },
            error: function() {
                alert('문의 등록 중 오류가 발생했습니다.');
            }
        });
    });

    function detailInquiry(inquiryId, page) {
        let url = '${pageContext.request.contextPath}/customer/inquiry/detail';
        url += '?inquiryId=' + inquiryId + '&pageNo=' + page;
        
        $.get(url, function(data) {
            $('#customer-center-content').html(data);
        }).fail(function() {
            alert("상세 정보를 불러오는 데 실패했습니다.");
        });
    }

    $(document).on('click', '.btn-edit', function() {
        $('#inquiry-view-mode').hide();
        $('#inquiry-edit-mode').show();
    });

    $(document).on('click', '.btn-cancel-edit', function() {
        $('#inquiry-edit-mode').hide();
        $('#inquiry-view-mode').show();
    });

    $(document).on('submit', 'form[name="inquiryUpdateForm"]', function(e) {
        e.preventDefault();
        if (!confirm('문의 내용을 수정하시겠습니까?')) return;

        const formData = $(this).serialize();
        $.ajax({
            url: '${pageContext.request.contextPath}/customer/inquiry/update',
            type: 'POST',
            data: formData,
            success: function(response) {
                if (response.state === 'true') {
                    alert('수정되었습니다.');
                    loadContent('inquiry');
                } else {
                    alert('수정에 실패했습니다.');
                }
            }
        });
    });

    $(document).on('click', '.btn-delete', function() {
        if (!confirm('이 문의를 정말 삭제하시겠습니까?')) return;

        const inquiryId = $(this).data('inquiry-id');
        $.ajax({
            url: '${pageContext.request.contextPath}/customer/inquiry/delete',
            type: 'POST',
            data: { inquiryId: inquiryId },
            success: function(response) {
                if (response.state === 'true') {
                    alert('삭제되었습니다.');
                    loadContent('inquiry');
                } else {
                    alert('삭제에 실패했습니다.');
                }
            }
        });
    });
</script>
</body>
</html>