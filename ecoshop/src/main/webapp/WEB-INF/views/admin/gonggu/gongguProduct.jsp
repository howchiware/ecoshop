<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공동구매 상품 등록/수정</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Quill Rich Text Editor -->
<link
	href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css"
	rel="stylesheet">
<!-- Quill Editor Image Resize CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.css"
	rel="stylesheet">

<style type="text/css">
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

.main-container {
	display: flex;
}

.right-PANEL {
	flex-grow: 1;
	padding: 2rem;
	overflow-y: auto;
}

.subtitle {
	background-color: #cccccc;
	color: #ffffff;
	padding: 1rem 1.5rem;
	border-radius: 8px 8px 0 0;
	font-weight: 600;
}

.form-table {
	width: 100%;
	border-collapse: collapse;
	font-size: 0.95rem;
}

.form-table tr {
	border-bottom: 1px solid #e9ecef;
}

.form-table tr:last-child {
	border-bottom: none;
}

.form-table th, .form-table td {
	padding: 1.5rem;
	vertical-align: top;
	border-top: 1px solid #c6c6c6;
	border-bottom: 1px solid #c6c6c6;
}

.form-table th {
	background-color: #f8f9fa;
	text-align: left;
	width: 150px;
	font-weight: 500;
}

.form-table td select, .form-table td input[type="text"], .form-table td textarea
	{
	width: 100%;
	padding: 0.75rem 1rem;
	border: 1px solid #ced4da;
	border-radius: 5px;
	box-shadow: none;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.form-table td select:focus, .form-table td input[type="text"]:focus,
	.form-table td textarea:focus {
	border-color: #86b7fe;
	box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}

.form-table td label {
	display: block;
	font-weight: 500;
	margin-bottom: 0.5rem;
}

.form-table td small {
	display: block;
	margin-top: 0.5rem;
	color: #6c757d;
}

.input-flex {
	display: flex;
	align-items: center;
	gap: 10px;
	width: 30%;
}

.input-flex input {
	flex-grow: 1;
}

.info-layout {
	display: flex;
	gap: 30px;
}

.product-name-section {
	flex-grow: 1;
}

.product-photo-section {
	width: 300px;
}

.additionalPhotos {
	display: flex;
	gap: 15px;
	align-items: flex-end;
	margin-top: 10px;
}

.additionalPhotoUpload {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.additionalPhotoUpload button {
	width: 100px;
	padding: 8px;
}

.additionalPhoto {
	width: 100px;
	height: 100px;
	border: 1px dashed #ced4da;
}

.submit-btn {
	display: block;
	width: 200px;
	margin: 30px auto 0;
	padding: 15px;
	background-color: #343a40;
	color: #fff;
	border: none;
	border-radius: 5px;
	font-weight: 600;
	cursor: pointer;
}

.deadLine {
	border: 1px solid #c6c6c6;
	border-radius: 4px;
	color: #5D5D5D;
}

.outside {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.title {
	padding-bottom: 10px;
}
#editor {
  min-height: 300px;
  background-color: white;
}

.image-viewer {
  display: block;
  width: 100%;
  height: 150px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: left;
}


</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="right-PANEL">
			<div class="pb-2">
				<h4 class="title">${mode=='update'?'상품 수정':'상품 등록'}</h4>
			</div>
			<hr>

			<div class="outside">
				<form method="post" name="productForm" enctype="multipart/form-data">
					<div class="title">카테고리</div>
					<div class="card-body">
						<table class="form-table">
							<tr>
								<th>카테고리</th>
								<td><select name="categoryId" class="st">
										<option value="">::카테고리 선택::</option>
								</select></td>
							</tr>
						</table>
					</div>

					<div class="title">기본정보</div>
					<div class="card-body">
						<table class="form-table">
							<tr>
								<th>상품명</th>
								<td><input type="text" name="gongguProductName"
									placeholder="상품명을 입력하세요"></td>
							</tr>
							<tr>
								<th>상품 사진</th>
								<td>
									<div>상품 대표 이미지</div>
									<div class="photo">
										<label for="thumbnailFile" class="me-2" tabindex="0" title="이미지 업로드"> 
										<span class="image-viewer"></span> 
										<input type="file" name="gongguThumbnail" id="thumbnailFile" hidden="" accept="image/png, image/jpeg">
										</label>
									</div>
									<div style="margin-top: 20px;">추가 사진</div>
									<div class="additionalPhotos">
										<div class="mb-3">
											<label for="formFileSm" class="form-label"></label> <input
												class="form-control form-control-sm" id="formFileSm"
												type="file">
										</div>
										<div class="mb-3">
											<label for="formFileSm" class="form-label"></label> <input
												class="form-control form-control-sm" id="formFileSm"
												type="file">
										</div>
										<div class="mb-3">
											<label for="formFileSm" class="form-label"></label> <input
												class="form-control form-control-sm" id="formFileSm"
												type="file">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>상품 소개글</th>
								<td><textarea name="content" rows="4"
										placeholder="상품 소개글을 입력하세요" style="resize: none"></textarea></td>
							</tr>
						</table>
					</div>

					<div class="title">가격</div>
					<div class="card-body">
						<table class="form-table">
							<tr>
								<th>원가</th>
								<td>
									<div class="input-flex">
										<input type="text" name="originalPrice"
											placeholder="원가를 입력하세요"> <span>원</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>할인율</th>
								<td>
									<div class="input-flex">
										<input type="text" name="gongguPrice"
											placeholder="공동구매 할인율을 입력하세요"> <span>%</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>재고</th>
								<td>
									<div class="input-flex">
										<input type="text" name="limitCount"
											placeholder="재고 수량을 입력하세요"> <span>개</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>마감일</th>
								<td><input type="date" name="deadline" class="deadLine">
								</td>
							</tr>
						</table>
					</div>

					<div class="title">상품 상세정보</div>
					<div class="card-body">
						<table class="form-table">
							<tr>
								<th>상품 상세 내용</th>
								<td>
									<div id="editor">${dto.content}</div> <input type="hidden"
									name="content">
								</td>
							</tr>
						</table>
					</div>
					<button type="submit" class="submit-btn">등록</button>
				</form>
			</div>
		</div>
	</main>

	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>
	<script type="text/javascript">
	window.addEventListener('DOMContentLoaded', evt => {
		const imageViewer = document.querySelector('form .image-viewer');
		const inputEL = document.querySelector('form input[name=gongguThumbnail]');
		
		let uploadImage = '${dto.gongguThumbnail}';
		let img;
		if( uploadImage ) { // 수정인 경우
			img = '${pageContext.request.contextPath}/uploads/products/' + uploadImage;
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
					img = '${pageContext.request.contextPath}/uploads/products/' + uploadImage;
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
	</script>
	
</body>
</html>