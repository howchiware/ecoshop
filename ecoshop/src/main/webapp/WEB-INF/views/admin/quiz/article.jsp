<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - 퀴즈 상세 보기</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<style>
:root {
  --color-primary: #315e4e;
  --color-primary-darker: #234d3c;
  --color-secondary: #e6f4ea;
  --color-border: #e0e6ed;
  --color-text-dark: #2c3e50;
  --color-text-light: #8492a6;
  --color-bg: #f8f9fa;
  --color-white: #ffffff;
}
* {
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
}
body {
  background-color: var(--color-bg);
}

.main-container {
  display: flex;
}
.right-panel {
  flex: 1;
  padding: 1.5rem 2rem;
}
.content {
  max-width: 900px;
  margin: 0 auto;
  background-color: var(--color-white);
  border-radius: 12px;
  padding: 2.5rem;
  border: 1px solid var(--color-border);
  box-shadow: 0 4px 12px rgba(0,0,0,0.04);
}

.page-title h2 {
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
    font-size: 1.8rem;
    color: var(--color-text-dark);
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 12px;
}
.page-title h2 i {
    color: var(--color-primary);
}
.page-subtitle {
    color: var(--color-text-light);
    margin-bottom: 2.5rem;
}

.quiz-card {
    border: 1px solid var(--color-border);
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 2rem;
}
.quiz-card-header {
    background-color: var(--color-secondary);
    padding: 1rem 1.5rem;
}
.quiz-card-header h4 {
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--color-primary);
    margin: 0;
}
.quiz-card-body {
    padding: 1.5rem;
}
.quiz-section {
    margin-bottom: 1.5rem;
}
.quiz-section:last-child {
    margin-bottom: 0;
}
.quiz-section-title {
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--color-text-light);
    margin-bottom: 0.5rem;
}
.quiz-section-content {
    font-size: 1.1rem;
    font-weight: 500;
    color: var(--color-text-dark);
}
.quiz-answer {
    font-weight: 700;
    font-size: 1.2rem;
    color: var(--color-primary-darker);
}

.meta-table {
    font-size: 0.9rem;
}
.meta-table th {
    width: 100px;
    font-weight: 600;
    color: var(--color-text-light);
    border: none;
}
.meta-table td {
    color: var(--color-text-dark);
    border: none;
}

.action-buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid var(--color-border);
    padding-top: 1.5rem;
    margin-top: 2rem;
}
.btn-primary {
  background-color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
  font-weight: 600;
}
.btn-outline-danger {
    font-weight: 600;
}
.btn-secondary {
    background-color: #e9ecef;
    border-color: #e9ecef;
    color: #495057;
    font-weight: 600;
}
</style>
</head>
<body>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		
        <div class="right-panel">
			<div class="page-title">
			    <h2><i class="bi bi-file-text-fill"></i> 퀴즈 상세 정보</h2>
                <p class="page-subtitle">등록된 퀴즈의 상세 내용을 확인합니다.</p>
			</div>

            <div class="content">
                <div class="quiz-card">
                    <div class="quiz-card-header">
                        <h4>${dto.subject}</h4>
                    </div>
                    <div class="quiz-card-body">
                        <div class="quiz-section">
                            <h5 class="quiz-section-title">퀴즈 내용</h5>
                            <p class="quiz-section-content">${dto.content}</p>
                        </div>
                        <div class="quiz-section">
                            <h5 class="quiz-section-title">정답</h5>
                            <p class="quiz-section-content quiz-answer">
                                <c:if test="${dto.answer eq '1'}">O</c:if>
								<c:if test="${dto.answer eq '0'}">X</c:if>
                            </p>
                        </div>
                        <div class="quiz-section">
                            <h5 class="quiz-section-title">해설</h5>
                            <p class="quiz-section-content">${dto.commentary}</p>
                        </div>
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
                
                <div class="action-buttons">
                    <div>
                        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/update?quizId=${dto.quizId}&page=${page}';">
                            <i class="bi bi-pencil-square"></i> 수정
                        </button>
                        <button type="button" class="btn btn-outline-danger" onclick="deleteOk();">
                            <i class="bi bi-trash-fill"></i> 삭제
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list?${query}';">
                            <i class="bi bi-list-ul"></i> 목록
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