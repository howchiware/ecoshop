<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>문의</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

.main-container {
	display: flex;
}

.right-PANEL {
	flex-grow: 1;
	padding: 2rem;
	overflow-y: auto;
}

.outside {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	margin-bottom: 20px;
}

.title {
	margin-bottom: 2em;
}

.category-border {
	border: 1px solid #c6c6c6;
	padding: 30px;
	margin-bottom: 20px;
}

.cg {
	width: 40%;
}

.table {
	width: 100%;
}

.table td:last-child {
    text-align: right;
}

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>
	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="right-PANEL">
			<div class="title" data-aos="fade-up" data-aos-delay="200">
				<h4>카테고리 등록/수정/삭제</h4>
			</div>
			<hr>

			<div class="outside">
				<form action="post" name="categoryForm">
					<p>카테고리 등록</p>
					<div class="category-border">
						<span>카테고리명&nbsp;&nbsp;&nbsp;</span> <input type="text"
							name="categoryName" class="cg border border-dark-subtle">
					</div>
					<div class="d-flex flex-row-reverse">
						<button>저장</button>
					</div>
				</form>
			</div>
			<div class="outside">
				<p>카테고리 수정/삭제</p>
				<table class="table category-border">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리명</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>001</td>
							<td>식품</td>
							<td>
								<button type="button">수정</button>
								<button type="button">삭제</button>
							</td>
						</tr>
						<tr>
							<td>002</td>
							<td>욕실</td>
							<td>
								<button type="button">수정</button>
								<button type="button">삭제</button>
							</td>
						</tr>
						<tr>
							<td>003</td>
							<td>주방</td>
							<td>
								<button type="button">수정</button>
								<button type="button">삭제</button>
							</td>
						</tr>
						<tr>
							<td>004</td>
							<td>리빙</td>
							<td>
								<button type="button">수정</button>
								<button type="button">삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</main>
</body>
</html>
