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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssEvent/quiz.css" type="text/css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<main>
	<section class="quiz-header">
	  <h1>오늘의 환경 퀴즈</h1>
	  <p><i class="bi bi-award-fill"></i> 정답을 맞히면 100 포인트를 드려요!</p>
	</section>
	
    <div class="flip-card-container">
        <div class="flip-card">
            <c:choose>

                <c:when test="${not empty todayQuiz}">
                    <div class="flip-card-front">
                        <div class="quiz-title">${todayQuiz.subject}</div>
                        <div class="quiz-question">${todayQuiz.content}</div>
                        <div class="quiz-buttons">
                            <button type="button" class="quiz-btn" data-answer="O">O</button>
                            <button type="button" class="quiz-btn" data-answer="X">X</button>
                        </div>
                    </div>

                    <div class="flip-card-back">
                        <div id="resultIcon"></div>
                        <h2 id="resultTitle"></h2>
                        <p id="resultDesc"></p>
                        <div id="resultPoint"></div>
                        <button type="button" class="btn-back">다시 보기</button>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="flip-card-front" style="background: #95a5a6;">
                        <div class="quiz-title">퀴즈 준비 중</div>
                        <div class="quiz-question">오늘의 퀴즈가 아직 등록되지 않았습니다.</div>
                    </div>
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
<c:choose>
    <c:when test="${not empty todayQuiz}">
        <script>
        const CONTEXT_PATH = '${pageContext.request.contextPath}';
        const quizData = {
            quizId: ${todayQuiz.quizId},
            isSolved: ${isSolved}
        };
        </script>
    </c:when>
    <c:otherwise>
        </c:otherwise>
</c:choose>
<script src="${pageContext.request.contextPath}/dist/jsEvent/quiz.js"></script>
</body>
</html>