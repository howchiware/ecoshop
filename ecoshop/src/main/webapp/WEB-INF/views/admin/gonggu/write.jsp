<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 등록/수정</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/productAdd.css" type="text/css">

<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.css" rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
			<div class="title">
				<h3>${mode=='update'?'공동구매 수정':'공동구매 등록'}</h3>
            </div>
            
			<hr>
				<div class="outside">
					<form name="gongguProductForm" method="post" enctype="multipart/form-data">
						<table class="table write-form">
							<tr>
								<td class="col-md-2 bg-light">제 목</td>
								<td><input type="text" name="gongguProductName" class="form-control"
									value="${dto.gongguProductName}"></td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">시작일자</td>
								<td>
									<div class="row">
										<div class="col-md-5 pe-2">
											<input type="date" name="sday" class="form-control"
												value="${dto.sday}">
										</div>
										<div class="col-md-5">
											<input type="time" name="stime" class="form-control"
												value="${dto.stime}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">종료일자</td>
								<td>
									<div class="row">
										<div class="col-md-5 pe-2">
											<input type="date" name="eday" class="form-control"
												value="${dto.eday}">
										</div>
										<div class="col-md-5">
											<input type="time" name="etime" class="form-control"
												value="${dto.etime}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">출력여부</td>
								<td>
									<div class="py-2">
										<input type="radio" name="productShow"
											class="form-check-input" id="productShow1" value="1"
											${empty dto || dto.productShow==1 ? "checked" : "" }>
										<label class="form-check-label" for="productShow1">표시</label>
										&nbsp;&nbsp; <input type="radio" name="productShow"
											class="form-check-input" id="productShow0" value="0"
											${dto.productShow==0 ? "checked" : "" }> <label
											class="form-check-label" for="productShow0">숨김</label>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">내 용</td>
								<td>
									<div id="editor">${dto.content}</div> <input type="hidden"
									name="content">
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이미지</td>
								<td>
									<div class="preview-session">
										<label for="selectFile" class="me-2" tabindex="0"
											title="사진 업로드"> <span class="image-viewer"></span> <input
											type="file" name="selectFile" id="selectFile" hidden=""
											accept="image/png, image/jpeg">
										</label>
									</div>
								</td>
							</tr>
						</table>

						<div class="text-center">
							<button type="button" class="btn-accent btn-md"
								onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md"
								onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/${mode}';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="gongguProductId"
									value="${dto.gongguProductId}">
								<input type="hidden" name="imageFilename"
									value="${dto.imageFilename}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>
					</form>
				</div>

			</div>
	</main>

	<!-- Quill Rich Text Editor -->
	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
	<!-- Quill Editor Image Resize JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.js"></script>
	<!-- Quill Editor 적용 JS -->
	<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>

	<script type="text/javascript">

// 단일 이미지 추가
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	let uploadImage = '${dto.imageFilename}';
	let img;
	if( uploadImage ) { // 수정인 경우
		img = '${pageContext.request.contextPath}/uploads/gonggu/' + uploadImage;
	} else {
		img = '${pageContext.request.contextPath}/dist/images/add_photo.png';
	}
	imageViewer.textContent = '';
	imageViewer.style.backgroundImage = 'url(' + img + ')';
	
	inputEL.addEventListener('change', ev => {
		let file = ev.target.files[0];
		if(! file) {
			let img;
			if( uploadImage ) { // 수정인 경우
				img = '${pageContext.request.contextPath}/uploads/gonggu/' + uploadImage;
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

function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch(e) {
		return false;
	}
}

function hasContent(htmlContent) {
	htmlContent = htmlContent.replace(/<p[^>]*>/gi, ''); // p 태그 제거
	htmlContent = htmlContent.replace(/<\/p>/gi, '');
	htmlContent = htmlContent.replace(/<br\s*\/?>/gi, ''); // br 태그 제거
	htmlContent = htmlContent.replace(/&nbsp;/g, ' ');
	htmlContent = htmlContent.replace(/\s/g, ''); // 공백 제거
	
	return htmlContent.length > 0;
}

function sendOk() {
	const f = document.gongguProductForm;
	const mode = '${mode}';
	let str;
	
	str = f.gongguProductName.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.gongguProductName.focus();
		return;
	}

	if(! isValidDateString(f.sday.value)) {
		alert('날짜를 입력하세요.');
		f.sday.focus();
		return;
	}
	
	if(! f.stime.value) {
		alert('시간을 입력하세요.');
		f.stime.focus();
		return;
	}

	if(! isValidDateString(f.eday.value)) {
		alert('날짜를 입력하세요.');
		f.eday.focus();
		return;
	}
	
	if(! f.etime.value) {
		alert('시간을 입력하세요.');
		f.etime.focus();
		return;
	}
	
	let sd = new Date(f.sday.value + ' ' + f.stime.value);
	let ed = new Date(f.eday.value + ' ' + f.etime.value);
	
	if( sd.getTime() >= ed.getTime() ) {
		alert('시작날짜는 종료날짜보다 크거나 같을 수 없습니다.');
		f.sday.focus();
		return;
	}

	if( mode === 'write' && new Date().getTime() > ed.getTime() ) {
		alert('종료날짜는 현재 시간보다 작을수 없습니다.');
		f.eday.focus();
		return;
	}
	
	b = false;
	for(let s of f.productShow) {
		if( s.checked ) {
			b = true;
			break;
		}
	}
	if( ! b ) {
		alert('표시 여부를 선택하세요.');
		f.productShow[0].focus();
		return false;
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

	if( (mode === 'write') && (! f.selectFile.value) ) {
		alert('이미지 파일을 추가 하세요. ');
		f.selectFile.focus();
		return;
	}	
	
	f.action = '${pageContext.request.contextPath}/admin/gonggu/${mode}';
	f.submit();
}
</script>
</body>
</html>