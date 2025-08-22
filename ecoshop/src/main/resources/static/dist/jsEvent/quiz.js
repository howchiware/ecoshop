$(document).ready(function() {
    if (!quizData) return;

    const correctAnswer = quizData.correctAnswer;
    const explanation = quizData.explanation;
    const isSolved = quizData.isSolved;
    const flipCard = $('.flip-card');

    if(isSolved) {
        $('.quiz-buttons').html(
            '<p style="font-size: 1.2rem; font-weight: 600; background: rgba(0,0,0,0.2); padding: 1rem; border-radius: 8px;">오늘의 퀴즈에 이미 참여했습니다!</p>'
        );
    }

    $('.quiz-btn').on('click', function() {
        if(isSolved) return;

        const userAnswer = $(this).data('answer');
        const isCorrect = (userAnswer === correctAnswer);

        if(isCorrect) {
            $('#resultIcon').html('<i class="bi bi-check-circle-fill result-icon correct"></i>');
            $('#resultTitle').text('정답입니다! 🎉');
            $('#resultDesc').html(explanation);
            $('#resultPoint').html('<i class="bi bi-gift-fill"></i> 100 포인트 적립 완료!');
        } else {
            $('#resultIcon').html('<i class="bi bi-x-circle-fill result-icon incorrect"></i>');
            $('#resultTitle').text('아쉬워요 😢');
            $('#resultDesc').html(explanation);
            $('#resultPoint').html('');
        }

        flipCard.addClass('is-flipped');
    });

    $('.btn-back').on('click', function() {
        flipCard.removeClass('is-flipped');
    });
});
