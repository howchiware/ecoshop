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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssQuiz/quiz.css">
</head>
<body>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		
        <div class="right-panel">
			<div class="page-title">
			    <h3>퀴즈 상세 정보</h3>
			</div>

            <div class="content">
                <div class="quiz-card">
				    <h3 class="quiz-title">${dto.subject}</h3>
				    <div class="quiz-section">
				        <h4>퀴즈 내용</h4>
				        <p>${dto.content}</p>
				    </div>
				    <div class="quiz-section">
				        <h4>정답</h4>
				        <p>
				            <c:if test="${dto.answer eq '1'}">O</c:if>
				            <c:if test="${dto.answer eq '0'}">X</c:if>
				        </p>
				    </div>
				    <div class="quiz-section">
				        <h4>해설</h4>
				        <p>${dto.commentary}</p>
				    </div>
				</div>

                <table class="table meta-table">
                    <tbody>
                        <tr>
                            <th>작성자</th>
                            <td>${dto.name}</td>
                            <th>작성일</th>
                            <td>${dto.regDate}</td>
                        </tr>
                        <tr>
                            <th>개시일</th>
                            <td>${dto.openDate}</td>
                            <th>퀴즈번호</th>
                            <td>${dto.quizId}</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="action-buttons2">
                    <div>
                        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/update?quizId=${dto.quizId}&page=${page}';">
                            수정
                        </button>
                        <button type="button" class="btn my-btn" onclick="deleteOk();">
                            삭제
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list?${query}';">
                            목록
                        </button>
                    </div>
                </div>
            </div>
		</div>
	</main>

<c:if test="${sessionScope.member.memberId==dto.memberId||sessionScope.member.userLevel>50}">
	<script type="text/javascript">
	function deleteOk() {
		if(confirm('이 퀴즈를 정말 삭제하시겠습니까?')) {
			let params = 'quizId=${dto.quizId}&${query}';
			let url = '${pageContext.request.contextPath}/admin/quiz/delete?' + params;
			location.href = url;
		}
	}
	</script>
</c:if>

</body>
</html>