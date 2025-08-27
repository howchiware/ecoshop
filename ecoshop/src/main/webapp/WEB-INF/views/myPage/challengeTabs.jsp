<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<ul class="nav nav-tabs mb-3">
  <li class="nav-item">
    <a class="nav-link ${tab=='list' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/challenge/mypage/list">
       내 챌린지
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${tab=='posts' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/challenge/mypage/specialPosts">
       내 인증글 관리
    </a>
  </li>
</ul>
