<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String emp_name = null;
	if (session.getAttribute("emp_name") != null) {
		emp_name = (String) session.getAttribute("emp_name");
	}
	String emp_no = null;
	if (session.getAttribute("emp_no") != null) {
		emp_no = (String) session.getAttribute("emp_no");
	}
	String toID = null;
	if (request.getAttribute("toID") != null) {
		toID = (String) request.getAttribute("toID");
	}

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>


<script type="text/javascript">
	var lastID = 0;

	function submitFunction() {
		var fromID = '<%=emp_name%>';
		var toID = '<%=toID%>';
		var chatContent = $('#chatContent').val();
		$.ajax({
			type : 'POST',
			url : '/chat2/insertChatSubmit',
			data : JSON.stringify({
				from_ID : fromID,
				to_ID : toID,
				m_Content : chatContent
			}),
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		});
		$('#chatContent').val('');
	}
	function autoClosingAlert(selector, deley) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, deley);
	}

	function chatListFunction(type) {
		var fromID = '<%=emp_name%>';
		var toID = '<%=toID%>';
		$.ajax({
			type : 'POST',
			url : '/chat2/listChatLoad',
			data : {
				fromID : fromID,
				toID : toID,
				listType : type
			},
			success : function(data) {
				if (data == null || data == "" || data == {}){
					return;
				}
				var parsed = JSON.parse(data);
				var result = parsed.result;

				for (var i = 0; i < result.length; i++) {
					if(result[i][0].value == fromID){
						result[i][0].value = "나";
					};
					addChat(result[i][0].value, result[i][2].value,
							result[i][3].value);
				}
				lastID = Number(parsed.last);
			}
		});
	}
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append(
			'<div class="row">' + 
			'<div class="col-lg-12">' + 
			'<div class="media">'+ 
			'<a class="pull-left" href="#">'+ 
			'<img class="media-object img-circle" style="width:30px; height:30px;" src="/resources/images/p.JPG" alt=""/>'+ 
			'</a>' + '<div class="media-body">'+ 
			'<h4 class="media-heading">' + 
			chatName + 
			'<span class="small pull-right">' + 
			chatTime + 
			'</span>' + 
			'</h4>' + 
			'</div>' + 
			'<p>'+ 
			chatContent + 
			'</p>' + 
			'</div></div></div><hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	
 	function getUnread() {
		$.ajax({
			type : "POST",
			url : "/chat2/unleadAllChatlist",
			data : {
				userID : '<%=emp_name%>'
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

	function getInfinitechatList() {
		setInterval(function() {
			chatListFunction(lastID);
		}, 3000);
	}
	function getInfiniteUnread() {
		setInterval(function() {
			getUnread();
		}, 3500);
	}
	

</script>

</head>
<body>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/login">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/loginafter">메인</a></li>
				<li><a href="/approval/applist_alllist">전자결재</a></li>
				<li><a href="/project/projectList">협업지원</a></li>
				<li><a href="/notice/noticeList">공지사항</a></li>
				<li><a href="/attend/attendInsert">출퇴근관리</a></li>
				<li><a href="/emp/empList">인사관리</a></li>
				<li><a href="/schedule/schduleMain">일정관리</a></li>
				<li class="active"><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>
			<%
				if (emp_no != null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="fa fa-circle text-green"></i>실시간 채팅창
							</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="portlet-body chat-widget"
							style="overflow-y: auto; width: auto; height: 600px;">
						
						</div>
						
						<div class="portlet-footer">
							<div class="row" style="height: 90px;">
								<div class="form-group col-xs-10">
									<textarea style="height: 80px;" id="chatContent"
										class="form-control" placeholder="메세지를 입력하세요." maxlength="100"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right"
										onclick="submitFunction();">전송</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="alert alert-success" id="successMessage"
		style="display: none;">
		<strong>메세지전송에 성공하였습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage"
		style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage"
		style="display: none;">
		<strong>데이터베이스에 오류가 있습니다.</strong>
	</div>

	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div
					class="modal-content <%if (messageType.equals("오류메세지"))
					out.println("panel-warning");
				else
					out.println("panel-success");%>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%=messageType%>
						</h4>
					</div>
					<div class="modal-body">
						<%=messageContent%>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal('show');
	</script>
	<%
		session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
		}
	%>
	
	<%
		if(emp_no != null){

	%>
	<script type="text/javascript">
	$(document).ready(function() {
		getUnread();
		chatListFunction('0');
		getInfinitechatList();
		getInfiniteUnread();
	});
	</script>
	<%
		}
	%>

	
</body>
</html>