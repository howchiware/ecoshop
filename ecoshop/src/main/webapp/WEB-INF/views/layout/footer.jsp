<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
/* --- Footer --- */
.site-footer {
	background-color: #f8f9fa; /* 밝은 회색 배경 */
	color: #6c757d; /* 기본 텍스트 색상 */
	padding: 3rem 1rem;
	font-size: 0.8rem; /* 전체적으로 폰트 크기 작게 */
	border-top: 1px solid #dee2e6;
}

.site-footer .container {
	max-width: 1200px;
}

.site-footer a {
	color: #6c757d; /* 링크 색상 */
	text-decoration: none;
	transition: color 0.2s;
}

.site-footer a:hover {
	color: #212529;
}

/* 상단 링크 */
.footer-top {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 2rem;
	padding-bottom: 2rem;
}

.footer-links {
	display: flex;
	gap: 2rem;
	flex-wrap: wrap;
}

.link-column h5 {
	color: #212529; /* 제목 색상 */
	font-weight: 600;
	margin-bottom: 1rem;
	font-size: 0.9rem;
}

.link-column ul li {
	margin-bottom: 0.5rem;
}

.footer-social {
	display: flex;
	gap: 1rem;
	font-size: 1.5rem;
}

/* 하단 상세 정보 */
.footer-bottom {
	padding-top: 2rem;
	border-top: 1px solid #dee2e6;
}

.footer-info-dense p {
	margin-bottom: 0.5rem;
/* 	line-height: 1.6; */
}

.footer-info-dense span {
	margin-right: 0.5rem;
}

.footer-info-dense .biz-info-check {
	margin-left: 0.5rem;
	text-decoration: underline;
}

.footer-info-dense .disclaimer {
	color: #adb5bd;
	font-size: 0.75rem;
}

.footer-legal {
	margin-top: 1.5rem;
}

.footer-legal a {
	margin-right: 1.5rem;
}

.footer-copyright {
	margin-top: 1.5rem;
	color: #adb5bd;
}

/* Mobile responsive */
@media ( max-width : 768px) {
	.site-footer {
		text-align: center; /* 모바일에서 중앙 정렬 */
	}
	.footer-top {
		flex-direction: column;
		align-items: center;
	}
	.footer-links {
		width: 100%;
		justify-content: space-around;
		text-align: center;
	}
	.footer-social {
		justify-content: center;
	}
	.footer-bottom {
		text-align: center;
	}
	.footer-info-dense span {
		margin-right: 0.25rem;
	}
	.footer-legal a {
		margin: 0 0.5rem;
	}
}
</style>

<footer class="site-footer">
	<div class="container">

		<div class="footer-info-dense">
			<p>
				<span>(주)에코모아</span> | <span>대표자 : 김환경</span> | <span>주소 :
					서울특별시 성동구 아차산로 100, 에코타워 5층</span> | <span>호스팅사업자 : (주)에코모아</span>
			</p>
			<p>
				<span>통신판매업 : 2025-서울성동-00001</span> | <span>사업자등록번호 :
					123-45-67890</span> <a href="#" class="biz-info-check">사업자정보확인</a>
			</p>
			<p>
				당사는 고객님이 현금 결제한 금액에 대해 우리은행과 채무지급보증 계약을 체결하여 안전거래를 보장하고 있습니다. <a
					href="#" class="biz-info-check">서비스 가입사실 확인</a>
			</p>
			<p class="disclaimer">일부 상품의 경우 (주)에코브랜드는 통신판매의 당사자가 아닌 통신판매중개자로서
				상품, 상품정보, 거래에 대한 책임이 제한될 수 있으므로, 각 상품 페이지에서 구체적인 내용을 확인하시기 바랍니다.</p>
		</div>
		<div class="footer-legal">
			<a href="#">이용약관</a> <a
				href="${pageContext.request.contextPath}/advertisement/write">광고
				문의</a> <a href="#"><strong>개인정보처리방침</strong></a>

		</div>



		<div class="footer-copyright">
			<p>© ECOMORE ALL RIGHTS RESERVED</p>
		</div>
	</div>

</footer>