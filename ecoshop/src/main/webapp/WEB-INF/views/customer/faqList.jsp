<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:if test="${not empty faqlist}">
	<div class="accordion faq-accordion" id="faqAccordion">
		<c:forEach var="dto" items="${faqlist}" varStatus="status">
			<div class="accordion-item">
				<h2 class="accordion-header" id="heading-${status.index}">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#collapse-${status.index}">
						<span class="faq-category">[${dto.categoryName}]</span>
						${dto.subject}
					</button>
				</h2>
				<div id="collapse-${status.index}"
					class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
					<div class="accordion-body">
						<div class="faq-content">${dto.content}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</c:if>