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
<style>
    .card-header h3 { font-weight: 700; }
    .card-body img { max-width: 50%; border-radius: 8px; margin-bottom: 1rem; }
    .card-body p { white-space: pre-wrap; line-height: 1.8; }
	.post-image {
    width: 50%;      
    height: auto;   
    border-radius: 8px;
    margin-bottom: 1rem;
    display: block;
}
}
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
                <span><strong>작성자:</strong> ${dto.name} | <strong>분류:</strong> ${dto.categoryName}</span>
                <span><strong>작성일:</strong> ${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
            </div>
        </div>
     	 <div class="card-body">
		    <c:if test="${not empty dto.imageFilename}">
		        <img src="${pageContext.request.contextPath}/uploads/reguide/${dto.imageFilename}" 
		             alt="첨부 이미지" class="post-image">
		    </c:if>
		    <c:out value="${dto.content}" escapeXml="false"/>
		</div>
    </div>

    <div class="post-navigation">
        <div class="nav-item">
            <span class="fw-bold">이전글 :</span>
            <c:if test="${not empty prevDto}">
			   <a href="${pageContext.request.contextPath}/reguide/article?guidId=${prevDto.guidId}&${query}">${prevDto.subject}</a>
			</c:if>
            <c:if test="${empty prevDto}">
                <span>이전글이 없습니다.</span>
            </c:if>
        </div>
        <div class="nav-item">
            <span class="fw-bold">다음글 :</span>
           <c:if test="${not empty nextDto}">
           		<a href="${pageContext.request.contextPath}/reguide/article?guidId=${nextDto.guidId}&${query}">${nextDto.subject}</a>
			</c:if>
            <c:if test="${empty nextDto}">
                <span>다음글이 없습니다.</span>
            </c:if>
        </div>
    </div>
    
    <div class="row button-group">
        <div class="col-md-6">
            <c:if test="${sessionScope.member.memberId == dto.memberId}">
                <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/reguide/update?guidId=${dto.guidId}&${query}';">수정</button>
                <button type="button" class="btn btn-outline-danger" onclick="deleteOk();">삭제</button>
            </c:if>
        </div>
        <div class="col-md-6 text-end">
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/reguide/list?${query}';">목록</button>
        </div>
    </div>
    
   
    
</main>
<c:if test="${sessionScope.member.memberId==dto.memberId||sessionScope.member.userLevel>50}">
	<script type="text/javascript">
		function deleteOk() {
		    if(confirm('게시글을 삭제 하시 겠습니까 ? ')) {
			    let params = 'guidId=${dto.guidId}&${query}';
			    let url = '${pageContext.request.contextPath}/reguide/delete?' + params;
		    	location.href = url;
		    }
		}
	</script>
</c:if>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
</script>
<!--<script src="${pageContext.request.contextPath}/dist/jsFree/dairyArticle.js"></script>  -->
</body>
</html>