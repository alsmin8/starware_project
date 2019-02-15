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
	function unreadChatMessage() {
		$.ajax({
			type : 'POST',
			url : '/chat2/unreadChatMessaging',
			data : { userID : '<%=emp_name%>'
			},
			success : function(data){
				$('#boxTable').html('');
				console.log(data);
				if (data == null || data == "" || data == {}){
					return;
				}
				
				for(i =0 ; i< data.length; i++){
				console.log(data[i]);
				addBox(data[i].from_ID, data[i].to_ID, data[i].m_Content, displayTime(data[i].m_regdate));
				}
			}
		});
	}
	function addBox(from_ID, to_ID, m_Content, m_regdate) {
		if(from_ID == '<%=emp_name%>'){
			m_Content = '내가 보낸 마지막 메세지 : ' + m_Content;
			from_ID = to_ID;
		}else{
			m_Content = '읽지 않은 마지막 메세지 : ' + m_Content;
			to_ID = from_ID;
		}
		$('#boxTable').append('<tr onclick="location.href=\'/chat/messengerChat?toID=' + to_ID + '\'">'
				+ '<td style="width : 150px;"><h5>'+ from_ID +'<span id="unreadAmount" class="label label-info"></span></h5></td>'
				+ '<td><h5>'+ m_Content +'</h5>'
				+ '<div class="pull-right">'+ m_regdate +'</div></td></tr>');
	}
	
 	function getInfiniteUnreadChat() {
		setInterval(function() {
			unreadChatMessage();
		}, 5000);
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
				<li><a href="/schedule/scheduleMain">일정관리</a></li>
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
					<th colspan="2"><h4>메세지목록</h4></th>
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
	<script src="/resources/chatMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var emp_name = '<%=emp_name%>';
			getUnread(emp_name);
			unreadChatMessage();
			getInfiniteUnreadChat();
			getInfiniteUnread(emp_name);
		});
	</script>
	<%
		}
	%>
</body>
</html>