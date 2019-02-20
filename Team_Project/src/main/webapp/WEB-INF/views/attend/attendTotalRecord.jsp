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
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.pagination ul {
	list-style:none;
	float:left;
	display:inline;
}
.pagination ul li {
	float:left;
}
.pagination ul li a {
	float:left;
	padding:4px;
	margin-right:3px;
	width:30px;
	color:#000;
	font:bold 12px tahoma;
	border:1px solid #eee;
	text-align:center;
	text-decoration:none;
}
.pagination ul li a:hover, ul li a:focus {
	color:#fff;
	border:1px solid #4d86d1;
	background-color:#4d86d1;
}
</style>

<script>

//데이트 피커 날짜 제한

	$(function() {
		$("#from").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
	$(function() {
		$("#to").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>
</head>
<body>

<%-- 	<%
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
	%> --%>
	
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

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
  <li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">출퇴근 기록지</a></li>
  <li class="active"><a id="tab3" href="#attendTotalTab" role="tab" data-toggle="tab" font-weight="bold" style="font-size:11pt; font-weight:bold">근태 기록지(관리자)</a></li>
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
		<div id="attendTotalTab" class="container">



		<h3>근태 일람표</h3>
		<br>
		<br>
		<br>
		<form id="searchForm" action="/attend/attendTotalRecord" method="post" onsubmit="return checkForm();">
		<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
		<tbody>
			<tr>
			<td style="width:110px"><h5>사원명</h5></td>
			<td style="text-align: left">
				<input type="text" name="searchName" size="6" value='<c:out value="${attendModel.attcri.searchName}"/>' />
				 <button type="submit" class="btn btn-default">조회</button>
			</td>
			</tr>
			<tr>
			<td style="width:110px"><h5>기간</h5></td>
			<td style="text-align: left">
				시작일 <input type="text" id="from" name="from" value='<c:out value="${attendModel.attcri.from}"/>' />
				 ~ 종료일 <input type="text" id="to" name="to" value='<c:out value="${attendModel.attcri.to 
				 }"/>' />
			<input type='hidden' name='pageNum' value='<c:out value="${attendModel.attcri.pageNum}"/>' />
			<input type='hidden' name='amount'	value='<c:out value="${attendModel.attcri.amount}"/>' />
				 <button type="submit" class="btn btn-default">조회</button>
			
			</td>
			</tr>
		</tbody>
		</table>
		</form>
		
		<script type="text/javascript">
		$(document).ready(function(){
			var searchForm=$("#searchForm");
			
			$("#searchForm button").on("click", function(e){
				searchForm.find("input[name='pageNum']").val("1"); //1페이지 설정
				e.preventDefault();
			
				searchForm.submit();
				
				
			});
			
			
		});
		</script>
		
		<script>
		function checkForm(){
			var searchForm=$("#searchForm");
			var from=searchForm.find("input[name='from']").val();
			var to=searchForm.find("input[name='to']").val();
			
				if(from.length===0&&to.length>=2){
					window.alert('시작일을 정확히 입력해야 합니다.');
					return false;
				}
				if(to.length===0&&from.length>=2){
					window.alert('종료일을 정확히 입력해야 합니다.');
					return false;
				}
		}
		</script>
		
		
		
		
		

		<table class="type04">
			<tr>
				<td><b>사원명</b></td>
				<td><b>날짜</b></td>
				<td><b>출근시간</b></td>
				<td><b>퇴근시간</b></td>
				<td><b>지각여부</b></td>
			</tr>
			<c:forEach var="attend" items="${total }">
				<tr>
					<td>${attend.emp_name }</td>
					<td><fmt:parseDate var="dateString"
							value="${attend.attend_date}" pattern="yyyy-MM-dd" /> <fmt:formatDate
							value="${dateString}" pattern="yy-MM-dd" /></td>
					<td>${attend.attend_startTime }</td>
					<td>${attend.attend_endTime }</td>
					<td>
					<c:set var="check" value="${fn:substring(attend.attend_startTime, 0,2) }${fn:substring(attend.attend_startTime, 3,5) }"></c:set>
					<fmt:parseNumber var="timeCheck" value="${check }"></fmt:parseNumber>
					<c:set var="checkNum" value="901"/>
					<c:if test="${timeCheck >=checkNum }">지각</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<br> <br>

		<!-- 페이지처리 영역 -->
		<div class="pagination">
			<ul>
				<c:if test="${attendModel.prev}">
					<li class="paginate_button previous"><a
						href="${attendModel.startPage -1}"><</a></li>
				</c:if>

				<c:forEach var="num" begin="${attendModel.startPage}"
					end="${attendModel.endPage}">
					<li class="paginate_button  ${attendModel.attcri.pageNum == num ? "active":""} ">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${attendModel.next}">
					<li class="paginate_button next"><a
						href="${attendModel.endPage +1 }">></a></li>
				</c:if>
			</ul>
		</div>


	
	<form id='attendAction' action='/attend/attendTotalRecord' method='get'>
	<input type="hidden" name="pageNum" value='${attendModel.attcri.pageNum }'>
	<input type="hidden" name="amount" value='${attendModel.attcri.amount }'>
	<input type='hidden' name='searchName' value='<c:out value="${ attendModel.attcri.searchName }"/>'>
	<input type='hidden' name='from' value='<c:out value="${ attendModel.attcri.from }"/>'>
	<input type='hidden' name='to' value='<c:out value="${ attendModel.attcri.to }"/>'>
	</form>




	</div>

<!-- 페이징 처리 액션 처리 -->
<script type="text/javascript">
$(document).ready(function(){
	
	var actionForm=$("#attendAction");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	
});


</script>





</body>
</html>