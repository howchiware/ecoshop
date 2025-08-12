<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="container-md">회원 목록</div>
  <div class="container">
    <div class="row">
      <!-- 탭 -->
      <div class="col">
        <div class="section p-5">
          <ul class="nav nav-tabs" id="myTab">
            <li class="nav-item"><button class="nav-link active" data-tab="1">회원</button></li>
            <li class="nav-item"><button class="nav-link" data-tab="2">강사</button></li>
          </ul>
          <form name="memberSearchForm">
            <input type="hidden" name="schType" value="login_id">
            <input type="hidden" name="kwd">
            <input type="hidden" name="role" value="1">
            <input type="hidden" name="non" value="0">
            <input type="hidden" name="enabled">
          </form>
        </div>
      </div>

      <!-- 검색 -->
      <div class="col order-last">
        <div class="form-search">
          <select id="searchType" name="schType">
            <option value="memberId" ${schType=="memberId" ? "selected":""}>아이디</option>
            <option value="name"     ${schType=="name" ? "selected":""}>이름</option>
            <option value="email"    ${schType=="email" ? "selected":""}>이메일</option>
            <option value="tel"      ${schType=="tel" ? "selected":""}>전화번호</option>
          </select>
          <input type="text" id="keyword" name="kwd" value="${kwd}">
          <button type="button" onclick="searchList()"><i class="bi bi-search"></i></button>
        </div>
      </div>
    </div>

    <!-- 회원 목록 -->
    <table class="table table-hover board-list">
      <thead class="table-light">
        <tr>
		  <th>번호</th>
		  <th>아이디</th>
          <th>이름</th>
          <th>전화번호</th>
          <th>가입일자</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="dto" items="${list}" varStatus="status">
          <tr onclick="profile('${dto.memberId}', '${page}');">
            <td>${(page-1) * size + status.index + 1}</td>
            <td>${dto.memberId}</td>
            <td>${dto.name}(${dto.nickname})</td>
            <td>${dto.tel}</td>
            <td>${dto.regDate}</td>
            <td>
			<c:choose>
				<c:when test="${dto.userLevel==1}">회원</c:when>
				<c:when test="${dto.userLevel==51}">강사</c:when>
				<c:when test="${dto.userLevel==99}">관리자</c:when>
			</c:choose>
			</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 페이징 -->
    <div class="page-navigation">
      ${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
    </div>
  </div>
</main>
<!-- 
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
    $('#tab-0').addClass('active');
	
    $('button[userLevel="tab"]').on('click', function(e){
    	const tab = $(this).attr('data-tab');
    	
		if(tab !== '4') {
			// 회원, 강사, 직원 리스트
			resetList();
		} else {
			// 연령별 어낼러시스(분석)
			memberAnalysis();
		}
    });	
});
 -->


</script>
</body>
</html>