<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담당자 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

.main-container {
  position: relative;
  margin-left: 250px; /* 사이드바 너비만큼 띄우기 */
  padding: 20px;
  box-sizing: border-box;
  min-height: calc(100vh - 60px);
  background-color: #f9f9f9;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="container py-3">

			<h4 class="mb-4 d-flex justify-content-between align-items-center">
				<span>담당자 관리</span>
				<!-- 등록 버튼 -->
				<button type="button" class="btn btn-success"
					data-bs-toggle="modal" data-bs-target="#managerModal"
					onclick="openManagerModal('write')">
					등록
				</button>
			</h4>

			<!-- 검색 폼 -->
			<form class="row g-2 align-items-end mb-3" method="get"
				action="${ctx}/admin/workshop/manager/list">
				<div class="col-md-1">
					<label class="form-label"></label>
					<select class="form-select" name="schType">
						<option value="all" <c:if test="${schType=='all'}">selected</c:if>>전체</option>
						<option value="name" <c:if test="${schType=='name'}">selected</c:if>>이름</option>
						<option value="department" <c:if test="${schType=='department'}">selected</c:if>>소속</option>
					</select>
				</div>
				<div class="col-md-3">
					<label class="form-label"></label>
					<input type="text" name="kwd" value="${kwd}" class="form-control">
				</div>
				<div class="col-md-1">
					<input type="hidden" name="page" value="1">
					<button type="submit" class="btn btn-primary w-100">검색</button>
				</div>
			</form>

			<!-- 목록 -->
			<div class="table-responsive">
				<table class="table table-sm align-middle">
					<thead class="table-light">
						<tr>
							<th class="text-center" style="width: 80px;">번호</th>
							<th style="width: 150px;">이름</th>
							<th style="width: 150px;">전화번호</th>
							<th style="width: 200px;">이메일</th>
							<th style="width: 150px;">소속</th>
							<th class="text-center" style="width: 120px;">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="6" class="text-center text-muted py-4">등록된 담당자가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="row" items="${list}" varStatus="st">
									<tr>
										<td class="text-center">${(page-1)*size + st.index + 1}</td>
										<td>${row.name}</td>
										<td>${row.tel}</td>
										<td>${row.email}</td>
										<td>${row.department}</td>
										<td class="text-center">
											<button type="button" class="btn btn-sm btn-primary"
												data-bs-toggle="modal" data-bs-target="#managerModal"
												onclick="openManagerModal('update',
													'${row.managerId}','${row.name}',
													'${row.tel}','${row.email}','${row.department}')">
												수정
											</button>
											<form action="${ctx}/admin/workshop/manager/delete" method="post" style="display:inline;">
												<input type="hidden" name="num" value="${row.managerId}">
												<input type="hidden" name="page" value="${page}">
												<button type="submit" class="btn btn-sm btn-danger"
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

			<!-- 페이징 -->
			<nav aria-label="페이징">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>
	</main>

	<!-- 담당자 등록/수정 모달 -->
	<div class="modal fade" id="managerModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle">담당자 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<form id="managerForm" action="${ctx}/admin/workshop/manager/write" method="post">
						<input type="hidden" id="managerId" name="managerId">
						<table class="table table-borderless align-middle">
							<tr>
								<th style="width: 120px;">이름</th>
								<td><input type="text" id="name" name="name" class="form-control" required></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="text" id="tel" name="tel" class="form-control" required></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" id="email" name="email" class="form-control" required></td>
							</tr>
							<tr>
								<th>소속</th>
								<td><input type="text" id="department" name="department" class="form-control"></td>
							</tr>
						</table>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" id="submitBtn" form="managerForm" class="btn btn-success">등록</button>
				</div>

			</div>
		</div>
	</div>

	<script>
	function openManagerModal(mode, id='', name='', tel='', email='', department='') {
		const form = document.getElementById("managerForm");
		const modalTitle = document.getElementById("modalTitle");
		const submitBtn = document.getElementById("submitBtn");

		if (mode === 'write') {
			modalTitle.innerText = "담당자 등록";
			submitBtn.innerText = "등록";
			submitBtn.className = "btn btn-success";
			form.action = "${ctx}/admin/workshop/manager/write";
			document.getElementById("managerId").value = '';
			document.getElementById("name").value = '';
			document.getElementById("tel").value = '';
			document.getElementById("email").value = '';
			document.getElementById("department").value = '';
		} else {
			modalTitle.innerText = "담당자 수정";
			submitBtn.innerText = "수정";
			submitBtn.className = "btn btn-primary";
			form.action = "${ctx}/admin/workshop/manager/update";
			document.getElementById("managerId").value = id;
			document.getElementById("name").value = name;
			document.getElementById("tel").value = tel;
			document.getElementById("email").value = email;
			document.getElementById("department").value = department;
		}
	}
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
