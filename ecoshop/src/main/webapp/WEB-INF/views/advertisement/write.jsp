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
	    h2 {
	        font-size: 20px;
	        margin-bottom: 10px;
	    }
	    .desc {
	        margin-bottom: 30px;
	        color: #666;
	    }
	    form {
	        width: 100%;
	    }
	    table {
	        width: 100%;
	        border-collapse: collapse;
	    }
	    th {
	        text-align: left;
	        width: 150px;
	        padding: 10px;
	        vertical-align: top;
	    }
	    td {
	        padding: 10px;
	    }
	    input[type=text],
	    input[type=file],
	    select,
	    textarea {
	        width: 100%;
	        padding: 8px;
	        border: 1px solid #ccc;
	        border-radius: 3px;
	    }
	    textarea {
	        height: 150px;
	        resize: none;
	    }
	    .required {
	        color: red;
	    }
	    .btn-box {
	        text-align: center;
	        margin-top: 30px;
	    }
	    .btn-md {
	        padding: 10px 20px;
	        border-radius: 5px;
	        border: 1px solid #aaa;
	        cursor: pointer;
	        margin: 0 5px;
	    }
	</style>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
		</header>
		<main class="main-container">
			<div class="container my-5">
			        <h2 class="mb-3"><i class="bi bi-clipboard-check"></i> 광고 신청</h2>
			        <p class="text-muted mb-4">
			            마이페이지 광고 신청에 대한 설명과 신청한 내용은 관리자에게 전달됩니다.
			        </p>
			
			        <form name="advertisementForm" action="" method="post" enctype="multipart/form-data">
			           <table class="table write-form">
								<tr>
									<td class="col-md-2 bg-light">작성자</td>
									<td>
										<input type="text" name="username" class="form-control" maxlength="100" placeholder="제목 입력" value="${dto.username}">
									</td>
								</tr>
	
								<tr>
									<td class="col-md-2 bg-light">제 목</td>
									<td>
										<div class="row">
											<div class="col-md-6">
												<input type="text" name="subject" class="form-control" value="${dto.subject}">
											</div>
										</div>
									</td>
								</tr>
							
								<tr>
								    <td class="col-md-2 bg-light">내 용</td>
								    <td>
								        <textarea name="content" class="form-control" rows="10" placeholder="내용 입력">${dto.content}</textarea>
								    </td>
								</tr>
								
								<tr>
								    <td class="col-md-2 bg-light">문의유형</td>
								    <td>
								        <input type="text" name="inquiryType" class="form-control" rows="10" placeholder="내용 입력">${dto.inquiryType}>
								    </td>
								</tr>
								
								<tr>
								    <td class="col-md-2 bg-light">이메일</td>
								    <td>
								        <input type="text" name="email" class="form-control" rows="10" placeholder="내용 입력">${dto.email}>
								    </td>
								</tr>
								
								<tr>
								    <td class="col-md-2 bg-light">전화번호</td>
								    <td>
								        <input type="text" name="tel" class="form-control" rows="10" placeholder="내용 입력">${dto.tel}>
								    </td>
								</tr>
								
								<tr>
								    <td class="col-md-2 bg-light">광고 시작일</td>
								    <td>
								        <input type="DATE"  name="adverStart" class="form-control" >${dto.adverStart}>
								    </td>
								</tr>
								
								<tr>
								    <td class="col-md-2 bg-light">광고 종료일</td>
								    <td>
								        <input type="date" name="adverEnd" class="form-control" value="${dto.adverEnd}">
								    </td>
								</tr>
																
								<tr>
									<td class="col-md-2 bg-light">파일</td>
									<td>
										<input type="file" class="form-control" name="selectFile" multiple>
									</td>
								</tr>
								
								<c:if test="${mode=='update'}">
									<tr> 
										<td class="col-md-2 bg-light">첨부된파일</td>
										<td>
											<p class="form-control-plaintext">
												<c:forEach var="vo" items="${listFile}" varStatus="status">
													<span>
														<label class="delete-file" data-noticefileId="${vo.advertisingFileNum}"><i class="bi bi-trash"></i></label> 
														${vo.originalFilename}&nbsp;|
													</span>
												</c:forEach>
												&nbsp;
											</p>
										</td>
									  </tr>
								</c:if>
							</table>
							
			            <div class="text-center">
			                <button type="reset" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/advertisement/list';">취소하기</button>
			                <button type="submit" class="btn-accent btn-md" onclick="sendOk()">신청하기</button>
			            </div>
			        </form>
			    </div>
			</main>
			
	<script type="text/javascript">
	
	function sendOk() {
	    const f = document.advertisementForm;
	
	
	    f.action = '${pageContext.request.contextPath}/advertisement/write';
	    f.submit();
	}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<c:if test="${mode=='update'}">
		<script type="text/javascript">
			$('.delete-file').click(function(){
				if(! confirm('선택한 파일을 삭제 하시겠습니까 ? ')) {
					return false;
				}
				
				let $span = $(this).closest('span');
				let advertisingFileNum = $(this).attr('data-advertisingFileNum');
				let url = '${pageContext.request.contextPath}/advertisement/deleteFile';
				
				$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
				$.post(url, {advertisingFileNum:advertisingFileNum}, function(data){
					$span.remove();
				}, 'json').fail(function(xhr){
					console.log(xhr.responseText);
				});
			});
		</script>
	</c:if>	
			
	</body>
	</html>
	
	
