<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<!-- Favicons -->
<link href="${pageContext.request.contextPath}/dist/images/h.png" rel="icon">
 
<!-- Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Nunito:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
  
<!-- Vendor CSS Files -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<!-- Core CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/core.css" type="text/css">
<!-- Main CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/main2.css" type="text/css">
<!-- Form CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/forms.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<!-- Quill Rich Text Editor -->
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

<!-- Vendor JS Files -->
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>

<!-- Quill Editor Image Resize CSS -->
<link href="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.css" rel="stylesheet">

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
	/*background-color: #cccccc;*/
	color: #555;
	padding: 1.5rem 0rem 0.8rem 0rem;
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
	width: 210px;
	margin: 30px auto 7px;
	padding: 15px;
	background-color:#b3b4b5;
	color: #fff;
	border: none;
	border-radius: 5px;
	font-weight: 600;
	cursor: pointer;
}

.submit-btn:hover {
	background: #88898b;
}

.btn-default:hover {
	border: 1px solid #88898b;
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
	/*padding-bottom: 10px;*/
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
button {
	background: #fff;
	border: 1px solid black;
	border-radius: 4px !important;
	padding: 3px 10px;
}
.hidden {
	visibility: hidden;
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
			<div class="title">
				<h3>${mode=='update'?'상품 수정':'상품 등록'}</h3>
			</div>
			<hr>

			<div class="outside">
				<form method="post" name="productForm" enctype="multipart/form-data">
					<div style="margin: 30px;">
						<div class="subtitle">카테고리</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>카테고리</th>
									<td>
										<select name="categoryId" class="st">
											<option value="">::카테고리 선택::</option>
											<c:forEach var="vo" items="${listCategory}">
												<option value="${vo.categoryId}" ${dto.categoryId==vo.categoryId?"selected":""}>${vo.categoryName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</table>
						</div>
	
						<div class="subtitle">기본정보</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>상품명</th>
									<td><input type="text" name="productName"
										placeholder="상품명을 입력하세요" value="${dto.productName}"></td>
								</tr>
								<tr>
									<th>상품 사진</th>
									<td>
										<div>상품 대표 이미지</div>
										<div class="photo">
											<label for="thumbnailFile" class="me-2" tabindex="0" title="이미지 업로드"> 
											<span class="image-viewer"></span> 
											<input type="file" name="thumbnailFile" id="thumbnailFile" hidden="" accept="image/png, image/jpeg">
											</label>
										</div>
										<div style="margin-top: 20px;">추가 사진</div>
										<div class="additionalPhotos">
											<!-- 
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
											-->
											<div class="preview-session">
												<label for="addFiles" class="me-2" tabindex="0" title="이미지 업로드">
													<img class="image-upload-btn" src="${pageContext.request.contextPath}/dist/images/add_photo.png">
													<input type="file" name="addFiles" id="addFiles" hidden="" multiple accept="image/png, image/jpeg">
												</label>
												<div class="image-upload-list">
													<!-- 클래스 -> image-item:새로추가된이미지, image-uploaded:수정에서 등록된이미지 -->
													<!-- 수정일때 등록된 이미지 -->
													<c:forEach var="vo" items="${listPhoto}">
														<img class="image-uploaded" src="${pageContext.request.contextPath}/uploads/products/${vo.photoName}"
															data-productPhotoNum="${vo.productPhotoNum}" data-photoName="${vo.photoName}">
													</c:forEach>
												</div>
											</div>
											
										</div>
									</td>
								</tr>
								<tr>
									<th>상품 소개글</th>
									<td><textarea name="content" rows="4"
											placeholder="상품 소개글을 입력하세요" style="resize: none">${dto.content}</textarea></td>
								</tr>
							</table>
						</div>
	
						<div class="subtitle">가격</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>판매가</th>
									<td>
										<div class="input-flex">
											<input type="text" name="price"
												placeholder="판매가를 입력하세요" value="${dto.price}" pattern="[^\d]*"> <span>원</span>
										</div>
									</td>
								</tr>
							</table>
						</div>
						
						<div class="subtitle">적립금</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>적립금</th>
									<td>
										<div class="row">
											<div class="col-md-6">
												<input type="text" name="point" class="form-control" value="${dto.point}"  pattern="[^\d]*">
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
						
						<div class="subtitle">상품옵션</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>상품옵션</th>
									<td>
										<div class="row">
											<div class="col-md-6">
												<c:if test="${mode=='update'}">
													<input type="hidden" name="optionCount" value="${dto.optionCount}">
												</c:if>
												<select name="optionCount" class="form-select" ${dto.userBought == 1 ? "disabled":""} ${dto.totalStock > 0 ? "disabled":""}>
													<option value="2" ${dto.optionCount==2?"selected":""}>옵션 둘</option>
													<option value="1" ${dto.optionCount==1?"selected":""}>옵션 하나</option>
													<option value="0" ${dto.optionCount==0?"selected":""}>옵션 없음</option>
												</select>
											</div>
										</div>
										<small class="form-control-plaintext help-block">상품 재고가 존재하면 옵션 변경은 불가능합니다.</small>
									</td>
								</tr>
	
								<tr class="product-option-1">
									<th>옵션 1</th>
									<td>
										<div class="mb-2">
											<input type="text" name="optionName" class="form-control" style="width: 250px;" placeholder="옵션명" value="${dto.optionName}" ${dto.userBought == 1 ? "disabled":""}>
											<c:if test="${mode=='update'}">
												<input type="hidden" name="optionNum" value="${empty dto.optionNum ? 0 : dto.optionNum}" ${dto.userBought == 1 ? "disabled":""}>
											</c:if>
										</div>
										<div class="row option-area">
											<div class="col-auto pe-0 d-flex flex-row optionValue-area">
												<c:forEach var="vo" items="${listOptionDetail}">
													<div class="input-group pe-1">
														<input type="text" name="optionValues" class="form-control" style="flex:none; width: 90px;" placeholder="옵션값" value="${vo.optionValue}" ${dto.userBought == 1 ? "disabled":""}>
														<input type="hidden" name="optionDetailNums" value="${vo.optionDetailNum}" ${dto.userBought == 1 ? "disabled":""}>
														<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus ${dto.userBought == 1 ? 'hidden':''}"></i>
													</div>
												</c:forEach>
												<c:if test="${empty listOptionDetail || listOptionDetail.size() < 1}">
													<div class="input-group pe-1">
														<input type="text" name="optionValues" class="form-control" style="flex:none; width: 90px;" placeholder="옵션값" ${dto.userBought == 1 ? "disabled":""}>
														<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus ${dto.userBought == 1 ? 'hidden':''}"></i>
													</div>
												</c:if>
											</div>
											<div class="col-auto">
												<button type="button" class="btn-default btnOptionAdd" ${dto.userBought == 1 ? "disabled":""}>추가</button>
											</div>
										</div>
										<small class="form-control-plaintext help-block">판매 상품이 존재하면 옵션은 삭제 되지 않습니다.</small>
									</td>
								</tr>
	
								<tr class="product-option-2">
									<th>옵션 2</th>
									<td>
										<div class="mb-2">
											<input type="text" name="optionName2" style="width: 250px;" class="form-control" placeholder="옵션명" value="${dto.optionName2}" ${dto.userBought == 1 ? "disabled":""}>
											<c:if test="${mode=='update'}">
												<input type="hidden" name="optionNum2" value="${empty dto.optionNum2 ? 0 : dto.optionNum2}" ${dto.userBought == 1 ? "disabled":""}>
											</c:if>
										</div>
										<div class="row option-area2">
											<div class="col-auto pe-0 d-flex flex-row optionValue-area2">
												<c:forEach var="vo" items="${listOptionDetail2}">
													<div class="input-group pe-1">
														<input type="text" name="optionValues2" class="form-control" style="flex:none; width: 90px;" placeholder="옵션값" value="${vo.optionValue}" ${dto.userBought == 1 ? "disabled":""}>
														<input type="hidden" name="optionDetailNums2" value="${vo.optionDetailNum}" ${dto.userBought == 1 ? "disabled":""}>
														<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus2 ${dto.userBought == 1 ? 'hidden':''}"></i>
													</div>
												</c:forEach>
												<c:if test="${empty listOptionDetail2 || listOptionDetail2.size() < 1}">
													<div class="input-group pe-1">
														<input type="text" name="optionValues2" class="form-control" style="flex:none; width: 90px;" placeholder="옵션값" ${dto.userBought == 1 ? "disabled":""}>
														<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus2 ${dto.userBought == 1 ? 'hidden':''}"></i>
													</div>
												</c:if>
											</div>
											<div class="col-auto">
												<button type="button" class="btn-default btnOptionAdd2" ${dto.userBought == 1 ? "disabled":""}>추가</button>
											</div>
										</div>
										<small class="form-control-plaintext help-block">판매 상품이 존재하면 옵션은 삭제 되지 않습니다.</small>
									</td>
								</tr>
							</table>
						</div>
	
						<div class="subtitle">상품진열</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>상품진열</th>
									<td>
										<div class="py-2" style="display: inline-flex;">
											<input type="radio" class="form-check-input" name="productShow" id="productShow1" value="1" ${dto.productShow==1 ? "checked":"" }>
											<label for="productShow1" class="form-check-label">상품진열</label>
											&nbsp;&nbsp;
											<input type="radio" class="form-check-input" name="productShow" id="productShow2" value="0" ${dto.productShow==0 ? "checked":"" }>
											<label for="productShow2" class="form-check-label">진열안함</label>
										</div>
									</td>
								</tr>
							</table>
						</div>
	
						<div class="subtitle">상품 상세정보</div>
						<div class="card-body">
							<table class="form-table">
								<tr>
									<th>상품 상세 내용</th>
									<td>
										<div id="editor">${dto.detailInfo}</div> <input type="hidden"
										name="detailInfo">
									</td>
								</tr>
							</table>
						</div>
						<div class="text-center">
							<c:url var="url" value="/admin/products/listProduct">
								<c:if test="${not empty page}">
									<c:param name="page" value="${page}"/>
								</c:if>
							</c:url>							
							<button type="button" class="btn-accent btn-md submit-btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md" onclick="location.href='${url}';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="productCode" value="${dto.productCode}">
								<input type="hidden" name="productId" value="${dto.productId}">
								<input type="hidden" name="thumbnail" value="${dto.thumbnail}">
								<input type="hidden" name="page" value="${page}">
								
								<input type="hidden" name="prevOptionNum" value="${empty dto.optionNum ? 0 : dto.optionNum}">
								<input type="hidden" name="prevOptionNum2" value="${empty dto.optionNum2 ? 0 : dto.optionNum2}">
								<input type="hidden" name="isBought" value="${dto.userBought == 1 ? 1:0}">
							</c:if>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
	
<!-- Quill Rich Text Editor -->
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
<!-- Quill Editor Image Resize JS -->
<script src="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.js"></script>
<!-- Quill Editor 적용 JS -->
<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>
	

<script type="text/javascript">
$(function(){
	let mode = '${mode}';
	
	if(mode === 'write') {
		// 등록인 경우
		$('#productShow1').prop('checked', true);
	} else if(mode === 'update') {
		// 수정인 경우
		let count = Number('${dto.optionCount}') || 0;
		
		if(count === 0) {
			$('.product-option-1').hide();
			$('.product-option-2').hide();
		} else if(count === 1) {
			$('.product-option-2').hide();
		}		
	}
});

function hasContent(htmlContent) {
	htmlContent = htmlContent.replace(/<p[^>]*>/gi, ''); // p 태그 제거
	htmlContent = htmlContent.replace(/<\/p>/gi, '');
	htmlContent = htmlContent.replace(/<br\s*\/?>/gi, ''); // br 태그 제거
	htmlContent = htmlContent.replace(/&nbsp;/g, ' ');
	htmlContent = htmlContent.replace(/\s/g, ''); // 공백 제거
	
	return htmlContent.length > 0;
}

$(function(){
	$('input[name="price"]').keyup(function(){
	 	var replace_text = $(this).val().replace(/[^-0-9]/g, '');
        $(this).val(replace_text);
        
		let point = $(this).val() * 0.1;
		console.log(point);
		$('input[name="point"]').val(point);
	});
	
	$('input[name="point"]').keyup(function(){
	 	var replace_text = $(this).val().replace(/[^-0-9]/g, '');
        $(this).val(replace_text);
	});
});

function sendOk() {
	const f = document.productForm;
	let mode = '${mode}';
	
	let str, b;

	if(! f.categoryId.value) {
		alert('카테고리를 선택하세요.');
		f.categoryId.focus();
		return;
	}
	
	if(! f.productName.value.trim()) {
		alert('상품명을 입력하세요.');
		f.productName.focus();
		return;
	}	
	
	if(! f.content.value.trim()) {
		alert('상품 소개글을 입력하세요.');
		f.content.focus();
		return;
	}
	
	if(!/^(\d){1,8}$/.test(f.price.value)) {
		alert('상품가격을 입력 하세요.');
		f.price.focus();
		return;
	}	

	
	if(!/^(\d){1,7}$/.test(f.point.value)) {
		alert('적립금을 입력 하세요.');
		f.point.focus();
		return;
	}
	
	let optionCount = parseInt(f.optionCount.value);
	if(optionCount > 0) {
		if(! f.optionName.value.trim()) {
			alert('옵션명 입력 하세요.');
			f.optionName.focus();
			return;
		}
		
		b = true;
		$('form input[name=optionValues]').each(function(){
			if(! $(this).val().trim()) {
				b = false;
				return false;
			}
		});
		
		if(! b) {
			alert('옵션값을 입력 하세요.');
			return;
		}
	}
	
	if(optionCount > 1) {
		if(! f.optionName2.value.trim()) {
			alert('옵션명 입력 하세요.');
			f.optionName2.focus();
			return;
		}
		
		b = true;
		$('form input[name=optionValues2]').each(function(){
			if(! $(this).val().trim()) {
				b = false;
				return false;
			}
		});
		
		if(! b) {
			alert('옵션값을 입력 하세요.');
			return;
		}
	}
	
	b = false;
	for(let ps of f.productShow) {
		if( ps.checked ) {
			b = true;
			break;
		}
	}
	if( ! b ) {
		alert('상품진열 여부를 선택하세요.');
		f.productShow[0].focus();
		return;
	}
	
	const htmlViewEL = document.querySelector('textarea#html-view');
	let htmlContent = htmlViewEL ? htmlViewEL.value : quill.root.innerHTML;
	if(! hasContent(htmlContent)) {
		alert('상품설명을 입력하세요. ');
		if(htmlViewEL) {
			htmlViewEL.focus();
		} else {
			quill.focus();
		}
		return;
	}
	f.detailInfo.value = htmlContent;
	
	if(mode === 'write' && ! f.thumbnailFile.value) {
		alert('대표 이미지를 등록하세요.');
		f.thumbnailFile.focus();
		return false;
	}	
	
	f.action = '${pageContext.request.contextPath}/admin/products/${mode}';
	f.submit();
}
</script>

<script type="text/javascript">
$(function(){
	// 옵션의 개수가 변경된 경우
	$('select[name=optionCount]').change(function(){
		let count = parseInt($(this).val());
		let mode = '${mode}';
		let savedCount = '${dto.optionCount}';
		let totalStock = '${dto.totalStock}';
		
		if(mode === 'update' && totalStock !== '0') {
			alert('옵션 변경이 불가능 합니다.');
			$(this).val(savedCount);
			return false;
		}
		
		if(count === 0) {
			$('.product-option-1').hide();
			$('.product-option-2').hide();
			
			
		} else if(count === 1) {
			$('.product-option-1').show();
			$('.product-option-2').hide();
			
			
		} else if(count === 2) {
			$('.product-option-1').show();
			$('.product-option-2').show();
		}
	});
});

$(function(){
	// 옵션 1 추가 버튼을 클릭한 경우	
	$('.btnOptionAdd').click(function(){
		let $el = $(this).closest('.option-area').find('.optionValue-area');
		if($el.find('.input-group').length >= 5) {
			alert('옵션은 최대 5개까지 가능합니다.');
			return false;
		}
		
		let $option = $('.option-area .optionValue-area .input-group:first-child').clone();
		
		$option.find('input[type=hidden]').remove();
		$option.find('input[name=optionValues]').removeAttr('value');
		$option.find('input[name=optionValues]').val('');
		$el.append($option);
	});
	
	// 옵션 1의 옵션값 제거를 클릭한 경우
	$('.option-area').on('click', '.option-minus', function(){
		let $minus = $(this);
		let $el = $minus.closest('.option-area').find('.optionValue-area');
		
		// 수정에서 등록된 자료 삭제
		let mode = '${mode}';
		if(mode === 'update' && $minus.parent('.input-group').find('input[name=detailNums]').length === 1) {
			// 저장된 옵션값중 최소 하나는 삭제되지 않도록 설정
			if($el.find('.input-group input[name=detailNums]').length <= 1) {
				alert('옵션값은 최소 하나이상 필요합니다.');	
				return false;
			}
			
			if(! confirm('옵션값을 삭제 하시겠습니까 ? ')) {
				return false;
			}
			
			let detailNum = $minus.parent('.input-group').find('input[name=detailNums]').val();
			let url = '${pageContext.request.contextPath}/admin/products/deleteOptionDetail';
			
			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {detailNum:detailNum}, function(data){
				if(data.state === 'true') {
					$minus.closest('.input-group').remove();
				} else {
					alert('옵션값을 삭제할 수 없습니다.');
				}
			}, 'json').fail(function(jqXHR){
				console.log(jqXHR.responseText);
			});
			
			return false;			
		}
		
		if($el.find('.input-group').length <= 1) {
			$el.find('input[name=optionValues]').val('');
			return false;
		}
		
		$minus.closest('.input-group').remove();
	});
});

$(function(){
	// 옵션 2 추가 버튼을 클릭한 경우	
	$('.btnOptionAdd2').click(function(){
		let $el = $(this).closest('.option-area2').find('.optionValue-area2');
		if($el.find('.input-group').length >= 5) {
			alert('옵션 값은 최대 5개까지 가능합니다.');
			return false;
		}
		let $option = $('.option-area2 .optionValue-area2 .input-group:first-child').clone();
		
		$option.find('input[type=hidden]').remove();
		$option.find('input[name=optionValues2]').removeAttr('value');
		$option.find('input[name=optionValues2]').val('');
		$el.append($option);
	});
	
	// 옵션 2의 옵션값 제거를 클릭한 경우
	$('.option-area2').on('click', '.option-minus2', function(){
		let $minus = $(this);
		let $el = $minus.closest('.option-area2').find('.optionValue-area2');
		
		// 수정에서 등록된 자료 삭제
		let mode = '${mode}';
		if(mode === 'update' && $minus.parent('.input-group').find('input[name=detailNums2]').length === 1) {
			// 저장된 옵션값중 최소 하나는 삭제되지 않도록 설정
			if($el.find('.input-group input[name=detailNums2]').length <= 1) {
				alert('옵션값은 최소 하나이상 필요합니다.');	
				return false;
			}
			
			if(! confirm('옵션값을 삭제 하시겠습니까 ? ')) {
				return false;
			}
			
			let detailNum = $minus.parent('.input-group').find('input[name=detailNums2]').val();
			let url = '${pageContext.request.contextPath}/admin/products/deleteOptionDetail';
			
			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {detailNum:detailNum}, function(data){
				if(data.state === 'true') {
					$minus.closest('.input-group').remove();
				} else {
					alert('옵션값을 삭제할 수 없습니다.');
				}
			}, 'json').fail(function(jqXHR){
				console.log(jqXHR.responseText);
			});
		}
		
		if($el.find('.input-group').length <= 1) {
			$el.find('input[name=optionValues2]').val('');
			return false;
		}
		
		$minus.closest('.input-group').remove();
	});
});

</script>

<script type="text/javascript">
//단일 이미지 ---
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=thumbnailFile]');
	
	let uploadImage = '${dto.thumbnail}';
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

