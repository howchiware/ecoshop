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
			    <h3>${mode == "update" ? "오늘의 퀴즈 수정" : "오늘의 퀴즈 등록"}</h3>
			</div>
			<hr>

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
                        <label for="content" class="form-label">퀴즈 내용</label>
                        <input class="form-control" type="text" id="content" name="content" value="${dto.content}">
                    </div>

                    <div class="mb-4">
                        <label for="commentary" class="form-label">정답 설명</label>
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
                        <button type="button" class="btn my-btn" onclick="quizOk();">
                            ${mode == "update" ? "수정 완료" : "퀴즈 등록"}
                        </button>
                        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list';">
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
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
		const MODE = '${mode}';
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsQuiz/quizManage.js"></script>

</body>
</html>