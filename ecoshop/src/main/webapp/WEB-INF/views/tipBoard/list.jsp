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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
<style>
.new-text {
    display: inline-block;
    margin-left: 6px;
    padding: 2px 6px;
    font-size: 0.75rem;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(135deg, #315e4e, #4b8071);
    border-radius: 12px;
    animation: blink 1.5s infinite;
}
.page-navigation {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    margin-top: 20px;
}

.page-navigation ul.pagination {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
}

.page-navigation ul.pagination li {
    margin: 0 4px; /* 페이지 간 간격 */
}

.page-navigation ul.pagination li a {
    display: block;
    padding: 6px 12px;
    text-decoration: none;
    color: #495057;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    transition: all 0.2s;
}

.page-navigation ul.pagination li a:hover {
    background-color: #0d6efd;
    color: #fff;
    border-color: #0d6efd;
}

.page-navigation ul.pagination li.active a {
    background-color: #0d6efd;
    color: #fff;
    border-color: #0d6efd;
    font-weight: 600;
}

.page-navigation ul.pagination li.disabled a {
    color: #6c757d;
    pointer-events: none;
    background-color: #fff;
    border-color: #dee2e6;
}

@keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.6; }
}	
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	<h2 class="mb-4 fw-bold">제로웨이스트 팁</h2>
	
	<form name="searchForm" class="search-form row g-3 align-items-end" method="get">
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
	
	<table class="table table-hover align-middle">
		<thead class="table-light text-center">
			<tr>
				<th style="width: 80px;">번호</th>
                <th>제목</th>
                <th style="width: 120px;">작성자</th>
                <th style="width: 120px;">작성일</th>
                <th style="width: 80px;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}" varStatus="status">
				<tr>
					<td class="text-center">${dataCount - (page-1) * size - status.index}</td>
					<td class="left" style="padding-left: 30px;">
						<c:forEach var="n" begin="1" end="${dto.depth}">&nbsp;&nbsp;</c:forEach>
						<c:if test="${dto.depth!=0}">└&nbsp;</c:if>
						<a href="${articleUrl}&tipId=${dto.tipId}" class="text-reset">${dto.subject}</a>
						<!--  
						<c:if test="${dto.gap < 1}">
							<span class="new-text">New</span>
						</c:if>
						-->
					</td>
					<td class="text-center">${dto.name}</td>
					<td class="text-center">${dto.regDate}</td>
					<td class="text-center">${dto.hitCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="table-bottom-controls">
         <div class="align-self-center">
             <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/tipBoard/write';">글 작성</button>
         </div>
         <div class="page-navigation">
             ${dataCount == 0 ? "" : paging}
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

function changeList() {
	const f = document.boardListForm;
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/tipBoard/list';
	location.href = url + '?' + params;
}

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/tipBoard/list';
	location.href = url + '?' + params;
}
</script>
</body>
</html>