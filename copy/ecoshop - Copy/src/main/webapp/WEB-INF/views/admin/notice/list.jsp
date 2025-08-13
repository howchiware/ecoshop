<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
 <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f7f6f3;
  color: #333;
  margin: 0;
}

h2.mb-4 {
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 600;
    font-size: 1.8rem;
    color: #333;
    letter-spacing: -0.5px;
    position: relative;
    padding-left: 16px;
    margin-bottom: 2.0rem;
}

h2.mb-4::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 6px;
    height: 80%;
    background: linear-gradient(180deg, #4CAF50, #81C784);
    border-radius: 3px;
}

.main-container {
  display: flex;
  padding: 20px;
  gap: 20px;
}

.content {
  flex: 1;
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

form label {
  font-weight: 700;
  color: #315e4e;
}

form .form-control,
form .form-select {
  border-radius: 6px;
  border: 1px solid #ddd;
  font-size: 0.9rem;
}

form .form-control:focus,
form .form-select:focus {
  border-color: #315e4e;
  box-shadow: 0 0 0 0.15rem rgba(49, 94, 78, 0.25);
}

form .btn-primary {
  background-color: #315e4e;
  border: none;
  font-weight: 500;
  padding: 0.45rem 1rem;
  border-radius: 6px;
}

.text-start > a {
	font-weight: normal !important;
	color: black;
}

div .btn-primary {
  background-color: #315e4e;
  border: none;
  font-weight: 500;
  padding: 0.45rem 1rem;
  border-radius: 6px;
}

form .btn-primary:hover {
  background-color: #234d3c;
}

form button[type=button] {
  background-color: #e2e2e2;
  border: none;
  padding: 0.45rem 1rem;
  border-radius: 6px;
  font-weight: 500;
}

form button[type=button]:hover {
  background-color: #ccc;
}

.table-wrapper {
    max-width: 90%;
    margin: 0 auto;
}

.table {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 12px;
    overflow: hidden;
    font-family: 'Noto Sans KR', sans-serif;
}

.table thead th {
    background-color: #e6f4ea;
    color: #2e7d32;
    font-weight: 600;
    text-align: center;
    border-bottom: 2px solid #c8e6c9;
}

.table tbody td {
    vertical-align: middle;
    text-align: center;
    border-color: #e0e0e0;
}

.table-hover tbody tr:hover {
    background-color: #f1f8f4;
    transition: background-color 0.2s ease;
}

.table-bordered {
    border: 1.5px solid #dcdcdc;
    border-radius: 12px;
    border-collapse: separate;
    border-spacing: 0;
    overflow: hidden;
}

.table-bordered thead th,
.table-bordered tbody td {
    border: 1px solid #dcdcdc;
}

.table-bordered thead th:first-child {
    border-left: none;
}

.table-bordered thead th:last-child {
    border-right: none;
}

.table-bordered tbody td:first-child {
    border-left: none;
}

.table-bordered tbody td:last-child {
    border-right: none;
}


.badge.bg-success {
  background-color: #315e4e !important;
  font-weight: 500;
  padding: 0.4em 0.6em;
}

.badge.bg-secondary {
  background-color: #bbb !important;
  font-weight: 500;
  padding: 0.4em 0.6em;
}

.badge-new {
  background-color: transparent;
  color: #4caf50;
  font-weight: 600;
  font-size: 0.75rem;
  border: 1px solid #4caf50;
  padding: 0.2em 0.5em;
  border-radius: 4px;
}

.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
  font-family: 'Noto Sans KR', sans-serif;
  gap: 10px;
}

.page-navigation a,
.page-navigation span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #7ecf98;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(126, 207, 152, 0.4);
  transition: background-color 0.25s ease, color 0.25s ease, box-shadow 0.25s ease;
  font-size: 1rem;
}

.page-navigation a:hover {
  background-color: #a4d7a7;
  color: white;
  box-shadow: 0 4px 12px rgba(126, 207, 152, 0.6);
}

.paginate span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  background-color: #4caf50;
  color: #fff;
  font-weight: 700;
  cursor: default;
  box-shadow: 0 2px 5px rgba(76, 175, 80, 0.6);
  font-size: 1rem;
}

.paginate a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s, color 0.3s;
  font-size: 1rem;
}

.paginate a:hover {
  background-color: #81c784;
  color: #fff;
  box-shadow: 0 4px 12px rgba(129, 199, 132, 0.6);
}

