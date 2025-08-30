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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/cssWorkshop/workshopUser.css">
<style type="text/css">
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

		<div class="row g-1 mb-4">
			<div class="col-md-6">
				<img src="${mainImg}" alt="<c:out value='${dto.workshopTitle}'/>"
					class="workshop-main-img"
					onerror="if(this.src.indexOf('noimage.png')===-1)this.src='${pageContext.request.contextPath}/dist/images/noimage.png'">
			</div>
			<div class="col-md-5 ps-md-4">
				<div class="detail-card">
					<div class="simple-panel">

						<h2 class="simple-title">
							<c:out value="${dto.workshopTitle}" />
						</h2>

						<div class="simple-meta">
							<div class="rowline">
								<div class="k">일정</div>
								<div class="v">
									<c:choose>
										<c:when test="${not empty dto.scheduleDate}">
											<fmt:formatDate value="${dto.scheduleDate}"
												pattern="yyyy.MM.dd (E) HH:mm" />
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="rowline">
								<div class="k">장소</div>
								<div class="v">
									<c:out value="${dto.location}" />
								</div>
							</div>

							<div class="rowline">
								<div class="k">강사</div>
								<div class="v">
									<c:choose>
										<c:when test="${not empty dto.managerName}">
											<c:out value="${dto.managerName}" />
											<c:if test="${not empty dto.managerDept}">
          (<c:out value="${dto.managerDept}" />)
        </c:if>
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="rowline">
								<div class="k">정원</div>
								<div class="v">
									<c:out value="${dto.capacity}" />
									명
								</div>
							</div>
							<div class="rowline">
								<div class="k">참가비</div>
								<div class="v">무료</div>
							</div>
							<div class="rowline">
								<div class="k">모집 마감</div>
								<div class="v">
									<c:choose>
										<c:when test="${not empty dto.applyDeadline}">
											<fmt:formatDate value="${dto.applyDeadline}"
												pattern="yyyy.MM.dd (E) HH:mm" />
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>

						<!-- 버튼 -->
						<div class="simple-actions">
							<c:url var="applyUrl" value="/workshop/apply">
								<c:param name="workshopId" value="${dto.workshopId}" />
							</c:url>

							<c:choose>
								<c:when test="${alreadyApplied}">
									<button type="button"
										class="btn btn-outline-secondary w-100 text-white"
										style="opacity: 1" disabled>신청 완료</button>
								</c:when>

								<c:when
									test="${dto.workshopStatus == 0 || dto.workshopStatus == 2 || dto.applyDeadline.time lt now.time}">
									<button type="button" class="btn btn-secondary w-100" disabled>신청
										불가</button>
								</c:when>

								<c:otherwise>
									<a href="${applyUrl}" class="btn btn-dark w-100">지금 신청하기</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>


		<ul class="nav nav-tabs nav-justified mt-3" id="workshopTabs"
			role="tablist">
			<li class="nav-item"><button class="nav-link active"
					data-bs-toggle="tab" data-bs-target="#intro" type="button"
					style="font-weight: 600;">워크샵 소개</button></li>
			<li class="nav-item"><button class="nav-link"
					data-bs-toggle="tab" data-bs-target="#reviews" type="button"
					style="font-weight: 600;">후기</button></li>
			<li class="nav-item"><button class="nav-link"
					data-bs-toggle="tab" data-bs-target="#faq" type="button"
					style="font-weight: 600;">FAQ</button></li>
		</ul>

		<div class="tab-content border border-top-0 p-3">
			<div class="tab-pane fade show active" id="intro">
				<div class="mb-3 mt-3">
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
				<div class="mb-1">
					<div class="form-floating">
						<textarea id="reviewContent" class="form-control"
							style="height: 100px" placeholder="후기를 남겨주세요."></textarea>
						<!-- <label for="reviewContent">참여 후기를 남겨주세요.</label> -->
					</div>
					<div class="d-flex justify-content-between align-items-center mt-2">
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

				<div id="reviewList" class="py-2 text-start">로딩 중...</div>
			</div>

			<div class="tab-pane fade" id="faq">
				<div id="faqList" class="py-2 text-start">로딩 중...</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
	const ctx = '${pageContext.request.contextPath}';
	 const workshopId = Number('<c:out value="${dto.workshopId}" />') || null;
	 
	 function loadFaq(){
		  const $faqList = $("#faqList");
		  const url = ctx + "/workshop/faq/list";
		  if (!workshopId) { $faqList.html("<div class='text-danger py-3'>워크샵 ID가 없습니다.</div>"); return; }
		  $faqList.text("로딩 중...");

		  $.ajax({ url: url, method: "GET", data: { workshopId: workshopId, page: 1 }, dataType: "json", cache: false })
		  .done(function(data){
		    var arr = Array.isArray(data) ? data
		            : Array.isArray(data.list) ? data.list
		            : Array.isArray(data.faqs) ? data.faqs
		            : Array.isArray(data.items) ? data.items : [];

		    if (!arr.length){
		      $faqList.html("<div class='text-muted py-3'>등록된 FAQ가 없습니다.</div>");
		      return;
		    }

		    // 아코디언 컨테이너
		    var $acc = $('<div/>', { "class": "accordion" });

		    arr.forEach(function(f){
		      var q = (f && f.question) ? String(f.question) : "";
		      var a = (f && f.answer)   ? String(f.answer)   : "";

		      var $item = $('<div/>', { "class": "accordion-item" });

		      // 헤더(버튼)
		      var $h   = $('<h2/>', { "class": "accordion-header" });
		      var $btn = $('<button/>', { "class": "accordion-button collapsed", type: "button" });
		      $btn.append($('<span/>', { "class": "mark-q", text: "Q." }))
		          .append(document.createTextNode(" " + q));
		      $h.append($btn);

		      // 본문(슬라이드용 pane)
		      var $pane = $('<div/>', { "class": "accordion-pane", style: "display:none;" });
		      var $body = $('<div/>', { "class": "accordion-body d-flex align-items-start" })
		                    .append($('<span/>', { "class": "mark-a", text: "A." }))
		                    .append($('<div/>', { "class": "text-body flex-grow-1 ms-2" }).text(a));
		      $pane.append($body);

		      $item.append($h).append($pane);
		      $acc.append($item);
		    });

		    $faqList.empty().append($acc);

		    $faqList.off("click.faq", ".accordion-button")
		            .on("click.faq", ".accordion-button", function(e){
		              e.preventDefault();
		              var $btn  = $(this);
		              var $item = $btn.closest(".accordion-item");
		              var $pane = $item.children(".accordion-pane").first();
		              var $acc  = $item.closest(".accordion");

		              var willOpen = !$pane.is(":visible");

		              $acc.find(".accordion-pane:visible").not($pane).each(function(){
		                $(this).stop(true,true).slideUp(160);
		                $(this).closest(".accordion-item")
		                       .children(".accordion-header")
		                       .find(".accordion-button").addClass("collapsed");
		              });

		              if (willOpen){
		                $pane.stop(true,true).slideDown(160);
		                $btn.removeClass("collapsed");
		              } else {
		                $pane.stop(true,true).slideUp(160);
		                $btn.addClass("collapsed");
		              }
		            });
		  })
		  .fail(function(xhr){
		    $faqList.html("<div class='text-danger py-3'>FAQ 로딩 실패 (" + xhr.status + ")</div>");
		    console.error("[FAQ] 요청 실패:", xhr.status, (xhr.responseText||"").slice(0,300));
		  });
		}


  //후기 목록
  function loadReviews(page = 1){
    const $list = $("#reviewList");
    if (!workshopId){
      $list.html("<div class='text-danger py-3'>워크샵 ID가 없습니다.</div>");
      return;
    }
    $list.text("로딩 중...");

    $.getJSON(`${ctx}/workshop/review/list`, { workshopId, page })
      .done(function(data){
        const arr = Array.isArray(data?.list) ? data.list : [];
        if (!arr.length){
          $list.html("<div class='text-muted py-3'>등록된 후기가 없습니다.</div>");
          return;
        }
        let html = "";
        $list.empty();
        arr.forEach(function(r){
          const name    = r?.writerName || "익명";
          const date    = r?.regDateStr || (r?.regDate ? String(r.regDate).substring(0,10) : "");
          const content = r?.reviewContent || "";

          const $item = $('<div/>', { class: 'review-item' });
          $item.append(
            $('<div/>', { class: 'small text-muted' }).text([name, date].filter(Boolean).join(' | '))
          );
          $item.append(
            $('<div/>', { class: 'content text-body' }).text(content)
          );

          $list.append($item);
        });
      })
      .fail(function(xhr){
        $list.html(`<div class='text-danger py-3'>후기 로딩 실패 (${xhr.status})</div>`);
        console.error('[reviews] fail', xhr.status, xhr.responseText?.slice?.(0,200));
      });
  }

  // 후기 등록
  $(document).on('click','#reviewSubmitBtn', function(){
    const $btn = $(this);
    const participantId = $("#participantId").val();
    const reviewContent = ($("#reviewContent").val()||"").trim();

    if (!reviewContent){ alert("내용을 입력하세요."); return; }
    if (!participantId){ alert("출석 확인된 참가자만 작성 가능합니다."); return; }
    if (!workshopId){ alert("워크샵 정보가 없습니다."); return; }

    $btn.prop('disabled', true);
    $.ajax({
      url: `${ctx}/workshop/review/submit`, 
      type: 'POST',
      data: { workshopId, participantId, reviewContent },
      dataType: 'json'
    })
    .done(function(res){
      if (res && res.success){
        $("#reviewContent").val("");
        loadReviews(1);
      } else {
        const msg = res?.error === 'login_required' ? '로그인 후 이용해주세요.'
                  : res?.error === 'not_allowed'     ? '본인의 출석만 후기 등록할 수 있습니다.'
                  : res?.error === 'duplicate'        ? '이미 후기를 등록하셨습니다.'
                  : '등록 실패';
        alert(msg);
      }
    })
    .fail(function(xhr){
      alert('네트워크 오류');
      console.error('[review submit] fail', xhr.status, xhr.responseText?.slice?.(0,200));
    })
    .always(function(){ $btn.prop('disabled', false); });
  });

  document.addEventListener('DOMContentLoaded', function(){
    let reviewLoaded = false, faqLoaded = false;
    const $reviewsTabBtn = $('#workshopTabs button[data-bs-target="#reviews"]');
    const $faqTabBtn     = $('#workshopTabs button[data-bs-target="#faq"]');

    $reviewsTabBtn.on('shown.bs.tab', function(){
      if(!reviewLoaded){ loadReviews(); reviewLoaded = true; }
    });
    $faqTabBtn.on('shown.bs.tab', function(){
      if(!faqLoaded){ loadFaq(); faqLoaded = true; }
    });

    const hash = window.location.hash;
    if (hash === '#faq')    { $faqTabBtn.trigger('shown.bs.tab'); loadFaq(); faqLoaded = true; }
    if (hash === '#reviews'){ $reviewsTabBtn.trigger('shown.bs.tab'); loadReviews(); reviewLoaded = true; }
  });
</script>

</body>
</html>
