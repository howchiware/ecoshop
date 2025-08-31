<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Challenge</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="stylesheet" href="${cp}/dist/css/home.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
main { padding: clamp(16px, 2vw, 32px) 0 60px; }
.page-wrap { max-width: 1120px; margin: 0 auto; padding: 0 16px; }
.panel { border: 1px solid #e9eef6; background: #fff; border-radius: 16px; box-shadow: 0 6px 18px rgba(28, 47, 88, 0.06); }
.detail-head { position: relative; display: flex; align-items: center; gap: 10px; min-height: 44px; }
.detail-title { margin: 0; font-size: clamp(20px, 2.4vw, 28px); font-weight: 800; color: #1f2937; }
.badge-type { display: inline-flex; align-items: center; gap: 6px; padding: 2px 10px; border-radius: 999px; font-weight: 700; font-size: 12px; border: 1px solid #dfe6f2; background: #f6f9ff; color: #4b5b76; }
.badge-special { background: #eef7ff; border-color: #cfe4ff; color: #2868ff; }
.badge-daily   { background: #f3f6fb; border-color: #e6edf7; color: #627089; }
.point-chip { position: absolute; right: 0; top: 0; display: inline-flex; gap: 6px; align-items: center; padding: 4px 12px; border-radius: 999px; font-weight: 800; font-size: 12px; border: 1px solid #e6edf7; background: #fff; color: #334155; z-index: 2; }
.hero { padding: clamp(12px, 1.8vw, 18px); }
.detail-hero { display: grid; grid-template-columns: 1fr; gap: 20px; }
@media (min-width: 1200px){ .detail-hero { grid-template-columns: 1.35fr 1fr; } }
.hero-thumb { width: 100%; aspect-ratio: 16/9; min-height: 240px; max-height: 420px; background: #eff4fa center/cover no-repeat; border-radius: 16px; border: 1px solid #e8eef6; }
.info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
@media (max-width: 480px){ .info-grid{ grid-template-columns: 1fr; } }
.info-card { border: 1px solid #e9eef6; border-radius: 12px; background: #fff; padding: 14px 16px; min-height: 88px; display: flex; flex-direction: column; justify-content: center; }
.info-label { font-size: 12px; color: #6b7280; margin-bottom: 6px; }
.info-value { font-weight: 800; color: #111827; }
.desc { color: #475569; line-height: 1.6; }
.cta-bar { padding: 14px 18px; background: #f7f9fc; border-top: 1px solid #eef2f7; border-bottom-left-radius: 16px; border-bottom-right-radius: 16px; }
.btn-grad { border: none; color: #fff; font-weight: 800; padding: 12px 16px; border-radius: 10px; background: linear-gradient(135deg, #4caf50, #2e7d32); }
.btn-outline { border: 1px solid #dbe3ee; background: #fff; color: #1f2a44; font-weight: 700; padding: 10px 14px; border-radius: 10px; }
.btn-grad[disabled] { filter: grayscale(.25); opacity: .6; cursor: not-allowed; }


.hero { padding: clamp(8px, 1.2vw, 14px) 16px 16px; } 
.detail-head { margin-bottom: 4px; }
.desc { margin-top: 6px; margin-bottom: 12px; }


@media (min-width: 992px){
  .detail-hero{
    grid-template-columns: minmax(0, 2fr) minmax(0, 1fr); /* 8:4 */
    align-items: start;
    gap: 18px;
}


@media (min-width: 992px){
  .hero-thumb{
    aspect-ratio: 4/3;            
    max-height: 480px;           
    background-position: center;  
   
  }
}


@media (min-width: 992px){
  .info-grid{
    grid-template-columns: 1fr 1fr; 
    grid-auto-rows: 1fr;           
    align-content: stretch;
  }
  .info-card{
    min-height: 84px;  
    padding: 12px 14px;
  }
}


@media (max-width: 991.98px){
  .hero-thumb{ aspect-ratio: 16/9; min-height: 200px; max-height: 360px; }
}



@media (min-width: 992px){
.detail-hero{ grid-template-columns: 1.4fr 1fr; gap: 16px; }
.hero-thumb{
    aspect-ratio: 3 / 2;          
    height: auto;                 
    max-height: clamp(220px, 30vw, 360px);
    background-size: cover;        
    background-position: center;
    border-radius: 16px;
    border: 1px solid #e8eef6;
  }
  
}


.hero-thumb{
  aspect-ratio: auto;                    
  height: clamp(240px, 28vw, 360px);     
  background-size: cover;
  background-position: top center;           
  min-height: 0;                      
  max-height: none;
}


.info-grid{
  grid-template-columns: 1fr 1fr;
  grid-auto-rows: 1fr;
}
.info-card{ min-height: 0; padding: 12px 14px; }
}


</style>
</head>

<body>
<header><jsp:include page="/WEB-INF/views/layout/header.jsp" /></header>

<main>
  <div class="page-wrap">
  
	<!-- 페이지 -->
	<nav class="crumb" aria-label="breadcrumb">
		<i class="bi bi-house-door"></i> <a href="${cp}/">홈</a> <span
			class="mx-1 text-secondary">›</span> <a href="${cp}/challenge/list">챌린지</a>
		<span class="mx-1 text-secondary">›</span> <span
			class="text-dark fw-bold">${dto.title}</span>
	</nav>
 
    <!-- 상단 카드 -->
    <section class="panel mb-4">
      <div class="p-4 pb-0">
        <div class="detail-head">
          <h1 class="detail-title">${dto.title}</h1>
          <c:choose>
            <c:when test="${dto.challengeType=='SPECIAL'}"><span class="badge-type badge-special">SPECIAL</span></c:when>
            <c:otherwise><span class="badge-type badge-daily">DAILY</span></c:otherwise>
          </c:choose>
          <span class="point-chip"><i class="bi bi-trophy"></i> + ${dto.rewardPoints} P</span>
        </div>
        <p class="mt-2 mb-3 desc">${dto.description}</p>
      </div>

      <!-- 썸네일 + 정보 -->
      <div class="hero">
        <div class="detail-hero">
          <c:choose>
            <c:when test="${not empty dto.thumbnail}">
              <c:url var="heroThumb" value="/uploads/challenge/${fn:escapeXml(dto.thumbnail)}"/>
              <div class="hero-thumb" style="background-image:url('${heroThumb}')"></div>
            </c:when>
            <c:otherwise><div class="hero-thumb"></div></c:otherwise>
          </c:choose>

          <div class="info-grid">
            <div class="info-card">
              <div class="info-label">목표</div>
              <div class="info-value">
                <c:choose>
                  <c:when test="${dto.challengeType=='DAILY'}">사진 인증 또는 글 인증</c:when>
                  <c:otherwise>연속 3일만 인정 / 하루 1회만 인증 등록 가능</c:otherwise>
                </c:choose>
              </div>
            </div>

            <div class="info-card">
              <div class="info-label">기간</div>
              <div class="info-value">
                <c:choose>
                  <c:when test="${dto.challengeType=='DAILY'}">
                    매주
                    <c:choose>
                      <c:when test="${dto.weekday==0}">일</c:when>
                      <c:when test="${dto.weekday==1}">월</c:when>
                      <c:when test="${dto.weekday==2}">화</c:when>
                      <c:when test="${dto.weekday==3}">수</c:when>
                      <c:when test="${dto.weekday==4}">목</c:when>
                      <c:when test="${dto.weekday==5}">금</c:when>
                      <c:otherwise>토</c:otherwise>
                    </c:choose>요일
                  </c:when>
                  <c:otherwise>${dto.startDate} ~ ${dto.endDate}</c:otherwise>
                </c:choose>
              </div>
            </div>

            <div class="info-card">
              <div class="info-label">포인트</div>
              <div class="info-value">${dto.rewardPoints}P</div>
            </div>

            <div class="info-card">
              <div class="info-label">인증 방식</div>
              <div class="info-value">
                <c:choose>
                  <c:when test="${dto.challengeType=='SPECIAL'}">사진 + 글 (승인형)</c:when>
                  <c:otherwise>사진 또는 글 (운영정책에 따라 자동/승인)</c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>

     
      <div class="d-flex justify-content-between align-items-center cta-bar">
        <a href="${cp}/challenge/list" class="btn btn-outline"><i class="bi bi-arrow-left"></i> 목록</a>

        <c:choose>
          <c:when test="${dto.challengeType=='DAILY'}">
            <c:choose>
              <c:when test="${dailyPlayable}"><a class="btn-grad" href="${cp}/challenge/join/daily/${dto.challengeId}">챌린지 참여하기</a></c:when>
              <c:otherwise><button class="btn-grad" disabled>해당 요일에만 참여 가능</button></c:otherwise>
            </c:choose>
          </c:when>

			<c:otherwise>
			  <c:choose>
			    <c:when test="${status=='OPEN'}">
			      <c:choose>
			        <c:when test="${empty nextDay}">
			          <button class="btn-grad" disabled>모든 일차 인증 완료</button>
			        </c:when>
			        <c:when test="${not empty canJoinToday and !canJoinToday}">
			          <button class="btn-grad" disabled>
			            스페셜 챌린지 <c:out value="${nextDay}"/>일차 참여하기 (오늘은 불가)
			          </button>
			        </c:when>
			        <c:otherwise>
			          <a class="btn-grad" href="${cp}/challenge/join/special/${dto.challengeId}?day=${nextDay}">
			            스페셜 챌린지 <c:out value="${nextDay}"/>일차 참여하기
			          </a>
			        </c:otherwise>
			      </c:choose>
			    </c:when>
			    <c:when test="${status=='UPCOMING'}"><button class="btn-grad" disabled>시작 전입니다</button></c:when>
			    <c:otherwise><button class="btn-grad" disabled>종료된 챌린지</button></c:otherwise>
			  </c:choose>
			</c:otherwise>
        </c:choose>
      </div>
    </section>

   
    <section class="panel mb-3 p-4">
      <div class="section-title">참여 조건</div>
      <div class="check-list">
        <c:choose>
          <c:when test="${dto.challengeType=='DAILY'}">
            <div class="d-flex align-items-center gap-2 mb-2"><i class="bi bi-check-circle text-success"></i> 매주 해당 요일만 참여 가능</div>
            <div class="d-flex align-items-center gap-2 mb-2"><i class="bi bi-check-circle text-success"></i> 사진 1장 이상 또는 글 인증 필수</div>
            <div class="d-flex align-items-center gap-2"><i class="bi bi-check-circle text-success"></i> 마감 시간: 밤 11시 59분</div>
          </c:when>
          <c:otherwise>
            <div class="d-flex align-items-center gap-2 mb-2"><i class="bi bi-check-circle text-success"></i> 기간 내 <strong>3일 연속</strong>인증(하루 1회만 가능)</div>
            <div class="d-flex align-items-center gap-2 mb-2"><i class="bi bi-check-circle text-success"></i> 3일차 완료 후 ‘인증 신청’ 제출</div>
            <div class="d-flex align-items-center gap-2"><i class="bi bi-check-circle text-success"></i> 관리자 승인 후 포인트 지급</div>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    
    <section class="panel p-4">
      <div class="section-title">보상</div>
      <div class="reward-box border border-warning-subtle rounded-3 p-3 bg-warning-subtle">
        <i class="bi bi-gift"></i> <strong class="ms-2">${dto.rewardPoints} P</strong> 포인트 지급
      </div>
    </section>
  </div>
</main>

<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>

<c:if test="${not empty message}">
  <script>alert('${fn:escapeXml(message)}');</script>
</c:if>
<script>const cp = "${cp}";</script>
</body>
</html>
