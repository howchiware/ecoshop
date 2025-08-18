<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
:root {
    --primary-color: #234d3c;
    --border-color: #e9ecef;
    --text-dark: #2c3e50;
    --text-light: #8492a6;
}

.faq-accordion .accordion-item {
	background-color: #fff;
	border: 1px solid var(--border-color);
	border-radius: 12px;
	margin-bottom: 1rem;
	box-shadow: 0 4px 12px rgba(0,0,0,0.04);
    overflow: hidden; /* border-radius 적용을 위해 필수 */
}

.faq-accordion .accordion-header {
    border-bottom: none;
}

.faq-accordion .accordion-button {
	font-weight: 600;
	color: var(--text-dark);
    background-color: #fff;
    transition: background-color 0.2s ease-in-out;
}

.faq-accordion .accordion-button .faq-category {
	font-weight: 700;
	color: var(--primary-color);
	margin-right: 8px;
    font-size: 0.95rem;
}

.faq-accordion .accordion-button:not(.collapsed) {
  background-color: var(--primary-color);
  color: #ffffff;
  box-shadow: none;
}
.faq-accordion .accordion-button:not(.collapsed) .faq-category {
    color: rgba(255, 255, 255, 0.85); 
}
.faq-accordion .accordion-button:focus {
    box-shadow: 0 0 0 0.2rem rgba(35, 77, 60, 0.25);
}

.faq-accordion .accordion-body {
	padding: 1.5rem 2rem;
    background-color: #fcfcfd;
}
.faq-accordion .faq-content {
	font-size: 0.95rem;
	color: #5c6e80;
	white-space: pre-line;
	line-height: 1.8;
}

.accordion-button::after {
    filter: grayscale(1) brightness(1.5);
}
.accordion-button:not(.collapsed)::after {
    filter: brightness(0) invert(1);
}
</style>

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
					class="accordion-collapse collapse"
					data-bs-parent="#faqAccordion">
					<div class="accordion-body">
						<div class="faq-content">${dto.content}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</c:if>