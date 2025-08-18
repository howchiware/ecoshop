<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<table class="table table-borderless board-list">
    <thead>
        <tr class="border-bottom">
            <th width="140">상품</th>
            <th>내용</th>
            <th width="100">평점</th>
            <th width="100">작성자</th>
            <th width="140">일시</th>
            <th width="140">상태</th>
            <th width="100">관리</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${not empty reviewList}">
            <c:forEach var="dto" items="${reviewList}">
                <tr class="border-bottom">
                    <td>${dto.productName}</td>
                    <td>${dto.content}</td>
                    <td>${dto.rate}</td>
                    <td>${dto.userName}</td>
                    <td><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${dto.status eq 1}">답변완료</c:when>
                            <c:otherwise>미답변</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${dto.status eq 1}">
                                <button type="button" class="small-btn">수정</button>
                                <button type="button" class="small-btn">삭제</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="small-btn">답변</button>
                                <button type="button" class="small-btn">삭제</button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty reviewList}">
            <tr>
                <td colspan="6" style="text-align: center;">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>