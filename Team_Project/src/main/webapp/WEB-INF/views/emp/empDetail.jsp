<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li class="active"><a href="empList">인사관리</a></li>
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
		 <!-- <form id = "empUpdate" method="post" action="/emp/empUpdateForm"> --> 

		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<th colspan="3"><h4>사원 정보</h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 110px;"><h5>사번</h5></td>
					<td>${emp.emp_no }
				</tr>
				<tr>
					<td style="width: 110px;"><h5>성명</h5></td>
					<td>${emp.emp_name }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>비밀번호</h5></td>
					<td colspan="2">${emp.emp_pass }</td>
				</tr>

				<tr>
					<td style="width: 110px;"><h5>성별</h5></td>
					<td colspan="2">${emp.emp_gender}</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>주민등록번호</h5></td>
					<td colspan="2">${emp.emp_socialNo }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>부서번호</h5></td>
					<td colspan="2">${emp.dept_no }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>직급번호</h5></td>
					<td colspan="2">${emp.grade_no }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>연락처</h5></td>
					<td colspan="2">${emp.emp_cellphone }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>내선번호</h5></td>
					<td colspan="2">${emp.emp_extension }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>입사일</h5></td>
					<td colspan="2">${emp.emp_hiredate }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>퇴사일</h5></td>
					<td colspan="2">${emp.emp_retiredate }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>고용상태</h5></td>
					<td colspan="2">${emp.emp_empstate }
					</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>총 연차일수</h5></td>
					<td colspan="2">${emp.emp_totalvdays }</td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>잔여 연차일수</h5></td>
					<td colspan="2">${emp.emp_vleftdays }</td>
				</tr>

				<tr>
					<td style="text-align: right" colspan="3">
					<span style="float:right">
						<button data-oper='empListAction' class="btn btn-default">목록</button>
						<button data-oper='empOperForm' class="btn btn-default">수정</button>
					</span>
				</td>
			</tr>

			</tbody>
		</table>

	 	
 


		 <form id='empOperForm' action='emp/empUpdateForm' method="get">
			<input type='hidden' name='emp_no' id='emp_no'
				value='<c:out value="${emp.emp_no }"/>'> 
				<input type='hidden' name='pageNum' 
				value='<c:out value="${empcri.pageNum }"/>'> 
				<input type='hidden' name='amount'
				value='<c:out value="${empcri.amount }"/>'>
		</form>
		
 		<form id="empListAction" action="emp/empList" method="get">
			<input type='hidden' name='emp_no' id='emp_no'
				value='<c:out value="${emp.emp_no }"/>'>
			<input type='hidden' name='pageNum' 
			    value='<c:out value="${empcri.pageNum }"/>'> 
			<input type='hidden' name='amount'
				value='<c:out value="${empcri.amount }"/>'>
		</form>
		<!-- </form> -->
	</div>
	
	<div align="center">
	
	
	</div>
	
<script type="text/javascript">
$(document).ready(function() {
  
  var empListAction =$("#empListAction");
  var empOperForm = $("#empOperForm"); 
  
  $("button[data-oper='empListAction']").on("click", function(e){
	   e.preventDefault(); 
	  console.log('console..............');
    empListAction.find("#emp_no").remove(); 
    empListAction.attr("action","/emp/empList")
    empListAction.submit();
  });
  
  $("button[data-oper='empOperForm']").on("click", function(e){
    empOperForm.attr("action","/emp/empUpdateForm").submit();
  });  
  
});
</script>

	 <!--  <script type="text/javascript">
		$(document).ready(
				function() {
					var empListAction = $('#empListAction');
					var empUpdateForm = $('#empUpdateForm');
					var empActionForm =$('#empActionForm');
				$(".empMove")
					.on(
							"click",
							function(e) {

								e.preventDefault();
								empActionForm
										.append("<input type='hidden' name='emp_no' value='"
												+ $(this)
														.attr(
																"href")
												+ "'>");
								empActionForm.attr(
										"action",
										"/emp/empDetail/empUpdateForm");
								empActionForm.submit();

							});
				});
	</script>  -->

</body>
</html>


<%-- <li>사번: ${emp.emp_no }</li>
		<li>성명: ${emp.emp_name }</li>
		<li>비밀번호: ${emp.emp_pass}</li>
		<li>성별: ${emp.emp_gender}</li>
		<li>주민등록번호: ${emp.emp_socialNo }</li>
		<li>부서번호: ${emp.dept_no}</li>
		<li>직급번호: ${emp.grade_no }</li>
		<li>연락처: ${emp.emp_cellphone }</li>
		<li>내선번호: ${emp.emp_extension }</li>
		<li>입사일: ${emp.emp_hiredate }</li> --%>