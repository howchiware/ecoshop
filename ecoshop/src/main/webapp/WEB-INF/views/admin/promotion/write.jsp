<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항</title>
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
 <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

    <div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>포토 갤러리</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
		<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">

					<div class="pb-2">
						<span class="small-title">${mode=='update' ? '게시글 수정' : '게시글 등록'}</span>
					</div>
				
					<form name="postForm" action="" method="post" enctype="multipart/form-data">
						<table class="table write-form">
							<tr>
								<td class="col-md-2 bg-light">제 목</td>
								<td>
									<input type="text" name="subject" class="form-control" maxlength="100"  value="${dto.subject}">
								</td>
							</tr>
							
							<tr>
								<td class="col-md-2 bg-light">번호</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${dto.advertisingId}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이 름</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.member.name}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이미지</td>
								<td>
									<div class="preview-session">
										<label for="selectFile" class="me-2" tabindex="0" title="사진 업로드">
											<span class="image-viewer"></span>
											<input type="file" name="selectFile" id="selectFile" hidden="" accept="image/png, image/jpeg">
										</label>
									</div>
								</td>
							</tr>
						</table>
						
						<div class="text-center">
							<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/admin/promotion/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="promotionId" value="${dto.promotionId}">
								<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>						
					</form>

				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 단일 이미지 추가
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	let uploadImage = '${dto.imageFilename}';
	let img;
	if( uploadImage ) { // 수정인 경우
		img = '${pageContext.request.contextPath}/uploads/promotion' + uploadImage;
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
				img = '${pageContext.request.contextPath}/uploads/promotion/' + uploadImage;
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

function sendOk() {
	const f = document.postForm;
	let str;
	
	let mode = '${mode}';
	if( (mode === 'write') && (!f.selectFile.value) ) {
		alert('이미지 파일을 추가 하세요. ');
		f.selectFile.focus();
		return;
	}
	
	
	f.action = '${pageContext.request.contextPath}/admin/promotion/${mode}';
	f.submit();
}
</script>

</body>
</html>