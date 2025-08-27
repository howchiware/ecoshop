<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>카테고리 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">

<style>
.table {
	background-color: #fff;
	border-collapse: collapse;
}

.table thead th {
	background-color: #f8f9fa;
	font-weight: 600;
	text-align: center;
}

.table td {
	vertical-align: middle;
	background-color: #ffffff;
}

.table tbody tr:hover {
	background-color: #fdfdfd;
}

.table .btn {
	margin: 0 2px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="container py-4">

			<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-0">카테고리 관리</h3>
			</div>

			<hr>

			<!-- 카테고리 목록 -->
			<div class="outside">
				<table class="table table-sm align-middle">
					<thead class="table-light">
						<tr>
							<th style="width: 7%">번호</th>
							<th>카테고리명</th>
							<th style="width: 14%">상태</th>
							<th style="width: 20%">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty categoryList}">
								<tr>
									<td colspan="4" class="text-center text-muted py-4">등록된
										카테고리가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="c" items="${categoryList}" varStatus="st">
									<tr>
										<td class="text-center">${st.count}</td>
										<td class="text-center"><c:out value="${c.categoryName}" /></td>

										<td class="text-center"><select
											class="form-select form-select-sm category-status d-inline-block"
											style="width: 110px" data-id="${c.categoryId}">
												<option value="1" ${c.isActive == 1 ? 'selected' : ''}>활성</option>
												<option value="0" ${c.isActive == 0 ? 'selected' : ''}>비활성</option>
										</select></td>

										<td class="text-center">
											<button type="button" class="btn-manage"
												data-bs-toggle="modal" data-bs-target="#categoryModal"
												data-id="${c.categoryId}" data-name="${c.categoryName}"
												data-active="${c.isActive}">수정</button>

											<form method="post"
												action="${ctx}/admin/workshop/category/delete"
												class="d-inline" onsubmit="return confirm('삭제하시겠습니까?');">
												<input type="hidden" name="categoryId"
													value="${c.categoryId}">
												<button type="submit" class="btn-manage">삭제</button>
											</form>
										</td>
									</tr>

								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>

			<div class="mt-2 text-start">
				<button class="btn-manage btn-register" data-bs-toggle="modal"
					data-bs-target="#categoryModal">카테고리 등록</button>
			</div>

			<c:if test="${dataCount > 0}">
				<div class="page-navigation">
					<c:out value="${paging}" escapeXml="false" />
				</div>
			</c:if>


		</div>
	</main>

	<script>

	<div class="modal fade" id="categoryModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form method="post" action="${ctx}/admin/workshop/category/write">
					<div class="modal-header">
						<h5 class="modal-title fw-bold">카테고리 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="categoryId" id="categoryId">
						<div class="mb-3">
							<label class="form-label">카테고리명</label> <input type="text"
								class="form-control" name="categoryName" id="categoryName"
								maxlength="200" required>
						</div>

						<div class="mb-3">
							<label class="form-label">상태</label> <select class="form-select"
								name="isActive" id="isActive">
								<option value="1" selected>활성</option>
								<option value="0">비활성</option>
							</select>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn-manage" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn-manage">저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
  const categoryModal = document.getElementById('categoryModal');
  categoryModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const categoryId = button ? button.getAttribute('data-id') : null;
    const categoryName = button ? button.getAttribute('data-name') : '';
    const isActive = button ? (button.getAttribute('data-active') ?? '1') : '1';

    const modalTitle = categoryModal.querySelector('.modal-title');
    const form = categoryModal.querySelector('form');

    if (categoryId) {
      modalTitle.innerHTML = '카테고리 수정';
      form.action = '${ctx}/admin/workshop/category/update';
      categoryModal.querySelector('#categoryId').value = categoryId;
      categoryModal.querySelector('#categoryName').value = categoryName;
      categoryModal.querySelector('#isActive').value = isActive; 
    } else {
      modalTitle.innerHTML = '카테고리 등록';
      form.action = '${ctx}/admin/workshop/category/write';
      form.reset();
      categoryModal.querySelector('#categoryId').value = '';
      categoryModal.querySelector('#categoryName').value = '';
      categoryModal.querySelector('#isActive').value = '1'; 
    }
  });
</script>

	<script>
  const csrfHeaderEl = document.querySelector('meta[name="_csrf_header"]');
  const csrfTokenEl  = document.querySelector('meta[name="_csrf"]');
  const csrfHeader = csrfHeaderEl ? csrfHeaderEl.content : null;
  const csrfToken  = csrfTokenEl  ? csrfTokenEl.content  : null;

  document.addEventListener('change', async (e) => {
    if (!e.target.classList.contains('category-status')) return;

    const sel = e.target;
    const id = sel.getAttribute('data-id');
    const isActive = sel.value;
    const prev = isActive === '1' ? '0' : '1';

    sel.disabled = true;

    try {
      const headers = { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' };
      if (csrfHeader && csrfToken) headers[csrfHeader] = csrfToken;

      const res = await fetch('${ctx}/admin/workshop/category/toggle', {
        method: 'POST',
        headers,
        body: new URLSearchParams({ categoryId: id, isActive })
      });

      if (!res.ok) throw new Error('bad response');
      alert('상태가 변경되었습니다.');
    } catch (err) {
      alert('상태 변경에 실패했습니다. 다시 시도해 주세요.');
      sel.value = prev; 
    } finally {
      sel.disabled = false;
    }
  });
</script>



</body>
</html>