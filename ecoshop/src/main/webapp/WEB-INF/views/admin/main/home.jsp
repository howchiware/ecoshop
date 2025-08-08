<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style>
.main-content {
  flex: 1;
  padding: 20px;
  background-color: #fff;
}
</style>
    
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
	</header>
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
<!-- 메인 콘텐츠 -->
<div style="margin-left:240px; padding:20px;">
    <h1>관리자 메인 페이지</h1>
    <p>여기에 관리자 기능 설명을 넣을 수 있습니다.</p>
    
    
</div>
</body>
</html>
