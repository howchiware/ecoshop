<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
/* --- ▼▼▼ 간격이 최종 수정된 디자인 CSS ▼▼▼ --- */
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-style: normal;
}
body {
    background-color: #f4f7f6;
}
* {
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
}

/* --- 헤더 --- */
.attendance-header {
  max-width: 600px;
  margin: 60px auto 40px auto; /* 수정: 상단 여백 증가 */
  text-align: center;
}
.attendance-header h1 {
  font-size: 2.5rem;
  color: #2c3e50;
  font-weight: 800;
  margin-bottom: 1rem; /* 수정: p태그와의 간격 조정 */
}
.attendance-header p {
  font-size: 1.1rem;
  color: #8492a6;
  font-weight: 500;
  line-height: 1.6;
}

/* --- 출석 카드 --- */
.attendance-card {
    max-width: 800px;
    margin: 0 auto 60px auto; /* 수정: 하단 여백 추가 */
    background-color: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
    padding: 40px 50px; /* 수정: 내부 패딩 조정 */
}

/* --- 진행률 바 --- */
.progress-container {
    margin-bottom: 2rem; /* 수정: 캘린더와의 간격 조정 */
}
.progress-label {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
    color: #34495e;
    margin-bottom: 0.75rem; /* 수정 */
    font-size: 0.9rem;
}
.progress {
    height: 12px;
    border-radius: 6px;
}
.progress-bar {
    background-color: #27ae60;
}

/* --- 캘린더 --- */
.attendance-calendar {
	width: 100%;
	border-collapse: separate;
	border-spacing: 10px; 
	text-align: center;
    margin: 1.5rem 0; /* 수정: 상하 여백 추가 */
}
.attendance-calendar th {
    padding: 10px 5px;
    font-weight: 600;
    color: #95a5a6;
    user-select: none;
    font-size: 0.9rem;
}
.attendance-calendar td {
	background-color: #ecf0f1;
	border-radius: 12px;
	height: 90px;
	width: calc(100% / 7);
	vertical-align: top;
	padding-top: 10px;
	position: relative;
    font-weight: 700;
    color: #7f8c8d;
}
/* 토, 일 색상 구분 */
.attendance-calendar th:nth-child(6), .attendance-calendar td:nth-child(6) { color: #3498db; }
.attendance-calendar th:nth-child(7), .attendance-calendar td:nth-child(7) { color: #e74c3c; }

.attendance-icon {
	width: 32px;
	height: 32px;
    position: absolute;
    top: 55%; /* 수정: 아이콘 위치 미세 조정 */
    left: 50%;
    transform: translate(-50%, -50%);
	margin: 0 auto;
	border-radius: 50%;
	background-color: rgba(189, 195, 199, 0.3);
}
.attendance-icon i {
  font-size: 20px;
  color: white;
}
.attended .attendance-icon {
	background-color: #27ae60;
    animation: pop 0.4s ease-out;
}

@keyframes pop {
    0% { transform: translate(-50%, -50%) scale(0.8); }
    70% { transform: translate(-50%, -50%) scale(1.1); }
    100% { transform: translate(-50%, -50%) scale(1); }
}

/* --- 출석 버튼 --- */
.button-wrap {
    text-align: center;
    margin-top: 2rem; /* 수정: 캘린더와의 간격 조정 */
}
.attendance-btn {
    font-weight: 600;
    font-size: 1.1rem;           
    padding: 12px 40px;        
    background-color: #2ecc71;
    color: #fff;             
    border: none;
    border-radius: 30px;      
    box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
    transition: all 0.3s ease;
    cursor: pointer;
}
.attendance-btn:hover {
    background-color: #27ae60;
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.5);
    transform: translateY(-2px);
}
.attendance-btn:disabled {
    background-color: #bdc3c7;
    box-shadow: none;
    cursor: not-allowed;
    transform: none;
}
</style>
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

	<script>
	function attendanceOk(event) {
		  event.preventDefault(); 
		  fetch('${pageContext.request.contextPath}/event/attendance/check', { method: 'POST' })
		    .then(res => res.json())
		    .then(data => {
		      if (data.message === '로그인이 필요합니다.') {
		        window.location.href = '${pageContext.request.contextPath}/member/login';
		        return;
		      }
		      alert(data.success ? '출석 체크 완료! 오늘도 화이팅하세요! 💪' : '😁 ' + data.message);
		      if (data.success) window.location.reload();
		    })
		    .catch(() => alert('오류가 발생했습니다.'));
		}
	</script>
</body>
</html>