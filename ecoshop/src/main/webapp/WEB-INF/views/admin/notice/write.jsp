<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
body {
  font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
  background-color: #f7f6f3;
  color: #333;
  margin: 0;
}

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-style: normal;
}

.right-panel { padding: 40px; }

.page-title {
  margin-bottom: 20px;
  font-size: 22px;
  font-weight: 700;
  color: #2d2f3a;
}

.section-body {
  max-width: 1300px;
  margin: 0 auto;
  background: #fff;
  border-radius: 12px;
  padding: 30px 40px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.05);
}

/* 제목 스타일 변경 */
.small-title {
  font-size: 18px; 
  font-weight: 700;
  margin-bottom: 20px;
  color: #666; 
}

.table.write-form { width: 100%; }
.table.write-form td { padding: 12px 10px; border: none; }
.table.write-form .bg-light {
  background-color: transparent !important;
  font-weight: 600;
  color: #555;
  width: 100px; 
  font-size: 14px;
}

.table.write-form input[type="text"],
.table.write-form input[type="file"],
.table.write-form textarea {
  width: 100%;
  max-width: 100%;
  border-radius: 8px;
  border: 1px solid #d0d7de;
  font-size: 14px;
  padding: 10px 12px;
}

.table.write-form input:focus,
.table.write-form textarea:focus {
  border-color: #315e4e;
  box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.15);
  outline: none;
}

.btn-accent {
  background-color: #315e4e;
  border: none;
  color: #fff;
  padding: 10px 25px;
  font-weight: 600;
  border-radius: 8px;
  transition: background-color 0.2s ease, transform 0.2s ease;
}

.btn-accent:hover {
  background-color: #5a54d4;
  transform: translateY(-1px);
}

.btn-default {
  background-color: #f3f4f6;
  color: #555;
  padding: 10px 25px;
  border-radius: 8px;
  border: none;
  font-weight: 500;
  transition: background-color 0.2s ease;
}

.btn-default:hover {
  background-color: #e2e4e9;
}

.text-center { margin-top: 20px; }

.form-row {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.right-panel { padding: 20px; }
.section-body { padding: 20px 30px; }
.section.p-5 { padding: 2rem !important; }
.board-section.p-5 { padding: 2rem !important; margin-top: 0 !important; }

/* 이전글/다음글 영역 */
.prev-next {
  margin-top: 30px;
  border-top: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
}
.prev-next div {
  padding: 12px 0;
  border-top: 1px solid #eee;
}
.prev-next div:first-child {
  border-top: none;
}

@media (max-width: 768px) {
  .right-panel { margin-left: 0; padding: 20px; }
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

	<div class="right-panel">

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="row gy-4 m-0">
					<div class="col-lg-12 board-section p-5 m-2" data-aos="fade-up" data-aos-delay="200">
						
						<div class="pb-2">
							<span class="small-title">${mode=='update'?'공지사항 수정':'공지사항 등록'}</span>
						</div>
					
						<form name="noticeForm" action="" method="post" enctype="multipart/form-data">
							<table class="table write-form">
								<tr>
									<td class="col-md-2 bg-light">제 목</td>
									<td>
										<input type="text" name="subject" class="form-control" maxlength="100" placeholder="제목 입력" value="${dto.subject}">
									</td>
								</tr>
	
								<tr>
									<td class="col-md-2 bg-light">공지여부</td>
									<td>
										<input type="checkbox" class="form-check-input" name="notice" id="notice" value="1" ${dto.notice==1 ? "checked":"" }>
										<label for="notice" class="form-check-label">공지</label>
									</td>
								</tr>
	
								<tr>
									<td class="col-md-2 bg-light">출력여부</td>
									<td>
										<input type="checkbox" class="form-check-input" name="showNotice" id="showNotice" value="1" ${mode=="write" || dto.showNotice==1 ? "checked":"" }>
										<label for="showNotice" class="form-check-label">표시</label>
									</td>
								</tr>
					
								<tr>
									<td class="col-md-2 bg-light">이 름</td>
									<td>
										<div class="row">
											<div class="col-md-6">
												<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.member.name}">
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
														<label class="delete-file" data-noticefileId="${vo.noticefileId}"><i class="bi bi-trash"></i></label> 
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
								<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
								<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="noticeId" value="${dto.noticeId}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</main>


<script type="text/javascript">

function sendOk() {
    const f = document.noticeForm;
    
    if (!f.subject.value.trim()) {
        alert("제목을 입력하세요.");
        f.subject.focus();
        return;
    }

    if (!f.content.value.trim()) {
        alert("내용을 입력하세요.");
        f.content.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/admin/notice/${mode}';
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
			let noticefileId = $(this).attr('data-noticefileId');
			let url = '${pageContext.request.contextPath}/admin/notice/deleteFile';
			
			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {noticefileId:noticefileId}, function(data){
				$span.remove();
			}, 'json').fail(function(xhr){
				console.log(xhr.responseText);
			});
		});
	</script>
</c:if>
</body>
</html>