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
								<td class="col-md-2 bg-light">카테고리</td>
								<td>
									<select name="categoryId" id="categoryId">
										<option value="">카테고리 선택</option>
											<c:forEach var="vo" items="${listCategory}">
												<option value="${vo.categoryId}" ${dto.categoryId==vo.categoryId?'selected':''}>${vo.categoryName}</option>
											</c:forEach>
									</select>	
												
								</td>
							</tr>
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
								<td class="col-md-2 bg-light">재고</td>
								<td>
									<input type="number" name="limitCount" class="form-control" value="${dto.limitCount}">
								</td>
							</tr>
							
							<tr>
								<td class="col-md-2 bg-light">할인율</td>
								<td>
									<input type="number" name="sale" class="form-control" value="${dto.sale}">
								</td>
							</tr>
							
							<tr>
								<td class="col-md-2 bg-light">간단한 소개글</td>
								<td>
									<textarea name="content" class="form-control">${dto.content}</textarea>
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
								<td class="col-md-2 bg-light">패키지 상세 내용</td>
								<td>
									<div id="editor">${dto.detailInfo}</div> <input type="hidden"
									name="detailInfo" value="">
								</td>
							</tr>
							
							<tr>
								<td class="col-md-2 bg-light">대표이미지</td>
								<td>
									<div class="preview-session">
										<label for="selectFile" class="me-2" tabindex="0"
											title="사진 업로드"> <span class="image-viewer"></span> <input
											type="file" name="selectFile" id="selectFile" hidden=""
											accept="image/png, image/jpeg">
										</label>
									</div>
								</td>
								
								<tr>
									<td class="col-md-2 bg-light">추가이미지</td>
									<td>
										<div class="preview-session">
											<label for="addFiles" class="me-2" tabindex="0" title="이미지 업로드">
												<img class="image-upload-btn" src="${pageContext.request.contextPath}/dist/images/add_photo.png">
												<input type="file" name="addFiles" id="addFiles" hidden="" multiple accept="image/png, image/jpeg">
											</label>
											<div class="image-upload-list">
												<c:forEach var="vo" items="${listFile}">
													<img class="image-uploaded" src="${pageContext.request.contextPath}/uploads/gonggu/${vo.detailPhoto}"
														data-fileNum="${vo.gongguProductDetailId}" data-filename="${vo.detailPhoto}">
												</c:forEach>
											</div>
										</div>
									</td>			
							</tr>
						</table>

						<div class="text-center">
							<button type="button" class="btn-accent btn-md"
								onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md"
								onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/listProduct';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="gongguProductId"
									value="${dto.gongguProductId}">
								<input type="hidden" name="gongguThumbnail"
									value="${dto.gongguThumbnail}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>
					</form>
				</div>
                </div>
	</main>

	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/quill-resize-module@2.0.4/dist/resize.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>

	<script type="text/javascript">

	window.addEventListener('DOMContentLoaded', evt => {
		const imageViewer = document.querySelector('form .image-viewer');
		const inputEL = document.querySelector('form input[name=selectFile]');
		
		let uploadImage = '${dto.gongguThumbnail}';
		let img;
		if( uploadImage ) {
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
				if( uploadImage ) {
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
		htmlContent = htmlContent.replace(/<p[^>]*>/gi, ''); 
		htmlContent = htmlContent.replace(/<\/p>/gi, '');
		htmlContent = htmlContent.replace(/<br\s*\/?>/gi, ''); 
		htmlContent = htmlContent.replace(/&nbsp;/g, ' ');
		htmlContent = htmlContent.replace(/\s/g, ''); 
		
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
		
		const detailInfoContent = quill.root.innerHTML;
		f.detailInfo.value = detailInfoContent;

		const simpleContent = f.content.value.trim();
		
		if(! hasContent(detailInfoContent) && ! hasContent(simpleContent)) {
			alert('내용을 입력하세요. ');
			quill.focus();
			return;
		}

		if( (mode === 'write') && (! f.selectFile.value) ) {
			alert('이미지 파일을 추가 하세요. ');
			f.selectFile.focus();
			return;
		}	
		
		f.action = '${pageContext.request.contextPath}/admin/gonggu/${mode}';
		f.submit();
	}

	window.addEventListener('DOMContentLoaded', evt => {
	    const fileUploadList = document.querySelectorAll('form .image-upload-list .image-uploaded');

	    for(let el of fileUploadList) {
	        el.addEventListener('click', () => {

	            if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
	                return false;
	            }

	            let url = '${pageContext.request.contextPath}/admin/gonggu/deleteFile';
	            let fileNum = el.dataset.filenum;

	            $.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
	            $.post(url, {fileNum:fileNum}, function(data){
	                el.remove();
	            }, 'json').fail(function(xhr){
	                console.log(xhr.responseText);
	            });

	        });
	    }
	});

	window.addEventListener('DOMContentLoaded', evt => {
		var sel_files = [];
		
		const imageListEL = document.querySelector('form .image-upload-list');
		const inputEL = document.querySelector('form input[name=addFiles]');
		
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