<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
td {
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
				<li><a href="/schedule/scheduleMain">일정관리</a></li>
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
			$('#tab2').click(function() {
				location.href = "/approval/applist_myself"
			});
			$('#tab3').click(function() {
				location.href = "/approval/applist_result"
			});
		});
	</script>

	<div class="container">
		<ul class="nav nav-tabs" role="tablist">
			<li class="active"><a id="tab1" href="/approval/applist_alllist"
				role="tab" data-toggle="tab"
				style="font-size: 11pt; font-weight: bold">전자결재목록</a></li>
			<li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold"
				style="font-size: 11pt; font-weight: bold">내가 올린 결재목록</a></li>
			<li><a id="tab3" role="tab" data-toggle="tab" font-weight="bold"
				style="font-size: 11pt; font-weight: bold">내가 진행할 결재목록</a></li>
		</ul>
	</div>
	<div class="container" id="applist">
		<h2>전자결재목록</h2>
		<br> <a class=newapproval href="appselectform">새 결재 상신</a>
		
		<ul class="nav navbar-nav navbar-left">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">문서별 검색<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href ="/approval/applist_alllist?app_kind=기안서">기안서</a></li>
						<li><a href ="/approval/applist_alllist?app_kind=지출결의서">지출결의서</a></li>
						<li><a href ="/approval/applist_alllist?app_kind=연차신청서">연차신청서</a></li>
						
					</ul></li>
			</ul>	
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
				<td>제 목</td>
				<td>기안일자</td>
				<td>완료일자</td>
				<td>결재현황</td>
				<td>기안자</td>
			</tr>

			<c:forEach var="Approval" items="${list}">
				<tr>
					<td>${Approval.app_no}</td>
					<td>${Approval.app_kind}</td>

					<td><a
						href="/approval/whichappdetail?app_no=${Approval.app_no}&app_kind=${Approval.app_kind}">${Approval.app_title}</a></td>

					<td><fmt:parseDate var="dateString"
							value="${Approval.app_startdate}" pattern="yyyy-MM-dd" /> <fmt:formatDate
							value="${dateString}" pattern="yyyy-MM-dd" /></td>
					<td><fmt:parseDate var="dateString"
							value="${Approval.app_enddate}" pattern="yyyy-MM-dd" /> <fmt:formatDate
							value="${dateString}" pattern="yyyy-MM-dd" /></td>
					<td>${Approval.app_situation}</td>
					<td>${Approval.emp_name}</td>
				</tr>
			</c:forEach>

		</table>

		<div class='pull-right'>
			<ul class="pagination">

				<c:if test="${appPageMaker.prev}">
					<li class="paginate_button previous">
					<a href="${appPageMaker.startPage -1}">Previous</a>
					</li>
				</c:if>

				<c:forEach var="num" begin="${appPageMaker.startPage}"
					end="${appPageMaker.endPage}">
					<li class="paginate_button ${appPageMaker.appcri.pageNum==num? "active":"" }"><a href="${num}">${num}</a></li>
				</c:forEach>

				<c:if test="${appPageMaker.next}">
					<li class="paginate_button next"><a href="${appPageMaker.endPage+1}">Next</a></li>
				</c:if>
				</ul>
				</div>
				
				<form id="actionForm" action="/approval/applist_alllist" method="get">
				<input type='hidden' name='pageNum' value='${appPageMaker.appcri.pageNum }'>
				<input type='hidden' name='amount' value='${appPageMaker.appcri.amount }'>
				</form>
				
				<script type="text/javascript">
				$(document).ready(function(){
					var actionForm = $("#actionForm");
					$(".paginate_button a").on("click", function(e){
						e.preventDefault();
						console.log('click');
						actionForm.find("input[name='pageNum']").val($(this).attr("href"));
						actionForm.submit();
					})
				})
				</script>
				<br>
				<br>


				<form id="actionForm" action="/approval/applist_alllist" method="get">
					 <!-- <input
						type="checkbox" name="time" value="approval_time">기간 <input
						type="date" name="time" value="app_startdate">~ <input
						type="date" name="time" value="app_enddate"> <br> -->
						<input type="radio" name="app_situation" value="결재요청">결재요청
				    	<input type="radio" name="app_situation" value="결재중">결재중 
						<input type="radio" name="app_situation" value="반려">반려 
						<input type="radio" name="app_situation" value="승인">승인

					<!-- 	<input type ="checkbox" name = "vd_title" value = "vd_title">제목
	<input type ="text" name = "searchKey" size = "10"></input> -->

					<!-- <input type ="text" name = "searchKey" size = "10"></input> -->
					<br>
					<input type='hidden' name='pageNum' value='${appPageMaker.appcri.pageNum }'>
				<input type='hidden' name='amount' value='${appPageMaker.appcri.amount }'>
				<%-- <input type='hidden' name='app_kind' value='${appPageMaker.appcri.app_kind }'> --%>
				<%-- <input type='hidden' name='time' value='${appPageMaker.appcri.time }'>--%>
				<%--  <input type='hidden' name='app_situation' value='${appPageMaker.appcri.app_situation }'> --%>
					
					<input type="submit" value="검색">

				</form>
		</div>
</body>
</html>