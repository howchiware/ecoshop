<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="row">
	<aside >
		<nav class="sidebar-nav sidebar-compact">
			<h5 class="nav-section-maintitle"><a class="unstyled" href="${pageContext.request.contextPath}/member/myPage">마이페이지</a></h5>
			<h5 class="nav-section-title">마이쇼핑</h5>
			<ul class="list-unstyled">
				<li><a href="${pageContext.request.contextPath}/" data-view="orders">주문/배송 조회</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="returns">취소/반품 내역</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="cart">장바구니</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="likes">좋아요</a></li>
				<li><a href="${pageContext.request.contextPath}/myShopping/myPoint" data-view="points">포인트</a></li>
			</ul>

			<h5 class="nav-section-title">마이활동</h5>
			<ul class="list-unstyled">
				<li><a href="${pageContext.request.contextPath}/" data-view="challenges">챌린지</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="workshops">워크숍</a></li>
				<li><a href="${pageContext.request.contextPath}/member/inquiry" data-view="inquiries">1:1 문의내역</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="reviews">리뷰</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="qna">상품Q&amp;A 내역</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="events">이벤트 참여 현황</a></li>
			</ul>

			<h5 class="nav-section-title">마이정보</h5>
			<ul class="list-unstyled">
				<li><a href="${pageContext.request.contextPath}/member/pwd" data-view="myProfile">회원정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="shipping">배송지/환불계좌</a></li>
				<li><a href="${pageContext.request.contextPath}/" data-view="withdraw">회원탈퇴</a></li>
			</ul>
		</nav>
	</aside>
	
</div>