<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="content-header">
    <h3>1:1 문의</h3>
</div>

<ul class="nav nav-tabs" id="inquiryTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="history-tab" data-bs-toggle="tab" data-bs-target="#history-tab-pane" type="button">내 문의내역</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="write-tab" data-bs-toggle="tab" data-bs-target="#write-tab-pane" type="button">문의하기</button>
    </li>
</ul>

<div class="tab-content pt-4" id="inquiryTabContent">
    <div class="tab-pane fade show active" id="history-tab-pane" role="tabpanel">
        <table class="table table-hover inquiry-table">
            <thead>
                <tr>
                    <th width="15%">상태</th>
                    <th width="15%">분류</th>
                    <th>제목</th>
                    <th width="20%">작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty myInquiries}">
                    <tr>
                        <td colspan="4" class="text-center p-5 text-muted">작성한 문의 내역이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="dto" items="${myInquiries}">
                    <tr>
                        <td>
                            <c:if test="${dto.status == 0}"><span class="status-badge pending">답변 대기</span></c:if>
                            <c:if test="${dto.status == 1}"><span class="status-badge answered">답변 완료</span></c:if>
                            <c:if test="${dto.status == 2}"><span class="status-badge answered">삭제</span></c:if>
                        </td>
                        <td>${dto.categoryName}</td>
                        <td class="inquiry-subject">
                        	<div class="text-wrap">
                        		<c:if test="${dto.status == 2}">
                            		<span>${dto.subject}</span>
                        		</c:if>
                        		<c:if test="${dto.status != 2}">
                        		<a onclick="detailInquiry('${dto.inquiryId}', '${pageNo}');">${dto.subject}</a>                        		
                        		</c:if>
                        	</div>
                        </td>
                        <td>${dto.regDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="tab-pane fade" id="write-tab-pane" role="tabpanel">
		<div class="form-card">
			<form name="inquiryForm" method="POST">
				<div class="mb-3">
					<label for="categoryId" class="form-label">카테고리</label>
					<select class="form-select" id="categoryId" name="categoryId" required>
					    <option value="" selected disabled>문의 유형을 선택하세요</option>
					    <c:forEach var="dto" items="${inquiryCategories}">
					        <option value="${dto.categoryId}">${dto.categoryName}</option>
					    </c:forEach>
					</select>
				</div>
				<div class="mb-3">
					<label for="subject" class="form-label">제목</label>
					<input type="text" class="form-control" id="subject" name="subject" placeholder="문의 제목을 입력하세요" required>
				</div>
				<div class="mb-4">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" id="question" name="question" rows="8" placeholder="문의하실 내용을 자세히 작성해주세요" required></textarea>
				</div>
				<div class="d-grid">
					 <button type="submit" class="btn btn-outline-primary my-btn">문의 등록</button>
				</div>
			</form>
		</div>
    </div>
</div>