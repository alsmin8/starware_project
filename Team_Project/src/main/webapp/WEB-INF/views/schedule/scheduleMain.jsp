<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>STARWARE(Groupware)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<script type="text/javascript" src="/resources/jquery.js"></script>
<script type="text/javascript" src="/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<!-- <script type="text/javascript" src="/resources/js/calendar_main_perform.js"></script> -->
<style>
table {
	table-layout: fixed;
	border-spacing: 0px;
}

.new {
	text-align: center;
	background-color: #5858FA;
	color: white;
	margin-top: 2px;
	margin-bottom: 2px;
	border-color: #5858FA;
	border-radius: 5px;
}

.new>a {
	color: white;
}
</style>
<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	if (strYear != null) {
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	} 

	//년도, 월 셋팅
	cal.set(year, month, 1);
	int startday = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;

	//오늘 날짜 저장
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>
</head>
<body>

	<!-- 메인 메뉴 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li class="active"><a href="scheduleMain.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="buton" aria-haspopup="true" aria-expanded="false">
						회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>


	<!-- tab -->
	<div class="container">

		<h3>일정 관리</h3>
		<hr>
		<ul class="nav nav-tabs" role="tablist">
			<li class="active"><a id="tab1" href="#calendartab" role="tab" data-toggle="tab" style="font-size: 11pt; font-weight: bold">
					캘린더	보기</a></li>
			<li><a id="tab2" href="#listtab" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">
					목록 보기</a></li>
			<li><a id="tab3" href="#newtab" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">
					일정 등록</a></li>
		</ul>


		<!-- tab 내용 -->
	<div class="tab-content">
		<div class="tab-pane active" id="calendartab">
			<form name="calendarFrm" id="calendarFrm" action="" method="post">
				<div id="content">

				<!-- 캘린더 네비게이션 -->
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr><td align="left">
						<input type="button" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="오늘" />
					</td>
					<td align="center" style="font-size: 13pt; font-weight: bold">
						
						<!-- 이전해 -->
						<a id="mth" name=<%=month+1 %> href="<c:url value='/schedule/scheduleMain' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self"> 
							<b>&lt;&lt;</b>&nbsp
						</a> <%if(month > 0 ){ %> 
						
						<!-- 이전달 -->
						<a href="<c:url value='/schedule/scheduleMain' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self"> 
							<b>&lt;</b>
						</a> <%} else {%> <b>&lt;</b> <%} %> &nbsp;&nbsp; <%=year%>년 <%=month+1%>월
									&nbsp;&nbsp; <%if(month < 11 ){ %> 
						
						<!-- 다음달 -->
						<a href="<c:url value='/schedule/scheduleMain' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self"> 
							<b>&gt;</b>&nbsp
						</a> <%}else{%> <b>&gt;</b> <%} %> 
						
						<!-- 다음해 -->
						<a href="<c:url value='/schedule/scheduleMain' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self"> 
							<b>&gt;&gt;</b>
						</a>
					</td>
					
					<!-- day-week-month 버튼 -->
					<td align="right">
						<div class="btn-group">
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="day" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="week" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="month" />
						</div>
					</td>
					</tr>
				</table>
				
				<!-- 캘린더 컨텐츠 -->
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-bordered" style="border-collapse: collapse;">
					<thead>
					<tr style="font-weight: bold; bgcolor: #E5E5E5">
						<td width='100px'><div align="center"><font color="red">일</font></div></td>
						<td width='100px'><div align="center">월</div></td>
						<td width='100px'><div align="center">화</div></td>
						<td width='100px'><div align="center">수</div></td>
						<td width='100px'><div align="center">목</div></td>
						<td width='100px'><div align="center">금</div></td>
						<td width='100px'><div align="center"><font color="#2E9AFE">토</font></div></td>
					</tr>
					</thead>
					<tbody>
					<tr>
					<%
						for(int index = 1; index < start ; index++ ){
 							out.println("<td >&nbsp;</td>");
  							newLine++;
						}

						for(int index = 1; index <= endDay; index++){
       						String color = "";
       							if(newLine == 0){          
       								color = "RED";
       							}else if(newLine == 6){    
       								color = "#2E9AFE";
       							}else{                     
       								color = "BLACK"; 
       							};
       						String sUseDate = Integer.toString(year); 
       						sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
       						sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
       						
       						int iUseDate = Integer.parseInt(sUseDate);
       						String backColor = "";
       							if(iUseDate == intToday ) {
             						backColor = "#CEE3F6";
       							}

       						out.println("<td class='index' id='" + index + "' style='padding-left:0px; padding-right:0px; margin-left:0px; margin-right:0px' valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");
       						%>
								<font color='<%=color%>'> <%=index %></font>
							<%
								/*    out.println("<br>");
								       out.println(iUseDate);
								       out.println("<br>"); */

       						out.println("</td>");
       						newLine++;

       						if(newLine == 7){
         						out.println("</TR>");
         							if(index <= endDay){
           								out.println("<TR>");
           								}
         							newLine=0;
       							}
							}

						//마지막 공란 LOOP
						while(newLine > 0 && newLine < 7){
  							out.println("<td>&nbsp;</td>");
  							newLine++;
						}
						%>
					</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	
			<div class="tab-pane" id="listtab"><div class="container"></div></div>
			<div class="tab-pane" id="newtab"><div class="container"></div></div>
		</div>
	</div>
</body>
</html>