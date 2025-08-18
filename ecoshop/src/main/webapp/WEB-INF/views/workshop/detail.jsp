<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><c:out value="${dto.workshopTitle}" /></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/home.css"
	type="text/css">

<style>
.workshop-main-img {
	width: 100%;
	aspect-ratio: 4/3;
	object-fit: cover;
	border-radius: 8px;
	background: #f8f9fa;
}

.review-item, .faq-item {
	border-bottom: 1px solid #e9ecef;
	padding: 1rem 0;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container py-4">

		<c:set var="rawMain"
			value="${(not empty photoList and fn:length(photoList) > 0) ? photoList[0].workshopImagePath : ''}" />
		<c:choose>
			<c:when test="${empty rawMain}">
				<c:set var="mainImg"
					value='${pageContext.request.contextPath}/dist/images/noimage.png' />
			</c:when>
			<c:when
				test="${fn:startsWith(rawMain, 'http://') 
                or fn:startsWith(rawMain, 'https://') 
                or fn:startsWith(rawMain, '/')}">
				<c:set var="mainImg" value='${rawMain}' />
			</c:when>
			<c:otherwise>
				<c:set var="mainImg"
					value='${pageContext.request.contextPath}/uploads/workshop/${rawMain}' />
			</c:otherwise>
		</c:choose>

		<div class="row g-4 mb-4">
			<div class="col-md-6">
				<img src="${mainImg}" alt="<c:out value='${dto.workshopTitle}'/>"
					class="workshop-main-img"
					onerror="if(this.src.indexOf('noimage.png')===-1)this.src='${pageContext.request.contextPath}/dist/images/noimage.png'">
			</div>
			<div class="col-md-6">
				<h2>
					<c:out value="${dto.workshopTitle}" />
				</h2>
				<p class="text-muted mb-2">
					일정:
					<c:choose>
						<c:when test="${not empty dto.scheduleDate}">
							<fmt:formatDate value="${dto.scheduleDate}" pattern="yyyy.MM.dd" />
						</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
					<br> 정원:
					<c:out value="${dto.capacity}" />
					명<br> 마감:
					<c:choose>
						<c:when test="${not empty dto.applyDeadline}">
							<fmt:formatDate value="${dto.applyDeadline}" pattern="MM.dd" />
						</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</p>

				<c:url var="applyUrl" value="/workshop/apply">
					<c:param name="workshopId" value="${dto.workshopId}" />
				</c:url>

				<c:choose>
					<c:when test="${alreadyApplied}">
						<button type="button" class="btn btn-secondary" disabled>이미
							신청된 워크샵</button>
					</c:when>

					<c:otherwise>
						<a href="${applyUrl}" class="btn btn-dark">신청하기</a>
					</c:otherwise>
				</c:choose>


				<ul class="nav nav-tabs" id="workshopTabs" role="tablist">
					<li class="nav-item"><button class="nav-link active"
							data-bs-toggle="tab" data-bs-target="#intro" type="button">워크샵
							소개</button></li>
					<li class="nav-item"><button class="nav-link"
							data-bs-toggle="tab" data-bs-target="#reviews" type="button">후기</button></li>
					<li class="nav-item"><button class="nav-link"
							data-bs-toggle="tab" data-bs-target="#faq" type="button">FAQ</button></li>
				</ul>

				<div class="tab-content border border-top-0 p-3">
					<div class="tab-pane fade show active" id="intro">
						<div class="mb-3">
							<c:out value="${dto.workshopContent}" escapeXml="false" />
						</div>
						<div class="row g-3">
							<c:forEach var="p" items="${photoList}" varStatus="st">
								<c:if test="${st.index > 0}">
									<c:set var="rawPhoto" value='${p.workshopImagePath}' />
									<c:choose>
										<c:when
											test="${fn:startsWith(rawPhoto, 'http://') 
                          or fn:startsWith(rawPhoto, 'https://') 
                          or fn:startsWith(rawPhoto, '/')}">
											<c:set var="photoUrl" value='${rawPhoto}' />
										</c:when>
										<c:otherwise>
											<c:set var="photoUrl"
												value='${pageContext.request.contextPath}/uploads/workshop/${rawPhoto}' />
										</c:otherwise>
									</c:choose>
									<div class="col-6 col-md-4">
										<img src="${photoUrl}" class="img-fluid rounded"
											onerror="if(this.src.indexOf('noimage.png')===-1)this.src='${pageContext.request.contextPath}/dist/images/noimage.png'">
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>

					<!-- 후기 -->
					<div class="tab-pane fade" id="reviews">
						<div id="reviewList" class="py-2 text-center text-muted">로딩
							중...</div>
					</div>

					<!-- FAQ -->
					<div class="tab-pane fade" id="faq">
						<div id="faqList" class="py-2 text-center text-muted">로딩
							중...</div>
					</div>
				</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<script>
const workshopId = ${dto.workshopId};

// 후기
function loadReviews(page=1) {
  $("#reviewList").html("로딩 중...");
  $.getJSON(`${'${pageContext.request.contextPath}'}/workshop/review/list`,
    { workshopId, page }, function(data) {
      if (!data.list || data.list.length === 0) {
        $("#reviewList").html("<div class='text-muted py-3'>등록된 후기가 없습니다.</div>");
        return;
      }
      let html = "";
      data.list.forEach(r => {
        html += `<div class="review-item text-start">
                  <div class="small text-muted">${r.regDate || ""}</div>
                  <p class="mb-0">${r.reviewContent || ""}</p>
                </div>`;
      });
      $("#reviewList").html(html);
    });
}

// FAQ
function loadFaq(page=1) {
  $("#faqList").html("로딩 중...");
  $.getJSON(`${'${pageContext.request.contextPath}'}/workshop/faq/list`,
    { workshopId, page }, function(data) {
      if (!data.list || data.list.length === 0) {
        $("#faqList").html("<div class='text-muted py-3'>등록된 FAQ가 없습니다.</div>");
        return;
      }
      let html = "";
      data.list.forEach(f => {
        html += `<div class="faq-item">
                  <div class="fw-bold">Q. ${f.question || ""}</div>
                  <div class="text-muted">A. ${f.answer || ""}</div>
                </div>`;
      });
      $("#faqList").html(html);
    });
}

let reviewLoaded=false, faqLoaded=false;
$('#workshopTabs button[data-bs-target="#reviews"]').on('shown.bs.tab', () => { if(!reviewLoaded){ loadReviews(); reviewLoaded=true; } });
$('#workshopTabs button[data-bs-target="#faq"]').on('shown.bs.tab', () => { if(!faqLoaded){ loadFaq(); faqLoaded=true; } });
</script>

</body>
</html>
