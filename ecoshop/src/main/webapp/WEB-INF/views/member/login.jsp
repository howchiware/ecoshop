<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<style>
body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f7f6f3;
      color: #333;
      margin: 0;
    }

    .login-container {
      max-width: 400px;
      margin: 100px auto 0 auto; /* 상단 여백을 줘서 좀 위로 */
      padding: 0 20px;
    }

    .login-title {
      font-size: 1.8rem;
      font-weight: 700;
      color: #315e4e;
      text-align: center;
      margin-bottom: 30px;
    }

    .form-label {
      font-size: 0.95rem;
      font-weight: 500;
      margin-bottom: 6px;
    }

    .form-control {
      border-radius: 12px;
      padding: 10px 15px;
      font-size: 0.95rem;
      border: 1px solid #ddd;
    }

    .form-control:focus {
      border-color: #315e4e;
      box-shadow: 0 0 0 0.2rem rgba(49, 94, 78, 0.15);
    }

    .btn-login {
      background-color: #315e4e;
      color: white;
      border: none;
      padding: 10px;
      font-size: 1rem;
      font-weight: 600;
      border-radius: 12px;
      transition: background 0.2s;
    }

    .btn-login:hover {
      background-color: #234d3c;
    }

    .link-group {
      display: flex;
      justify-content: space-between;
      font-size: 0.85rem;
      margin-top: 10px;
    }

    .link-group a {
      color: #315e4e;
      text-decoration: none;
    }

    .link-group a:hover {
      text-decoration: underline;
    }
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	
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
      <div class="link-group mt-3">
        <a href="#">비밀번호 찾기</a>
        <a href="#">회원가입</a>
      </div>
    </form>
  	</div>
	
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