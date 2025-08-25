<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
</head>
<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- 메인 영역 -->
<main class="main-container">
<div class="row">

	<div class="col-md-2">
        <jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp"/>
    </div>
    
    <div class="col-md-10">
	    <div class="contentsArea">
	  	    <h3 class="pb-2 mb-4 border-bottom sub-title">포인트</h3>
	  	    
	  	    <p>현재 포인트 : ${balance}</p>
			<table class="table board-list table-hover">
				<thead>
					<tr>
						<th width="130">번호</th>
						<th width="130">구분</th>
						<th width="150">일자</th>
						<th width="130">포인트</th>
						<th width="160">상세내용</th>
						<th width="160">잔액</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${pointList}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td>${dto.classifyStr}</td>
							<td>${dto.baseDate}</td>
							<td><fmt:formatNumber value="${dto.points}"/></td>
							<td>${dto.reason}</td>
							<td>${dto.balance}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<table class="table">
				<tr>
					<td width="100">
						<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/myShopping/myPoint';">새로고침</button>
					</td>
					<td align="center">
						<form name="searchForm" class="form-search">
							<select name="schType" title="검색항목">
								<option value="classifyStr" ${schType=="classifyStr"?"selected":""}>구분</option>
								<option value="reason" ${schType=="reason"?"selected":""}>상세내용</option>
								<option value="baseDate" ${schType=="baseDate"?"selected":""}>일자</option>
							</select>
							<input type="text" name="kwd" value="${kwd}"title="검색키워드">
							<button type="button" class="btn-default" onclick="searchList()">검색</button>
						</form>
					</td>
				</tr>
			</table>	
			
			<div class="page-navigation">
				${dataCount==0 ? "포인트 내역이 없습니다." : paging}
			</div>
	    </div>
	  
		
		  
    </div>
    
  </div>
  
</main>

<script type="text/javascript">
// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
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
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/myShopping/myPoint';
	location.href = url + '?' + params;
}
</script>


  <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
  <script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>