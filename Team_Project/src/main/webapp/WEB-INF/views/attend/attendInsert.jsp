<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>

<style>

.formRegion{
  text-align:center;
}
.formRegion:before{
  content:'';
  height:100%;
  display:inline-block;
  vertical-align:middle;
}
button{
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:60px;
  font-size:1.6em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
button:hover{
  background:#fff;
  color:#1AAB8A;
}
button:before,button:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
}
button:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
button:hover:before,button:hover:after{
  width:100%;
  transition:800ms ease all;
}


</style>
</head>
<body onload="showClock()">
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
		}
	%>
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

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="/loginafter">메인</a></li>
			<li><a href="/approval/applist_alllist">전자결재</a></li>
			<li><a href="/project/projectList">협업지원</a></li>
			<li><a href="/notice/noticeList">공지사항</a></li>
			<li class="active"><a href="/attend/attendInsert">출퇴근관리</a></li>
			<li><a href="/emp/empList">인사관리</a></li>
			<li><a href="/schedule/scheduleMain">일정관리</a></li>
			<li><a href="/chat/messengerFind">메세지함<span id="unread"
					class="label label-info"></span></a></li>
		</ul>

		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="buton" aria-haspopup="true"
				aria-expanded="false">회원관리<span class="caret"></span>
			</a>
				<ul class="dropdown-menu">
					<li><a href="/logoutaction">로그아웃</a></li>
				</ul></li>
		</ul>

	</div>
	</nav>

	<div class="container">
		<ul class="nav nav-tabs" role="tablist">
				<li class="active"><a id="tab1" href="#attendTab" role="tab"
				data-toggle="tab" style="font-size: 11pt; font-weight: bold">출근/퇴근</a></li>
				<li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold"
				style="font-size: 11pt; font-weight: bold">출퇴근 기록지</a></li>
			   <c:if test="${emp_no==12301 }">
  	<li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold"
				style="font-size: 11pt; font-weight: bold">근태 기록지(관리자)</a></li>
  </c:if>			
		</ul>
		<script type="text/javascript">
			$(function() {
				$('#tab1').click(function() {
					location.href = "attendInsert"
				});
				$('#tab2').click(function() {
					location.href = "attendEmpRecord";
				})
				$('#tab3').click(function() {
					location.href = "attendTotalRecord"
				});
			});
		</script>
	</div>
	<div class="container" id="attendTab">

		<h3>출퇴근 기록부</h3>
		<br>
		<br>
		<center>
			<h4>${emp_name } 사원님,</h4>
			<div id="divClock" class="clock"></div>
			<br>
		</center>
		
		<div class="formRegion">
			<form id="insertForm">
				<input type="hidden" name="emp_no" value="<%=emp_no%>">
				<!-- <input type="hidden" name="attend_date">
<input type="hidden" name="attend_startTime">
<input type="hidden" name="attend_endTime">
-->
				<button class="InsertButton" id="attButton" type="submit">출근</button>
			</form>
			<br>
			<br>


			<form id="leaveForm">
				<input type="hidden" name="emp_no" value="<%=emp_no%>"> <input
					type="hidden" name="attend_startTime"> <input type="hidden"
					name="attend_endTime">
				<button class="InsertButton" id="leaveButton" type="submit">퇴근</button>
			</form>
		</div>



	</div>


	<script>
		$(document).ready(
				function(e) {
					var attendForm = $("#insertForm");
					var leaveForm = $("#leaveForm");

					var emp_no = leaveForm.find("input[name='emp_no']").val();
					var attend_date = $("attend_date").val();
					var attend_startTime = leaveForm.find(
							"input[name='attend_startTime']").val();
					var attend_endTime = leaveForm.find(
							"input[name='attend_endTime']").val();

					var allData = {
						"emp_no" : emp_no,
						"attend_date" : attend_date,
						"attend_startTime" : attend_startTime,
						"attend_endTime" : attend_endTime
					};

					$("#attButton").on("click", function(e) {
						e.preventDefault();

						$.ajax({
							url : '/attend/attendAction',
							data : allData,
							type : 'POST',
							success : function(result) {
								//alert(result);
								var attendContents=$('#attendContents').text(result);
								$('#attendModal').modal();
 							}
						});
					})

					$("#leaveButton").on("click", function(e) {
						e.preventDefault();

						$.ajax({
							url : '/attend/leaveAction',
							data : allData,
							type : 'POST',
							success : function(result) {
								//alert(result);
								var attendContents=$('#attendContents').text(result);
								$('#attendModal').modal();
							}
						});
					})
				})
	</script>

	<script>
		function showClock() {
			var currentDate = new Date();
			var divClock = document.getElementById("divClock");
			var apm = currentDate.getHours();
			if (apm < 12) {
				apm = "오전";
			} else {
				apm = "오후";
			}
			var minute = currentDate.getMinutes();
			var second = currentDate.getSeconds();
			minute = checkTime(minute);
			second = checkTime(second);
			var msg = "<h4>현재 시각은 " + apm + " " + currentDate.getHours() + "시 ";
			msg += minute + "분 ";
			msg += second + "초 입니다.</h4>";

			divClock.innerHTML = msg;

			setTimeout(showClock, 1000);
		}

		function checkTime(i) {
			if (i < 10) {
				i = "0" + i
			}
			; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
			return i;
		}
	</script>

<!-- Modal  추가 -->
	<div class="modal fade" id="attendModal" tabindex="-1" role="dialog"
		aria-labelledby="attendModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="attendModalLabel">확인 메시지</h4>
				</div>
				<div class="modal-body" id="attendContents"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->






</body>
</body>
</html>