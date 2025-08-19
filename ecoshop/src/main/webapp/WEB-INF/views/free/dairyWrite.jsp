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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/free.css" type="text/css">
<style>

</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>
	
	<div>
		<div>
			<span>${mode=='update'?'일상이야기 수정':'일상이야기 작성'}</span>
		</div>
	
		<form action="dairyForm" action="" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject" placeholder="제목을 입력해주세요." value="#{dto.subject}">
					</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>
						<input type="text" name="content" placeholder="내용을 입력해주세요.\n 부적절한 내용 작성하면 임의로 차단됩니다." value="#{dto.content}">
					</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>
						<input type="text" name="content" placeholder="내용을 입력해주세요.\n 부적절한 내용 작성하면 임의로 차단됩니다." value="#{dto.content}">
					</td>
				</tr>
				
				<tr>
					<td>파일</td>
					<td>
						<input type="file" name="selectFile" multiple="multiple">
					</td>
				</tr>
				
			</table>
		</form>
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
</script>
</body>
</html>