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
		<div class="content">
			<h2 class="mb-4">출석체크 관리</h2>

			<form name="searchForm" class="row g-3 mb-4" method="get">
				<div class="col-auto">
					<label for="start" class="form-label">기간 시작일(월요일)</label> 
					<input type="date" id="start" name="start" value="${empty start ? '' : start}" class="form-control" required>
				</div>
				<div class="col-auto">
					<label for="end" class="form-label">기간 종료일(일요일)</label>
					<input type="date" id="end" name="end" value="${empty end ? '' : end}" class="form-control" readonly>
				</div>

				<div class="col-auto">
					<label for="schType" class="form-label">검색 조건</label> 
						<select 	id="schType" name="schType" class="form-select">
							<option value="name" ${schType=="name"?"selected":""}>이름</option>
							<option value="memberId" ${schType=="memberId"?"selected":""}>회원번호</option>
						</select>
					
				</div>
				<div class="col-auto">
					<label for="keyword" class="form-label">검색어</label> 
					<input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
				</div>

				<div class="col-auto align-self-end">
					<button type="submit" class="btn btn-primary" onclick="searchList();">조회</button>
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/attendance/list'">초기화
				</button>
				</div>
				
				
			</form>

			<table class="table table-bordered table-hover">
				<thead class="table-light">
					<tr class="text-center">
						<th>회원번호</th>
						<th>이름</th>
						<th>기간</th>
						<th>출석 횟수</th>
						<th>마지막 출석일</th>
						<th>포인트 지급 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}">
						<tr class="text-center">
							<td>${item.memberId}</td>
							<td>${item.name}</td>
							<td>${start}~${end}</td>
							<td>
			                    <c:choose>
			                        <c:when test="${item.attendanceCount > 0}">
			                            ${item.attendanceCount}회
			                        </c:when>
			                        <c:otherwise>
			                            없음
			                        </c:otherwise>
			                    </c:choose>
			                </td>
			                <td><fmt:formatDate value="${item.lastAttendanceDate}" pattern="yyyy-MM-dd" /></td>
							<td>
								<c:choose>
									<c:when test="${item.attendanceCount >= 5}">
										<span class="badge bg-success">지급완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">미지급</span>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>


					<c:if test="${empty list}">
						<tr>
							<td colspan="6" class="text-center">조회하실 정보를 입력해 주세요.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			
			<div class="page-navigation">
				${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
			</div>
		</div>
	</main>

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
	
	let url = '${pageContext.request.contextPath}/admin/attendance/list';
	location.href = url + '?' + params;
}

document.getElementById("start").addEventListener("change", function () {
  let start = new Date(this.value);
  let day = start.getDay();

  if (day !== 1) {
    alert("시작일은 월요일로 선택해주세요.");
    this.value = "";
    document.getElementById("end").value = "";
    return;
  }

  let end = new Date(start);
  end.setDate(start.getDate() + 6);
  document.getElementById("end").value = end.toISOString().split("T")[0];
});
</script>
	

</body>
</html>