.page-navigation .disabled {
  color: #cde5d4;
  border-color: #cde5d4;
  cursor: default;
  pointer-events: none;
  box-shadow: none;
}


</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="content">
    <h2 class="mb-4">공지사항</h2>

    <!-- 상단 정보 및 검색 -->
    <div class="d-flex justify-content-between flex-wrap align-items-end mb-4">
      <div class="data-info">
        <span class="small-title">글목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page} 페이지)</span>
      </div>
      <form name="searchForm" class="row g-2" method="get">
        <div class="col-auto">
          <select name="schType" class="form-select">
            <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
            <option value="name" ${schType=="name"?"selected":""}>글쓴이</option>
            <option value="regDate" ${schType=="regDate"?"selected":""}>작성일</option>
            <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
            <option value="content" ${schType=="content"?"selected":""}>내용</option>
          </select>
        </div>
        <div class="col-auto">
          <input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
        </div>
        <div class="col-auto">
          <button type="submit" class="btn btn-primary">
            <i class="bi bi-search"></i> 검색
          </button>
        </div>
      </form>
    </div>

    <!-- 테이블 -->
    <div class="table-wrapper">
      <table class="table table-bordered table-hover">
        <thead class="table-light text-center">
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>첨부</th>
            <th>표시</th>
          </tr>
        </thead>
        <tbody>
          <!-- 공지 -->
          <c:forEach var="dto" items="${noticeList}">
            <tr class="text-center">
              <td><span class="badge bg-success">공지</span></td>
              <td class="text-start">
                <c:url var="url" value="/admin/notice/article/${dto.noticeId}">
                  <c:param name="page" value="${page}"/>
                  <c:if test="${not empty kwd}">
                    <c:param name="schType" value="${schType}"/>
                    <c:param name="kwd" value="${kwd}"/>
                  </c:if>
                </c:url>
                <a href="${url}" class="text-decoration-none fw-semibold">${dto.subject}</a>
              </td>
              <td>${dto.name}</td>
              <td>${dto.regDate}</td>
              <td>${dto.hitCount}</td>
              <td>
                <c:if test="${dto.fileCount != 0}">
                  <a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeId}" class="text-reset">
                    <i class="bi bi-file-arrow-down"></i>
                  </a>
                </c:if>
              </td>
              <td>&nbsp;</td>
            </tr>
          </c:forEach>

          <!-- 일반 게시물 -->
          <c:forEach var="dto" items="${list}" varStatus="status">
            <tr class="text-center">
              <td>${dataCount - (page-1) * size - status.index}</td>
              <td class="text-start">
                <c:url var="url" value="/admin/notice/article/${dto.noticeId}">
                  <c:param name="page" value="${page}"/>
                  <c:if test="${not empty kwd}">
                    <c:param name="schType" value="${schType}"/>
                    <c:param name="kwd" value="${kwd}"/>
                  </c:if>
                </c:url>
                <a href="${url}" class="text-decoration-none fw-semibold">${dto.subject}</a>
                <c:if test="${dto.gap < 1}">
				  <span class="badge-new ms-1">NEW</span>
				</c:if>
              </td>
              <td>${dto.name}</td>
              <td>${dto.regDate}</td>
              <td>${dto.hitCount}</td>
              <td>
                <c:if test="${dto.fileCount != 0}">
                  <a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeId}" class="text-reset">
                    <i class="bi bi-file-arrow-down"></i>
                  </a>
                </c:if>
              </td>
              <td>
                <c:choose>
                  <c:when test="${dto.showNotice == 1}">표시</c:when>
                  <c:otherwise>숨김</c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>

          <!-- 목록 없음 -->
          <c:if test="${dataCount == 0}">
            <tr>
              <td colspan="7" class="text-center">등록된 게시물이 없습니다.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
    <!-- 페이지네이션 & 글쓰기 버튼 -->
    <div class="d-flex justify-content-end mt-2">
	  <button type="button" class="btn btn-primary d-flex align-items-center gap-2"
	    onclick="location.href='${pageContext.request.contextPath}/admin/notice/write';">
	    <i class="bi bi-pencil-square"></i> 글쓰기
	  </button>
	</div>
     	<div class="page-navigation">
        ${dataCount == 0 ? " " : paging}
    </div>
  </div>
</main>

</body>
</html>