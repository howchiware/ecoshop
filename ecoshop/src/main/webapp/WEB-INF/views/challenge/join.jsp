<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${dto.title} - 챌린지 참가</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <link rel="stylesheet" href="${cp}/dist/css/home.css"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
main { padding: clamp(16px, 2vw, 32px) 0 60px; }
.page-wrap { max-width: 800px; margin: 0 auto; padding: 0 16px; }
.page-title { margin-bottom: 24px; }
.page-title h1 { font-size: clamp(24px, 3vw, 36px); font-weight: 800; }

.panel { border: 1px solid #e9eef6; background: #fff; border-radius: 16px;
  box-shadow: 0 6px 18px rgba(28,47,88,0.06); padding: 32px; }

.form-group { margin-bottom: 20px; }
.form-label { font-weight: 600; margin-bottom: 8px; }
.form-control { border-radius: 8px; padding: 10px 14px; }
.btn-grad { border: none; color: #fff; font-weight: 800; padding: 12px 16px; border-radius: 10px;
  background: linear-gradient(135deg, #4caf50, #2e7d32); width: 100%; }
.btn-grad[disabled] { filter: grayscale(.25); opacity: .6; cursor: not-allowed; }
.btn-outline { border: 1px solid #dbe3ee; background: #fff; color: #1f2a44; font-weight: 700;
  padding: 10px 14px; border-radius: 10px; }
.btn-outline { border: 1px solid #dbe3ee; background: #fff; color: #1f2a44; font-weight: 700; padding: 10px 14px; border-radius: 10px; }


.title-row{
  display:flex;
  align-items:baseline;           
  justify-content:space-between;
  gap:12px;
}
.title-text{
  font-size:clamp(20px, 2.2vw, 28px);
  font-weight:800;
}
.title-back{
  white-space:nowrap;
  padding:6px 10px;              
  border-radius:8px;
}


@media (max-width: 575.98px){
  .title-row{ flex-wrap:wrap; }
  .title-back{ order:2; margin-left:auto; margin-top:6px; }
}

</style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
  <div class="page-wrap">
    <div class="page-title"><h1>챌린지 참여하기</h1></div>
    

    <c:if test="${empty member}">
      <div class="alert alert-warning text-center" role="alert">
        <i class="bi bi-exclamation-circle me-2"></i> 로그인 후 챌린지에 참여할 수 있습니다.
        <a href="${cp}/member/login" class="alert-link ms-2">로그인 페이지로 이동</a>
      </div>
    </c:if>

   
    <jsp:useBean id="now" class="java.util.Date"/>
    <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr"/>
    <c:set var="isSpecial" value="${dto.challengeType=='SPECIAL'}"/>

   
    <c:set var="specialOpen"
           value="${isSpecial and not empty dto.startDate and not empty dto.endDate
                   and (dto.startDate <= todayStr) and (todayStr <= dto.endDate)}"/>

	 <div class="panel">
	  <!-- 제목 + 오른쪽 목록 버튼 -->
	  <div class="title-row">
	    <h4 class="title-text mb-0">${dto.title}</h4>
	    <a href="${cp}/challenge/list" class="btn btn-outline btn-sm title-back">
	      <i class="bi bi-list"></i> 목록
	    </a>
	  </div>
	
	  <p class="text-muted mt-2">${dto.description}</p>
	  <hr/>
	  
      <c:choose>
        <c:when test="${not empty submitAction}">
          <c:set var="formAction" value="${submitAction}"/>
        </c:when>
        <c:otherwise>
          <c:set var="formAction" value='${cp}/challenge/dailySubmit'/>
        </c:otherwise>
      </c:choose>

     
      <c:if test="${isSpecial and not specialOpen}">
        <div class="alert alert-info" role="alert">
          아직 시작 전이거나 기간이 종료된 스페셜 챌린지입니다. 기간 내에만 제출할 수 있어요.
        </div>
      </c:if>
      <c:if test="${not isSpecial and not dailyPlayable}">
        <div class="alert alert-info" role="alert">
          이 데일리 챌린지는 지정된 요일에만 제출할 수 있어요.
        </div>
      </c:if>
      <c:if test="${alreadyJoined}">
        <div class="alert alert-success" role="alert">
          오늘은 이미 참여하셨습니다. 다음 해당 요일에 다시 도전해 주세요!
        </div>
      </c:if>

      <form id="joinForm" action="${formAction}" method="post" enctype="multipart/form-data">
        <input type="hidden" name="challengeId" value="${dto.challengeId}" />
        <input type="hidden" name="memberId" value="${member.memberId}" />
        <input type="hidden" id="flagIsSpecial" value="${isSpecial}" />
        <input type="hidden" id="flagSpecialOpen" value="${specialOpen}" />
        <input type="hidden" id="flagDailyPlayable" value="${dailyPlayable}" />
        <input type="hidden" id="flagAlreadyJoined" value="${alreadyJoined}" />

       
        <c:if test="${isSpecial}">
          <input type="hidden" name="dayNumber" value="${empty dayNumber ? 1 : dayNumber}" />
        </c:if>

        <div class="form-group">
          <label for="content" class="form-label">인증글 작성 <span class="text-danger">*</span></label>
          <textarea id="content" name="content" class="form-control" rows="5" required
                    placeholder="인증 내용을 20자 이상 작성해주세요."></textarea>
          <div class="form-text text-end" id="content-count">0자 / 최소 20자</div>
        </div>

        <div class="form-group">
          <label for="photoFile" class="form-label">사진 첨부
            <c:if test="${isSpecial}"><span class="text-danger">*</span></c:if>
          </label>
          <input type="file" id="photoFile" name="photoFile" class="form-control" accept="image/*" />
        </div>

        <c:choose>
          <c:when test="${empty member}">
            <button type="button" class="btn-grad mt-3" disabled>로그인 후 제출 가능</button>
          </c:when>
          <c:when test="${alreadyJoined}">
            <button type="button" class="btn-grad mt-3" disabled>오늘은 제출 완료</button>
          </c:when>
          <c:when test="${isSpecial and not specialOpen}">
            <button type="button" class="btn-grad mt-3" disabled>지금은 제출할 수 없어요</button>
          </c:when>
          <c:when test="${not isSpecial and not dailyPlayable}">
            <button type="button" class="btn-grad mt-3" disabled>해당 요일에만 제출 가능</button>
          </c:when>
          <c:otherwise>
            <button type="submit" class="btn-grad mt-3">챌린지 제출</button>
          </c:otherwise>
        </c:choose>
      </form>
    </div>
  </div>
</main>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
  const cp = "${cp}";

  // 글자 수 카운트 (최소 20자)
  document.getElementById('content').addEventListener('input', function() {
    const count = this.value.length;
    const counter = document.getElementById('content-count');
    counter.textContent = `${count}자 / 최소 20자`;
    counter.style.color = (count < 20) ? 'red' : 'green';
  });

  // 제출 시 유효성 + 상태 가드
  document.getElementById('joinForm').addEventListener('submit', function(e) {
    const isSpecial = document.getElementById('flagIsSpecial').value === 'true';
    const specialOpen = document.getElementById('flagSpecialOpen').value === 'true';
    const dailyPlayable = document.getElementById('flagDailyPlayable').value === 'true';
    const alreadyJoined = document.getElementById('flagAlreadyJoined').value === 'true';

    if (alreadyJoined) { alert('오늘은 이미 참여하셨어요.'); e.preventDefault(); return; }
    if (isSpecial && !specialOpen) { alert('아직 기간이 아니에요. 기간 내에 제출할 수 있어요.'); e.preventDefault(); return; }
    if (!isSpecial && !dailyPlayable) { alert('해당 요일에만 제출할 수 있어요.'); e.preventDefault(); return; }

    const content = document.getElementById('content').value.trim();
    if (content.length < 20) {
      alert('인증글을 20자 이상 작성해야 합니다.');
      e.preventDefault();
      return;
    }
    if (isSpecial) {
      const photo = document.getElementById('photoFile');
      if (!photo || !photo.value) {
        alert('스페셜 챌린지는 사진 업로드가 필요합니다.');
        e.preventDefault();
        return;
      }
    }
  });
</script>
</body>
</html>
