<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="d-flex align-items-end mb-4">
    <h1 class="mb-2 board-title fw-bold"><a href="${pageContext.request.contextPath}/free/dairyList">자유게시판</a></h1>
    <ul class="nav board-tabs ms-2 mb-2">
        <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/free/dairyList">일상 이야기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/free/challengeBundles">챌린지톡</a>
        </li>
    </ul>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const currentPath = window.location.pathname;
        const links = document.querySelectorAll(".board-tabs .nav-link");

        links.forEach(link => {
            if (currentPath.endsWith(link.getAttribute("href"))) {
                link.classList.add("active");
            } else {
                link.classList.remove("active");
            }
        });
    });
</script>