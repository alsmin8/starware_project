<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<style>

td{
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
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href=loginafter.jsp>메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="list.jsp">인사관리</a></li>
				<li><a href="calendar_main.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
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
						<li><a href="main.jsp">로그인</a></li>
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
	<form action="detailvacation.bit?seq=${Approval.app_no}" method="post">
	<input type="hidden" name="app_kind" value="<%=app_kind%>">
	<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="4"><h4>기 안 서</h4></th>
					</tr>
				</thead>
			<tr>
				<td style="width: 110px;">제 목</td>
				<td style="width: 110px;" colspan="5">${vacationdoc.vd_title}</td>
			</tr>
			<tr>
				<td style="width: 110px;">이 름</td>
				<td colspan="2">${emp_name }</td>
				<td style="width: 110px;">사 번</td>
				<td colspan="2">${emp_no}</td>
			</tr>
			<tr>
				<td style="width: 110px;">휴가기간</td>
				<td>
				<fmt:parseDate var="dateString" value="${vacationdoc.vd_startdate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td>~</td>
				<td>
				<fmt:parseDate var="dateString" value="${vacationdoc.vd_enddate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="width: 110px;">총 일수</td>
				<td>${vacationdoc.vd_day}</td>
			</tr>
			<tr>
				<td style="width: 110px;">내용</td>
				<td colspan="5"><br><br>위와 같이 신청하오니 결재 바랍니다.</br></br></br></td>
			</tr>
			<tr>
				<td style="width: 110px;" rowspan="2">비고</td>
				<td colspan="5" rowspan="2">${vacationdoc.vd_contents}</td>
			</tr>
			
		</table>
		<br>
		<center>
		<a href="updateform.bit?seq=${Approval.app_no}&app_kind=${Approval.app_kind}">수정</a> &emsp;&emsp;&emsp;&emsp;&emsp;
		<a href="delete.bit?seq=${Approval.app_no}">삭제</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<a href="list.bit">목록</a>
		</center>
	</form>
	
	</div>
	
	
</body>
</html>