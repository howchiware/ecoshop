<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내 챌린지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>


<style type="text/css">
/* 배지 색상 */
.badge-special { 
	background-color:#4b4b4b; 
	color:#fff; 
}
.badge-daily   { 
	background-color:#dcdcdc; 
	color:#333; 
	border:1px solid #cfcfcf; 
}

/* PaginateUtil  */
.page-navigation .paginate {
  display:flex; 
  justify-content:center; 
  align-items:center; 
  gap:6px; 
  flex-wrap:wrap;
}
.page-navigation a, .page-navigation strong, .page-navigation span {
   background: #fff;
   border-radius: 4px;
   padding: 3px 10px;
   color: #363636;
   font-weight: 500;
   text-decoration: none;
   cursor: pointer;
   transition: all 0.2s ease;
}

.page-navigation a:hover {
   background: #e0e0e0;
   border-color: #999;
}

.page-navigation .disabled {
   background: #f8f8f8;
   border-color: #ddd;
   color: #aaa;
   cursor: not-allowed;
}

.page-navigation strong, .page-navigation span {
   background: #ccc;
   border-color: #999;
   color: #333;
}


</style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<main class="main-container container my-4">
  <div class="row justify-content-center">
  
    <div class="col-md-2">
      <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>

    <div class="col-md-10">
    	<div class="contentsArea">
      <h3 class="pb-2 mb-4 border-bottom sub-title">내 챌린지</h3>
      
       <jsp:include page="/WEB-INF/views/myPage/challengeTabs.jsp"/> 

      <table class="table table-hover align-middle">
        <thead>
          <tr>
            <th>제목</th>
            <th style="width:110px;">타입</th>
            <th style="width:120px;">상태</th>
            <th style="width:150px;">참여일</th>
            <th style="width:120px;">인증수</th>
            <th style="width:160px;">마지막 인증일</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="d" items="${list}" varStatus="status">
            <tr>
              <td class="fw-semibold">
                <c:out value="${d.title}"/>
                <c:if test="${d.challengeType=='SPECIAL'}">
                  <div class="text-muted small">
                    <c:out value="${d.startDate}"/> ~ <c:out value="${d.endDate}"/>
                    <c:if test="${d.requireDays != null}"> · 연속 ${d.requireDays}일</c:if>
                  </div>
                </c:if>
              </td>
              <td>
                <span class="badge ${d.challengeType=='SPECIAL' ? 'badge-special' : 'badge-daily'}">
                  <c:out value="${d.challengeType}"/>
                </span>
              </td>
              <td>
                <c:choose>
                  <c:when test="${d.participationStatus==0}">진행 중</c:when>
                  <c:when test="${d.participationStatus==1}">승인대기</c:when>
                  <c:when test="${d.participationStatus==2}">완료</c:when>
                  <c:when test="${d.participationStatus==5}">중단</c:when>
                  <c:otherwise>기타(${d.participationStatus})</c:otherwise>
                </c:choose>
                <c:if test="${d.challengeType=='SPECIAL' && d.approvedDays != null}">
                  <div class="text-muted small">승인 일차: <c:out value="${d.approvedDays}"/>/<c:out value="${d.requireDays!=null?d.requireDays:3}"/></div>
                </c:if>
              </td>
              <td><c:out value="${d.participateDate}"/></td>
              <td><c:out value="${d.certCount}"/></td>
              <td><c:out value="${d.postRegDate}"/></td>
            </tr>
          </c:forEach>

          <c:if test="${empty list}">
            <tr><td colspan="6" class="text-center text-muted py-5">참여한 챌린지가 없습니다.</td></tr>
          </c:if>
        </tbody>
      </table>

      <!-- 페이징 -->
      <div class="page-navigation">
        ${paging}
      </div>
      </div>
    </div>
  </div>
</main>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>	
<script type="text/javascript" src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>


</body>
</html>
