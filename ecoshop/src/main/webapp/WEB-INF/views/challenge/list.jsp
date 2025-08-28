<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG" value="${pageContext.request.contextPath}/uploads/challenge/no-image.png" />

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
/*  공통  */
.section { padding: 36px 0; }
.page-title { padding: 24px 0 10px; }
.page-title h1 { font-weight:700; margin:0 0 6px; }
.page-title-underline-accent { width:72px; height:4px; background:linear-gradient(90deg,#5e9cff,#8b5dff); border-radius:4px; }

/*  요일 버튼  */
.weekday-wrap { overflow-x:auto; white-space:nowrap; padding:8px 2px 12px; }
.weekday-btn {
  display:inline-block; margin-right:8px; padding:10px 14px;
  background:#f4f7fb; border:1px solid #dbe3ee; border-radius:12px; color:#516178;
  font-weight:600; cursor:pointer; transition:.2s;
}
.weekday-btn[data-active="true"] { background:#12131a; color:#fff; border-color:#12131a; }

/*  데일리 카드  */
.daily-card { border:1px solid #e9eef6; border-radius:16px; background:#fff; overflow:hidden; box-shadow:0 6px 18px rgba(28,47,88,0.06); }
.daily-media { width:100%; aspect-ratio: 16/10; background:#eef3f9 center/cover no-repeat; }
.daily-body { padding:20px; }
.daily-title { margin:0 0 6px; font-size:20px; font-weight:700; color:#1e293b; }
.daily-desc { color:#65748a; margin-bottom:12px; }
.daily-meta { display:flex; gap:10px; align-items:center; margin-bottom:14px; }
.badge-soft { background:#f3f6fb; color:#627089; border:1px solid #e6edf7; padding:4px 10px; border-radius:999px; font-weight:600; font-size:12px; }
.btn-ghost { border:1px solid #dbe3ee; background:#fff; color:#1f2a44; font-weight:700; padding:10px 16px; border-radius:10px; }
.btn-primary-grad { border:none; color:#fff; font-weight:700; padding:10px 18px; border-radius:10px;
  background:linear-gradient(90deg,#5e9cff,#8b5dff);
}
.btn-primary-grad[disabled] { filter:grayscale(.25); opacity:.6; cursor:not-allowed; }

/*  스페셜 카드 */
.special-grid { display:grid; grid-template-columns: repeat(3, 1fr); gap:18px; }
@media (max-width: 991px){ .special-grid{ grid-template-columns: repeat(2,1fr); } }
@media (max-width: 575px){ .special-grid{ grid-template-columns: 1fr; } }

.card { border:1px solid #e9eef6; border-radius:16px; background:#fff; overflow:hidden; box-shadow:0 6px 18px rgba(28,47,88,0.06); display:flex; flex-direction:column; }
.card-thumb { width:100%; aspect-ratio: 16/10; background:#eef3f9 center/cover no-repeat; }  
.card-body { padding:16px; display:flex; flex-direction:column; gap:8px; }
.card-title { margin:0; font-size:16px; font-weight:700; color:#1e293b; }
.card-desc { color:#65748a; height:3.1em; overflow:hidden; }
.card-foot { display:flex; justify-content:space-between; align-items:center; margin-top:auto; }
.btn-more { display:block; margin:18px auto 0; border:1px solid #dbe3ee; background:#fff; color:#1f2a44; font-weight:700; padding:12px 18px; border-radius:12px; }





</style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>

  <!-- Page Title - 데일리 -->
  <div class="page-title">
    <div class="container align-items-center" data-aos="fade-up">
      <h1>🎯 오늘의 챌린지</h1>
      <p>챌린지 프로그램에 참여하고 목표에 달성해보세요!</p>
      <div class="page-title-underline-accent"></div>
    </div>
  </div>

  <!-- 데일리 콘텐츠 -->
  <div class="section">
    <div class="container" data-aos="fade-up" data-aos-delay="50">

      <!-- 요일 버튼 -->
      <div class="weekday-wrap" id="weekdayWrap">
        <c:forEach var="d" items="${weekly}">
          <button class="weekday-btn"
                  data-weekday="${d.weekday}"
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
        <div class="col-lg-10 my-3">
          <div class="daily-card" id="dailyCard">
            <c:choose>
              <c:when test="${not empty today.thumbnail}">
                <c:url var="todayThumb" value="/uploads/challenge/${fn:escapeXml(today.thumbnail)}"/>
                <div class="daily-media" style="background-image:url('${todayThumb}')"></div>
              </c:when>
              <c:otherwise>
                <div class="daily-media"></div>
              </c:otherwise>
            </c:choose>

            <div class="daily-body">
              <div class="d-flex justify-content-between align-items-center">
                <h2 class="daily-title">${empty today.title ? '수요일 플라스틱 제로데이 챌린지' : today.title}</h2>
                <div class="badge-soft">+ <c:out value="${empty today.rewardPoints ? 0 : today.rewardPoints}"/> P</div>
              </div>
              <p class="daily-desc">${empty today.description ? '일회용품 플라스틱 제로에 도전!' : today.description}</p>

			 <!-- 데일리 챌린지 타드 정보 -->	
			<!-- 기존 daily-meta 블록을 아래로 교체 -->
			<!-- daily-meta: "오늘"일 때만 TODAY 표시 -->
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="u" var="dowStr" /> <%-- 1(월)~7(일) --%>
			<fmt:parseNumber integerOnly="true" value="${dowStr}" var="dow" />
			<c:set var="todayIdx0to6" value="${dow == 7 ? 0 : dow}" /> <%-- 0(일)~6(토)로 변환 --%>
			
			<fmt:parseNumber integerOnly="true" value="${today.weekday}" var="challengeDow" />
			
			<div class="daily-meta">
			  <c:if test="${not empty challengeDow and todayIdx0to6 == challengeDow}">
			    <span class="badge-soft">TODAY</span>
			  </c:if>
			
			  <span class="badge-soft">
			    <c:choose>
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
                <a class="btn-ghost" href="${cp}/challenge/detail/${today.challengeId}">상세보기</a>
                <a class="btn-primary-grad" href="${cp}/challenge/join/daily/${today.challengeId}">
				  지금 참가하기
				</a>
              </div>

              <div class="alert alert-warning mt-3" role="alert" style="border-radius:12px;">
                🔐 로그인 후 챌린지에 참가할 수 있습니다.
              </div>
            </div>
          </div>
        </div>
      </div>

    </div><!-- /.container -->
  </div><!-- /.section -->

  <!-- Page Title - 스페셜 -->
  <div class="page-title">
    <div class="container align-items-center" data-aos="fade-up">
      <h1>🎯 스페셜 챌린지</h1>
      <p>정해진 기간 3일에 걸쳐 도전할 수 있는 스페셜 챌린지, 도전해보세요!</p>
      <div class="page-title-underline-accent"></div>
    </div>
  </div>

  <!-- 스페셜 콘텐츠 -->
  <div class="section">
    <div class="container" data-aos="fade-up" data-aos-delay="50">
      <div id="specialGrid" class="special-grid">
        <c:forEach var="s" items="${list}">
          <div class="card"
               data-id="${s.challengeId}"
               data-end-date="${s.endDate}">
            <c:choose>
              <c:when test="${not empty s.thumbnail}">
                <c:url var="thumbUrl" value="/uploads/challenge/${fn:escapeXml(s.thumbnail)}"/>
                <div class="card-thumb" style="background-image:url('${thumbUrl}')"></div>
              </c:when>
              <c:otherwise>
                <div class="card-thumb"></div>
              </c:otherwise>
            </c:choose>

            <div class="card-body">
              <h3 class="card-title">${s.title}</h3>
              <p class="card-desc">${s.description}</p>
              <div class="card-foot">
                <span class="badge-soft">~ ${s.endDate}</span>
                <div class="d-flex gap-2">
                  <a class="btn-ghost" href="${cp}/challenge/detail/${s.challengeId}">상세보기</a>
                  <button class="btn-primary-grad btn-join-special"
                          data-challenge-id="${s.challengeId}">
                    지금 참가하기
                  </button>
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
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
  const cp = "${cp}";
  const todayWeekday = ${empty targetWeekday ? -1 : targetWeekday};

  // 요일 버튼 활성화 + 가운데로 스크롤
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

  // 스페셜 - 지금 참가하기(상세로 이동)
  (function joinSpecialInit(){
    const grid = document.getElementById('specialGrid');
    grid.addEventListener('click', (e)=>{
      const btn = e.target.closest('.btn-join-special');
      if(!btn) return;
      const id = btn.dataset.challengeId;
      if(!id) return;
      location.href = cp + "/challenge/detail/" + id;
    });
  })();

  // 더보기 (종료일 빠른 순 + 커서로 중복 방지)
  (function moreInit(){
    const grid = document.getElementById('specialGrid');
    const btn  = document.getElementById('btnMore');
    if(!btn) return;

    function getLastCursor(){
      const cards = grid.querySelectorAll('.card');
      if(cards.length===0) return null;
      const last = cards[cards.length-1];
      return { id: last.dataset.id, endDate: last.dataset.endDate };
    }

    btn.addEventListener('click', async ()=>{
      btn.disabled = true; btn.textContent = "불러오는 중...";
      const params = new URLSearchParams();
      const cur = getLastCursor();
      if(cur){
        params.set('lastId', cur.id);
        params.set('lastEndDate', cur.endDate); // 종료일 커서
      }
      params.set('size', '6');
      params.set('sort', 'CLOSE_DATE'); // 종료일 빠른 순

      try{
        const res = await fetch(cp + "/challenge/special/more?" + params.toString());
        const items = await res.json();
        if(!items || items.length===0){ btn.style.display='none'; return; }

        const frag = document.createDocumentFragment();

        items.forEach(function(s){
          const hasThumb = !!(s.thumbnail && s.thumbnail.length>0);
          const thumb = hasThumb ? (cp + "/uploads/challenge/" + s.thumbnail) : null;
          const bg = hasThumb ? " style=\"background-image:url('" + thumb + "')\"" : "";

          const title = s.title || "";
          const desc  = s.description || "";
          const endDt = s.endDate || "";

          const el = document.createElement('div');
          el.className = 'card';
          el.dataset.id = s.challengeId;
          el.dataset.endDate = endDt; // 다음 커서용
          el.innerHTML =
            '<div class="card-thumb"' + bg + '></div>' +
            '<div class="card-body">' +
              '<h3 class="card-title">' + title + '</h3>' +
              '<p class="card-desc">' + desc + '</p>' +
              '<div class="card-foot">' +
                '<span class="badge-soft">~ ' + endDt + '</span>' +
                '<div class="d-flex gap-2">' +
                  '<a class="btn-ghost" href="' + cp + '/challenge/detail/' + s.challengeId + '">상세보기</a>' +
                  '<button class="btn-primary-grad btn-join-special" data-challenge-id="' + s.challengeId + '">지금 참가하기</button>' +
                '</div>' +
              '</div>' +
            '</div>';

          frag.appendChild(el);
        });

        grid.appendChild(frag);
      }catch(e){
        alert('더보기 로딩 중 오류가 발생했어요.');
      }finally{
        btn.disabled = false; btn.textContent = "더보기";
      }
    });
  })();
</script>
</body>
</html>
