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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/myEvent.css" type="text/css">
</head>
<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- 메인 영역 -->
<main class="main-container">
  <div class="row">

    <div class="col-md-2">
      <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
    <div class="col-md-10">
	  <div class="contentsArea">
	  	<h3 class="pb-2 mb-4 border-bottom sub-title">이벤트 참여 현황</h3>
	  
	  
		  <!-- 출석체크 -->
		  <div>
		  <h5>출석체크</h5>
		  	<table class="attendance-calendar">
				<thead>
					<tr>
						<th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="i" begin="0" end="6">
							<td>
								<div class="date-text">${weekDate[i]}</div>
								
								<div>
									<c:set var="isAttended" value="false" />
									<c:set var="currentDay" value="${i + 1}" />
									
									<c:forEach var="attendedDay" items="${attendanceDays}">
										<c:if test="${attendedDay == currentDay}">
											<c:set var="isAttended" value="true" />
										</c:if>
									</c:forEach>
									
									<c:if test="${isAttended}">
										😆
									</c:if>
								</div>
							</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
			<div>
				<a href="${pageContext.request.contextPath}/member/myEventAttendance">자세히 보기</a>
			</div>
		  </div>
		  
		  
	  
		  <!-- 퀴즈 -->
		  <div class="mt-5">
		    <h5 class="pb-2 mb-3">오늘의 퀴즈</h5>
		    <div class="quiz-status-box">
		    	<p>오늘의 퀴즈: ${todayQuizSubject}</p>
		        <c:choose>
		            <c:when test="${!isSolved}">
		                <p>아직 오늘의 퀴즈에 참여하지 않았습니다. 참여하러 가볼까요? 🤔</p>
		                <a href="${pageContext.request.contextPath}/event/quiz" class="btn-quiz">퀴즈 풀러가기</a>
		            </c:when>
		            <c:when test="${isSolved && isCorrect}">
		                <p>🎉 정답을 맞혀 100 포인트가 적립되었습니다!</p>
		            </c:when>
		            <c:otherwise>
		                <p>아쉽지만 오답입니다. 내일 다시 도전해주세요! 😥</p>
		            </c:otherwise>
		        </c:choose>
		    </div>
		</div>
		  
		  
		  
	  </div>
    </div>
    
  </div>
  
</main>

  <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
  <script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>