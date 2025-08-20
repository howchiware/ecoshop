<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
.main-container .container {
	margin-left: 250px;
	max-width: calc(100% - 250px);
}

.program-content {
	white-space: pre-wrap
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
				<h4 class="m-0">프로그램 관리</h4>
				<div class="d-flex gap-2">
					<a class="btn btn-outline-secondary"
						href="${ctx}/admin/workshop/program/write">등록</a>
				</div>
			</div>

			<!-- 필터/검색 -->
			<form class="row g-2 align-items-end mb-3" method="get"
				action="${ctx}/admin/workshop/program/list">
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
						name="categoryId">
						<option value="">카테고리 선택</option>
						<c:forEach var="c" items="${category}">
							<option value="${c.categoryId}"
								<c:if test="${categoryId == c.categoryId}">selected</c:if>>
								${c.categoryName}</option>
						</c:forEach>
					</select>
				</div>

				<div class="col-md-4">
					<label class="form-label"></label> <input type="text"
						class="form-control" name="kwd" value="${kwd}">
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
							<th style="width: 80px;" class="text-center">번호</th>
							<th style="width: 160px;">카테고리</th>
							<th>프로그램명</th>
							<th style="width: 160px;" class="text-center">등록일</th>
							<th style="width: 120px;" class="text-center">관리</th>
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
										<td><c:out value="${row.categoryName}" /></td>
										<td><a href="javascript:void(0);" class="program-title"
											data-id="${row.programId}"> <c:out
													value="${row.programTitle}" />
										</a></td>
										<td class="text-center"><fmt:formatDate
												value="${row.regDate}" pattern="yyyy-MM-dd" /></td>
										<td class="text-center"><a
											href="${ctx}/admin/workshop/program/update?num=${row.programId}&page=${page}"
											class="btn btn-sm btn-primary">수정</a>
											<form action="${ctx}/admin/workshop/program/delete"
												method="post" style="display: inline;">
												<input type="hidden" name="num" value="${row.programId}">
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

			<!-- 페이징 -->
			<nav aria-label="페이지네이션">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>
	</main>

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script type="text/javascript">
	$(function() {
		$(".program-title").click(function(){
			let programId = $(this).data("id");
			let $row = $(this).closest("tr");
			
			// 열려 있으면 닫기
			if($row.next().hasClass("program-detail")) {
				$row.next().remove();
				return;
			}
			
			// 기존 열린 상세 닫기
			$(".program-detail").remove();
			
			$.ajax({
				url: "${ctx}/admin/workshop/program/detail",
				type: "GET",
				dataType: "json",
				data: { programId: programId },
				success: function(data) {
					console.log('resp:', data);
				    const content = data?.programContent || "<em class='text-muted'>내용 없음</em>";
				    const detailRow = 
				        '<tr class="program-detail">' +
				          '<td colspan="4" class="bg-light p-3">' +
				            '<div class="program-content">' + content + '</div>' +
				          '</td>' +
				        '</tr>';
				      $row.after(detailRow);
				},
				error: function() {
					alert("프로그램 정보를 불러오지 못했습니다.");
				}
			});
		});
	});
	
	</script>

</body>
</html>
