<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
.reguide-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    padding-bottom: 1rem;
    margin-bottom: 2rem;
    border-bottom: 2px solid #315e4e;
}

.reguide-header h2 {
    margin: 0;
}

.reguide-subtitle {
    color: #555;
    font-size: 1rem;
}

.guide-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    transition: all 0.2s;
}
.guide-card:hover {
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
.guide-thumb {
    width: 100%;
    height: 200px;      
    object-fit: contain;  
    background-color: #f5f5f5;
}
.guide-body {
    padding: 10px;
}
.guide-title {
    font-weight: 600;
    font-size: 1rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.guide-meta {
    font-size: 0.85rem;
    color: #666;
}
.page-navigation {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

/* 페이징 */
.page-navigation {
   display: flex;
   justify-content: center;
   align-items: center;
   gap: 6px;
   flex-wrap: wrap;
}

.page-navigation a, .page-navigation strong, .page-navigation span {
   background: #fff;
   border-radius: 4px;
   padding: 3px 10px;
   color: #363636;
   font-weight: 500;
   text-decoration: none;
   cursor: pointer;
   transition: all 0.2s ease;
}

.page-navigation a:hover {
   background: #e0e0e0;
   border-color: #999;
}

.page-navigation .disabled {
   background: #f8f8f8;
   border-color: #ddd;
   color: #aaa;
   cursor: not-allowed;
}

.page-navigation strong, .page-navigation span {
   background: #ccc;
   border-color: #999;
   color: #333;
}

.search-form {
    background-color: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2.5rem;
    border: 1px solid #e9ecef;
}
</style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">
	<div class="reguide-header">
    	<h2 class="mb-4 fw-bold">분리배출 가이드</h2>
    	<span class="reguide-subtitle">환경을 지키는 첫걸음, 올바른 분리배출 정보 게시판입니다.</span>
	</div>
    <form name="searchForm" class="search-form row g-3 align-items-end mb-4" method="get">
        <div class="col-md-3">
            <label for="schType" class="form-label">검색 조건</label> 
            <select id="schType" name="schType" class="form-select">
                <option value="name" ${schType=="name"?"selected":""}>작성자</option>
                <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
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

    <div class="row g-3">
        <c:forEach var="dto" items="${list}">
            <div class="col-md-4">
                <div class="guide-card">
                    <a href="${articleUrl}&guidId=${dto.guidId}">
                        <c:choose>
                            <c:when test="${not empty dto.imageFilename}">
                                <img src="${pageContext.request.contextPath}/uploads/reguide/${dto.imageFilename}" class="guide-thumb" alt="${dto.subject}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/default_thumb.jpg" class="guide-thumb" alt="기본 이미지">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <div class="guide-body">
                        <div class="guide-title">
                            <a href="${articleUrl}&guidId=${dto.guidId}" class="text-reset">${dto.subject}</a>
                        </div>
                        <div class="guide-meta">
                            작성자: ${dto.name} | 작성일: ${dto.regDate} | 조회수: ${dto.hitCount}
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
 <div class="control-section">
    <div class="page-navigation">
        ${dataCount == 0 ? "" : paging}
    </div>
  </div>

    <div class="text-end mt-4">
    	<c:if test="${sessionScope.member.userLevel >= 51}">
        	<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/reguide/write';">글 작성</button>
    	</c:if>
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
    
    let url = '${pageContext.request.contextPath}/reguide/list';
    location.href = url + '?' + params;
}
</script>
</body>
</html>