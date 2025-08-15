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
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-style: normal;
}
body {
    background-color: #f4f7f6;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}
main {
    flex: 1;
}
* {
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
}

.quiz-header {
  text-align: center;
  margin: 60px auto 40px auto;
}
.quiz-header h1 {
  font-size: 2.5rem;
  font-weight: 800;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}
.quiz-header p {
  font-size: 1.2rem;
  color: #27ae60;
  font-weight: 600;
}
.quiz-header p i {
    vertical-align: -2px;
}

/* --- 플립 카드 컨테이너 --- */
.flip-card-container {
    perspective: 1000px;
    max-width: 550px;
    margin: 0 auto;
}
.flip-card {
    width: 100%;
    height: 350px;
    position: relative;
    transition: transform 0.6s;
    transform-style: preserve-3d;
}
.flip-card.is-flipped {
    transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
    position: absolute;
    width: 100%;
    height: 100%;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
    border-radius: 24px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 30px;
    text-align: center;
}

.flip-card-front {
    background: linear-gradient(135deg, #66bb6a, #43a047);
    color: white;
}
.quiz-title {
    font-size: 1.2rem;
    font-weight: 600;
    opacity: 0.8;
}
.quiz-question {
    font-size: 1.8rem;
    font-weight: 700;
    margin: 1rem 0 2rem 0;
}
.quiz-buttons {
    display: flex;
    gap: 20px;
}
.quiz-btn {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 3px solid rgba(255, 255, 255, 0.7);
    background: transparent;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.2s ease;
}
.quiz-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.05);
}

/* --- 카드 뒷면 (답변) --- */
.flip-card-back {
    background-color: #ffffff;
    transform: rotateY(180deg);
}
.result-icon {
    font-size: 4rem;
    line-height: 1;
    animation: pop-in 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
}
.result-icon.correct { color: #27ae60; }
.result-icon.incorrect { color: #e74c3c; }

.result-title {
    font-size: 2rem;
    font-weight: 800;
    margin-top: 1rem;
    color: #2c3e50;
    animation: fade-in 0.5s 0.2s ease-out both;
}
.result-desc {
    font-size: 1.1rem;
    color: #8492a6;
    margin-top: 0.75rem;
    font-weight: 500;
    animation: fade-in 0.5s 0.4s ease-out both;
}
.result-point {
    font-size: 1.1rem;
    font-weight: 600;
    color: #27ae60;
    margin-top: 1rem;
    animation: fade-in 0.5s 0.6s ease-out both;
}
.btn-back {
    margin-top: 1.5rem;
    padding: 10px 25px;
    border-radius: 20px;
    background: #ecf0f1;
    color: #7f8c8d;
    border: none;
    font-weight: 600;
    animation: fade-in 0.5s 0.8s ease-out both;
}

@keyframes pop-in {
    from { transform: scale(0.5); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}
@keyframes fade-in {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

footer {
	text-align: center;
	padding: 30px 0;
	font-size: 0.9rem;
	color: #666;
	background-color: transparent;
	margin-top: 60px;
}
</style>
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
	
	<script>
	$(document).ready(function() {

        <c:if test="${not empty todayQuiz}">
            const correctAnswer = '${todayQuiz.answer == "1" ? "O" : "X"}';
            const explanation = `${fn:escapeXml(todayQuiz.commentary)}`; // fn은 특수 문자를 안전한 코드로 변환해주는 함수
            const isSolved = ${isSolved};
            const flipCard = $('.flip-card');

            if(isSolved) {
                $('.quiz-buttons').html('<p style="font-size: 1.2rem; font-weight: 600; background: rgba(0,0,0,0.2); padding: 1rem; border-radius: 8px;">오늘의 퀴즈에 이미 참여했습니다!</p>');
            }

            $('.quiz-btn').on('click', function() {
                if(isSolved) return;

                const userAnswer = $(this).data('answer');
                const isCorrect = (userAnswer === correctAnswer);

                if(isCorrect) {
                    $('#resultIcon').html('<i class="bi bi-check-circle-fill result-icon correct"></i>');
                    $('#resultTitle').text('정답입니다! 🎉');
                    $('#resultDesc').html(explanation);
                    $('#resultPoint').html('<i class="bi bi-gift-fill"></i> 100 포인트 적립 완료!');
                } else {
                    $('#resultIcon').html('<i class="bi bi-x-circle-fill result-icon incorrect"></i>');
                    $('#resultTitle').text('아쉬워요 😢');
                    $('#resultDesc').html(explanation);
                    $('#resultPoint').html('');
                }

                flipCard.addClass('is-flipped');
            });

            $('.btn-back').on('click', function() {
                flipCard.removeClass('is-flipped');
            });
        </c:if>
	});
	</script>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>