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
<style type="text/css">
.my-btn {
   background: #fff;
   border: 1px solid black !important;
   border-radius: 4px;
   padding: 3px 10px
}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<div class="page-header">
		<h2>${mode=='update'?'분리배출 가이드 수정':'분리배출 가이드 등록'}</h2>
	</div>

	<form name="tipForm" class="write-form" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="subject" class="form-label">제목</label>
			<input type="text" id="subject" name="subject" class="form-control" placeholder="제목을 입력해주세요." value="${dto.subject}" >
		</div>
		
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임</label>
			<input type="text" id="nickname" name="nickname" class="form-control" value="${sessionScope.member.nickname}" readonly>
		</div>
		
		<div class="mb-3 d-flex align-items-center">
		    <div class="flex-grow-1 me-2">
		        <label for="categoryCodeSelect" class="form-label">카테고리</label>
		        <select id="categoryCodeSelect" class="form-select" name="categoryCode">
				    <c:forEach var="cat" items="${categories}">
				        <option value="${cat.categoryCode}"
				            <c:if test="${cat.categoryCode == dto.categoryCode}">selected</c:if>>
				            ${cat.categoryName}
				        </option>
				    </c:forEach>
				</select>
		    </div>
		    <div>
		        <button type="button" class="my-btn" onclick="writeForm()">카테고리추가</button>
		    </div>
		</div>
		
		<div class="mb-4">
			<label for="editor" class="form-label">내용</label>
			<div id="editor">${dto.content}</div>
			<input type="hidden" name="content">
		</div>
		<div class="mb-5">
		  	<div class="preview-session">
				<label for="selectFile" class="me-2" tabindex="0" title="사진 업로드">
					<span class="image-viewer"></span>
					<input type="file" name="selectFile" id="selectFile" hidden="" accept="image/png, image/jpeg">
				</label>
			</div>
		</div>
		<div class="text-center">
			<button type="button" class="btn btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
			<button type="button" class="btn btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/reguide/list?size=${size}';">${mode=='update'?'수정취소':'등록취소'}</button>
			<c:if test="${mode=='update'}">
				<input type="hidden" name="guidId" value="${dto.guidId}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="size" value="${size}">
			</c:if>
		</div>
	</form>
	
</main>

<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myDialogModalLabel">카테고리 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-2"></div>
    </div>
  </div> 	
</div>

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
window.addEventListener('DOMContentLoaded', evt => {
	const imageViewer = document.querySelector('form .image-viewer');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	let uploadImage = '${dto.imageFilename}';
	let img;
	if( uploadImage ) { // 수정인 경우
		img = '${pageContext.request.contextPath}/uploads/reguide/' + uploadImage;
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
				img = '${pageContext.request.contextPath}/uploads/reguide/' + uploadImage;
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

// --- 카테고리 등록 모달 열기 ---
function writeForm() {
    $('#myDialogModalLabel').text('카테고리 등록');

    let url = '${pageContext.request.contextPath}/reguide/addCategory';

    const fn = function(data){
        $('#myDialogModal .modal-body').html(data); 
        $('#myDialogModal').modal("show");         
    };

    ajaxRequest(url, 'get', null, 'text', fn); 
}

function sendOk() {
	const f = document.tipForm;
	
	let mode = '${mode}';
	
	if (!f.subject.value.trim()) {
        alert("제목을 입력하세요.");
        f.subject.focus();
        return;
    }

	let htmlContent = document.querySelector('#editor .ql-editor').innerHTML;
	if (!htmlContent || htmlContent.trim() === "<p><br></p>") {
		alert('내용을 입력하세요.');
		quill.focus();
		return;
	}
	
	f.content.value = htmlContent;
	
	f.action = '${pageContext.request.contextPath}/reguide/${mode}';
	f.submit();
}

$('#categoryCodeSelect').on('change', function() {
    $('#categoryCodeHidden').val(this.value);
});

// --- 카테고리 등록 / 삭제 ---
function CsendOk() {
    const url = '${pageContext.request.contextPath}/reguide/addCategory';
    const params = $('form[name=categoryForm]').serialize();

    const fn = function(data) {
        if (data.state === "success") {
            const $select = $('#categoryCodeSelect');

            if (data.newCategoryCode && data.newCategoryName) {
                if ($select.find(`option[value="${data.newCategoryCode}"]`).length === 0) {
                    const $newOption = $('<option>', {
                        value: data.newCategoryCode,
                        text: data.newCategoryName
                    });
                    $select.append($newOption);
                }

                $select.val(data.newCategoryCode);
                $('#categoryCodeHidden').val(data.newCategoryCode);
            } else {
                alert("카테고리 이름이 비어있습니다.");
            }

            $('#myDialogModal .btn-close').click();
            $('#myDialogModal .modal-body').empty();
        } else {
            alert("등록에 실패했습니다.");
        }
    };

    ajaxRequest(url, 'post', params, 'json', fn);
}

function deleteCategory(categoryCode) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    const url = '${pageContext.request.contextPath}/reguide/deleteCategory?categoryCode=' + categoryCode;

    $.get(url, function(data) {
        if (data === '성공') {
            $('#cat-' + categoryCode).remove(); 
            $('#categoryCodeSelect option[value="'+categoryCode+'"]').remove();
        } else if (data === '사용중') {
            alert("이미 사용 중인 카테고리는 삭제할 수 없습니다.");
        } else {
            alert("삭제 실패");
        }
    });
}

</script>

</body>
</html>