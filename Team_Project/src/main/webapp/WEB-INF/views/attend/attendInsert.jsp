﻿<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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


input[type="submit"]:hover {
    background-color: #C2D0B7;
}

input[type="submit"] {
  width:100px;
    background-color: #90BE9D;
    border: none;
    color:#fff;
    padding: 15px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    cursor: pointer;
    border-radius:10px;
}

</style>
</head>
<body>
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
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
			  <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/projectList">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li class="active"><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
            <li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

		</div>
	</nav>
	
	<div class="container">
	<ul class="nav nav-tabs" role="tablist">
  <li class="active"><a id="tab1" href="#attendTab" role="tab" data-toggle="tab" style="font-size:11pt; font-weight:bold">출근/퇴근</a></li>
  <li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">출퇴근 기록지</a></li>
  <li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">근태 기록지(관리자)</a></li>
</ul>
	<script type="text/javascript">
		$(function() {
			$('#tab2').click(function() {
				location.href="attendEmpRecord"
			});
			$('#tab3').click(function() {
				location.href="attendTotalRecord"
			});
		});
	
	</script>   
	</div>
	<div class="container" id="attendTab">
	
<h3>출퇴근 기록부</h3> <br><br>
<center>
<h4>${emp_name } 사원님, 현재 시각은 <%= sf.format(nowTime) %> 입니다.</h4><br>
<form id="insertForm">
<input type="hidden" name="emp_no" value="<%=emp_no%>">
<!-- <input type="hidden" name="attend_date">
<input type="hidden" name="attend_startTime">
<input type="hidden" name="attend_endTime">
-->
<button class="InsertButton" id="attButton" type="submit">출근</button>
</form><br><br>


<form id="leaveForm">
<input type="hidden" name="emp_no" value="<%=emp_no%>">
<input type="hidden" name="attend_startTime">
<input type="hidden" name="attend_endTime">
<button class="InsertButton" id="leaveButton" type="submit">퇴근</button>
</form>

</center>
</div>


<script>
$(document).ready(function(e){
	var attendForm=$("#insertForm");
	var leaveForm=$("#leaveForm");
	
	var emp_no=leaveForm.find("input[name='emp_no']").val();
	//var attend_date=$("attend_date").val();
	var attend_startTime=leaveForm.find("input[name='attend_startTime']").val();
	var attend_endTime=leaveForm.find("input[name='attend_endTime']").val();
	
	
	var allData={"emp_no": emp_no , 
			"attend_startTime": attend_startTime,
			"attend_endTime" : attend_endTime
			};
	
	$("#attButton").on("click", function(e){
		e.preventDefault();
		console.log("clicked..");
		
		$.ajax({
			url : '/attend/attendAction',
			data : allData,
			type : 'POST',
			success : function(result){
				alert(result);
			},
			  error:function(jqXHR, textStatus, errorThrown){
		            alert("이미 출근하셨습니다.");
			  }
			
		});
	
	})
	

	$("#leaveButton").on("click", function(e){
		e.preventDefault();
		console.log("clicked...");
		
		$.ajax({
			url : '/attend/leaveAction',
			data : allData,
			type : 'POST',
			success : function(result){
				console.log(result);
				alert(result);
			}
			
			
		});
		
		
		
	})
	
	
})


</script>


<!-- Modal  추가 -->
			<div class="modal fade" id="AttendModal" tabindex="-1" role="dialog"
				aria-labelledby="AttendModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="AttendModalLabel">Modal title</h4>
						</div>
						<div class="modal-body">이미 출근하셨습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
			
<script type="text/javascript">
/* 	$(document).ready(function() {
						var result = '<c:out value="${result}"/>';
						checkModal(result);
						history.replaceState({}, null, null);
						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}
							$("#AttendModal").modal("show");
						}
						$("#regBtn").on("click", function() {
							self.location = "/board/register";
						});
						var actionForm = $("#actionForm");
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});
					
					}); */
</script>






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
</body>
</body>
</html>