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
				<li><a href="/loginafter">메인</a></li>
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
						<li><a href="/logoutaction">로그아웃</a></li>
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
			$('#tab2').click(function(){
				location.href="attendEmpRecord";
			})
			$('#tab3').click(function() {
				location.href="attendTotalRecord"
			});
		});
	
	</script>   
	</div>
		<div id="empRecordTab" class="container">
	
<h3>${emp_name } 사원님의 출퇴근 기록지</h3>

<form method="post" id="searchForm">
<br>	
	<input type="hidden" name="emp_no" value="<%=emp_no%>">
	
	<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
		<tbody>
		<tr>
		<td style="width:110px"><h5>조회기간</h5></td>
		<td style="text-align: left">
		<input type="text" name="year" size="5" placeholder="YYYY">년
		<input type="text" name="month" size="3" placeholder="MM">월
		&nbsp;<button type="submit" class="btn btn-default">조회</button>
		</td>
		<tr>
		</tbody>
		</table>

</form>



<script type="text/javascript">
$(document).ready(function(){
	var searchForm=$("#searchForm");

	var emp_no=searchForm.find("input[name='emp_no']").val();
	
	console.log("emp_no:"+emp_no);
	
	
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		
	var year=searchForm.find("input[name='year']").val();
	var month=searchForm.find("input[name='month']").val();
	var allData={"emp_no" : emp_no, "year" : year, "month" : month};

		//console.log(allData);
		
		$.ajax({
			url : '/attend/listEmpRecord',
			data : allData,
			type : 'POST',
			dataType :"json",
			success : function(result){
				$('#record-tbl > tbody').empty();
				$.each(result, function(index, item){
			
					if(item.emp_no==emp_no){
						
						//퇴근값 null 인 경우
						if(item.attend_endTime==null){
							item.attend_endTime="";
						}
						
						var str="";
						str+='<tbody><tr><td>'+item.emp_name+'</td>';
						str+='<td>'+displayDate(item.attend_date)+'</td>';
						str+='<td>'+item.attend_startTime+'</td>';
						str+='<td>'+item.attend_endTime+'</td>';
						str+='<td>'+lateCheck(item.attend_startTime)+'</td></tr></tbody>';
							
					}
					$('#record-tbl').append(str);	
				});
			}
		}) //ajax 끝
})

});


</script>

<script>

// 날짜 필요 없는 거 제거
function displayDate(timeValue) {
	var today = new Date();
	var gap = today.getTime() - timeValue;
	var dateObj = new Date(timeValue);
		
	var yy = dateObj.getFullYear();
	var mm = dateObj.getMonth() + 1;
	var dd = dateObj.getDate();
	
	return [yy, '/',(mm > 9 ? '' : '0') + mm, '/',(dd > 9 ? '' : '0') + dd].join('');
};


//지각 여부 체크
function lateCheck(StringValue){

		var hourCheck=StringValue.substring(0,2);
		var minuteCheck=StringValue.substring(3,5);
		var hourMinute=Number(hourCheck)+minuteCheck;
		
		if(hourMinute>=901){
			var lateCheck="지각";
		}else{
			var lateCheck="";
		}
		return lateCheck;
};

</script>


<table id="record-tbl" class="type04">
<thead>
<tr>
	<td><b>사원명</b></td>
	<td><b>날짜</b></td>
	<td><b>출근시각</b></td>
	<td><b>퇴근시각</b></td>
	<td><b>지각여부</b></td>
</tr>
</thead>
	 

</table>

</div>

</body>
</html>