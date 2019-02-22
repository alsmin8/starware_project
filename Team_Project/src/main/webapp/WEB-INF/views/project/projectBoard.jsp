<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/resources/css/projectBoard.css">
</head>
<body oncontextmenu="return false">
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/login">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/loginafter">메인</a></li>
            	<li><a href="/approval/applist_alllist">전자결재</a></li>
            	<li class="active"><a href="/project/projectList">협업지원</a></li>
            	<li><a href="/notice/noticeList">공지사항</a></li>
            	<li><a href="/attend/attendInsert">출퇴근관리</a></li>
            	<li><a href="/emp/empList">인사관리</a></li>
            	<li><a href="/schedulePage/">일정관리</a></li>
            	<li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>
			<%
				if (emp_no == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="main.jsp">로그인</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>

	<div class="container">

		<h3 align="center">프로젝트 게시판</h3>
		<hr>
		<div align="center">
			<form>
				<input class="btn btn-primary pull" type="button" value="프로젝트 목록" onclick="location.href='/project/projectList';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="btn btn-primary pull" type="button" value="프로젝트  상세보기" onclick="location.href='/project/projectDetail?project_No=${project.project_No}';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="btn btn-primary pull" type="button" value="프로젝트 진행도">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="btn btn-primary pull" type="button" value="프로젝트 업무 분담">
			</form>
			<hr>
			<div class="container">
				<div class="row">
					<a><h2 id="todolistHeader">To Do List</h2></a>
				</div>

				<div class="row">
					<div class="col-sm-4">
						<hr>
						<p id="enter">To do</p>

						<p class="inputarea">
						
						<input type="text" id="inputText" placeholder="what to do" name="project_Board_Contents" /> 
						<input id="addboard" class="btn btn-primary pull" type="button" value="등록"/>

						<ul id="todolist">
							
						</ul>
						</p>
					</div>
					<div class="col-sm-4">
						<hr>
						
						<p id="enter">Doing</p>
								
						<ul id="doinglist">
							
						</ul>
					</div>

					<div class="col-sm-4">
						<hr>
						
						<p id="enter">Done</p>

						<ul id="donelist">
							
						</ul>
					</div>
				</div>
			</div>

		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">PROJECT BOARD MODAL</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Content</label> <input class="form-control" name='project_Board_Contents' value='New Contents!!!!'>
						</div>
						<div class="form-group">
							<label>Writer</label> <input class="form-control" name='project_Board_Writer' value='project_Board_Writer'>
						</div>
						<!-- <div class="form-group">
							<label>Content Date</label> <input class="form-control" name='project_Board_Regdate' value='2018-01-01 13:13'>
						</div> -->

					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
						<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
						<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<script type="text/javascript" src="/resources/js/projectboard.js"></script>
		<script>
			console.log("=================");
			console.log("JS TEST");

			$(document).ready(function() {
				
				var project_noValue = '<c:out value="${project.project_No}"/>';
				var project_writerValue = '<c:out value="${project.project_Writer}"/>';
				var todolist = $("#todolist");
				
				showList(1);
				
				function showList() {
					
					projectboardservice.getList({project_No:project_noValue}, function(list) {
						
						var str = "";
						var str2 = "";
						var str3 = "";
						if(list == null || list.length == 0){
							todolist.hmtl("");
							
							return;
							
						}

						for(var i=0, len = list.length || 0; i < len; i++){
							if(list[i].project_Board_Position == 0){
								str += "<li data-project_Board_No='"+list[i].project_Board_No+"' data-project_Board_Postion='"+list[i].project_Board_Position+"'>" + list[i].project_Board_Contents + "</li>";
							}else if(list[i].project_Board_Position == 1){
								str2 += "<li data-project_Board_No='"+list[i].project_Board_No+"' data-project_Board_Postion='"+list[i].project_Board_Position+"'>" + list[i].project_Board_Contents + "</li>";
							}else if(list[i].project_Board_Position == 2){
								str3 += "<li data-project_Board_No='"+list[i].project_Board_No+"' data-project_Board_Postion='"+list[i].project_Board_Position+"'>" + list[i].project_Board_Contents + "</li>";
							}
							
						}
						
						todolist.html(str);
						doinglist.html(str2);
						donelist.html(str3);
					})
					
				}
				
				$("#addboard").on("click",function(e){
					
					var inputText = $("#inputText");
					
					var board = {
						project_No : project_noValue,
						project_Board_Writer : project_writerValue,
						project_Board_Contents : inputText.val(),
						project_Board_Position : 0
					};
					
					projectboardservice.add(board, function(result) {
						
						alert(result);
						
						inputText.val("");
						
						showList(1);
					});
					
				});
				
				var modal = $(".modal");
				var modalInputContents = modal.find("input[name='project_Board_Contents']");
				var modalInputWriter = modal.find("input[name='project_Board_Writer']");
				
				var modalModBtn = $("#modalModBtn");
				var modalRemoveBtn = $("#modalRemoveBtn");
				var modalCloseBtn = $("#modalCloseBtn");
				
				$("#todolist").on("click", "li", function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					projectboardservice.get(project_Board_No, function(board) {
						
						modalInputContents.val(board.project_Board_Contents);
						modalInputWriter.val(board.project_Board_Writer).attr("readonly","readonly");
						modal.data("project_board_no", board.project_Board_No);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
						
					})
				})
				
				$("#doinglist").on("click", "li", function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					projectboardservice.get(project_Board_No, function(board) {
						
						modalInputContents.val(board.project_Board_Contents);
						modalInputWriter.val(board.project_Board_Writer).attr("readonly","readonly");
						modal.data("project_board_no", board.project_Board_No);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
						
					});
				});
				
				$("#donelist").on("click", "li", function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					projectboardservice.get(project_Board_No, function(board) {
						
						modalInputContents.val(board.project_Board_Contents);
						modalInputWriter.val(board.project_Board_Writer).attr("readonly","readonly");
						modal.data("project_board_no", board.project_Board_No);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
						
					});
				});

				modalModBtn.on("click", function(e) {
					var board = {project_Board_No : modal.data("project_board_no"), project_Board_Contents: modalInputContents.val()};
				
				projectboardservice.update(board, function(result) {
					
					alert(result);
					modal.modal("hide");
					showList(1);
				});
			});
				modalRemoveBtn.on("click", function(e) {
				
					var project_Board_No = modal.data("project_board_no");
					
					projectboardservice.remove(project_Board_No, function(result) {
						
						alert(result);
						modal.modal("hide");
						showList(1);
						
					})
					
				})
				
				$("#modalCloseBtn").on("click", function(e) {

					modal.modal('hide');
				});
				
				var doinglist = $("#doinglist");
				var donelist = $("#donelist");
				
				$("#todolist").on("mousedown","li",function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					if(e.which == 3){
						
						var board = {project_Board_No : project_Board_No, project_Board_Position: 1};
						
						doinglist.html(this);

						projectboardservice.move(board, function(result) {
							
							//alert(result);
							
							showList(1);
						});
						
					}

				});
				
				$("#doinglist").on("mousedown","li",function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					if(e.which == 3){
						
						var board = {project_Board_No : project_Board_No, project_Board_Position: 2};
						
						donelist.html(this);
						
						projectboardservice.move(board, function(result) {
							
							//alert(result);
							
							showList(1);
						});
						
					}

				});
				
				$("#donelist").on("mousedown","li",function(e) {
					
					var project_Board_No = $(this).data("project_board_no");
					
					if(e.which == 3){
						
						var board = {project_Board_No : project_Board_No, project_Board_Position: 0};
						
						todolist.html(this);
						
						projectboardservice.move(board, function(result) {
							
							//alert(result);
							
							showList(1);
						});
						
					}

				});
				
			});

</script>

</body>
</html>
