<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/editMember.css" type="text/css">
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<!-- 메인 영역 -->
	<main class="main-container">
		<div class="row">

			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
			</div>

			<div class="col-md-10">
				<div class="contentsArea">
					<form name="memberUpdateForm" method="post">
            <div class="row mb-3">
                <label for="userId" class="col-sm-3 col-form-label">아이디</label>
                <div class="col-sm-6">
                    <input type="text" name="userId" id="userId" class="form-control-plaintext" readonly value="${dto.userId}">
                </div>
            </div>

            <div class="row mb-3">
                <label for="password" class="col-sm-3 col-form-label">새 비밀번호</label>
                <div class="col-sm-6">
                    <input type="password" name="password" id="password" class="form-control" placeholder="변경할 경우에만 입력하세요">
                    <small class="form-text text-muted">5~10자, 영문자와 숫자/특수문자 포함</small>
                </div>
            </div>

            <div class="row mb-4">
                <label for="password2" class="col-sm-3 col-form-label">새 비밀번호 확인</label>
                <div class="col-sm-6">
                    <input type="password" name="password2" id="password2" class="form-control">
                </div>
            </div>

            <div class="row mb-3">
                <label for="name" class="col-sm-3 col-form-label">이름</label>
                <div class="col-sm-6">
                    <input type="text" name="name" id="name" class="form-control-plaintext" readonly value="${dto.name}">
                </div>
            </div>

            <div class="row mb-3">
                <label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <input type="text" name="nickname" id="nickname" class="form-control" value="${dto.nickname}">
                        <button class="btn btn-outline-secondary" type="button" onclick="nicknameCheck();">중복 검사</button>
                    </div>
                    <small id="nicknameHelp" class="form-text text-muted">2~10자의 한글만 가능합니다.</small>
                    <input type="hidden" id="originalNickname" value="${dto.nickname}">
                    <input type="hidden" id="nicknameValid" value="true">
                </div>
            </div>

            <div class="row mb-3">
                <label for="birth" class="col-sm-3 col-form-label">생년월일</label>
                <div class="col-sm-6">
                    <input type="text" name="birth" id="birth" class="form-control-plaintext" readonly value="${dto.birth}">
                </div>
            </div>
            
            <div class="row mb-3">
                <label for="email" class="col-sm-3 col-form-label">이메일</label>
                <div class="col-sm-6">
                    <input type="email" name="email" id="email" class="form-control" value="${dto.email}">
                </div>
            </div>

            <div class="row mb-4">
                <label for="tel" class="col-sm-3 col-form-label">전화번호</label>
                <div class="col-sm-6">
                    <input type="text" name="tel" id="tel" class="form-control" value="${dto.tel}">
                </div>
            </div>

            <div class="row mb-2">
                <label for="zip" class="col-sm-3 col-form-label">우편번호</label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <input type="text" name="zip" id="zip" class="form-control" readonly value="${dto.zip}">
                        <button class="btn btn-outline-secondary" type="button" onclick="daumPostcode();">주소 검색</button>
                    </div>
                </div>
            </div>
            <div class="row mb-2">
                <label for="addr1" class="col-sm-3 col-form-label">기본주소</label>
                <div class="col-sm-9">
                    <input type="text" name="addr1" id="addr1" class="form-control" readonly value="${dto.addr1}">
                </div>
            </div>
            <div class="row mb-4">
                <label for="addr2" class="col-sm-3 col-form-label">상세주소</label>
                <div class="col-sm-9">
                    <input type="text" name="addr2" id="addr2" class="form-control" value="${dto.addr2}">
                </div>
            </div>

            <div class="row">
                <div class="col-sm-9 offset-sm-3 d-flex justify-content-start gap-2">
                    <button type="button" class="btn btn-primary btn-lg" onclick="updateInfo();">정보수정</button>
                    <button type="button" class="btn btn-secondary btn-lg" onclick="location.href='${pageContext.request.contextPath}/';">수정취소</button>
                </div>
            </div>
        </form>
					
				</div>
			</div>
		</div>

	</main>

	<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="${pageContext.request.contextPath}/dist/jsMember/editMember.js"></script>
</body>
</html>