<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG" value="${cp}/uploads/challenge/no-image.png" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 - 챌린지 ${mode=='update'?'수정':'등록'}</title>
<link rel="stylesheet" href="<c:url value='/dist/css/main2.css'/>" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>

  <!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<c:url value='/dist/js/util-jquery.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
  
  
  <style>
/* .page-wrap{max-width:1200px; margin:0 auto;} */
.card{border-radius:14px}
.thumb-preview{width:100%; aspect-ratio:16/9; border:1px dashed #e5e7eb; border-radius:12px; background:#f8fafc center/cover no-repeat;}
.section-title{font-weight:800; font-size:1.05rem}
.weekday-badges .badge{cursor:pointer; font-weight:700}
.weekday-badges .badge.active{background:#0d6efd!important}
.form-text small{color:#64748b}
.sticky-actions{position:sticky; bottom:0; z-index:5; background:#fff; padding:12px 0; border-top:1px solid #eef2f7}

/* 관리자페이지 공통 부분 */  
.admin-main-container { display:flex; }
.admin-sidebar { width:250px; flex-shrink:0; }
.admin-content { flex-grow:1; margin-left:20px; } 
  
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<div class="container my-4 admin-main-container">
 <div class="admin-sidebar">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
 </div>	
  <!-- 헤더 -->
  
 <div class="admin-content"> 
  <div class="d-flex justify-content-between align-items-center mb-3">
    <div>
      <h3 class="mb-1">${mode=='update'?'챌린지 수정':'챌린지 등록'}</h3>
      <div class="text-muted">필수 항목을 입력하고 저장하세요.</div>
    </div>
    <a href="<c:url value='/admin/challengeManage/list'/>" class="btn btn-outline-secondary">목록</a>
  </div>

  <!-- 본문 카드 -->
  <form id="challengeForm" method="post" action="<c:url value='/admin/challengeManage/${mode}'/>" enctype="multipart/form-data">
    <c:if test="${mode=='update'}">
      <input type="hidden" name="challengeId" value="${dto.challengeId}">
    </c:if>

    <div class="row g-4">
      <!-- 왼쪽 : 기본 정보 -->
      <div class="col-lg-7">
        <div class="card p-4">
          <div class="mb-3">
            <label class="form-label section-title">기본 정보</label>
            <input class="form-control form-control-lg" name="title" placeholder="제목을 입력하세요" value="${dto.title}" required>
          </div>

          <div class="mb-3">
            <textarea class="form-control" name="description" rows="5" placeholder="설명을 입력하세요" required>${dto.description}</textarea>
            <div class="form-text"><small>간결하지만 핵심이 드러나게 작성하면 좋아요.</small></div>
          </div>

          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">포인트</label>
              <input class="form-control" type="number" name="rewardPoints" value="${empty dto.rewardPoints ? 0 : dto.rewardPoints}" min="0" step="10" required>
            </div>
            <div class="col-md-4">
              <label class="form-label">타입</label>
              <select class="form-select" name="challengeType" id="typeSel" required>
                <option value="DAILY"   ${dto.challengeType=='DAILY'?'selected':''}>DAILY</option>
                <option value="SPECIAL" ${dto.challengeType=='SPECIAL'?'selected':''}>SPECIAL</option>
              </select>
            </div>
            <!-- 썸네일 업로드 -->
            <div class="col-md-4">
              <label class="form-label">썸네일 파일</label>
              <input id="thumbInput" type="file" class="form-control" name="thumbnailFile" accept="image/*">
              <c:if test="${mode=='update'}">
                <div class="form-check mt-2">
                  <input class="form-check-input" type="checkbox" id="removeThumb" name="removeThumbnail" value="true">
                  <label class="form-check-label" for="removeThumb">이미지 없음(썸네일 삭제)</label>
                </div>
              </c:if>
              <div class="form-text"><small>파일을 선택하면 오른쪽에서 미리보기 됩니다.</small></div>
            </div>
          </div>
        </div>

        <!-- DAILY 섹션 -->
        <div id="dailyBox" class="card p-4 mt-3">
          <div class="d-flex justify-content-between align-items-center mb-2">
            <span class="section-title">데일리 설정</span>
            <span class="badge bg-info">DAILY</span>
          </div>

          <label class="form-label">요일 선택</label>
          <div class="weekday-badges d-flex gap-2 flex-wrap mb-2">
            <c:forEach var="i" begin="0" end="6">
              <span class="badge bg-light text-dark px-3 py-2" data-value="${i}">
                <c:choose>
                  <c:when test="${i==0}">일</c:when>
                  <c:when test="${i==1}">월</c:when>
                  <c:when test="${i==2}">화</c:when>
                  <c:when test="${i==3}">수</c:when>
                  <c:when test="${i==4}">목</c:when>
                  <c:when test="${i==5}">금</c:when>
                  <c:otherwise>토</c:otherwise>
                </c:choose>
              </span>
            </c:forEach>
          </div>

          <select id="weekdaySelect" class="form-select" name="weekday" aria-label="요일 선택">
            <c:forEach var="i" begin="0" end="6">
              <option value="${i}" ${dto.weekday==i?'selected':''}>${i}</option>
            </c:forEach>
          </select>
          <div class="form-text"><small>0=일요일 … 6=토요일</small></div>
        </div>

        <!-- SPECIAL 섹션 -->
        <div id="specialBox" class="card p-4 mt-3">
          <div class="d-flex justify-content-between align-items-center mb-2">
            <span class="section-title">스페셜 설정</span>
            <span class="badge bg-primary">SPECIAL</span>
          </div>

          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">시작일</label>
              <input id="startDate" class="form-control" type="date" name="startDate" value="${dto.startDate}">
            </div>
            <div class="col-md-4">
              <label class="form-label">종료일</label>
              <input id="endDate" class="form-control" type="date" name="endDate" value="${dto.endDate}">
            </div>
            <div class="col-md-2">
              <label class="form-label">연속일</label>
              <input class="form-control" type="number" name="requireDays" value="${empty dto.requireDays?3:dto.requireDays}" min="1" max="7">
            </div>
            <div class="col-md-2">
              <label class="form-label">상태</label>
              <select class="form-select" name="specialStatus">
                <option value="0" ${dto.specialStatus==0?'selected':''}>대기</option>
                <option value="1" ${dto.specialStatus==1?'selected':''}>진행</option>
                <option value="2" ${dto.specialStatus==2?'selected':''}>종료</option>
              </select>
            </div>
          </div>
          <div class="form-text mt-1"><small>시작일과 종료일은 필수이며, 시작일이 종료일보다 늦을 수 없습니다.</small></div>
        </div>

        <!-- 액션 -->
        <div class="sticky-actions mt-3 d-flex gap-2">
          <c:if test="${mode=='update'}">
            <input type="hidden" name="thumbnail" value="${dto.thumbnail}">
          </c:if>
          <button class="btn btn-primary px-4">${mode=='update'?'수정':'등록'}</button>
          <a class="btn btn-outline-secondary" href="<c:url value='/admin/challengeManage/list'/>">목록</a>
        </div>
      </div>

      <!-- 오른쪽 : 썸네일 미리보기 가이드 -->
      <div class="col-lg-5">
        <div class="card p-4">
          <div class="section-title mb-2">썸네일 미리보기</div>
          <c:choose>
            <c:when test="${not empty dto.thumbnail}">
              <c:url var="initialThumb" value="/uploads/challenge/${fn:escapeXml(dto.thumbnail)}"/>
            </c:when>
            <c:otherwise>
              <c:set var="initialThumb" value="${NOIMG}"/>
            </c:otherwise>
          </c:choose>
          <div id="thumbPreview" class="thumb-preview" style="background-image:url('${initialThumb}')"></div>
          <ul class="mt-3 text-muted small">
            <li>권장 비율 <strong>16:9</strong>, 최소 960×540</li>
            <li>이미지 파일만 업로드 가능합니다.</li>
          </ul>
        </div>

		<!-- 설명부분 보충하기 -->
        <div class="card p-4 mt-3">
          <div class="section-title mb-2">작성 팁</div>
          <ul class="small text-muted mb-0">
            <li>제목은 20자 내외로 핵심이 드러나게.</li>
            <li>설명은 2~3문장으로 행동을 유도.</li>
            <li>포인트 기준은 기존 챌린지와 일관되게.</li>
          </ul>
        </div>
      </div>
    </div>
  </form>
 </div>
</div>

<script>
  // 타입 토글
  function toggleBoxes(){
    const v = document.getElementById('typeSel').value;
    document.getElementById('dailyBox').style.display   = (v==='DAILY') ? 'block' : 'none';
    document.getElementById('specialBox').style.display = (v==='SPECIAL') ? 'block' : 'none';
  }
  document.getElementById('typeSel').addEventListener('change', toggleBoxes);
  toggleBoxes();

  // 썸네일 미리보기
  const thumbInput = document.getElementById('thumbInput');
  const thumbPreview = document.getElementById('thumbPreview');
  const NOIMG = '${NOIMG}';

  if (thumbInput) {
    thumbInput.addEventListener('change', () => {
      const file = thumbInput.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (event) => {
          thumbPreview.style.backgroundImage = `url('${event.target.result}')`;
        };
        reader.readAsDataURL(file);
        const removeChkEl = document.getElementById('removeThumb');
        if (removeChkEl) removeChkEl.checked = false;
      } else {
        thumbPreview.style.backgroundImage = `url('${NOIMG}')`;
      }
    });
  }

  // 삭제 체크 시 미리보기/파일 입력 초기화
  const removeChk = document.getElementById('removeThumb');
  if (removeChk) {
    removeChk.addEventListener('change', (e) => {
      if (e.target.checked) {
        if (thumbInput) thumbInput.value = '';
        thumbPreview.style.backgroundImage = `url('${NOIMG}')`;
      }
    });
  }

  // 요일 배지 - select 동기화
  const weekdaySelect = document.getElementById('weekdaySelect');
  const badges = document.querySelectorAll('.weekday-badges .badge');
  function syncBadges(val){
    badges.forEach(b => b.classList.toggle('active', String(b.dataset.value)===String(val)));
  }
  badges.forEach(b => b.addEventListener('click', () => {
    weekdaySelect.value = b.dataset.value; syncBadges(b.dataset.value);
  }));
  if (weekdaySelect) {
    syncBadges(weekdaySelect.value);
    weekdaySelect.addEventListener('change', e => syncBadges(e.target.value));
  }

  // 날짜 유효성
  const st = document.getElementById('startDate');
  const en = document.getElementById('endDate');
  function validateDates(){
    if(!st || !en) return true;
    if(!st.value || !en.value) return true;
    if(st.value > en.value){
      en.setCustomValidity('종료일은 시작일 이후여야 합니다.');
      en.reportValidity();
      return false;
    } else { en.setCustomValidity(''); return true; }
  }
  if(st && en){ st.addEventListener('change', validateDates); en.addEventListener('change', validateDates); }

  // SPECIAL 선택 시 날짜 필수
  document.getElementById('challengeForm').addEventListener('submit', (e)=>{
    const type = document.getElementById('typeSel').value;
    if(type==='SPECIAL'){
      if(!st.value || !en.value || !validateDates()){
        e.preventDefault();
      }
    }
  });
</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
