<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE - 공지사항</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
<style>
    .card-header h3 { font-weight: 700; }
    .card-body p { white-space: pre-wrap; line-height: 1.8; }
    .post-navigation { margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #ddd; }
    .post-navigation .nav-item { margin-bottom: 0.5rem; }
    .btn-default { background-color: #315e4e; color: #fff; border-radius: 8px; border: none; padding: 8px 20px; }
    .btn-default:hover { background-color: #26463a; }
    .list-group-item {
    border-radius: 6px;
    margin-bottom: 6px;
    transition: background-color 0.2s;
	}
	
	.list-group-item:hover {
	    background-color: #f1f8f4;
	    color: #333;
	}
	
	.list-group-item i {
	    color: #315e4e;
	}
	
	.list-group-item .badge {
	    font-size: 0.8rem;
	    font-weight: 500;
	}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	<div class="card mt-4 article-card">
        <div class="card-header">
            <h3>${dto.subject}</h3>
            <div class="d-flex justify-content-between text-muted small">
                <span><strong>작성자:</strong> ${dto.name}</span>
                <span><strong>작성일:</strong> ${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
            </div>
        </div>
        <div class="card-body">
		    <c:out value="${dto.content}" escapeXml="false"/>
		</div>

        <!-- 첨부파일 -->
	    <c:if test="${listFile.size() != 0}">
        <div class="article-attachment card-body border-top mt-3">
            <p class="fw-bold mb-1"><i class="bi bi-folder2-open me-2"></i>첨부파일</p>
            <div class="list-group">
                <c:forEach var="vo" items="${listFile}">
                    <a href="${pageContext.request.contextPath}/notice/download/${vo.noticefileId}" 
                       class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                       style="border:1px solid #e9ecef; border-radius:8px; padding:0.75rem 1rem; margin-bottom:0.5rem; background-color:#ffffff; transition: all 0.2s;">
                        <span><i class="bi bi-file-earmark-text me-1" style="color:#315e4e;"></i>${vo.originalFilename}</span>
                        <span class="badge bg-secondary rounded-pill" style="font-size:0.8rem; font-weight:500;">
                            <fmt:formatNumber value="${vo.fileSize}" type="number"/> byte
                        </span>
                    </a>
                </c:forEach>
            </div>
        </div>
    </c:if>
    </div>

    <!-- 이전글 / 다음글 -->
    <div class="post-navigation">
        <div class="nav-item">
            <span class="fw-bold">이전글 :</span>
            <c:if test="${not empty prevDto}">
                <a href="${pageContext.request.contextPath}/notice/article/${prevDto.noticeId}?${query}">${prevDto.subject}</a>
            </c:if>
            <c:if test="${empty prevDto}">
                <span>이전글이 없습니다.</span>
            </c:if>
        </div>
        <div class="nav-item">
            <span class="fw-bold">다음글 :</span>
            <c:if test="${not empty nextDto}">
                <a href="${pageContext.request.contextPath}/notice/article/${nextDto.noticeId}?${query}">${nextDto.subject}</a>
            </c:if>
            <c:if test="${empty nextDto}">
                <span>다음글이 없습니다.</span>
            </c:if>
        </div>
    </div>
    
    <!-- 버튼 -->
    <div class="row mt-4">
        <div class="col-md-6">
            <c:if test="${sessionScope.member.memberId == dto.memberId || sessionScope.member.userLevel > 50}">
                <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/notice/update?noticeId=${dto.noticeId}&${query}';">수정</button>
                <button type="button" class="btn btn-outline-danger" onclick="deleteOk();">삭제</button>
            </c:if>
        </div>
        <div class="col-md-6 text-end">
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/notice/list?${query}';">목록</button>
        </div>
    </div>
</main>

<c:if test="${sessionScope.member.memberId==dto.memberId || sessionScope.member.userLevel>50}">
<script type="text/javascript">
function deleteOk() {
    if(confirm('공지사항을 삭제하시겠습니까?')) {
        let params = 'noticeId=${dto.noticeId}&${query}';
        let url = '${pageContext.request.contextPath}/notice/delete?' + params;
        location.href = url;
    }
}
</script>
</c:if>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>