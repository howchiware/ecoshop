<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
			<div class="title">
				<h3>오늘의 퀴즈 관리</h3>
			</div>
			<hr>
            
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
                        <button type="submit" class="btn my-btn">조회</button>
                        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list'">초기화</button>
                    </div>
                </form>

                <table class="table table-hover">
                    <thead>
                        <tr class="text-center">
                            <th width="8%">번호</th>
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
                	<div class="page-navigation">
                        ${dataCount == 0 ? "" : paging}
                    </div>
                    <div class="align-self-center">
                        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/write';">퀴즈 등록</button>
                    </div>
                </div>
            </div>
		</div>
	</main>

<script src="${pageContext.request.contextPath}/dist/jsInquiry/inquiry.js"></script>
	
</body>
</html>