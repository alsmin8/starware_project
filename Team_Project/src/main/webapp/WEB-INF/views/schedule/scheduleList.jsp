<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- profile="http://www.w3.org/2005/10/profile" -->
<head>
<title>STARWARE(Groupware)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/jquery.datetimepicker.css" >
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<script type="text/javascript" src="/resources/jquery.js"></script>
<script type="text/javascript" src="/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script><script type="text/javascript">
		$(function() {
			$('#tab2').click(function() {
				location.href="listActionSchedule.sche"
			});
			
			$('#tab3').click(function() {
				location.href="insertFormSchedule2.jsp"
			});
			$('#mysche').click(function() {
				$.ajax({
					url : 'listJson.sche',
					dataType : 'json',
					success : function(data){
						$('#sche-table tr:not(:first)').remove();
						$.each(data, function(index, item) {
							var member_name = '<%=session.getAttribute("emp_name")%>'
							if(item.emp_name==member_name) {
							var present = item.schedule_regdate.substr(0,10);
							var html = '';
							html += '<tr><td>'+item.schedule_no + '</td>'
							html += '<td>'+ item.emp_no + '</td>'
							html += '<td>'+ item.emp_name + '</td>'
							html += '<td>'+ item.dept_name + '</td>'
							html += '<td>'+ item.schedule_title + '</td>'
							html += '<td>'+ present + '</td>'
							html += '<td>'+ item.schedule_starttime + '</td>'
							html += '<td>'+ item.schedule_endtime + '</td></tr>'
							}
							$('#sche-table').append(html);
							console.log($('#sche-table').text());
						});
						}
				});
			});
		});
		</script>   

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
			response.sendRedirect("login.jsp");
			return;
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
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li class="active"><a href="calendar_main.jsp">일정관리</a></li>
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

<h3>일정 관리 </h3>
<hr>
<!-- Nav tabs -->
<ul class="nav nav-tabs" role="tablist">
  <li><a id="tab1" role="tab" data-toggle="tab" style="font-size:11pt; font-weight:bold">캘린더 보기</a></li>
  <li class="active"><a href="#listtab" id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">목록 보기</a></li>
  <li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">일정 등록</a></li>
</ul>
	
<!-- Tab panes -->
<div class="tab-content">
  <div class="tab-pane" id="calendartab">
  		<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="calendar_main.jsp"
			});
			
			$('#tab3').click(function() {
				location.href="insertFormSchedule2.jsp"
			});
		});
		</script>
</div>

  <div class="tab-pane active" id="listtab">
  <br><br>
	<div class="card" style="border: 1px solid #BDBDBD">
  <div class="card-body" style="padding:16px">
  	<form action="listActionSchedule.sche" method="post">
		<div class="form-inline">
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="schedule_title" >일정명</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="emp_name" >참여자명</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="dept_name" >부서명</label></div>

		<div class="form-group"><div class="col-sm-6">
		<input type="text" class="form-control" name="searchKey" placeholder="키워드 입력">
		</div></div>
		</div>
		<br><div style="height:8px"></div>
		<div class="form-inline">
		<div class="checkbox-inline"><label><input type="checkbox" name="time" value="schedule_time">시간</label></div>
		<div class="form-group"><div class="col-sm-3">
		<input type="text" class="form-control" name="schedule_starttime" id='datetimepicker1' size="20" placeholder="2019/01/17 13:00">
		</div>
  		</div>
  		<div class="form-group"><div class="col-sm-3">
  		<input type="text" class="form-control" name="schedule_endtime" id='datetimepicker2' size="20" placeholder="2019/01/17 18:00">
  		</div>
  		</div>
  		&nbsp&nbsp&nbsp&nbsp&nbsp<input type="submit" value="찾기" class="btn btn-primary">
  		</div>
	</form>
	</div>
	</div>
	<br>
	<div align="left">
		<input type="button" value="내 일정 보기" class="btn btn-default" id="mysche">
<!--   		<input type="button" value="마감일자별" class="btn btn-default">
  		<input type="button" value="사용자별" class="btn btn-default" > -->
  	</div>
	<br>
<table id="sche-table" class="type04" style="text-align:center">
	<tr>
		<td>일정번호</td>
		<td>사원id</td>
		<td>사원명</td>
		<td>부서명</td>
		<td>일정명</td>
		<td>등록일</td>
		<td>시작일</td>
		<td>종료일</td>
	</tr>
		<c:forEach var="i" items="${list}">
		<tr>
			<td>${i.schedule_no}</td>
			<td>${i.emp_no}</td>
			<td>${i.emp_name}</td>
			<td>${i.dept_name}</td>
			<td><a href="detailActionSchedule.sche?schedule_no=${i.schedule_no}&emp_no=${i.emp_no}">${i.schedule_title}</a></td>
			<td>
				<fmt:parseDate var="dateString" value="${i.schedule_regdate}" pattern="yyyy-MM-dd"></fmt:parseDate>
				<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"></fmt:formatDate>
			</td>
			<td>${i.schedule_starttime}</td>
			<td>${i.schedule_endtime}</td>
		</tr>
		</c:forEach>
	</table>
	
	<br><br>

	<script type="text/javascript" src="jquery.datetimepicker.full.min.js"></script>
		<script>
			$('#datetimepicker1').datetimepicker({
			});
			$('#datetimepicker2').datetimepicker({
			});
		</script>
</div>

  <div class="tab-pane" id="newtab">
</div>
</div>
</div>
</body>
</HTML>