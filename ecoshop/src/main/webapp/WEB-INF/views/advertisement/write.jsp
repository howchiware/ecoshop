<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>광고 신청</title>
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
  <style>
    body {
      font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
      background: ##f7f6f3;
      color: #333;
    }
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      background: #fff;
    }
    h3 {
      font-weight: 700;
      color: #333;
    }
    .form-label {
      font-weight: 500;
      margin-bottom: 6px;
    }
    .form-control, .form-select {
      border-radius: 10px;
    }
    .my-btn {
	   background: #fff;
	   border: 1px solid black !important;
	   border-radius: 4px;
	   padding: 3px 10px
	}

    .delete-file {
      cursor: pointer;
    }
  </style>
</head>
<body>
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<main class="main-container">
  <div class="container my-5">
    <div class="card p-5">
      <div class="mb-4 text-center">
        <h3>광고 신청</h3>
        <p style="color: #28a745; font-weight: bold;">
          광고 신청 시 회원 관리자에게 내용이 전달되며, 확인 후 이메일 또는 전화로 연락드립니다.
        </p>
      </div>
      <form name="advertisementForm" method="post" enctype="multipart/form-data">
        <div class="mb-3">
          <label class="form-label">작성자<span class="text-danger">  *</span></label>
          <input type="text" name="username" class="form-control" value="${dto.username}" placeholder="작성자 입력" required maxlength="50">
        </div>
        <div class="mb-3">
          <label class="form-label">제목<span class="text-danger">  *</span></label>
          <input type="text" name="subject" class="form-control" value="${dto.subject}" placeholder="제목 입력" required maxlength="100">
        </div>
        <div class="mb-3">
          <label class="form-label">내용<span class="text-danger">  *</span></label>
          <textarea name="content" class="form-control" rows="5" placeholder="내용 입력" required>${dto.content}</textarea>
        </div>
        <div class="mb-3">
          <label class="form-label">문의유형</label>
          <select name="inquiryType" class="form-select">
            <option value="1" ${dto.inquiryType == 1 ? 'selected' : ''}>메인</option>
            <option value="2" ${dto.inquiryType == 2 ? 'selected' : ''}>개인페이지</option>
          </select>
        </div>
        <div class="mb-3">
          <label class="form-label">이메일<span class="text-danger">  *</span></label>
          <input type="email" name="email" class="form-control" value="${dto.email}" placeholder="이메일 입력" required>
        </div>
        <div class="mb-3">
          <label class="form-label">전화번호<span class="text-danger">  *</span></label>
          <input type="text" name="tel" class="form-control" value="${dto.tel}"  placeholder="전화번호 입력" required pattern="^01[0-9]-?\d{3,4}-?\d{4}$" 
         	title="전화번호 형식(010-1234-5678)">
        </div>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label class="form-label">광고 시작일</label>
            <input type="date" name="adverStart" class="form-control" value="${dto.adverStart}">
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">광고 종료일</label>
            <input type="date" name="adverEnd" class="form-control" value="${dto.adverEnd}">
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label">첨부파일</label>
          <input type="file" class="form-control" name="selectFile" multiple>
        </div>
        <c:if test="${mode=='update'}">
          <div class="mb-3">
            <label class="form-label">첨부된 파일</label>
            <div>
              <c:forEach var="vo" items="${listFile}">
                <span class="me-3">
                  <label class="delete-file text-danger" data-advertisingFileNum="${vo.advertisingFileNum}">
                    <i class="bi bi-trash"></i>
                  </label>
                  ${vo.originalFilename}
                </span>
              </c:forEach>
            </div>
          </div>
        </c:if>
        <div class="text-center mt-4">
          <button type="button" class="my-btn" onclick="location.href='${pageContext.request.contextPath}/main/home';">뒤로가기</button>
          <button type="submit" class="my-btn" onclick="sendOk()">신청하기</button>
        </div>
      </form>
    </div>
  </div>
</main>
<script>
function validateForm() {
    const f = document.advertisementForm;

    // 작성자
    if(!f.username.value.trim()) {
      alert("작성자 입력해주세요");
      f.username.focus();
      return false;
    }

    // 제목
    if(!f.subject.value.trim()) {
      alert("제목 입력해주세요");
      f.subject.focus();
      return false;
    }

    // 내용
    if(!f.content.value.trim()) {
      alert("내용 입력해주세요");
      f.content.focus();
      return false;
    }

    // 전화번호
    const telPattern = /^01[0-9]-?\d{3,4}-?\d{4}$/;
    if(!f.tel.value.trim()) {
      alert("전화번호 입력해주세요");
      f.tel.focus();
      return false;
    } else if(!telPattern.test(f.tel.value.trim())) {
      alert("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678");
      f.tel.focus();
      return false;
    }

    // 이메일
    if(!f.email.value.trim()) {
      alert("이메일 입력해주세요");
      f.email.focus();
      return false;
    }
    
    // 날짜
    const startDate = f.adverStart.value;
    const endDate = f.adverEnd.value;
    if(startDate && endDate && new Date(endDate) < new Date(startDate)) {
      alert("광고 종료일은 시작일 이후여야 합니다.");
      f.adverEnd.focus();
      return false;
    }

    return true; // 모든 체크 통과 시 폼 제출
}

// sendOk에서 검증 후 제출
function sendOk() {
    if(validateForm()) {
        const f = document.advertisementForm;
        f.action = '${pageContext.request.contextPath}/advertisement/write';
        f.submit();
    }
}
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:if test="${mode=='update'}">
  <script>
    $('.delete-file').click(function(){
      if(!confirm('선택한 파일을 삭제하시겠습니까?')) return;
      let $span = $(this).closest('span');
      let advertisingFileNum = $(this).attr('data-advertisingFileNum');
      $.ajaxSetup({ beforeSend: function(e){ e.setRequestHeader('AJAX', true); } });
      $.post('${pageContext.request.contextPath}/advertisement/deleteFile', {advertisingFileNum}, function(){
        $span.remove();
      }, 'json').fail(function(xhr){ console.log(xhr.responseText); });
    });
  </script>
</c:if>
<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>