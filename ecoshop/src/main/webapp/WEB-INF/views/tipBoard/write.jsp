<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyWrite.css" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.css" rel="stylesheet">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>
	
	<div class="page-header">
		<h2>${mode=='update'?'팁 수정':'팁 등록'}</h2>
	</div>

	<form name="dairyForm" class="write-form" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="subject" class="form-label">제목</label>
			<input type="text" id="subject" name="subject" class="form-control" placeholder="제목을 입력해주세요." value="${dto.subject}" maxlength="50">
		</div>
		
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임</label>
			<input type="text" id="nickname" name="nickname" class="form-control" value="${sessionScope.member.nickname}" readonly>
		</div>
		
		<div class="mb-4">
			<label for="editor" class="form-label">내용</label>
			<div id="editor">${dto.content}</div>
			<input type="hidden" name="content">
		</div>
		
		  <input type="hidden" name="saveFilename" value="${dto.saveFilename != null ? dto.saveFilename : ''}">
		
		<div class="text-center">
			<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
			<button type="reset" class="btn-default btn-md">다시입력</button>
			<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/tipBoard/list?size=${size}';">${mode=='update'?'수정취소':'등록취소'}</button>
			<c:if test="${mode=='update'}">
				<input type="hidden" name="tipId" value="${dto.tipId}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="size" value="${size}">
			</c:if>
			<c:if test="${mode=='reply'}">
				<input type="hidden" name="groupNum" value="${dto.groupNum}">
				<input type="hidden" name="orderNo" value="${dto.orderNo}">
				<input type="hidden" name="depth" value="${dto.depth}">
				<input type="hidden" name="parent" value="${dto.tipId}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="size" value="${size}">
			</c:if>
		</div>
	</form>
	
</main>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsFree/dairyWrite.js"></script>

<script type="text/javascript">
function hasContent(htmlContent) {
	htmlContent = htmlContent.replace(/<p[^>]*>/gi, '');
	htmlContent = htmlContent.replace(/<\/p>/gi, '');
	htmlContent = htmlContent.replace(/<br\s*\/?>/gi, '');
	htmlContent = htmlContent.replace(/&nbsp;/g, ' ');
	htmlContent = htmlContent.replace(/\s/g, '');
	
	return htmlContent.length > 0;
}
function sendOk() {
    const f = document.dairyForm;
    
    // 제목 체크
    let str = f.subject.value.trim();
    if( ! str ) {
        alert('제목을 입력하세요.');
        f.subject.focus();
        return;
    }
    
    // 내용 체크
    const htmlViewEL = document.querySelector('textarea#html-view');
    let htmlContent = htmlViewEL ? htmlViewEL.value : quill.root.innerHTML;
    if(! hasContent(htmlContent)) {
        alert('내용을 입력하세요.');
        if(htmlViewEL) htmlViewEL.focus();
        else quill.focus();
        return;
    }
    f.content.value = htmlContent;

    // 첫 번째 이미지 src 추출
    const tempDiv = document.createElement('div');
    tempDiv.innerHTML = htmlContent;
    const firstImg = tempDiv.querySelector('img');
    if(firstImg) {
        // 전체 경로에서 파일명만 저장
        const src = firstImg.getAttribute('src');
        const filename = src.split('/').pop();
        f.saveFilename.value = filename; // hidden input에 설정
    } else {
        f.saveFilename.value = ''; // 이미지 없으면 빈값
    }

    f.action = '${pageContext.request.contextPath}/tipBoard/${mode}';
    f.submit();
}
</script>

</body>
</html>