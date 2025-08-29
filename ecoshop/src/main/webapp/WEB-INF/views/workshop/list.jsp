<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>워크샵</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/home.css"
	type="text/css">
<jsp:useBean id="now" class="java.util.Date" />

<style>
.workshop-card {
	border: 1px solid #e9ecef;
	border-radius: 16px;
	overflow: hidden;
	transition: transform .12s ease, box-shadow .12s ease;
	height: 100%;
}

.workshop-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(0, 0, 0, .08);
}

.workshop-thumb {
	display: block;
	width: 100%;
	aspect-ratio: 4/3;
	object-fit: cover;
	background: #f2f2f2;
}

.workshop-title {
	font-weight: 700;
	font-size: 1rem;
	line-height: 1.4;
	margin-bottom: .25rem;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.workshop-desc {
	color: #6c757d;
	font-size: .9rem;
	min-height: 40px;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.badge-status {
	font-weight: 600;
	letter-spacing: -.2px;
}

.form-check .form-check-input {
	cursor: pointer;
}

.form-select {
	width: 11rem;
}

label[for="onlyRecruiting"] {
	
}

.form-select {
	margin-right: 4px;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<header class="border-bottom">
		<div class="container py-3">
			<h4 class="m-0" style="font-size: 22px;">워크샵</h4>
		</div>
	</header>

	<main class="container py-4">
		<c:url var="defaultImg" value="/dist/images/noimage.png" />

		<c:url var="listAction" value="/workshop/list" />
		<form id="filterForm" class="row g-2 align-items-end mb-4"
			method="get" action="${listAction}">

			<div class="col-sm-2 col-md-2">
				<!-- <label class="form-label">카테고리</label> -->
				<div class="d-flex">
					<select class="form-select me-2" name="categoryId">
						<option value="">전체</option>
						<c:forEach var="cvo" items="${category}">
							<option value="${cvo.categoryId}"
								<c:if test="${categoryId == cvo.categoryId}">selected</c:if>>
								<c:out value="${cvo.categoryName}" />
							</option>
						</c:forEach>
					</select> <select class="form-select" name="sort">
						<option value="latest"
							<c:if test="${sort=='latest'}">selected</c:if>>최신순</option>
						<option value="deadline"
							<c:if test="${sort=='deadline'}">selected</c:if>>마감 임박순</option>
					</select>
				</div>

			</div>

			<div class="col-auto ms-auto mt-4">
				<input class="form-check-input" type="checkbox" id="onlyRecruiting"
					name="onlyRecruiting" value="true"
					<c:if test="${onlyRecruiting}">checked</c:if>> <label
					class="form-check-label" for="onlyRecruiting">모집 중만 보기</label>
			</div>
		</form>

		<!-- 결과 수 -->
		<div class="d-flex justify-content-between align-items-center mb-3">
			<div class="text-muted">
				총 <strong>${dataCount}</strong>개
			</div>
		</div>

		<!-- 카드 그리드 -->
		<c:choose>
			<c:when test="${empty list}">
				<div class="text-center text-muted py-5">표시할 워크샵이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<div class="row g-4">
					<c:forEach var="w" items="${list}">
						<div class="col-12 col-sm-6 col-lg-4">

							<c:url var="detailUrl" value="/workshop/detail">
								<c:param name="workshopId" value="${w.workshopId}" />
							</c:url>

							<c:set var="raw" value="${w.thumbnailPath}" />
							<c:choose>
								<c:when test="${empty raw}">
									<c:set var="thumbUrl" value="${defaultImg}" />
								</c:when>
								<c:when
									test="${fn:startsWith(raw, 'http://') or fn:startsWith(raw, 'https://') or fn:startsWith(raw, '/')}">
									<c:set var="thumbUrl" value="${raw}" />
								</c:when>
								<c:otherwise>
									<c:url var="thumbUrl" value="/uploads/workshop/${raw}" />
								</c:otherwise>
							</c:choose>

							<a href="${detailUrl}" class="text-decoration-none text-reset">
								<div class="workshop-card">
									<!-- 썸네일 -->
									<img class="workshop-thumb" src="${thumbUrl}"
										alt="<c:out value='${w.workshopTitle}'/>" loading="lazy"
										decoding="async"
										onerror="if (this.src.indexOf('noimage.png') === -1) this.src='${defaultImg}'">

									<div class="p-3">
										<c:choose>
											<c:when
												test="${w.workshopStatus == 1 and not empty w.applyDeadline and w.applyDeadline.time lt now.time}">
												<span
													class="badge bg-secondary-subtle text-secondary badge-status me-1">마감</span>
											</c:when>

											<c:when test="${w.workshopStatus == 1}">
												<span
													class="badge bg-success-subtle text-success badge-status me-1">모집
													중</span>
											</c:when>
											<c:when test="${w.workshopStatus == 0}">
												<span
													class="badge bg-secondary-subtle text-secondary badge-status me-1">마감</span>
											</c:when>
											<c:when test="${w.workshopStatus == 2}">
												<span
													class="badge bg-danger-subtle text-danger badge-status me-1">취소</span>
											</c:when>
										</c:choose>


										<c:if test="${not empty w.categoryName}">
											<span class="badge bg-light text-dark border"><c:out
													value="${w.categoryName}" /></span>
										</c:if>

										<div class="workshop-title mt-2">
											<c:out value="${w.workshopTitle}" />
										</div>
										<div class="workshop-desc">
											<c:out value="${w.workshopContent}" />
										</div>

										<div class="mt-2 small text-muted">
											<span class="me-2"> 일정 | <c:choose>
													<c:when test="${not empty w.scheduleDate}">
														<fmt:formatDate value="${w.scheduleDate}"
															pattern="yyyy.MM.dd" />
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</span> <span class="me-2">정원 | <c:out value="${w.capacity}" /></span>
											<c:if test="${not empty w.applyDeadline}">
												<span>마감 | <fmt:formatDate value="${w.applyDeadline}"
														pattern="MM.dd" />
												</span>
											</c:if>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>

		<c:if test="${totalPage > 1}">
			<nav class="mt-4" aria-label="pagination">
				<ul class="pagination justify-content-center">

					<c:url var="prevUrl" value="/workshop/list">
						<c:param name="page" value="${page-1}" />
						<c:if test="${not empty categoryId}">
							<c:param name="categoryId" value="${categoryId}" />
						</c:if>
						<c:if test="${not empty sort}">
							<c:param name="sort" value="${sort}" />
						</c:if>
						<c:if test="${onlyRecruiting}">
							<c:param name="onlyRecruiting" value="true" />
						</c:if>
					</c:url>
					<li class="page-item <c:if test='${page <= 1}'>disabled</c:if>">
						<c:choose>
							<c:when test="${page <= 1}">
								<span class="page-link" aria-disabled="true">이전</span>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="${prevUrl}">이전</a>
							</c:otherwise>
						</c:choose>
					</li>

					<li class="page-item active" aria-current="page"><span
						class="page-link">${page}</span></li>

					<c:url var="nextUrl" value="/workshop/list">
						<c:param name="page" value="${page+1}" />
						<c:if test="${not empty categoryId}">
							<c:param name="categoryId" value="${categoryId}" />
						</c:if>
						<c:if test="${not empty sort}">
							<c:param name="sort" value="${sort}" />
						</c:if>
						<c:if test="${onlyRecruiting}">
							<c:param name="onlyRecruiting" value="true" />
						</c:if>
					</c:url>
					<li
						class="page-item <c:if test='${page >= totalPage}'>disabled</c:if>">
						<c:choose>
							<c:when test="${page >= totalPage}">
								<span class="page-link" aria-disabled="true">다음</span>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="${nextUrl}">다음</a>
							</c:otherwise>
						</c:choose>
					</li>

				</ul>
			</nav>
		</c:if>

	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script>
		(function() {
			var form = document.getElementById('filterForm');
			
			const autoSubmit = () => form.requestSubmit();
		      document.querySelector('select[name="categoryId"]')?.addEventListener('change', autoSubmit);
		      document.querySelector('select[name="sort"]')?.addEventListener('change', autoSubmit);
		      document.getElementById('onlyRecruiting')?.addEventListener('change', autoSubmit);


			if (!form) return;
			
			form.addEventListener('submit', function () {
		        var cb = document.getElementById('onlyRecruiting');
		        var hidden = document.getElementById('onlyRecruitingHidden');
		        if (cb && hidden) hidden.disabled = cb.checked;
			});
		})();
	</script>

</body>
</html>
