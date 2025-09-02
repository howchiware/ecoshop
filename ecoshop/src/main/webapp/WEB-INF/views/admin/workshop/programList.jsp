<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 목록</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">

<style>
.program-content {
	white-space: pre-wrap
}

.table {
	background-color: #fff;
	border-collapse: collapse;
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

select.form-control {
	font-size: 15px;
}

select.form-select {
	font-size: 15px;
}

.program-title {
	text-align: left;
}

.table-responsive {
	margin-top: 20px;
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

	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-4">
			<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-0">프로그램 등록</h3>
			</div>

			<hr>

			<div class="outside">
				<form class="row g-2 align-items-end mb-1" method="get"
					action="${ctx}/admin/workshop/program/list">
					<div class="col-md-2">
						<select class="form-select" name="schType">
							<option value="all"
								<c:if test="${schType=='all'}">selected</c:if>>전체</option>
							<option value="title"
								<c:if test="${schType=='title'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${schType=='content'}">selected</c:if>>내용</option>
						</select>
					</div>

					<div class="col-md-3">
						<label class="form-label"></label> <select class="form-select"
							name="categoryId">
							<option value="">카테고리 선택</option>
							<c:forEach var="c" items="${category}">
								<option value="${c.categoryId}"
									<c:if test="${categoryId == c.categoryId}">selected</c:if>>${c.categoryName}</option>
							</c:forEach>
						</select>
					</div>

					<div class="col-md-4">
						<label class="form-label"></label> <input type="text"
							class="form-control" name="kwd" value="${kwd}"
							style="height: 36.5px;">
					</div>

					<div class="col-md-1">
						<input type="hidden" name="page" value="1" />
						<button type="submit" class="btn-search">검색</button>
					</div>
				</form>

				<!-- 목록 테이블 -->
				<div class="table-responsive">
					<table class="table table-sm align-middle">
						<thead class="table-light">
							<tr>
								<th style="width: 5%;" class="text-center">번호</th>
								<th style="width: 20%;">카테고리</th>
								<th style="width: 40%;">프로그램명</th>
								<th style="width: 15%;" class="text-center">등록일</th>
								<th style="width: 20%;" class="text-center">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="5" class="text-center text-muted py-4">데이터가
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="row" items="${list}" varStatus="st">
										<tr>
											<td class="text-center"><c:out
													value="${(page-1)*size + st.index + 1}" /></td>
											<td class="text-center"><c:out
													value="${row.categoryName}" /></td>
											<td class="text-start"><a class="program-title"
												style="padding-left: 15px;"
												href="${ctx}/admin/workshop/program/detail?num=${row.programId}&page=${page}&schType=${schType}&categoryId=${categoryId}&kwd=${kwd}">
													<c:out value="${row.programTitle}" />
											</a></td>
											<td class="text-center"><fmt:formatDate
													value="${row.regDate}" pattern="yyyy-MM-dd" /></td>
											<td class="text-center">
												<form action="${ctx}/admin/workshop/program/update"
													method="get" style="display: inline;">
													<input type="hidden" name="num" value="${row.programId}">
													<input type="hidden" name="page" value="${page}">
													<button type="submit" class="btn-manage"
														style="width: 51px; height: 30px;">수정</button>
												</form>
												<form action="${ctx}/admin/workshop/program/delete"
													method="post" style="display: inline;">
													<input type="hidden" name="num" value="${row.programId}">
													<input type="hidden" name="page" value="${page}">
													<button type="submit" class="btn-manage"
														onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<div class="mt-2 text-start">
				<form action="${ctx}/admin/workshop/program/write" method="get"
					style="display: inline;">
					<button type="submit" class="btn-manage btn-register">프로그램
						등록</button>
				</form>
			</div>
		</div>

		<c:if test="${dataCount > 0}">
			<div class="page-navigation">
				<c:out value="${paging}" escapeXml="false" />
			</div>
		</c:if>

	</main>

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

</body>
</html>
