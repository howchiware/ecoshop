<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">

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
				<h4 class="m-0">워크샵 관리</h4>
				<div class="d-flex gap-2">
					<a class="btn btn-outline-secondary"
						href="${ctx}/admin/workshop/write">등록</a>
				</div>
			</div>

			<!-- 검색/필터 -->
			<form class="row g-2 align-items-end mb-3" method="get"
				action="${ctx}/admin/workshop/list">
				<div class="col-md-1">
					<label class="form-label"></label> <select class="form-select"
						name="schType">
						<option value="all" <c:if test="${schType=='all'}">selected</c:if>>전체</option>
						<option value="title"
							<c:if test="${schType=='title'}">selected</c:if>>제목</option>
						<option value="content"
							<c:if test="${schType=='content'}">selected</c:if>>내용</option>
					</select>
				</div>

				<div class="col-md-3">
					<label class="form-label"></label> <select class="form-select"
						name="programId">
						<option value="">프로그램 선택</option>
						<c:forEach var="p" items="${programList}">
							<option value="${p.programId}"
								<c:if test="${workshop.programId == p.programId}">selected</c:if>>${p.programTitle}</option>
						</c:forEach>
					</select>
				</div>

				<div class="col-md-2">
					<label class="form-label"></label> <select class="form-select"
						name="workshopStatus">
						<option value="">모집 현황</option>
						<option value="1"
							<c:if test="${workshopStatus == '1'}">selected</c:if>>모집
							중</option>
						<option value="0"
							<c:if test="${workshopStatus == '0'}">selected</c:if>>마감</option>
						<option value="2"
							<c:if test="${workshopStatus == '2'}">selected</c:if>>취소</option>
					</select>
				</div>

				<div class="col-md-4">
					<label class="form-label"></label> <input type="text"
						class="form-control" name="kwd" value="${kwd}"
						placeholder="">
				</div>

				<div class="col-md-1">
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
										<td class="text-center"><select
											class="form-select form-select-sm" name="workshopStatus"
											data-id="${row.workshopId}" onchange="updateStatus(this)">
												<option value="1"
													<c:if test="${row.workshopStatus == 1}">selected</c:if>>모집
													중</option>
												<option value="0"
													<c:if test="${row.workshopStatus == 0}">selected</c:if>>마감</option>
												<option value="2"
													<c:if test="${row.workshopStatus == 2}">selected</c:if>>취소</option>
										</select></td>


										<td class="text-center"><a
											href="${ctx}/admin/workshop/update?num=${row.workshopId}&page=${page}"
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

			<nav aria-label="페이지네이션">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>
	</main>
	
	<script type="text/javascript">
	function updateStatus(select) {
		const workshopId = select.getAttribute("data-id");
		const newStatus = select.value;
		
		fetch("${ctx}/admin/workshop/updateStatus", {
			method: "POST",
			headers: { "Content-Type": "application/json"},
			body: JSON.stringify({workshopId, workshopStatus: newStatus})
		})
		.then(res => res.json())
		.then(data => {
			if(data.success) {
				alert("상태가 변경되었습니다.");
			} else {
				alert("상태 변경에 실패했습니다.");
			}
		})
		.catch(err => {
			console.error(err);
			alert("상태 변경에 실패했습니다.");
		});
	}
	</script>

</body>
</html>
