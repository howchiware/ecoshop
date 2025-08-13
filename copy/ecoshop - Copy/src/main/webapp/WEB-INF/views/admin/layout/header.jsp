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
    <ul class="left-menu">
      <li>
      <c:if test="${sessionScope.member.userLevel>50}">
        <a href="${pageContext.request.contextPath}/admin" title="관리자 페이지" class="admin-text">관리자 페이지</a>
      </c:if>
      </li>
    </ul>

    <ul class="right-menu">
      <li>
        <a href="${pageContext.request.contextPath}/" title="홈">
          <i class="bi bi-house-door-fill"></i>
        </a>
      </li>
	  <li>
        <a href="<c:url value='/member/logout' />" title="로그아웃">
          <i class="bi bi-box-arrow-in-left"></i>
        </a>
      </li>
    </ul>
  </div>
</div>
</body>
</html>
