<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ECOMORE - 챌린지 톡</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyList.css" type="text/css">


<style>
.badge-special { 
	background:#4b4b4b; 
	color:#fff; 
}

.card-img-top { 
	object-fit: cover; 
	height: 180px; 
}

.card-title { 
	font-size: 0.98rem; 
	font-weight: 600; 
}

.card .muted { 
	color:#6b7280; 
	font-size: 0.82rem; 
}

.page-navigation .paginate {
  display:flex; 
  justify-content:center; 
  align-items:center; 
  gap:6px; 
  flex-wrap:wrap;
}

.search-bar .form-control { 
	max-width: 260px; 
}

</style>
</head>
<body>
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">
  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>

  <!-- 검색 / 정렬 바 -->
  <form class="d-flex align-items-center gap-2 my-3" method="get" action="${pageContext.request.contextPath}/free/challengeList">
    <input type="hidden" name="page" value="1">
    <select name="sort" class="form-select form-select-sm" style="width:120px;">
      <option value="RECENT" ${sort=='RECENT' ? 'selected' : ''}>최신순</option>
      <option value="POPULAR" ${sort=='POPULAR' ? 'selected' : ''}>인기순</option>
    </select>
    <div class="search-bar ms-auto d-flex gap-2">
      <input class="form-control form-control-sm" type="text" name="kwd" placeholder="검색(제목/내용)" value="${kwd}">
      <button class="btn btn-sm btn-outline-secondary" type="submit">검색</button>
    </div>
  </form>

  <!-- 카드 그리드 -->
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
    <c:forEach var="d" items="${list}">
      <div class="col">
  <div class="card h-100 shadow-sm position-relative"><%-- position-relative 필요 --%>
    <c:choose>
      <c:when test="${not empty d.photoUrl}">
        <img class="card-img-top" src="${pageContext.request.contextPath}/uploads/challenge/${d.photoUrl}" alt="photo">
      </c:when>
      <c:otherwise>
        <img class="card-img-top" src="${pageContext.request.contextPath}/dist/img/noimage.png" alt="noimage">
      </c:otherwise>
    </c:choose>

    <div class="card-body">
      <span class="badge badge-special">SPECIAL</span>
      <h6 class="card-title mt-2 mb-1">${d.title} · ${d.dayNumber}일차</h6>
      <div class="muted mb-2">${d.memberName} · ${d.postRegDate}</div>
      <p class="mb-0">
        <c:out value="${fn:length(d.content) > 80 ? fn:substring(d.content,0,80).concat('...') : d.content}"/>
      </p>

      <!-- 카드 전체 클릭영역 -->
      <a href="${pageContext.request.contextPath}/free/challengeList/${d.postId}" class="stretched-link"></a>
    </div>
  </div>
</div>

    </c:forEach>

    <c:if test="${empty list}">
      <div class="col">
        <div class="text-center text-muted py-5">공개된 스페셜 인증글이 없습니다.</div>
      </div>
    </c:if>
  </div>

  <!-- 페이징 -->
  <div class="page-navigation mt-4">
    ${paging}
  </div>
</main>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
