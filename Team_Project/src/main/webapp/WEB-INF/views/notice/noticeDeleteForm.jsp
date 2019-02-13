<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
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

</head>
<body>

	<%-- <%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("login.jsp");
			return;
		}
	%> --%>
	
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
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li class="active"><a href="noticeList">공지사항</a></li>
				<li><a href="../attend/attendInsert">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li><a href="calendar_main.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
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
<br><br><br>
<h4 align="center">삭제하시겠습니까?</h4>

<br>
<div align="center">
	<button data-oper='delete'>&nbsp;&nbsp예&nbsp;&nbsp</button>
	<button data-oper='list'>아니오</button>

</div>

<form id="listAction" action="notice/noticeList" method="get">
	<input type='hidden' name='notice_no' id='notice_no' value='<c:out value="${notice.notice_no }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${ncri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
</form>

<form id="deleteAction" action="notice/noticeDelete" method="get">
	<input type='hidden' name='notice_no' id='notice_no' value='<c:out value="${notice.notice_no }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${ncri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
</form>


</div>


<script type="text/javascript">
$(document).ready(function() {
	var listAction = $("#listAction");
	var deleteAction = $("#deleteAction");


	$("button[data-oper='list']").on("click", function(e) {
		listAction.find("#notice_no").remove();
		listAction.attr("action", "/notice/noticeList")
		listAction.submit();
	});
	
	$("button[data-oper='delete']").on("click", function(e) {
		deleteAction.attr("action", "noticeDelete").submit();
	}); 

	
	

});


</script>




</body>
</html>