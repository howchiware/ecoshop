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
.attendance-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background-color: #4caf50;
  box-shadow: 0 0 12px #388e3c;
  
  display: flex;
  justify-content: center;
  align-items: center;     
  cursor: default;
}

.attendance-icon i.bi-patch-check {
  font-size: 20px;
  color: white;
  line-height: 1;
}

.attendance-calendar {
	width: 100%;
	max-width: 700px;
	margin: 80px auto 80px auto; 
	border-collapse: separate;
	border-spacing: 10px; 
	background-color: #fff;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
	font-family: 'Noto Sans KR', sans-serif;
}

.attendance-calendar th {
    width: 80px;
    height: 80px;
    text-align: center;
    vertical-align: middle;
    font-size: 1.4rem;
    background-color: #dff0d8;
    border-radius: 12px;
    padding: 0;
    font-weight: 700;
    color: #3a662e;
    user-select: none;
}

.day-name {
	font-size: 1.6rem;
	font-weight: 800;
	margin-bottom: 4px;
}

.date-number {
	font-size: 1rem;
	color: #4b7c4b;
}

.attendance-calendar td {
	background-color: #f0f8f0;
	border-radius: 12px;
	height: 80px;
	vertical-align: middle;
	cursor: default;
	position: relative;
}

.attendance-icon {
	width: 32px;
	height: 32px;
	margin: 0 auto;
	border-radius: 50%;
	background-color: #a2d5a2;
	box-shadow: inset 0 0 8px #6db06d;
	transition: background-color 0.3s ease;
}

.attended .attendance-icon {
	background-color: #4caf50;
	box-shadow: 0 0 12px #388e3c;
}

.button-wrap {
    max-width: 600px;
    margin: 30px auto 40px auto; 
    text-align: center;
}

.attendance-btn {
    font-weight: 600;
    font-size: 1rem;           
    padding: 10px 32px;        
    background-color: #28a745;
    color: #fff;             
    border: none;
    border-radius: 24px;      
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.5);
    transition: background-color 0.3s ease, box-shadow 0.3s ease, transform 0.2s ease;
    cursor: pointer;
}

.attendance-btn:hover {
    background-color: #218838; /* 조금 더 진한 초록색 */
    box-shadow: 0 6px 20px rgba(33, 136, 56, 0.7);
    transform: translateY(-2px);
}

.attendance-header {
  max-width: 600px;
  margin: 40px auto 20px auto;
  text-align: center;
  font-family: 'Noto Sans KR', sans-serif;
}

.attendance-header h1 {
  font-size: 2.2rem;
  color: #3a662e;
  font-weight: 800;
  margin-bottom: 10px;
}

.attendance-header p {
  font-size: 1.1rem;
  color: #4b7c4b;
  font-weight: 600;
}


footer {
	text-align: center;
	padding: 30px 0;
	font-size: 0.9rem;
	color: #666;
	background-color: transparent;
	margin-top: 60px;
	user-select: none;
}
</style>



</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<section class="attendance-header">
		  <h1>출석 체크</h1>
		  <p>한 주 동안 출석체크를 5일만 완료하면 500포인트를 드려요!</p>
		  <p>🌟 열심히 출석해서 포인트 받아가세요! 😊</p>
		</section>
		
		<form name="attendanceForm" method="post" action="${pageContext.request.contextPath}/event/attendance/check">
			<table class="attendance-calendar">
				<thead>
					<tr>
						<c:forEach var="dateStr" items="${weekDate}" varStatus="status">
							<th><c:set var="dayNames" value="${fn:split('월,화,수,목,금,토,일', ',')}" />
								<div class="day-name">${dayNames[status.index]}</div>
								<div class="date-number">${weekDate[status.index]}</div></th>
						</c:forEach>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="dateStr" items="${weekDate}" varStatus="status">
						    <c:set var="dayNum" value="${status.index + 1}" />
						    <td>
						        <c:choose>
						            <c:when test="${fn:contains(attendanceDays, dayNum)}">
						                <div class="attendance-icon attended">
						                    <i class="bi bi-patch-check"></i>
						                </div>
						            </c:when>
						            <c:otherwise>
						                <div class="attendance-icon"></div>
						            </c:otherwise>
						        </c:choose>
						    </td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
		<div class="button-wrap">
			<button class="btn btn-primary attendance-btn" onclick="attendanceOk(event);">출석체크</button>
		</div>
	</form>

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
		      alert(data.success ? '출석 체크 완료!' : '😁 ' + data.message);
		      if (data.success) window.location.reload();
		    })
		    .catch(() => alert('오류가 발생했습니다.'));
		}


	</script>
</body>
</html>
