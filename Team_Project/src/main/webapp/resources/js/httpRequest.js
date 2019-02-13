function getXMLHttpRequest() {
	// 구형 브라우저에서 xhr 객체 생성 방법
	if (window.ActiveXObject) {
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch(e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch(e1) { return null; }
		}
    // 신형 브라우저에서 xhr 객체 생성 방법
	} else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}
var httpRequest = null;

function sendRequest(url, params, callback, method) {
	//xhr 객체
	httpRequest = getXMLHttpRequest();
	// get 방식인지, post 방식인지 구분
	var httpMethod = method ? method : 'GET';
	if (httpMethod != 'GET' && httpMethod != 'POST') {
		httpMethod = 'GET';
	}
	var httpParams = (params == null || params == '') ? null : params;
	var httpUrl = url;
	if (httpMethod == 'GET' && httpParams != null) {
		httpUrl = httpUrl + "?" + httpParams;
	}
	httpRequest.open(httpMethod, httpUrl, true);
	httpRequest.setRequestHeader(
		'Content-Type', 'application/x-www-form-urlencoded');
	// 서버로부터 결과값이 도착하면 함수가 호출되도록 설정
	httpRequest.onreadystatechange = callback;
	// post 방식일때 데이터 전달하는 방식
	httpRequest.send(httpMethod == 'POST' ? httpParams : null);
}
















