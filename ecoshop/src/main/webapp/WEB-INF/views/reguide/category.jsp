<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form name="categoryForm" class="p-2 mb-3">
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

<!-- 카테고리 리스트 -->
<div class="category-list">
    <table class="table table-bordered table-sm align-middle text-center">
        <thead class="table-light">
            <tr>
                <th style="width:70%">카테고리명</th>
                <th style="width:30%">관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cat" items="${list}">
                <tr id="cat-${cat.categoryCode}">
                    <td>${cat.categoryName}</td>
                    <td>
                        <button type="button" class="btn btn-sm btn-danger"
                                onclick="deleteCategory(${cat.categoryCode})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>