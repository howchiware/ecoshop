<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

h2.mb-4 {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 600;
	font-size: 1.8rem;
	color: #333;
	letter-spacing: -0.5px;
	position: relative;
	padding-left: 16px;
	margin-bottom: 2.0rem;
}

/* 작성자 이름 (h2 옆 작은 글씨) */
h2.mb-4 .author-name {
	font-size: 0.85rem;
	color: #555;
	font-weight: 600;
	position: absolute;
	right: 0;
	top: 50%;
	transform: translateY(-50%);
	white-space: nowrap;
}

.main-container {
	display: flex;
	padding: 20px;
	gap: 20px;
}

.content {
	flex: 1;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	max-width: 700px; /* 너비 제한 */
	margin: 0 auto; /* 가운데 정렬 */
}

form label {
	font-weight: 700;
	color: #315e4e;
}

form .form-control, form .form-select {
	border-radius: 6px;
	border: 1px solid #ddd;
	font-size: 0.9rem;
}

form .form-control:focus, form .form-select:focus {
	border-color: #315e4e;
	box-shadow: 0 0 0 0.15rem rgba(49, 94, 78, 0.25);
}

form .btn-primary {
	background-color: #315e4e;
	border: none;
	font-weight: 500;
	padding: 0.45rem 1rem;
	border-radius: 6px;
}

form .btn-primary:hover {
	background-color: #234d3c;
}

form button[type=button] {
	background-color: #e2e2e2;
	border: none;
	padding: 0.45rem 1rem;
	border-radius: 6px;
	font-weight: 500;
}

form button[type=button]:hover {
	background-color: #ccc;
}

/* 작성자 readonly input 스타일 - 테두리 제거, 진회색 글씨 */
form input[readonly] {
	border: none;
	background-color: transparent;
	color: #555;
	font-weight: 600;
	padding-left: 0;
	box-shadow: none;
	pointer-events: none;
}

form input#content, form input#commentary {
	font-size: 1rem; /* 기본 유지 */
	padding: 12px 12px; /* 패딩 크게 */
	height: 48px; /* 높이 명시 */
	font-weight: 500;
}

/* 퀴즈 제목과 정답을 같은 줄에 */
.row.title-answer {
	display: flex;
	gap: 20px;
	align-items: flex-start;
	margin-bottom: 1rem;
}

.title-answer>div {
	flex: 1;
}

.title-answer>div.answer-col {
	flex: 0 0 150px;
}

.btn-group-center {
	text-align: center;
	margin-top: 1.5rem;
}

.btn-group-center button {
	margin: 0 10px;
}
</style>

</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="content">
			<h2 class="mb-4">
				${mode == "update" ? "오늘의 퀴즈 수정" : "퀴즈 등록"} <small
					class="author-name">작성자: ${sessionScope.member.name}</small>
			</h2>

			<form name="quizForm" method="post">
				<div class="row title-answer">
					<div>
						<label for="subject" class="form-label">퀴즈 제목</label> <input
							class="form-control" type="text" id="subject" name="subject"
							value="${dto.subject}" autofocus>
					</div>
					<div class="answer-col">
						<label for="answer" class="form-label">정답</label> <select
							name="answer" class="form-select">
							<option value="1" ${dto.answer=="1"?"selected":"" }>O</option>
							<option value="0" ${dto.answer=="0"?"selected":"" }>X</option>
						</select>
					</div>
				</div>
				
				<div class="row mb-3">
					<div class="col-12">
						<label for="content" class="form-label">퀴즈 내용</label> <input
							class="form-control" type="text" id="content" name="content"
							value="${dto.content}">
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						<label for="commentary" class="form-label">퀴즈 해석</label> <input
							class="form-control" type="text" id="commentary"
							name="commentary" value="${dto.commentary}">
					</div>
				</div>

				<div class="row mb-4">
					<div class="col-md-6">
						<label for="openDate" class="form-label">개시일</label> <input
							class="form-control" type="date" id="openDate" name="openDate"
							value="${dto.openDate}">
					</div>
				</div>

				<div class="btn-group-center">
					<button type="button" name="sendButton"
						class="btn btn-primary btn-lg" onclick="quizOk();">
						${mode == "update" ? "퀴즈 수정" : "퀴즈 등록"} <i class="bi bi-check2"></i>
					</button>
					<button type="button" class="btn btn-secondary btn-lg"
						onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list';">
						${mode == "update" ? "수정 취소" : "등록 취소"} <i class="bi bi-x"></i>
					</button>
					<input type="hidden" name="name"
						value="${sessionScope.member.name}">
					<c:if test="${mode=='update'}">
						<input type="hidden" name="quizId" value="${dto.quizId}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</div>
			</form>
		</div>
	</main>

	<script type="text/javascript">
function isValidDateString(dateString) {
    try {
        const date = new Date(dateString);
        const [year, month, day] = dateString.split("-").map(Number);
        return date instanceof Date && !isNaN(date) && date.getDate() === day;
    } catch(e) {
        return false;
    }
}

function quizOk() {
    const f = document.quizForm;
    let str;

    str = f.subject.value;
    if (!str) { 
        alert('퀴즈 제목을 입력하세요.');
        f.subject.focus();
        return;
    }

    str = f.content.value;
    if (!str) { 
        alert('퀴즈 내용을 입력하세요.');
        f.content.focus();
        return;
    }
    
    str = f.answer.value;
    if (!str) { 
        alert('정답을 선택하세요.');
        f.answer.focus();
        return;
    }

    str = f.openDate.value;
    if (!isValidDateString(str)) {
        alert('개시일을 선택하세요.');
        f.openDate.focus();
        return;
    }
    
    f.action = '${pageContext.request.contextPath}/admin/quiz/${mode}';
    f.submit();
} 
</script>

</body>
</html>
