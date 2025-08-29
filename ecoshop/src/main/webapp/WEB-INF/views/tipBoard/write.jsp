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
<style type="text/css">
.community-guidelines {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 0.5rem;
    padding: 1.5rem;
    margin-bottom: 2rem;
}

.guidelines-title {
    font-size: 1.1rem;
    font-weight: 600;
    margin-bottom: 0.75rem;
    color: #212529;
}

.guidelines-title i {
    color: #198754;
    margin-right: 0.5rem;
}

.guidelines-intro {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1rem;
}

.community-guidelines ul {
    padding-left: 1.2rem;
    margin-bottom: 0;
    font-size: 0.875rem;
}

.community-guidelines li {
    margin-bottom: 0.5rem;
    color: #495057;
}

.community-guidelines li:last-child {
    margin-bottom: 0;
}
.guidelines-warning {
    margin-top: 1.25rem;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    color: #664d03;
    display: flex;
    align-items: center;
}

.guidelines-warning i {
    margin-right: 0.5rem;
    font-size: 1rem;
}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<div class="page-header">
		<h2>${mode=='update'?'제로웨이스트 팁 수정':'제로웨이스트 팁 등록'}</h2>
	</div>
	<div class="community-guidelines">
	    <h5 class="guidelines-title">
	        <i class="bi bi-check2-circle"></i> 커뮤니티 가이드라인
	    </h5>
	    <p class="guidelines-intro">
	        모두가 유용한 정보를 얻고 즐겁게 소통하는 공간을 위해 아래 가이드라인을 지켜주세요.
	    </p>
	    <ul>
	        <li><strong>주제 존중:</strong> 제로웨이스트, 친환경 라이프와 관련된 팁과 정보를 공유해주세요.</li>
	        <li><strong>상호 존중:</strong> 비방, 욕설, 타인에게 불쾌감을 주는 언어 사용을 자제해주세요.</li>
	        <li><strong>정보 공유:</strong> 유용하고 사실에 기반한 정보를 공유하며 서로에게 도움을 주세요.</li>
	        <li><strong>광고 지양:</strong> 상업적 목적의 광고나 스팸성 게시물은 지양해주세요.</li>
	    </ul>
	    <p class="guidelines-warning">
	        <i class="bi bi-exclamation-triangle-fill"></i>
	        가이드라인을 위반하는 게시물은 사전 통보 없이 삭제될 수 있습니다.
    </p>
    </div>

	<form name="tipForm" class="write-form" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="subject" class="form-label">제목</label>
			<input type="text" id="subject" name="subject" class="form-control" placeholder="제목을 입력해주세요." maxlength="50" 
			value="${mode == 'reply' ? 'RE: ' : ''}${dto.subject}" ${mode == 'reply' ? 'readonly' : ''}>
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
		
		<div class="text-center button-group">
			<button type="button" class="btn btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
			<button type="reset" class="btn btn-default btn-md">다시입력</button>
			<button type="button" class="btn btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/tipBoard/list?size=${size}';">${mode=='update'?'수정취소':'등록취소'}</button>
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
    const f = document.tipForm;
    
    // 제목 체크
    let str = f.subject.value.trim();
    if( ! str ) {
        alert('제목을 입력하세요.');
        f.subject.focus();
        return;
    }
    
    const htmlViewEL = document.querySelector('textarea#html-view');
    let htmlContent = htmlViewEL ? htmlViewEL.value : quill.root.innerHTML;
    if(! hasContent(htmlContent)) {
        alert('내용을 입력하세요.');
        if(htmlViewEL) htmlViewEL.focus();
        else quill.focus();
        return;
    }
    
	f.content.value = htmlContent;

    f.action = '${pageContext.request.contextPath}/tipBoard/${mode}';
    f.submit();
}
</script>

</body>
</html>