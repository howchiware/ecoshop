<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<head>
<style>
.accordion-item {
  border: none;
  border-radius: 6px;
  margin-bottom: 0.75rem;
  overflow: hidden;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

.accordion-button {
  font-weight: 500;
  background-color: #f8f9fa;
  color: #000; /* 기본 제목 검정 */
  transition: all 0.2s ease-in-out;
}
.accordion-button:hover {
  background-color: rgba(35, 77, 60, 0.08);
}
.accordion-button:not(.collapsed) {
  background-color: var(--theme-green) !important;
  color: #fff !important;
}

/* 카테고리 텍스트 강조 */
.accordion-button .faq-category {
  font-weight: 700;
  color: var(--theme-green);
  margin-right: 6px;
}

.accordion-body {
  background-color: #fff;
  font-size: 0.95rem;
  color: #000; /* 본문 검정 */
}

.accordion-body label {
  font-weight: 500;
  color: #000; /* 라벨 검정 */
}

.faq-content {
  white-space: pre-line;
  line-height: 1.6;
}

/* 버튼 영역 */
.btn-outline-primary {
  color: var(--theme-green) !important;
  border-color: var(--theme-green) !important;
}
.btn-outline-primary:hover {
  background-color: var(--theme-green) !important;
  border-color: var(--theme-green) !important;
  color: #fff !important;
}

.btn-outline-danger {
  color: var(--theme-red) !important;
  border-color: var(--theme-red) !important;
}
.btn-outline-danger:hover {
  background-color: var(--theme-red) !important;
  border-color: var(--theme-red) !important;
  color: #fff !important;
}

.board-section {
    background-color: #e6f4ea;
    padding: 20px;
    border-radius: 8px;
    color: #000;
}

.board-section h2,
.board-section p,
.board-section td,
.board-section th {
    color: #000;
}

.board-section a {
    color: #000;
    text-decoration: none;
}
.board-section a:hover {
    color: #0d6efd;
    text-decoration: underline;
}



</style>
</head>
<c:if test="${list.size() > 0}">
  <div class="accordion accordion-flush mt-1" id="accordionFlush"> 
    <c:forEach var="dto" items="${list}" varStatus="status">
      <div class="accordion-item">
        <h2 class="accordion-header" id="flush-heading-${status.index}">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#flush-collapse-${status.index}"
                  aria-expanded="false"
                  aria-controls="flush-collapse-${status.index}">
            [${dto.categoryName}] ${dto.subject}
          </button>
        </h2>
        <div id="flush-collapse-${status.index}" class="accordion-collapse collapse"
             aria-labelledby="flush-heading-${status.index}" data-bs-parent="#accordionFlush">
          <div class="accordion-body p-3">
            
            <div class="row border-bottom mb-2 pb-2">
              <div class="col">
                분류 : <label>${dto.categoryName}</label>				
              </div>
            </div>
            
            <div class="row border-bottom mb-2 pb-2">
              <div class="col">
                작성자 : <label class="text-light-emphasis">${dto.name} (${dto.memberId})</label>
              </div>
              <div class="col-auto">
                작성일 : <label class="text-light-emphasis">${dto.regDate}</label>
              </div>
            </div>

            <c:if test="${not empty dto.updateId}">
              <div class="row border-bottom mb-2 pb-2">
                <div class="col">
                  수정자 : <label class="text-light-emphasis">${dto.updateName} (${dto.updateId})</label>
                </div>
                <div class="col-auto">
                  수정일 : <label class="text-light-emphasis">${dto.regUpdate}</label>
                </div>
              </div>
            </c:if>

            <div class="row border-bottom mb-2 pb-2">
              <div class="col faq-content text-light-emphasis">${dto.content}</div>
            </div>

            <div class="row mt-2">
              <div class="col text-end">
                <button type="button" class="btn btn-sm btn-outline-primary"
                        onclick="updateFaq('${dto.faqId}', '${pageNo}');">수정</button>
                <button type="button" class="btn btn-sm btn-outline-danger"
                        onclick="deleteFaq('${dto.faqId}', '${pageNo}');">삭제</button>
              </div>
            </div>

          </div>
        </div>
      </div>		
    </c:forEach>
  </div>
</c:if>

<div class="page-navigation">
  ${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>
