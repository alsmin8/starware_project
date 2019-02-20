<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">

<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js" type="text/javascript"></script>
</head>
<body>
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
/* 
		if (emp_no != null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있습니다.");
		} */
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

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="/login">로그인</a></li>
					</ul></li>
			</ul>

		</div>
	</nav>

	<div class="container">
		<div class="row">
			<div class="col-xs-2">
				<button type="button" class="btn btn-default btn-lg btn-block">기본</button>
				<button type="button" class="btn btn-default btn-lg btn-block">업무지원</button>
				<button type="button" class="btn btn-default btn-lg btn-block">협업지원</button>
				<button type="button" class="btn btn-default btn-lg btn-block">커뮤니티</button>
				<button type="button" class="btn btn-default btn-lg btn-block">인사관리</button>
			</div>
			<div class="col-xs-10">

				<form method="post" action="/login">
					<table class="table table-bordered table-hover"
						style="text-align: center; border: 1px solid #dddddd;">
						<thead>
							<tr>
								<th colspan="3"><h4>로그인 창</h4></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 110px;"><h5>아이디</h5></td>
								<td colspan="2"><input class="form-control" type="text"
									id="emp_no" name="emp_no" maxlength="20"
									placeholder="아이디를 입력하세요"></td>
							</tr>
							<tr>
								<td style="width: 110px;"><h5>비밀번호</h5></td>
								<td colspan="2"><input class="form-control" type="password"
									id="emp_pass" name="emp_pass" maxlength="20"
									placeholder="비밀번호를 입력하세요"></td>
							</tr>
							<tr>
								<td style="text-align: left" colspan="3"><input
									class="btn btn-primary pull-right" type="submit" value="로그인">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
	<br>
	<div class="container">
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 5px solid #eeeeee;">
			<tbody>
			<c:forEach var="notice" items="${noticeList }" begin="0" end="2">
				<tr>
					<td colspan="3"><h5>${notice.notice_title }</h5></td>
				</tr>
				<!-- <tr>
					<td colspan="3"><h5>리스트2</h5></td>
				</tr>
				<tr>
					<td colspan="3"><h5>리스트3</h5></td>
				</tr> -->
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="3"><h4>공지사항</h4></th>
				</tr>
			</tfoot>
		</table>
	</div>
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div
					class="modal-content <%if (messageType.equals("오류메세지"))
					out.println("panel-warning");
				else
					out.println("panel-success");%>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%=messageType%>
						</h4>
					</div>
					<div class="modal-body">
						<%=messageContent%>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$('#messageModal').modal('show');
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">확인메세지</h4>
					</div>
					<div id="checkMessage" class="modal-body"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>