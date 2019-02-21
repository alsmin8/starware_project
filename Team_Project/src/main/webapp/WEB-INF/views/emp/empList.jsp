<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!CTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- <!DOCTYPE html> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<style type="text/css">
.pagination ul {
	list-style: none;
	float: left;
	display: inline;
}

.pagination ul li {
	float: left;
}

.pagination ul li a {
	float: left;
	padding: 4px;
	margin-right: 3px;
	width: 30px;
	color: #000;
	font: bold 12px tahoma;
	border: 1px solid #eee;
	text-align: center;
	text-decoration: none;
}

.pagination ul li a:hover, ul li a:focus {
	color: #fff;
	border: 1px solid #4d86d1;
	background-color: #4d86d1;
}
</style>

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
					</ul></li>
			</ul>

		</div>
	</nav>

	<div class="container">

		<h1>인사관리</h1>

		<h3>사원정보</h3>





		<table class="type04">

			<!-- <table width="500" border="1" cellpadding="0" cellspacing="0">  -->
			<tr>
				<td>사번</td>
				<td>성명</td>
				<td>입사일</td>
				<td>부서번호</td>
				<td>직급번호</td>
				<td>재직상태</td>

			</tr>
			<c:forEach var="emp" items="${empList}">


				<tr>
					<td>${emp.emp_no}</td>
					<%-- <td><a href="/emp/empDetail?emp_no=${emp.emp_no }">${emp.emp_name }</a></td>  --%>


					<%-- <td><a href = '/emp/empDetail?emp_no=<c:out value="${emp.emp_no }"/>'>
					<c:out value="${emp.emp_name }" /></a></td>  --%>

					<td><a class='empMove' href='<c:out value="${emp.emp_no }"/>'>
							<c:out value="${emp.emp_name }" />
					</a></td>


					<td>${emp.emp_hiredate }</td>
					<td>${emp.dept_name }</td>
					<td>${emp.grade_name }</td>
					<td>${emp.emp_empstate }</td>



				</tr>


			</c:forEach>


		</table>

		<tr>
			<td style="text-align: right" colspan="3">
				<h5 style="color: red;" id="passwordCheckMessage"></h5> <a
				class="btn btn-default pull-right" value="입력"
				href="/emp/empInsertForm?emp_no=${emp.emp_no }">사원정보추가</a>
			</td>
		</tr>

	</div>
	

	
	
	
	<!-- 페이지 처리 영역 (newver.)-->
	
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${empPageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${empPageMaker.empStartPage -1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${empPageMaker.empStartPage}"
				end="${empPageMaker.empEndPage}">
				<li class="paginate_button  ${empPageMaker.empcri.pageNum == num ? "active":""} ">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>

			<c:if test="${empPageMaker.next}">
				<li class="paginate_button next"><a
					href="${empPageMaker.empEndPage +1 }">Next</a></li>
			</c:if>
		</ul>


		<form id='empActionForm' action='/emp/empList' method='get'>
			<input type='hidden' name='pageNum' value='${empPageMaker.empcri.pageNum }'>
			<input type='hidden' name='amount' value='${empPageMaker.empcri.amount }'>
			<input type='hidden' name='empSearchType' value='<c:out value="${empPageMaker.empcri.empSearchType }"/>'>
			<input type='hidden' name='empSearchKeyword' value='<c:out value="${empPageMaker.empcri.empSearchKeyword }"/>'>
		</form>

		<script type="text/javascript">
		
			$(document)
					.ready(
							function() {
								var result = '<c:out value="${result}"/>';
								checkModal(result);

								history.replaceState({}, null, null);

								function checkModal(result) {

									if (result === '' || history.state) {
										return;
									}

									if (parseInt(result) > 0) {
										$(".modal-body").html(
												"게시글" + parseInt(result)
														+ " 등록되었습니다.");

									}
									$("#myModal").modal("show");
								}
								$("#regBtn").on("click", function() {

									self.location = "/emp/empInsertForm";
								});
								var empActionForm = $("#empActionForm");

								$(".paginate_button a").on(
										"click",
										function(e) {
											e.preventDefault();
											console.log('click');
											empActionForm.find(
													"input[name='pageNum']")
													.val($(this).attr("href"));
											empActionForm.submit();
										});
								//게시물 조회를 위한 이벤트 처리 추가
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
															"/emp/empDetail");
													empActionForm.submit();

												});
							});
		</script>
		<!-- 검색 부분 -->
		<div class='row'>
		<div class="col-lg-12" >

				<form id='empSearch' action="/emp/empList" method='get' >
					<select name='empSearchType'>
						<option value=""
						<c:out value="${empPageMaker.empcri.empSearchType == null?'selected':'' }"/>>--</option>
						<option value="NEDGS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NEDGS'?'selected':'' }"/>>전체</option>
						<option value="N"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'N'?'selected':'' }"/>>성명</option>
						<option value="E"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'E'?'selected':'' }"/>>사번</option>
						<option value="D"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'D'?'selected':'' }"/>>부서</option>
						<option value="G"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'G'?'selected':'' }"/>>직급</option>
						<option value="S"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'S'?'selected':'' }"/>>재직상태</option>
						<option value="NE"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NE'?'selected':'' }"/>>성명+사번</option>
						<option value="ND"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'ND'?'selected':'' }"/>>성명+부서</option>
						<option value="NG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NG'?'selected':'' }"/>>성명+직급</option>
						<option value="NS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NS'?'selected':'' }"/>>성명+재직상태</option>
						<option value="ED"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'ED'?'selected':'' }"/>>사번+부서</option>
						<option value="EG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'EG'?'selected':'' }"/>>사번+직급</option>
						<option value="ES"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'ES'?'selected':'' }"/>>사번+재직상태</option>
						<option value="DG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'DG'?'selected':'' }"/>>부서+직급</option>
						<option value="DS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'DS'?'selected':'' }"/>>부서+재직상태</option>
						<option value="GS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'GS'?'selected':'' }"/>>직급+재직상태</option>
						<option value="NED"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NED'?'selected':'' }"/>>성명+사번+부서</option>
						<option value="NEG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NEG'?'selected':'' }"/>>성명+사번 +직급</option>
						<option value="NES"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NES'?'selected':'' }"/>>성명 +사번+재직상태</option>
						<option value="EDG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'EDG'?'selected':'' }"/>>사번+부서+직급</option>
						<option value="EDS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'EDS'?'selected':'' }"/>>사번+부서+재직상태</option>
						<option value="DGS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'DGS'?'selected':'' }"/>>부서+직급+재직상태</option>
						<option value="NEDG"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NEDG'?'selected':'' }"/>>성명+사번+부서 +직급</option>
						<option value="NEDS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NEDS'?'selected':'' }"/>>성명+사번+부서+재직상태</option>
						<option value="EDGS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'EDGS'?'selected':'' }"/>>사번+부서+직급+재직상태</option>
						<option value="NDGS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NDGS'?'selected':'' }"/>>성명+부서+직급+재직상태</option>
						<option value="NEGS"
						<c:out value="${empPageMaker.empcri.empSearchType eq 'NEGS'?'selected':'' }"/>>성명+사번+직급+재직상태</option>
						
					</select> 

					<input type='text' name='empSearchKeyword' />
					<input type='hidden' name='pageNum' value='${empPageMaker.empcri.pageNum }' />
					<input type='hidden' name='amount' value='${empPageMaker.empcri.amount }' />
					<button type = 'submit' class='btn btn-default'>Search</button>
				</form>
				</div>
		</div>
	</div>

	<script type="text/javascript">
		var empSearch = $("#empSearch");
		$("#empSearch button").on("click", function(e) {
			if (!empSearch.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
			if (!empSearch.find("input[name='empSearchKeyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			empSearch.find("input[name='pageNum']").val("1");
			e.preventDefault();
			empSearch.submit();

		});
	</script>






</body>
</html>