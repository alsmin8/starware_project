<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
td {
	text-align: center;
}

tr {
	height: 25px;
	width: 200;
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


		<form action="detaildd.bit?seq=${Approval.app_no}" method="post">
			<input type="hidden" name="app_kind" value="<%=app_kind%>">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"><h4>기 안 서</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;">제 목</td>
						<td colspan="3">${disbursementdoc.d_title }</td>
					</tr>
					<tr>
						<td style="width: 110px;">이 름</td>
						<td>${emp_name }</td>
						<td style="width: 110px;">사 번</td>
						<td>${emp_no}</td>
					</tr>
					<tr>
						<td style="width: 110px;">부 서</td>
						<td>${dept_name}</td>
						<td style="width: 110px;">직 급</td>
						<td>${grade_name}</td>
					</tr>
					<tr>
						<td style="width: 110px;">사용일자</td>
						<td style="width: 110px;">사 유</td>
						<td style="width: 110px;">사용금액</td>
						<td style="width: 110px;">거래처 번호</td>
					</tr>
					<tr>
						<td style="width: 110px;"><fmt:parseDate var="dateString"
								value="${disbursementdoc.d_usingdate}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" /></td>
						<td style="width: 110px;">${disbursementdoc.d_contents}</td>
						<td style="width: 110px;">${disbursementdoc.d_amount}</td>
						<td style="width: 110px;">${disbursementdoc.customer_no}</td>
					</tr>
					<tr>
						<td style="width: 110px;"></td>
						<td style="width: 110px;"></td>
						<td style="width: 110px;"></td>
						<td style="width: 110px;"></td>
					</tr>

					<tr>
						<td style="width: 110px;">비 고</td>
						<td colspan="3"></td>
					</tr>
				</tbody>

			</table>
			<br>
			<center>
				<a
					href="updateform.bit?seq=${Approval.app_no}&app_kind=${Approval.app_kind}">수정</a>
				&emsp;&emsp;&emsp;&emsp;&emsp; <a
					href="delete.bit?seq=${Approval.app_no}">삭제</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<a href="list.bit" align="right">목록</a>
			</center>
		</form>


	</div>


</body>
</html>