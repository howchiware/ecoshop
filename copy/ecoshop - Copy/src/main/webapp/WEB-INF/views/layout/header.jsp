<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<div class="bg-light py-1 border-bottom small" style="font-size: 0.8rem;">
		<div class="container d-flex justify-content-between align-items-center">
			<div class="text-muted">지속 가능한 일상을 위한 모든 것</div>
			<div>
				<a class="text-decoration-none me-3 text-muted" href="${pageContext.request.contextPath}/customer/list">고객센터</a>
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<a class="text-decoration-none me-3 text-muted" href="${pageContext.request.contextPath}/member/login">로그인</a>						
						<a class="text-decoration-none text-muted" href="${pageContext.request.contextPath}/member/account">회원가입</a>
					</c:when>
					<c:otherwise>
						<a class="text-decoration-none me-3 text-muted" href="${pageContext.request.contextPath}/member/logout" title="로그아웃">로그아웃</a>
						<c:if test="${sessionScope.member.userLevel>50}">
							<a class="text-decoration-none me-3 text-muted" href="${pageContext.request.contextPath}/admin" title="관리자">관리 페이지</a>
						</c:if>
						<c:if test="${sessionScope.member.userLevel == 1  }">
							<a class="text-decoration-none me-3 text-muted" href="${pageContext.request.contextPath}/member/myPage" title="사용자">마이 페이지</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</div>
	<!-- 상단 네비게이션 -->
	<nav class="navbar navbar-expand-lg sticky-top">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">ECOBRAND</a>
			<button class="navbar-toggler" data-bs-target="#navbarNav"
				data-bs-toggle="collapse" type="button">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-between"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="#">SHOP</a></li>
					<li class="nav-item"><a class="nav-link" href="#">패키지</a></li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button">이벤트</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/attendance">출석체크</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/quiz">퀴즈</a></li>
						</ul>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">워크샵</a></li>
					<li class="nav-item"><a class="nav-link" href="#">챌린지</a></li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button">콘텐츠</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">매거진</a></li>
							<li><a class="dropdown-item" href="#">제로웨이스트 팁</a></li>
							<li><a class="dropdown-item" href="#">분리배출 가이드</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button">커뮤니티</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/free/list">자유게시판</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
						</ul>
					</li>
				</ul>
				<ul class="navbar-nav">
					<c:if test="${not empty sessionScope.member}">
						<li class="nav-item d-flex align-items-center">
						    <span class="nickname-text">${sessionScope.member.nickname}님</span>
						</li>
						<a class="nav-link" href="#"><i class="bi bi-bell" style="font-size: 1.2rem;"></i></a>
					</c:if>
					<li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-bag" style="font-size: 1.2rem;"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	

</body>
</html>
