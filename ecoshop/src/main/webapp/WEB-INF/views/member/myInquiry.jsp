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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/myInquiry.css" type="text/css">
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
	  	<h3 class="pb-2 mb-4 border-bottom sub-title">1:1 문의내역</h3>
	  	
	  	<table class="table inquiry-table">
            <thead>
                <tr>
                    <th width="15%">상태</th>
                    <th width="15%">분류</th>
                    <th>제목</th>
                    <th width="20%">작성일</th>
                    <th width="20%">답변 확인</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty myInquiries}">
                    <tr>
                        <td colspan="5" class="text-center p-5 text-muted">작성한 문의 내역이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="dto" items="${myInquiries}">
                    <tr>
                        <td>
                            <c:if test="${dto.status == 0}"><span class="status-badge pending">답변 대기</span></c:if>
                            <c:if test="${dto.status == 1}"><span class="status-badge answered">답변 완료</span></c:if>
                            <c:if test="${dto.status == 2}"><span class="status-badge answered">삭제</span></c:if>
                        </td>
                        <td>${dto.categoryName}</td>
                        <td class="inquiry-subject">
                        	<div class="text-wrap">
                        		<c:if test="${dto.status == 2}">
                            		<span>${dto.subject}</span>
                        		</c:if>
                        		<c:if test="${dto.status != 2}">
                        		<a onclick="detailInquiry('${dto.inquiryId}', '${pageNo}');">${dto.subject}</a>                        		
                        		</c:if>
                        	</div>
                        </td>
                        <td>${dto.regDate}</td>
                        <td>
	                     	<button class="btn-inquiry" onclick="location.href='${pageContext.request.contextPath}/customer/main'">이동</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
	  </div>  
    </div>
  </div>
</main>

  <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
  <script src="${pageContext.request.contextPath}/dist/jsMember/menubar.js"></script>
</body>
</html>