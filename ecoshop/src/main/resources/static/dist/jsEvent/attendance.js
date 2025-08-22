function attendanceOk(event) {
  event.preventDefault(); 
  fetch(CONTEXT_PATH + '/event/attendance/check', { method: 'POST' })
    .then(res => res.json())
    .then(data => {
      if (data.message === '로그인이 필요합니다.') {
        window.location.href = CONTEXT_PATH + '/member/login';
        return;
      }
      alert(data.success ? '출석 체크 완료! 오늘도 화이팅하세요! 💪' : '😁 ' + data.message);
      if (data.success) window.location.reload();
    })
    .catch(() => alert('오류가 발생했습니다.'));
}