function sendAjaxRequest(url, method, params, responseType, fn, file = false) {
	const settings = {
		url,
		type: method,
		data: params,
		dataType: responseType,
		success: fn,
		beforeSend: xhr => xhr.setRequestHeader('AJAX', true),
		error: xhr => {
			console.log('AJAX error', xhr.status, xhr.responseText);
			if (xhr.status === 403) {
				alert('error: ', e);
			}
		}
	};
	if (file) {
		settings.processData = false;
		settings.contentType = false;
	}
	$.ajax(settings);
}