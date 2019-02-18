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
				<li><a href="/schedule/scheduleMain">일정관리</a></li>
				<li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
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
						<li><a href="/login">로그인</a></li>
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
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
	
	 <%
		String app_kind = request.getParameter("app_kind");
	%> 
	
	<form role="form" action="/approval/appinsertdraftform" method="post">
		 <input type="hidden" name="app_kind" value="<%=app_kind%>"> 
		<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="4"><h4>기 안 서</h4></th>
					</tr>
			<tr>
				<td style="width: 110px;">이 름</td>
				<td><input  class="form-control" type="text" name="emp_name" value=${emp_name}></td>
				<td style="width: 110px;">사 번</td>
				<td><input type="text" name="emp_no" value=${emp_no}></td>
			</tr>
			<tr>
				<td style="width: 110px;">부 서</td>
				<td><input  class="form-control" type="text" name="dept_name"></td>
				<td style="width: 110px;">직 급</td>
				<td><input  class="form-control" type="text" name="grade_name"></td>
			</tr>
			<tr>
				<td style="width: 110px;">제 목</td>
				<td colspan="3"><input  class="form-control" type="text" name="app_title" size="80"></td>
			</tr>
			<tr>
				<td style="width: 110px;">내 용</td>
				<td colspan="3" rowspan = "5"><textarea  class="form-control" rows="10" cols="90" name="dd_contents"></textarea>
			</tr>	
		</table>
		<div class="container">
			<label id="add-attendee" class="col-sm-2 control-label">결재권자 검색</label>
		  	<div class="attendees-group col-sm-6" name = "search-attendee" onkeyup="startSuggest()">
				<input type="text" class="form-control" id="temp" size="20" placeholder="이름으로 검색"></input>
			</div>
		 	<div id="suggest" class="col-sm-4">
				<div id="suggestList" class="form-control" style="height:100px"></div>
			</div>
		</div>
		<center><input type="submit" value="상신"></center>
	</form>
	</div>
<script type="text/javascript">
function startSuggest(){
	var keyword = $('#temp').val();
	var params = "keyword=" + encodeURIComponent(keyword);
	console.log(keyword);
	console.log(params);
	/* $.ajax({
		type : 'POST',
		url : '/approval2/listJsonEmp',
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
	}); */
}
</script>
	
</body>
</html>