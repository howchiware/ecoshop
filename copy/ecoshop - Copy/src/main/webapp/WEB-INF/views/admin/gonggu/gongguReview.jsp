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
}

.f {
	text-align: center;
}

.select-two {
	padding: 30px;
}

.two {
	text-align: center;
}
.title {
	margin-bottom: 2em;
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
				<h4>리뷰 및 Q&A 관리</h4>
			</div>
			<hr>
			
			<div class="outside">
				<div class="row mb-2">
					<div class="col-md-6 two">
						<button type="button" class="btn two" a href="#" aria-current="page">상품리뷰</button>
					</div>
					<div class="col-md-6 two">
						<button type="button" class="btn two" a href="#">상품문의</button>
					</div>
				</div>
				<hr>
				<div class="row select-two">
					<div class="col input-group mb-3">
						<input type="text" class="form-control" placeholder="상품명"
							aria-label="productName" aria-describedby="searching"
							style="width: 50%">
						<button class="btn btn-outline-secondary" type="button"
							id="searching">🔍</button>
					</div>
					<div class="col input-group mb-3">
						<input type="text" class="form-control" placeholder="내용, 작성자"
							aria-label="content" aria-describedby="searching"
							style="width: 50%">
						<button class="btn btn-outline-secondary" type="button"
							id="searching">🔍</button>
					</div>
				</div>

				<table class="table table-borderless board-list">
					<thead class="table-light">
						<tr class="border-bottom">
							<th width="140">상품</th>
							<th>내용</th>
							<th width="100">작성자</th>
							<th width="140">일시</th>
							<th width="140">상태</th>
							<th width="100">관리</th>
						</tr>
					</thead>
					<tbody>
						
							<tr class="item-basic-content border-bottom">
								<td>123456789 BlackJacket</td>
								<td class="left">너무 좋은거같은데요? 우하하하하</td>
								<td>정**</td>
								<td>2025-08-11</td>
								<td>${not empty dto.answer ? '<span class="text-primary">답변완료</span>' : '<span class="text-secondary">답변대기</span>'}
								</td>
								<td>
									<button type="button" class="btn btn-primary">등록</button>
								</td>
							</tr>
					
					</tbody>
				</table>
			</div>
		</div>



	</main>
</body>
</html>
