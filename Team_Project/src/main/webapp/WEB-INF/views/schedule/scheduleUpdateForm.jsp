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
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="httpRequest.js"></script>
<!-- <script type="text/javascript" src="jquery.min.js"></script> -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="jquery.datetimepicker.css" type="text/css" />
<!-- <script src="https://code.jquery.com/jquery-1.10.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script> 
 --><script type="text/javascript">

	function startSuggest(){
		var keyword = $('#temp').val();
		var params = "keyword=" + encodeURIComponent(keyword);
		
		$.ajax({
			url : 'listJsonEmp.sche',
			type : 'POST',
			data : params,
			dataType : 'json',
			success : function(data){
				var html = "";
				$.each(data, function(index, item) {
					var str = item.dept_name;
					console.log(typeof(str));
					html += "<a href=javascript:select('"  + item.emp_name +"-"+item.dept_name+"-"+item.emp_no + "')>" + item.emp_name +"-"+item.dept_name+"-"+item.emp_no+"</a><br>";
				});
				console.log('성공');
				var suggestList = document.getElementById("suggestList");
				suggestList.innerHTML = html;
				show('suggest');
	        }
		});
	}
	
	function show(elementId){
		var element = document.getElementById(elementId);
		console.log(element);
		if(element){
			element.style.display="";
		}
	}
	
	function select(selectKeyword1){
		selectKeyword = selectKeyword1.substring(selectKeyword1.lastIndexOf('-')+1); 
		hide('suggest');
		$('.attendees-group').append('<div class="checkbox-inline"><label><input type="checkbox" name="attendees" id="person" value="'+ selectKeyword +'">'+selectKeyword1+'<label></div>&nbsp&nbsp');
	}

	function hide(elementId){
		var element = document.getElementById(elementId);
		if(element){
			element.style.display="none";
		}
	}
	
</script> 
		<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="calendar_main.jsp"
			});
			$('#tab2').click(function() {
				location.href="listActionSchedule.sche"
			});
		});
		</script>   
		<script type="text/javascript">
			$(function() {
			test = $('#temp');
/* 			var toplen = test.offset().top; ;
			var leftlen = test.offset().left; */

			$('#suggest').offset({top:test.offset().top+test.height()*2});
			$('#suggest').offset({left:test.offset().left});
		})
	
</script>
<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="calendar_main.jsp"
			});
			
			$('#tab2').click(function() {
				location.href="listActionSchedule.sche"
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
					</ul></li>
			</ul>

		</div>
	</nav>
	
	<div class="container">

<h3>일정 수정 </h3>
<hr>
<!-- Nav tabs -->
<ul class="nav nav-tabs" role="tablist">
  <li><a id="tab1" role="tab" data-toggle="tab" style="font-size:11pt; font-weight:bold">캘린더 보기</a></li>
  <li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">목록 보기</a></li>
  <li class="active"><a href="#newtab" id="tab3"  role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">일정 등록</a></li>
</ul>
	
<!-- Tab panes -->
<div class="tab-content">
  <div class="tab-pane" id="calendartab">
</div>

  <div class="tab-pane" id="listtab">
  <br><br>
</div>

  <div class="tab-pane active" id="newtab">
 <br>
  <form action="updateActionSchedule.sche" method="post" class="form-horizontal">
  <input type="hidden" name="schedule_no" value="${schedule.schedule_no}">
  	<div class="form-group">
  	<div style="float:right; margin-right:400px">
  		<button type="submit" class="btn btn-primary">수정완료</button>
 	 </div>
 	 </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">참여자(사원 id)</label>
    <div class="col-sm-6">
    <c:forEach var="i" items="${list}">
    <c:if test="${i.schedule_no eq schedule.schedule_no}">
    <input type="text" name="emp_no" width="50%" value="${i.emp_no}">${i.emp_name}-${i.dept_name}
    </c:if>
    </c:forEach>
    </div>
    </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label">제목</label>
  <div class="col-sm-6">  
    <input type="text" class="form-control" name="title" value="${schedule.schedule_title}">
  </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label">시작일</label>
  <div class="col-sm-6">
    <input type="text" class="form-control" id='datetimepicker3' name="starttime" value="${schedule.schedule_starttime}">
   </div>
    </div>
 
  <div class="form-group">  
    <label class="col-sm-2 control-label">종료일</label>
    <div class="col-sm-6">
    <input type="text" class="form-control" id='datetimepicker4' name="endtime" value="${schedule.schedule_endtime}">
    </div>
    </div>

  <div class="form-group">
    <label class="col-sm-2 control-label">파일 첨부</label>
    <div class="col-sm-6">
    <input type="file" id="exampleInputFile">
    </div>
  </div>
  
  <div class="form-group">
  <label class="col-sm-2 control-label">내용</label><br>
  <div class="col-sm-6">
    <textarea rows="6" cols="50" name="contents" class="form-control">${schedule.schedule_contents}</textarea>
  </div>
  </div>
  
	<div class="form-inline">
	<label id="add-attendee" class="col-sm-2 control-label">참여자 검색</label>
  	<div class="attendees-group col-sm-6" name = "search-attendee" onkeyup="startSuggest()">
		<input type="text" class="form-control" id="temp" size="20" placeholder="사원이름으로 검색"></input>&nbsp&nbsp
	</div>
	</div>


 	<div id="suggest" class="col-sm-3">
		<div id="suggestList" class="form-control" style="height:100px"></div>
	</div>

</form>

	<script type="text/javascript" src="jquery.datetimepicker.full.min.js"></script>
		<script>
			$('#datetimepicker3').datetimepicker({
			});
			$('#datetimepicker4').datetimepicker({
			});
		</script>

</div>

</div>

</div>

	 <br> <br><br>	
	
</body>
</html>