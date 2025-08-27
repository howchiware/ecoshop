<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>워크샵 목록</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	box-sizing: border-box;
}

@font-face {
	font-family: 'Pretendard';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

body {
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
}

.btn-search {
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
	margin-bottom: 5px;
}

.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

.main-container {
	font-size: 15px;
}

select.form-control {
	font-size: 15px;
}

select.form-select {
	font-size: 15px;
}

.table {
	background-color: #fff;
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

.table .btn {
	margin: 0 2px;
}

.text-padding-start {
	padding-left: 20px;
}
</style>
</head>
<body>


	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-4">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h3 class="m-0">워크샵 관리</h3>
			</div>

			<hr>

			<div class="outside">
				<form class="row g-2 align-items-end mb-3" method="get"
					action="${ctx}/admin/workshop/list">
					<div class="col-md-2">
						<label class="form-label"></label> <select class="form-select"
							name="schType">
							<option value="all"
								<c:if test="${schType=='all'}">selected</c:if>>전체</option>
							<option value="title"
								<c:if test="${schType=='title'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${schType=='content'}">selected</c:if>>내용</option>
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
							style="height: 36.5px;">
					</div>

					<div class="col-md-1">
						<input type="hidden" name="page" value="1" />
						<button type="submit" class="btn-search">검색</button>
					</div>
				</form>

				<div class="table-responsive">
					<table class="table table-sm align-middle">
						<thead class="table-light">
							<tr>
								<th style="width: 6%;" class="text-center">번호</th>
								<th style="width: 28%;">프로그램</th>
								<th style="width: 34%;">워크샵명</th>
								<th style="width: 11%;" class="text-center">일정</th>
								<th style="width: 8%;" class="text-center">정원</th>
								<th style="width: 11%;" class="text-center">상태</th>
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
											<td class="text-center"><c:out
													value="${row.programTitle}" /></td>
											<td class="text-padding-start"><a
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
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<div class="mt-2 text-start">
				<form action="${ctx}/admin/workshop/write" method="get">
					<button type="submit" class="btn-manage btn-register">워크샵
						등록</button>
				</form>
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
