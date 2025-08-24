<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/editMember.css" type="text/css">
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<!-- 메인 영역 -->
	<main class="main-container">
		<div class="row">

			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
			</div>

			<div class="col-md-10">
				<div class="contentsArea centered-content">
					
					<div class="bg-white box-shadow my-5 p-5">
						<h3 class="text-center pt-3">패스워드 재확인</h3>

						<form name="pwdForm" action="" method="post" class="row g-3 mb-2">
							<div class="col-12">
								<p class="form-control-plaintext text-center">정보보호를 위해 패스워드를
									다시 한 번 입력해주세요.</p>
							</div>

							<div class="col-12">
								<input type="text" name="userId"
									class="form-control form-control-lg" placeholder="아이디"
									value="${sessionScope.member.memberId}" readonly>
							</div>
							<div class="col-12">
								<input type="password" name="password"
									class="form-control form-control-lg" autocomplete="off"
									placeholder="패스워드">
							</div>
							<div class="col-12 text-center">
								<input type="hidden" name="mode" value="${mode}">
								<button type="button" class="btn-accent btn-lg w-50"
									onclick="sendOk();">
									확인 <i class="bi bi-check2"></i>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</main>

	<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>
	<script type="text/javascript">
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsMember/pwd.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>