<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/sidebar.css" type="text/css">

</head>
<body>

<div class="sidebar" id="sidebar">
  <ul class="sidebar-menu">	
    <li class="menu-title">회원관리</li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/member/main"> 회원</a>
    </li>

	<li class="menu-title">온라인샵</li>
    <li>
      <a href="#"> 카테고리 관리 > </a>
      <ul class="submenu">
        <li><a href="#"> 카테고리 등록 / 수정 / 삭제</a></li>
        <li><a href="#"> 카테고리 순서</a></li>
      </ul>
    </li>
    <li>
      <a href="#"> 상품 관리 > </a>
      <ul class="submenu">
        <li><a href="/admin/product/totalProductList"> 전체 상품 관리</a></li>
        <li><a href="#"> 상품 등록</a></li>
        <li><a href="/admin/product/deliveryInfo"> 배송 정책 및 배송비</a></li>
        <li><a href="#"> 리뷰 및 Q&A 관리</a></li>
      </ul>
    </li>
    <li><a href="/admin/order/orderManage"> 주문 상태 관리</a></li>
    <li><a href="/admin/order/detailManage"> 주문 취소 관리</a></li>
    
    <li class="menu-title">공동구매</li>
    <li>
      <a href="#"> 카테고리 관리 > </a>
      <ul class="submenu">
        <li><a href="/admin/gonggu/category"> 카테고리 등록 / 수정 / 삭제</a></li>
        <li><a href="#"> 카테고리 순서</a></li>
      </ul>
    </li>
    <li>
      <a href="#"> 상품 관리 > </a>
      <ul class="submenu">
        <li><a href="#"> 전체 상품 관리</a></li>
        <li><a href="/admin/gonggu/productForm"> 상품 등록</a></li>
        <li><a href="#"> 배송 정책 및 배송비</a></li>
        <li><a href="/admin/gonggu/productReview"> 리뷰 및 Q&A 관리</a></li>
      </ul>
    </li>
    <li><a href=""> 주문 상태 관리</a></li>
    <li><a href=""> 주문 취소 관리</a></li>

    <li class="menu-title">챌린지</li>
    <li>
      <a href="#"> 챌린지 관리 ></a>
      <ul class="submenu">
        <li><a href="#"> 챌린지 목록</a></li>
        <li><a href="#"> 챌린지 등록/수정/삭제</a></li>
      </ul>
    </li>
    <li>
      <a href="#"> 챌린지 인증 관리 > </a>
      <ul class="submenu">
        <li><a href="#"> 스페셜 챌린지 인증</a></li>
      </ul>
    </li>

    <li class="menu-title">워크숍</li>
    <li>
      <a href="/admin/workshop/program/list"> 프로그램 관리 </a>
    </li>
    <li>
      <a href="#"> 워크샵 관리 > </a>
      <ul class="submenu">
        <li><a href="#"> 워크샵 목록</a></li>
        <li><a href="#"> 워크샵 등록</a></li>
        <li><a href="#"> 참여자 관리</a></li>
        <li><a href="/admin/workshop/manager/list"> 담당자 관리</a></li>
        <li><a href="#"> FAQ 관리</a></li>
      </ul>
    </li>
    <li>
      <a href="#">포인트 관리 ></a>
      <ul class="submenu">
        <li><a href="#"> 포인트 지급 내역</a></li>
      </ul>
    </li>

    <li class="menu-title">광고</li>
    <li>
      <a href="#"> 광고 관리 ></a>
      <ul class="submenu">
        <li><a href="${pageContext.request.contextPath}/admin/advertisement/list"> 광고 목록</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/advertisement/status"> 광고 상태 조회</a></li>
      </ul>
    </li>

    <li class="menu-title">이벤트</li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/quiz/list"> 오늘의 퀴즈</a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/attendance/list"> 출석 체크</a>
    </li>

    <li class="menu-title">고객센터</li>
    <li><a href="${pageContext.request.contextPath}/admin/notice/list"> 공지사항</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/blockAndInquiry/main"> 신고 / 1:1</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/faq/main"> 자주 묻는 질문</a></li>

  </ul>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll(".sidebar-menu > li > a").forEach(function(menu) {
    menu.addEventListener("click", function(e) {
      let submenu = this.nextElementSibling;
      if (submenu && submenu.classList.contains("submenu")) {
        e.preventDefault();
        submenu.style.display = submenu.style.display === "block" ? "none" : "block";
      }
    });
  });
});
</script>

</body>
</html>
