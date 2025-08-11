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
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
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

h2.mb-4::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 6px;
    height: 80%;
    background: linear-gradient(180deg, #4CAF50, #81C784);
    border-radius: 3px;
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
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

form label {
  font-weight: 700;
  color: #315e4e;
}

form .form-control,
form .form-select {
  border-radius: 6px;
  border: 1px solid #ddd;
  font-size: 0.9rem;
}

form .form-control:focus,
form .form-select:focus {
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

.table-wrapper {
    max-width: 90%;
    margin: 0 auto;
}

.table {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 12px;
    overflow: hidden;
    font-family: 'Noto Sans KR', sans-serif;
}

.table thead th {
    background-color: #e6f4ea;
    color: #2e7d32;
    font-weight: 600;
    text-align: center;
    border-bottom: 2px solid #c8e6c9;
}

.table tbody td {
    vertical-align: middle;
    text-align: center;
    border-color: #e0e0e0;
}

.table-hover tbody tr:hover {
    background-color: #f1f8f4;
    transition: background-color 0.2s ease;
}

.table-bordered {
    border: 1.5px solid #dcdcdc;
    border-radius: 12px;
    border-collapse: separate;
    border-spacing: 0;
    overflow: hidden;
}

.table-bordered thead th,
.table-bordered tbody td {
    border: 1px solid #dcdcdc;
}

.table-bordered thead th:first-child {
    border-left: none;
}

.table-bordered thead th:last-child {
    border-right: none;
}

.table-bordered tbody td:first-child {
    border-left: none;
}

.table-bordered tbody td:last-child {
    border-right: none;
}


.badge.bg-success {
  background-color: #315e4e !important;
  font-weight: 500;
  padding: 0.4em 0.6em;
}

.badge.bg-secondary {
  background-color: #bbb !important;
  font-weight: 500;
  padding: 0.4em 0.6em;
}

.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
  font-family: 'Noto Sans KR', sans-serif;
  gap: 10px;
}

.page-navigation a,
.page-navigation span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #7ecf98;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(126, 207, 152, 0.4);
  transition: background-color 0.25s ease, color 0.25s ease, box-shadow 0.25s ease;
  font-size: 1rem;
}

.page-navigation a:hover {
  background-color: #a4d7a7;
  color: white;
  box-shadow: 0 4px 12px rgba(126, 207, 152, 0.6);
}

.paginate span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  background-color: #4caf50;
  color: #fff;
  font-weight: 700;
  cursor: default;
  box-shadow: 0 2px 5px rgba(76, 175, 80, 0.6);
  font-size: 1rem;
}

.paginate a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s, color 0.3s;
  font-size: 1rem;
}

.paginate a:hover {
  background-color: #81c784;
  color: #fff;
  box-shadow: 0 4px 12px rgba(129, 199, 132, 0.6);
}

.page-navigation .disabled {
  color: #cde5d4;
  border-color: #cde5d4;
  cursor: default;
  pointer-events: none;
  box-shadow: none;
}

</style>

</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />


	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		
			<h2>오늘의 퀴즈 관리</h2>
			
			<div>
				<table>
					<thead>
						<tr>
							<td>퀴즈 제목</td>
							<td>${dto.subject}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>퀴즈 내용</td>
							<td>${dto.content}</td>
						</tr>
						<tr>
							<td>답</td>
							<td>
								<c:if test="${dto.answer eq '1'}">
								    O
								</c:if>
								<c:if test="${dto.answer eq '0'}">
								    X
								</c:if>
							</td>
						</tr>
						<tr>
							<td>해석</td>
							<td>${dto.commentary}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>${dto.name}</td>
						</tr>
						<tr>
							<td>작성일</td>
							<td>${dto.regDate}</td>
						</tr>
						<tr>
							<td>개시일</td>
							<td>${dto.openDate}</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div>
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/update?quizId=${dto.quizId}&page=${page}';">수정</button>
				<button type="button" onclick="deleteOk();">삭제</button>
			</div>
			
			<div>
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/quiz/list?${query}';">목록으로 돌아가기</button>
			</div>
			
	</main>

<c:if test="${sessionScope.member.memberId==dto.memberId||sessionScope.member.userLevel>50}">
	<script type="text/javascript">
	function deleteOk() {
		if(confirm('퀴즈를 삭제하시겠습니까?')) {
			let params = 'quizId=${dto.quizId}&${query}';
			let url = '${pageContext.request.contextPath}/admin/quiz/delete?' + params;
			location.href = url;
		}
	}
	</script>
</c:if>

</body>
</html>