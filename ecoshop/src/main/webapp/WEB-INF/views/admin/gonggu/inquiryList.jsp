<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="outside review-manage">
	<div class="row select-two"></div>
	<table class="table table-borderless board-list">
		<thead>
			<tr class="border-bottom">
				<th width="140">상품</th>
				<th>내용</th>
				<th width="100">작성자</th>
				<th width="140">일시</th>
				<th width="140">상태</th>
				<th width="100">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty list}">
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.gongguProductName}</td>
						<td>${dto.content}</td>
						<td>${dto.rate}</td>
						<td>${dto.name}</td>
						<td><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd" /></td>
						<td>
							<button type="button" class="btn btn-primary">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>

			<c:if test="${empty list}">
				<tr>
					<td colspan="6" style="text-align: center;">등록된 내용이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>