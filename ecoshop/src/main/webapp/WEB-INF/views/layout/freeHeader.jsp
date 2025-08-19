<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="d-flex align-items-end mb-4">
    <h1 class="m-0 board-title"><a href="${pageContext.request.contextPath}/free/dairyList">자유게시판</a></h1>
    <ul class="nav board-tabs ms-4">
        <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/free/dairyList">일상 이야기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/free/challengeList">챌린지톡</a>
        </li>
    </ul>
</div>