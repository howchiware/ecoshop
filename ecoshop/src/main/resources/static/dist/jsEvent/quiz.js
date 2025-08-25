$(document).ready(function() {
	if (!quizData) return;

	const isSolved = quizData.isSolved;
	const flipCard = $('.flip-card');

	if (isSolved) {
		$('.quiz-buttons').html(
			'<p style="font-size: 1.2rem; font-weight: 600; background: rgba(0,0,0,0.2); padding: 1rem; border-radius: 8px;">오늘의 퀴즈에 이미 참여했습니다!</p>'
		);
		
		return;
	}

	$('.quiz-btn').on('click', function() {

		const userAnswer = $(this).data('answer');

		$.ajax({
			type: 'POST',
			url: CONTEXT_PATH + '/event/quiz/play',
			data: {
				quizId: quizData.quizId,
				userAnswer: userAnswer
			},
			success: function(resp) {
				if (resp.success) {
					if (resp.isCorrect) {
						$('#resultIcon').html('<i class="bi bi-check-circle-fill result-icon correct"></i>');
						$('#resultTitle').text('정답입니다! 🎉');
						$('#resultPoint').html('<i class="bi bi-gift-fill"></i> 100 포인트 적립 완료!');
					} else {
						$('#resultIcon').html('<i class="bi bi-x-circle-fill result-icon isCorrect"></i>');
						$('#resultTitle').text('아쉬워요 😢');
						$('#resultPoint').html('');
					}
						$('#resultDesc').html(resp.explanation);
						flipCard.addClass('is-flipped');
						$('.quiz-buttons').html('<p style="font-size: 1.2rem; font-weight: 600;">참여해주셔서 감사합니다!</p>');
					
				} else {
					alert(resp.message);
				}
			},
			error: function() {
				alert('오류가 발생했습니다. 나중에 다시 이용해주세요.');
			}
		});
	});

	$('.btn-back').on('click', function() {
		flipCard.removeClass('is-flipped');
	});
});
