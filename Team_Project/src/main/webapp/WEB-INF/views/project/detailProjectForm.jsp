<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link rel="stylesheet" href="/resources/css/detailProject.css">

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
	
	<h3 align="center">프로젝트 상세보기</h3>
	<hr>
	<table class="detail" width="1000" border="1" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td>번호</td>
			<td>${project.project_No }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${project.project_Regdate }</td>
		</tr>
		<tr>
			<td>프로젝트 제목</td>
			<td>${project.project_Title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${project.project_Writer }</td>
		</tr>
		<tr>
			<td>담당자</td>
			<td>${project.project_Manager }</td>
		</tr>
		<tr>
			<td>기간</td>
			<td>${project.project_Term }</td>
		</tr>
		<tr>
			<td>계획시작일</td>
			<td>${project.project_Start_Date }</td>
		</tr>
		<tr>
			<td>계획종료일</td>
			<td>${project.project_End_Date }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${project.project_Contents }</td>
		</tr>
<%-- 		<tr>
			<td>첨부파일</td>
			<td><a href="download.jsp?filename=${project.project_File }">${project.project_File }</a></td>
		</tr> --%>

	</table>
	
	
	<button data-oper="update" class="btn btn-primary pull" style="text-align: center">수정하기</button>
	<button data-oper="delete" class="btn btn-primary pull" style="text-align: center">삭제하기</button>
	<button data-oper="list" class="btn btn-primary pull" style="text-align: center">목록</button>

	
	<form id='listAction' action="project/listProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	</form>
	
	<form id='deleteFormAction' action="project/deleteProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	</form>
	
	<form id='updateFormAction' action="project/updateProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	</form>
	
	<script type="text/javascript">
$(document).ready(function() {
	var listAction = $("#listAction");
	var updateFormAction = $("#updateFormAction");
	var deleteFormAction = $("#deleteFormAction");

	$("button[data-oper='update']").on("click", function(e) {
		updateFormAction.attr("action", "/project/updateProjectForm").submit();
	}); 

	$("button[data-oper='list']").on("click", function(e) {
		listAction.find("#project_No").remove();
		listAction.attr("action", "/project/listProjectForm")
		listAction.submit();
	});
	
	$("button[data-oper='delete']").on("click", function(e) {
		deleteFormAction.attr("action", "/project/deleteProjectForm").submit();
	}); 

	
	

});


</script>
	
	</div>
	
	
</body>
</html>