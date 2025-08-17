<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>FAQ ${mode eq 'update' ? '수정' : '등록'}</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
.main-container .container {
	margin-left: 250px;
	max-width: calc(100% - 250px);
}

.form-wrap {
	max-width: 900px;
}

.form-row {
	margin: 12px 0;
}

.form-row label {
	display: block;
	font-weight: 600;
	margin-bottom: 6px;
}

.form-row input[type="text"], .form-row select, .form-row textarea {
	width: 100%;
	box-sizing: border-box;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 6px;
}

.form-actions {
	margin-top: 20px;
	display: flex;
	gap: 8px;
}

.btn {
	padding: 10px 16px;
	border-radius: 6px;
	border: 1px solid #ddd;
	background: #fff;
	cursor: pointer;
}

.btn.primary {
	background: #222;
	color: #fff;
	border-color: #222;
}

.btn.link {
	background: transparent;
	border: none;
	color: #007bff;
	text-decoration: underline;
	padding: 0;
}

.note {
	color: #777;
	font-size: 0.9rem;
}
</style>
</head>
<body>

	<!-- 관리자 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<!-- 관리자 공통 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3 form-wrap">
			<h3>FAQ ${mode eq 'update' ? '수정' : '등록'}</h3>

			<!-- action URL 구성 -->
			<c:choose>
				<c:when test="${mode eq 'update'}">
					<c:url var="formAction" value="/admin/workshop/faq/update" />
				</c:when>
				<c:otherwise>
					<c:url var="formAction" value="/admin/workshop/faq/write" />
				</c:otherwise>
			</c:choose>

			<!-- 선택된 프로그램 ID 계산 (update 시 dto.programId, write 시 요청 파라미터 programId) -->
			<c:set var="selectedProgramId"
				value="${not empty dto ? dto.programId : programId}" />
			<c:set var="currPage"
				value="${empty page ? (empty param.page ? 1 : param.page) : page}" />

			<form method="post" action="${formAction}">
				<!-- 수정인 경우 faqId 포함 -->
				<c:if test="${mode eq 'update'}">
					<input type="hidden" name="faqId" value="${dto.faqId}">
				</c:if>
				<!-- 목록 복귀용 page 유지 -->
				<input type="hidden" name="page" value="${currPage}">

				<!-- 프로그램 선택 -->
				<div class="form-row">
					<label for="programId">프로그램</label> <select id="programId"
						name="programId" required>
						<c:forEach var="p" items="${programList}">
							<option value="${p.programId}"
								<c:if test="${p.programId == selectedProgramId}">selected</c:if>>
								<c:out value="${p.programTitle}" />
							</option>
						</c:forEach>
					</select>
					<div class="note">이 FAQ는 선택한 프로그램에 속한 모든 워크샵 상세에서 공통으로 노출됩니다.</div>
				</div>

				<!-- 질문 -->
				<div class="form-row">
					<label for="question">질문</label> <input type="text" id="question"
						name="question" maxlength="1000" required
						value="<c:out value='${not empty dto ? dto.question : ""}'/>">
				</div>

				<!-- 답변 -->
				<div class="form-row">
					<label for="answer">답변</label>
					<textarea id="answer" name="answer" rows="8" maxlength="2000"
						required><c:out
							value='${not empty dto ? dto.answer : ""}' /></textarea>
				</div>

				<div class="form-actions">
					<button type="submit" class="btn primary">${mode eq 'update' ? '수정' : '등록'}</button>
					<a class="btn"
						href="${ctx}/admin/workshop/faq/list?programId=${selectedProgramId}&page=${currPage}">목록</a>
				</div>
			</form>

			<!-- 프로그램이 하나도 없을 때 안내 -->
			<c:if test="${empty programList}">
				<p class="note" style="margin-top: 16px;">
					등록된 프로그램이 없습니다. 먼저 프로그램을 생성해 주세요. <a class="btn link"
						href="${ctx}/admin/workshop/program/write">프로그램 등록하기</a>
				</p>
			</c:if>
		</div>
	</main>

</body>
</html>
