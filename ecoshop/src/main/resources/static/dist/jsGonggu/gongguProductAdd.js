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
	const f = document.productForm;
	let mode = '${mode}';
	
	let b;

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


//단일 이미지 ---
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=gongguThumbnailFile]');
	
	let uploadImage = '${dto.gongguThumbnail}';
	let img;
	if( uploadImage ) { // 수정인 경우
		img = '${pageContext.request.contextPath}/uploads/gongguProducts/' + uploadImage;
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
				img = '${pageContext.request.contextPath}/uploads/gongguProducts/' + uploadImage;
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
				
			let url = '${pageContext.request.contextPath}/admin/gongguProducts/deleteFile';
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