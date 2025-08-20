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
	border-radius: 4px;
	background: #f8f9fa
}

.review-item, .faq-item {
	border-bottom: 1px solid #e9ecef;
	padding: 1rem 0
}

</style>

</head>
<body>
	<c:set var="now" value="<%=new java.util.Date()%>" />

	<c:if test="${not empty msg}">
		<script>alert("${msg}");</script>
		<c:remove var="msg" scope="session" />
	</c:if>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container py-4">

		<!-- 대표 이미지 선택 -->
		<c:set var="rawMain"
	value="${(not empty photoList and fn:length(photoList)>0) ? photoList[0].workshopImagePath : ''}" />
<c:choose>
	<c:when test="${empty rawMain}">
		<c:set var="mainImg"
			value='${pageContext.request.contextPath}/dist/images/noimage.png' />
	</c:when>
	<c:when
		test="${fn:startsWith(rawMain,'http://') or fn:startsWith(rawMain,'https://') or fn:startsWith(rawMain,'/')}">
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
		<h2 class="mb-2">
			<c:out value="${dto.workshopTitle}" />
		</h2>
		<p class="text-muted mb-2">
			일정 :
			<c:choose>
				<c:when test="${not empty dto.scheduleDate}">
					<fmt:formatDate value="${dto.scheduleDate}" pattern="yyyy.MM.dd" />
				</c:when>
				<c:otherwise>-</c:otherwise>
			</c:choose>
			<br> 장소 :
			<c:out value="${dto.location}" />
			<br> 정원 :
			<c:out value="${dto.capacity}" />
			명 
			<br> 모집 마감 :
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
				<button type="button" class="btn btn-secondary" disabled>신청 완료</button>
				<form
					action="${pageContext.request.contextPath}/workshop/apply/cancel"
					method="post" style="display: inline;">
					<input type="hidden" name="workshopId" value="${dto.workshopId}" />
					<button type="submit" class="btn btn-outline-danger"
						onclick="return confirm('정말 신청을 취소하시겠습니까?');">신청 취소</button>
				</form>
			</c:when>

			<c:when
				test="${dto.workshopStatus == 0 
           || dto.workshopStatus == 2 
           || dto.applyDeadline.time lt now.time}">
				<button type="button" class="btn btn-secondary" disabled>신청
					불가</button>
			</c:when>

			<c:otherwise>
				<a href="${applyUrl}" class="btn btn-dark">신청하기</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>



				<!-- 탭 -->
				<ul class="nav nav-tabs mt-3" id="workshopTabs" role="tablist">
					<li class="nav-item"><button class="nav-link active"
							data-bs-toggle="tab" data-bs-target="#intro" type="button">워크샵
							소개</button></li>
					<li class="nav-item"><button class="nav-link"
							data-bs-toggle="tab" data-bs-target="#reviews" type="button">후기</button></li>
					<li class="nav-item"><button class="nav-link"
							data-bs-toggle="tab" data-bs-target="#faq" type="button">FAQ</button></li>
				</ul>

				<div class="tab-content border border-top-0 p-3">
					<!-- 소개 -->
					<div class="tab-pane fade show active" id="intro">
						<div class="mb-3">
							<c:out value="${dto.workshopContent}" escapeXml="false" />
						</div>
						<div class="row g-3">
							<c:forEach var="p" items="${photoList}" varStatus="st">
								<c:if test="${st.index>0}">
									<c:set var="rawPhoto" value='${p.workshopImagePath}' />
									<c:choose>
										<c:when
											test="${fn:startsWith(rawPhoto,'http://') or fn:startsWith(rawPhoto,'https://') or fn:startsWith(rawPhoto,'/')}">
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

					<div class="tab-pane fade" id="reviews">
						<div class="mb-3">
							<div class="form-floating">
								<textarea id="reviewContent" class="form-control"
									style="height: 100px" placeholder="후기를 남겨주세요."></textarea>
								<!-- <label for="reviewContent">참여 후기를 남겨주세요.</label> -->
							</div>
							<div
								class="d-flex justify-content-between align-items-center mt-2">
								<small class="text-muted"> <c:choose>
										<c:when test="${empty participantId}">참여 완료 후 등록 가능합니다.</c:when>
										<c:otherwise>참여 완료된 사용자입니다. 후기를 등록할 수 있어요.</c:otherwise>
									</c:choose>
								</small>
								<button id="reviewSubmitBtn" type="button"
									class="btn btn-dark btn-sm">등록</button>
							</div>
							<input type="hidden" id="participantId" value="${participantId}" />
							<hr class="my-3">
						</div>

						<div id="reviewList" class="py-2 text-start text-muted">로딩
							중...</div>
					</div>

					<!-- FAQ -->
					<div class="tab-pane fade" id="faq">
						<div id="faqList" class="py-2 text-start text-muted">로딩 중...</div>
					</div>
				</div>
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
  const ctx='${pageContext.request.contextPath}';
  const workshopId=${dto.workshopId};

  // 후기 목록
  function loadReviews(page=1){
  $("#reviewList").html("로딩 중...");
  $.getJSON(ctx + "/workshop/review/list", { workshopId: workshopId, page: page }, function(data){
    if (!data || !Array.isArray(data.list) || data.list.length === 0) {
      $("#reviewList").html("<div class='text-muted py-3'>등록된 후기가 없습니다.</div>");
      return;
    }
    var html = "";
    data.list.forEach(function(r){
      var name = r.writerName || "익명";
      var date = r.regDateStr || (r.regDate ? String(r.regDate).substring(0,10) : "");
      var content = r.reviewContent || "";

      html += '<div class="review-item">'
           +    '<div class="small text-muted">' + name + ' | ' + date + '</div>'
           +    '<div>' + content + '</div>'
           +  '</div>';
    });
    $("#reviewList").html(html);
  }).fail(function(){
    $("#reviewList").html("<div class='text-danger py-3'>후기 로딩 실패</div>");
  });
}

  $(document).on('click','#reviewSubmitBtn',function(){
	  const participantId = $("#participantId").val();
	  const reviewContent = ($("#reviewContent").val()||"").trim();
	  if(!reviewContent){ alert("내용을 입력하세요."); return; }
	  if(!participantId){ alert("출석 확인된 참가자만 작성 가능합니다."); return; }

	  $.ajax({
	    url: `${ctx}/workshop/review/submit`,
	    type: 'POST',
	    data: { workshopId, participantId, reviewContent },
	    dataType: 'json'
	  })
	  .done(function(res){
	    if (typeof res === 'string') { try { res = JSON.parse(res); } catch(e) {} }
	    if (res && res.success === true) {
	      $("#reviewContent").val("");
	      loadReviews(1);
	    } else {
	      const msg = res?.error === 'login_required' ? '로그인 후 이용해주세요.'
	                : res?.error === 'not_attended'    ? '출석 확인된 참여자만 작성할 수 있어요.'
	                : res?.error === 'duplicate'       ? '이미 후기를 등록하셨습니다.'
	                : '등록 실패';
	      alert(msg);
	    }
	  })
	  .fail(function(xhr){
	    alert('네트워크 오류');
	    console.log('submit fail', xhr.status, xhr.responseText);
	  });
	});
  
