<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssEvent/attendance.css" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<section class="attendance-header">
		  <h1>출석 체크 이벤트</h1>
		  <p>매일 출석하고 500 포인트를 받아가세요!</p>
		</section>
		
		<div class="attendance-card">
			<div class="progress-container">
				<c:set var="attendanceCount" value="${fn:length(attendanceDays)}" />
				<c:set var="progressPercent" value="${(attendanceCount / 5) * 100}" />
				<div class="progress-label">
					<span>출석 진행률</span>
					<span>${attendanceCount}일 / 5일</span>
				</div>
				<div class="progress" role="progressbar" aria-valuenow="${progressPercent}" aria-valuemin="0" aria-valuemax="100">
					<div class="progress-bar" style="width: ${progressPercent}%"></div>
				</div>
			</div>
			
			<table class="attendance-calendar">
				<thead>
					<tr>
						<th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="dateStr" items="${weekDate}" varStatus="status">
							<c:set var="dayNum" value="${status.index + 1}" />
							<td>
								${dateStr}
								<c:if test="${fn:contains(attendanceDays, dayNum)}">
									<div class="attended">
										<div class="attendance-icon">
											<i class="bi bi-check-lg"></i>
										</div>
									</div>
								</c:if>
							</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>

			<div class="button-wrap">
				<c:choose>
					<c:when test="${isAttendedToday}">
						<button class="attendance-btn" disabled>출석 완료</button>
					</c:when>
					<c:otherwise>
						<button class="attendance-btn" onclick="attendanceOk(event);">출석체크</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
const CONTEXT_PATH = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/dist/jsEvent/attendance.js"></script>

</body>
</html>