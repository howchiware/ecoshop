<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/login.css" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	
	<main class="container my-5">
		<div class="login-container">
	    <h2 class="login-title">로그인</h2>
	    <form name="loginForm" action="" method="post">
	      <div class="mb-3">
	        <label for="userId" class="form-label">아이디</label>
	        <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
	      </div>
	      <div class="mb-3">
	        <label for="password" class="form-label">비밀번호</label>
	        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
	      </div>
	      <button type="submit" class="btn btn-login w-100 mt-3" onclick="sendLogin();">로그인</button>
	      <div>
		  	<p class="form-control-plaintext text-center text-danger">${message}</p>
		  </div>
	      <div class="link-group mt-3">
	        <a href="${pageContext.request.contextPath}/member/pwdFind">비밀번호 찾기</a>
	        <a href="${pageContext.request.contextPath}/member/account">회원가입</a>
	      </div>
	    </form>
	  	</div>
  	</main>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
	function sendLogin() {
		const f = document.loginForm;
		
		if(! f.userId.value.trim()) {
			f.userId.focus();
			return;
		}
		
		if(! f.password.value.trim()) {
			f.password.focus();
			return;
		}
		
		 f.action = '${pageContext.request.contextPath}/member/login';
		 f.submit();
	}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>