// FAQ
function loadFaq(){
  $("#faqList").html("로딩 중...");
  $.getJSON(`${ctx}/workshop/faq/list`, { workshopId, page:1 }, function(data){
    if (!data || !Array.isArray(data.list) || data.list.length === 0) {
      $("#faqList").html("<div class='text-muted py-3'>등록된 FAQ가 없습니다.</div>");
      return;
    }
    let html = "";
    data.list.forEach(function(f){
      var q = (f.question || "");
      var a = (f.answer || "");
      html += '<div class="faq-item">'
           +    '<div class="fw-bold">Q. ' + q + '</div>'
           +    '<div class="text-muted">A. ' + a + '</div>'
           +  '</div>';
    });
    $("#faqList").html(html);
  }).fail(function(){
    $("#faqList").html("<div class='text-danger py-3'>FAQ 로딩 실패</div>");
  });
}

  // 탭 최초 진입 시만 로딩
  let reviewLoaded=false, faqLoaded=false;
  $('#workshopTabs button[data-bs-target="#reviews"]').on('shown.bs.tab',()=>{ if(!reviewLoaded){ loadReviews(); reviewLoaded=true; } });
  $('#workshopTabs button[data-bs-target="#faq"]').on('shown.bs.tab',()=>{ if(!faqLoaded){ loadFaq(); faqLoaded=true; } });
</script>
</body>
</html>
