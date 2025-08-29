<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="form-search">
    <select id="searchTypeStatus" name="schTypeStatus">
        <option value="advertisingId" ${schTypeStatus=='advertisingId' ? 'selected':''}>광고 번호</option>
        <option value="changeDate" ${schTypeStatus=='changeDate' ? 'selected':''}>변경 날짜</option>
    </select>
    <input type="text" id="keywordStatus" name="kwdStatus" value="${kwdStatus}">
    <button type="button" class="btn-default" onclick="searchStatusList()">검색</button>
    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="resetStatusSearch()">새로고침</button>
</div>

<table class="table table-bordered table-sm">
  <thead>
    <tr>
      <th>로그ID</th>
      <th>광고ID</th>
      <th>변경일</th>
      <th>이전 상태</th>
      <th>변경 상태</th>
      <th>이전 게시</th>
      <th>변경 게시</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="row" items="${listStatus}">
      <tr>
        <td>${row.statuslogId}</td>
        <td>${row.advertisingId}</td>
        <td>${row.changeDate}</td>
         <td>
        <c:choose>
            <c:when test="${row.oldStatus == 1}">메인</c:when>
            <c:when test="${row.oldStatus == 2}">개인페이지</c:when>
            <c:otherwise>${row.oldStatus}</c:otherwise>
        </c:choose>
    </td>
    <td>
        <c:choose>
            <c:when test="${row.newStatus == 1}">메인</c:when>
            <c:when test="${row.newStatus == 2}">개인페이지</c:when>
            <c:otherwise>${row.newStatus}</c:otherwise>
        </c:choose>
    </td>
         <td>
        <c:choose>
            <c:when test="${row.oldPosting == 1}">비공개</c:when>
            <c:when test="${row.oldPosting == 0}">공개</c:when>
            <c:otherwise>${row.oldPosting}</c:otherwise>
        </c:choose>
    </td>
    <td>
        <c:choose>
            <c:when test="${row.newPosting == 1}">비공개</c:when>
            <c:when test="${row.newPosting == 0}">공개</c:when>
            <c:otherwise>${row.newPosting}</c:otherwise>
        </c:choose>
    </td>
      </tr>
    </c:forEach>
    <c:if test="${empty listStatus}">
      <tr><td colspan="6" class="text-center">이력이 없습니다.</td></tr>
    </c:if>
  </tbody>
</table>

    <div class="page-navigation">
      ${statusdataCount == 0 ? "등록된 자료가 없습니다." : paging}
    </div>

	<div class="row board-list-footer">
	</div>