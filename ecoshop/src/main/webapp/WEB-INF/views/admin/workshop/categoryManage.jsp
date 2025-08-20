<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>카테고리 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
.main-container .container {
  margin-left: 250px;
  max-width: calc(100% - 250px);
}
</style>
</head>
<body>

  <!-- 공통 헤더/사이드바 -->
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <main class="main-container">
    <div class="container py-4">

      <!-- 제목 & 등록버튼 -->
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h3 class="m-0">카테고리 관리</h3>
        <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#categoryModal">
          <i class="bi bi-plus-lg"></i> 카테고리 등록
        </button>
      </div>

      <!-- 카테고리 목록 (표 형식) -->
      <table class="table table-bordered align-middle">
        <thead class="table-light">
          <tr>
            <th style="width:10%">No</th>
            <th>카테고리명</th>
            <th style="width:20%">관리</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty categoryList}">
              <tr>
                <td colspan="3" class="text-center text-muted py-4">등록된 카테고리가 없습니다.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="c" items="${categoryList}" varStatus="st">
                <tr>
                  <td class="text-center">${st.count}</td>
                  <td><c:out value="${c.categoryName}" /></td>
                  <td class="text-center">
                    <!-- 수정 버튼 -->
                    <button type="button" class="btn btn-outline-primary btn-sm"
                            data-bs-toggle="modal" data-bs-target="#categoryModal"
                            data-id="${c.categoryId}" data-name="${c.categoryName}">
                      수정
                    </button>

                    <!-- 삭제 버튼 -->
                    <form method="post" action="${ctx}/admin/workshop/category/delete"
                          class="d-inline" onsubmit="return confirm('삭제하시겠습니까?');">
                      <input type="hidden" name="categoryId" value="${c.categoryId}">
                      <button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>

    </div>
  </main>

  <!-- 카테고리 등록/수정 모달 -->
  <div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="${ctx}/admin/workshop/category/write">
          <div class="modal-header">
            <h5 class="modal-title fw-bold"><i class="bi bi-tags"></i> 카테고리 등록</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" name="categoryId" id="categoryId">
            <div class="mb-3">
              <label class="form-label">카테고리명</label>
              <input type="text" class="form-control" name="categoryName" id="categoryName" maxlength="200" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-dark">저장</button>
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  //수정 버튼 눌렀을 때 모달에 데이터 바인딩
  const categoryModal = document.getElementById('categoryModal');
  categoryModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const categoryId = button ? button.getAttribute('data-id') : null;
    const categoryName = button ? button.getAttribute('data-name') : '';

    const modalTitle = categoryModal.querySelector('.modal-title');
    const form = categoryModal.querySelector('form');

    if (categoryId) {
      modalTitle.innerHTML = '<i class="bi bi-pencil-square"></i> 카테고리 수정';
      form.action = '${ctx}/admin/workshop/category/update';
      categoryModal.querySelector('#categoryId').value = categoryId;
      categoryModal.querySelector('#categoryName').value = categoryName;
    } else {
      modalTitle.innerHTML = '<i class="bi bi-tags"></i> 카테고리 등록';
      form.action = '${ctx}/admin/workshop/category/write';
      form.reset();
      categoryModal.querySelector('#categoryId').value = '';
      categoryModal.querySelector('#categoryName').value = '';
    }
  });
  </script>

</body>
</html>