<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

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
                <button type="button" class="my-btn btn btn-sm"
                        onclick="updateFaq('${dto.faqId}', '${pageNo}');">수정</button>
                <button type="button" class="my-btn btn btn-sm"
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
