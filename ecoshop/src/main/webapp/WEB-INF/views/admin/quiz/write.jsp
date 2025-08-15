<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - 퀴즈 등록/수정</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<style>
:root {
  --color-primary: #315e4e;
  --color-primary-darker: #234d3c;
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
	background-color: var(--color-white);
	border-radius: 12px;
	padding: 2.5rem;
    border: 1px solid var(--color-border);
    box-shadow: 0 4px 12px rgba(0,0,0,0.04);
	max-width: 900px;
	margin: 0 auto;
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
.form-label {
	font-weight: 600;
	color: var(--color-text-dark);
    margin-bottom: 0.75rem;
}
.form-text {
    font-size: 0.85rem;
    color: var(--color-text-light);
}
.form-control, .form-select {
    border-radius: 6px;
    border: 1px solid var(--color-border);
    padding: 0.75rem 1rem;
    font-size: 1rem;
}
.form-control:focus, .form-select:focus {
	border-color: var(--color-primary);
	box-shadow: 0 0 0 0.2rem rgba(49, 94, 78, 0.2);
}
.action-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 2.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid var(--color-border);
}
.btn {
    font-weight: 600;
    padding: 0.75rem 1.5rem;
}
.btn-primary {
  background-color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
}
.btn-secondary {
    background-color: #e9ecef;
    border-color: #e9ecef;
    color: #495057;
}
</style>
</head>
<body>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		
        <div class="right-panel">
			<div class="page-title">
			    <h2><i class="bi bi-pencil-fill"></i> ${mode == "update" ? "오늘의 퀴즈 수정" : "오늘의 퀴즈 등록"}</h2>
                <%-- 수정된 서브타이틀 --%>
                <p class="page-subtitle">재미있는 퀴즈로 사용자의 꾸준한 참여를 유도해보세요.</p>
			</div>

            <div class="content">
                <form name="quizForm" method="post">
                    <div class="row g-3 mb-4">
                        <div class="col-md-9">
                            <label for="subject" class="form-label">퀴즈 제목</label>
                            <input class="form-control" type="text" id="subject" name="subject" value="${dto.subject}" autofocus>
                        </div>
                        <div class="col-md-3">
                            <label for="answer" class="form-label">정답</label>
                            <select id="answer" name="answer" class="form-select">
                                <option value="1" ${dto.answer=="1"?"selected":"" }>O</option>
                                <option value="0" ${dto.answer=="0"?"selected":"" }>X</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="content" class="form-label">퀴즈 내용 (질문)</label>
                        <input class="form-control" type="text" id="content" name="content" value="${dto.content}">
                    </div>

                    <div class="mb-4">
                        <label for="commentary" class="form-label">해설</label>
                        <input class="form-control" type="text" id="commentary" name="commentary" value="<c:out value='${dto.commentary}' escapeXml='false'/>" />
                    </div>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="openDate" class="form-label">개시일</label>
                            <input class="form-control" type="date" id="openDate" name="openDate" value="${dto.openDate}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">최종 작성자</label>
                            <input class="form-control" type="text" value="${sessionScope.member.name}" readonly style="border:none; background:transparent; padding-left:0;">
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button type="button" class="btn btn-primary" onclick="quizOk();">
                            ${mode == "update" ? "수정 완료" : "퀴즈 등록"}
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list';">
                            취소
                        </button>
                        
                        <c:if test="${mode=='update'}">
                            <input type="hidden" name="quizId" value="${dto.quizId}">
                            <input type="hidden" name="page" value="${page}">
                        </c:if>
                    </div>
                </form>
            </div>
		</div>
	</main>

	<c:if test="${not empty message}">
	    <script>
	        alert("${message}");
	    </script>
	</c:if>
	<script type="text/javascript">
	function isValidDateString(dateString) {
	    return dateString && dateString.length === 10;
	}

	function quizOk() {
	    const f = document.quizForm;
	    let str;

	    str = f.subject.value.trim();
	    if (!str) { 
	        alert('퀴즈 제목을 입력하세요.');
	        f.subject.focus();
	        return;
	    }

	    str = f.content.value.trim();
	    if (!str) { 
	        alert('퀴즈 내용을 입력하세요.');
	        f.content.focus();
	        return;
	    }
	    
	    str = f.answer.value;
	    if (!str) { 
	        alert('정답을 선택하세요.');
	        f.answer.focus();
	        return;
	    }

	    str = f.openDate.value;
	    if (!isValidDateString(str)) {
	        alert('개시일을 선택하세요.');
	        f.openDate.focus();
	        return;
	    }
	    
	    f.action = '${pageContext.request.contextPath}/admin/quiz/${mode}';
	    f.submit();
	} 
	</script>

</body>
</html>