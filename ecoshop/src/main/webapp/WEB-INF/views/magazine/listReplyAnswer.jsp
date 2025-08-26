<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:forEach var="vo" items="${listReplyAnswer}">
	<div class="reply-card answer-card">
		<div class="reply-header">
			<div class="reply-writer">
				<img src="${pageContext.request.contextPath}/dist/images/person.png" class="avatar-icon">
				<div class="writer-info">
					<span class="name">${vo.name}</span>
					<span class="date">${vo.regDate}</span>
				</div>
			</div>
			<div class="reply-dropdown">
				<span class="dropdown-button"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu d-none">
					<c:choose>
						<c:when test="${sessionScope.member.memberId == vo.memberId}">
							<div class="deleteReplyAnswer reply-menu-item" data-replyId="${vo.magazineReplyNum}" data-parentNum="${vo.parentNum}">삭제</div>
						</c:when>
						<c:otherwise>
							<div class="notifyReplyAnswer reply-menu-item" data-replyId="${vo.magazineReplyNum}">신고</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<div class="reply-content">  ${vo.content}</div>
	</div>
</c:forEach>