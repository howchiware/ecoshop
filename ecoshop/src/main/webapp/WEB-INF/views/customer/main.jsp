<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssCustomer/customer.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssCustomer/faq.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssCustomer/inquiry.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssCustomer/detail.css" type="text/css">
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
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsCustomer/faq.js"></script>

</body>
</html>