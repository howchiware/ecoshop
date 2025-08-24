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
      background: linear-gradient(90deg, #5e9cff, #8b5dff); width: 100%; }
    .btn-outline { border: 1px solid #dbe3ee; background: #fff; color: #1f2a44; font-weight: 700;
      padding: 10px 14px; border-radius: 10px; }
  </style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
  <div class="page-wrap">
    <div class="page-title">
      <h1>챌린지 참여하기</h1>
    </div>

    <c:if test="${empty member}">
      <div class="alert alert-warning text-center" role="alert">
        <i class="bi bi-exclamation-circle me-2"></i> 로그인 후 챌린지에 참여할 수 있습니다.
        <a href="${cp}/member/login" class="alert-link ms-2">로그인 페이지로 이동</a>
      </div>
    </c:if>

    <div class="panel">
      <h4>${dto.title}</h4>
      <p class="text-muted">${dto.description}</p>
      <hr />

      <%-- action 분기: submitAction이 오면 그걸, 없으면 dailySubmit --%>
      <c:choose>
        <c:when test="${not empty submitAction}">
          <c:set var="formAction" value="${submitAction}"/>
        </c:when>
        <c:otherwise>
          <c:set var="formAction" value='${cp}/challenge/dailySubmit'/>
        </c:otherwise>
      </c:choose>

      <form id="joinForm"
            action="${formAction}"
            method="post" enctype="multipart/form-data">
        <input type="hidden" name="challengeId" value="${dto.challengeId}" />
        <input type="hidden" name="memberId" value="${member.memberId}" />

        <%-- SPECIAL이면 dayNumber 포함 --%>
        <c:if test="${dto.challengeType=='SPECIAL'}">
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
            <c:if test="${dto.challengeType=='SPECIAL'}"><span class="text-danger">*</span></c:if>
          </label>
          <input type="file" id="photoFile" name="photoFile" class="form-control" accept="image/*" />
        </div>

        <c:choose>
          <c:when test="${not empty member}">
            <button type="submit" class="btn-grad mt-3">챌린지 제출</button>
          </c:when>
          <c:otherwise>
            <button type="button" class="btn-grad mt-3" disabled>로그인 후 제출 가능</button>
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

  // 제출 시 유효성 검사
  document.getElementById('joinForm').addEventListener('submit', function(e) {
    const content = document.getElementById('content').value;
    if (content.length < 20) {
      alert('인증글을 20자 이상 작성해야 합니다.');
      e.preventDefault();
      return;
    }
    // SPECIAL은 사진 필수
    const isSpecial = "${dto.challengeType}" === "SPECIAL";
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
