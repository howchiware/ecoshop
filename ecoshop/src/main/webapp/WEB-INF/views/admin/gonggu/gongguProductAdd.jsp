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
            <div class="pb-2">
                <h4 class="title">${mode=='update'?'상품 수정':'상품 등록'}</h4>
            </div>
            <hr>

            <div class="outside">
                <form method="post" name="gongguProductForm" enctype="multipart/form-data">
                    <div class="title">카테고리</div>
                    <div class="card-body">
                        <table class="form-table">
                            <tr>
                                <th>패키지 상품구성</th>
                                <td>
                                    <select name="categoryId" class="st">
                                        <option value="">::카테고리 선택::</option>
                                        <c:forEach var="vo" items="${categoryList}">
                                            <option value="${vo.categoryId}" ${dto.categoryId==vo.categoryId?"selected":""}>${vo.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="productId" class="st">
                                        <option value="">::상품 선택::</option>
                                        <c:if test="dto.categoryId==vo.categoryId">
	                                        <c:forEach var="vo" items="${productList}">
	                                        	<option value="${vo.productId}" ${dto.productId==vo.productId?"selected":""}>${vo.productName}</option>
	                                        </c:forEach>
                                        </c:if>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="title">기본정보</div>
                    <div class="card-body">
                        <table class="form-table">
                            <tr>
                                <th>상품명</th>
                                <td><input type="text" name="gongguProductName"
                                    placeholder="상품명을 입력하세요" value="${dto.gongguProductName}"></td>
                            </tr>
                            <tr>
                                <th>상품 사진</th>
                                <td>
                                    <div>상품 대표 이미지</div>
                                    <div class="photo">
                                        <label for="gongguThumbnailFile" class="me-2" tabindex="0" title="이미지 업로드"> 
                                            <span class="image-viewer"></span> 
                                            <input type="file" name="gongguThumbnailFile" id="gongguThumbnailFile" hidden="" multiple accept="image/png, image/jpeg">
                                        </label>
                                    </div>
                                    <div style="margin-top: 20px;">추가 사진</div>
                                    <div class="additionalPhotos">
                                        
                                        <div class="preview-session">
                                            <label for="addPhotoFiles" class="me-2" tabindex="0" title="이미지 업로드">
                                                <img class="image-upload-btn" src="${pageContext.request.contextPath}/dist/images/add_photo.png">
                                                <input type="file" name="addPhotoFiles" id="addPhotoFiles" hidden="" multiple accept="image/png, image/jpeg">
                                            </label>
                                            <div class="image-upload-list">
                                                <c:forEach var="vo" items="${listPhoto}">
                                                    <img class="image-uploaded" src="${pageContext.request.contextPath}/uploads/gonggu/${vo.detailPhoto}"
                                                        data-fileNum="${vo.gongguProductDetailId}" data-filename="${vo.detailPhoto}">
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

                    <div class="title">가격</div>
                    <div class="card-body">
                        <table class="form-table">
                        	<tr>
                                <th>원가</th>
                                <td>
                                    <div class="input-flex">
                                        <input type="text" name="originalPrice"
                                            placeholder="원가를 입력하세요" value="${dto.originalPrice}"> <span>원</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>판매가</th>
                                <td>
                                    <div class="input-flex">
                                        <input type="text" name="gongguPrice"
                                            placeholder="판매가를 입력하세요" value="${dto.gongguPrice}"> <span>원</span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="title">상품진열</div>
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

                    <div class="title">상품 상세정보</div>
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
                        <c:url var="url" value="/admin/gonggu/listProduct">
                            <c:if test="${not empty page}">
                                <c:param name="page" value="${page}"/>
                            </c:if>
                        </c:url>                            
                        <button type="button" class="btn-accent btn-md submit-btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
                        <button type="reset" class="btn-default btn-md">다시입력</button>
                        <button type="button" class="btn-default btn-md" onclick="location.href='${url}';">${mode=='update'?'수정취소':'등록취소'}</button>
                        <c:if test="${mode=='update'}">
                            <input type="hidden" name="productCode" value="${dto.productCode}">
                            <input type="hidden" name="gongguProductId" value="${dto.gongguProductId}">
                            <input type="hidden" name="gongguThumbnail" value="${dto.gongguThumbnail}">
                            <input type="hidden" name="page" value="${page}">
                            
                            <input type="hidden" name="prevOptionNum" value="${empty dto.optionNum ? 0 : dto.optionNum}">
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </main>

<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductAdd.js"></script>
<script type="text/javascript">
$(function(){
	let mode = '${mode}';
	
	if(mode === 'write') {
		// 등록인 경우
		$('#productShow1').prop('checked', true);
	}
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
	const f = document.gongguProductForm;
	let mode = '${mode}';
	
	let b;

	if(! f.categoryId.value) {
		alert('카테고리를 선택하세요.');
		f.categoryId.focus();
		return;
	}
	
	if(! f.gongguProductName.value.trim()) {
		alert('상품명을 입력하세요.');
		f.gongguProductName.focus();
		return;
	}	
	
	if(! f.content.value.trim()) {
		alert('상품 소개글을 입력하세요.');
		f.content.focus();
		return;
	}
	
	if(!/^(\d){1,8}$/.test(f.originalPrice.value)) {
		alert('상품가격을 입력 하세요.');
		f.originalPrice.focus();
		return;
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
	
	if(mode === 'write' && ! f.gongguThumbnailFile.value) {
		alert('대표 이미지를 등록하세요.');
		f.gongguThumbnailFile.focus();
		return false;
	}	
	
	f.action = '${pageContext.request.contextPath}/admin/gonggu/${mode}';
	f.submit();
}


//단일 이미지 ---
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=gongguThumbnailFile]');
	
	let uploadImage = '${dto.gongguThumbnail}';
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
				
			let url = '${pageContext.request.contextPath}/admin/gonggu/deleteFile';
			// let fileNum = el.getAttribute('data-fileNum');
			let fileNum = el.dataset.filenum;
			let filename = el.dataset.filename;

			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {fileNum:fileNum, filename:filename}, function(data){
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
	const inputEL = document.querySelector('form input[name=addPhotoFiles]');
	
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
			node.setAttribute('data-filename', file.name);

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
			
			let filename = e.target.getAttribute('data-filename');
			
			for(let i = 0; i < sel_files.length; i++) {
				if(filename === sel_files[i].name){
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