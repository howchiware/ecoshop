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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/pwdFind.css" type="text/css"> 
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	
	<main class="container my-5">
		<div class="login-container">
			<h2 class="login-title">비밀번호 찾기</h2>
			<form name="pwdForm" action="" method="post">
				<div class="mb-3">
					<label for="userId" class="form-label">아이디</label>
					<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요">
				</div>
				<div class="mb-3">
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
				</div>
				
				<button type="button" class="btn btn-login w-100 mt-3" onclick="sendOk();">확인</button>
				
				<div>
					<p class="form-control-plaintext text-center text-danger">${message}</p>
				</div>
			</form>
		</div>
	</main>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsMember/pwdFind.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>