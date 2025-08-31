<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG" value="${cp}/uploads/challenge/no-image.png" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>관리자 - 인증 상세</title>

<link rel="stylesheet" href="<c:url value='/dist/css/main2.css'/>" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />

<style>
.detail-wrap{display:flex; gap:20px}
.detail-sidebar{width:250px; flex-shrink:0}
.detail-content{flex:1; min-width:0}

.badge-pill{border-radius:9999px; padding:.35rem .75rem; font-weight:700}
.pill-special{background:#e5e7eb; border:1px solid #d1d5db; color:#111827}
.pill-daily{background:#f3f4f6; border:1px solid #e5e7eb; color:#374151}

.photo-grid{display:grid; grid-template-columns:repeat(auto-fill,minmax(160px,1fr)); gap:10px}
.photo-grid img{width:100%; height:160px; object-fit:cover; border-radius:10px; border:1px solid #eaeef4; background:#f8fafc}

.kv{display:grid; grid-template-columns:120px 1fr; row-gap:6px; column-gap:12px}
.kv .k{color:#64748b}
.kv .v{color:#111827; font-weight:600}

.status-badge{display:inline-flex; align-items:center; gap:8px; height:24px; padding:0 10px; border-radius:9999px; background:#f3f4f6; border:1px solid #e5e7eb; color:#344054; font-size:12px; font-weight:700}
.status-badge::before{content:""; width:8px; height:8px; border-radius:50%; background:#cbd5e1}
.status-0::before{background:#64748b}
.status-1::before{background:#16a34a}
.status-2::before{background:#e11d48}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<div class="container my-4 detail-wrap">
  <div class="detail-sidebar">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
  </div>

  <div class="detail-content">
    <!-- breadcrumbs -->
    <div class="mb-3">
      <c:url var="backUrl" value="/admin/challengeManage/certList">
        <c:param name="page" value="${page}" />
        <c:if test="${not empty keyword}">
          <c:param name="keyword" value="${keyword}" />
        </c:if>
        <c:if test="${not empty type}">
          <c:param name="type" value="${type}" />
        </c:if>
        <c:if test="${approvalStatus ne null}">
          <c:param name="approvalStatus" value="${approvalStatus}" />
        </c:if>
      </c:url>
      <a class="text-decoration-none" href="${backUrl}">← 목록으로</a>
    </div>

    <div class="d-flex align-items-center justify-content-between mb-2">
      <h3 class="mb-0">인증 상세</h3>
      <div>
        <c:choose>
          <c:when test="${dto.challengeType=='SPECIAL'}">
            <span class="badge-pill pill-special">SPECIAL</span>
          </c:when>
          <c:otherwise>
            <span class="badge-pill pill-daily">DAILY</span>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- 상단 정보 -->
    <div class="card mb-3">
      <div class="card-body">
        <div class="kv">
          <div class="k">제목</div>
          <div class="v"><c:out value="${dto.title}" /></div>

          <div class="k">회원</div>
          <div class="v"><c:out value="${dto.memberName}" /> (#<c:out value="${dto.memberId}" />)</div>

          <div class="k">작성일</div>
          <div class="v"><c:out value="${dto.postRegDate}" /></div>

			<div class="k">상태</div>
			<div class="v">
			  <c:choose>
			    <c:when test="${dto.challengeType=='DAILY'}">
			      <span class="text-muted">자동</span>
			    </c:when>
			    <c:when test="${dto.approvalStatus==1}"><span class="status-badge status-1">승인</span></c:when>
			    <c:when test="${dto.approvalStatus==2}"><span class="status-badge status-2">반려</span></c:when>
			    <c:otherwise><span class="status-badge status-0">대기</span></c:otherwise>
			  </c:choose>
			</div>
			
			
			<c:if test="${dto.challengeType=='SPECIAL'}">
			 
			</c:if>



          <div class="k">유형/일차</div>
          <div class="v">
            <c:choose>
              <c:when test="${dto.challengeType=='SPECIAL'}">
                SPECIAL / Day <c:out value="${dto.dayNumber}" />
              </c:when>
              <c:otherwise>DAILY</c:otherwise>
            </c:choose>
          </div>

          <c:if test="${dto.challengeType=='SPECIAL'}">
            <div class="k">기간</div>
            <div class="v"><c:out value="${dto.startDate}" /> ~ <c:out value="${dto.endDate}" /></div>
          </c:if>

          <div class="k">포인트</div>
          <div class="v">+ <c:out value="${dto.rewardPoints}" /> P</div>
        </div>

        <hr/>

        <div>
          <div class="mb-2 fw-semibold">내용</div>
          <div class="p-3 border rounded bg-light"><c:out value="${dto.content}" /></div>
        </div>
      </div>
    </div>

    <!-- 사진 -->
    <c:if test="${not empty photos}">
      <div class="card mb-3">
        <div class="card-body">
          <div class="mb-2 fw-semibold">사진</div>
          <div class="photo-grid">
            <c:forEach var="p" items="${photos}">
              <img src="${cp}/uploads/challenge/${p}" onerror="this.onerror=null; this.src='${NOIMG}'" />
            </c:forEach>
          </div>
        </div>
      </div>
    </c:if>

	<!-- SPECIAL일 때만 승인/반려 버튼 노출 -->
	<c:if test="${dto.challengeType=='SPECIAL'}">
	  <div class="d-flex gap-2">
	    <form method="post" action="<c:url value='/admin/challengeManage/cert/approve'/>">
	      <input type="hidden" name="postId" value="${dto.postId}" />
	      <input type="hidden" name="page" value="${page}" />
	      <input type="hidden" name="keyword" value="${keyword}" />
	      <input type="hidden" name="type" value="${type}" />
	      <input type="hidden" name="approvalStatus" value="${approvalStatus}" />
	      <button class="btn btn-outline-primary" type="submit" ${dto.approvalStatus==1 ? 'disabled' : ''}>승인</button>
	    </form>
	
	    <form method="post" action="<c:url value='/admin/challengeManage/cert/reject'/>">
	      <input type="hidden" name="postId" value="${dto.postId}" />
	      <input type="hidden" name="page" value="${page}" />
	      <input type="hidden" name="keyword" value="${keyword}" />
	      <input type="hidden" name="type" value="${type}" />
	      <input type="hidden" name="approvalStatus" value="${approvalStatus}" />
	      <button class="btn btn-outline-danger" type="submit" ${dto.approvalStatus==2 ? 'disabled' : ''}>반려</button>
	    </form>
	  </div>
	</c:if>

    
    
    
    
  </div>
</div>

<!-- scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 플래시 메시지 토스트(선택적으로 certList와 동일하게 써도 됨) -->

</body>
</html>
