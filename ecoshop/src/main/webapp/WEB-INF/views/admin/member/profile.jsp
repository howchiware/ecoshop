<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<table>
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
  <tr>
    <td>가입일</td>
    <td>${dto.regDate}</td>
    <td>최근수정일</td>
    <td>${dto.regUpdate}</td>
  </tr>
   <tr>
    <td>전화번호</td>
    <td>${dto.tel}</td>
  </tr>
  <tr>
   <tr>
    <td>우편번호</td>
    <td>${dto.zip}</td>
  </tr>
  <tr>
    <td>주소</td>
    <td>${dto.addr1}&nbsp;${dto.addr2}</td>
  </tr>
  <tr>
    <td>주소</td>
    <td>${dto.email}</td>
  </tr>
</table>

<button type="button" class="btn-default" onclick="updateMember();">수정</button>
<button type="button" class="btn-default" onclick="deleteMember('${dto.memberId}');">삭제</button>


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
								<input type="text" name="name" class="form-control" value="${dto.name}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">생년월일</td>
							<td>
								<input type="date" name="birth" class="form-control" value="${dto.birth}" style="width: 95%;">
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
