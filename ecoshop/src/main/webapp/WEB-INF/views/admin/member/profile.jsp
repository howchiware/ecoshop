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

<!-- 회원 상세보기 -->
<table class="member-info">
  <tr>
    <td>회원번호</td>
    <td>${dto.memberId}</td>
  </tr>
  <tr>
    <td>이름</td>
    <td>${dto.name}</td>
  </tr>
  <tr>
    <td>생일</td>
    <td>${dto.birth}</td>
  </tr>
  <tr class="date-row">
    <td>가입일</td>
    <td>${dto.regDate}</td>
  </tr>
  <tr>
    <td>전화번호</td>
    <td>${dto.tel}</td>
  </tr>
  <tr>
    <td>우편번호</td>
    <td>${dto.zip}</td>
  </tr>
  <tr>
    <td>주소</td>
    <td>${dto.addr1} ${dto.addr2}</td>
  </tr>
  <tr>
    <td>이메일</td>
    <td>${dto.email}</td>
  </tr>
</table>

<div class="btn-row">
  <!-- 왼쪽 -->
  <div class="left-btns">
    <button type="button" class="btn-default" onclick=''>목록</button>
  </div>
  
  <!-- 오른쪽 -->
  <div class="right-btns">
    <button type="button" class="btn-default" onclick="updateMember();">수정</button>
    <button type="button" class="btn-default" onclick="deleteMember('${dto.memberId}');">삭제</button>
  </div>
</div>


<div class="modal fade" data-bs-backdrop="static" id="memberUpdateDialogModal" tabindex="-1" aria-labelledby="memberUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memberUpdateDialogModalLabel">회원정보수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="memberUpdateForm" id="memberUpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td class="bg-light">이름</td>
							<td>
								<input type="text" name="name" class="form-control" value="${dto.name}" style="width: 95%;" readonly>
							</td>
						</tr>
						<tr>
							<td class="bg-light">닉네임</td>
							<td>
								<input type="text" name="nickname" class="form-control" value="${dto.email}" style="width: 95%;">
							</td>
							<td>
								<c:if test="${mode=='account'}">
                                    <button type="button" class="btn btn-default" onclick="nicknameCheck();">중복 검사</button>
                                </c:if>
							</td>
						</tr>
						<tr>
							<td class="bg-light">생년월일</td>
							<td>
								<input class="form-control" type="date" id="birth" name="birth" value="${dto.birth}" readonly>
							</td>
						</tr>
						<tr>				
							<td class="bg-light">이메일</td>
							<td>
								<input type="text" name="email" class="form-control" value="${dto.email}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">전화번호</td>
							<td>
								<input type="text" name="tel" class="form-control" value="${dto.tel}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">우편번호</td>
							<td>
								<input class="form-control" type="text" name="zip" id="zip" value="${dto.zip}" readonly tabindex="-1">
							</td>
							<td>
								<button type="button" class="btn btn-default" id="btn-zip" onclick="daumPostcode();">주소 검색</button>
							</td>
						</tr>
						<tr>
							<td class="bg-light">기본주소</td>
							<td>
								<input class="form-control" type="text" name="addr1" id="addr1" value="${dto.addr1}" readonly tabindex="-1">
							</td>
						</tr>
						<tr>
							<td class="bg-light">상세주소</td>
							<td>
								<input class="form-control" type="text" name="addr2" id="addr2" value="${dto.addr2}">
							</td>
						</tr>
						
						
					</table>
					<div class="text-end">
						<input type="hidden" name="memberId" value="${dto.memberId}">
						<input type="hidden" name="enabled" value="${dto.enabled}">
						
						<button type="button" class="btn-default" onclick="updateMemberOk('${page}');">수정완료</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>
