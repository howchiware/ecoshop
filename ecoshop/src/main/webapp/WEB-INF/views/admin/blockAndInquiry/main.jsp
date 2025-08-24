<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/cssBlockAndInquiry/blockAndInquiry.css">
</head>
<body>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="right-panel">
			<div class="title">
				<h3>1:1 문의 | 신고 관리</h3>
			</div>

			<hr>

			<div class="row" data-aos="fade-up" data-aos-delay="100">
				<div class="col-12 mb-4">
					<div class="dashboard-card stats-card">
						<div class="card-header">
							<h3 class="card-title">업무 현황</h3>
						</div>
						<div class="card-body">
							<div class="stat-item">
								<h4>1:1 문의 답변 처리율</h4>
								<p class="stat-value">${rate}%</p>
							</div>
							<div class="stat-item">
								<h4>신규 신고 접수</h4>
								<p class="stat-value">${empty weeklyStats.newReportCount ? 0 : weeklyStats.newReportCount}
									건</p>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row" data-aos="fade-up" data-aos-delay="200">
				<div class="col-lg-6 mb-4">
					<div class="dashboard-card">
						<div class="card-header">
							<h3 class="card-title">답변 대기 중인 1:1 문의</h3>
						</div>
						<div class="card-body">
							<p class="kpi-metric">${empty waitInquiry ? 0 : waitInquiry}<small>건</small>
							</p>
							<ul class="item-list">
								<c:forEach var="dto" items="${recentInquiries}" begin="0"
									end="4">
									<li><span class="item-title">${dto.subject}</span> <span
										class="item-date">${dto.regDate}</span></li>
								</c:forEach>
							</ul>
						</div>
						<div class="card-footer">
							<a href="${pageContext.request.contextPath}/admin/inquiry/main">문의
								처리 바로가기 &rarr;</a>
						</div>
					</div>
				</div>

				<div class="col-lg-6 mb-4">
					<div class="dashboard-card">
						<div class="card-header">
							<h3 class="card-title">처리 대기 중인 신고</h3>
						</div>
						<div class="card-body">
							<p class="kpi-metric">${empty pendingReportCount ? 0 : pendingReportCount}<small>건</small>
							</p>
							<ul class="item-list">
								<c:forEach var="dto" items="${recentReports}" begin="0" end="4">
									<li><span class="item-title">${dto.reportTypeName}</span>
										<span class="item-date">${dto.regDate}</span></li>
								</c:forEach>
							</ul>
						</div>
						<div class="card-footer">
							<a href="${pageContext.request.contextPath}/admin/reportsManage/main">신고
								처리 바로가기 &rarr;</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsBlockAndInquiry/blockAndInquiry.js"></script>

</body>
</html>