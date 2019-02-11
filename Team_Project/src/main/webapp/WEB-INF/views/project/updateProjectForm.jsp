<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>STARWARE(Groupware)</title>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  function getSelectValue(frm)
  {
   frm.project_Situation.value = frm.situation.options[frm.situation.selectedIndex].text;
   frm.project_Kind.value = frm.Kind.options[frm.Kind.selectedIndex].text;
   
 };
  </script>
<script src="jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>

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
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li class="active"><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
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
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<form
			action="updateActionProject.pro?project_No=${project.project_No}" method="post" enctype="multipart/form-data">
			<input type="hidden" name="emp_No" value="12301" >
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="5"><h4>프로젝트 수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>작성자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Writer" name="project_Writer" maxlength="20"
							value="${project.project_Writer }"></td>

						<td><h5>프로젝트 종류</h5></td>
						<td colspan="2"><select name="project_Kind"
							onChange="getSelectValue(this.form);" class="form-control">
								<option value="${project.project_Kind }">품질개선</option>
								<option value="${project.project_Kind }">검증</option>
								<option value="${project.project_Kind }">유지보수</option>
								<option value="${project.project_Kind }">개발</option>
						</select> <input class="form-control" name="project_Kind" type="text"
							maxlength="20" value="${project.project_Kind }"></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>담당자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Manager" name="project_Manager" maxlength="20"
							value="${project.project_Manager }"></td>

						<td style="width: 110px;"><h5>진행상태</h5></td>
						<td colspan="2"><select name="project_Situation"
							onChange="getSelectValue(this.form);" class="form-control">
								<option value="${project.project_Situation }">예정</option>
								<option value="${project.project_Situation }">완료</option>
								<option value="${project.project_Situation }">보류</option>
								<option value="${project.project_Situation }">폐기</option>
								<input class="form-control" type="text" name="project_Situation"
								maxlength="20" value="${project.project_Situation }">
						</select>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>팀원</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Members" name="project_Members" maxlength="20"
							value="${project.project_Members }"></td>

						<td style="width: 110px;"><h5>계획시작일</h5></td>
						<td colspan="2"><input class="form-control" type="date"
							id="project_Start_Date" name="project_Start_Date" maxlength="20"
							value="${project.project_Start_Date }"></td>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>제목</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Title" name="project_Title" maxlength="20"
							value="${project.project_Title }"></td>
							
						<td style="width: 110px;"><h5>계획종료일</h5></td>
						<td colspan="2"><input class="form-control" type="date"
							id="project_End_Date" name="project_End_Date" maxlength="20"
							value="${project.project_End_Date }"></td>

						</td>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>내용</h5></td>
						<td colspan="2"><textarea class="form-control" rows="10" cols="120" name="project_Contents">${project.project_Contents }</textarea></td>
						<td colspan="2" rowspan="2"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>첨부파일</h5></td>
						<td colspan="2"><input class="form-control" type="file"
							id="project_File" name="project_File" maxlength="20"
							value="${project.project_File }">기존파일: ${project.project_File }</td>
					</tr>

				</tbody>
			</table>

			<input type="submit" class="btn btn-primary pull" value="프로젝트 수정" style="margin-left: 485px">
			<input type="button" class="btn btn-primary pull" value="프로젝트 목록" onclick="location.href='listActionProject.pro';" style="text-align: center;">
		</form>
	</div>


</body>
</html>