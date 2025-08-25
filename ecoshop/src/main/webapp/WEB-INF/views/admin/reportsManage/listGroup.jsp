<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssReport/report.css">						
<table class="table table-hover board-list">
	<thead>
		<tr>
			<th width="80">번호</th>
			<th>콘텐츠</th>
			<th width="100">게시물번호</th>
			<th width="120">분류</th>
			<th width="200">테이블명</th>
			<th width="90">신고건수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr> 
				<td>${dataCount - (pageNo-1) * size - status.index}</td>
				<td class="left">
					${dto.contentTitle}
				</td>
				<td>${dto.targetNum}</td>
				<td>${dto.contentType}</td>
				<td>${dto.target}</td>
				<td>${dto.reportsCount}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-navigation">
	${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>
