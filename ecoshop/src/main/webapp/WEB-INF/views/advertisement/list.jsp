<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>광고 문의</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<style>
* {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

    h2 {
        font-size: 28px;
        font-weight: bold;
        margin-top: 50px;
        margin-bottom: 50px;
    }
    .ad-box {
        display: flex;
        align-items: center;
        margin-bottom: 50px;
    }
    .ad-box img {
        width: 250px;
        height: 250px;
        background-color: #ddd;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        margin-right: 30px;
    }
    .ad-desc {
        max-width: 500px;
    }
    .ad-desc h3 {
        margin: 0 0 10px 0;
        font-size: 18px;
    }
    .ad-desc p {
        margin: 0 0 15px 0;
        color: #333;
        line-height: 1.5;
    }
    .btn {
        display: inline-block;
        padding: 8px 15px;
        background: #eee;
        border: 1px solid #aaa;
        cursor: pointer;
        text-decoration: none;
        color: black;
    }
    .reverse {
        flex-direction: row-reverse;
    }
    .reverse img {
        margin-left: 30px;
        margin-right: 0;
    }
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
	  <div class="container">
        <h2>광고문의</h2>

        <!-- 첫 번째 광고 -->
        <div class="ad-box">
            <img src="#" alt="메인페이지 광고 이미지"><br>
            <div class="ad-desc">
                <h3>마이페이지 광고</h3>
                <p>
                    이 페이지는 마이페이지 광고에 대한 설명입니다.<br>
                    마이페이지에 대한 광고를 설명하는 자리 입니다.<br>
                    여기에 장점쓰고 뭔가 추가적인 설명도 써야됨
                </p>
                <a href="${pageContext.request.contextPath}/advertisement/write" class="btn">신청하기</a>
            </div>
        </div>

        <!-- 두 번째 광고 (이미지 오른쪽) -->
        <div class="ad-box reverse">
            <img src="#" alt="메인페이지 광고 이미지"><br>
            <div class="ad-desc">
                <h3>마이페이지 광고</h3>
                <p>
                    이 페이지는 마이페이지 광고에 대한 설명입니다.<br>
                    마이페이지에 대한 광고를 설명하는 자리 입니다.<br>
                    여기에 장점쓰고 뭔가 추가적인 설명도 써야됨
                </p>
                <a href="${pageContext.request.contextPath}/advertisement/write" class="btn">신청하기</a>
            </div>
        </div>
    </div>

</body>
</html>
