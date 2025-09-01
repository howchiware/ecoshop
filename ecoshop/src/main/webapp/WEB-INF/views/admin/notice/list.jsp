<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자페이지</title>
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssAdmin/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin_paginate.css">
<style type="text/css">

</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="right-panel">
  	<div class="title">
		<h3>공지사항</h3>
	</div>
	<hr>
<div class="board-container row">
    <!-- 상단 정보 및 검색 -->
<div class="row-md-6 text-end">
      <form name="form-search" method="get" class="form-search">
          <select name="schType" class="form-select">
            <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
            <option value="name" ${schType=="name"?"selected":""}>글쓴이</option>
            <option value="regDate" ${schType=="regDate"?"selected":""}>작성일</option>
            <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
            <option value="content" ${schType=="content"?"selected":""}>내용</option>
          </select>
          <input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
          <button type="submit" class="my-btn" onclick="searchList()">조회</button>
      </form>
    </div>
    
        <span class="dataCount">글목록 ${dataCount}개(${page}/${total_page} 페이지)</span>
    <!-- 테이블 -->

      <div class="col">
      <table class="table table-hover board-list">
        <thead class="table-light">
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>첨부</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="dto" items="${noticeList}">
            <tr class="hover-cursor" onclick="profile('${dto.memberId}', '${page}');">
              <td><span class="badge bg-success text-white">공지</span></td>
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
            </tr>
          </c:forEach>

          <!-- 일반 게시물 -->
          <c:forEach var="dto" items="${list}" varStatus="status">
            <tr class="text-center">
              <td>${dataCount - (page - 1) * size - status.index}</td>
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
		  <span class="badge bg-success text-white ms-1">NEW</span>
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
    <div class="form-search">
	  <button type="button" class="btn my-btn"
	    onclick="location.href='${pageContext.request.contextPath}/admin/notice/write';">
	    <i class="bi bi-pencil-square"></i> 글쓰기
	  </button>
	      </div>
     	<div style="padding-top: 10px;" class="page-navigation">
        	${dataCount == 0 ? " " : paging}
    	</div>
    </div>
</div>
</main>

</body>
</html>