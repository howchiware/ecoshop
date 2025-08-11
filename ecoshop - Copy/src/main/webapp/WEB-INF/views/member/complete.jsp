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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        body {
            background-color: #f7f6f3;
            color: #333;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .result-section {
            background-color: #f7f6f3;
            min-height: calc(100vh - 60px); /* 헤더 높이를 제외한 최소 높이 */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .result-card {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            max-width: 500px;
            width: 100%;
        }

        .result-title {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
            color: #315e4e;
        }
        
        .result-message {
            font-size: 1rem;
            line-height: 1.6;
            color: #555;
            margin-top: 2rem;
            margin-bottom: 2rem;
            text-align: center;
        }

        .btn-accent {
            background-color: #315e4e;
            border: none;
            color: #fff;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 5px;
            width: 100%;
            transition: background-color 0.2s ease-in-out;
        }

        .btn-accent:hover {
            background-color: #2a4c3f;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    
    <main class="result-section">
        <div class="result-card">
            <h3 class="result-title">${title}</h3>
            <hr class="my-4">
            
            <p class="result-message">${message}</p>
                
            <div>
                <button type="button" class="btn-accent" onclick="location.href='${pageContext.request.contextPath}/member/login';">
                 	로그인하러 가기
                </button>                    
            </div>
        </div>
    </main>
</body>
</html>