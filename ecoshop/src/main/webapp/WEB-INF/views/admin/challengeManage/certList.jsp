<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG" value="${cp}/uploads/challenge/no-image.png" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>관리자 - 챌린지 인증 목록</title>

  <link rel="stylesheet" href="<c:url value='/dist/css/main2.css'/>" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />

  <style>

  
/* 색상 변경 */
:root{
  --ink: #334155;
  --muted-ink: #64748b;

  --card-bg:#fff;
  --bd:#e5e7eb;

  --chip-bg: #f8fafc;
  --chip-bd: #e5e7eb;
  --chip-ink: #334155;

  /* 배지: SPECIAL/DAILY (명도 차이) */
  --pill-special-bg: #e5e7eb;  /* 더 진한 회색 */
  --pill-special-bd: #d1d5db;
  --pill-special-ink:#111827;

  --pill-daily-bg:   #f3f4f6;  /* 더 옅은 회색 */
  --pill-daily-bd:   #e5e7eb;
  --pill-daily-ink:  #374151;

  /* 상태 배지(배경 회색, 도트만 컬러) */
  --status-bg:#f3f4f6;
  --status-bd:#e5e7eb;
  --status-ink:#344054;

  --dot-pending:#64748b;   /* slate */
  --dot-approved:#16a34a;  /* green */
  --dot-rejected:#e11d48;  /* rose */
}

.admin-wrap{display:flex; gap:20px}
.admin-sidebar{width:250px; flex-shrink:0}
.admin-content{flex:1; min-width:0}

