<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
    .detail-card { background-color: #fff; border: 1px solid var(--border-color); border-radius: 12px; padding: 2rem; }
    .detail-header { padding-bottom: 1rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); }
    .detail-header h3 { font-weight: 700; color: var(--text-dark); margin: 0; }
    .detail-table th { width: 120px; background-color: #f8f9fa; font-weight: 600; text-align: center; vertical-align: middle; }
    .detail-content { white-space: pre-wrap; background-color: #f8f9fa; padding: 1.5rem; border-radius: 6px; min-height: 100px; }
    .answer-section { background-color: #f5f7fa; border-radius: 8px; padding: 1.5rem; margin-top: 2rem; }
    .answer-title { font-weight: 600; color: var(--primary-color); display: flex; align-items: center; gap: 8px; margin-bottom: 1rem; }
    .btn-wrapper { text-align: right; margin-top: 2rem; }
    textarea { resize: none; }
</style>

<div class="detail-card">
    <c:if test="${empty dto}">
        <div class="alert alert-warning">문의 내역을 찾을 수 없거나 접근 권한이 없습니다.</div>
    </c:if>

    <c:if test="${not empty dto}">
        <div id="inquiry-view-mode">
            <div class="detail-header">
                <h3>1:1 문의 조회</h3>
            </div>
            <table class="table table-bordered detail-table mt-4">
                <tbody>
                    <tr><th>카테고리</th><td>${dto.categoryName}</td></tr>
                    <tr><th>제목</th><td>${dto.subject}</td></tr>
                    <tr><th>내용</th><td><div class="detail-content">${dto.question}</div></td></tr>
                </tbody>
            </table>

            <c:if test="${dto.status == 1}">
                <div class="answer-section">
                    <h5 class="answer-title"><i class="bi bi-chat-dots-fill"></i> 관리자 답변</h5>
                    <div class="detail-content bg-white">${dto.questionAnswer}</div>
                </div>
            </c:if>

            <div class="btn-wrapper d-flex justify-content-between">
                <button type="button" class="btn btn-secondary" onclick="loadContent('inquiry');">목록으로</button>
                <c:if test="${dto.status == 0}">
                    <div>
                        <button type="button" class="btn btn-outline-danger btn-delete" data-inquiry-id="${dto.inquiryId}">삭제하기</button>
                        <button type="button" class="btn btn-primary btn-edit">수정하기</button>
                    </div>
                </c:if>
            </div>
        </div>

        <div id="inquiry-edit-mode" style="display: none;">
            <div class="detail-header">
                <h3>1:1 문의 수정</h3>
            </div>
            <form name="inquiryUpdateForm" class="mt-4">
                <div class="mb-3">
                    <label class="form-label">카테고리</label>
                    <select class="form-select" name="categoryId">
                        <c:forEach var="cat" items="${inquiryCategories}">
                            <option value="${cat.categoryId}" ${dto.categoryId == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <input type="text" class="form-control" name="subject" value="${dto.subject}">
                </div>
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <textarea class="form-control" name="question" rows="8">${dto.question}</textarea>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4">
                    <button type="button" class="btn btn-secondary btn-cancel-edit">취소</button>
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                </div>
                <input type="hidden" name="inquiryId" value="${dto.inquiryId}">
            </form>
        </div>
    </c:if>
</div>