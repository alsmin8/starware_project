<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
  <script src="/resources/jquery.js" type="text/javascript"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="/resources/js/bootstrap.js"></script>

</head>
<body>
<%-- <%
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
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li class="active"><a href="noticeList">공지사항</a></li>
				<li><a href="../attend/attendInsert">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li><a href="calendar_main.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

		</div>
	</nav>

	<div class="container">
<form role="form" name="form" action="noticeInsert" method="post" onsubmit="return checkForm();">
	<input type="hidden" name="emp_no" value=""><br>
	<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd;">
	<thead>
	<tr><th colspan="4"><h4>공지사항 글쓰기</h4></th></tr>
		</thead>
		
	<tbody>
	<tr>
	<td style="width: 110px;"><h5>카테고리</h5></td>
	<td colspan="3" style="text-align: left"><select name="notice_subject">
	<option label="안 내">안 내</option>
	<option label="인 사">인 사</option>
	<option label="기 타">기 타</option>
	</select></td>
	</tr>
	
	<tr>
	<td style="width: 110px;"><h5>제목</h5></td>
	<td colspan="3"><input class="form-control" type="text"
								name="notice_title"></td>
	</tr>
	
	<tr>
	<td style="width: 110px;"><h5>내용</h5></td>
	<td colspan="3">
	<textarea rows="10" cols="100" name="notice_contents"></textarea>
	</tr>
	
	<tr>
	<td style="width: 110px;"><h5>시작일</h5></td>
	<td style="width: 40%"><input class="form-control"  type="text" id="start"
								name="notice_startDate"></td>
		<td style="width: 110px;"><h5>파일</h5></td>
	<td><!-- <input type="file" name=""> --></td>	
	</tr>
	<tr>
		<td style="width: 110px;"><h5>종료일</h5></td>
	<td style="width: 40%"><input class="form-control"  type="text" id="end"
								name="notice_endDate"></td>
	<td style="width: 110px;"><h5>진행상태</h5></td>
	<td style="text-align: left"><select name="notice_state">
	<option label="진행중">진행중</option>
	<option label="완료">완료</option>
	</select></td>
	</tr>
	<tr>
	<td style="text-align: left" colspan="4">
		<input class="btn btn-primary pull-right" type="button" onclick="location.href='noticeList';" value="취소" />
	<input class="btn btn-primary pull-right" type="submit" value="등록"/> </td>
						</tr>
	
	</tbody>
	</table>
	
</form>
</div>



	  <script>
  $( function() {
    $( "#start" ).datepicker();
    dateFormat: 'yy-mm-dd'
  } );
  $( function() {
	    $( "#end" ).datepicker();
	    dateFormat: 'yy-mm-dd'
	  } );
  
  function checkForm(){
	  var title=document.form.notice_title;
	  var contents=document.form.notice_contents;
	  
	  if(title.value==''||contents.value==''){
		  window.alert("제목과 내용을 입력해야 합니다.")
		  document.form.notice_title.focus();
		  document.form.notice_contents.focus();
		  return false;
	  }
  }
  </script>

</body>
</html>