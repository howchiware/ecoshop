<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>챌린지 톡 - 인증글</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyList.css" type="text/css">


<style>
.article-title {
	font-weight: 700;
	font-size: 1.35rem;
}

.photo-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
	gap: 14px;
}

.photo-grid img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	border-radius: 10px;
}

.content-box {
	white-space: pre-wrap;
	line-height: 1.7;
}

.meta small {
	color: #6c757d;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container my-5">
		<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp" />

		<div class="card shadow-sm">
			<div class="card-body">
				<div class="d-flex justify-content-between align-items-center mb-2">
					<div class="meta">
						<small class="me-3"><i class="bi bi-person"></i>
							${post.memberName}</small> <small class="me-3"><i
							class="bi bi-calendar"></i> ${post.postRegDate}</small> <small
							class="badge bg-primary-subtle text-primary-emphasis">스페셜
							${post.dayNumber}일차</small>
					</div>

					<c:choose>
						<c:when test="${src == 'bundles'}">
							<!-- 번들 메인으로 -->
							<a class="btn btn-outline-secondary btn-sm"
								href="${pageContext.request.contextPath}/free/challengeBundles">목록</a>
						</c:when>
						<c:otherwise>
							<!-- 기존 리스트로 (기존 파라미터 유지) -->
							<a class="btn btn-outline-secondary btn-sm"
								href="<c:url value='/free/challengeList'>
                 <c:if test='${not empty page}'><c:param name='page' value='${page}'/></c:if>
                 <c:if test='${not empty size}'><c:param name='size' value='${size}'/></c:if>
                 <c:if test='${not empty kwd}' ><c:param name='kwd'  value='${kwd}' /></c:if>
               </c:url>">목록</a>
						</c:otherwise>
					</c:choose>
				</div>


				<h2 class="article-title mb-3">${post.title}</h2>

				<c:if test="${not empty photos}">
					<div class="photo-grid mb-4">
						<c:forEach var="p" items="${photos}">
							<img src="${pageContext.request.contextPath}/uploads/challenge/${p}" alt="인증 사진">
						</c:forEach>
					</div>
				</c:if>

				<div class="content-box">${post.content}</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
