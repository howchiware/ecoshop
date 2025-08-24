<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssReport/report.css">
<table class="table table-hover board-list">
	<thead>
		<tr>
			<th width="80">번호</th>
			<th>콘텐츠</th>
			<th width="80">글번호</th>
			<th width="90">신고자</th>
			<th width="180">신고사유</th>
			<th width="110">등록일</th>
			<th class="80">처리상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr> 
				<td>${dataCount - (pageNo-1) * size - status.index}</td>
				<td class="left">
					<c:url var="url" value="/admin/reportsManage/article/${dto.reportId}">
						<c:param name="page" value="${pageNo}"/>
						<c:if test="${reportsStatus != 0}">
							<c:param name="status" value="${reportsStatus}"/>
						</c:if>									
						<c:if test="${not empty kwd}">
							<c:param name="schType" value="${schType}"/>
							<c:param name="kwd" value="${kwd}"/>
						</c:if>									
					</c:url>
					<div class="text-wrap"><a href="${url}">${dto.contentTitle}</a></div>
				</td>
				<td>${dto.targetNum}</td>
				<td>${dto.reporterName}</td>
				<td>${dto.reasonCode}</td>
				<td>${dto.reportDate}</td>
				<td>${dto.reportStatus == 1 ? "신고접수" : (dto.reportStatus == 2 ? "처리완료" : "기각")}</td>
			</tr>
		</c:forEach>
	</tbody>					
</table>

<div class="page-navigation">
	${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>
		
