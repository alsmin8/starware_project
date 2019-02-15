function getUnread(emp_name) {
	$.ajax({
		type : "POST",
		url : "/chat2/unleadAllChatlist",
		data : {
			userID : emp_name
		},
		success : function(result) {
			var count = Number(result);
			if(count >= 1){
				showUnread(result);
			}else{
				showUnread('');
			}
		}
	});
}
function showUnread(result) {
	$('#unread').html(result);
}
function getInfiniteUnread(emp_name) {
	setInterval(function() {
		getUnread(emp_name);
	}, 3000);
}

function allUserFunction(emp_name) {
	$.ajax({
		type : 'POST',
		url : '/chat2/allUserCheck.json',
		success : function(data) {
			//console.log(data);
			for (var i = 0; i < data.length; i++) {
				addListUser(data[i].emp_no, data[i].emp_name, emp_name);
			}
		}
	});
}
function addListUser(emp_no, findID, emp_name) {
	var findID2 = findID;
	if(findID == emp_name){
		findID2 = findID + '(본인)';
	}
	//console.log(emp_no);
	$('#friendResult').append(
			'<tbody><tr><td style="text-align: center;"><h3>사번 :' + emp_no +"&nbsp;&nbsp; 이름 : " + findID2 +'</h3><a href="/chat/messengerChat?toID=' + findID +
			'" class="btn btn-primary pull-right">메신저보내기</a></td></tr></tbody>');
}

function displayTime(timeValue) {
	var today = new Date();
	
	var gap = today.getTime() - timeValue;
	
	var dateObj = new Date(timeValue);
	var str = "";
	
	if(gap < (1000 * 60 * 60 * 24)){
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':',(ss > 9 ? '' : '0') + ss ].join('');
	}else{
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();
		
		return [yy, '/',(mm > 9 ? '' : '0') + mm, '/',(dd > 9 ? '' : '0') + dd].join('');
	}
}