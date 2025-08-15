<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
/* textarea 크기 조절 막고 세로 길이 더 길게 */
textarea.form-control {
    resize: none;        /* 크기 조절 불가 */
    min-height: 150px;   /* 세로 길이 충분히 길게 */
}

/* tr 첫 번째 td 텍스트 가운데 정렬 */
.write-form td:first-child {
    text-align: center;
    vertical-align: middle;
}

/* 모달창 화면 가운데로 띄우기 */
.modal-dialog {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh; /* 화면 세로 중앙 정렬 */
}

.modal-content {
    border-radius: 8px;
    padding: 20px;
}


</style>
		
<form name="faqForm" method="post">
	<table class="table write-form">
		<tr>
			<td class="col-md-2 bg-light">카테고리</td>
			<td>
				<div class="row">
					<div class="col-md-6">
						<select name="categoryId" class="form-select">
							<c:forEach var="vo" items="${listCategory}">
								<option value="${vo.categoryId}" ${dto.categoryId==vo.categoryId?"selected":""}>${vo.categoryName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="col-md-2 bg-light">제 목</td>
			<td>
				<input type="text" name="subject" class="form-control" maxlength="100" value="${dto.subject}">
			</td>
		</tr>

		<tr>
			<td class="col-md-2 bg-light">이 름</td>
			<td>
				<div class="row">
					<div class="col-md-6">
						<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.member.name}" readonly>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="col-md-2 bg-light">내 용</td>
			<td>
				<textarea name="content" class="form-control">${dto.content}</textarea>
			</td>
		</tr>		
	</table>
	
	<div class="text-center mb-3">
		<button type="button" class="btn-accent btn-md" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type="reset" class="btn-default btn-md">다시입력</button>
		<button type="button" class="btn-default btn-md"  onclick="sendCancel();">${mode=='update'?'수정취소':'등록취소'}</button>
		<c:if test="${mode=='update'}">
			<input type="hidden" name="faqId" value="${dto.faqId}">
		</c:if>
	</div>
</form>