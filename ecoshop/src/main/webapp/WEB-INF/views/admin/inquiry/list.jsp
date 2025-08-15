<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<table class="table table-hover">
    <thead>
        <tr>
            <th style="width: 12%;">문의 상태</th>
            <th style="width: 40%;">질문 제목</th>
            <th style="width: 15%;">작성자</th>
            <th style="width: 15%;">작성일</th>
            <th style="width: 18%;">작업</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${empty list}">
            <tr>
                <td colspan="5" class="text-center py-5">문의 내역이 없습니다.</td>
            </tr>
        </c:if>

        <c:forEach var="dto" items="${list}">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${dto.status == 1}">
                            <span class="status-badge answered">답변 완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge pending">답변 대기</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="subject-cell">${dto.subject}</td>
                <td>${dto.name} (${dto.memberId})</td>
                <td>${dto.regDate}</td>
                <td>
                    <c:choose>
				        <c:when test="${dto.status == 1}">
				            <button type="button" class="btn btn-sm btn-outline-secondary" 
				                    onclick="viewInquiry(${dto.inquiryId}, ${pageNo});">답변 확인</button>
				        </c:when>
				        
				        <c:otherwise>
				            <button type="button" class="btn btn-sm btn-primary" 
				                    onclick="viewInquiry(${dto.inquiryId}, ${pageNo});">답변하기</button>
				        </c:otherwise>
				    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div class="page-navigation">
  ${dataCount == 0 ? "" : paging}
</div>