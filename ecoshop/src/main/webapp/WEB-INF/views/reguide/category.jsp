<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form name="categoryForm" class="p-2">
    <div class="mb-3">
        <label for="categoryName" class="form-label">카테고리 이름</label>
        <input type="text" class="form-control" id="categoryName" name="categoryName"
               placeholder="카테고리명을 입력하세요." required />
    </div>
    <div class="text-center">
        <button type="button" class="btn-accent btn-md" onclick="CsendOk()">등록</button>
        <button type="button" class="btn-default btn-md" data-bs-dismiss="modal">취소</button>
    </div>
</form>