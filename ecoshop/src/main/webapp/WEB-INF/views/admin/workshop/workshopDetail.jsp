<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 상세</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	box-sizing: border-box;
}

@font-face {
	font-family: 'Pretendard';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

body {
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

.workshop-img {
	max-width: 400px;
	height: auto;
	display: block;
	margin-bottom: 20px;
	border-radius: 8px;
	border: 1px solid #ddd;
}

.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
	height: 30px;
	width: 51px;
}

.view-table {
	width: 100%;
	border-collapse: collapse;
}

.view-table th, .view-table td {
	border-bottom: 1px solid #eee;
	padding: 12px 10px;
}

.view-table th {
	width: 140px;
	background: #fafafa;
	font-weight: 500;
	color: #555;
	text-align: left;
}

.view-table td {
	color: #222;
}

.view-photos img {
	max-width: 200px;
	height: auto;
	margin: 4px;
	border: 1px solid #eee;
	border-radius: 4px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4 class="m-0">워크샵 상세</h4>
				<div>
					<button type="button" class="btn-manage"
						onclick="location.href='${ctx}/admin/workshop/list?${query}'">목록</button>

					<button type="button" class="btn-manage"
						onclick="location.href='${ctx}/admin/workshop/update?num=${dto.workshopId}&page=${page}'">수정</button>

					<form action="${ctx}/admin/workshop/delete" method="post"
						style="display: inline;">
						<input type="hidden" name="num" value="${dto.workshopId}">
						<input type="hidden" name="page" value="${page}">
						<button type="submit" class="btn-manage"
							onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
					</form>
				</div>
			</div>

			<div class="card">
				<div class="card-body">
					<table class="view-table">
						<tbody>
							<c:if test="${not empty dto.thumbnailPath}">
								<tr>
									<th>썸네일</th>
									<td><img
										src="${ctx}/uploads/workshop/${dto.thumbnailPath}"
										alt="워크샵 이미지"
										style="max-width: 400px; height: auto; border: 1px solid #ddd; border-radius: 8px;">
									</td>
								</tr>
							</c:if>

							<tr>
								<th>제목</th>
								<td>${dto.workshopTitle}</td>
							</tr>

							<tr>
								<th>일정</th>
								<td><fmt:formatDate value="${dto.scheduleDate}"
										pattern="yyyy.MM.dd" /></td>
							</tr>

							<tr>
								<th>정원</th>
								<td>${dto.capacity}명</td>
							</tr>

							<tr>
								<th>상태</th>
								<td><c:choose>
										<c:when test="${dto.workshopStatus == 1}">모집</c:when>
										<c:when test="${dto.workshopStatus == 0}">마감</c:when>
										<c:when test="${dto.workshopStatus == 2}">취소</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose></td>
							</tr>

							<tr>
								<th>내용</th>
								<td style="white-space: pre-line;"><c:out
										value="${dto.workshopContent}" /></td>
							</tr>


							<c:if test="${not empty photoList}">
								<tr>
									<th>상세 이미지</th>
									<td class="view-photos"><c:forEach var="p"
											items="${photoList}">
											<img src="${ctx}/uploads/workshop/${p.workshopImagePath}"
												alt="워크샵 상세 이미지">
										</c:forEach></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</main>

</body>
</html>
