<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
textarea[name="questionAnswer"] {
    resize: none;
}
</style>
<div class="container-fluid">
    <h4 class="mb-3">문의 내용</h4>
    <table class="table table-bordered info-table">
        <tbody>
            <tr>
                <th>작성자</th>
                <td>${dto.name} (${dto.memberId})</td>
                <th>작성일</th>
                <td>${dto.regDate}</td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td colspan="3">${dto.categoryName}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td colspan="3">${dto.subject}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <div class="question-content">${dto.question}</div>
                </td>
            </tr>
        </tbody>
    </table>

    <hr class="my-4">
    
    <h4 class="mb-3">답변 관리</h4>
    <form name="answerForm" method="post" onsubmit="return sendAnswer(this);">
        <c:choose>
            <c:when test="${dto.status == 1}">
                <div class="mb-3">
                    <label class="form-label fw-bold">등록된 답변 내용</label>
                    <textarea class="form-control" name="questionAnswer" rows="8" readonly>${dto.questionAnswer}</textarea>
                </div>
                <div class="d-flex justify-content-between text-secondary small">
                    <span><strong>담당자:</strong> ${dto.answerName}</span>
                    <span><strong>답변일:</strong> ${dto.answerDate}</span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="mb-3">
                    <label for="answer" class="form-label fw-bold">답변 등록</label>
                    <textarea class="form-control" id="answer" name="questionAnswer" rows="8" placeholder="고객의 문의에 대한 답변을 입력하세요."></textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn my-btn">답변 등록하기</button>
                </div>
            </c:otherwise>
        </c:choose>
        
        <input type="hidden" name="inquiryId" value="${dto.inquiryId}">
        <input type="hidden" name="pageNo" value="${pageNo}">
    </form>
</div>