function sendOk() {
	const f = document.pwdForm;

	if (!f.userId.value.trim()) {
		alert('아이디를 입력하세요.');
		f.userId.focus();
		return;
	}

	if (!f.name.value.trim()) {
		alert('이름을 입력하세요.');
		f.name.focus();
		return;
	}

	f.action = CONTEXT_PATH + '/member/pwdFind';
	f.submit();
}