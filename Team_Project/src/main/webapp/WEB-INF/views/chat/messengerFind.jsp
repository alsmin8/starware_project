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
	function findFunction() {
		var userID = $('#findID').val();
		$.ajax({
			type : 'POST',
			url : '/chat2/userRegisterCheck',
			data : {
				userID : userID
			},
			success : function(result) {
				//console.log(result);
				if (result == null || result =="" || result.length == 0) {
					$('#checkMessage').html('사용자를 찾을수 없습니다.');
					$('#checkType').attr('class','modal-content panel-warning');
				}else {
					$('#checkMessage').html('사용자찾기에 성공하였습니다.');
					$('#checkType').attr('class','modal-content panel-success');
					getFriend(result.emp_no , result.emp_name);
					
				}
				$('#checkModal').modal('show');
			}
		});
	} 
	function getFriend(emp_no, findID) {
		$('#friendResult').html('<thead><tr><th><h4>검색결과</h4></th></tr></thead><tbody><tr>' +
				'<td style="text-align: center;"><h3>사번 :' + emp_no +"&nbsp;&nbsp; 이름 : " + findID +'</h3><a href="/chat/messengerChat?toID=' + findID +
				'" class="btn btn-primary pull-right">메신저보내기</a></td>'+
				'</tr></tbody>');
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
	<div class="container">
		<div>
			<button class="btn btn-primary" onclick="location.href='/chat/messengerUnread'">안읽은메신저 보관함으로 이동</button>
		</div>
	
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2"><h4>검색으로 사용자찾기</h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 110px;"><h5>사용자아이디</h5></td>
					<td><input class="form-control" type="text" id="findID" maxlength="20" placeholder="찾을 아이디를 입력하세요."></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right" onclick="findFunction();">검색</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<table id="friendResult" class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd">
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
				<div class="modal-content <%if (messageType.equals("오류메세지"))
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
	<!-- 로그인시 아래 js 실행 -->
 	<%
		if(emp_no != null){
	%>
	<script src="/resources/chatMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var emp_name = '<%=emp_name%>';
			allUserFunction(emp_name);
			getUnread(emp_name);
			getInfiniteUnread(emp_name);
		});
	</script>
	<%
		}
	%>
</body>
</html>