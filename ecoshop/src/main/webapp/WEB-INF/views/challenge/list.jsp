<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG"
	value="${pageContext.request.contextPath}/uploads/challenge/no-image.png" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Challenge</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${cp}/dist/css/home.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>

.section {
	padding: 36px 0;
}

.page-title {
	padding: 24px 0 10px;
}

.page-title h1 {
	font-weight: 700;
	margin: 0 0 6px;
}

.page-title-underline-accent {
	width: 400px;
	height: 4px;
	background: linear-gradient(135deg, #4caf50, #2e7d32);
	border-radius: 4px;
	margin: 8px auto 0;
}

/*  요일 버튼  */
.weekday-wrap {
	overflow-x: auto;
	white-space: nowrap;
	padding: 8px 2px 12px;
	text-align: center;
}

.weekday-btn {
	display: inline-block;
	margin-right: 8px;
	padding: 10px 14px;
	background: #f4f7fb;
	border: 1px solid #dbe3ee;
	border-radius: 12px;
	color: #516178;
	font-weight: 600;
	cursor: pointer;
	transition: .2s;
}

.weekday-btn[data-active="true"] {
	background: #12131a;
	color: #fff;
	border-color: #12131a;
}


.daily-card {
	border: 1px solid #e9eef6;
	border-radius: 16px;
	background: #fff;
	overflow: hidden;
	box-shadow: 0 6px 18px rgba(28, 47, 88, 0.06);
}

.daily-media {
	width: 100%;
	aspect-ratio: 16/9;
	background: #eef3f9 center/cover no-repeat;
}

.daily-body {
	padding: 20px;
}

.daily-title {
	margin: 0 0 6px;
	font-size: 20px;
	font-weight: 700;
	color: #1e293b;
}

.daily-desc {
	color: #65748a;
	margin-bottom: 12px;
}

.daily-meta {
	display: flex;
	gap: 10px;
	align-items: center;
	margin-bottom: 14px;
}

.badge-soft {
	background: #f3f6fb;
	color: #627089;
	border: 1px solid #e6edf7;
	padding: 4px 10px;
	border-radius: 999px;
	font-weight: 600;
	font-size: 12px;
}

.btn-ghost {
	border: 1px solid #dbe3ee;
	background: #fff;
	color: #1f2a44;
	font-weight: 700;
	padding: 10px 16px;
	border-radius: 10px;
}

.btn-primary-grad {
	border: none;
	color: #fff;
	font-weight: 700;
	padding: 10px 18px;
	border-radius: 10px;
	background: linear-gradient(135deg, #4caf50, #2e7d32);
}

.btn-primary-grad[disabled], .btn-more[disabled] {
	filter: grayscale(.25);
	opacity: .6;
	cursor: not-allowed;
}

/*  스페셜 카드 */
.special-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 18px;
}

@media ( max-width : 991px) {
	.special-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 575px) {
	.special-grid {
		grid-template-columns: 1fr;
	}
}

.card {
	border: 1px solid #e9eef6;
	border-radius: 16px;
	background: #fff;
	overflow: hidden;
	box-shadow: 0 6px 18px rgba(28, 47, 88, 0.06);
	display: flex;
	flex-direction: column;
}

.card-thumb {
	width: 100%;
	aspect-ratio: 16/10;
	background: #eef3f9 center/cover no-repeat;
}

.card-body {
	padding: 16px;
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.card-title {
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #1e293b;
}

.card-desc {
	color: #65748a;
	height: 3.1em;
	overflow: hidden;
}

.card-foot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: auto;
}

.btn-more {
	display: block;
	margin: 18px auto 0;
	border: 1px solid #dbe3ee;
	background: #fff;
	color: #1f2a44;
	font-weight: 700;
	padding: 12px 18px;
	border-radius: 12px;
}

.page-title:first-of-type {
	padding-top: 56px;
}

@media ( max-width : 575.98px) {
	.page-title:first-of-type {
		padding-top: 36px;
	}
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>

		<!-- Page Title - 데일리 -->
		<div class="page-title">
			<div class="container text-center align-items-center"
				data-aos="fade-up">
				<h1>🎯 오늘의 챌린지</h1>
				<p>데일리 챌린지 프로그램에 참여하고 목표에 달성해보세요!</p>
				<div class="page-title-underline-accent"></div>
			</div>
		</div>

		<!-- 데일리 콘텐츠 -->
		<div class="section">
			<div class="container" data-aos="fade-up" data-aos-delay="50">

				<!-- 요일 버튼 -->
				<div class="weekday-wrap" id="weekdayWrap">
					<c:forEach var="d" items="${weekly}">
						<button class="weekday-btn" data-weekday="${d.weekday}"
							data-challenge-id="${d.challengeId}">
							<c:choose>
								<c:when test="${d.weekday==0}">일요일</c:when>
								<c:when test="${d.weekday==1}">월요일</c:when>
								<c:when test="${d.weekday==2}">화요일</c:when>
								<c:when test="${d.weekday==3}">수요일</c:when>
								<c:when test="${d.weekday==4}">목요일</c:when>
								<c:when test="${d.weekday==5}">금요일</c:when>
								<c:otherwise>토요일</c:otherwise>
							</c:choose>
						</button>
					</c:forEach>
				</div>

				<!-- 오늘의 데일리 카드 -->
				<div class="row justify-content-center">
					<div class="col-12 col-md-10 col-lg-8 col-xl-7 my-3">
						<div class="daily-card" id="dailyCard">
							<c:choose>
								<c:when test="${not empty today.thumbnail}">
									<c:url var="todayThumb"
										value="/uploads/challenge/${fn:escapeXml(today.thumbnail)}" />
									<div class="daily-media"
										style="background-image:url('${todayThumb}')"></div>
								</c:when>
								<c:otherwise>
									<div class="daily-media"></div>
								</c:otherwise>
							</c:choose>

							<div class="daily-body">
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:formatDate value="${now}" pattern="u" var="dowStr" />
								<fmt:parseNumber integerOnly="true" value="${dowStr}" var="dow" />
								<c:set var="realTodayIdx0to6" value="${dow == 7 ? 0 : dow}" />
								<fmt:parseNumber integerOnly="true" value="${today.weekday}"
									var="challengeDow" />
								<c:set var="canPlayDaily"
									value="${not empty challengeDow and realTodayIdx0to6 == challengeDow}" />

								<div class="d-flex justify-content-between align-items-center">
									<h2 class="daily-title">${empty today.title ? '데일리 챌린지' : today.title}</h2>
									<div class="badge-soft">
										+
										<c:out
											value="${empty today.rewardPoints ? 0 : today.rewardPoints}" />
										P
									</div>
								</div>

								<p class="daily-desc">${empty today.description ? '참여하고 포인트를 받으세요.' : today.description}</p>

								<div class="daily-meta">
									<c:if
										test="${not empty challengeDow and realTodayIdx0to6 == challengeDow}">
										<span class="badge-soft">TODAY</span>
									</c:if>
									<span class="badge-soft"> <c:choose>
											<c:when test="${not empty challengeDow}">
												<c:choose>
													<c:when test="${challengeDow==0}">일</c:when>
													<c:when test="${challengeDow==1}">월</c:when>
													<c:when test="${challengeDow==2}">화</c:when>
													<c:when test="${challengeDow==3}">수</c:when>
													<c:when test="${challengeDow==4}">목</c:when>
													<c:when test="${challengeDow==5}">금</c:when>
													<c:otherwise>토</c:otherwise>
												</c:choose>요일
                    						</c:when>
											<c:otherwise>요일</c:otherwise>
										</c:choose>
									</span>
								</div>

								<div class="d-flex gap-2">
									<a class="btn-ghost"
										href="${cp}/challenge/detail/${today.challengeId}">상세보기</a>

									<c:choose>
										<c:when test="${!isLogin}">
											<button id="btnDailyJoin" class="btn-primary-grad"
												data-href="${cp}/member/login?returnURL=${pageContext.request.requestURI}">
												로그인하고 참가하기</button>
										</c:when>


										<c:otherwise>
											<c:choose>
												<c:when test="${!canPlayDaily}">
													<button id="btnDailyJoin" class="btn-primary-grad" disabled>
														오늘만 참가 가능</button>
												</c:when>

												<c:when test="${alreadyDailyJoined}">
													<button id="btnDailyJoin" class="btn-primary-grad" disabled>
														오늘은 이미 참여하셨습니다</button>
												</c:when>

												<c:otherwise>
													<button id="btnDailyJoin" class="btn-primary-grad"
														data-href="${cp}/challenge/join/daily/${today.challengeId}">
														지금 참가하기</button>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>


								<c:if test="${!isLogin}">
									<div class="alert alert-warning mt-3" role="alert"
										style="border-radius: 12px;">🔐 로그인 후 챌린지에 참가할 수 있습니다.</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>


		<!-- Page Title - 스페셜 -->
		<div class="page-title">
			<div class="container text-center align-items-center mt-5"
				data-aos="fade-up">
				<h1>🎯 스페셜 챌린지</h1>
				<p>한 달 내 3일에 걸쳐 도전할 수 있는 스페셜 챌린지, 도전해 보세요!</p>
				<div class="page-title-underline-accent"></div>
			</div>
		</div>

		<!-- 스페셜 콘텐츠 -->
		<div class="section">
			<div class="container" data-aos="fade-up" data-aos-delay="50">
				<div id="specialGrid" class="special-grid">
					<c:forEach var="s" items="${list}">
						<div class="card" data-id="${s.challengeId}"
							data-end-date="${s.endDate}">
							<c:choose>
								<c:when test="${not empty s.thumbnail}">
									<c:url var="thumbUrl"
										value="/uploads/challenge/${fn:escapeXml(s.thumbnail)}" />
									<div class="card-thumb"
										style="background-image:url('${thumbUrl}')"></div>
								</c:when>
								<c:otherwise>
									<div class="card-thumb"></div>
								</c:otherwise>
							</c:choose>

							<div class="card-body">
								<h3 class="card-title">${empty s.title ? '-' : s.title}</h3>
								<p class="card-desc">${empty s.description ? '' : s.description}</p>

								<div class="card-foot">
									<span class="badge-soft">~ ${empty s.endDate ? '-' : s.endDate}</span>

									<div class="d-flex gap-2">
										<c:choose>
											<c:when test="${not empty s.challengeId}">
												<a class="btn-ghost"
													href="${cp}/challenge/detail/${s.challengeId}">상세보기</a>
											</c:when>
											<c:otherwise>
												<button class="btn-ghost" type="button" disabled
													title="상세 페이지 준비 중">상세보기</button>
											</c:otherwise>
										</c:choose>

										<c:set var="st" value="${statusMap[s.challengeId]}" />
										<c:choose>
											<c:when test="${st eq 'UPCOMING'}">
												<button class="btn-primary-grad btn-join-special"
													data-challenge-id="${s.challengeId}" data-status="UPCOMING"
													disabled>시작 전</button>
											</c:when>

											<c:when test="${st eq 'CLOSED'}">
												<button class="btn-primary-grad btn-join-special"
													data-challenge-id="${s.challengeId}" data-status="CLOSED"
													disabled>종료됨</button>
											</c:when>

											<c:otherwise>

												<c:choose>

													<c:when
														test="${isLogin and canJoinMap[s.challengeId] == false}">
														<button class="btn-primary-grad btn-join-special"
															data-challenge-id="${s.challengeId}" data-status="OPEN"
															disabled title="오늘은 참여할 수 없어요(연속 3일 규칙/하루 1회)">
															오늘은 참여 불가</button>
													</c:when>


													<c:otherwise>
														<button class="btn-primary-grad btn-join-special"
															data-challenge-id="${s.challengeId}" data-status="OPEN">
															지금 참가하기</button>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="text-center">
					<button id="btnMore" class="btn-more">더보기</button>
				</div>
			</div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<c:if test="${not empty message}">
		<script>alert('${fn:escapeXml(message)}');</script>
	</c:if>

	<script>
  const cp = "${cp}";
  const todayWeekday = ${empty targetWeekday ? -1 : targetWeekday};
  const IS_LOGIN = ${isLogin ? 'true' : 'false'};

  // 요일 버튼 활성화 + 가운데 스크롤
  (function initWeekday(){
    const wrap = document.getElementById('weekdayWrap');
    const btns = wrap.querySelectorAll('.weekday-btn');
    btns.forEach(btn=>{
      const isToday = Number(btn.dataset.weekday) === Number(todayWeekday);
      btn.dataset.active = isToday ? "true" : "false";
      btn.addEventListener('click', ()=> {
        location.href = cp + "/challenge/list?weekday=" + btn.dataset.weekday;
      });
    });
    const active = wrap.querySelector('.weekday-btn[data-active="true"]');
    if (active) {
      const center = active.offsetLeft - (wrap.clientWidth/2 - active.clientWidth/2);
      wrap.scrollTo({ left: Math.max(center,0), behavior: 'smooth' });
    }
  })();

  // 데일리: 해당 요일 아닐 때 안내
  (function dailyJoinGuard(){
    const btn = document.getElementById('btnDailyJoin');
    if (!btn) return;
    btn.addEventListener('click', (e)=>{
      if (btn.hasAttribute('disabled')) {
        alert('해당 데일리 챌린지는 지정된 요일에만 참여할 수 있어요!');
        e.preventDefault();
        return;
      }
      const href = btn.dataset.href;
      if (href) location.href = href;
    });
  })();

  // 스페셜 - 지금 참가하기(상태별 안내)
  (function joinSpecialInit(){
    const grid = document.getElementById('specialGrid');
    if (!grid) return;
    grid.addEventListener('click', (e)=>{
      const btn = e.target.closest('.btn-join-special');
      if(!btn) return;
      const id = btn.dataset.challengeId;
      const st = btn.dataset.status || 'OPEN';
      
      if (!id) return;

      
      if (!IS_LOGIN) {
        alert('로그인이 필요합니다. 로그인 후 참가해 주세요.');
        const returnURL = encodeURIComponent(location.pathname + location.search);
        location.href = cp + "/member/login?returnURL=" + returnURL;
        return;
      }

      // 상태 체크
      if (st !== 'OPEN' || btn.disabled) {
        if (st === 'UPCOMING') alert('아직 시작 전인 챌린지예요. 시작일에 참여할 수 있어요!');
        else if (st === 'CLOSED') alert('종료된 챌린지예요.');
        return;
      }

     
      location.href = cp + "/challenge/detail/" + id;
    });
  })();

  // 더보기 
  (function moreInit(){
    const grid = document.getElementById('specialGrid');
    const btn  = document.getElementById('btnMore');
    if(!btn) return;

    function pick(o, k) {
      if (!o) return undefined;
      if (o[k] !== undefined && o[k] !== null) return o[k];
      const up = k.toUpperCase();
      if (o[up] !== undefined && o[up] !== null) return o[up];
      return undefined;
    }
    function normalize(item){
      return {
        id:          pick(item, 'challengeId'),
        title:       pick(item, 'title') || '',
        description: pick(item, 'description') || '',
        thumbnail:   pick(item, 'thumbnail') || '',
        startDate:   pick(item, 'startDate') || '',
        endDate:     pick(item, 'endDate') || '',
        type:        pick(item, 'challengeType') || 'SPECIAL'
      };
    }

    function getLastCursor(){
      const cards = grid.querySelectorAll('.card');
      if(cards.length===0) return null;
      const last = cards[cards.length-1];
      const id = last.dataset.id && last.dataset.id !== 'undefined' ? last.dataset.id : null;
      const endDate = last.dataset.endDate && last.dataset.endDate !== 'undefined' ? last.dataset.endDate : null;
      return { id, endDate };
    }

    function statusOfSpecial(startDate, endDate){
      const today = new Date(); today.setHours(0,0,0,0);
      const s = startDate ? new Date(startDate) : null;
      const e = endDate   ? new Date(endDate)   : null;
      if (s && today < s) return 'UPCOMING';
      if (e && today > e) return 'CLOSED';
      return 'OPEN';
    }
    function ddayOf(startDate){
      if (!startDate) return null;
      const today = new Date(); today.setHours(0,0,0,0);
      const s = new Date(startDate);
      const diff = Math.ceil((s - today)/86400000);
      return diff >= 0 ? diff : null;
    }

    btn.addEventListener('click', async ()=>{
      btn.disabled = true; btn.textContent = "불러오는 중...";

      const params = new URLSearchParams();
      const cur = getLastCursor();
      if (cur && cur.id)      params.set('lastId', cur.id);
      if (cur && cur.endDate) params.set('lastEndDate', cur.endDate);
      params.set('size', '6');
      params.set('sort', 'CLOSE_DATE');

      try{
        const res = await fetch(cp + "/challenge/special/more?" + params.toString());
        const raw = await res.json();
        const items = Array.isArray(raw) ? raw.map(normalize) : [];
        if(!items.length){ btn.style.display='none'; return; }

        const frag = document.createDocumentFragment();

        items.forEach(function(it){
          const st   = statusOfSpecial(it.startDate, it.endDate);
          const dday = ddayOf(it.startDate);
          const hasId = !!it.id;

          const disabled = (!hasId || st!=='OPEN') ? ' disabled' : '';
          const btnText  = !hasId ? '준비 중' : (st==='UPCOMING' ? '시작 전' : (st==='CLOSED' ? '종료됨' : '지금 참가하기'));

          var badges = '';
          if (st === 'UPCOMING') badges += '<span class="badge-soft">예정' + (dday!=null ? ' D-' + dday : '') + '</span> ';
          if (st === 'OPEN')     badges += '<span class="badge-soft">진행중</span> ';
          if (st === 'CLOSED')   badges += '<span class="badge-soft">종료</span> ';

          const thumbUrl = it.thumbnail ? (cp + "/uploads/challenge/" + it.thumbnail) : null;
          const bg = thumbUrl ? ' style="background-image:url(\'' + thumbUrl + '\')"' : '';

          const el = document.createElement('div');
          el.className = 'card';
          if (hasId) el.dataset.id = it.id;
          if (it.endDate) el.dataset.endDate = it.endDate;

          var html = ''
            + '<div class="card-thumb"' + bg + '></div>'
            + '<div class="card-body">'
            +   '<h3 class="card-title">' + it.title + '</h3>'
            +   '<div class="d-flex gap-2 flex-wrap mb-1">' + badges + '</div>'
            +   '<p class="card-desc">' + it.description + '</p>'
            +   '<div class="card-foot">'
            +     '<span class="badge-soft">~ ' + (it.endDate || '') + '</span>'
            +     '<div class="d-flex gap-2">'
            +       (hasId
                      ? ('<a class="btn-ghost" href="' + cp + '/challenge/detail/' + it.id + '">상세보기</a>')
                      : '<button class="btn-ghost" type="button" disabled title="상세 페이지 준비 중">상세보기</button>')
            +       '<button class="btn-primary-grad btn-join-special"'
            +               ' data-challenge-id="' + (hasId ? it.id : '') + '"'
            +               ' data-status="' + st + '"' + disabled + '>'
            +         btnText
            +       '</button>'
            +     '</div>'
            +   '</div>'
            + '</div>';

          el.innerHTML = html;
          frag.appendChild(el);
        });

        grid.appendChild(frag);
      } catch(e) {
        alert('더보기 로딩 중 문제가 발생했어요. 잠시 후 다시 시도해주세요.');
        console.error(e);
      } finally {
        btn.disabled = false; btn.textContent = "더보기";
      }
    });
  })();
</script>

</body>
</html>
