<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="reply-info">
	<span class="reply-count">댓글 ${replyCount}개</span>
</div>

<div class="reply-list mt-3">
	<c:if test="${empty listReply}">
		<div class="text-center py-5 text-muted">첫 댓글을 작성해보세요.</div>
	</c:if>
	
	<c:forEach var="vo" items="${listReply}">
		<div class="reply-item">
			<div class="reply-header">
				<div class="reply-writer">
					<img src="${pageContext.request.contextPath}/dist/images/person.png" class="avatar-icon">
					<div class="writer-info">
						<span class="name">${vo.nickname}</span>
						<span class="date d-block" style="font-size: 10px;">${vo.regDate}</span>
					</div>
				</div>
				
				<div class="reply-dropdown" style="position: relative;">
					<span class="dropdown-button" style="cursor: pointer;"><i class="bi bi-three-dots-vertical"></i></span>
					<div class="reply-menu d-none" style="position: absolute; top: 100%; right: 0; background: #fff; border: 1px solid #ddd; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); z-index: 10; font-size: 0.875rem; width: 80px; text-align: center;">
						<c:choose>
							<c:when test="${sessionScope.member.memberId == vo.memberId}">
								<div class="deleteReply reply-menu-item" data-replyId="${vo.replyId}" data-page-no="${pageNo}" style="padding: 0.5rem; cursor: pointer;">삭제</div>
							</c:when>
							<c:otherwise>
								<div class="notifyReply reply-menu-item" data-replyId="${vo.replyId}" style="padding: 0.5rem; cursor: pointer;">신고</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="reply-content">${vo.content}</div>
			
			<div class="reply-footer">
			    <button type="button" class="btnReplyAnswerLayout" data-reply-id="${vo.replyId}">
			        답글 <span class="answer-count" id="answerCount${vo.replyId}">${vo.answerCount}</span>
			    </button>
			</div>
		
			<div class="reply-answer ps-4 mt-3 d-none">
				<div id="listReplyAnswer${vo.replyId}" class="answer-list"></div>
				<div class="answer-form d-flex gap-2 mt-2">
					<textarea class="form-control form-control-sm" rows="1"></textarea>
					<button type="button" class="btn btn-sm btn-primary btnSendReplyAnswer" data-reply-id="${vo.replyId}">등록</button>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<div id="original-paging">
    ${paging}
</div>