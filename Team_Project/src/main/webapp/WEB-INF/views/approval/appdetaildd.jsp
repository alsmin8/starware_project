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
/* #mytable {
width: 100px;
border: 1px solid #ddd !important;
bor
} */
td {
 border: 1px solid #dddddd;
	text-align: center;
}

tr {
 border: 1px solid #dddddd;
	height: 25px;
	width: 100;
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


		<form action="/approval/appdetaildd?app_no=${approval.app_no}&app_kind=${app_kind}" method="post">
			<input type="hidden" name="app_kind" value="<%=app_kind%>">
			<table 
				style="text-align: center; border: 1px solid #dddddd; width: 100%">
				<thead>
					<tr>
						<th colspan="12" ><h4>지 출 결 의 서</h4></th>
					</tr>
				</thead>
				<tr>
					<td colspan="8" style='width:450px; ' rowspan="3"></td>
					<td >결재자2</td>
					<td >결재자2</td>
					<td >결재자3</td>
					<td >상신자</td>
					
				</tr>
				<tr>
					<!-- <td style='height:100px'colspan="8"></td> -->
					<td style='height:100px'>결재자1</td>
					<td >결재자1</td>
					<td >결재자2</td>
					<td >결재자3</td>
					
				</tr>
				<tr>
					<!-- <td colspan="8"></td> -->
					<td>${emp.emp_name }</td>
					<td><%-- ${power.emp_name } --%></td>
					<td><%-- ${power.emp_name } --%></td>
					<td><%-- ${power.emp_name } --%></td>
			
				</tr>			
			</table>
			<table class="table table-bordered"
				style="text-align: center; border: 1px solid #dddddd; ">
				
				<tbody>
					<tr>
						<td colspan="3" >제 목</td>
						<td colspan="9">${approval.app_title }</td>
					</tr>
					<tr>
						<td colspan="3" >이 름</td>
						<td colspan="3">${emp.emp_name }</td>
						<td colspan="3">사 번</td>
						<!-- <td  >사 번</td>
						<td style="border-left: 0">사 번</td> -->
						<td colspan="3" >${emp.emp_no}</td>
					</tr>
					<tr>
						<td colspan="3" >부 서</td>
						<td colspan="3">${dept.dept_name}</td>
						<td colspan="3" >직 급</td>
						<td colspan="3">${grade.grade_name}</td>
					</tr>
					<tr>
						<td colspan="3" >순 번</td>
						<td colspan="3" >사용일자</td>
						<td colspan="3" >사 유</td>
						<td colspan="3" >사용금액</td>
					</tr>
					<tr>
					    <td colspan="3" >${disbursementdoc.d_idx}</td>
						<td colspan="3" >
							 <fmt:parseDate var="dateString" value="${disbursementdoc.d_usingdate}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
							</td>
						<td colspan="3" >${disbursementdoc.d_contents}</td>
						<td colspan="3" >${disbursementdoc.d_amount}</td>
					</tr>
					<tr>
						<td colspan="3" ></td>
						<td colspan="3" ></td>
						<td colspan="3" ></td>
						<td colspan="3" ></td>
					</tr>

					<tr>
						<td colspan="3" >비 고</td>
						<td colspan="9"></td>
					</tr>
				</tbody>

			</table>
			<br>
			<center>
				<a href="/approval/appupdateddform?app_no=${approval.app_no}&app_kind=${approval.app_kind}">수정</a>&emsp;&emsp;&emsp;&emsp;&emsp; 
				<a href="/approval/appdeletedd?app_no=${approval.app_no}">삭제</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<a href="/approval/applist_alllist?app_kind=${appCriteria.app_kind }" align="right">목록</a>
			</center>
		</form>


	</div>
	


</body>
</html>