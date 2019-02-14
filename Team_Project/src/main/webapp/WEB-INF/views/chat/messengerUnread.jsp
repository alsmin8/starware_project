<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		String emp_name = null;
		if (session.getAttribute("emp_name") != null) {
			emp_name = (String) session.getAttribute("emp_name");
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
	
	function unreadChatMessage() {
		$('#boxTable').html('');
		var userID = '<%=emp_name%>';
		$.ajax({
			type : 'POST',
			url : '/chat2/unreadChatMessaging',
			data : {
				userID : userID
			},
			success : function(data){
				//console.log(data);
				if (data == null || data == "" || data == {}){
					return;
				}
				for (var i = 0; i < data.length; i++) {
					if(data[i].from_ID == userID){
						data[i].from_ID = data[i].to_ID;
					}else{
						data[i].to_ID = data[i].from_ID;
					}
					var date = data[i].m_regdate;
					addBox(data[i].from_ID, data[i].to_ID, data[i].m_Content, displayTime(data[i].m_regdate.getTime()));
				}
			}
		});
	}
	function addBox(lastID, toID, chatContent, chatTime) {
		$('#boxTable').append('<tr onclick="location.href=\'/chat/messengerChat?toID=' + toID + '\'">'
				+ '<td style="width : 150px;"><h5>'+ lastID +'</h5></td>'
				+ '<td><h5>마지막 메세지 : '+ chatContent +'</h5>'
				+ '<div class="pull-right">'+ chatTime +'</div></td></tr>');
	}
	
 	function getInfiniteUnreadChat() {
		setInterval(function() {
			unreadChatMessage();
		}, 5000);
	}
	function getInfiniteUnread() {
		setInterval(function() {
			getUnread();
		}, 3000);
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
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<br>
	<div class="container">
		<table class="table" style="margin: 0 auto;">
			<thead>
				<tr>
					<th colspan="2"><h4>안읽은 메세지목록</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width: 100%; max-height: 450px;">
				<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
					<tbody id="boxTable">
						<tr onclick="location.href ='/chat/messengerChat?toID=홍길동'">
							<td style="width : 150px;"><h5>lastID</h5></td>
							<td>
								<h5>마지막 메세지 : chatContent</h5>
								<div class="pull-right">chatTime</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</table>
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
	<script type="text/javascript">
		$('#messageModal').modal('show');
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times</span>
						<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
						확인메세지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button"class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
 	<%
		if(emp_no != null){

	%>
	<script type="text/javascript">
		$(document).ready(function() {
			getUnread();
			unreadChatMessage();
			getInfiniteUnreadChat();
			getInfiniteUnread();
		});
	</script>
	<%
		}
	%>
</body>
</html>