/*  테이블  */
.cert-table{ width:100%; border-collapse:collapse; table-layout:fixed; }
.cert-table thead th{ font-weight:700; color:#475569; padding:10px; white-space:nowrap; }
.table-head{ border-bottom:2px solid #e6ebf2; }
.cert-row td{ padding:16px 14px; vertical-align:middle; border-bottom:1px solid #e9edf3; }
.cert-row:last-child td{ border-bottom:0; }

.thumb{
  width:88px; height:60px; object-fit:cover; border-radius:10px;
  border:1px solid #eaeef4; background:#f8fafc;
}
.col-content{ width:32%; }
.col-title{ width:22%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.muted{ color:var(--muted-ink); font-size:12px; }

/*  SPECIAL / DAILY (무채색 + 명도차)  */
.pill{
  display:inline-flex; align-items:center; justify-content:center;
  height:28px; padding:0 12px; border-radius:9999px;
  font-weight:700; letter-spacing:.02em; font-size:12px;
}
.pill.special{
  background:var(--pill-special-bg); color:var(--pill-special-ink); border:1px solid var(--pill-special-bd);
}
.pill.daily{
  background:var(--pill-daily-bg);   color:var(--pill-daily-ink);   border:1px solid var(--pill-daily-bd);
}

/*  상태 배지 (회색 배경 + 컬러 도트)  */
.status-badge{
  display:inline-flex; align-items:center; gap:8px;
  height:24px; padding:0 10px; border-radius:9999px;
  background:var(--status-bg); border:1px solid var(--status-bd);
  color:var(--status-ink); font-size:12px; font-weight:700;
}
.status-badge::before{
  content:""; width:8px; height:8px; border-radius:50%; display:inline-block;
  background:#cbd5e1; /* default */
}
.status-0::before{ background:var(--dot-pending); }   /* 대기 */
.status-1::before{ background:var(--dot-approved); }  /* 승인 */
.status-2::before{ background:var(--dot-rejected); }  /* 반려 */

/*  액션 버튼  */
.btn-line{ display:flex; gap:8px; justify-content:flex-end; white-space:nowrap; }
.btn-approve,.btn-reject{ border-radius:10px; padding:6px 12px; font-weight:700; border:1px solid var(--bd); background:#fff; color:#334155;}
.btn-approve:hover,.btn-reject:hover{ background:#f8fafc; }

/* 상단 요약 배지 묶음 */
.chip-group{
  display:flex; align-items:center; gap:6px;
  background:var(--card-bg); border:1px solid var(--chip-bd); border-radius:9999px;
  padding:6px; box-shadow:0 1px 2px rgba(0,0,0,.04);
}
.chip{
  display:inline-flex; align-items:center; gap:8px;
  padding:6px 10px; border-radius:9999px; font-weight:700; font-size:12px;
  color:var(--chip-ink); background:var(--chip-bg); border:1px solid var(--chip-bd);
}
.chip .count{ font-weight:800; padding-left:2px; }
.chip .dot{ width:8px; height:8px; border-radius:50%; background:#cbd5e1; }
/* 요약 도트도 상태별 컬러 */
.chip.pending  .dot{ background:var(--dot-pending); }
.chip.approved .dot{ background:var(--dot-approved); }
.chip.rejected .dot{ background:var(--dot-rejected); }
.chip.is-active{ background:#eef2f6; border-color:#cbd5e1; }

/* 페이지네이션 */
.paging-wrap{
  display:flex; justify-content:center; gap:10px; margin:22px 0 8px;
}
.paging-wrap a, .paging-wrap span{
  min-width:40px; height:40px; border-radius:10px;
  border:1px solid var(--bd); display:inline-flex; align-items:center; justify-content:center;
  text-decoration:none; color:#334155; background:#fff; padding:0 12px;
  box-shadow:0 1px 2px rgba(0,0,0,.04);
}
.paging-wrap a:hover{ background:#f8fafc; }
.paging-wrap .current{ background:#111827; border-color:#111827; color:#fff; font-weight:800; }

@media (max-width: 1400px){ .col-content{width:35%} .col-title{width:20%} }
@media (max-width: 1200px){ .col-content{width:38%} .col-title{width:18%} }
   
/* 행 전체 하이라이트 */
.table.table-hover tbody tr:hover{
  background:#f3f4f6 !important;        /* 밝은 회색 */
  transition: background-color .12s ease;
}

/* 행 hover 시 제목에만 밑줄 */
.table.table-hover tbody tr:hover .title-link{
  text-decoration: underline !important; 
  box-shadow: inset 0 -1px currentColor; 
}

/* 행 전체 하이라이트 */
.cert-table tbody tr:hover{
  background:#f3f4f6;
  transition: background-color .12s ease;
}

/* 행 hover 시 제목에만 밑줄 */
.cert-table tbody tr:hover .title-link{
  box-shadow: inset 0 -1px currentColor; 
}

.title-link{ display:inline-block; line-height:1.2; }
.table.table-hover tbody tr:hover .title-link,
.cert-table tbody tr:hover .title-link{
  color:#0f172a; /* 살짝 진하게 */
}



   

  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<!-- 알림창 (우측 하단) -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1080;">
  <div id="actionToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="2500">
    <div class="toast-header">
      <strong class="me-auto">알림</strong>
      <small>방금</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body"></div>
  </div>
</div>

<div class="container my-4 admin-wrap">
  <div class="admin-sidebar">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
  </div>

  <div class="admin-content">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="mb-0">챌린지 인증 목록</h3>
    </div>

    <!-- 검색, 요약 배지 묶음 -->
    <form class="row g-2 mb-3" method="get" action="<c:url value='/admin/challengeManage/certList'/>">
      <div class="col-md-4">
        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="제목/내용/이름 검색">
      </div>
      <div class="col-md-3">
        <select name="type" class="form-select">
          <option value="ALL"     <c:if test="${empty type || type=='ALL'}">selected</c:if>>전체 타입</option>
          <option value="DAILY"   <c:if test="${type=='DAILY'}">selected</c:if>>DAILY</option>
          <option value="SPECIAL" <c:if test="${type=='SPECIAL'}">selected</c:if>>SPECIAL</option>
        </select>
      </div>
      <div class="col-md-3">
        <select name="approvalStatus" class="form-select">
          <option value="">상태(전체)</option>
          <option value="0" <c:if test="${param.approvalStatus=='0'}">selected</c:if>>대기</option>
          <option value="1" <c:if test="${param.approvalStatus=='1'}">selected</c:if>>승인</option>
          <option value="2" <c:if test="${param.approvalStatus=='2'}">selected</c:if>>반려</option>
        </select>
      </div>
      <div class="col-md-2 col-6">
        <button class="btn btn-outline-secondary w-100">검색</button>
      </div>

      <!-- 요약 배지 묶음 (오른쪽 정렬) -->
      <c:if test="${not empty countPending or not empty countApproved or not empty countRejected}">
        <div class="col-auto ms-auto d-flex align-items-center">
          <div class="chip-group">
            <span class="chip pending  ${approvalStatus==0 ? 'is-active' : ''}">
              <span class="dot"></span> 대기 <span class="count">${countPending}</span>
            </span>
            <span class="chip approved ${approvalStatus==1 ? 'is-active' : ''}">
              <span class="dot"></span> 승인 <span class="count">${countApproved}</span>
            </span>
            <span class="chip rejected ${approvalStatus==2 ? 'is-active' : ''}">
              <span class="dot"></span> 반려 <span class="count">${countRejected}</span>
            </span>
          </div>
        </div>
      </c:if>
    </form>

    <table class="cert-table">
      <thead class="table-head">
      <tr>
        <th style="width:112px">사진</th>
        <th class="col-content">내용</th>
        <th style="width:130px">유형/일차</th>
        <th class="col-title">챌린지</th>
        <th style="width:160px">회원</th>
        <th style="width:150px">작성일</th>
        <th style="width:90px">상태</th>
        <th style="width:150px">관리</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="row" items="${list}">
        <tr class="cert-row">
          <!-- 사진 -->
          <td>
            <c:choose>
              <c:when test="${not empty row.photoUrl}">
                <img class="thumb" src="${cp}/uploads/challenge/${row.photoUrl}"
                     onerror="this.onerror=null; this.src='${NOIMG}'" />
              </c:when>
              <c:otherwise>
                <img class="thumb" src="${NOIMG}" />
              </c:otherwise>
            </c:choose>
          </td>

          <!-- 내용 -->
          <td class="col-content">
            <div class="fw-semibold text-truncate"><c:out value="${row.content}" /></div>
            <div class="muted">참여: <c:out value="${row.participateDate}"/> · 포인트 + <c:out value="${row.rewardPoints}"/> P</div>
          </td>

          <!-- 유형/일차 -->
          <td>
            <c:choose>
              <c:when test="${row.challengeType=='SPECIAL'}">
                <span class="pill special">SPECIAL</span>
                <div class="muted mt-1">Day <c:out value="${row.dayNumber}" /></div>
              </c:when>
              <c:otherwise>
                <span class="pill daily">DAILY</span>
              </c:otherwise>
            </c:choose>
          </td>

          <!-- 챌린지 -->
          <td class="col-title">
			  <div class="text-truncate">
			    <span class="title-link"><c:out value="${row.title}" /></span>
			  </div>
			  <c:if test="${row.challengeType=='SPECIAL'}">
			    <div class="muted"><c:out value="${row.startDate}" /> ~ <c:out value="${row.endDate}" /></div>
			  </c:if>
		  </td>

          <!-- 회원 -->
          <td>
            <div class="fw-semibold"><c:out value="${row.memberName}" /></div>
            <div class="muted">회원번호 #<c:out value="${row.memberId}" /></div>
          </td>

          <!-- 작성일 -->
          <td><c:out value="${row.postRegDate}" /></td>

          <!-- 상태 -->
          <td>
            <c:choose>
              <c:when test="${row.approvalStatus==1}"><span class="status-badge status-1">승인</span></c:when>
              <c:when test="${row.approvalStatus==2}"><span class="status-badge status-2">반려</span></c:when>
              <c:otherwise><span class="status-badge status-0">대기</span></c:otherwise>
            </c:choose>
          </td>

          <!-- 관리 -->
          <td>
            <div class="btn-line">
              <form method="post" action="<c:url value='/admin/challengeManage/cert/approve'/>">
                <input type="hidden" name="postId" value="${row.postId}" />
                <input type="hidden" name="page" value="${page}" />
                <input type="hidden" name="keyword" value="${keyword}" />
                <input type="hidden" name="type" value="${type}" />
                <input type="hidden" name="approvalStatus" value="${param.approvalStatus}" />
                <button class="btn-approve" type="submit">승인</button>
              </form>

              <form method="post" action="<c:url value='/admin/challengeManage/cert/reject'/>">
                <input type="hidden" name="postId" value="${row.postId}" />
                <input type="hidden" name="page" value="${page}" />
                <input type="hidden" name="keyword" value="${keyword}" />
                <input type="hidden" name="type" value="${type}" />
                <input type="hidden" name="approvalStatus" value="${param.approvalStatus}" />
                <button class="btn-reject" type="submit">반려</button>
              </form>
            </div>
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty list}">
        <tr class="cert-row"><td colspan="8" class="text-center text-muted py-5">데이터가 없습니다.</td></tr>
      </c:if>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="paging-wrap">${paging}</div>
  </div>
</div>

<!-- scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 승인, 반려 알림창 표시 -->
<c:if test="${not empty message}">
<script>
  (function() {
    var el = document.getElementById('actionToast');
    if (!el) return;
    el.querySelector('.toast-body').textContent = '${message}'.replace(/'/g, "\\'");
    var toast = new bootstrap.Toast(el);
    toast.show();
  })();
</script>
</c:if>
</body>
</html>
