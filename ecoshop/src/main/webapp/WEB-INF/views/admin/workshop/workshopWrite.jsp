<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<c:choose>
	<c:when test="${mode eq 'update'}">
		<title>워크샵 수정</title>
	</c:when>
	<c:otherwise>
		<title>워크샵 등록</title>
	</c:otherwise>
</c:choose>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">

<style>
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">
			<c:if test="${mode eq 'update'}">
				<fmt:formatDate value="${dto.scheduleDate}"
					pattern="yyyy-MM-dd'T'HH:mm" var="formattedScheduleDate" />
				<fmt:formatDate value="${dto.applyDeadline}"
					pattern="yyyy-MM-dd'T'HH:mm" var="formattedApplyDeadline" />
			</c:if>

			<form id="workshopForm" method="post"
				<c:choose>
					<c:when test="${mode eq 'update'}">action="${ctx}/admin/workshop/update"</c:when>
					<c:otherwise>action="${ctx}/admin/workshop/write"</c:otherwise>
				</c:choose>
				enctype="multipart/form-data">

				<c:if test="${mode eq 'update'}">
					<input type="hidden" name="workshopId" value="${dto.workshopId}">
					<input type="hidden" name="page" value="${page}">
				</c:if>

				<div class="outside">
					<h5 class="section-title">기본 정보</h5>
					<table class="form-table">
						<tbody>
							<tr>
								<th>워크샵명</th>
								<td><input type="text" name="workshopTitle" class="form-control"
									required value="${dto.workshopTitle}"></td>
							</tr>
							<tr>
								<th>프로그램</th>
								<td>
									<select name="programId" class="form-select" required>
										<option value="">프로그램 선택</option>
										<c:forEach var="p" items="${programList}">
											<option value="${p.programId}"
												<c:if test="${dto.programId == p.programId}">selected</c:if>>
												${p.programTitle}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td>
									<select name="managerId" class="form-select" required>
										<option value="">담당자 선택</option>
										<c:forEach var="m" items="${managerList}">
											<option value="${m.managerId}"
												<c:if test="${dto.managerId == m.managerId}">selected</c:if>>
												${m.name} (${m.department})</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</tbody>
					</table>

					<h5 class="section-title">운영 정보</h5>
					<table class="form-table">
						<tbody>
							<tr>
								<th>정원</th>
								<td><input type="number" name="capacity" class="form-control"
									required value="${dto.capacity}"></td>
							</tr>
							<tr>
								<th>일시</th>
								<td><input type="datetime-local" name="scheduleDate"
									class="form-control" required
									<c:if test="${mode eq 'update'}">value="${formattedScheduleDate}"</c:if>></td>
							</tr>
							<tr>
								<th>장소</th>
								<td><input type="text" name="location" class="form-control"
									value="${dto.location}"></td>
							</tr>
							<tr>
								<th>모집 상태</th>
								<td>
									<select name="workshopStatus" class="form-select">
										<option value="1" <c:if test='${dto.workshopStatus == 1}'>selected</c:if>>모집</option>
										<option value="0" <c:if test='${dto.workshopStatus == 0}'>selected</c:if>>마감</option>
										<option value="2" <c:if test='${dto.workshopStatus == 2}'>selected</c:if>>취소</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>마감 일시</th>
								<td><input type="datetime-local" name="applyDeadline"
									class="form-control" required
									<c:if test="${mode eq 'update'}">value="${formattedApplyDeadline}"</c:if>></td>
							</tr>
						</tbody>
					</table>

					<h5 class="section-title">콘텐츠</h5>
					<table class="form-table">
						<tbody>
							<tr>
								<th>대표 사진</th>
								<td>
									<input type="file" name="thumbnail" class="form-control">
									<c:if test="${mode eq 'update' && not empty dto.thumbnailPath}">
										<small class="text-muted">현재: ${dto.thumbnailPath}</small>
									</c:if>
								</td>
							</tr>
							<tr>
								<th>워크샵 내용</th>
								<td>
									<textarea name="workshopContent" rows="10" class="form-control">${dto.workshopContent}</textarea>
								</td>
							</tr>
							<tr>
								<th>상세 이미지</th>
								<td><input type="file" name="photos" class="form-control" multiple></td>
							</tr>
							<c:if test="${mode eq 'update' && not empty photoList}">
								<tr>
									<th>등록된 이미지</th>
									<td>
										<div class="d-flex flex-wrap gap-3">
											<c:forEach var="p" items="${photoList}">
												<div class="border rounded p-2" style="width: 140px">
													<img src="${p.workshopImagePath}" class="img-fluid rounded" alt="photo">
													<div class="form-check mt-2">
														<input class="form-check-input" type="checkbox"
															name="deletePhotoIds" value="${p.photoId}"
															id="del-${p.photoId}">
														<label class="form-check-label small" for="del-${p.photoId}">삭제하기</label>
													</div>
												</div>
											</c:forEach>
										</div>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>

					<div class="center-btn-container">
						<c:choose>
							<c:when test="${mode eq 'update'}">
								<button type="submit" class="btn-search">수정</button>
							</c:when>
							<c:otherwise>
								<button type="submit" class="btn-search">등록</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>
		</div>
	</main>
</body>
</html>
