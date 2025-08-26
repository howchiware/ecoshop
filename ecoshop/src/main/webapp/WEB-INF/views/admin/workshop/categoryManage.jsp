<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>카테고리 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

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
  font-size: 15px;
}

.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

/* 표 기본 스타일 */
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

.modal-backdrop {
	z-index: 9998 !important;
}

.modal {
	z-index: 9999 !important;
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

      		<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-0">카테고리 관리</h3>
			</div>
			
			<hr>
			
			<div class="d-flex justify-content-end mb-2">
				<button class="btn-manage btn-register" data-bs-toggle="modal"
					data-bs-target="#categoryModal">등록</button>
			</div>

 
      <!-- 카테고리 목록 -->
      <div class="outside">
      <table class="table table-sm align-middle">
        <thead class="table-light">
          <tr>
            <th style="width:7%">번호</th>
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
                  <td class="text-center"><c:out value="${c.categoryName}" /></td>
                  <td class="text-center">
       
                    <button type="button" class="btn-manage"
                            data-bs-toggle="modal" data-bs-target="#categoryModal"
                            data-id="${c.categoryId}" data-name="${c.categoryName}">
                      수정
                    </button>

   
                    <form method="post" action="${ctx}/admin/workshop/category/delete"
                          class="d-inline" onsubmit="return confirm('삭제하시겠습니까?');">
                      <input type="hidden" name="categoryId" value="${c.categoryId}">
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
    
      <nav aria-label="페이지네이션">
        <ul class="pagination justify-content-center">
          <li class="page-item active"><span class="page-link">${page}</span></li>
        </ul>
      </nav>
			
    </div>
  </main>

  <div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="${ctx}/admin/workshop/category/write">
          <div class="modal-header">
            <h5 class="modal-title fw-bold"> 카테고리 등록</h5>
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
            <button type="button" class="btn-manage" data-bs-dismiss="modal">취소</button>
            <button type="submit" class="btn-manage">저장</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  // 수정 버튼 눌렀을 때 모달 데이터 세팅
  const categoryModal = document.getElementById('categoryModal');
  categoryModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const categoryId = button ? button.getAttribute('data-id') : null;
    const categoryName = button ? button.getAttribute('data-name') : '';

    const modalTitle = categoryModal.querySelector('.modal-title');
    const form = categoryModal.querySelector('form');

    if (categoryId) {
      modalTitle.innerHTML = '카테고리 수정';
      form.action = '${ctx}/admin/workshop/category/update';
      categoryModal.querySelector('#categoryId').value = categoryId;
      categoryModal.querySelector('#categoryName').value = categoryName;
    } else {
      modalTitle.innerHTML = '카테고리 등록';
      form.action = '${ctx}/admin/workshop/category/write';
      form.reset();
      categoryModal.querySelector('#categoryId').value = '';
      categoryModal.querySelector('#categoryName').value = '';
    }
  });
  </script>

</body>
</html>