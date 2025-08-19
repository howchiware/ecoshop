<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - 오늘의 퀴즈 관리</title>
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
  background-color: var(--color-white);
  border-radius: 12px;
  padding: 2rem;
  border: 1px solid var(--color-border);
  box-shadow: 0 4px 12px rgba(0,0,0,0.04);
}

.page-title h2 {
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
    font-size: 1.8rem;
    color: var(--color-text-dark);
    margin-bottom: 2.5rem;
    display: flex;
    align-items: center;
    gap: 12px;
}
.page-title h2 i {
    color: var(--color-primary);
}

.stats-card {
    background: linear-gradient(135deg, var(--color-primary), #4caf50);
    color: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2.5rem;
    box-shadow: 0 8px 16px rgba(49, 94, 78, 0.2);
}
.stats-card .card-title {
    font-weight: 500;
    opacity: 0.9;
    font-size: 1rem;
}
.stats-card .card-text {
    font-size: 2rem;
    font-weight: 700;
}
.stats-card .badge {
    font-size: 0.9rem;
    padding: 0.5em 0.8em;
}

.search-form {
    background-color: var(--color-bg);
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2rem;
    border: 1px solid var(--color-border);
}
.search-form label {
  font-weight: 600;
  color: var(--color-text-dark);
  font-size: 0.9rem;
}

.btn-primary {
  background-color: var(--color-primary) !important;
  border-color: var(--color-primary) !important;
  font-weight: 600;
}
.btn-primary:hover {
  background-color: var(--color-primary-darker) !important;
  border-color: var(--color-primary-darker) !important;
}
.btn-secondary {
    background-color: #e9ecef;
    border-color: #e9ecef;
    color: #495057;
    font-weight: 600;
}
.btn-secondary:hover {
    background-color: #dee2e6;
    border-color: #dee2e6;
}

.table {
    border-top: 2px solid var(--color-primary);
}
.table thead th {
    background-color: #f8f9fa;
    color: var(--color-text-secondary);
    font-weight: 600;
    text-align: center;
    border-bottom: 1px solid var(--color-border);
}
.table tbody td {
    vertical-align: middle;
    text-align: center;
    color: #495057;
}
.table tbody tr:hover {
    background-color: #fcfcfd;
}
.table a {
    color: var(--color-text-dark);
    text-decoration: none;
    font-weight: 600;
}
.table a:hover {
    color: var(--color-primary);
    text-decoration: underline;
}

.table-bottom-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 1.5rem;
}

.page-navigation {
    display: flex;
    justify-content: center;
}
.pagination .page-link {
    color: var(--color-primary);
}
.pagination .page-item.active .page-link {
    background-color: var(--color-primary);
    border-color: var(--color-primary);
}
.pagination .page-link:focus {
    box-shadow: 0 0 0 0.2rem rgba(49, 94, 78, 0.25);
}
</style>
</head>
<body>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		
        <div class="right-panel">
			<div class="page-title">
			    <h2><i class="bi bi-patch-question-fill"></i> 오늘의 퀴즈 관리</h2>
			</div>
            
            <div class="content">
                <div class="row">
                    <div class="col-md-6">
                         <div class="stats-card">
                            <h5 class="card-title">총 등록된 퀴즈</h5>
                            <p class="card-text">${dataCount}개</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="stats-card">
                            <h5 class="card-title">오늘의 퀴즈</h5>
                            <p class="card-text">
                                <c:choose>
                                    <c:when test="${not empty todayQuiz}">
                                        ${todayQuiz.subject}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-dark">미지정</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>

                <form name="searchForm" class="search-form row g-3 align-items-end" method="get">
                    <div class="col-md-3">
                        <label for="schType" class="form-label">검색 조건</label> 
                        <select id="schType" name="schType" class="form-select">
                            <option value="name" ${schType=="name"?"selected":""}>작성자</option>
                            <option value="openDate" ${schType=="openDate"?"selected":""}>개시일</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="kwd" class="form-label">검색어</label> 
                        <input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">조회</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list'">초기화</button>
                    </div>
                </form>

                <table class="table table-hover">
                    <thead>
                        <tr class="text-center">
                            <th width="8%">No</th>
                            <th width="12%">퀴즈 번호</th>
                            <th>퀴즈 제목</th>
                            <th width="15%">개시일</th>
                            <th width="15%">작성일</th>
                            <th width="12%">최종 출제자</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                            <tr class="text-center">
                                <td>${dataCount - (page-1) * size - status.index}</td>
                                <td>${item.quizId}</td>
                                <td class="text-start">
                                    <a href="${articleUrl}&quizId=${item.quizId}">${item.subject}</a>
                                </td>
                                <td>${item.openDate}</td>
                                <td>${item.regDate}</td>
                                <td>${item.name}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center py-5">등록된 퀴즈가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                
                <div class="table-bottom-controls">
                    <div class="align-self-center">
                        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/write';">퀴즈 등록</button>
                    </div>
                    <div class="page-navigation">
                        ${dataCount == 0 ? "" : paging}
                    </div>
                </div>
            </div>
		</div>
	</main>

<script>
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') { 
			evt.preventDefault();
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>
	
</body>
</html>