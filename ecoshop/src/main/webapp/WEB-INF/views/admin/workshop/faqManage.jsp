<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>FAQ 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	box-sizing: border-box;
}

@font-face {
	font-family: 'Pretendard';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

body {
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

.main-container {
	position: relative;
	margin-left: 250px; /* 사이드바 너비 */
	padding: 20px;
	min-height: calc(100vh - 60px);
	background-color: #f9f9f9;
	font-size: 15px;
}

select.form-control {
	font-size: 15px;
}

select.form-select {
	font-size: 15px;
}

/* 공통 카드 */
.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

/* 표 */
.table {
	background-color: #fff;
}

.table thead th {
	background-color: #f8f9fa;
	font-weight: 500;
	text-align: center;
}

.table td {
	vertical-align: middle;
	background-color: #fff;
}

.table tbody tr:hover {
	background-color: #fdfdfd;
}

/* 버튼 */
.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
}

.btn-submit {
	background: #000;
	color: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
}

.modal-backdrop { z-index: 9998 !important; }
.modal { z-index: 9999 !important; }


</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="container py-4">

			<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-0">FAQ 관리</h3>
			</div>

			<hr>
			
			<div class="d-flex justify-content-end mb-2">
				<button class="btn-manage btn-register" data-bs-toggle="modal"
					data-bs-target="#faqModal">등록</button>
			</div>

			<div class="outside">
			<form method="get" action="${ctx}/admin/workshop/faq/manage">
				<div class="d-flex align-items-center mb-3">
					<!-- <label class="me-3 mb-0 fw-semibold" style="white-space: nowrap;">워크샵명</label> -->
					<select name="programId" class="form-select w-auto"
						onchange="this.form.submit()">
						<option value="">워크샵 선택</option>
						<c:forEach var="p" items="${programList}">
							<option value="${p.programId}"
								<c:if test="${p.programId == programId}">selected</c:if>>
								<c:out value="${p.programTitle}" />
							</option>
						</c:forEach>
					</select>
				</div>
			</form>
			
				<table class="table table-sm align-middle">
					<thead class="table-light">
						<tr>
							<th style="width: 7%">번호</th>
							<th style="width: 30%">질문</th>
							<th>답변</th>
							<th style="width: 15%">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty faqList}">
								<tr>
									<td colspan="4" class="text-center text-muted py-4">등록된
										FAQ가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="faq" items="${faqList}" varStatus="st">
									<tr>
										<td class="text-center">${st.count}</td>
										<td><c:out value="${faq.question}" /></td>
										<td><c:out value="${faq.answer}" /></td>
										<td class="text-center">
											<button type="button" class="btn-manage"
												data-bs-toggle="modal" data-bs-target="#faqModal"
												data-id="${faq.faqId}" data-question="${faq.question}"
												data-answer="${faq.answer}" data-program="${faq.programId}">
												수정</button>
											<form method="post" action="${ctx}/admin/workshop/faq/delete"
												class="d-inline" onsubmit="return confirm('삭제하시겠습니까?');">
												<input type="hidden" name="faqId" value="${faq.faqId}">
												<input type="hidden" name="programId" value="${programId}">
												<button type="submit" class="btn-manage">삭제</button>
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>

			<nav aria-label="페이징">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>
	</main>

	<div class="modal fade" id="faqModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<form method="post" action="${ctx}/admin/workshop/faq/write">
					<div class="modal-header">
						<h5 class="modal-title fw-bold">FAQ 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="faqId" id="faqId">
						<div class="mb-3">
							<label class="form-label">워크샵 선택</label> <select
								class="form-select" name="programId" id="programId" required>
								<c:forEach var="p" items="${programList}">
									<option value="${p.programId}"><c:out
											value="${p.programTitle}" /></option>
								</c:forEach>
							</select>
							<div class="form-text text-muted">&nbsp;FAQ는 선택한 워크샵의 상세 페이지에 공통
								노출됩니다.</div>
						</div>
						<div class="mb-3">
							<label class="form-label">질문</label> <input type="text"
								class="form-control" name="question" id="question"
								maxlength="1000" required>
						</div>
						<div class="mb-3">
							<label class="form-label">답변</label>
							<textarea class="form-control" name="answer" id="answer" rows="5"
								maxlength="2000" required></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn-submit">저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// 수정 버튼 눌렀을 때 모달 데이터 바인딩
		const faqModal = document.getElementById('faqModal');
		faqModal
				.addEventListener(
						'show.bs.modal',
						function(event) {
							const button = event.relatedTarget;
							const faqId = button ? button
									.getAttribute('data-id') : null;
							const question = button ? button
									.getAttribute('data-question') : '';
							const answer = button ? button
									.getAttribute('data-answer') : '';
							const programId = button ? button
									.getAttribute('data-program') : '';

							const modalTitle = faqModal
									.querySelector('.modal-title');
							const form = faqModal.querySelector('form');

							if (faqId) {
								modalTitle.innerHTML = 'FAQ 수정';
								form.action = '${ctx}/admin/workshop/faq/update';
								faqModal.querySelector('#faqId').value = faqId;
								faqModal.querySelector('#question').value = question;
								faqModal.querySelector('#answer').value = answer;
								faqModal.querySelector('#programId').value = programId;
							} else {
								modalTitle.innerHTML = 'FAQ 등록';
								form.action = '${ctx}/admin/workshop/faq/write';
								form.reset();
								faqModal.querySelector('#faqId').value = '';
								faqModal.querySelector('#programId').selectedIndex = 0;
							}
						});
	</script>

</body>
</html>
