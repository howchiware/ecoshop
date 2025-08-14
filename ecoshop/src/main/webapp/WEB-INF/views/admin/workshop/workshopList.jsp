<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
.main-container .container {
	margin-left: 250px;
	max-width: calc(100% - 250px);
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">

			<!-- 상단 바 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4 class="m-0">워크샵 목록</h4>
				<div class="d-flex gap-2">
					<a class="btn btn-outline-secondary"
						href="${ctx}/admin/workshop/write">등록</a>
				</div>
			</div>

			<!-- 검색/필터 -->
			<form class="row g-2 align-items-end mb-3" method="get"
				action="${ctx}/admin/workshop/list">
				<div class="col-md-2">
					<label class="form-label">검색 구분</label> <select class="form-select"
						name="schType">
						<option value="all" <c:if test="${schType=='all'}">selected</c:if>>전체</option>
						<option value="title"
							<c:if test="${schType=='title'}">selected</c:if>>제목</option>
						<option value="content"
							<c:if test="${schType=='content'}">selected</c:if>>내용</option>
					</select>
				</div>

				<div class="col-md-3">
					<label class="form-label">프로그램</label> <select class="form-select"
						name="programId">
						<option value="">전체</option>
						<c:forEach var="p" items="${programList}">
							<option value="${p.programId}"
								<c:if test="${workshop.programId == p.programId}">selected</c:if>>${p.programTitle}</option>
						</c:forEach>
					</select>
				</div>

				<div class="col-md-4">
					<label class="form-label">키워드</label> <input type="text"
						class="form-control" name="kwd" value="${kwd}"
						placeholder="검색어를 입력하세요">
				</div>

				<div class="col-md-3">
					<input type="hidden" name="page" value="1" />
					<button type="submit" class="btn btn-primary w-100">검색</button>
				</div>
			</form>

			<!-- 목록 테이블 -->
			<div class="table-responsive">
				<table class="table table-sm align-middle">
					<thead class="table-light">
						<tr>
							<th style="width: 60px;" class="text-center">번호</th>
							<th style="width: 180px;">프로그램</th>
							<th>워크샵명</th>
							<th style="width: 140px;" class="text-center">일정</th>
							<th style="width: 100px;" class="text-center">정원</th>
							<th style="width: 120px;" class="text-center">상태</th>
							<th style="width: 120px;" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="7" class="text-center text-muted py-4">데이터가
										없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="row" items="${list}" varStatus="st">
									<tr>
										<td class="text-center"><c:out
												value="${(page-1)*size + st.index + 1}" /></td>
										<td><c:out value="${row.programTitle}" /></td>
										<td><a
											href="${ctx}/admin/workshop/detail?num=${row.workshopId}">
												${row.workshopTitle} </a></td>

										<td class="text-center"><fmt:formatDate
												value="${row.scheduleDate}" pattern="yyyy.MM.dd" /></td>
										<td class="text-center">${row.capacity}</td>
										<td class="text-center"><c:choose>
												<c:when test="${row.workshopStatus == 1}">모집</c:when>
												<c:when test="${row.workshopStatus == 0}">마감</c:when>
												<c:when test="${row.workshopStatus == 2}">취소</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose></td>

										<td class="text-center"><a
											href="${ctx}/admin/workshop/workshop/update?num=${row.workshopId}&page=${page}"
											class="btn btn-sm btn-primary">수정</a>
											<form action="${ctx}/admin/workshop/delete" method="post"
												style="display: inline;">
												<input type="hidden" name="num" value="${row.workshopId}">
												<input type="hidden" name="page" value="${page}">
												<button type="submit" class="btn btn-sm btn-danger"
													onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
											</form></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 -->
			<c:set var="hasPrev" value="${page > 1}" />
			<c:set var="hasNext" value="${not empty list && list.size() >= size}" />
			<nav aria-label="페이지네이션">
				<ul class="pagination justify-content-center">
					<li class="page-item <c:if test='${!hasPrev}'>disabled</c:if>'">
						<a class="page-link"
						href="${ctx}/admin/workshop/list?page=${page-1}&schType=${schType}&kwd=${kwd}&programId=${programId}">이전</a>
					</li>
					<li class="page-item active"><span class="page-link">${page}</span></li>
					<li class="page-item <c:if test='${!hasNext}'>disabled</c:if>'">
						<a class="page-link"
						href="${ctx}/admin/workshop/list?page=${page+1}&schType=${schType}&kwd=${kwd}&programId=${programId}">다음</a>
					</li>
				</ul>
			</nav>

		</div>
	</main>

</body>
</html>
