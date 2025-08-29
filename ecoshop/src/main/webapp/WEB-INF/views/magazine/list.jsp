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
.magazine-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    padding-bottom: 1rem;
    margin-bottom: 2rem;
    border-bottom: 2px solid #315e4e;
}

.magazine-header h2 {
    margin: 0;
}

.magazine-subtitle {
    color: #555;
    font-size: 1rem;
}

.card-magazine {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1rem;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    margin-bottom: 1rem;
    background-color: #fff;
}

.card-magazine img {
    width: 100%;
    height: auto;
    aspect-ratio: 16 / 9;
    object-fit: cover;
    border-radius: 4px;
}

.card-magazine-body {
    flex: 1;
}

.card-magazine-title {
    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 0.75rem;
}

.card-magazine-summary {
    font-size: 1rem;
    color: #555;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
}

.card-magazine .text-muted {
    font-size: 0.875rem;
    margin-top: 1.5rem;
}

.search-form {
    flex-direction: column;
    gap: 0.5rem;
}
.search-form .col-md-3,
.search-form .col-md-4,
.search-form .col-auto {
    width: 100%;
}

@media (min-width: 768px) {
    .magazine-header {
        align-items: baseline;
    }
    
    .card-magazine {
        flex-direction: row;
        gap: 2rem;
        padding: 1.25rem;
    }
    
    .card-magazine img {
        width: 350px;
        height: 100%;
    }

    .card-magazine-title {
        font-size: 1.75rem;
        margin-bottom: 1rem;
    }

    .card-magazine-summary {
        font-size: 1.125rem;
    }
    
    .search-form {
        flex-direction: row;
    }
    .search-form .col-md-3 {
        width: 25%;
    }
    .search-form .col-md-4 {
        width: 33.33%;
    }
    .search-form .col-auto {
        width: auto;
    }
}
.search-form {
    background-color: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2.5rem;
    border: 1px solid #e9ecef;
}
.page-navigation .pagination .page-link {
    color: #555;
    border-radius: 6px;
    margin: 0 3px;
    border: 1px solid #dee2e6;
    transition: all 0.2s ease;
}

.page-navigation .pagination .page-link:hover {
    background-color: #e9ecef;
    color: #315e4e;
}

.page-navigation .pagination .page-item.active .page-link {
    background-color: #315e4e;
    border-color: #315e4e;
    color: #fff;
    box-shadow: 0 2px 5px rgba(49, 94, 78, 0.3);
}

.paginate {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin-top: 2.5rem;
    margin-bottom: 2.5rem;
    gap: 4px;
    font-size: 0.9rem;
}

.paginate a,
.paginate span {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 36px;
    height: 36px;
    border: 1px solid #d2e4d9;
    border-radius: 40%;
    background-color: #ffffff;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
}

.paginate a:hover {
    background-color: #f1f8f3;
    border-color: #28a745;
    color: #28a745;
}

.paginate span {
    background-color: #28a745;
    border-color: #28a745;
    color: #ffffff;
    font-weight: bold;
    cursor: default;
}
.bottom-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 2.5rem;
}

.control-section {
    flex: 1;
}

.control-section:nth-child(2) {
    display: flex;
    justify-content: center;
}

.control-section:nth-child(3) {
    text-align: right;
}

.btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #5a6268;
    border-color: #545b62;
}
</style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="container my-5">   
	<div class="magazine-header">
	    <h2 class="fw-bold">에코모아 매거진</h2>
	    <span class="magazine-subtitle">주간 에코모아 매거진! 놓치지 말고 확인하세요!</span>
    </div>
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
                        <img src="${pageContext.request.contextPath}/dist/images/noimage.png" class="guide-thumb" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 내용 -->
            <div class="card-magazine-body">
                <div class="card-magazine-title">
                    <a style="text-decoration: none; color: black" href="${url}">${item.subject}</a>
                </div>
                <div class="card-magazine-summary">
				    ${fn:substring(item.content.replaceAll('<img[^>]*>', ''), 0, 150)}
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

    <div class="bottom-controls">
        <div class="control-section">
            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/magazine/list';">새로고침</button>
        </div>

        <div class="control-section">
            <div class="page-navigation">
                ${dataCount == 0 ? "" : paging}
            </div>
        </div>

        <div class="control-section">
            <c:if test="${sessionScope.member.userLevel >= 51}">
                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/magazine/write';">매거진 작성</button>
            </c:if>
        </div>
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