<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>STARWARE(Groupware)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<link rel="stylesheet" href="/resources/css/schedule_custom.css">
<script type="text/javascript" src="/resources/jquery.js"></script>
<script type="text/javascript" src="/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>
</head>
<body>

	<!-- 메인 메뉴 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/login">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			<li><a href="/loginafter">메인</a></li>
            <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/projectList">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li class="active"><a href="/schedulePage/">일정관리</a></li>
            <li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="buton" aria-haspopup="true" aria-expanded="false">
						회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	

	<!-- start container -->
	<div id="container">
	
	<div id="ca-header">
		<a href="/schedulePage/"><h3>일정 상세</h3></a>
		<div id="mask"></div>
		<hr>
	</div>
	
	<form id="actor" action="/schedulePage/listSch" method="get">
		<c:forEach var='i' items='${search.area}'>
			<input type='hidden' name='area' name='${i}' value='${i}'>
		</c:forEach>
							
		<c:forEach var='k' items='${search.ename}'>
			<input type='hidden' name='ename' value='${k}'>
		</c:forEach>

		<input type='hidden' name='searchKey' value='${search.searchKey}'>
		<input type='hidden' name='schedule_starttime' value='${search.schedule_starttime}'>
		<input type='hidden' name='schedule_endtime' value='${search.schedule_endtime}'>
	</form>

	<form id="real" action="/schedulePage/updateSch" method="post">
	
			<c:forEach var='i' items='${search.area}'>
			<input type='hidden' name='area' name='${i}' value='${i}'>
		</c:forEach>
							
		<c:forEach var='k' items='${search.ename}'>
			<input type='hidden' name='ename' value='${k}'>
		</c:forEach>

<%-- 		<input type='hidden' name='searchKey' value='${search.searchKey}'>
		<input type='hidden' name='schedule_starttime' value='${search.schedule_starttime}'>
		<input type='hidden' name='schedule_endtime' value='${search.schedule_endtime}'> --%>
		

							<button id='listSchBtn' class='btn btn-primary' style='position:absolute;right:25%'>목록</button>
							<button type="submit" id='updateSchBtn' class='btn btn-primary' style='position:absolute;right:20%'>수정</button>
							<button type="submit" id='deleteSchBtn' class='btn btn-primary' style='position:absolute;right:15%'>삭제</button>
								<br><br>
		
							<input type='hidden' name='schedule_no' value='${schedule.schedule_no}'>
							<input type='hidden' name='emp_no' value='${schedule.emp_no}'>
								
							<div class='form-group col-md-12'>
								<label>일정명</label> 
								<input type='text' class='form-control' name='schedule_title' value='${schedule.schedule_title}'>
							</div>

				<div class='form-group col-md-12'>
					<label>카테고리 색상</label><br> 
					<input type='hidden'	class='form-control' name='category_no' value='${schedule.category_no}'>
					<div id='pickColor' class='form-control'>
						<div class='colorSchList' style='background-color:${schedule.category_color}'></div>
						${schedule.category_name}</div>
					<div id='selColor'>
						<div class='form-control'
							style='background-color: white; overflow-y: scroll; position: absolute; text-align: left; width: 96%; height: 280%; z-index: 100000;'>
						</div>
					</div>
				</div>


				<div class='form-group col-md-12'>
								<label>시작일</label> 
								<input type='text' class='form-control' id='datetimepicker1' name='schedule_starttime' value='${schedule.schedule_starttime}'>
							</div>
							
							<div class='form-group col-md-12'>
								<label>종료일</label> 
								<input type='text' class='form-control' id='datetimepicker2' name='schedule_endtime' value='${schedule.schedule_endtime}'>
							</div>
							
							<div class='form-group col-md-12'>
								<label>파일첨부</label> 
								<input type='file' name=''>
							</div>
							
							<div class='form-group col-md-12'>
								<label>내용</label> 
								<input type='text' class='form-control' name='schedule_contents' value='${schedule.schedule_contents}'>
							</div>
							
							<div class='form-group col-md-12'>
								<label>참여자</label>
								<div class=''>
									<c:forEach var="i" items="${empList}">
										${i.emp_no}-${i.emp_name}-${i.dept_name}&nbsp/&nbsp
									</c:forEach>
								</div>
							</div>
							
							<div class='form-group col-md-12'>
								<label>추가할 참여자</label>
								<div class='attendees-group'></div>
							</div>
							
							<div class='form-group col-md-12'>
								<label>참여자 검색</label> <input class="form-control" type="text"
									maxlength="20" id="temp2" onkeyup="startSuggest()">
								<div id="suggest">
									<div class="form-control"
										style="background-color: white; overflow-y: scroll; position: absolute; text-align: left; width: 95%; height: 120px">
										<table class="table table-bordered" id="suggestList">
											<thead>
												<tr>
													<td>사원명</td>
													<td>부서명</td>
													<td>사원번호</td>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<br><br><br><br><br>
							</form>
	
				
			</div>
			
			<script type="text/javascript">
hide('selColor');
$('#pickColor').on('click', function() {
	console.log('성공');
	var emp_no = 12305;
	var params = {emp_no:emp_no};

	categoryService.getList(function(data){
		var html = '<ul>';

		$.each(data, function(index, item) {
			html += "<li class='myColorList' ><div class='colorSchList' style='background-color:" 
					+ item.category_color + "'></div>"+item.category_name+"</li><input type='hidden' value='"+item.category_no+"'>";
			console.log('d'+item.category_color);
		});
		
		html += '</ul>';
		console.log('성공');
		$('#selColor > div').html(html);
	});
	show('selColor');
})

$('#selColor').on('click', 'li', function() {
			var color = $(this).next().val();
			var str = $(this).html();
			
			console.log('color'+color+'str'+str);
			$('input[name=category_no]').val(color);
			$('#pickColor').html(str);
			hide('selColor');
		})
</script>

	<script type="text/javascript">
		$('#listSchBtn').on('click', function(e) {
			e.preventDefault();
			$('#actor').attr('action', '/schedulePage/listSch');
			$('#actor').attr('method', 'get');
			$('#actor').submit();
		})
		
		$('#deleteSchBtn').on('click', function() {
			$('#real').attr('action', '/schedulePage/deleteSch');
			$('#real').submit();
		})
	</script>
</body>
</html>