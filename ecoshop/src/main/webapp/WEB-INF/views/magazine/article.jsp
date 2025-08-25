<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container my-5">
		<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp" />

		<div class="card mt-4 article-card">
			<div class="card-header">
				<h3>${dto.subject}</h3>
				<div class="d-flex justify-content-between text-muted small">
					<span><strong>작성자:</strong> ${dto.nickname}</span> 
					<span><strong>작성일:</strong>${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
				</div>
			</div>
			<div class="card-body">
				<p>${dto.content}</p>
			</div>

			<div class="btn-like-wrapper">
				<button type="button" class="btnSendFreeLike" title="좋아요">
					<i class="bi ${isUserLiked ? 'bi-heart-fill text-danger' : 'bi-heart' }"></i>
					<span id="freeLikeCount">${dto.freeLikeCount}</span>
				</button>
			</div>

		</div>

		<div class="post-navigation">
			<div class="nav-item">
				<span class="fw-bold">이전글 :</span>
				<c:if test="${not empty prevDto}">
					<a href="${pageContext.request.contextPath}/free/article/${prevDto.freeId}?${query}">${prevDto.subject}</a>
				</c:if>
				<c:if test="${empty prevDto}">
					<span>이전글이 없습니다.</span>
				</c:if>
			</div>
			<div class="nav-item">
				<span class="fw-bold">다음글 :</span>
				<c:if test="${not empty nextDto}">
					<a href="${pageContext.request.contextPath}/free/article/${nextDto.freeId}?${query}">${nextDto.subject}</a>
				</c:if>
				<c:if test="${empty nextDto}">
					<span>다음글이 없습니다.</span>
				</c:if>
			</div>
		</div>

		<div class="article-actions">
		    <div class="actions-left">
		        <c:choose>
		            <c:when test="${sessionScope.member.memberId==dto.memberId}">
		                <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/free/update?freeId=${dto.freeId}&${query}';">수정</button>
		            </c:when>
		            <c:otherwise>
		                <button type="button" class="btn-default btnPostsReport" data-freeid="${dto.freeId}">신고</button>
		            </c:otherwise>
		        </c:choose>
		        <c:choose>
		            <c:when test="${sessionScope.member.memberId==dto.memberId || sessionScope.member.userLevel>50}">
		                <button type="button" class="btn-default" onclick="deleteOk();">삭제</button>
		            </c:when>
		            <c:otherwise>
		                <button type="button" class="btn-default" disabled>차단</button>
		            </c:otherwise>
		        </c:choose>
		    </div>
		
		    <div class="actions-right">
		        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/free/dairyList?${query}';">목록</button>
		    </div>
		</div>


		<div class="reply-session mt-5">
			<div class="reply-form-card">
				<div class="reply-form-header">
					<h5 class="form-title">댓글</h5>
					<p class="form-guide">건전한 소통 문화를 함께 만들어주세요.</p>
				</div>
				<div class="reply-form-body">
					<textarea class="form-control" name="content" rows="4"
						placeholder="댓글을 입력하세요"></textarea>
					<div class="text-end mt-2">
						<button type="button" class="btn btn-primary btn-sm btnSendReply">댓글 등록</button>
					</div>
				</div>
			</div>

			<div id="listReply" class="mt-4" data-target="freeReply" data-freeid="${dto.freeId}"></div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/posts/report.jsp"/>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = "${pageContext.request.contextPath}";
		const FREE_ID = "${dto.freeId}";
		const QUERY_STRING = "${query}";
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsFree/dairyArticle.js"></script>
</body>
</html>