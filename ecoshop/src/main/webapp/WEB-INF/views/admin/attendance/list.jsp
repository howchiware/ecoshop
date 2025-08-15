<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

/* --- ▼ 기능에 집중하는 무채색(Grayscale) 테마로 변경 ▼ --- */

h2.mb-4 {
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 600;
    font-size: 1.7rem;
    color: #212529;
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
    width: 5px;
    height: 70%;
    background: #343a40; /* 변경: 진한 회색 */
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
  border: 1px solid #e9ecef; /* 추가: 콘텐츠 영역 구분선 */
  border-radius: 4px; 
  padding: 25px;
  box-shadow: none; /* 변경: 그림자 제거 */
}

form label {
  font-weight: 600;
  color: #495057;
  font-size: 0.9rem;
}

form .form-control,
form .form-select {
  border-radius: 4px;
  border: 1px solid #ced4da;
  font-size: 0.9rem;
}

form .form-control:focus,
form .form-select:focus {
  border-color: #343a40; /* 변경: 진한 회색 */
  box-shadow: 0 0 0 0.15rem rgba(52, 58, 64, 0.2); /* 변경 */
}

/* 조회 버튼 */
form .btn-primary {
  background-color: #343a40; /* 변경: 진한 회색 */
  border: 1px solid #343a40; /* 변경 */
  color: white;
  font-weight: 500;
  padding: 0.45rem 1.2rem;
  border-radius: 4px;
}

form .btn-primary:hover {
  background-color: #212529; /* 변경: 더 진한 회색 */
}

/* 초기화 버튼 */
form button[type=button] {
  background-color: #fff; /* 변경: 흰색 배경 */
  color: #495057; /* 변경: 회색 글씨 */
  border: 1px solid #ced4da; /* 변경: 테두리선 */
  padding: 0.45rem 1rem;
  border-radius: 4px;
  font-weight: 500;
}

form button[type=button]:hover {
  background-color: #f8f9fa; /* 변경: 밝은 회색 배경 */
}

.table-wrapper {
    max-width: 100%;
    margin: 0 auto;
}

.table {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 4px;
    overflow: hidden;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 0.9rem;
}

.table thead th {
    background-color: #f8f9fa;
    color: #343a40;
    font-weight: 600;
    text-align: center;
    border-bottom: 2px solid #dee2e6;
    padding: 0.6rem 0.5rem;
}

.table tbody td {
    vertical-align: middle;
    text-align: center;
    border-color: #e9ecef;
    color: #495057;
}

.table-hover tbody tr:hover {
    background-color: #f1f3f5;
    transition: background-color 0.2s ease;
}

.table-bordered {
    border: 1px solid #dee2e6;
    border-radius: 4px;
}

.table-bordered thead th,
.table-bordered tbody td {
    border: 1px solid #dee2e6;
}

/* 뱃지 스타일 */
.badge.bg-success {
  background-color: #343a40 !important; /* 변경: 진한 회색 */
  color: #fff;
  font-weight: 500;
  padding: 0.4em 0.7em;
}

.badge.bg-secondary {
  background-color: #e9ecef !important; /* 변경: 밝은 회색 */
  color: #495057; /* 변경 */
  font-weight: 500;
  padding: 0.4em 0.7em;
}

/* 페이지네이션 스타일 */
.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 25px;
    font-family: 'Noto Sans KR', sans-serif;
    gap: 6px;
}
.paginate {
    display: flex;
    gap: 6px;
}

.paginate a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 36px;
    height: 36px;
    padding: 0 10px;
    border-radius: 4px;
    border: 1px solid #dee2e6;
    color: #495057;
    background-color: #fff;
    text-decoration: none;
    font-weight: 500;
    transition: background-color 0.1s ease, border-color 0.1s ease;
}

/* 현재 페이지 번호 */
.paginate span {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 36px;
    height: 36px;
    padding: 0 10px;
    border-radius: 4px;
    border: 1px solid #343a40; /* 변경 */
    background-color: #343a40; /* 변경 */
    color: #fff;
    font-weight: 600;
    cursor: default;
}

.paginate a:hover {
    background-color: #f1f3f5; /* 변경 */
    border-color: #dee2e6; /* 변경 */
}

/* 이전/다음 버튼 */
.page-navigation a {
    border-radius: 4px;
}
.page-navigation a:hover {
    background-color: #f1f3f5;
    border-color: #dee2e6;
}

/* 비활성화된 버튼 */
.page-navigation .disabled {
    color: #adb5bd;
    border-color: #dee2e6;
    cursor: default;
    pointer-events: none;
    background-color: #f8f9fa;
}

.card {
    border: 1px solid #e9ecef;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.card-title {
    font-size: 0.95rem;
    font-weight: 600;
    color: #495057;
}

.card-text {
    color: #212529;
}
.text-success {
	color: #198754 !important;
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

<div class="row mb-4">
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">총 조회 인원</h5>
                <p class="card-text fs-4 fw-bold">${dataCount}명</p>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">포인트 지급 대상</h5>
                <%-- 이 값은 컨트롤러에서 계산해서 넘겨줘야 합니다 --%>
                <p class="card-text fs-4 fw-bold text-success">${pointTargetCount}명</p> 
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">기간 내 총 출석</h5>
                <%-- 이 값도 컨트롤러에서 계산해서 넘겨줘야 합니다 --%>
                <p class="card-text fs-4 fw-bold">${totalAttendanceCount}회</p>
            </div>
        </div>
    </div>
</div>

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