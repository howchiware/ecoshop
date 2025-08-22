<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 상세</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.workshop-img {
	max-width: 400px;
	height: auto;
	display: block;
	margin-bottom: 20px;
	border-radius: 8px;
	border: 1px solid #ddd;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">

			<!-- 상단 바 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4 class="m-0">워크샵 상세</h4>
				<div>
					<a href="${ctx}/admin/workshop/list?${query}"
						class="btn btn-secondary btn-sm">목록</a> <a
						href="${ctx}/admin/workshop/update?workshopId=${dto.workshopId}&page=${page}"
						class="btn btn-primary btn-sm">수정</a>
				</div>
			</div>

			<!-- 내용 -->
			<div class="card">
				<div class="card-body">

					<!-- 썸네일 -->
					<c:if test="${not empty dto.thumbnailPath}">
						<img src="${ctx}/uploads/workshop/${dto.thumbnailPath}"
							alt="워크샵 이미지" class="workshop-img">
					</c:if>

					<h5 class="card-title">${dto.workshopTitle}</h5>
					<p class="text-muted mb-2">
						<fmt:formatDate value="${dto.scheduleDate}" pattern="yyyy.MM.dd" />
						| 정원: ${dto.capacity}명 | 상태:
						<c:choose>
							<c:when test="${dto.workshopStatus == 1}">모집</c:when>
							<c:when test="${dto.workshopStatus == 0}">마감</c:when>
							<c:when test="${dto.workshopStatus == 2}">취소</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</p>

					<!-- 설명 -->
					<div class="mt-3">${dto.workshopContent}</div>
					
					<!-- 상세 이미지 -->
					<c:forEach var="p" items="${photoList}">
						<img src="${ctx}/uploads/workshop/${p.workshopImagePath}"
							alt="워크샵 상세 이미지">
					</c:forEach>

				</div>
			</div>
		</div>
	</main>

</body>
</html>
