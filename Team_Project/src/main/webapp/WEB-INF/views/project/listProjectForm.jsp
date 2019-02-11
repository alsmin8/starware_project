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
<script src="jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/mainProject.css">

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
	
	<hr>
	<h3 align="center"><a href="listActionProject.pro">프로젝트 목록 보기</a></h3>
	<hr>
	
	<table class="type04">
	
	<tr>
		<td>No</td>
		<td>제목</td>
		<td>작성자</td>
		<td>담당자</td>
		<td>기간</td>
		<td>계획 시작일</td>
		<td>계획 종료일</td>
	</tr>
	
	<c:forEach var="project" items="${projectListModel.list }">
		<tr>
			<td>${project.project_No}</td>
			<td><a href="detailProject.pro?project_No=${project.project_No }">${project.project_Title}</a></td>
			<td>${project.project_Writer}</td>
			<td>${project.project_Manager}</td>
			<td>${project.project_Term }</td>
			<td>${project.project_Start_Date}</td>
			<td>${project.project_End_Date}</td>
		</tr>
	</c:forEach>
	</table>
	<br>
	
	<form style="text-align: center">

	<c:if test="${projectListModel.startPage > 5 }">
		<a href="listActionProject.pro?pageNum=${projectListModel.startPage-5 }">[이전]</a>
	</c:if>

	<c:forEach var="pageNo" begin="${projectListModel.startPage }" end="${projectListModel.endPage }">
		<c:if test="${projectListModel.requestPage == pageNo }"><b></c:if>
		<a href="listActionProject.pro?pageNum=${pageNo }">[${pageNo }]</a>
		<c:if test="${projectListModel.requestPage == pageNo }"></b></c:if>
	</c:forEach>

	<c:if test="${projectListModel.endPage < projectListModel.totalPageCount }">
		<a href="listActionProject.pro?pageNum=${projectListModel.startPage+5 }">[이후]</a>
	</c:if>
	</form>
	<hr>
	<br>
	<hr>
	<form action="listActionProject.pro" method="post" style="text-align: center">
		<input type="checkbox" name="area" value="project_Title">제목
		<input type="checkbox" name="area" value="project_Writer">작성자
		<input type="text" name="searchKey" size="20"></input>
		<input class="btn btn-primary pull" type="submit" value="검색">
	</form>
	
	<hr>
	<form action="insertFormProject.pro" method="post">
	<input class="btn btn-primary pull" type="submit" value="프로젝트 생성하기" >
	</form>
	</div>
	
</body>
</html>