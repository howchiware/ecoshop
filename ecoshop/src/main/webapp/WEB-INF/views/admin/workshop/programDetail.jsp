<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 상세</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* 버튼 디자인: 기존 유지 */
.btn-manage {
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
}

/* 워크샵 상세와 동일한 표 스타일 */
.view-table { width: 100%; border-collapse: collapse; }
.view-table th, .view-table td { border-bottom: 1px solid #eee; padding: 12px 10px; }
.view-table th { width: 140px; background: #fafafa; font-weight: 500; color: #555; text-align: left; }
.view-table td { color: #222; }
</style>
</head>
<body>

  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <main class="main-container">
    <div class="container py-3">

      <!-- 상단 바: 버튼은 그대로 -->
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="m-0">프로그램 상세</h4>
        <div class="d-inline-flex gap-1">

          <!-- 목록 -->
          <form action="${ctx}/admin/workshop/program/list" method="get" class="d-inline">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="schType" value="${schType}">
            <input type="hidden" name="kwd" value="${kwd}">
            <input type="hidden" name="categoryId" value="${categoryId}">
            <button type="submit" class="btn-manage">목록</button>
          </form>

          <!-- 수정 -->
          <form action="${ctx}/admin/workshop/program/update" method="get" class="d-inline">
            <input type="hidden" name="num" value="${dto.programId}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="schType" value="${schType}">
            <input type="hidden" name="kwd" value="${kwd}">
            <input type="hidden" name="categoryId" value="${categoryId}">
            <button type="submit" class="btn-manage">수정</button>
          </form>

          <!-- 삭제 -->
          <form action="${ctx}/admin/workshop/program/delete" method="post" class="d-inline">
            <input type="hidden" name="num" value="${dto.programId}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="schType" value="${schType}">
            <input type="hidden" name="kwd" value="${kwd}">
            <input type="hidden" name="categoryId" value="${categoryId}">
            <button type="submit" class="btn-manage" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
          </form>

        </div>
      </div>

      <!-- 상세 표: 워크샵 상세와 동일 구조 -->
      <div class="card">
        <div class="card-body">
          <c:choose>
            <c:when test="${not empty dto}">
              <table class="view-table">
                <tbody>
                  <tr>
                    <th>제목</th>
                    <td><c:out value="${dto.programTitle}" /></td>
                  </tr>
                  <tr>
                    <th>카테고리</th>
                    <td>
                      <c:choose>
                        <c:when test="${not empty dto.categoryName}">
                          <c:out value="${dto.categoryName}" />
                        </c:when>
                        <c:otherwise><em class="text-muted">미지정</em></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                  <tr>
                    <th>등록일</th>
                    <td><fmt:formatDate value="${dto.regDate}" pattern="yyyy.MM.dd" /></td>
                  </tr>
                  <tr>
                    <th>내용</th>
                    <td><c:out value="${dto.programContent}" escapeXml="false" /></td>
                  </tr>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
              <div class="alert alert-warning mb-0">데이터를 찾을 수 없습니다.</div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </div>
  </main>

</body>
</html>
