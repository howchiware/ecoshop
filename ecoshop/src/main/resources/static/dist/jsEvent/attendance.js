function attendanceOk(event) {
  event.preventDefault(); 
  fetch(CONTEXT_PATH + '/event/attendance/check', { method: 'POST' })
    .then(res => res.json())
    .then(data => {
      if (data.message === '로그인이 필요합니다.') {
        window.location.href = CONTEXT_PATH + '/member/login';
        return;
      }
      alert(data.success ? data.message: data.message);
      if (data.success) window.location.reload();
    })
    .catch(() => alert('오류가 발생했습니다.'));
}