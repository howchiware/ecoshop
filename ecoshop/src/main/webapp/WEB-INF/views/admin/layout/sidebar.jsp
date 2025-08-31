<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/sidebar.css" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css">
<meta content="width=device-width, initial-scale=1" name="viewport" />

<div class="sidebar" id="sidebar">
  <ul class="sidebar-menu">	
    <li class="menu-title">회원관리</li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/member/main"> 회원</a>
    </li>

	<li class="menu-title">온라인샵</li>
    <li>
      <a href="/admin/category/categoryManage"> 카테고리 관리</a>
    </li>
    <li>
      <a href="#"> 상품 관리 > </a>
      <ul class="submenu">
        <li><a href="/admin/products/listProduct"> 전체 상품 관리</a></li>
        <li><a href="/admin/products/write"> 상품 등록</a></li>
        <li><a href="/admin/products/deliveryWrite"> 배송 정책 및 배송비</a></li>
        <li><a href="/admin/products/productReviewInquiry"> 리뷰 및 Q&amp;A 관리</a></li>
      </ul>
    </li>
     <li>
    	<a href=""> 주문 상태 관리 > </a>
    	<ul class="submenu">
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/orderManage/100'/>">주문완료</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/orderManage/110'/>">배송</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/100'/>">배송후교환</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/110'/>">구매확정</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/orderManage/120'/>">주문리스트</a></li>
    	</ul>
    </li>
    <li>
    	<a href=""> 주문 취소 관리 > </a>
    	<ul class="submenu">
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/200'/>">배송전환불</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/210'/>">배송후반품</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/220'/>">판매취소</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/order/detailManage/230'/>">취소리스트</a></li>
    	</ul>
    </li>
    
    <li class="menu-title">공동구매</li>
    <li>
      <a href="/admin/category/categoryManage"> 카테고리 관리</a>
    </li>
    <li>
      <a href="#"> 상품 관리 > </a>
      <ul class="submenu">
        <li><a href="/admin/gonggu/listProduct"> 패키지 등록 및 조회</a></li>
        <li><a href="/admin/gonggu/deliveryWrite"> 배송 정책 및 배송비</a></li>
        <li><a href="/admin/gonggu/productReview"> 리뷰 및 Q&amp;A 관리</a></li>
      </ul>
    </li>
    <li>
    	<a href=""> 주문 상태 관리 > </a>
    	<ul class="submenu">
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/orderManage/100'/>">주문완료</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/orderManage/110'/>">배송</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/100'/>">배송후교환</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/110'/>">구매확정</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/orderManage/120'/>">주문리스트</a></li>
    	</ul>
    </li>
    <li>
    	<a href=""> 주문 취소 관리 > </a>
    	<ul class="submenu">
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/200'/>">배송전환불</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/210'/>">배송후반품</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/220'/>">판매취소</a></li>
			<li><a class="sub-menu-link" href="<c:url value='/admin/gongguOrder/detailManage/230'/>">취소리스트</a></li>
    	</ul>
    </li>

    <li class="menu-title">챌린지</li>
    <li>
      <a href="#"> 챌린지 관리 ></a>
      <ul class="submenu">
        <li><a href="${pageContext.request.contextPath}/admin/challengeManage/list"> 챌린지 목록</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/challengeManage/write"> 챌린지 등록</a></li>
      </ul>
    </li>
    <li>
      <a href="#"> 챌린지 인증 관리 > </a>
      <ul class="submenu">
        <li><a href="${pageContext.request.contextPath}/admin/challengeManage/certList"> 챌린지 인증 목록</a></li>
      </ul>
    </li>

    <li class="menu-title">워크샵</li>
    <li>
      <a href="#"> 프로그램 관리 > </a>
      <ul class="submenu">
      	<li><a href="/admin/workshop/category/manage"> 카테고리 관리 </a></li>
      	<li><a href="/admin/workshop/program/list"> 프로그램 등록 </a></li>
      </ul>
    </li>
    <li>
      <a href="#"> 운영 관리 > </a>
      <ul class="submenu">
        <li><a href="/admin/workshop/list"> 워크샵 관리</a></li>
        <li><a href="/admin/workshop/manager/list"> 담당자 관리</a></li>
        <li><a href="/admin/workshop/participant/list"> 참여자 관리</a></li>
      </ul>
   </li>
   <li>
      <a href="#"> 운영 지원 > </a>
      <ul class="submenu">
        <li><a href="/admin/workshop/faq/manage"> FAQ 관리</a></li>
        <li><a href="/admin/workshop/points"> 포인트 관리</a></li>
      </ul>
    </li>

    <li class="menu-title">광고</li>
    <li>
      <a href="#"> 광고 관리 ></a>
      <ul class="submenu">
        <li><a href="${pageContext.request.contextPath}/admin/advertisement/list"> 광고 목록</a></li>
        <!--<li><a href="${pageContext.request.contextPath}/admin/promotion/list"> 광고 상태 조회</a></li>  -->
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
    const sidebar = document.getElementById("sidebar");
    const allLinks = document.querySelectorAll(".sidebar-menu a");

    document.querySelectorAll(".sidebar-menu > li > a").forEach(function(menu) {
        menu.addEventListener("click", function(e) {
            let submenu = this.nextElementSibling;
            if (submenu && submenu.classList.contains("submenu")) {
                e.preventDefault();
                submenu.style.display = submenu.style.display === "block" ? "none" : "block";
            }
        });
    });

    const savedScrollTop = sessionStorage.getItem('sidebarScrollTop');
    if (savedScrollTop) {
        sidebar.scrollTop = parseInt(savedScrollTop, 10);
    }

    allLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            const href = link.getAttribute('href');
            if (href && href !== '#') {
                sessionStorage.setItem('sidebarScrollTop', sidebar.scrollTop);
            }
        });
    });
});
</script>


