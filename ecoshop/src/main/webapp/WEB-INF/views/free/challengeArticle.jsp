<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>챌린지 톡 - 인증글</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyList.css" type="text/css">


<style>
.article-title {
	font-weight: 700;
	font-size: 1.35rem;
}

.photo-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
	gap: 14px;
}

.photo-grid img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	border-radius: 10px;
}

.content-box {
	white-space: pre-wrap;
	line-height: 1.7;
}

.meta small {
	color: #6c757d;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container my-5">
		<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp" />


 <div class="row g-4 align-items-start">
    <!-- 왼쪽: 본문 -->
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-center mb-2">
            <div class="meta">
              <small class="me-3"><i class="bi bi-person"></i> ${post.memberName}</small>
              <small class="me-3"><i class="bi bi-calendar"></i> ${post.postRegDate}</small>
              <small class="badge bg-primary-subtle text-primary-emphasis">스페셜 ${post.dayNumber}일차</small>
            </div>
            <c:choose>
              <c:when test="${src == 'bundles'}">
                <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/free/challengeBundles">목록</a>
              </c:when>
              <c:otherwise>
                <a class="btn btn-outline-secondary btn-sm"
                   href="<c:url value='/free/challengeList'>
                          <c:if test='${not empty page}'><c:param name='page' value='${page}'/></c:if>
                          <c:if test='${not empty size}'><c:param name='size' value='${size}'/></c:if>
                          <c:if test='${not empty kwd}' ><c:param name='kwd'  value='${kwd}' /></c:if>
                        </c:url>">목록</a>
              </c:otherwise>
            </c:choose>
          </div>

          <h2 class="article-title mb-3">${post.title}</h2>

          <c:if test="${not empty photos}">
            <div class="photo-grid mb-4">
              <c:forEach var="p" items="${photos}">
                <!-- 보기 좋은 비율 썸네일 -->
                <div class="ratio ratio-4x3 rounded-3 overflow-hidden">
                  <img src="${pageContext.request.contextPath}/uploads/challenge/${p}"
                       class="w-100 h-100" style="object-fit:cover" alt="인증 사진">
                </div>
              </c:forEach>
            </div>
          </c:if>

          <div class="content-box">${post.content}</div>
        </div>
      </div>
    </div>

  
    <div class="col-lg-4">
      <div class="sticky-lg-top">
        <div class="card mb-3 shadow-sm">
          <div class="card-body">
            <div class="d-flex align-items-center mb-2">
              <i class="bi bi-trophy me-2"></i><strong>챌린지 정보</strong>
            </div>
            <ul class="list-unstyled small mb-0">
			  <li class="mb-1"><span class="text-muted">이름</span> :
			    <strong><c:out value="${challengeSummary.title}"/></strong></li>
			  <li class="mb-1"><span class="text-muted">기간</span> :
			    <c:out value="${challengeSummary.startDate}"/> ~
			    <c:out value="${challengeSummary.endDate}"/></li>
			  <li class="mb-1"><span class="text-muted">포인트</span> :
			    <strong><c:out value="${challengeSummary.rewardPoints}"/></strong></li>
			  <li class="mb-1"><span class="text-muted">총 일수</span> :
			    <c:out value="${challengeSummary.requireDays}"/>일</li>
			</ul>
			
			
			<c:if test="${empty challengeSummary}">
			  <div class="text-danger small">※ challengeSummary 요약이 비어있음</div>
			</c:if>

			

          </div>
        </div>

        <div class="card mb-3 shadow-sm">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-center">
			  <c:choose>
			    <c:when test="${prevPostId != null}">
			      <a class="btn btn-outline-secondary btn-sm"
			         href="${pageContext.request.contextPath}/free/challengeList/${prevPostId}">
			        <i class="bi bi-chevron-left"></i> 이전(일차)
			      </a>
			    </c:when>
			    <c:otherwise>
			      <a class="btn btn-outline-secondary btn-sm disabled" href="#" tabindex="-1" aria-disabled="true">
			        <i class="bi bi-chevron-left"></i> 이전(일차)
			      </a>
			    </c:otherwise>
			  </c:choose>
			
			  <div class="small text-muted">
			    <c:out value="${post.dayNumber}"/> / <c:out value="${challengeSummary.requireDays}"/>일
			  </div>
			
			  <c:choose>
			    <c:when test="${nextPostId != null}">
			      <a class="btn btn-outline-secondary btn-sm"
			         href="${pageContext.request.contextPath}/free/challengeList/${nextPostId}">
			        다음(일차) <i class="bi bi-chevron-right"></i>
			      </a>
			    </c:when>
			    <c:otherwise>
			      <a class="btn btn-outline-secondary btn-sm disabled" href="#" tabindex="-1" aria-disabled="true">
			        다음(일차) <i class="bi bi-chevron-right"></i>
			      </a>
			    </c:otherwise>
			  </c:choose>
			</div>


			
          </div>
        </div>

        
        <a class="btn btn-outline-primary w-100"
           href="${pageContext.request.contextPath}/free/challengeBundles">전체 인증 모아보기</a>
      </div>
    </div>
  </div>
</main>

<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>