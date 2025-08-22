<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:forEach var="vo" items="${listCategory}">
  <tr>
    <td>
      <input type="text" name="categoryName" class="form-control form-control-sm" disabled value="${vo.categoryName}">
    </td>
    <td align="center">
  <input type="hidden" name="categoryId" value="${vo.categoryId}">
  <div class="category-modify-btn">
    <span class="text-link btnCategoryUpdate" title="수정">
      <i class="bi bi-pencil-fill"></i>
    </span>
    &nbsp;
    <span class="text-link btnCategoryDeleteOk" title="삭제">
      <i class="bi bi-trash-fill"></i>
    </span>
  </div>
  <div class="category-modify-btnOk" style="display:none">
    <span class="text-link btnCategoryUpdateOk" title="수정완료">
      <i class="bi bi-check-square-fill"></i>
    </span>
    &nbsp;
    <span class="text-link btnCategoryUpdateCancel" title="수정취소">
      <i class="bi bi-x-square-fill"></i>
    </span>
  </div>
</td>

  </tr>
</c:forEach>
