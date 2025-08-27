<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<%-- Original CSS files are kept in case they contain other necessary styles --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/myEvent.css" type="text/css"> 
</head>
<body>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<main class="main-container container-fluid mt-4">
  <div class="row">
    <div class="col-md-2">
      <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
    <div class="col-md-10">
	  <div class="contentsArea p-3">
	  	<h3 class="pb-3 mb-4 fw-bold border-bottom">이벤트 참여 현황</h3>
	  
		  <div class="card shadow-sm mb-5">
			  <div class="card-header bg-light p-3">
				<h5 class="mb-0 fw-semibold">이번 주 출석체크</h5>
			  </div>
			  <div class="card-body p-4">
				<table class="table table-bordered text-center attendance-calendar">
					<thead class="table-light">
						<tr>
							<th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:forEach var="i" begin="0" end="6">
								<c:set var="isAttended" value="false" />
								<c:set var="currentDay" value="${i + 1}" /> 
								<c:forEach var="attendedDay" items="${attendanceDays}">
									<c:if test="${attendedDay == currentDay}">
										<c:set var="isAttended" value="true" />
									</c:if>
								</c:forEach>
								
								<td class="align-middle p-3 ${isAttended ? 'attended' : ''}"> 
									<div class="date-text">${weekDate[i]}</div>
									<div class="attendance-mark">
										<c:if test="${isAttended}">
											<span><i class="bi bi-check-circle"></i></span>
										</c:if>
										<c:if test="${!isAttended}">
											<span class="text-light-emphasis">-</span>
										</c:if>
									</div>
								</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
			  </div>
		  </div>
		  
		  <div class="card shadow-sm">
			<div class="card-header bg-light p-3">
				<h5 class="mb-0 fw-semibold">오늘의 퀴즈: ${todayQuizSubject}</h5>
			</div>
			<div class="card-body p-4">
				<c:choose>
					<c:when test="${!isSolved}">
						<div class="quiz-prompt">
							<div class="quiz-prompt-text">
								<p class="fs-5 fw-bold">아직 오늘의 퀴즈에 참여하지 않았습니다.</p>
								<p class="text-muted">포인트 획득의 기회를 놓치지 마세요!</p>
							</div>
							<a href="${pageContext.request.contextPath}/event/quiz" class="btn-quiz">퀴즈 풀러가기 <i class="bi bi-arrow-right-short"></i></a>
						</div>
					</c:when>
					<c:when test="${isSolved && isCorrect}">
						<div class="alert alert-success d-flex align-items-center gap-3 p-3 fs-5">
							<i class="bi bi-check-circle-fill fs-4"></i>
							<div>
								<strong class="d-block">정답입니다!</strong> 100 포인트가 적립되었습니다.
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger d-flex align-items-center gap-3 p-3 fs-5"> 
							<i class="bi bi-x-circle-fill fs-4"></i>
							<div>
								<strong class="d-block">아쉽지만 오답입니다.</strong> 내일 다시 도전해주세요! 😥
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	  </div>
    </div>
  </div>
</main>

<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>