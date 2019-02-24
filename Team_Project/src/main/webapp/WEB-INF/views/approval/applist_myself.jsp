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
				<li class="active"><a href="/approval/applist_alllist">전자결재</a></li>
				<li><a href="/project/projectList">협업지원</a></li>
				<li><a href="/notice/noticeList">공지사항</a></li>
				<li><a href="/attend/attendInsert">출퇴근관리</a></li>
				<li><a href="/emp/empList">인사관리</a></li>
				<li><a href="/schedulePage/">일정관리</a></li>
				<li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul>
				</li>
			</ul>

		</div>
	</nav>
	
	<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="/approval/applist_alllist"
			});
			$('#tab3').click(function() {
				location.href="/approval/applist_result"
			});
		});
	
	</script>  
	
	<div class="container">
		<ul class="nav nav-tabs" role="tablist">
			<li><a id="tab1" role="tab" data-toggle="tab" style="font-size: 11pt; font-weight: bold">전자결재목록</a></li>
			<li class="active"><a id="tab2" href="#applist" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 올린 결재목록</a></li>
			<li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 진행할 결재목록</a></li>
		</ul>
	</div>
	<div class="container" id="applist">
		<h2>내가 올린 결재 목록</h2><br>
	<table class="type04">
	<tr>
		<td>글번호</td>
		<td>문서종류</td>
		<td>제      목</td>
		<td>기안일자</td>
		<td>완료일자</td>
		<td>승인결과</td>
	</tr>
	
		<c:forEach var="Approval" items="${applist_myself}">
			<tr data-app_no="${Approval.APP_NO}", data-app_kind="${Approval.APP_KIND}", data-power_defult="${Approval.POWER_DEFULT}">
				<td>${Approval.APP_NO}</td>
				<td>${Approval.APP_KIND}</td>
				<td>${Approval.APP_TITLE}</td>
				<%-- <a href="detail.bit?seq=${Approval.APP_NO}&app_kind=${Approval.APP_KIND}"></a> --%>
				<td>
					 <fmt:parseDate var="dateString" value="${Approval.APP_STARTDATE}" pattern="yyyy-MM-dd"/>
					 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					 <fmt:parseDate var="dateString" value="${Approval.APP_ENDDATE}" pattern="yyyy-MM-dd"/>
					 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${Approval.APP_SITUATION}</td>
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