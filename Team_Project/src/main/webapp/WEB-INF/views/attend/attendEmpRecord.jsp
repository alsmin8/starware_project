<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
 <%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			/* response.sendRedirect("login.jsp");
			return; */
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
			  <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/projectList">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li class="active"><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
            <li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
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
	

<!-- Nav tabs -->
<ul class="nav nav-tabs" role="tablist">
  <li><a id="tab1" role="tab" data-toggle="tab" style="font-size:11pt; font-weight:bold">출근/퇴근</a></li>
  <li class="active"><a id="tab2" href="#empRecordTab"  role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">출퇴근 기록지</a></li>
  <li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">근태 기록지(관리자)</a></li>
</ul>
	<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="attendInsert"
			});
			$('#tab3').click(function() {
				location.href="attendTotalRecord"
			});
		});
	
	</script>   
	</div>
		<div id="empRecordTab" class="container">
	
<h3>${emp_name } 사원님의 출퇴근 기록지</h3>

<form action="empRecord.att" method="post">
<br>	
	<input type="hidden" name="emp_no" value="<%=emp_no%>">
	<select name="year">
	<option value="2019">2019</option>
	<option value="2018">2018</option>
	<option value="2017">2017</option>
	<option value="2016">2016</option>
	<option value="2015">2015</option>
	</select> 년
	
	<select name="month">
	<option value="01">01</option>
	<option value="02">02</option>
	<option value="03">03</option>
	<option value="04">04</option>
	<option value="05">05</option>
	<option value="06">06</option>
	<option value="07">07</option>
	<option value="08">08</option>
	<option value="09">09</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	</select> 월
	<input type="submit" value="검색">
</form>


<br>
<br>


<table class="type04">
<tr>
	<td>사원명</td>
	<td>날짜</td>
	<td>출근시각</td>
	<td>퇴근시각</td>
	<td>지각여부</td>
	<td>결근여부</td>	
	
<%-- 	<c:if test="${li.search.year }!=null">${li.search.year }년</c:if>
	<c:if test="${li.search.month }!=null">${li.search.month }월의 기록입니다</c:if>
	 --%>
	<c:forEach var="li" items="${list}">
		<tr>
			<td>${li.emp_name }</td>
			<td>
			<fmt:parseDate var="dateString"
							value="${li.attend_date}" pattern="yyyy-MM-dd" /> <fmt:formatDate
							value="${dateString}" pattern="yyyy-MM-dd" />
			</td>
			<td>${li.attend_startTime}</td>
			<td>${li.attend_endTime }</td>
			<td>
			<c:set var="check" value="${fn:substring(li.attend_startTime, 0,2) }${fn:substring(li.attend_startTime, 3,5) }"></c:set>
					<fmt:parseNumber var="timeCheck" value="${check }"></fmt:parseNumber>
					<c:set var="checkNum" value="901"/>
					<c:if test="${timeCheck >=checkNum }">지각</c:if>
			
			</td>
			<td> </td>
		</tr>
	
	</c:forEach>
	 
</table>

</div>

</body>
</html>