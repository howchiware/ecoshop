<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOBRAND</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.form-section {
    background-color: #fff;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    max-width: 800px;
    margin: 0 auto;
}

.form-title {
    font-size: 1.8rem;
    font-weight: 600;
    margin-bottom: 2rem;
    text-align: center;
    color: #315e4e;
}

.form-label {
    font-weight: 500;
}

.help-block {
    font-size: 0.75rem; /* 기존 0.8rem에서 약간 더 작게 조정 */
    color: #777;
    margin-top: 5px;
    white-space: nowrap; /* 한 줄에 표시 */
    overflow: hidden; /* 넘치는 부분 숨기기 */
    text-overflow: ellipsis; /* ...으로 표시 */
    display: block;
    max-width: 100%;
}

.btn-default,
.btn-accent {
    border: 1px solid #ccc;
    padding: 0.375rem 1rem; /* Bootstrap input 기본 padding과 유사하게 설정 */
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.25rem;
    transition: all 0.2s ease-in-out;
}

.btn-default {
    background-color: #f0f0f0;
    border-color: #ccc;
    color: #555;
}

.btn-default:hover {
    background-color: #e0e0e0;
}

.btn-accent {
    background-color: #315e4e;
    border-color: #315e4e;
    color: #fff;
}

.btn-accent:hover {
    background-color: #2a4c3f;
    border-color: #2a4c3f;
}


.btn-lg {
    padding: 0.5rem 1.5rem; /* 기존보다 작게 조정 */
    font-size: 1rem; /* 약간 작게 */
}

.row {
    margin-bottom: 1rem;
}

.row.g-2 > [class^="col-"],
.row.g-2 > [class*=" col-"] {
    padding-right: 0.5rem;
}

.row.g-2 > [class^="col-"]:last-child,
.row.g-2 > [class*=" col-"]:last-child {
    padding-right: 0;
}
</style>
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
    
        function memberOk() {
            const f = document.memberForm;
            let str, p;
    
            p = /^[a-z][a-z0-9_]{4,9}$/i;
            str = f.userId.value;
            if( ! p.test(str) ) { 
                alert('아이디를 다시 입력 하세요. ');
                f.userId.focus();
                return;
            }
    
            let mode = '${mode}';
            if( mode === 'account' && f.loginIdValid.value === 'false' ) {
                str = '아이디 중복 검사가 실행되지 않았습니다.';
                // 고유 ID로 참조하도록 수정
                $('#userIdHelp').html(str);
                f.userId.focus();
                return;
            }
    
            p =/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
            str = f.password.value;
            if( ! p.test(str) ) { 
                alert('패스워드를 다시 입력 하세요. ');
                f.password.focus();
                return;
            }
    
            if( str !== f.password2.value ) {
                alert('패스워드가 일치하지 않습니다. ');
                f.password.focus();
                return;
            }
            
            p = /^[가-힣]{2,5}$/;
            str = f.name.value;
            if( ! p.test(str) ) {
                alert('이름을 다시 입력하세요. ');
                f.name.focus();
                return;
            }
            
            p = /^[가-힣]{2,10}$/;
            str = f.nickname.value;
            if( ! p.test(str) ) {
                alert('닉네임을 다시 입력하세요. ');
                f.nickname.focus();
                return;
            }
            
            if( mode === 'account' && f.nicknameValid.value === 'false' ) {
                str = '닉네임 중복 검사가 실행되지 않았습니다.';
                // 고유 ID로 참조하도록 수정
                $('#nicknameHelp').html(str);
                f.nickname.focus();
                return;
            }
    
            str = f.birth.value;
            if( ! isValidDateString(str) ) {
                alert('생년월일를 입력하세요. ');
                f.birth.focus();
                return;
            }
            
            p = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;    
            str = f.email.value;
            if( ! p.test(str) ) {
                alert('이메일을 입력하세요. ');
                f.email.focus();
                return;
            }
            
            p = /^(010)-?\d{4}-?\d{4}$/;    
            str = f.tel.value;
            if( ! p.test(str) ) {
                alert('전화번호를 입력하세요. ');
                f.tel.focus();
                return;
            }
    
            f.action = '${pageContext.request.contextPath}/member/${mode}';
            f.submit();
        }
    
        function userIdCheck() {
            let userId = $('#userId').val();
            let $helpBlock = $('#userIdHelp'); // ID로 직접 참조
    
            if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
                let str = '아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.';
                $helpBlock.html(str);
                $('#userId').focus();
                return;
            }
            
            let url = '${pageContext.request.contextPath}/member/userIdCheck';
            let params = 'userId=' + userId;
            $.ajax({
                type: 'POST',
                url: url,
                data: params,
                dataType: 'json',
                success: function(data) {
                    let passed = data.passed;
                    
                    if(passed === 'true') {
                        let str = '<span style="color:blue; font-weight: bold;">' + userId + '</span> 아이디는 사용가능 합니다.';
                        $helpBlock.html(str);
                        $('#loginIdValid').val('true');
                    } else {
                        let str = '<span style="color:red; font-weight: bold;">' + userId + '</span> 아이디는 사용할수 없습니다.';
                        $helpBlock.html(str);
                        $('#userId').val('');
                        $('#loginIdValid').val('false');
                        $('#userId').focus();
                    }
                }
            }); 
        }
    
        function nicknameCheck() {
            let nickname = $('#nickname').val();
            let $helpBlock = $('#nicknameHelp'); // ID로 직접 참조
    
            if(!/^[가-힣]{2,10}$/i.test(nickname)) { 
                let str = '닉네임은 2~10자 이내이며, 한글만 가능합니다.';
                $helpBlock.html(str);
                $('#nickname').focus();
                return;
            }
            
            let url = '${pageContext.request.contextPath}/member/nicknameCheck';
            let params = 'nickname=' + nickname;
            $.ajax({
                type: 'POST',
                url: url,
                data: params,
                dataType: 'json',
                success: function(data) {
                    let passed = data.passed;
                    
                    if(passed === 'true') {
                        let str = '<span style="color:blue; font-weight: bold;">' + nickname + '</span> 닉네임은 사용가능 합니다.';
                        $helpBlock.html(str);
                        $('#nicknameValid').val('true');
                    } else {
                        let str = '<span style="color:red; font-weight: bold;">' + nickname + '</span> 닉네임은 사용할수 없습니다.';
                        $helpBlock.html(str);
                        $('#nickname').val('');
                        $('#nicknameValid').val('false');
                        $('#nickname').focus();
                    }
                }
            }); 
        }
    </script>
    
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        function daumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var fullAddr = ''; 
                    var extraAddr = ''; 
    
                    if (data.userSelectedType === 'R') { 
                        fullAddr = data.roadAddress;
                    } else {
                        fullAddr = data.jibunAddress;
                    }
    
                    if(data.userSelectedType === 'R'){
                        if(data.bname !== ''){
                            extraAddr += data.bname;
                        }
                        if(data.buildingName !== ''){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                    }
    
                    document.getElementById('zip').value = data.zonecode;
                    document.getElementById('addr1').value = fullAddr;
                    document.getElementById('addr2').focus();
                }
            }).open();
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>