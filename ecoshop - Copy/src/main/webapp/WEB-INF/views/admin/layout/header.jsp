<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>관리자 페이지 헤더</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/Aheader.css" />
</head>
<body>
  <div class="header">
    <div class="header-inner">
      <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
      <div class="header-title">관리자 페이지</div>
      <div class="header-icons">
        <ul>
          <li>
            <a href="<c:url value='/member/logout' />" title="Logout">
              <span class="menu-label">로그아웃</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</body>
</html>
