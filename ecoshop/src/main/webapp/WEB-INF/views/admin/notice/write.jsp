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

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

	<div class="right-panel">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>공지사항</h2>
		</div>

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
										<input type="text" name="subject" class="form-control" maxlength="100" placeholder="Subject" value="${dto.subject}">
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
														<label class="delete-file" noticefileId="${vo.noticefileId}"><i class="bi bi-trash"></i></label> 
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
								<button type="reset" class="btn-default btn-md">다시입력</button>
								<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.noticeId}">
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