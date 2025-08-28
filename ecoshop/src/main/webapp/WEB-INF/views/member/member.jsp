<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssMember/member.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    
    <main class="container my-5">
    
        <div class="form-section">
            <h2 class="form-title">${mode == "update" ? "회원 정보 수정" : "회원가입"}</h2>
            <form name="memberForm" method="post">
                <div class="row">
                    <div class="col-md-6">
                        <label for="userId" class="form-label">아이디</label>
                        <div class="row g-2">
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="userId" name="userId" value="${dto.userId}" ${mode=="update" ? "readonly ":""} autofocus>
                            </div>
                            <div class="col-sm-4 d-grid">
                                <c:if test="${mode=='account'}">
                                    <button type="button" class="btn btn-default" onclick="userIdCheck();">중복 검사</button>
                                </c:if>
                            </div>
                        </div>
                        <c:if test="${mode=='account'}">
                            <small id="userIdHelp" class="help-block text-muted">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
                        </c:if>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="password" class="form-label">패스워드</label>
                        <input class="form-control" type="password" id="password" name="password" autocomplete="off">
                        <small class="help-block text-muted">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자를 포함 합니다.</small>
                    </div>
                    <div class="col-md-6">
                        <label for="password2" class="form-label">패스워드 확인</label>
                        <input class="form-control" type="password" id="password2" name="password2" autocomplete="off">
                        <small class="help-block text-muted">패스워드를 한번 더 입력해주세요.</small>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="fullName" class="form-label">이름</label>
                        <input class="form-control" type="text" id="fullName" name="name" value="${dto.name}" ${mode=="update" ? "readonly ":""}>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="nickname" class="form-label">닉네임</label>
                        <div class="row g-2">
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="nickname" name="nickname" value="${dto.nickname}" ${mode=="update" ? "readonly ":""} autofocus>
                            </div>
                            <div class="col-sm-4 d-grid">
                                <c:if test="${mode=='account'}">
                                    <button type="button" class="btn btn-default" onclick="nicknameCheck();">중복 검사</button>
                                </c:if>
                            </div>
                        </div>
                        <c:if test="${mode=='account'}">
                            <small id="nicknameHelp" class="help-block text-muted">닉네임은 2~10자 이내이며, 한글만 가능합니다.</small>
                        </c:if>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="birth" class="form-label">생년월일</label>
                        <input class="form-control" type="date" id="birth" name="birth" value="${dto.birth}" ${mode=="update" ? "readonly ":""}>
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">이메일</label>
                        <input class="form-control" type="text" id="email" name="email" value="${dto.email}">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="tel" class="form-label">전화번호</label>
                        <input class="form-control" type="text" id="tel" name="tel" value="${dto.tel}">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="zip" class="form-label">우편번호</label>
                        <div class="row g-2">
                            <div class="col-sm-8">
                                <input class="form-control" type="text" name="zip" id="zip" value="${dto.zip}" readonly tabindex="-1">
                            </div>
                            <div class="col-sm-4 d-grid">
                                <button type="button" class="btn btn-default" id="btn-zip" onclick="daumPostcode();">주소 검색</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="addr1" class="form-label">기본주소</label>
                        <input class="form-control" type="text" name="addr1" id="addr1" value="${dto.addr1}" readonly tabindex="-1">
                    </div>
                    <div class="col-md-6">
                        <label for="addr2" class="form-label">상세주소</label>
                        <input class="form-control" type="text" name="addr2" id="addr2" value="${dto.addr2}">
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <button type="button" name="sendButton" class="btn btn-accent btn-lg" onclick="memberOk();">
                            ${mode == "update" ? "정보수정" : "회원가입"} <i class="bi bi-check2"></i>
                        </button>
                        <button type="button" class="btn btn-default btn-lg" onclick="location.href='${pageContext.request.contextPath}/';">
                            ${mode == "update" ? "수정취소" : "가입취소"} <i class="bi bi-x"></i>
                        </button>                 
                        <input type="hidden" name="loginIdValid" id="loginIdValid" value="false">
                        <input type="hidden" name="nicknameValid" id="nicknameValid" value="false">
                    </div>
                </div>
            </form>
        </div>
    </main>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
		const MODE = "${mode}";
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsMember/member.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>