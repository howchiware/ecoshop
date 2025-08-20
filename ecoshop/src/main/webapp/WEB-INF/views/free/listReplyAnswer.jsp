<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:forEach var="vo" items="${listReplyAnswer}">
	<div class="border-bottom m-1">
		<div class="row p-1">
			<div class="col-md-6">
				<div class="row reply-writer">
					<div class="col-lg-1">
						<img src="${pageContext.request.contextPath}/dist/images/person.png" class="avatar-icon">
					</div>
					<div class="col-auto ms-1 align-self-center">
						<div class="name">${vo.name}</div>
						<div class="date">${vo.reg_date}</div>
					</div>
				</div>
			</div>
			<div class="col align-self-center text-end">
				<div class="reply-dropdown">
					<span class="dropdown-button"><i class="bi bi-three-dots-vertical"></i></span>
					<div class="reply-menu d-none">
						<c:choose>
							<c:when test="${sessionScope.member.member_id == vo.member_id}">
								<div class="deleteReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">삭제</div>
								<div class="hideReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-showReply="${vo.showReply}">${vo.showReply == 1 ? "숨김":"표시"}</div>
							</c:when>
							<c:when test="${sessionScope.member.userLevel > 50}">
								<div class="deleteReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">삭제</div>
								<div class="blockReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">차단</div>
							</c:when>
							<c:otherwise>
								<div class="notifyReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}">신고</div>
								<div class="blockReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">차단</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		
		<div class="p-2" class="${vo.showReply==0?'text-primary text-opacity-50':''}">
			${vo.content}
		</div>
	</div>
</c:forEach>
