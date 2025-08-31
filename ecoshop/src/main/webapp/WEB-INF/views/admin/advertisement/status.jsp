<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>

.form-search {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 15px;
}
.form-search select,
.form-search input {
    height: 36px;
    font-size: 14px;
}

.form-search .btn-default {
    padding: 6px 12px;
    border-radius: 4px;
    transition: background 0.2s;
}
.form-search .btn-default:hover {
    background-color: #5a6268;
    border: 1px gray;
    border-radius: 4px;
    padding: 6px 12px;
}

.table {
    border-collapse: collapse;
    width: 100%;
}
.table th, .table td {
    vertical-align: middle;
    text-align: center;
    padding: 10px;
    border: 1px solid #dee2e6;
}
.table thead th {
    font-weight: 600;
    color: #495057;
    background-color: transparent; 
}
.table-hover tbody tr:hover {
    background-color: #f8f9fa; 
}

.badge-status {
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 12px;
    color: #495057;
    background-color: #e9ecef;
}
.status-main { background-color: #dbe5ff; }
.status-page { background-color: #cff4fc; }
.posting-open { background-color: #d1e7dd; }
.posting-close { background-color: #e2e3e5; }



</style>

<div class="form-search input-group mb-3" style="max-width: 600px;">
    <select id="searchTypeStatus" name="schTypeStatus" class="form-select" style="flex: 0 0 120px;">
        <option value="advertisingId" ${schTypeStatus=='advertisingId' ? 'selected':''}>광고 번호</option>
        <option value="changeDate" ${schTypeStatus=='changeDate' ? 'selected':''}>변경 날짜</option>
    </select>

    <input type="text" id="keywordStatus" name="kwdStatus" value="${kwdStatus}" class="form-control" placeholder="검색어 입력">
	<button type="button" class="btn-default" onclick="searchStatusList()"> 
            <i class="bi bi-search"></i> 
    </button>

    <button type="button" class="btn btn-outline-secondary" onclick="resetStatusSearch()">새로고침</button>
</div>

<table class="table table-bordered table-hover table-sm">
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
                <c:when test="${row.oldStatus == 1}"><span class="badge-status status-main">메인</span></c:when>
                <c:when test="${row.oldStatus == 2}"><span class="badge-status status-page">개인페이지</span></c:when>
                <c:otherwise>${row.oldStatus}</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${row.newStatus == 1}"><span class="badge-status status-main">메인</span></c:when>
                <c:when test="${row.newStatus == 2}"><span class="badge-status status-page">개인페이지</span></c:when>
                <c:otherwise>${row.newStatus}</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${row.oldPosting == 0}"><span class="badge-status posting-open">공개</span></c:when>
                <c:when test="${row.oldPosting == 1}"><span class="badge-status posting-close">비공개</span></c:when>
                <c:otherwise>${row.oldPosting}</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${row.newPosting == 0}"><span class="badge-status posting-open">공개</span></c:when>
                <c:when test="${row.newPosting == 1}"><span class="badge-status posting-close">비공개</span></c:when>
                <c:otherwise>${row.newPosting}</c:otherwise>
            </c:choose>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty listStatus}">
      <tr><td colspan="7" class="text-center text-muted">이력이 없습니다.</td></tr>
    </c:if>
  </tbody>
</table>
<div style="padding-top: 10px;" class="page-navigation">${statusdataCount == 0 ? "등록된 자료가 없습니다." : paging}</div>