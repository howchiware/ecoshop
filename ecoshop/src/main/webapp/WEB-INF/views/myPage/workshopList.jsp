<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ECOMORE - 내 워크샵</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/home.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/mypage.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/paginate.css"
	type="text/css">

<style>
:root {
	--ink: #222;
	--muted: #666;
	--line: #e9e9e9;
	--card: #fff;
	--soft: #f7f7f8;
}

.main-wrap {
	background: var(--card);
}

.tabs {
	display: flex;
	gap: 8px;
	margin: 8px 0 16px;
}

.tabs a {
	display: inline-block;
	padding: 8px 14px;
	border: 1px solid var(--line);
	border-radius: 999px;
	background: #fafafa;
	color: #222;
	text-decoration: none;
	font-weight: 600;
	font-size: 14px;
}

.tabs a.on {
	background: #111;
	color: #fff;
	border-color: #111;
}

.filter {
	display: flex;
	gap: 10px;
	align-items: center;
	padding: 10px 12px;
	border: 1px dashed var(--line);
	border-radius: 10px;
	background: #fcfcfc;
	margin-bottom: 12px;
}

.filter .form-check {
	margin: 0;
}

.summary {
	color: var(--muted);
	font-size: 14px;
	margin-bottom: 8px;
}

.ws-list {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.ws-item {
	display: flex;
	gap: 14px;
	align-items: center;
	padding: 14px;
	border: 1px solid var(--line);
	border-radius: 12px;
	background: #fff;
}

.ws-thumb {
	width: 72px;
	height: 72px;
	border-radius: 10px;
	object-fit: cover;
	background: #f2f2f2;
	border: 1px solid var(--line);
}

.ws-body {
	flex: 1;
	min-width: 0;
}

.ws-title {
	font-weight: 700;
	font-size: 16px;
	line-height: 1.2;
	margin-bottom: 10px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.ws-title a {
	color: #111;
	text-decoration: none;
}

.ws-title a:hover {
	text-decoration: underline;
}

.ws-meta {
	color: var(--muted);
	font-size: 13px;
	display: flex;
	gap: 14px;
	flex-wrap: wrap;
}

.ws-right {
	text-align: right;
	min-width: 92px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 8px;
	padding-right: 12px;
}

.state {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 999px;
	font-weight: 700;
	font-size: 12px;
	background: #fafafa
}

.state-applied {
	background: #fafafa;
	color: #000;
}

.state-attended {
	background: #000;
	color: #eee;
}

.state-confirm {
	background: #111;
	color: #fff;
}

.state-wait {
	background: #fafafa;
	color: #000;
}

.state-cancel {
	background: #e9ecef;
	color: #666;
}

.empty {
	text-align: center;
	color: var(--muted);
	padding: 64px 8px;
}

.pagination .page-link {
	border: none;
	background: #f3f4f6;
	color: #333;
	margin: 0 2px;
	border-radius: 8px;
}

.pagination .page-item.active .page-link {
	background: #111;
	color: #fff;
}

.ws-meta {
	gap: 6px 5px;
} /* row/column 간격 */
.ws-meta .meta-item {
	display: inline-flex;
	align-items: center;
	padding-right: 10px;
	margin-right: 6px;
	position: relative;
}

.ws-meta .meta-item:not(:last-child)::after {
	content: "";
	width: 1px;
	height: 12px;
	background: #e5e7eb;
	position: absolute;
	right: 0;
	top: 50%;
	transform: translateY(-50%);
}

.state-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 6px 10px; /* .state와 동일한 패딩 */
	border-radius: 999px; /* pill */
	font-size: 12px;
	font-weight: 700; /* .state와 동일 굵기/크기 */
	color: #111;
	background: #fff; /* 모노톤 */
	border: 1px solid #111;
	line-height: 1;
	cursor: pointer;
}

.state-btn:hover {
	background: #111;
	color: #fff;
}

.ws-right form {
	display: inline;
	margin: 0;
}

.status-inline {
	margin-left: 6px;
	font-size: 12px;
	color: var(--muted);
	font-weight: 600;
}

.meta-item {
	padding-bottom: 0.5rem;
}

@media ( max-width : 480px) {
	.ws-meta .meta-item {
		padding-right: 0;
		margin-right: 0;
	}
	.ws-meta .meta-item:not(:last-child)::after {
		display: none;
	}
}
</style>

<c:if test="${mode=='applied'}">
	<style>
.ws-right .state {
	display: none !important;
}
</style>
</c:if>

</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<main class="main-container">
		<c:set var="ctx" value="${pageContext.request.contextPath}" />
		<div class="row">
			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
			</div>

			<div class="col-md-10">
				<div class="contentsArea">

					<div class="main-wrap">
						<h3 class="pb-2 mb-4 border-bottom section-title">나의 워크샵</h3>
						<div class="tabs">
							<a
								href="${ctx}/workshop/mypage?mode=applied&page=1&size=${size}&onlyFuture=${onlyFuture}"
								class="${mode=='applied' ? 'on' : ''}">신청 내역</a> <a
								href="${ctx}/workshop/mypage?mode=attended&page=1&size=${size}"
								class="${mode=='attended' ? 'on' : ''}">참석 내역</a>
						</div>

						<div class="summary">
							총 <strong>${total}</strong>건
							<c:if test="${mode=='applied'}"> · 현재 신청한 워크샵</c:if>
							<c:if test="${mode=='attended'}"> · 참석 완료된 워크샵</c:if>
						</div>

						<c:choose>
							<c:when test="${empty list}">
								<div class="empty">
									<div>표시할 내역이 없습니다.</div>
									<div>새로운 워크샵을 신청해 보세요.</div>
								</div>
							</c:when>

							<c:otherwise>
								<div class="ws-list">
									<c:forEach var="row" items="${list}" varStatus="st">
										<div class="ws-item">
											<c:choose>
												<c:when test="${not empty row.thumbnailPath}">
													<img class="ws-thumb" src="${ctx}${row.thumbnailPath}"
														alt="워크샵 썸네일">
												</c:when>
												<c:otherwise>
													<div class="ws-thumb d-inline-block"></div>
												</c:otherwise>
											</c:choose>

											<div class="ws-body">
												<div
													class="ws-meta d-flex flex-wrap align-items-center small text-muted">
													<span class="meta-item"> 신청일 <fmt:formatDate
															value="${row.appliedDate}" pattern="yyyy-MM-dd HH:mm" />
														<c:if test="${mode=='applied'}">
															<span class="status-inline"> <c:choose>
																	<c:when test="${row.isAttended == 'Y'}"> · 참석</c:when>
																	<c:when
																		test="${row.participantStatus == 1 or row.participantStatus eq '1'}"> · 확정</c:when>
																	<c:when
																		test="${row.participantStatus == 2 or row.participantStatus eq '2'}"> · 대기</c:when>
																	<c:when
																		test="${row.participantStatus == 0 or row.participantStatus eq '0'}"> · 신청</c:when>
																	<c:otherwise> · 취소됨</c:otherwise>
																</c:choose>
															</span>
														</c:if>
													</span>
												</div>


												<div class="ws-title">
													<a
														href="${pageContext.request.contextPath}/workshop/detail?workshopId=${row.workshopId}">${row.workshopTitle}</a>
												</div>
												<div
													class="ws-meta d-flex flex-wrap align-items-center small text-muted">
													<span class="meta-item"> <fmt:formatDate
															value="${row.scheduleDate}" pattern="yyyy-MM-dd" />
													</span>

													<c:if test="${not empty row.categoryName}">
														<span class="meta-item">${row.categoryName}</span>
													</c:if>

													<c:if test="${not empty row.location}">
														<span class="meta-item">${row.location} </span>
													</c:if>
												</div>
											</div>

											<div class="ws-right">
												<c:choose>
													<c:when test="${row.isAttended == 'Y'}">
														<span class="state state-attended">참석</span>
													</c:when>

													<c:when
														test="${row.participantStatus == 1 or row.participantStatus eq '1'}">
														<form action="${ctx}/workshop/apply/cancel" method="post"
															onsubmit="return confirm('정말 신청을 취소하시겠습니까?');">
															<input type="hidden" name="workshopId"
																value="${row.workshopId}" />
															<button type="submit" class="state-btn">신청 취소</button>

														</form>
													</c:when>


													<c:when
														test="${row.participantStatus == 2 or row.participantStatus eq '2'}">
														<span class="state state-wait">대기</span>
														<form action="${ctx}/workshop/apply/cancel" method="post"
															onsubmit="return confirm('정말 신청을 취소하시겠습니까?');"
															style="display: inline">
															<input type="hidden" name="workshopId"
																value="${row.workshopId}" />
															<button type="submit" class="state-btn">신청 취소</button>
														</form>
													</c:when>


													<c:otherwise>
														<span class="state state-cancel">취소</span>
													</c:otherwise>
												</c:choose>
											</div>

										</div>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>

						<div class="mt-3">
							<c:set var="totalPages" value="${(total + size - 1) / size}" />
							<c:if test="${totalPages > 1}">
								<nav>
									<ul class="pagination justify-content-center">
										<c:forEach begin="1" end="${totalPages}" var="p">
											<li class="page-item ${p==page ? 'active':''}"><a
												class="page-link"
												href="${ctx}/workshop/mypage?mode=${mode}&page=${p}&size=${size}&onlyFuture=${onlyFuture}">${p}</a>
											</li>
										</c:forEach>
									</ul>
								</nav>
							</c:if>
						</div>

					</div>
				</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<script
		src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>
