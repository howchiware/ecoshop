<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

.navbar {
	background-color: #ffffff;
	border-bottom: 1px solid #e2e2e2;
	padding-top: 10px;
	padding-bottom: 10px;
}

.navbar-brand {
	font-weight: 600;
	font-size: 1.4rem;
	color: #222 !important;
	letter-spacing: 0.7px;
}

.nav-link {
	color: #222 !important;
	font-weight: 400;
	font-size: 0.9rem;
	padding: 0.5rem 1rem;
}

.nav-link:hover {
	color: #999 !important;
}

.navbar-nav {
	gap: 5px;
}

.dropdown-menu {
	font-size: 0.9rem;
}

.navbar-toggler {
	border: none;
}

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml,%3csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3e%3cpath stroke='rgba(34, 34, 34, 0.8)' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

.navbar-brand {
	font-weight: bold;
	color: #315e4e;
}

.nav-link {
	color: #3a3a3a !important;
	font-weight: 500;
	margin-right: 15px;
}

.nav-link:hover {
	color: #234d3c !important;
}

.hero {
	background-image:
		url('https://source.unsplash.com/1600x900/?nature,earth');
	background-size: cover;
	background-position: center;
	height: 80vh;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;
	color: white;
	text-align: center;
}

.hero-overlay {
	background-color: rgba(0, 0, 0, 0.4);
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 1;
}

.hero-content {
	z-index: 2;
	padding: 20px;
}

.hero-content h1 {
	font-size: 3rem;
	font-weight: 800;
	margin-bottom: 1rem;
}

.hero-content p {
	font-size: 1.2rem;
}

.section {
	padding: 80px 20px;
}

.section-title {
	font-size: 1.8rem;
	font-weight: 600;
	margin-bottom: 40px;
	text-align: left;
	color: #1f1f1f;
}

.card-hover {
	border: 1px solid #ddd;
	border-radius: 0;
	overflow: hidden;
	box-shadow: none;
	transition: all 0.2s ease-in-out;
}

.card-hover:hover {
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
	transform: translateY(-2px);
}

.card-img-top, .card-img, .card-body, .card-img-overlay {
	border-radius: 0 !important;
}

.card-img-top, .card-img {
	border-radius: 0;
}

.card-body {
	background-color: #fff;
	padding: 1.25rem;
}

.card-title {
	font-size: 1rem;
	font-weight: 500;
	margin-bottom: 0.5rem;
	color: #222;
}

.card-img-overlay .card-title {
	color: #fff !important;
}

.card-text {
	font-size: 0.875rem;
	color: #555;
}

.card-img-overlay {
	background: rgba(0, 0, 0, 0.3);
	color: white;
	padding: 1rem;
}

.card:hover .card-img-overlay {
	background: rgba(0, 0, 0, 0.45);
}

.card-body {
	background-color: #fff;
}

.card-img-overlay {
	background: rgba(0, 0, 0, 0.3);
	color: white;
}

.card:hover .card-img-overlay {
	background: rgba(0, 0, 0, 0.5);
}

.card-title {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 0.5rem;
}

.card-body .card-text {
	color: #333; /* 일반 카드용 본문 텍스트 */
}

.card-img-overlay .card-text {
	color: #fff; /* 이미지 오버레이 카드용 텍스트 */
}

.nav-item.dropdown:hover > .dropdown-menu {
  display: block;
  margin-top: 0;
}

footer {
	background-color: #2e2e2e;
	color: #ccc;
	text-align: center;
	padding: 40px 0;
}
</style>
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
	<!-- 베스트 상품 Section -->
	<section class="section">
		<div class="container">
			<h2 class="section-title text-start mb-4">많이 찾는 제품</h2>
			<div class="row g-4">
				<div class="col-md-4">
					<div class="card card-hover border-0 shadow-sm">
						<img alt="Best 1" class="card-img-top"
							src="https://source.unsplash.com/600x400/?eco,product1" />
						<div class="card-body">
							<h5 class="card-title">유기농 핸드타월</h5>
							<p class="card-text">자극 없이 피부를 감싸는 친환경 핸드타월</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card card-hover border-0 shadow-sm">
						<img alt="Best 2" class="card-img-top"
							src="https://source.unsplash.com/600x400/?eco,product2" />
						<div class="card-body">
							<h5 class="card-title">천연 수세미</h5>
							<p class="card-text">플라스틱 없이 설거지 가능한 식물성 수세미 3종</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card card-hover border-0 shadow-sm">
						<img alt="Best 3" class="card-img-top"
							src="https://source.unsplash.com/600x400/?eco,product3" />
						<div class="card-body">
							<h5 class="card-title">생분해 비누망</h5>
							<p class="card-text">비누 거품을 풍성하게 만드는 생분해 소재망</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 공동구매 Section -->
	<section class="section py-5">
		<div class="container">
			<h2 class="section-title text-start mb-4">함께 사서 더 저렴하게</h2>
			<div class="card border-0 shadow-sm">
				<div class="row g-0 align-items-center" style="height: 220px;">
					<!-- 이미지 -->
					<div class="col-md-5 h-100">
						<img src="https://source.unsplash.com/1000x600/?eco,groupbuy"
							class="img-fluid w-100 h-100" style="object-fit: cover;"
							alt="공동구매">
					</div>
					<!-- 텍스트 -->
					<div
						class="col-md-7 p-4 d-flex flex-column justify-content-center h-100">
						<h5 class="card-title fs-4 fw-bold">제로 웨이스트 패키지</h5>
						<p class="card-text text-muted mb-0">대나무 칫솔, 천연 밀랍 랩, 리필형
							주방세제, 휴대용 빨대까지 제로웨이스트 필수 구성</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 감성 콘텐츠 카드 Section -->
	<section class="section">
		<div class="container">
			<h2 class="section-title">일상에서 시작하는 습관</h2>
			<div class="row g-4">
				<div class="col-md-4">
					<div class="card text-white card-hover">
						<img alt="워크샵" class="card-img"
							src="https://source.unsplash.com/600x400/?eco,bag" />
						<div class="card-img-overlay d-flex align-items-end">
							<div>
								<h5 class="card-title">워크샵</h5>
								<p class="card-text">배우고, 만드는 지속 가능성</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card text-white card-hover">
						<img alt="챌린지" class="card-img"
							src="https://source.unsplash.com/600x400/?volunteer,environment" />
						<div class="card-img-overlay d-flex align-items-end">
							<div>
								<h5 class="card-title">챌린지</h5>
								<p class="card-text">오늘 할 수 있는 한 가지</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card text-white card-hover">
						<img alt="매거진" class="card-img"
							src="https://source.unsplash.com/600x400/?newsletter,reading" />
						<div class="card-img-overlay d-flex align-items-end">
							<div>
								<h5 class="card-title">매거진</h5>
								<p class="card-text">조용히 읽고, 가볍게 실천하기</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 광고 섹션 -->
	<section class="py-5">
		<div class="container">
			<div class="bg-light text-center py-5 px-3 border rounded shadow-sm">
				<p class="mb-0 fw-semibold fs-5 text-muted">광고 또는 배너 영역</p>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<footer>
		<p>© 2025 ECOBRAND. 지구를 위한 작은 실천, 여기서 시작됩니다.</p>
	</footer>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>