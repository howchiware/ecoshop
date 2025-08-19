<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
</head>
<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- 메인 영역 -->
<main class="main-container">
  <div class="row">

    <div class="col-md-2">
      <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
    <div class="col-md-10">
	  <div class="contentsArea">
	  	<h3 class="pb-2 mb-4 border-bottom sub-title">회원정보 수정</h3>
	  </div>
	  
	  
    </div>
    
  </div>
  
</main>

  <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
</body>
</html>