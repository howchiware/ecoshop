<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>FAQ 관리</title>
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
        <h4 class="m-0">FAQ 관리</h4>
        <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#faqModal">
          등록
        </button>
      </div>

      <!-- 검색/필터 -->
      <form class="row g-2 align-items-end mb-3" method="get" action="${ctx}/admin/workshop/faq/manage">
        <div class="col-sm-6 col-md-3">
          <label class="form-label">프로그램명</label>
          <select name="programId" class="form-select" onchange="this.form.submit()">
            <option value="">프로그램 선택</option>
            <c:forEach var="p" items="${programList}">
              <option value="${p.programId}" <c:if test="${p.programId == programId}">selected</c:if>>
                <c:out value="${p.programTitle}" />
              </option>
            </c:forEach>
          </select>
        </div>
      </form>

      <!-- FAQ 목록 (표 형식) -->
      <table class="table table-bordered align-middle">
        <thead class="table-light">
          <tr>
            <th style="width:5%">번호</th>
            <th style="width:25%">질문</th>
            <th>답변</th>
            <th style="width:15%">관리</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty faqList}">
              <tr>
                <td colspan="4" class="text-center text-muted py-4">등록된 FAQ가 없습니다.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="faq" items="${faqList}" varStatus="st">
                <tr>
                  <td class="text-center">${st.count}</td>
                  <td><c:out value="${faq.question}" /></td>
                  <td><c:out value="${faq.answer}" /></td>
                  <td class="text-center">
                    <button type="button" class="btn btn-outline-primary btn-sm"
                            data-bs-toggle="modal" data-bs-target="#faqModal"
                            data-id="${faq.faqId}" data-question="${faq.question}" data-answer="${faq.answer}"
                            data-program="${faq.programId}">
                      수정
                    </button>
                    <form method="post" action="${ctx}/admin/workshop/faq/delete"
                          class="d-inline" onsubmit="return confirm('삭제하시겠습니까?');">
                      <input type="hidden" name="faqId" value="${faq.faqId}">
                      <input type="hidden" name="programId" value="${programId}">
                      <button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
      
      <!-- 페이징 -->
	  <nav aria-label="페이징">
		<ul class="pagination justify-content-center">
			<li class="page-item active"><span class="page-link">${page}</span></li>
		</ul>
	  </nav>
			
    </div>
  </main>

  <!-- FAQ 등록/수정 모달 -->
  <div class="modal fade" id="faqModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="${ctx}/admin/workshop/faq/write">
          <div class="modal-header">
            <h5 class="modal-title fw-bold"><i class="bi bi-question-circle"></i> FAQ 등록</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" name="faqId" id="faqId">
            <div class="mb-3">
              <label class="form-label">프로그램</label>
              <select class="form-select" name="programId" id="programId" required>
                <c:forEach var="p" items="${programList}">
                  <option value="${p.programId}"><c:out value="${p.programTitle}" /></option>
                </c:forEach>
              </select>
              <div class="form-text text-muted">FAQ는 선택한 프로그램의 상세 페이지에 공통 노출됩니다.</div>
            </div>
            <div class="mb-3">
              <label class="form-label">질문</label>
              <input type="text" class="form-control" name="question" id="question" maxlength="1000" required>
            </div>
            <div class="mb-3">
              <label class="form-label">답변</label>
              <textarea class="form-control" name="answer" id="answer" rows="5" maxlength="2000" required></textarea>
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
  const faqModal = document.getElementById('faqModal');
  faqModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const faqId = button ? button.getAttribute('data-id') : null;
    const question = button ? button.getAttribute('data-question') : '';
    const answer = button ? button.getAttribute('data-answer') : '';
    const programId = button ? button.getAttribute('data-program') : '';

    const modalTitle = faqModal.querySelector('.modal-title');
    const form = faqModal.querySelector('form');

    if (faqId) {
      modalTitle.innerHTML = '<i class="bi bi-pencil-square"></i> FAQ 수정';
      form.action = '${ctx}/admin/workshop/faq/update';
      faqModal.querySelector('#faqId').value = faqId;
      faqModal.querySelector('#question').value = question;
      faqModal.querySelector('#answer').value = answer;
      faqModal.querySelector('#programId').value = programId;
    } else {
      modalTitle.innerHTML = '<i class="bi bi-question-circle"></i> FAQ 등록';
      form.action = '${ctx}/admin/workshop/faq/write';
      form.reset();
      faqModal.querySelector('#faqId').value = '';
      faqModal.querySelector('#programId').selectedIndex = 0;
    }
  });

  </script>

</body>
</html>