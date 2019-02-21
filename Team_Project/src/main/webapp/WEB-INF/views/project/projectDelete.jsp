<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
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
		<div align="center">
		<b>정말 삭제하시겠습니까</b> <br><br>
	<button class="btn btn-primary pull" data-oper='delete'>네</button>
	<button class="btn btn-primary pull" data-oper='list'>아니오</button>

</div>

<form id="listAction" action="/project/projectList" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
</form>

<form id="deleteAction" action="/project/projectDelete" method="post">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
</form>

			<!-- Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">starware</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	
	var listAction = $("#listAction");
	var deleteAction = $("#deleteAction");


	$("button[data-oper='list']").on("click", function(e) {
		listAction.find("#project_No").remove();
		listAction.attr("action", "/project/projectList")
		listAction.submit();
	});
	
	$("button[data-oper='delete']").on("click", function(e) {
		deleteAction.attr("action", "/project/projectDelete").submit();
	});

});
</script>
	
	
</body>
</html>