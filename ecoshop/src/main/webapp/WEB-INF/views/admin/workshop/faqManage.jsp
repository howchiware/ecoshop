<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">

<style>
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

			<div class="outside">
				<form method="get" action="${ctx}/admin/workshop/faq/manage">
					<div class="d-flex align-items-center mb-3">
						<select name="programId" class="form-select w-auto"
							onchange="this.form.submit()">
							<option value="">프로그램 선택</option>
							<c:forEach var="p" items="${programList}">
								<option value="${p.programId}"
									<c:if test="${p.programId == programId}">selected</c:if>>
									<c:out value="${p.programTitle}" />
								</option>
							</c:forEach>
						</select>
					</div>
				</form>

				<div class="accordion" id="faqAccordion">
					<c:choose>
						<c:when test="${empty faqList}">
							<div class="text-center text-muted py-4">등록된 FAQ가 없습니다.</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="faq" items="${faqList}" varStatus="st">
								<div class="accordion-item">
									<h2 class="accordion-header" id="faq-${faq.faqId}-header">
										<button class="accordion-button collapsed d-flex gap-2"
											type="button" data-bs-toggle="collapse"
											data-bs-target="#faq-${faq.faqId}-collapse"
											aria-expanded="false"
											aria-controls="faq-${faq.faqId}-collapse">
											<span class="faq-number small"> ${ (page - 1) * size + st.index + 1 }
											</span> <span class="fw-semibold flex-grow-1 text-start"> <span
												class="fw-bold text-dark me-2">Q.</span> <c:out
													value="${faq.question}" />
											</span>

										</button>
									</h2>
									<div id="faq-${faq.faqId}-collapse"
										class="accordion-collapse collapse"
										aria-labelledby="faq-${faq.faqId}-header"
										data-bs-parent="#faqAccordion">
										<div
											class="accordion-body d-flex justify-content-between align-items-start">
											<div class="me-3 ms-3 flex-grow-1 d-flex">
												<span class="fw-bold text-success me-2">A.</span>
												<div>
													<c:out value="${faq.answer}" />
												</div>
											</div>


											<div class="d-flex gap-1">
												<button type="button" class="btn-manage"
													data-bs-toggle="modal" data-bs-target="#faqModal"
													data-id="${faq.faqId}"
													data-question="${fn:escapeXml(faq.question)}"
													data-answer="${fn:escapeXml(faq.answer)}"
													data-program="${faq.programId}">수정</button>
												<form method="post"
													action="${ctx}/admin/workshop/faq/delete" class="d-inline"
													onsubmit="return confirm('삭제하시겠습니까?');">
													<input type="hidden" name="faqId" value="${faq.faqId}">
													<input type="hidden" name="programId" value="${programId}">
													<button type="submit" class="btn-manage">삭제</button>
												</form>
											</div>
										</div>

									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

			</div>

			<div class="mt-2 text-start">
				<button class="btn-manage btn-register" data-bs-toggle="modal"
					data-bs-target="#faqModal">FAQ 등록</button>
			</div>

			<c:if test="${dataCount > 0}">
				<div class="page-navigation">
					<c:out value="${paging}" escapeXml="false" />
				</div>
			</c:if>

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
							<label class="form-label">프로그램 선택</label> <select
								class="form-select" name="programId" id="programId" required>
								<c:forEach var="p" items="${programList}">
									<option value="${p.programId}"><c:out
											value="${p.programTitle}" /></option>
								</c:forEach>
							</select>
							<div class="form-text text-muted">&nbsp;FAQ는 선택한 워크샵의 상세
								페이지에 공통 노출됩니다.</div>
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
						<button type="submit" class="btn-submit">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		const faqModal = document.getElementById('faqModal');
		if (faqModal) {
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
									// 수정 모드
									modalTitle.textContent = 'FAQ 수정';
									form.action = '${ctx}/admin/workshop/faq/update';
									faqModal.querySelector('#faqId').value = faqId;
									faqModal.querySelector('#question').value = question;
									faqModal.querySelector('#answer').value = answer;
									faqModal.querySelector('#programId').value = programId;
								} else {
									// 등록 모드
									modalTitle.textContent = 'FAQ 등록';
									form.action = '${ctx}/admin/workshop/faq/write';
									form.reset();
									faqModal.querySelector('#faqId').value = '';
									faqModal.querySelector('#programId').selectedIndex = 0;
								}
							});
		}
	</script>

</body>
</html>
