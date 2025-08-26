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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyList.css" type="text/css">
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
	<h2 class="mb-4 fw-bold">매거진</h2>
	<form name="searchForm" class="search-form row g-3 align-items-end" method="get">
         <div class="col-md-3">
             <label for="schType" class="form-label">검색 조건</label> 
             <select id="schType" name="schType" class="form-select">
                 <option value="nickname" ${schType=="name"?"selected":""}>작성자</option>
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
	
	<table class="table table-hover">
		<thead>
			<tr class="text-center">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${magazineList}" varStatus="status">
				<tr class="text-center">
                    <td>${dataCount - (page-1) * size - status.index}</td>
					<td class="text-start">
						<c:url var="url" value="/magazine/article/${item.magazineId}">
							<c:param name="page" value="${page}" />
							<c:if test="${not empty kwd}">
								<c:param name="schType" value="${schType}" />
								<c:param name="kwd" value="${kwd}" />
							</c:if>
						</c:url>
						<div class="text-wrap">
							<a href="${url}">${item.subject}</a>
						</div>
					</td>
					<td>${item.name}</td>
                    <td>${item.regDate}</td>
                    <td>${item.hitCount}</td>
                </tr>
			</c:forEach>
			
			<c:if test="${empty magazineList}">
                <tr>
                    <td colspan="6" class="text-center py-5">등록된 게시글이 없습니다.</td>
                </tr>
            </c:if>
		</tbody>
	</table>
	
	<div class="table-bottom-controls">
         <div class="align-self-center">
             <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/magazine/write';">글 작성</button>
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