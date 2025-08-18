<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>광고 문의</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<style>
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	color: #333;
	margin: 0;
}
    h2 {
        font-size: 20px;
        margin-bottom: 10px;
    }
    .desc {
        margin-bottom: 30px;
        color: #666;
    }
    form {
        width: 100%;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th {
        text-align: left;
        width: 150px;
        padding: 10px;
        vertical-align: top;
    }
    td {
        padding: 10px;
    }
    input[type=text],
    input[type=file],
    select,
    textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }
    textarea {
        height: 150px;
        resize: none;
    }
    .required {
        color: red;
    }
    .btn-box {
        text-align: center;
        margin-top: 30px;
    }
    .btn-md {
        padding: 10px 20px;
        border-radius: 5px;
        border: 1px solid #aaa;
        cursor: pointer;
        margin: 0 5px;
    }
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	<main class="main-container">
		<div class="container my-5">
		        <h2 class="mb-3"><i class="bi bi-clipboard-check"></i> 광고 신청</h2>
		        <p class="text-muted mb-4">
		            마이페이지 광고 신청에 대한 설명과 신청한 내용은 관리자에게 전달됩니다.
		        </p>
		
		        <form action="" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
		            <div class="mb-3">
		                <label class="form-label">문의유형</label>
		                <select name="adType" class="form-select">
		                    <option value="main">메인페이지 광고</option>
		                    <option value="mypage">마이페이지 광고</option>
		                </select>
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">이름 <span class="text-danger">*</span></label>
		                <input type="text" name="username" class="form-control" required>
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">전화번호 <span class="text-danger">*</span></label>
		                <div class="d-flex gap-2">
		                    <input type="text" name="tel" class="form-control">
		                </div>
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">이메일 <span class="text-danger">*</span></label>
		                <div class="d-flex gap-2">
		                    <input type="text" name="email1" class="form-control">
		                    <span class="align-self-center">@</span>
		                    <input type="text" name="email2" class="form-control">
		                </div>
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">제목</label>
		                <input type="text" name="subject" class="form-control">
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">내용</label>
		                <textarea name="content" class="form-control" rows="5"></textarea>
		            </div>
		
		            <div class="mb-3">
		                <label class="form-label">첨부파일</label>
		                <input type="file" name="upload" class="form-control">
		            </div>
		
		            <div class="text-center">
		                <button type="reset" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/advertisement/list';">취소하기</button>
		                <button type="submit" class="btn-accent btn-md" onclick="sendOk()">신청하기</button>
		            </div>
		        </form>
		    </div>
		</main>
		
		<script type="text/javascript">

function sendOk() {
    const f = document.noticeForm;
    
    if (!f.subject.value.trim()) {
        alert("제목을 입력하세요.");
        f.subject.focus();
        return;
    }


    f.action = '${pageContext.request.contextPath}/admin/notice/write';
    f.submit();
}
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		
</body>
</html>