// 다중 이미지 ---
// 수정인 경우 이미지 파일 삭제
window.addEventListener('DOMContentLoaded', evt => {
	const fileUploadList = document.querySelectorAll('form .image-upload-list .image-uploaded');
	
	for(let el of fileUploadList) {
		el.addEventListener('click', () => {
			/*
			let listEl = document.querySelectorAll('form .image-upload-list .image-uploaded');
			if(listEl.length <= 1) {
				alert('등록된 이미지가 2개 이상인 경우만 삭제 가능합니다.');
				return false;
			}
			*/
			
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
				
			let url = '${pageContext.request.contextPath}/admin/products/deleteFile';
			let productPhotoNum = el.getAttribute('data-productPhotoNum');
			let photoName = el.getAttribute('data-photoName');
			// let productPhotoNum = el.dataset.productPhotoNum;
			// let photoName = el.dataset.photoName;
			
			console.log(productPhotoNum);
			console.log(photoName);

			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {productPhotoNum:productPhotoNum, photoName:photoName}, function(data){
				el.remove();
			}, 'json').fail(function(xhr){
				console.log(xhr.responseText);
			});
			
		});
	}
});

// 다중 이미지 추가
window.addEventListener('DOMContentLoaded', evt => {
	var sel_files = [];
	
	const imageListEL = document.querySelector('form .image-upload-list');
	const inputEL = document.querySelector('form input[name=addFiles]');
	
	// sel_files[] 에 저장된 file 객체를 <input type="file">로 전송하기
	const transfer = () => {
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		inputEL.files = dt.files;
	}

	inputEL.addEventListener('change', ev => {
		if(! ev.target.files || ! ev.target.files.length) {
			transfer();
			return;
		}
		
		for(let file of ev.target.files) {
			if(! file.type.match('image.*')) {
				continue;
			}

			sel_files.push(file);
        	
			let node = document.createElement('img');
			node.classList.add('image-item');
			node.setAttribute('data-photoName', file.name);

			const reader = new FileReader();
			reader.onload = e => {
				node.setAttribute('src', e.target.result);
			};
			reader.readAsDataURL(file);
        	
			imageListEL.appendChild(node);
		}
		
		transfer();		
	});
	
	imageListEL.addEventListener('click', (e)=> {
		if(e.target.matches('.image-item')) {
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
			
			let photoName = e.target.getAttribute('data-photoName');
			
			for(let i = 0; i < sel_files.length; i++) {
				if(photoName === sel_files[i].name){
					sel_files.splice(i, 1);
					break;
				}
			}
		
			transfer();
			
			e.target.remove();
		}
	});	
});
</script>


</body>
</html>