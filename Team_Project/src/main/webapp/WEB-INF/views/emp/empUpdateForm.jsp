
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
			<a class="navbar-brand" href="/login">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
				<li><a href="/loginafter">메인</a></li>
            <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/projectList">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li class="active"><a href="/emp/empList">인사관리</a></li>
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
					</ul>
				</li>
			</ul>

		</div>
	</nav>
	
	
	
	<div class="container">

	
	
	<%-- 
	
	사번 : <input type="text" name="emp_no" value = "${emp.emp_no }"><br>
	성명 : <input type="text" name="emp_name" value = "${emp.emp_name }"><br>
	비밀번호 : <input type="text" name="emp_pass" value = "${emp.emp_pass }"><br>
	성별 : <input type="text" name="emp_gender" value = "${emp.emp_gender }"><br>
	주민등록번호 : <input type="text" name="emp_socialNo" value = "${emp.emp_socialNo }"><br>
	부서번호 : <input type="text" name="dept_no" value = "${emp.dept_no }"><br>
	직급번호 : <input type="text" name="grade_no" value = "${emp.grade_no }"><br>
	연락처 : <input type="text" name="emp_cellphone" value = "${emp.emp_cellphone }"><br>
	내선번호 : <input type="text" name="emp_extension" value = "${emp.emp_extension }"><br>
	입사일 : <input type="text" name="emp_hiredate" value = "${emp.emp_hiredate }"><br>
	퇴사일 : <input type="text" name="emp_retiredate" value = "${emp.emp_retiredate }"><br>
	고용상태 : <input type="text" name="emp_empstate" value = "${emp.emp_empstate }"><br>
		
	총 연차일수 : <input type="text" name="emp_totalvdays" value = "${emp.emp_totalvdays }"><br>
	잔여 연차일수 : <input type="text" name="emp_vleftdays" value = "${emp.emp_vleftdays }"><br>
	 
	> --%>
	
	<form id="empForm" name="empForm" action="/emp/empUpdate" method="post" >
	<input type="hidden" name="emp_no" value="${emp.emp_no }">
	<input type='hidden' name='pageNum' value='<c:out value="${empcri.pageNum}" />'>
    <input type='hidden' name='amount' value='<c:out value="${empcri.amount}" />'>
			
				<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="3"><h4>사원 정보 수정</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 110px;"><h5>사번</h5></td>
							<td>사번은 임의로 수정할 수 없습니다.</td>
							<%-- <td><input class="form-control" type="text" id="emp_no"
								name="emp_no" maxlength="20" placeholder="사번을 입력하세요" value = "${emp.emp_no }"></td>	 --%>
								
							<!-- <td style="width: 110px;"><button class="btn btn-primary"
									onclick="registerCheckFunction();" type="button">중복체크</button></td> -->
						</tr>
						<tr>
							<td style="width: 110px;"><h5>성명</h5></td>
							<td><input class="form-control" type="text" id="emp_name"
								name="emp_name" maxlength="20" placeholder="성명을 입력하세요" value = "${emp.emp_name }"></td>
						</tr>		
						<tr>
							<td style="width: 110px;"><h5>비밀번호</h5></td>
							<td colspan="2"><input onkeyup="passwordCheckFunction();"
								class="form-control" type="password" id="emp_pass"
								name="emp_pass" maxlength="20" placeholder="비밀번호를 입력하세요" value = "${emp.emp_pass }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>성별</h5></td>
							<td><input class="form-control" type="text" id="emp_gender"
								name="emp_gender" maxlength="20" placeholder="성별을 입력하세요" value = "${emp.emp_gender }"></td>
						</tr>
						
						
						<tr>
							<td style="width: 110px;"><h5>주민등록번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_socialNo" name="emp_socialNo" maxlength="20"
								placeholder="주민등록번호를 입력하세요" value = "${emp.emp_socialNo }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>부서번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="dept_no" name="dept_no" maxlength="20"
								placeholder="부서번호를 입력하세요" value = "${emp.dept_no }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>직급번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="grade_no" name="grade_no" maxlength="20"
								placeholder="직급번호를 입력하세요" value = "${emp.grade_no }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>연락처</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_cellphone" name="emp_cellphone" maxlength="20"
								placeholder="연락처를 입력하세요" value = "${emp.emp_cellphone }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>내선번호</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_extension" name="emp_extension" maxlength="20"
								placeholder="내선번호를 입력하세요" value = "${emp.emp_extension }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>입사일</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_hiredate" name="emp_hiredate" maxlength="20"
								placeholder="입사일을 입력하세요" value = "${emp.emp_hiredate }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>퇴사일</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_retiredate" name="emp_retiredate" maxlength="20"
								placeholder="퇴사일을 입력하세요" value = "${emp.emp_retiredate }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>고용상태</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_empstate" name="emp_empstate" maxlength="20"
								placeholder="고용상태를 입력하세요" value = "${emp.emp_empstate }"></td>
						</tr>
				
						<tr>
							<td style="width: 110px;"><h5>총 연차일수</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_totalvdays" name="emp_totalvdays" maxlength="20"
								placeholder="총 연차일수를 입력하세요" value = "${emp.emp_totalvdays }"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>잔여 연차일수</h5></td>
							<td colspan="2"><input class="form-control" type="text"
								id="emp_vleftdays" name="emp_vleftdays" maxlength="20"
								placeholder="잔여 연차일수를 입력하세요" value = "${emp.emp_vleftdays }"></td>
						</tr>
											
						
						
						<tr>
					<td style="text-align: right" colspan="3">
					<span style="float:right">
						<button type="submit" data-oper='List' class="btn btn-default">목록</button>
						<button type="submit" data-oper='Update' class="btn btn-default">수정</button>
					</span>
				</td>
			</tr>
						
					</tbody>
				</table>
			</form>
		</div>
	
	
	
	
	
<script type="text/javascript">
$(document).ready(function() {
  
  var empUpdateForm =$("#empForm");
  
  
  $('button').on("click", function(e){
	  
	   e.preventDefault(); 
	  
	  var empOperation = $(this).data("oper");
	  
	  console.log(empOperation);
	 //여기부터 잘못된거같다 
	  if(empOperation === 'Update'){
		  empUpdateForm.attr("action", "/emp/empUpdate");
		  
	  }else if(empOperation === 'List'){
		
		empUpdateForm.attr("action", "/emp/empList").attr("method", "get");
	 	
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		
		empUpdateForm.empty();
		empUpdateForm.append(pageNumTag);
		empUpdateForm.append(amountTag);
	  }
	 
	  empUpdateForm.submit();
	  
  });
  });
</script>


	
	
	
	
	
	
	
	
	
	
</body>
</html>