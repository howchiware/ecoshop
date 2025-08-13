<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 등록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">

			<!-- 카테고리 섹션 (별도 폼) -->
			<section class="mb-4">
				<h4>| 카테고리</h4>

				<div class="row g-2 align-items-center mb-2">
					<label class="col-sm-2 col-form-label">카테고리</label>
					<div class="col-sm-6">
						<select name="categoryId" id="categoryId" class="form-select"
							form="programForm" required>
							<option value="" disabled>카테고리 선택</option>
							<c:forEach var="c" items="${category}">
								<option value="${c.categoryId}"
									<c:if test="${mode == 'update' && c.categoryId == dto.categoryId}">selected</c:if>>
									${c.categoryName}</option>
							</c:forEach>
						</select>

					</div>
				</div>

				<!-- 새 카테고리 추가 폼 -->
				<form method="post" action="${ctx}/admin/workshop/program/category"
					class="row g-2 align-items-center">
					<label class="col-sm-2 col-form-label">새 카테고리</label>
					<div class="col-sm-6">
						<input type="text" name="categoryName" class="form-control"
							required />
					</div>
					<div class="col-sm-2">
						<button type="submit" class="btn btn-outline-secondary w-100">추가</button>
					</div>
				</form>
			</section>

			<!-- 프로그램 등록 폼 -->
			<section>
				<h4>| 기본 정보</h4>
				<form id="programForm" method="post"
					action="${ctx}/admin/workshop/program/${mode}">
					<c:if test="${mode == 'update'}">
						<input type="hidden" name="programId" value="${dto.programId}">
						<input type="hidden" name="page" value="${page}">
					</c:if>

					<div class="row g-2 align-items-center mb-2">
						<label class="col-sm-2 col-form-label">프로그램명</label>
						<div class="col-sm-8">
							<input type="text" name="programTitle" class="form-control"
								value="${dto.programTitle}" required />
						</div>
					</div>

					<div class="row g-2 mb-3">
						<label class="col-sm-2 col-form-label">프로그램 내용</label>
						<div class="col-sm-8">
							<textarea name="programContent" rows="8" class="form-control">${dto.programContent}</textarea>
						</div>
					</div>

					<div class="row g-2">
						<div class="col-sm-10 offset-sm-2">
							<c:choose>
								<c:when test="${mode == 'update'}">
									<button type="submit" class="btn btn-secondary me-2">수정</button>
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary">등록</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

				</form>
			</section>

		</div>
	</main>

</body>
</html>
