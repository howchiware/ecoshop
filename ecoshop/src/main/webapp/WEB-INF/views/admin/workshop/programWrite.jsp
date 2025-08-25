<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>프로그램 등록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
	height: 30px;
	width: 51px;
}

.center-btn-container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

.main-title {
	font-weight: 600;
}

.form-control {
	margin-bottom: 20px;
}

.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<div class="container py-3"></div>

		<div class="outside">
			<div class="d-flex align-items-center justify-content-between mb-3">
				<h5 class="main-title">
					<c:choose>
						<c:when test="${mode == 'update'}">프로그램 수정</c:when>
						<c:otherwise>프로그램 등록</c:otherwise>
					</c:choose>
				</h5>
			</div>

			<hr>


			<section class="mb-4">
				<div class="row g-2 align-items-center mb-2">
					<label class="col-sm-2 col-form-label">카테고리</label>
					<div class="col-sm-3">
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
			</section>

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

				<div class="center-btn-container">
					<c:choose>
						<c:when test="${mode == 'update'}">
							<button type="submit" class="btn-manage">등록</button>
						</c:when>
						<c:otherwise>
							<button type="submit" class="btn-manage">등록</button>
						</c:otherwise>
					</c:choose>
				</div>

			</form>
		</div>

	</main>

</body>
</html>
