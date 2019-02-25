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
<script type="text/javascript" src="/resources/js/moment.js"></script>
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
		<a href="/schedulePage/"><h3>일정 관리</h3></a>
			<div class="btn-group" style="position:absolute;top:90px;right:150px">
				<input type="button" class="btn btn-secondary" onclick="javascript:location.href='<c:url value='/schedulePage/' />'" value="캘린더" /> 
				<input type="button" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedulePage/listSch' />'" value="목록" /> 
			</div>
		<hr class="menu-line">
	</div>
	
	<div class="card" style="border: 1px solid #BDBDBD">
  <div class="card-body" style="padding:16px">
  	<form id="actor" action="/schedulePage/listSch" method="get">
		<div class="form-inline">
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="category_name" >카테고리명</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="schedule_title" >일정명</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="schedule_contents" >내용</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" name="ename" value="emp_name" >참여자</label></div>
		
		<c:forEach var='j' items='${search.area}'>
			<input type='hidden' name='area' name='${j}' value='${j}'>
		</c:forEach>
		
		<c:forEach var='k' items='${search.ename}'>
			<input type='hidden' name='ename' value='${k}'>
		</c:forEach>
		
		<div class="form-group"><div class="col-sm-6">
		<input type="text" class="form-control" name="searchKey" value='${search.searchKey}' placeholder="키워드 입력">
		</div></div>
		</div>
		<br><div style="height:8px"></div>
		<div class="form-inline">
		<div class="checkbox-inline"><label><input type="checkbox" name="area" value="schedule_time">시간</label></div>
		<div class="form-group"><div class="col-sm-3">
		<input type="text" class="form-control" name="schedule_starttime" id='datetimepicker1' value='${search.schedule_starttime}' size="20" placeholder="2019/01/17 13:00">
		</div>
  		</div>
  		<div class="form-group"><div class="col-sm-3">
  		<input type="text" class="form-control" name="schedule_endtime" id='datetimepicker2' value='${search.schedule_endtime}' size="20" placeholder="2019/01/17 18:00">
  		</div>
  		</div>
  		&nbsp&nbsp&nbsp&nbsp&nbsp<input type="submit" value="찾기" class="btn btn-primary">
  		</div>
	</form>
	</div>
	</div>
	<br>
	<div align="left">
		<input type="button" value="오늘 일정 보기" class="btn btn-default" id="mysche" >
<!--   		<input type="button" value="마감일자별" class="btn btn-default">
  		<input type="button" value="사용자별" class="btn btn-default" > -->
  	</div>
	<br>
<table id="sche-table" class="type04" style="text-align:center">
	<tr>
		<td>카테고리번호</td>
		<td>카테고리색상</td>
		<td>카테고리명</td>
		<td>일정명</td>
		<td>시작일</td>
		<td>종료일</td>
		<td>참여자수</td>
	</tr>
		<c:forEach var="i" items="${list}">
		<tr>
			<td>${i.category_no}</td>
			<td><div class="colorSchList" style="background-color:${i.category_color}"></div></td>
			<td>${i.category_name}</td>
			<td><a class="detail" name="${i.schedule_no}">${i.schedule_title}</a></td>
			<td>${i.schedule_starttime}</td>
			<td>${i.schedule_endtime}</td>
			<td>${i.attcount}</td>
		</tr>
		</c:forEach>
		
	</table>

	
	<script type="text/javascript">
		$('.detail').on('click', function(e) {
			e.preventDefault();
			$('#actor').attr('action', '/schedulePage/getSch');
			var num = $(this).attr('name');
			
			$('#actor').append('<input type="hidden" name="schedule_no" value="'+num+'"/>');
			$('#actor').submit();
		})
	</script>

	<br><br>
			</div>
			
			<script type="text/javascript">
		$('#mysche').on('click', function() {
			console.log('성공 오늘');
			var date = new Date();
			var formatDate = moment(date).format('YYYY/MM/DD');
			var schedule_starttime = formatDate+' 00:00';
			var schedule_endtime = formatDate+' 23:59';
			var params = {area : "schedule_time", schedule_starttime : schedule_starttime, schedule_endtime : schedule_endtime}
			
			scheduleService.getList(params, function(data) {
				var html = '';
				$('.type04').empty();
				$('.type04').append('<tr><td>카테고리번호</td><td>카테고리색상</td><td>카테고리명</td><td>일정명</td><td>시작일</td><td>종료일</td><td>참여자수</td></tr>')
				$.each(data, function(index, item) {
					html += '<tr><td>'+item.category_no+'</td><td><div class="colorSchList" style="background-color:'+item.category_color+'"></div></td><td>'+item.category_name+'</td><td>'+item.schedule_title+'</td><td>'+item.schedule_starttime+'</td><td>'+item.schedule_endtime+'</td><td>'+item.attcount+'</td></tr>'
				});
				$('.type04').append(html);
				$('.type04').append('</table>');
			})
		})
	</script>
</body>
</html>