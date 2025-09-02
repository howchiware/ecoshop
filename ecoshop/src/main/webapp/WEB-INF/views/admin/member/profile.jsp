<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- 회원 상세보기 -->
<table class="table member-info">
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
  <tr>
    <td>유효 상태</td>
		<td>
			<c:if test="${dto.enabled == 1}"><span>활성화</span></c:if>
			<c:if test="${dto.enabled == 0}"><span class="userEnabled2">비활성화</span></c:if>
		</td>
	</tr>
</table>

<div class="btn-row">
    <div class="right-btns">
        <button type="button" class="btn my-btn" onclick="updateMember();">수정</button>
        
        <form action="${pageContext.request.contextPath}/admin/member/deleteMember" method="post" onsubmit="return confirm('${dto.name} 님을 정말로 탈퇴 처리하시겠습니까?');" style="display: inline;">  
              <input type="hidden" name="memberId" value="${dto.memberId}">
              <input type="hidden" name="name" value="${dto.name}">
            <button type="submit" class="btn my-btn">탈퇴</button>
        </form>
    </div>
  
    <div class="left-btns">
        <button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/member/main'">목록</button>
    </div>
</div>

<div class="modal fade" data-bs-backdrop="static" id="memberUpdateDialogModal" tabindex="-1" aria-labelledby="memberUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="memberUpdateDialogModalLabel">회원정보수정</h3>
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
								<input type="text" name="nickname" class="form-control" value="${dto.nickname}" style="width: 95%;">
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
								<button type="button" class="btn my-btn" id="btn-zip" onclick="daumPostcode();">주소검색</button>
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
						
						<button type="button" class="btn my-btn btn2" onclick="updateMemberOk('${page}');">수정완료</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>
