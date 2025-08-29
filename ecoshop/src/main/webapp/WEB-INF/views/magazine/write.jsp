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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<div class="page-header">
		<h2>${mode=='update'?'에코모아 매거진 수정':'에코모아 매거진 등록'}</h2>
	</div>

	<form name="dairyForm" class="write-form" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="subject" class="form-label">제목</label>
			<input type="text" id="subject" name="subject" class="form-control" placeholder="제목을 입력해주세요." value="${dto.subject}" maxlength="50">
		</div>
		
		<div class="mb-3">
			<label for="name" class="form-label">이름</label>
			<input type="text" id="name" name="name" class="form-control" value="${sessionScope.member.name}" readonly>
		</div>
		
		<div class="mb-4">
			<label for="editor" class="form-label">내용</label>
			<div id="editor">${dto.content}</div>
			<input type="hidden" name="content">
		</div>
		
		<div class="mb-5">
		  	<div class="preview-session">
				<label for="selectFile" class="me-2 form-label" tabindex="0" title="표지 업로드">
					썸네일 등록
					<span class="image-viewer"></span>
					<input type="file" name="selectFile" id="selectFile" hidden="" accept="image/png, image/jpeg">
				</label>
			</div>
		</div>
		
		<div class="button-group">
			<button type="button" class="btn btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
			<button type="button" class="btn btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/magazine/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			<c:if test="${mode=='update'}">
				<input type="hidden" name="magazineId" value="${dto.magazineId}">
				<input type="hidden" name="page" value="${page}">
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
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	let uploadImage = '${dto.originalFilename}';
	let img;
	if( uploadImage ) {  
		img = '${pageContext.request.contextPath}/uploads/magazine/' + uploadImage;
	} else {
		img = '${pageContext.request.contextPath}/dist/images/add_photo.png';
	}
	imageViewer.textContent = '';
	imageViewer.style.backgroundImage = 'url(' + img + ')';
	
	inputEL.addEventListener('change', ev => {
		let file = ev.target.files[0];
		if(! file) {
			let img;
			if( uploadImage ) { 
				img = '${pageContext.request.contextPath}/uploads/magazine/' + uploadImage;
			} else {
				img = '${pageContext.request.contextPath}/dist/images/add_photo.png';
			}
			imageViewer.textContent = '';
			imageViewer.style.backgroundImage = 'url(' + img + ')';
			
			return;
		}
		
		if(! file.type.match('image.*')) {
			inputEL.focus();
			return;
		}
		
		const reader = new FileReader();
		reader.onload = e => {
			imageViewer.textContent = '';
			imageViewer.style.backgroundImage = 'url(' + e.target.result + ')';
		};
		reader.readAsDataURL(file);
	});
	
});
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
    
	str = f.subject.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.subject.focus();
		return;
	}
    
	const htmlViewEL = document.querySelector('textarea#html-view');
	let htmlContent = htmlViewEL ? htmlViewEL.value : quill.root.innerHTML;
	if(! hasContent(htmlContent)) {
		alert('내용을 입력하세요. ');
		if(htmlViewEL) {
			htmlViewEL.focus();
		} else {
			quill.focus();
		}
		return;
	}
	f.content.value = htmlContent;
	
	f.action = '${pageContext.request.contextPath}/magazine/${mode}';
	f.submit();
}
</script>

</body>
</html>