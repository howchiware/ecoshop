function sendOk() {
	const f = document.pwdForm;

	if(! f.password.value.trim()) {
		alert('패스워드를 입력하세요. ');
		f.password.focus();
		return;
	}

	f.action = CONTEXT_PATH + '/member/pwd';
	f.submit();
}