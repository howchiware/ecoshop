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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">
<style>
.table {
	background: #fff;
}

.table thead th {
	background: #f8f9fa;
	font-weight: 500;
	text-align: center;
}

.table td {
	vertical-align: middle;
	background: #fff;
}

.table .btn {
	margin: 0 2px;
}

.text-muted {
	font-size: 13px;
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
				<h3 class="m-0">포인트 지급</h3>
				<div class="text-muted">
					* 후기 작성 시 <strong> <fmt:formatNumber
							value="${empty pointPolicy ? 1000 : pointPolicy}" pattern="#,##0" />
					</strong> <span class="point-text">P 지급</span>
				</div>
			</div>

			<hr>

			<c:if test="${not empty sessionScope.msg}">
				<div class="alert alert-dark py-2">${sessionScope.msg}</div>
				<c:remove var="msg" scope="session" />
			</c:if>

			<div class="outside">
				<div class="table-responsive">
					<table class="table table-sm align-middle">
						<thead>
							<tr>
								<th style="width: 5%;" class="text-center">번호</th>
								<th style="width: 10%;" class="text-center">참여자명</th>
								<th style="width: 40%;">워크샵명</th>
								<th style="width: 10%;" class="text-center">포인트</th>
								<th style="width: 10%;" class="text-center">상태</th>
								<th style="width: 10%;" class="text-center">지급</th>
							</tr>

						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty rows}">
									<tr>
										<td colspan="6" class="text-center text-muted py-4">표시할
											데이터가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="r" items="${rows}" varStatus="st">
										<tr>
											<td class="text-center">${(page - 1) * size + st.index + 1}</td>
											<td class="text-center"><c:out value="${r.memberName}" /></td>
											<td class="text-center"><c:out
													value="${r.workshopTitle}" /></td>
											<td class="text-center"><fmt:formatNumber
													value="${empty pointPolicy ? 1000 : pointPolicy}"
													pattern="#,##0" />P</td>
											<td class="text-center"><span
												class="${r.paid == 1 ? 'badge-done' : 'badge-pending'}">
													${r.paid == 1 ? '지급 완료' : '미지급'} </span></td>
											<td class="text-center"><c:choose>
													<c:when test="${r.paid == 1}">
														<button class="btn-submit" disabled>완료</button>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${empty r.workshopReviewId}">
																<button class="btn-manage" disabled>지급</button>
															</c:when>
															<c:otherwise>
																<form method="post"
																	action="${ctx}/admin/workshop/points/pay"
																	class="d-inline"
																	onsubmit="return confirm('포인트를 지급하시겠습니까?');">
																	<input type="hidden" name="workshopReviewId"
																		value="${r.workshopReviewId}" /> <input type="hidden"
																		name="participantId" value="${r.participantId}" /> <input
																		type="hidden" name="memberId" value="${r.memberId}" />
																	<input type="hidden" name="workshopId"
																		value="${r.workshopId}" /> <input type="hidden"
																		name="points"
																		value="${empty pointPolicy ? 1000 : pointPolicy}" />
																	<input type="hidden" name="postId"
																		value="${r.workshopReviewId}" />
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

			<c:if test="${total > 0}">
				<div class="page-navigation">
					<c:out value="${paging}" escapeXml="false" />
				</div>
			</c:if>

		</div>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
