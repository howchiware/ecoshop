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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <form method="post" name="productForm" enctype="multipart/form-data">
                    <div class="title">카테고리</div>
                    <div class="card-body">
                        <table class="form-table">
                            <tr>
                                <th>카테고리</th>
                                <td>
                                    <select name="categoryId" class="st">
                                        <option value="">::카테고리 선택::</option>
                                        <c:forEach var="vo" items="${categoryList}">
                                            <option value="${vo.categoryId}" ${dto.categoryId==vo.categoryId?"selected":""}>${vo.categoryName}</option>
                                        </c:forEach>
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
                                            <span class="image-viewer">
                                                <c:if test="${not empty dto.gongguThumbnail}">
                                                    <img src="${pageContext.request.contextPath}/uploads/gongguProducts/${dto.gongguThumbnail}" alt="상품 대표 이미지">
                                                    <span class="remove-btn" onclick="removePhoto(this)">X</span>
                                                </c:if>
                                            </span> 
                                            <input type="file" name="gongguThumbnailFile" id="gongguThumbnailFile" hidden="" accept="image/png, image/jpeg">
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
                                                    <img class="image-uploaded" src="${pageContext.request.contextPath}/uploads/gongguProducts/${vo.photoName}"
                                                        data-fileNum="${vo.gongguProductPhotoNum}" data-filename="${vo.photoName}">
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
                            <input type="hidden" name="gongguProductId" value="${dto.gongguProductId}">
                            <input type="hidden" name="gongguThumbnail" value="${dto.gongguThumbnail}">
                            <input type="hidden" name="page" value="${page}">
                            
                            <input type="hidden" name="prevOptionNum" value="${empty dto.optionNum ? 0 : dto.optionNum}">
                            <input type="hidden" name="prevOptionNum2" value="${empty dto.optionNum2 ? 0 : dto.optionNum2}">
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </main>

<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/qeditor.js"></script>
<script src="${pageContext.request.contextPath}/dist/jsGonggu/gongguProductAdd.js"></script>
    
</body>
</html>