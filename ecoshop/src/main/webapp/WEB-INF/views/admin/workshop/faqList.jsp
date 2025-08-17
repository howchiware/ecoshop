<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>FAQ 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.main-container .container {
  margin-left: 250px;
  max-width: calc(100% - 250px);
}

.faq-answer { display:inline; white-space: normal; }

.accordion-button { background:#fff; color:inherit; }
.accordion-button:not(.collapsed) { background:#fff; color:inherit; box-shadow:none; }
.accordion-button:focus { box-shadow:none; }
.accordion-item { border:1px solid #e9ecef; }
</style>
</head>
<body>

  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <main class="main-container d-flex">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

    <div class="container py-4">
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h3 class="m-0">FAQ 목록</h3>

        <c:if test="${not empty programId}">
          <c:url var="writeUrl" value="/admin/workshop/faq/write">
            <c:param name="programId" value="${programId}" />
          </c:url>
          <a href="${writeUrl}" class="btn btn-dark btn-sm">FAQ 등록</a>
        </c:if>
      </div>

      <form class="row g-2 align-items-end mb-3" method="get" action="${ctx}/admin/workshop/faq/list">
        <div class="col-sm-6 col-md-4">
          <label class="form-label">프로그램</label>
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

      <!-- 프로그램 미선택 안내 -->
      <c:if test="${empty programId}">
        <div class="alert alert-secondary">좌측 드롭다운에서 프로그램을 선택하면 해당 프로그램의 FAQ가 표시됩니다.</div>
      </c:if>

      <!-- FAQ 아코디언 -->
      <c:choose>
        <c:when test="${empty programId}">
          <!-- 안내가 이미 위에 있음 -->
        </c:when>
        <c:when test="${empty faqList}">
          <div class="text-muted py-5 text-center">등록된 FAQ가 없습니다.</div>
        </c:when>
        <c:otherwise>
          <div class="accordion" id="faqAccordion">
            <c:forEach var="faq" items="${faqList}" varStatus="st">
              <div class="accordion-item">
                <h2 class="accordion-header" id="heading-${faq.faqId}">
                  <button class="accordion-button collapsed"
                          type="button"
                          data-bs-toggle="collapse"
                          data-bs-target="#collapse-${faq.faqId}"
                          aria-expanded="false"
                          aria-controls="collapse-${faq.faqId}">
                    <span class="me-2 text-secondary">Q.</span>
                    <c:out value="${faq.question}" />
                  </button>
                </h2>
                <div id="collapse-${faq.faqId}"
                     class="accordion-collapse collapse"
                     aria-labelledby="heading-${faq.faqId}"
                     data-bs-parent="#faqAccordion">
                  <div class="accordion-body">
                    <!-- 왼쪽: A + 답변 / 오른쪽: 버튼 -->
                    <div class="mb-3 d-flex align-items-center gap-2">
                      <span class="fw-semibold me-2">A.</span>
                      <span class="faq-answer"><c:out value="${faq.answer}" /></span>

                      <div class="ms-auto d-flex gap-2">
                        <c:url var="editUrl" value="/admin/workshop/faq/update">
                          <c:param name="faqId" value="${faq.faqId}" />
                          <c:param name="page" value="1" />
                        </c:url>
                        <a href="${editUrl}" class="btn btn-outline-primary btn-sm">수정</a>

                        <form method="post" action="${ctx}/admin/workshop/faq/delete"
                              class="d-inline"
                              onsubmit="return confirm('삭제하시겠습니까?');">
                          <input type="hidden" name="faqId" value="${faq.faqId}">
                          <input type="hidden" name="programId" value="${programId}">
                          <button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
