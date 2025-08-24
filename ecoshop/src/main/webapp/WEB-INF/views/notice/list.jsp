<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>ECOMORE - 공지사항</title>
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
  <style>
    .new-text {
        display: inline-block;
        margin-left: 6px;
        padding: 2px 6px;
        font-size: 0.75rem;
        font-weight: 600;
        color: #fff;
        background: linear-gradient(135deg, #315e4e, #4b8071);
        border-radius: 12px;
        animation: blink 1.5s infinite;
    }
    @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.6; }
    }
    .page-navigation {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
  </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">
    <h2 class="mb-4 fw-bold">공지사항</h2>

    <!-- 검색 -->
    <form name="searchForm" class="search-form row g-3 align-items-end mb-4" method="get">
         <div class="col-md-3">
             <label for="schType" class="form-label">검색 조건</label> 
             <select id="schType" name="schType" class="form-select">
                 <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
                 <option value="name" ${schType=="name"?"selected":""}>작성자</option>
                 <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
             </select>
         </div>
         <div class="col-md-4">
             <label for="kwd" class="form-label">검색어</label> 
             <input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
         </div>
         <div class="col-auto">
             <button type="submit" class="btn btn-primary">검색</button>
         </div>
     </form>

    <!-- 공지/게시글 목록 -->
    <table class="table table-hover align-middle">
        <thead class="table-light text-center">
            <tr>
                <th style="width: 80px;">번호</th>
                <th>제목</th>
                <th style="width: 120px;">작성자</th>
                <th style="width: 120px;">작성일</th>
                <th style="width: 80px;">조회수</th>
                <th style="width: 60px;">첨부</th>
            </tr>
        </thead>
        <tbody>
            <!-- 공지글 -->
            <c:forEach var="dto" items="${noticeList}">
                <tr class="text-center">
                    <td><span class="badge bg-success">공지</span></td>
                    <td class="text-start">
                        <a href="${pageContext.request.contextPath}/notice/article/${dto.noticeId}?page=${page}" 
                           class="text-decoration-none fw-semibold">${dto.subject}</a>
                    </td>
                    <td>${dto.name}</td>
                    <td>${dto.regDate}</td>
                    <td>${dto.hitCount}</td>
                    <td>
                        <c:if test="${dto.fileCount != 0}">
                          <i class="bi bi-paperclip"></i>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>

            <!-- 일반글 -->
            <c:forEach var="dto" items="${list}" varStatus="status">
                <tr class="text-center">
                    <td>${dataCount - (page-1) * size - status.index}</td>
                    <td class="text-start">
                        <a href="${pageContext.request.contextPath}/notice/article/${dto.noticeId}?page=${page}" 
                           class="text-decoration-none">${dto.subject}</a>
                        <c:if test="${dto.gap < 1}">
                            <span class="new-text">NEW</span>
                        </c:if>
                    </td>
                    <td>${dto.name}</td>
                    <td>${dto.regDate}</td>
                    <td>${dto.hitCount}</td>
                    <td>
                        <c:if test="${dto.fileCount != 0}">
                          <i class="bi bi-paperclip"></i>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>

            <!-- 글 없음 -->
            <c:if test="${dataCount == 0}">
                <tr>
                    <td colspan="6" class="text-center">등록된 게시물이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- 페이징 -->
    <div class="page-navigation">
        ${dataCount == 0 ? "" : paging}
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
