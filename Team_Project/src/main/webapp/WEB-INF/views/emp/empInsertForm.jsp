<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
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
			response.sendRedirect("login.jsp");
			return;
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
			<a class="navbar-brand" href="main.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li class="active"><a href="list.do">인사관리</a></li>
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
	
	<%-- <div class="container">
	
	<h1>사원 정보</h1>
	
		<h3>사원정보 입력</h3>
	<hr>
	<form action="insertAction.do" method="post">

		사번 : <input type="text" name="emp_no" value="12301"><br>
		성명 : <input type="text" name="emp_name" value="최성우"><br>
		비밀번호 : <input type="text" name="emp_pass" value="12301"><br>
		성별 : <input type="text" name="emp_gender" value="M"><br>
		주민등록번호 : <input type="text" name="emp_socialNo" value="920717-1234567"><br>
		부서번호 : <input type="text" name="dept_no" value="103"><br>
		직급번호 : <input type="text" name="grade_no" value="20"><br>
		연락처 : <input type="text" name="emp_cellphone" value="010-1234-5678"><br>
		내선번호 : <input type="text" name="emp_extension" value="1001"><br>
		입사일 : <input type="text" name="emp_hiredate" value="2018-01-01"><br>
		퇴사일 : <input type="text" name="emp_retiredate" value="2018-12-31"><br>
		고용상태 : <input type="text" name="emp_empstate" value="퇴사"><br> 
		
			<!-- 셀렉트 형태(수정시 DB에서 데이터 유지가 안되는 상태, 일단은 inputtype으로 사용하자 -->
				<select type = "hidden" name="emp_empstate">
			<option value="선택" >${emp.emp_empstate }</option>
			<option value="재직">재직</option>
			<option value="퇴사">퇴사</option>
			</select> <br> 
			
		총 연차일수 : <input type="text" name="emp_totalvdays" value="15"><br>
		잔여 연차일수 : <input type="text" name="emp_vleftdays" value="13"><br>

		

		<br>
				
		 <input type="submit" value="등록"> <a href="list.do">목록</a> 
		 	
	</form>
	
	
	
	</div> --%>
	
	<div class="container">
			<form method="post" action="./insertAction.do">
				<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="3"><h4>사원 등록 양식</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 110px;"><h5>사번</h5></td>
							<td><input class="form-control" type="text" id="emp_no"
								name="emp_no" maxlength="20" placeholder="사번을 입력하세요"></td>
							<!-- <td style="width: 110px;"><button class="btn btn-primary"
									onclick="registerCheckFunction();" type="button">중복체크</button></td> -->
						</tr>
						<tr>
							<td style="width: 110px;"><h5>성명</h5></td>
							<td><input class="form-control" type="text" id="emp_name"
								name="emp_name" maxlength="20" placeholder="성명을 입력하세요"></td>
						</tr>		
						<tr>
							<td style="width: 110px;"><h5>비밀번호</h5></td>
							<td colspan="2"><input onkeyup="passwordCheckFunction();"
								class="form-control" type="password" id="emp_pass"
								name="emp_pass" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>성별</h5></td>
							<td><input class="form-control" type="text" id="emp_gender"
								name="emp_gender" maxlength="20" placeholder="성별을 입력하세요"></td>
						</tr>
						<!-- <tr>
							<td style="width: 110px;"><h5>성별</h5></td>
							<td colspan="2">
								<div class="form-group"
									style="text-align: center; margin: 0 auto;">
									<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-primary active"> <input
											type="radio" name="emp_gender" autocomplete="off" value="남자"
											checked>남자
										</label> <label class="btn btn-primary"> <input type="radio"
											name="emp_gender" autocomplete="off" value="여자">여자
										</label>
									</div>
								</div>
							</td>
						</tr> -->
						<tr>
							<td style="width: 110px;"><h5>주민등록번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_socialNo" name="emp_socialNo" maxlength="20"
								placeholder="주민등록번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>부서번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="dept_no" name="dept_no" maxlength="20"
								placeholder="부서번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>직급번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="grade_no" name="grade_no" maxlength="20"
								placeholder="직급번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>연락처</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_cellphone" name="emp_cellphone" maxlength="20"
								placeholder="연락처를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>내선번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_extension" name="emp_extension" maxlength="20"
								placeholder="내선번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>입사일</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_hiredate" name="emp_hiredate" maxlength="20"
								placeholder="입사일을 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>퇴사일</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_retiredate" name="emp_retiredate" maxlength="20"
								placeholder="퇴사일을 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>고용상태</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_empstate" name="emp_empstate" maxlength="20"
								placeholder="고용상태를 입력하세요"></td>
						</tr>
						<!-- <tr>
							<td style="width: 110px;"><h5>고용상태</h5></td>
							<td colspan="2">
								<div class="form-group"
									style="text-align: center; margin: 0 auto;">
									<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-primary active"> <input
											type="radio" name="emp_empstate" autocomplete="off" value="재직"
											checked>재직
										</label> <label class="btn btn-primary"> <input type="radio"
											name="emp_empstate" autocomplete="off" value="퇴사">퇴사
										</label>
									</div>
								</div>
							</td>
						</tr> -->
						<tr>
							<td style="width: 110px;"><h5>총 연차일수</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_totalvdays" name="emp_totalvdays" maxlength="20"
								placeholder="총 연차일수를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>잔여 연차일수</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_vleftdays" name="emp_vleftdays" maxlength="20"
								placeholder="잔여 연차일수를 입력하세요"></td>
						</tr>
											
						<tr>
							<td style="text-align: left" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"/> 
							<h5 style="color: red;" id="passwordCheckMessage"></h5><a class="btn btn-default pull-right" value="목록" href="list.do">목록</a> </td>
						</tr>
						
					</tbody>
				</table>
			</form>
		</div>
	
	
</body>
</html>