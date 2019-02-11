<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>STARWARE(Groupware)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/jquery.datetimepicker.css" >
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<script type="text/javascript" src="/resources/jquery.js"></script>
<script type="text/javascript" src="/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">
	$('#datetimepicker1').datetimepicker({});
	$('#datetimepicker2').datetimepicker({});
</script>
</head>

<body>
	<!-- head start -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expended="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="">메인</a></li>
				<li><a href="">전자결재</a></li>
				<li><a href="">협업지원</a></li>
				<li><a href="">공지사항</a></li>
				<li><a href="">출퇴근관리</a></li>
				<li><a href="">인사관리</a></li>
				<li class="active"><a href="calendar.jsp">일정관리</a></li>
				<li><a href="">메세지함</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="buton" aria-haspopup="true" aria-expanded="false">회원관리
					<span class="caret"></span></a>
					<ul class="dropdown-menu">
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<!-- body start -->
	<div class="container">

	<h3>일정 관리 </h3>
	<hr>
	<!-- tabs start -->
		<ul class="nav nav-tabs" role="tablist">
  			<li><a id="tab1" role="tab" data-toggle="tab" style="font-size:11pt; font-weight:bold">캘린더 보기</a></li>
  			<li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">목록 보기</a></li>
  			<li class="active"><a href="#newtab" id="tab3"  role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">일정 등록</a></li>
		</ul>
	
	<!-- tabs content start -->
	<div class="tab-content">
  		<div class="tab-pane" id="calendartab"></div>
  		<div class="tab-pane" id="listtab"></div>
  		<div class="tab-pane active" id="newtab">
  		<br>
  			<form action="insertActionSchedule.sche" method="post" class="form-horizontal">
  				<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="3"><h4>일정 등록</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 110px;"><h5>사원ID</h5></td>
							<td colspan="2"><input class="form-control" type="text" name="writer" maxlength="20" value="${emp_no}"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>제목</h5></td>
							<td colspan="2"><input class="form-control" type="text" name="title" maxlength="20" placeholder="일정명을 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>시작일</h5></td>
							<td colspan="2"><input class="form-control" type="text" id='datetimepicker1' name="starttime" maxlength="20" placeholder="시작일을 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>종료일</h5></td>
							<td colspan="2"><input class="form-control" type="text" id='datetimepicker2' name="endtime" maxlength="20" placeholder="종료일을 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>파일 첨부</h5></td>
							<td colspan="2"><input type="file" name="file" maxlength="20" ></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>내용</h5></td>
							<td colspan="2"><textarea maxlength="20" name="contents" class="form-control" placeholder="내용을 입력하세요"></textarea></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>참여자</h5></td>
							<td colspan="2" class="attendees-group" ></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>참여자 검색</h5></td>
							<td colspan="2" onkeyup="startSuggest()">
								<input class="form-control" type="text" maxlength="20" id="temp">
								<div id="suggest"><div id="suggestList" class="form-control" style="background-color:white;overflow-y:scroll;position:absolute;text-align:left;width:66.7%;height:80px"></div></div>
							</td>
						</tr>
						
						
						<tr>
							<td style="text-align: left" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"/> </td>
						</tr>
						
					</tbody>
				</table>
				
</form>

</div>

</div>

</div>

	 <br> <br><br>	
	
</body>
</html>