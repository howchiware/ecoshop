<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 등록</title>
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

			<form id="workshopForm" method="post"
				action="${ctx}/admin/workshop/write" enctype="multipart/form-data">

				<!-- 기본 정보 -->
				<h5 class="mt-4">| 기본 정보</h5>
				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">워크샵명</label>
					<div class="col-sm-6">
						<input type="text" name="workshopTitle" class="form-control"
							required>
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">프로그램</label>
					<div class="col-sm-6">
						<select name="programId" class="form-select" required>
							<option value="">프로그램 선택</option>
							<c:forEach var="p" items="${programList}">
								<option value="${p.programId}">${p.programTitle}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">담당자</label>
					<div class="col-sm-6">
						<select name="managerId" class="form-select" required>
							<option value="">담당자 선택</option>
							<c:forEach var="m" items="${managerList}">
								<option value="${m.managerId}">${m.name}
									(${m.department})</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<!-- 운영 정보 -->
				<h5 class="mt-4">| 운영 정보</h5>
				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">일시</label>
					<div class="col-sm-3">
						<input type="date" name="scheduleDate" class="form-control"
							required>
					</div>
					<div class="col-sm-3">
						<input type="time" name="scheduleTime" class="form-control"
							required>
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">장소</label>
					<div class="col-sm-6">
						<input type="text" name="location" class="form-control">
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">모집 상태</label>
					<div class="col-sm-3">
						<select name="workshopStatus" class="form-select">
							<option value="1">모집</option>
							<option value="0">마감</option>
							<option value="2">취소</option>
						</select>
					</div>
					<div class="col-sm-3">
						<input type="date" name="applyDeadlineDate" class="form-control"
							required>
					</div>
					<div class="col-sm-2">
						<input type="time" name="applyDeadlineTime" class="form-control"
							required>
					</div>
				</div>

				<!-- 콘텐츠 -->
				<h5 class="mt-4">| 콘텐츠</h5>
				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">대표 사진</label>
					<div class="col-sm-6">
						<input type="file" name="thumbnail" class="form-control">
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">워크샵 내용</label>
					<div class="col-sm-8">
						<textarea name="workshopContent" rows="5" class="form-control"></textarea>
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2 col-form-label">상세 이미지</label>
					<div class="col-sm-6">
						<input type="file" name="photos" class="form-control mb-1"
							multiple> <small class="text-muted">여러 장 선택하려면
							Ctrl 또는 Cmd 키를 누른 상태로 클릭하세요.</small>
					</div>
				</div>

				<!-- 버튼 -->
				<div class="row">
					<div class="col-sm-10 offset-sm-2">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-secondary">수정</button>
					</div>
				</div>

			</form>
		</div>

	</main>

</body>
</html>
