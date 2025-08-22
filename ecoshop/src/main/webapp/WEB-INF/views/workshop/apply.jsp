<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>프로그램 신청</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/workshop.css" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.page-wrap {
	background: #f6f7f8;
	min-height: 100vh;
}

.section-card {
	background: #fff;
	border: 1px solid #e9ecef;
	border-radius: 16px;
}

.section-title {
	font-weight: 700;
	font-size: 1.25rem;
	margin-top: 20px;
}

.section-card .section-title {
    margin-top: 0;
}

.kv dt {
	width: 96px;
	color: #6c757d;
}

.kv dd {
	margin-left: 0;
}

.consent-card {
	background: #fff;
	border: 1px solid #e9ecef;
	border-radius: 16px;
	padding: 20px;
}

.consent-item+.consent-item {
	border-top: 1px solid #f1f3f5;
	padding-top: 16px;
	margin-top: 16px;
}

.btn-apply {
	border-radius: 14px;
	padding: .9rem 1.2rem;
	font-weight: 700;
	width: 100%;
}

.req {
	color: #dc3545;
}
</style>
</head>
<body class="page-wrap">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<header class="border-bottom bg-white">
		<div class="container py-3">
			<p class="m-0" style="font-size: 1.2rem;">워크샵 > 신청</p>
		</div>
	</header>

	<main class="container py-4">

		<c:if test="${not empty sessionScope.msg}">
			<div class="alert alert-success">${sessionScope.msg}</div>
			<c:remove var="msg" scope="session" />
		</c:if>


		<c:set var="ws" value="${not empty dto ? dto : detail}" />

		<div class="row g-4">
			<div class="col-lg-7">
				<div class="section-card p-4 mb-4">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<div>
							<div class="text-muted">워크샵 정보</div>
							<div class="section-title">
								<c:out value="${ws.workshopTitle}" />
							</div>
						</div>
					</div>

					<dl class="kv row gy-2">
						<dt class="col-3 col-sm-2">일시</dt>
						<dd class="col-9 col-sm-10">
							<c:choose>
								<c:when test="${not empty ws.scheduleDate}">
									<fmt:formatDate value="${ws.scheduleDate}"
										pattern="yyyy.MM.dd (E) a h시" />
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</dd>

						<dt class="col-3 col-sm-2">장소</dt>
						<dd class="col-9 col-sm-10">
							<c:out value="${ws.location}" default="-" />
						</dd>

						<dt class="col-3 col-sm-2">정원</dt>
						<dd class="col-9 col-sm-10">
							<c:out value="${ws.capacity}" />
							명
						</dd>

						<dt class="col-3 col-sm-2">참가비</dt>
						<dd class="col-9 col-sm-10">무료</dd>
					</dl>
				</div>

				<form class="section-card p-4" method="post"
					action="${pageContext.request.contextPath}/workshop/submit"
					id="applyForm">
					<input type="hidden" name="workshopId"
						value="${not empty workshopId ? workshopId : ws.workshopId}">
					<input type="hidden" name="agreeMarketing" value="false"
						id="agreeMarketingHidden">

					<div class="mb-3">
						<div class="section-title mb-2">신청자 정보</div>
						<small class="text-muted">* 표시는 필수 입력</small>
					</div>

					<div class="mb-3">
						<label class="form-label">이름<span class="req"> *</span></label> 
						<input type="text" class="form-control" name="name" value="${member.name}" readonly>
						<input type="hidden" name="memberId" value="${loginMember.memberId}">
					</div>

					<div class="mb-3">
						<label class="form-label">휴대폰 번호<span class="req"> *</span></label> 
						<input type="tel" class="form-control" name="tel" value="${member.tel}">
					</div>

					<div class="mb-4">
						<label class="form-label">이메일</label> 
						<input type="email" class="form-control" name="email" value="${member.email}">
					</div>

					<div class="d-lg-none mb-3">
						<button class="btn btn-dark btn-apply" type="submit">신청하기</button>
					</div>
				</form>
			</div>

			<div class="col-lg-5">
				<div class="consent-card">
					<div class="consent-item">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="agreeTerms"
								name="agreeTerms" form="applyForm" required> <label
								class="form-check-label fw-semibold" for="agreeTerms">
								개인정보 수집·이용 동의 <span class="req">(필수)</span>
							</label>
						</div>
						<div class="small text-muted mt-2">
							수집 항목 : 이름, 연락처, 이메일<br> 이용 목적 : 프로그램 운영 및 안내<br> 보유 기간
							: 행사 종료 후 3개월
						</div>
					</div>

					<div class="consent-item">
						<div class="form-check">
							<input class="form-check-input" type="checkbox"
								id="agreeMarketing" name="agreeMarketing" value="true"
								form="applyForm"> <label
								class="form-check-label fw-semibold" for="agreeMarketing">
								사진·영상 촬영 및 마케팅 활용 동의 </label>
						</div>
						<div class="small text-muted mt-2">행사 중 촬영된 사진·영상은 홍보·마케팅에
							활용될 수 있습니다.</div>
					</div>

					<div class="consent-item">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="agreePenalty"
								required> <label class="form-check-label fw-semibold"
								for="agreePenalty"> 취소/패널티 안내 확인 <span class="req">(필수)</span>
							</label>
						</div>
						<div class="small text-muted mt-2">무단 불참 시 향후 3개월 동안 신청이 제한됩니다.</div>
					</div>

					<div class="mt-4 d-none d-lg-block">
						<button class="btn btn-dark btn-apply" type="submit"
							form="applyForm">신청하기</button>
					</div>
				</div>
			</div>
		</div>

	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script>
		(function() {
			var cb = document.getElementById('agreeMarketing');
			var hidden = document.getElementById('agreeMarketingHidden');
			if (cb && hidden) {
				cb.addEventListener('change', function() {
					hidden.disabled = cb.checked;
				});
			}
		})();
	</script>
</body>
</html>
