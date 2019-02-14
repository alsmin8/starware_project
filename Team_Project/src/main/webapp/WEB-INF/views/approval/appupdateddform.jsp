<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
	
	
	<form action="/approval/appupdateddform?app_no=${approval.app_no}&app_kind=${approval.app_kind}" method="post">
	
		<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="4"><h4>지 출 결 의 서</h4></th>
					</tr>
			<tr>
				<td style="width: 110px;">제 목</td>
				<td colspan="3"><input class="form-control" type="text" name="app_title" value="${approval.app_title }" width=100></td>
			</tr>
			<tr>
				<td style="width: 110px;">이 름</td>
				<td><input class="form-control" type="text" name="emp_name" value="emp"></td>
				<td style="width: 110px;">사 번</td>
				<td><input class="form-control" type="text" name="emp_no" value="${approval.emp_no}"></td>
			</tr>
			<tr>
				<td style="width: 110px;">사 유</td>
				<td style="width: 110px;">사용일자</td>
				<td style="width: 110px;">사용금액</td>
				<td style="width: 110px;">거래처 번호</td>
			</tr>
			<tr>
				<td><input class="form-control" type="text" name="d_contents" value="${disbursementdoc.d_contents}"></td>
				<td><input class="form-control" type="text" name="d_usingdate" value="${disbursementdoc.d_usingdate }"></td>
				<td><input class="form-control" type="text" name="d_amount" value="${disbursementdoc.d_amount }"></td>
				
			</tr>

			<tr>
				<td style="width: 110px;">비 고</td>
				<td colspan="3"><input class="form-control" type="text" name="etc"></td>
			</tr>


		</table><br>
		<center><input type="submit" value="수정완료"></center>
		</form>
	
	</div>
	
	
</body>
</html>