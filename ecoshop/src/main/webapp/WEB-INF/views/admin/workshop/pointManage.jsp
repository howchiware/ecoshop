<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>포인트 지급 내역</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background: #f7f6f3;
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
	font-size: 15px;
}

.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

.table {
	background: #fff;
	border: 1px solid #dee2e6;
}

.table thead th {
	background: #f8f9fa;
	font-weight: 500;
	text-align: center;
	border: 1px solid #dee2e6;
}

.table td {
	vertical-align: middle;
	border: 1px solid #dee2e6;
	background: #fff;
}

.table .btn {
	margin: 0 2px;
}

.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background .2s, color .2s;
	cursor: pointer;
	height: 30px;
	min-width: 51px;
}

.badge-done {
	background: #e8f5e9;
	color: #1b5e20;
	padding: 4px 8px;
	border-radius: 999px;
	font-size: 12px;
}

.badge-pending {
	background: #fff7ed;
	color: #b45309;
	padding: 4px 8px;
	border-radius: 999px;
	font-size: 12px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<div class="container py-4">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<h3 class="m-0">포인트 지급 내역</h3>
				<div class="text-muted">
					* 후기 작성 시 <strong><fmt:formatNumber
							value="${empty pointPolicy ? 1000 : pointPolicy}" pattern="#,##0" /></strong>P
					지급
				</div>
			</div>

			<c:if test="${not empty sessionScope.msg}">
				<div class="alert alert-dark py-2">${sessionScope.msg}</div>
				<c:remove var="msg" scope="session" />
			</c:if>

			<div class="outside">
				<div class="table-responsive">
					<table class="table table-sm align-middle">
						<thead>
							<tr>
								<th style="width: 140px;" class="text-center">참여자명</th>
								<th>워크샵명</th>
								<th style="width: 90px;" class="text-center">포인트</th>
								<th style="width: 100px;" class="text-center">상태</th>
								<th style="width: 120px;" class="text-center">지급</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty rows}">
									<tr>
										<td colspan="5" class="text-center text-muted py-4">표시할
											데이터가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="r" items="${rows}">
										<tr>
											<td class="text-center"><c:out value="${r.memberName}" /></td>
											<td class="text-start"><c:out value="${r.workshopTitle}" /></td>
											<td class="text-center"><fmt:formatNumber
													value="${empty pointPolicy ? 1000 : pointPolicy}"
													pattern="#,##0" />P</td>
											<td class="text-center"><span
												class="${r.paid == 1 ? 'badge-done' : 'badge-pending'}">
													${r.paid == 1 ? '지급 완료' : '미지급'} </span></td>
											<td class="text-center"><c:choose>
													<c:when test="${r.paid == 1}">
														<button class="btn-manage" disabled>완료</button>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${empty r.workshopReviewId}">
																<button class="btn-manage" disabled>지급</button>
															</c:when>
															<c:otherwise>
																<form method="post"
																	action="${ctx}/admin/workshop/points/pay"
																	class="d-inline">
																	<input type="hidden" name="workshopReviewId"
																		value="${r.workshopReviewId}" /> <input type="hidden"
																		name="participantId" value="${r.participantId}" /> <input
																		type="hidden" name="memberId" value="${r.memberId}" />
																	<input type="hidden" name="workshopId"
																		value="${r.workshopId}" /> <input type="hidden"
																		name="points"
																		value="${empty pointPolicy ? 1000 : pointPolicy}" />
																	<c:if test="${not empty _csrf}">
																		<input type="hidden" name="${_csrf.parameterName}"
																			value="${_csrf.token}" />
																	</c:if>
																	<button type="submit" class="btn-manage">지급</button>
																</form>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<nav aria-label="페이지네이션">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
