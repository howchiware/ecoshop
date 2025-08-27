<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=sync" />
<style>
.card-magazine {
    display: flex;
    gap: 50px;
    padding: 20px;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    margin-bottom: 16px;
    background-color: #fff;
}
.card-magazine img {
    width: 540px;
    height: 200px;
    object-fit: cover;
    border-radius: 4px;
}
.card-magazine-body {
    flex: 1;
}
.card-magazine-title {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 15px;
}
.card-magazine-summary {
    font-size: 18px;
    color: #555;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3; 
    -webkit-box-orient: vertical;
}
.page-navigation {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
</style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">    
    <h2 class="mb-4 fw-bold">매거진</h2>
    
    <!-- 검색 폼 -->
    <form name="searchForm" class="search-form row g-3 align-items-end mb-4" method="get">
         <div class="col-md-3">
             <label for="schType" class="form-label">검색 조건</label> 
             <select id="schType" name="schType" class="form-select">
             <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
                 <option value="content" ${schType=="content"?"selected":""}>내용</option>
                 
             </select>
         </div>
         <div class="col-md-4">
             <label for="kwd" class="form-label">검색어</label> 
             <input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
         </div>
         <div class="col-auto">
             <button type="submit" class="btn btn-primary">조회</button>
         </div>
    </form>

    <!-- 매거진 카드 리스트 -->
    <c:forEach var="item" items="${magazineList}" varStatus="status">
        <c:url var="url" value="/magazine/article/${item.magazineId}">
            <c:param name="page" value="${page}" />
            <c:if test="${not empty kwd}">
                <c:param name="schType" value="${schType}" />
                <c:param name="kwd" value="${kwd}" />
            </c:if>
        </c:url>
        
        <div class="card-magazine">
            <!-- 썸네일 -->
            <div>
                <c:choose>
                    <c:when test="${not empty item.originalFilename}">
                        <img src="${pageContext.request.contextPath}/uploads/magazine/${item.originalFilename}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/dist/images/default_thumb.jpg" class="guide-thumb" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 내용 -->
            <div class="card-magazine-body">
                <div class="card-magazine-title">
                    <a style="text-decoration: none; color: black" href="${url}">${item.subject}</a>
                </div>
                <div class="card-magazine-summary">
                    ${fn:substring(item.content, 0, 150)}
                </div>
                <div class="text-muted small mt-5">
                    ${item.name} · ${item.regDate} · 조회수 ${item.hitCount} · 댓글 ${item.replyCount}
                </div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty magazineList}">
        <div class="text-center py-5">등록된 게시글이 없습니다.</div>
    </c:if>

    <!-- 글 작성 + 페이지 네비게이션 -->
    <div class="d-flex justify-content-between align-items-center mt-4">
    	<c:if test="${sessionScope.member.userLevel >= 51}">
        	<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/magazine/write';">글 작성</button>
        </c:if>
        <div class="page-navigation">
            ${dataCount == 0 ? "" : paging}
        </div>
    </div>
    
    <div class="col-auto">
       <a href="${pageContext.request.contextPath}/magazine/list">새로고침</a>
    </div>

</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
window.addEventListener('DOMContentLoaded', () => {
    const inputEL = document.querySelector('form input[name=kwd]'); 
    inputEL.addEventListener('keydown', function (evt) {
        if(evt.key === 'Enter') { 
            evt.preventDefault();
            searchList();
        }
    });
});

function searchList() {
    const f = document.searchForm;
    if(! f.kwd.value.trim()) {
        return;
    }
    
    const formData = new FormData(f);
    let params = new URLSearchParams(formData).toString();
    
    let url = '${pageContext.request.contextPath}/magazine/list';
    location.href = url + '?' + params;
}
</script>
</body>
</html>