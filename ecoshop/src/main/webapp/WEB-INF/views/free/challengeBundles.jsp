<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>챌린지 톡</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/dist/css/home.css" type="text/css">
  <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/dist/cssFree/free.css" type="text/css">
  <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/dist/cssFree/dairyList.css" type="text/css">

  <style>
    .card-img-top{ object-fit:cover; height:180px; }
    .badge-progress{ background:#111; color:#fff; }
    .modal-body .day-card img{ width:100%; max-height:320px; object-fit:cover; border-radius:10px; }
    .text-truncate-2{
      display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;
    }
  </style>
</head>
<body>
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">
  <jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>

  <!-- 상단 바 -->
  <div class="d-flex align-items-center gap-2 my-3">
    <select id="sort" class="form-select form-select-sm" style="width:120px;">
      <option value="RECENT">최신순</option>
      <option value="PROGRESS">진행 완료</option>
    </select>
    <div class="ms-auto small text-muted">스페셜 챌린지에 도전하세요!</div>
  </div>

  <!-- 번들 카드 그리드 -->
  <div id="bundle-grid" class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3"></div>

  <!-- 더보기 -->
  <div class="text-center mt-3">
    <button id="loadMore" class="btn btn-outline-secondary btn-sm">더보기</button>
  </div>
</main>

<!-- 스레드 모달 -->
<div class="modal fade" id="threadModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable modal-fullscreen-sm-down">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="threadTitle" class="modal-title">3일치 인증</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div id="threadBody" class="modal-body"><!-- JS가 렌더링 --></div>
    </div>
  </div>
</div>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
 
  var ctx = '<c:out value="${pageContext.request.contextPath}"/>';

  var page = 1, size = 12;

  function esc(s){
    if(s==null) return '';
    return String(s).replace(/[&<>"']/g, function(m){
      return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[m];
    });
  }

  function tplBundleCard(d){
    var img = d.photoUrl ? (ctx + '/uploads/challenge/' + d.photoUrl)
                         : (ctx + '/dist/img/noimage.png');
    var progress = ((d.approvedDays||0) + '/3');
    var dateTxt = d.postRegDate || '';
    var name = d.memberName || '';
    var title = d.title || '';
    var pid = d.participationId;

    var html = '';
    html += '<div class="col">';
    html += '  <div class="card h-100 shadow-sm bundle-card" data-pid="' + pid + '" data-title="' + esc(title) + '">';
    html += '    <img class="card-img-top" src="' + img + '" alt="thumbnail">';
    html += '    <div class="card-body">';
    html += '      <div class="d-flex justify-content-between align-items-center mb-1">';
    html += '        <span class="badge badge-progress">' + esc(progress) + '</span>';
    html += '        <small class="text-muted">' + esc(dateTxt) + '</small>';
    html += '      </div>';
    html += '      <div class="fw-semibold text-truncate">' + esc(title) + '</div>';
    html += '      <div class="text-muted small text-truncate">' + esc(name) + '</div>';
    html += '    </div>';
    html += '  </div>';
    html += '</div>';
    return html;
  }

  function loadBundles(reset){
    if(reset){
      page = 1;
      $('#bundle-grid').empty();
      $('#loadMore').prop('disabled', false).text('더보기');
    }
    var sort = $('#sort').val();
    var url = ctx + '/free/challengeBundles/feed?page=' + page + '&size=' + size + '&sort=' + encodeURIComponent(sort);

    fetch(url)
      .then(function(r){ if(!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function(rows){
        if(!Array.isArray(rows) || rows.length===0){
          $('#loadMore').prop('disabled', true).text('더 이상 없음');
          return;
        }
        rows.forEach(function(d){ $('#bundle-grid').append(tplBundleCard(d)); });
        page++;
      })
      .catch(function(){
        alert('로딩 실패');
      });
  }

  $(document).on('click', '#loadMore', function(){ loadBundles(false); 
  
  });
  $('#sort').on('change', function(){ loadBundles(true); 
  
  });

  $(document).on('click', '.bundle-card', function() {
    var pidRaw = $(this).data('pid');
    var pid = Number(pidRaw);
    if(!Number.isInteger(pid) || pid <= 0){
      alert('잘못된 참여 식별자입니다.');
      return;
    }
    var title = $(this).data('title') || '3일치 인증';
    $('#threadTitle').text(title);

    var url = ctx + '/free/challengeBundles/thread?participationId=' + encodeURIComponent(pid);
    fetch(url)
      .then(function(r){ if(!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function(rows){
        var html = '';
        if(Array.isArray(rows) && rows.length){
          rows.forEach(function(p){
            var img = p.photoUrl ? (ctx + '/uploads/challenge/' + p.photoUrl)
                                 : (ctx + '/dist/img/noimage.png');
            var badge = (p.approvalStatus==1 ? 'bg-success' : (p.approvalStatus==0 ? 'bg-secondary' : 'bg-danger'));
            // var link = ctx + '/free/challengeList/' + p.postId; // 단건 보기(기존 리스트형 목록으로 가기)
            var link = ctx + '/free/challengeList/' + p.postId + '?src=bundles'; // 번들용 리스트
            html += '<div class="day-card mb-3">';
            html += '  <div class="d-flex justify-content-between align-items-center">';
            html += '    <div class="fw-semibold">' + esc(p.dayNumber) + '일차</div>';
            html += '    <div>';
            html += '      <span class="badge ' + badge + ' me-2">' + (p.approvalStatus==1?'승인':(p.approvalStatus==0?'대기':'반려')) + '</span>';
            html += '      <a class="btn btn-sm btn-outline-secondary js-view-one" href="' + link + '" target="_self">단건 보기</a>';
            html += '    </div>';
            html += '  </div>';
            html += '  <img src="' + img + '" alt="day photo" class="my-2">';
            html += '  <div class="small">' + esc(p.content||'') + '</div>';
            html += '  <div class="text-muted small mt-1">' + esc(p.postRegDate||'') + '</div>';
            html += '</div>';
          });
        } else {
          html = '<div class="text-muted">공개된 인증이 없습니다.</div>';
        }
        $('#threadBody').html(html);
        new bootstrap.Modal('#threadModal').show(); // 모달 오픈
      })
      .catch(function(err){
        console.error('thread load failed:', err);
        alert('스레드 불러오기 실패');
      });
  });

  $(function(){ loadBundles(true); 
  
  });
  
  $(document).on('click', '.js-view-one', function(){
	  var modalEl = document.getElementById('threadModal');
	  if (modalEl) {
	    var m = bootstrap.Modal.getInstance(modalEl);
	    if (m) m.hide();
	  }
	});

  
  
  
</script>
</body>
</html>
