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

	
</table>

<button type="button" class="btn-default" onclick="updateMember();">수정</button>
<button type="button" class="btn-default" onclick="deleteMember('${dto.memberId}');">삭제</button>



