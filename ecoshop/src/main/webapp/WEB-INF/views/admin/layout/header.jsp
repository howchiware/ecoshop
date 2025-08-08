<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
/* 헤더 바 */
.header {
  width: 100%;
  background-color: #2e7d32;
  color: white;
  position: fixed;
  top: 0;
  left: 0;
  height: 60px;
  display: flex;
  align-items: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  z-index: 1000;
}

/* 내부 컨테이너: 여백 포함해서 중앙 정렬 */
.header-inner {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

/* 타이틀 */
.header-title {
  font-size: 20px;
  font-weight: bold;
}

/* 아이콘 영역 */
.header-icons .icon-btn {
  background: none;
  border: none;
  color: white;
  font-size: 20px;
  margin-left: 15px;
  cursor: pointer;
}

/* 햄버거 버튼 */
.menu-toggle {
  background: none;
  border: none;
  color: white;
  font-size: 22px;
  cursor: pointer;
  display: none;
  margin-right: 15px;
}

/* 모바일에서 햄버거 표시 */
@media (max-width: 768px) {
  .menu-toggle {
    display: inline;
  }
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<div class="header">
	  <div class="header-inner">
	    <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
	    <div class="header-title">관리자 페이지</div>
	    <div class="header-icons">
		    <ul>
			     <li>
					<a href="<c:url value='/member/logout' />" class="menu-link" title="Logout">
						<i class="menu-icon bi bi-unlock"></i>
						<span class="menu-label">Logout</span>
					</a>
				</li>
			</ul>
	    </div>
	  </div>
	</div>
</body>
</html>
