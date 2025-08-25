<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
/* --- ▼▼▼ 새롭게 개선된 헤더 CSS ▼▼▼ --- */
@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

@font-face {
    font-family: 'SpoqaHanSansNeo-Regular';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SpoqaHanSansNeo-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

.site-title {
      font-family: 'SpoqaHanSansNeo-Regular'
    }

.admin-header {
	width: 100%;
	height: 60px;
	background-color: #ffffff;
	border-bottom: 1px solid #e0e6ed;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 25px;
	position: sticky;
	top: 0;
	z-index: 1000;
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
}

/* --- 왼쪽: 로고 및 타이틀 --- */
.header-left {
	display: flex;
	align-items: center;
}

.logo-link {
	display: flex;
	align-items: center;
	text-decoration: none;
}

.logo-icon {
	font-size: 1.8rem;
	color: #2e7d32; /* ECOBRAND 테마 컬러 */
}

.site-title {
	font-size: 1.2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-left: 10px;
}

.admin-text {
	font-size: 1rem;
	font-weight: 500;
	color: #8492a6;
	margin-left: 15px;
	padding-left: 15px;
	border-left: 1px solid #e0e6ed;
}

/* --- 오른쪽: 사용자 정보 및 아이콘 메뉴 --- */
.header-right {
	display: flex;
	align-items: center;
	gap: 20px;
}

.user-greeting {
	font-size: 0.95rem;
	color: #5c6e80;
}

.user-greeting strong {
	font-weight: 600;
	color: #2c3e50;
}

.icon-menu {
	display: flex;
	align-items: center;
	gap: 15px;
	list-style: none;
	margin: 0;
	padding: 0;
}

.icon-menu a {
	color: #5c6e80;
	text-decoration: none;
	font-size: 1.3rem;
	transition: color 0.2s ease;
}

.icon-menu a:hover {
	color: #2e7d32;
}

.admin-header {
	position: sticky; /* 또는 fixed */
	top: 0;
	width: 100%;
	background-color: #ffffff; /* 배경색이 없으면 투명하게 비칠 수 있음 */
	/* 가장 높은 z-index 값을 부여하여 다른 모든 요소 위에 오도록 강제 */
	z-index: 9999 !important;
}
</style>

	<header class="admin-header">
		<div class="header-left">
			<a href="${pageContext.request.contextPath}/admin" class="logo-link">
				<span class="site-title">에코모아</span>
			</a> <span class="admin-text">관리자 페이지</span>
		</div>

		<div class="header-right">
			<span class="user-greeting"> 안녕하세요, <strong>${sessionScope.member.name}</strong>님
			</span>
			<ul class="icon-menu">
				<li><a href="${pageContext.request.contextPath}/" title="홈으로">
						<i class="bi bi-house-door-fill"></i>
				</a></li>
				<li><a href="<c:url value='/member/logout' />" title="로그아웃">
						<i class="bi bi-box-arrow-right"></i>
				</a></li>
			</ul>
		</div>
	</header>
