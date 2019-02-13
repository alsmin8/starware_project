<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
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
<style>

td{
text-align: center;
}
</style>

</head>
<body>
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
/* 		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("login.jsp");
			return;
		} */
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
				<li class="active"><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
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
	
	<script type="text/javascript">
		$(function() {
			$('#tab2').click(function() {
				location.href="/approval/applist_myself"
			});
			$('#tab3').click(function() {
				location.href="/approval/applist_result"
			});
		});
	
	</script>  
	
	<div class="container">
		<ul class="nav nav-tabs" role="tablist">
			<li class="active"><a id="tab1" href="/approval/applist_alllist" role="tab" data-toggle="tab" style="font-size: 11pt; font-weight: bold">전자결재목록</a></li>
			<li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 올린 결재목록</a></li>
			<li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 진행할 결재목록</a></li>
		</ul>
	</div>
	<div class="container" id="applist">
		<h2>전자결재목록</h2><br>
	<a class=newapproval href="appselectform">새 결재 상신</a>
	<!-- <script type="text/javascript">
	$(document).ready(
			$(function(){
				$(".newapproval").on("click", function(){
					self.location="/approval/appselectform";
				});
			});
	</script> -->
	<table class="type04">
	<tr>
	<td>글번호</td>
	<td>문서종류</td>
	<td>제      목</td>
	<td>기안일자</td>
	<td>완료일자</td>
	<td>결재현황</td>
	<td>기안자</td>
	</tr>
	
	<c:forEach var="Approval" items="${list}">
	<tr>
	<td>${Approval.app_no}</td>
	<td>${Approval.app_kind}</td>
	
	<td><a href="/approval/a?app_no=${Approval.app_no}&app_kind=${Approval.app_kind}">${Approval.app_title}</a></td>
	
	<td>
	 <fmt:parseDate var="dateString" value="${Approval.app_startdate}" pattern="yyyy-MM-dd"/>
	 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
	</td>
	<td>
	 <fmt:parseDate var="dateString" value="${Approval.app_enddate}" pattern="yyyy-MM-dd"/>
	 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
	</td>
	<td>${Approval.app_situation}</td>
	<td>${Approval.emp_no}</td>
	</tr>
	</c:forEach>
	
	</table>
	<br><br>
	
	
	<form action="list.bit" method="post" >
	<input type ="checkbox" name = "check" value = "연차신청서">연차신청서
	<input type ="checkbox" name = "check" value = "지출결의서">지출결의서
	<input type ="checkbox" name = "check" value = "기안서">기안서
	<br>
	<input type ="checkbox" name = "time" value = "approval_time">기간
	<input type ="date" name = "time" value = "app_startdate">~
	<input type ="date" name = "time" value = "app_enddate">
	<br>
	<input type="radio" name="app_situation" value="결재요청">결재요청
	<input type="radio" name="app_situation" value="결재중">결재중
	<input type="radio" name="app_situation" value="반려">반려
	<input type="radio" name="app_situation" value="승인">승인
	
<!-- 	<input type ="checkbox" name = "vd_title" value = "vd_title">제목
	<input type ="text" name = "searchKey" size = "10"></input> -->
	
	<!-- <input type ="text" name = "searchKey" size = "10"></input> -->
	<br><input type = "submit" value = "검색">
	
	</form>
	
	
	</div>
	
	
</body>
</html>