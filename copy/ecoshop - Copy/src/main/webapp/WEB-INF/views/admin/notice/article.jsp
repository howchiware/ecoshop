<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분리배출 가이드</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
body {
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
  background-color: #f7f6f3;
  color: #333;
  margin: 0;
}

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-style: normal;
}
.right-panel {
  padding: 20px 40px;
}
.section-body {
  max-width: 1300px;
  margin: 0 auto;
  background: #fff;
  border-radius: 12px;
  padding: 20px 30px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.05);
}
.small-title {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 20px;
  color: #666;
  
}
.article-title {
  font-size: 22px;
  font-weight: bold;
  margin-bottom: 8px;
}
.article-meta {
  display: flex;
  justify-content: space-between;
  color: #777;
  font-size: 14px;
  border-bottom: 1px solid #ddd;
  padding-bottom: 8px;
  margin-bottom: 20px;
}
.article-content {
  min-height: 200px;
  padding: 15px 0;
  margin-bottom: 20px;
}

/* 이전글/다음글 영역 */
.prev-next-wrap {
  border-top: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  font-size: 14px;
}
.prev-next-wrap div {
  padding: 10px 0;
}
.prev-next-wrap div:first-child {
  border-bottom: 1px solid #ddd; 
}
.prev-next-wrap a {
  color: #333;
  text-decoration: none;
}
.prev-next-wrap a:hover {
  text-decoration: underline;
}

.span-default {
  color: black;
  cursor: pointer;
}
.span-default:hover {
  color: gray;
}
.btn-default {
  background-color: #315e4e;
  color: #fff;
  padding: 10px 25px;
  border-radius: 8px;
  border: none;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s ease;
}
.btn-default:hover {
  background-color: #26463a;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="right-panel">
    <div class="section p-5" data-aos="fade-up" data-aos-delay="200">
      <div class="section-body p-5">

        <!-- 상단 구분 타이틀 -->
        <div class="pb-3">
           <a style="text-decoration:none;" href="${pageContext.request.contextPath}/admin/notice/list?${query}"><span class="small-title">공지사항</span></a>
        </div>

        <!-- 제목 + 메타정보 -->
        <div class="article-title">${dto.subject}</div>
        <div class="article-meta">
          <span>${dto.regDate}</span>
          <span>작성자 : ${dto.name} | 조회수 : ${dto.hitCount}</span>
        </div>

        <!-- 본문 -->
        <div class="article-content">
          ${dto.content}
        </div>

        <!-- 첨부파일 -->
        <c:if test="${listFile.size() != 0}">
          <div class="mb-3">
            <p class="border text-secondary mb-1 p-2">
              <i class="bi bi-folder2-open"></i>
              <c:forEach var="vo" items="${listFile}" varStatus="status">
                <a href="${pageContext.request.contextPath}/admin/notice/download/${vo.noticefileId}">
                  ${vo.originalFilename}
                  (<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
                </a>
                <c:if test="${not status.last}"> | </c:if>
              </c:forEach>
            </p>
          </div>
        </c:if>

        <!-- 이전글 + 다음글 -->
        <div class="prev-next-wrap">
          <div>
            이전 글 :
            <c:if test="${not empty prevDto}">
              <a href="${pageContext.request.contextPath}/admin/notice/article/${prevDto.noticeId}?${query}">${prevDto.subject}</a>
            </c:if>
            <c:if test="${empty prevDto}"></c:if>
          </div>
          <div>
            다음 글 :
            <c:if test="${not empty nextDto}">
              <a href="${pageContext.request.contextPath}/admin/notice/article/${nextDto.noticeId}?${query}">${nextDto.subject}</a>
            </c:if>
            <c:if test="${empty nextDto}"></c:if>
          </div>
        </div>

        <!-- 버튼 -->
        <div class="row mt-4">
          <div class="col-md-6 align-self-center">
            <span class="span-default" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?${query}';">
              <i class="bi bi-arrow-left-short"></i> 목록
            </span>
          </div>
          <div class="col-md-6 align-self-center text-end">
            <button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?noticeId=${dto.noticeId}&page=${page}';">수정</button>
            <button type="button" class="btn-default" onclick="deleteOk();">삭제</button>
          </div>
        </div>

      </div>
    </div>
  </div>
</main>

<script type="text/javascript">
function deleteOk() {
  let params = 'noticeId=${dto.noticeId}&${query}';
  let url = '${pageContext.request.contextPath}/admin/notice/delete?' + params;
  if (confirm('위 자료를 삭제 하시겠습니까?')) {
    location.href = url;
  }
}
</script>

</body>
</html>