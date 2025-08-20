<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE - 일상이야기</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
<style>
    .card-header h3 { font-weight: 700; }
    .card-body img { max-width: 100%; border-radius: 8px; margin-bottom: 1rem; }
    .card-body p { white-space: pre-wrap; line-height: 1.8; }
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>
	
	<div class="card mt-4 article-card">
        <div class="card-header">
            <h3>${dto.subject}</h3>
            <div class="d-flex justify-content-between text-muted small">
                <span><strong>작성자:</strong> ${dto.nickname}</span>
                <span><strong>작성일:</strong> ${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
            </div>
        </div>
        <div class="card-body">
            <p>${dto.content}</p>
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
    
    <div class="row button-group">
        <div class="col-md-6">
            <c:if test="${sessionScope.member.memberId == dto.memberId}">
                <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/free/update?freeId=${dto.freeId}&${query}';">수정</button>
                <button type="button" class="btn btn-outline-danger" onclick="deleteOk();">삭제</button>
            </c:if>
        </div>
        <div class="col-md-6 text-end">
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/free/dairyList?${query}';">목록</button>
        </div>
    </div>
    
    <div class="reply-session">
		<div class="reply-form">
			<div class="form-header">
				<span class="small-title">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
			</div>
			
			<div class="mb-2">
				<textarea class="form-control" name="content"></textarea>
			</div>
			<div class="text-end">
				<button type="button" class="btn-default btn-md btnSendReply">댓글 등록</button>
			</div>
		</div>
		<div id="listReply"></div>
	</div>
    
</main>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

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