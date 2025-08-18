<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 챌린지 목록</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/main2.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>
  .table thead th { white-space:nowrap; }
  .badge { font-size:12px; }
  .admin-main-container { display:flex; }
  .admin-sidebar { width:250px; flex-shrink:0; }
  .admin-content { flex-grow:1; margin-left:20px; }

  /* Paging UI */
  .paging-wrap{
    display:flex; justify-content:center; align-items:center;
    gap:10px; margin:26px 0 10px; font-size:18px;
  }
  .paging-wrap a, .paging-wrap span{
    display:inline-flex; align-items:center; justify-content:center;
    min-width:44px; height:44px; padding:0 14px;
    border:1px solid #e5e7eb; border-radius:9999px;
    background:#fff; color:#334155; text-decoration:none;
    box-shadow:0 1px 2px rgba(0,0,0,.04);
  }
  .paging-wrap a:hover{ background:#f8fafc; }
  .paging-wrap .current,
  .paging-wrap span.current,
  .paging-wrap span:has(> b){
    background:#0d6efd; border-color:#0d6efd; color:#fff; font-weight:700;
  }
  .paging-wrap a[rel="prev"], .paging-wrap a.prev,
  .paging-wrap a[rel="next"], .paging-wrap a.next{ padding:0 16px; min-width:48px; }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<c:set var="cp" value="${pageContext.request.contextPath}" />

<div class="container my-4 admin-main-container">
  <div class="admin-sidebar">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
  </div>

  <div class="admin-content">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="mb-0">챌린지 목록</h3>
      <a href="${cp}/admin/challengeManage/write" class="btn btn-success">등록</a>
    </div>

    <form class="row g-2 mb-3" method="get" action="${cp}/admin/challengeManage/list">
      <div class="col-md-3">
        <input type="text" class="form-control" name="kwd" value="${kwd}" placeholder="제목/내용 검색">
      </div>
      <div class="col-md-3">
        <select name="challengeType" class="form-select">
          <option value="">전체 타입</option>
          <option value="DAILY"  <c:if test="${challengeType=='DAILY'}">selected</c:if>>DAILY</option>
          <option value="SPECIAL"<c:if test="${challengeType=='SPECIAL'}">selected</c:if>>SPECIAL</option>
        </select>
      </div>
      <div class="col-md-3">
        <select name="weekday" class="form-select">
          <option value="">요일(DAILY 전용)</option>
          <c:forEach var="i" begin="0" end="6">
            <option value="${i}" <c:if test="${weekday==i}">selected</c:if>>
              <c:choose>
                <c:when test="${i==0}">일</c:when>
                <c:when test="${i==1}">월</c:when>
                <c:when test="${i==2}">화</c:when>
                <c:when test="${i==3}">수</c:when>
                <c:when test="${i==4}">목</c:when>
                <c:when test="${i==5}">금</c:when>
                <c:otherwise>토</c:otherwise>
              </c:choose>
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-3">
        <button class="btn btn-outline-secondary w-100">검색</button>
      </div>
    </form>

    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
          <tr>
            <th style="width:90px;">ID</th>
            <th>제목</th>
            <th style="width:120px;">타입</th>
            <th style="width:120px;">요일/기간</th>
            <th style="width:150px;">등록일</th>
            <th style="width:160px;">관리</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="d" items="${list}">
            <%-- 상세 링크를 c:url로 안전하게 생성(인코딩 포함) --%>
            <c:url var="articleLink" value="${cp}/admin/challengeManage/article">
              <c:param name="challengeId" value="${d.challengeId}"/>
              <c:param name="page" value="${page}"/>
              <c:if test="${not empty kwd}">
                <c:param name="kwd" value="${kwd}"/>
              </c:if>
              <c:if test="${not empty challengeType}">
                <c:param name="challengeType" value="${challengeType}"/>
              </c:if>
              <c:if test="${weekday ne null}">
                <c:param name="weekday" value="${weekday}"/>
              </c:if>
            </c:url>

            <tr>
              <td>${d.challengeId}</td>
              <td><a href="${articleLink}">${d.title}</a></td>
              <td>
                <c:choose>
                  <c:when test="${d.challengeType=='DAILY'}"><span class="badge bg-info">DAILY</span></c:when>
                  <c:when test="${d.challengeType=='SPECIAL'}"><span class="badge bg-primary">SPECIAL</span></c:when>
                  <c:otherwise><span class="badge bg-secondary">-</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${d.challengeType=='DAILY'}">
                    <span class="badge bg-light text-dark">
                      <c:choose>
                        <c:when test="${d.weekday==0}">일</c:when>
                        <c:when test="${d.weekday==1}">월</c:when>
                        <c:when test="${d.weekday==2}">화</c:when>
                        <c:when test="${d.weekday==3}">수</c:when>
                        <c:when test="${d.weekday==4}">목</c:when>
                        <c:when test="${d.weekday==5}">금</c:when>
                        <c:otherwise>토</c:otherwise>
                      </c:choose>
                    </span>
                  </c:when>
                  <c:when test="${d.challengeType=='SPECIAL'}">
                    <small>${d.startDate} ~ ${d.endDate}</small>
                  </c:when>
                </c:choose>
              </td>
              <td>${d.challengeRegDate}</td>
              <td>
                <a class="btn btn-sm btn-outline-secondary"
                   href="${cp}/admin/challengeManage/update?challengeId=${d.challengeId}">수정</a>
                <a class="btn btn-sm btn-outline-danger"
                   href="${cp}/admin/challengeManage/delete?challengeId=${d.challengeId}&page=${page}"
                   onclick="return confirm('삭제하시겠습니까?');">삭제</a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty list}">
            <tr><td colspan="6" class="text-center text-muted py-5">데이터가 없습니다.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>

    <div class="paging-wrap">
      ${paging}
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
