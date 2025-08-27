<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/myEvent.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/myEventAttendance.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<main class="main-container">
		<div class="row">

			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
			</div>

			<div class="col-md-10">
				<div class="contentsArea">
					<h3 class="pb-2 mb-4 border-bottom sub-title">마이 출석체크</h3>

					<div class="row">
						<div class="col px-2">
							<div id="calendar"></div>
						</div>
					</div>
					
					<div>
						<a href="${pageContext.request.contextPath}/member/myEvent">돌아가기</a>
					</div>
				</div>
			</div>

		</div>
	</main>

	<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/fullcalendar6/dist/index.global.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/fullcalendar6/dist/locales-all.global.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/dateUtil.js"></script>
<script>
    const CONTEXT_PATH = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/jsEvent/attendance.js"></script>

</body>
</html>