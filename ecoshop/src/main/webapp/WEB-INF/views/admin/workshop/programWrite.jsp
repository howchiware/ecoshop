<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>프로그램 등록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssWorkshop/workshop.css">

<style>
.main-title { font-weight:600; }

.form-table { width:100%; border-collapse:collapse; table-layout:fixed; }
.form-table th, .form-table td { border-bottom:1px solid #eee; padding:12px 10px; vertical-align:middle; }
.form-table th { width:140px; background:#fafafa; font-weight:500; color:#555; text-align:left; }
.form-table td { color:#222; }

.form-table .form-control,
.form-table .form-select,
.form-table textarea {
  width:100%;
  height:36.5px;
}
.form-table textarea { height:auto; min-height:220px; resize:vertical; }

.center-btn-container { display:flex; justify-content:center; gap:8px; margin-top:20px; }
</style>
</head>
<body>

  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
    <div class="container py-3">

      <div class="outside">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <h5 class="main-title">
            <c:choose>
              <c:when test="${mode == 'update'}">프로그램 수정</c:when>
              <c:otherwise>프로그램 등록</c:otherwise>
            </c:choose>
          </h5>

          <!-- 목록 버튼(선택) 필요하면 주석 해제
          <form action="${ctx}/admin/workshop/program/list" method="get" class="d-inline">
            <input type="hidden" name="page" value="${page}">
            <button type="submit" class="btn-manage">목록</button>
          </form>
          -->
        </div>

        <hr class="mt-0">

        <form id="programForm" method="post" action="${ctx}/admin/workshop/program/${mode}">
          <c:if test="${mode == 'update'}">
            <input type="hidden" name="programId" value="${dto.programId}">
            <input type="hidden" name="page" value="${page}">
          </c:if>

          <table class="form-table">
            <tbody>
              <tr>
                <th>카테고리</th>
                <td>
                  <select name="categoryId" id="categoryId" class="form-select" required>
                    <option value="" disabled <c:if test="${empty dto.categoryId}">selected</c:if>>카테고리 선택</option>
                    <c:forEach var="c" items="${category}">
                      <option value="${c.categoryId}"
                        <c:if test="${mode == 'update' && c.categoryId == dto.categoryId}">selected</c:if>>
                        ${c.categoryName}
                      </option>
                    </c:forEach>
                  </select>
                </td>
              </tr>

              <tr>
                <th>프로그램명</th>
                <td>
                  <input type="text" name="programTitle" class="form-control"
                         value="${dto.programTitle}" maxlength="200" required>
                </td>
              </tr>

              <tr>
                <th>프로그램 내용</th>
                <td>
                  <textarea name="programContent" class="form-control" rows="10" style="height: 400px"
                            placeholder="프로그램 소개/구성/유의사항 등을 입력하세요.">${dto.programContent}</textarea>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="center-btn-container">
            <button type="submit" class="btn-manage">등록</button>
          </div>
        </form>
      </div>

    </div>
  </main>

</body>
</html>
