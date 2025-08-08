<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<!-- 최상단 회사 설명 및 로그인 회원가입 영역 -->
	<div class="bg-light py-1 border-bottom small"
		style="font-size: 0.8rem;">
		<div
			class="container d-flex justify-content-between align-items-center">
			<div class="text-muted">지속 가능한 일상을 위한 모든 것</div>
			<div>
				<a class="text-decoration-none me-3 text-muted" href="#">고객센터</a> <a
					class="text-decoration-none me-3 text-muted" href="#">로그인</a> <a
					class="text-decoration-none text-muted" href="#">회원가입</a>
			</div>
		</div>
	</div>
	<!-- 상단 네비게이션 -->
	<nav class="navbar navbar-expand-lg sticky-top">
		<div class="container">
			<a class="navbar-brand" href="#">ECOBRAND</a>
			<button class="navbar-toggler" data-bs-target="#navbarNav"
				data-bs-toggle="collapse" type="button">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-between"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#">홈</a></li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button">SHOP</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">전체 상품</a></li>
						</ul>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">패키지</a></li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button">이벤트</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">출석체크</a></li>
							<li><a class="dropdown-item" href="#">퀴즈</a></li>
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
							<li><a class="dropdown-item" href="#">자유게시판</a></li>
							<li><a class="dropdown-item" href="#">공지사항</a></li>
						</ul>
					</li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-bell" style="font-size: 1.2rem;"></i></a></li>
					<li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-bag" style="font-size: 1.2rem;"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Hero Section -->
	<section class="hero">
		<div class="hero-overlay"></div>
		<div class="hero-content">
			<h1>당신의 선택이 변화를 만듭니다.</h1>
			<p>지속 가능한 삶, 지금 이곳에서 시작하세요.</p>
		</div>
	</section>

</body>
</html>
