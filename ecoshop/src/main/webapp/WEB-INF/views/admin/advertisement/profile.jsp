<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>
table.member-info {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Noto Sans KR', sans-serif;
    margin-bottom: 20px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    overflow: hidden;
}

table.member-info td {
    padding: 12px 14px;
    vertical-align: middle;
    font-size: 14px;
    color: #555;
    border-bottom: 1px solid #f0f0f0;
}

table.member-info tr:last-child td {
    border-bottom: none;
}

table.member-info td:first-child {
    font-weight: 600;
    color: #333;
    width: 140px;
    text-align: right;
    background-color: #fafafa;
}

/* 버튼 스타일 */
.btn-default {
    background-color: #fff;
    color: #007bff;
    border: 2px solid #007bff;
    padding: 6px 16px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 14px;
    transition: 0.3s;
    cursor: pointer;
    margin-right: 6px;
}

.btn-default:hover {
    background-color: #007bff;
    color: #fff;
}

.btn-row {
    display: flex;
    justify-content: space-between; /* 양쪽 끝으로 배치 */
    align-items: center;
    margin-top: 10px;
}

/* 모달 스타일 */
.modal-content {
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.15);
    border: none;
}

.modal-header {
    border-bottom: 1px solid #eee;
}

.modal-title {
    font-weight: 700;
    font-size: 1rem;
    color: #333;
}

.table.write-form td {
    padding: 10px;
    font-size: 14px;
    vertical-align: middle;
}

.table.write-form td.bg-light {
    font-weight: 600;
    color: #333;
    width: 120px;
}


</style>

<!-- 광고 상세보기 -->
<table class="member-info">
  <tr>
    <td>광고번호</td>
    <td>${dto.advertisingId }</td>
  </tr>
  <tr>
    <td>작성자</td>
    <td>${dto.username}</td>
  </tr>
  <tr>
    <td>제목</td>
    <td>${dto.subject}</td>
  </tr>
  <tr class="date-row">
    <td>작성일</td>
    <td>${dto.regDate}</td>
  </tr>
  <tr>
  	<td>문의유형</td>
  	 <td>
         <c:choose>
            <c:when test="${dto.inquiryType == 1}">
                메인
            </c:when>
            <c:when test="${dto.inquiryType == 2}">
                개인페이지
            </c:when>
            <c:otherwise>
                ${dto.inquiryType} 
            </c:otherwise>
        </c:choose>
    </td>
  </tr>
  <tr>
    <td>전화번호</td>
    <td>${dto.tel}</td>
  </tr>
  <tr>
    <td>이메일</td>
    <td>${dto.email}</td>
  </tr>
  <tr>
  	<td>내용</td>
    <td class="article-content">${dto.content}</td>
  </tr>
  
   <!-- 첨부파일 -->
        <c:if test="${listFile.size() != 0}">
          <div class="mb-3">
            <p class="border text-secondary mb-1 p-2">
              <i class="bi bi-folder2-open"></i>
              <c:forEach var="vo" items="${listFile}" varStatus="status">
                <a href="${pageContext.request.contextPath}/admin/advertisement/download/${vo.advertisingFileNum}">
                  ${vo.originalFilename}
                  (<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
                </a>
                <c:if test="${not status.last}"> | </c:if>
              </c:forEach>
            </p>
          </div>
        </c:if>
</table>

<div class="btn-row">
  <div class="right-btns">
    <button type="button" class="btn-default" onclick="updateAdvertisement();">수정</button>
  </div>
</div>

<div class="modal fade" data-bs-backdrop="static" id="advertisementUpdateDialogModal" tabindex="-1" aria-labelledby="advertisementUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="advertisementUpdateDialogModal">상태변경</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="advertisementUpdateForm" id="advertisementUpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td class="bg-light">문의유형</td>
							<td>
								<select name="inquiryType" class="form-select" style="width: 95%;">
									<option value="1" ${dto.inquiryType == 1 ? "selected" : ""}>메인</option>
									<option value="2" ${dto.inquiryType == 2 ? "selected" : ""}>개인페이지</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="bg-light">게시여부</td>
							<td>
								<select name="postingStatus" class="form-select" style="width: 95%;">
									<option value="1" ${dto.postingStatus == 1 ? "selected" : ""}>공개</option>
									<option value="0" ${dto.postingStatus == 0 ? "selected" : ""}>비공개</option>
								</select>
							</td>
						</tr>
					</table>
					
					<div class="text-end">
						<input type="hidden" name="advertisingId" value="${dto.advertisingId}">
						<button type="button" class="btn-default" onclick="updateAdvertisementOk('${page}');">수정완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

