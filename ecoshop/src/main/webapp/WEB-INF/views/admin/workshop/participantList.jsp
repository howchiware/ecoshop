<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>참여자 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.main-container .container {
  margin-left: 250px;
  max-width: calc(100% - 250px);
}

.section-title {
  border-bottom: 1px solid #e5e7eb;
  padding-bottom: .75rem;
  margin-bottom: 1rem;
  font-weight: 600;
}

.table-outline {
  border: 1px solid #ced4da;
  border-radius: .25rem;
  overflow: hidden;
}
.table-outline thead th {
  background: #f1f3f5;
  white-space: nowrap;
}
.table-outline .row-no { width:72px; text-align:center; color:#6c757d; }
.table-outline .col-status { width:160px; }
.table-outline .col-attend { width:120px; text-align:center; }

.filters .form-select { min-width: 240px; }
</style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <main class="main-container d-flex">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

    <div class="container py-4">

      <div class="d-flex align-items-center justify-content-between mb-3">
        <h3 class="m-0">참여자 관리</h3>
        <div class="text-muted small">관리자 &gt; 워크샵 &gt; 참여자 관리</div>
      </div>

      <div class="section-title">워크샵 선택</div>
      <form class="row g-3 filters mb-4" method="get" action="${ctx}/admin/workshop/participant/list">
        <div class="col-sm-6 col-lg-4">
          <label class="form-label">워크샵</label>
          <select name="workshopId" class="form-select" onchange="this.form.submit()">
            <option value="">워크샵 선택</option>
            <c:forEach var="w" items="${workshopList}">
              <option value="${w.workshopId}"
                <c:if test="${w.workshopId == workshopId}">selected</c:if>>
                <c:out value="${w.workshopTitle}" />
              </option>
            </c:forEach>
          </select>
        </div>
      </form>

      <!-- 안내 -->
      <c:if test="${empty workshopId}">
        <div class="alert alert-secondary">워크샵을 선택하면 해당 워크샵의 참여자 목록이 표시됩니다.</div>
      </c:if>

      <!-- 참여자 목록 -->
      <c:if test="${not empty workshopId}">
        <div class="section-title">참여자 목록</div>

        <div class="table-outline mb-3">
          <table class="table table-bordered align-middle mb-0">
            <thead>
              <tr>
                <th class="row-no">No</th>
                <th>이름</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>신청일</th>
                <th class="col-status">상태</th>
                <th class="col-attend">출석</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty participantList}">
                  <tr><td colspan="7" class="text-center text-muted py-4">참여자가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="p" items="${participantList}" varStatus="st">
                    <tr>
                      <td class="row-no">${st.index + 1}</td>
                      <td><c:out value="${p.name}" /></td>
                      <td><c:out value="${p.tel}" /></td>
                      <td><c:out value="${p.email}" /></td>
                      <td><fmt:formatDate value="${p.appliedDate}" pattern="yyyy.MM.dd HH:mm" /></td>
                      <td>
                        <select class="form-select form-select-sm js-status" data-id="${p.participantId}">
                          <option value="1" <c:if test="${p.participantStatus == 1}">selected</c:if>>신청완료</option>
                          <option value="2" <c:if test="${p.participantStatus == 2}">selected</c:if>>대기</option>
                          <option value="0" <c:if test="${p.participantStatus == 0}">selected</c:if>>취소</option>
                        </select>
                      </td>
                      <td class="text-center">
                        <input type="checkbox" class="form-check-input js-attend"
                               data-id="${p.participantId}"
                               <c:if test="${p.isAttended == 'Y'}">checked</c:if> />
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>
      </c:if>

    </div>
  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <script>
  (function() {
    const post = (url, body) => fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams(body)
    }).then(r => r.json());

    // 출석 체크
    document.querySelectorAll(".js-attend").forEach(cb => {
      cb.addEventListener("change", async (e) => {
        const participantId = e.target.dataset.id;
        const isAttended = e.target.checked ? "Y" : "N";
        try {
          const res = await post("${ctx}/admin/workshop/participant/attendance", { participantId, isAttended });
          if (!res.success) {
            alert("출석 저장 실패: " + (res.message || ""));
            e.target.checked = !e.target.checked; 
          }
        } catch (err) {
          alert("네트워크 오류로 실패했습니다.");
          e.target.checked = !e.target.checked;
        }
      });
    });

    // 상태 변경
    document.querySelectorAll(".js-status").forEach(sel => {
      // 현재 선택값을 data-prev에 저장(실패 시 복구용)
      sel.dataset.prev = sel.value;

      sel.addEventListener("change", async (e) => {
        const participantId = e.target.dataset.id;
        const participantStatus = e.target.value;
        try {
          const res = await post("${ctx}/admin/workshop/participant/status", { participantId, participantStatus });
          if (!res.success) {
            alert("상태 변경 실패: " + (res.message || ""));
            e.target.value = e.target.dataset.prev; 
          } else {
            e.target.dataset.prev = participantStatus; 
          }
        } catch (err) {
          alert("네트워크 오류로 실패했습니다.");
          e.target.value = e.target.dataset.prev; 
        }
      });
    });
  })();
  </script>

</body>
</html>
