<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>STARWARE(Groupware)</title>
<script type="text/javascript">
function deleteBoard() {
	var message = confirm("정말로 삭제 하시겠습니까?");
	if(message == true){
		alert("삭제되었습니다.");
	}else{
		return false;
	}
}
</script>
<script src="jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/projectBoard.css">
</head>
<body>
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
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li class="active"><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li><a href="calendar_main.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
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
						<li><a href="logoutaction.jsp">로그아웃</a></li>
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
		<input class="btn btn-primary pull" type="button" value="프로젝트 목록" onclick="location.href='listActionProject.pro';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-primary pull" type="button" value="프로젝트 진행도">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-primary pull" type="button" value="프로젝트 업무 분담">
	</form>
	<hr>
	<div class="container">
		<div class="row">
			<a><h4 id="todolistHeader">통합 프로세스 모델</h4></a>
		</div>
		
		<div class="row">
			<div class="col-sm-4">
				<hr>
				<p id="enter">To do</p>
				
				<p class="inputarea">
					<form action="insertActionProjectBoard.pro" method="post">
					<input type="hidden" name="project_No" value="${project.project_No}">
					<input type="hidden" name="project_Writer" value="${project.project_Writer }"/>
					<input type="hidden" name="project_Board_Position" value="0">
					<input type="text" id="inputText" placeholder="what to do" name="project_Board_Contents"/>
					<input class="btn btn-primary pull" type="submit" value="등록"/>
					</form>
					
					<ul id="todolist">
					
					<c:forEach var="project_board" items="${list }"> 
					<c:if test="${project_board.project_Board_Position == 0 }">
						<li>${project_board.project_Board_Contents }</li>
						<span style="border: solid;"><a href="deleteActionProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}" onclick="return deleteBoard()">삭제</a></span>
						<span style="border: solid;"><a href="updateFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}">수정</a></span>
						<span style="border: solid;"><a href="moveFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}&project_Board_Position=${project_board.project_Board_Position}">이동</a></span>
					</c:if>
					</c:forEach>
					
					</ul>
				</p>
			</div>
			<div class="col-sm-4">
				<hr>
				<p id="enter">Doing</p>
				
				<ul id="doinglist">
				<c:forEach var="project_board" items="${list }">
				<c:if test="${project_board.project_Board_Position == 1 }">
				<li>${project_board.project_Board_Contents }</li>
				<span style="border: solid;"><a href="deleteActionProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}" onclick="return deleteBoard()">삭제</a></span>
				<span style="border: solid;"><a href="updateFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}">수정</a></span>
				<span style="border: solid;"><a href="moveFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}&project_Board_Position=${project_board.project_Board_Position}">이동</a></span>
				</c:if>
				</c:forEach>
				</ul>
			</div>
			
			<div class="col-sm-4">
				<hr>
				<p id="enter">Done</p>
				
				<ul id="donelist">
				<c:forEach var="project_board" items="${list }">
				<c:if test="${project_board.project_Board_Position == 2 }">
				<li>${project_board.project_Board_Contents }</li>
				<span style="border: solid;"><a href="deleteActionProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}" onclick="return deleteBoard()">삭제</a></span>
				<span style="border: solid;"><a href="updateFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}">수정</a></span>
				<span style="border: solid;"><a href="moveFormProjectBoard.pro?project_Board_No=${project_board.project_Board_No }&project_No=${project.project_No}&project_Board_Contents=${project_board.project_Board_Contents}&project_Board_Position=${project_board.project_Board_Position}">이동</a></span>
				</c:if>
				</c:forEach>
				</ul>
			</div>
		</div>
	</div>

	</div>

</body>
</html>