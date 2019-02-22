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
<link rel="stylesheet" href="/resources/css/jquery.datetimepicker.css" >
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script type="text/javascript" src="/resources/jquery.js"></script>
<script type="text/javascript" src="/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>
<script type="text/javascript" src="/resources/js/moment.js"></script>
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
<!-- <script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script> -->
<script type="text/javascript">
	showList();
	 showCalendar();
</script>
<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	if (strYear != null) {
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	} 

	//년도, 월 셋팅
	cal.set(year, month, 1);
	int startday = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;

	//오늘 날짜 저장
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>
</head>
<!-- <body onload="fnOnLoad()"> -->
<body>
<!-- <div id="notifi" style='border:1px solid black;position:absolute;top:0%;right:0%;height:200px;width:200px;background-color:white;z-index: 1000000000000'>알림 내용</div> -->
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
<%-- 	<input name='location_emp' value='${emp_no}'> --%>
	<div id="ca-header">
		<a href="/schedulePage/"><h3>일정 관리</h3></a><!-- <button id="doit">interupt</button> -->
		<div id="mask"></div>
		<hr>
	</div>
	<script type="text/javascript">
/* 		$('#menu').nextAll().hide();
		$('#menu').on('click', function() {
			$(this).nextAll().show();
		}) */
	</script>
		<div id="side-bar">
		<ul id="calendar-info">
			<li id="menu">Menu</li> 
			<hr class="menu-line">
			<li class="sub" id="registerSch">등록</li>
			<li class="sub" id="searchSch"><a href="/schedulePage/listSch">검색</a></li>
			<li class="sub" id="notSch">알림</li>
			<li class="sub" id="title">My Calendar</li>
			<hr class="menu-line sub">
			<div class="list"></div>
		</ul>
		</div>
		
		<div id="calendar-sub-info">
			<ul class="list-group">
				<li class="register list-group-item">생성</li>
				<li class="listedit list-group-item">편집</li>
			</ul>
		</div>

		<!-- start calendar -->
				<div id="content">
				<br>
				<table class="calendar-header">
					<tr>
					
					<td align="left">
						<input type="button" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedulePage/' />'" value="오늘" />
					</td>
					<td align="center" style="font-size: 13pt; font-weight: bold">
						
						<!-- 이전해 -->
						<a id="mth" name=<%=month+1 %> href="<c:url value='/schedulePage/' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self"> 
							<b>&lt;&lt;</b>&nbsp
						</a> <%if(month > 0 ){ %> 
						
						<!-- 이전달 -->
						<a href="<c:url value='/schedulePage/' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self"> 
							<b>&lt;</b>
						</a> <%} else {%> <b>&lt;</b> <%} %> &nbsp;&nbsp; <%=year%>년 <%=month+1%>월
									&nbsp;&nbsp; <%if(month < 11 ){ %> 
						
						<!-- 다음달 -->
						<a href="<c:url value='/schedulePage/' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self"> 
							<b>&gt;</b>&nbsp
						</a> <%}else{%> <b>&gt;</b> <%} %> 
						
						<!-- 다음해 -->
						<a href="<c:url value='/schedulePage/' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self"> 
							<b>&gt;&gt;</b>
						</a>
					</td>
					
					<!-- day-week-month 버튼 -->
					<td align="right">
						<div class="btn-group">
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="day" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="week" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="month" />
						</div>
					</td>
					</tr>
				</table>
				
				<!-- 캘린더 컨텐츠 -->
				<br>
				<table class="table table-bordered calendar-body">
					<thead>
					<tr style="font-weight: bold;">
						<td width='100px'><div align="center"><font color="red">일</font></div></td>
						<td width='100px'><div align="center">월</div></td>
						<td width='100px'><div align="center">화</div></td>
						<td width='100px'><div align="center">수</div></td>
						<td width='100px'><div align="center">목</div></td>
						<td width='100px'><div align="center">금</div></td>
						<td width='100px'><div align="center"><font color="#2E9AFE">토</font></div></td>
					</tr>
					</thead>
					<tbody>
					<tr>
					<%
						for(int index = 1; index < start ; index++ ){
 							out.println("<td >&nbsp;</td>");
  							newLine++;
						}

						for(int index = 1; index <= endDay; index++){
       						String color = "";
       							if(newLine == 0){          
       								color = "RED";
       							}else if(newLine == 6){    
       								color = "#2E9AFE";
       							}else{                     
       								color = "BLACK"; 
       							};
       						String sUseDate = Integer.toString(year); 
       						sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
       						sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
       						
       						int iUseDate = Integer.parseInt(sUseDate);
       						String backColor = "";
       							if(iUseDate == intToday ) {
             						backColor = "#CEE3F6";
       							}

       						out.println("<td class='index' id='" + iUseDate + "' ondrop='drop(event)' ondragover='allowDrop(event)' style='padding-left:0px; padding-right:0px; margin-left:0px; margin-right:0px' valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");
       						%>
								<font color='<%=color%>'> <%=index %></font>
							<%
/* 						  				out.println("<br>");
								       out.println(iUseDate);
								       out.println("<br>");  */

       						out.println("</td>");
       						newLine++;

       						if(newLine == 7){
         						out.println("</TR>");
         							if(index <= endDay){
           								out.println("<TR>");
           								}
         							newLine=0;
       							}
							}

						//마지막 공란 LOOP
						while(newLine > 0 && newLine < 7){
  							out.println("<td>&nbsp;</td>");
  							newLine++;
						}
						%>
					</tr>
					</tbody>
				</table>
			</div>

		<!-- end calendar -->
		
	</div>
	
	
	
	
	<!-- ---------------------카테고리 목록 창----------------------------  -->
		<div id="listeditModal" class='modal modal-dialog'>
				<div class='modal-content'>

					<div class='modal-header'>
						<button type='button' class='close' data-dismiss='modal'
							aria-label='Close'>
							<span aria-hidden='true'>&times;</span>
						</button>
						<h4 class='modal-title'>category list</h4>
					</div>

					<div class='modal-body'></div>
				</div>
			</div>
			
			
		<!-- ---------------------카테고리 등록 창----------------------------  -->
		
		<div id="registerModal" class='modal modal-dialog'>
				<div class='modal-content'>

					<div class='modal-header'>
						<button type='button' class='close' data-dismiss='modal'
							aria-label='Close'>
							<span aria-hidden='true'>&times;</span>
						</button>
						<h4 class='modal-title'>category register</h4>
					</div>
					<!-- modal header end -->

					<div class='modal-body'>
						<!-- <form id='formModal' method='post' action='/schedule/insertCgr'>
						 -->
							<button type='' id='insertCgrBtn' class='btn btn-primary'
								style="position: absolute; left: 170px; top: -45px;">등록</button>
							<button type='' id='listCgrBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 230px; top: -45px;">목록</button>
							<button type='' id='updateCgrBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 290px; top: -45px;">수정</button>
							<button type='' id='deleteCgrBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 350px; top: -45px;">삭제</button>
								
							<input type='hidden' name='schedule_no' value=''>
							<input type='hidden' name='emp_no' value='12305'>
								
							<div class='form-group col-md-12'>
								<label>카테고리명</label> 
								<input type='text' class='form-control' name='category_name'>
							</div>
							
							<br><br><br>
							
							<div class='form-group col-md-12 color-selector'>
								<label>카테고리 색상</label><br>
								<div class='color' style='background-color: #F78181;'></div>
									<input class='color-select color1' type='radio' name='category_color' id='#F78181' value='#F78181' />&nbsp&nbsp&nbsp
								<div class='color' style='background-color: #FAAC58;'></div>
									<input class='color-select color2' type='radio' name='category_color' id='#FAAC58' value='#FAAC58' />&nbsp&nbsp&nbsp
								<div class='color' style='background-color: #A9F5D0;'></div>
									<input class='color-select color3' type='radio' name='category_color' id='#A9F5D0' value='#A9F5D0' />&nbsp&nbsp&nbsp
								<div class='color' style='background-color: #81BEF7;'></div>
									<input class='color-select color4' type='radio' name='category_color' id='#81BEF7' value='#81BEF7' />&nbsp&nbsp&nbsp
								<div class='color' style='background-color: #8258FA;'></div>
									<input class='color-select color5' type='radio' name='category_color' id='#8258FA' value='#8258FA' />&nbsp&nbsp&nbsp
							</div>
							
							<div class='form-group col-md-12'>
								<label>참여자</label>
								<div id='nome_iscrizione' class='attendees-group'></div>
							</div>
							
							<div class='form-group col-md-12'>
								<label>참여자 검색</label> <input class="form-control" type="text"
									maxlength="20" id="temp1" onkeyup="startSuggest()">
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
							
						<!-- </form> -->
						
					</div>
					<!-- modal body end -->

				</div>
				<!-- modal content end -->
			</div>
			
			
			
			<!-- ---------------------일정 등록 창----------------------------  -->
		<div id="registerSchModal" class='modal modal-dialog'>
				<div class='modal-content'>

					<div class='modal-header'>
						<button type='button' class='close' data-dismiss='modal'
							aria-label='Close'>
							<span aria-hidden='true'>&times;</span>
						</button>
						<h4 class='modal-title'>schedule register</h4>
					</div>
					<!-- modal header end -->

					<div class='modal-body'>
						<!-- <form id='formModal' method='post' action='/schedule/insertCgr'>
						 -->
							<button type='' id='insertSchBtn' class='btn btn-primary'
								style="position: absolute; left: 170px; top: -45px;">등록</button>
<!-- 							<button type='' id='listSchBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 230px; top: -45px;">목록</button>
							<button type='' id='updateSchBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 290px; top: -45px;">수정</button>
							<button type='' id='deleteSchBtn' data-cgrno='' class='btn btn-primary'
								style="position: absolute; left: 350px; top: -45px;">삭제</button> -->
								
							<input type='hidden' name='schedule_no' value=''>
							<input type='hidden' name='emp_no' value='12305'>
								
							<div class='form-group col-md-12'>
								<label>일정명</label> 
								<input type='text' class='form-control' name='schedule_title'>
							</div>

				<div class='form-group col-md-12'>
					<label>카테고리 색상</label><br> 
					<input type='hidden'	class='form-control' name='category_no' value=''>
					<div id='pickColor' class='form-control'>클릭하세요.</div>
					<div id='selColor'>
						<div class='form-control'
							style='background-color: white; overflow-y: scroll; position: absolute; text-align: left; width: 96%; height: 280%; z-index: 100000'>
						</div>
					</div>
				</div>
				
				<div class="form-row">
					<div class='form-group col-md-6'>
								<label>시작일</label> 
								<input type='text' class='form-control' id='datetimepicker1' name='schedule_starttime'>
							</div>
							
							<div class='form-group col-md-6'>
								<label>종료일</label> 
								<input type='text' class='form-control' id='datetimepicker2' name='schedule_endtime'>
							</div>
							</div>
							<div class='form-group col-md-12'>
								<label>파일첨부</label> 
								<input type='file' name=''>
							</div>
							
							<div class='form-group col-md-12'>
								<label>내용</label> 
								<input type='text' class='form-control' name='schedule_contents'>
							</div>
							
							<div class='form-group col-md-12'>
								<label>반복</label> 
								<input type='radio' name='not_newyn' value='1'>YES
								<input type='radio' name='not_newyn' value='0'>NO
							</div>
							
							<!-- <div class='form-group col-md-12'>
								<label>remind 알림</label> 
								<input type='radio' name='not_remindyn' value='1'>YES
								<input type='radio' name='not_remindyn' value='0'>NO
							</div>  -->
							
							<div class='form-group col-md-12'>
								<label>참여자</label>
								<div id='nome_iscrizione' class='attendees-group'></div>
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
							
						<!-- </form> -->
						
					</div>
					<!-- modal body end -->

				</div>
				<!-- modal content end -->
			</div>

<div class="popupLayer">
	<div>
		<span onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
	</div>
	<div id="detail-content">여긴 레이어~
	클릭하면 바로 나타나는 레이어에요^^</div>
</div>



<!--  category service event -->
	<script type="text/javascript">
		var category = '';
		var modal = $('.modal');
		var emp_no = 12305;
		$('#insertCgrBtn').on('click', function() {
			
			var colorValue = $('#registerModal input[type=radio][name=category_color]').length;
	 	    console.log('len'+colorValue);
	    	var colorData = new Array(colorValue);
	    	
	    	var attValue = $('#registerModal input[type=checkbox][name=attendees]').length;
	 	    console.log('len'+attValue);
	    	var attData = new Array(attValue);
	 	    
	    	for(var i=0; i<colorValue; i++){                          
	 	    	colorData[i] = $('#registerModal input[type=radio][name=category_color]')[i].checked;
	 	    	console.log('-----'+colorData[i]);
	 	    	if(colorData[i]) {
	 	    		var category_color = $('#registerModal input[type=radio][name=category_color]')[i].id;
	 	    		console.log('확인!!!!!!!!!1'+category_color);
	 	    	}
	 	    }
	    	
	    	var j = 0;
	    	for(var i = 0; i < attValue; i++) {
	 	    	if($('#registerModal input[name=attendees]')[i].checked) {
	 	    		attData[j] = Number($('#registerModal input[name=attendees]')[i].value);
	 	    		j++;
	 	    	}
	    	}
	    	
	    	console.log('j'+attData);

	    	category = {emp_no: emp_no, category_name : $('#registerModal input[name=category_name]').val(), 
	    							category_color : category_color, attendees : attData};
		
			categoryService.add(category, function(result) {	
				alert(result);
				modal.find("input").val("");
				$('#mask, .modal, #calendar-sub-info').hide();  
				 showList(); 
				 showCalendar();
			});
			
		})
		
		$('.listedit, #listCgrBtn').on('click', function(e) {
			
			$('#listeditModal').hide();
			$('#registerModal').hide();
			 wrapWindowByMask('listedit');

			e.preventDefault();
			
			categoryService.getList(function(data){
				
				var html = '';
				html += '<table class="table table-bordered"><thead><tr><td>캘린더 색상</td><td>캘린더 명</td><td>편집</td></tr></thead><tbody>';
				
				$.each(data, function(index, item) {
					console.log('color.......'+item.category_color);
 					html += "<tr><td><div class='colorModalList' style='background-color:" 
 									+ item.category_color + "'></div></td><td>" + item.category_name + "</td><td class='edit-area'><button class='cgr-edit-btn' data-cgrno='"+item.category_no+"'>편집</button></td></tr>";
 				});
				
 				html += '</tbody></table>';
 				console.log('성공');
 				$('#listeditModal .modal-body').html(html);

			});
		});
		
			$('#listeditModal').on('click', 'button[class=cgr-edit-btn]', function() {

				$('#listeditModal').hide();
				$('#insertCgrBtn').hide();
				$('#updateCgrBtn').show();
				$('#deleteCgrBtn').show();
				$('#listCgrBtn').show();
				$('.color-selector .color').css('border', '');
				
				$('div[class=attendees-group]').empty();
				
				var category_no = $(this).data('cgrno');
				var params = {category_no:category_no};

				categoryService.get(params, function(data) {
					$('input[name=category_name]').val(data.category_name);
					
	 				for(var i = 0; i < 5; i++) {
	 					if($('#registerModal input[name=category_color]')[i].id==data.category_color) {
	 						console.log('색상 확인'+data.category_color);
	 						$('.color'+(i+1)).prop('checked', true);
	 						$('.color'+(i+1)).prev().css('border','3.5px #BDBDBD solid');
	 	 				}
	 				}
	 				
	 				$('#updateCgrBtn').data('cgrno', data.category_no);
	 				$('#deleteCgrBtn').data('cgrno', data.category_no);
	 				
	 				if(data.attendees!=null) {
	 				var arr = data.attendees;
	 				var name = data.emp_name;
	 				var dept = data.dept_name;
	 				
	 				for(var i = 0; i < arr.length; i++) {
	 						$('div[class=attendees-group]').append(arr[i]+"-");
	 						$('div[class=attendees-group]').append(name[i]+"-");
	 						$('div[class=attendees-group]').append(dept[i]+",");
	 				}
	 				}
	 				
	 				$('div[class=attendees-group]').append('<hr><label>추가할 참여자</label><br>');
	 				
				})
				
				$('#registerModal').show();
			})
			
			$('#updateCgrBtn').on('click', function() {
				
				var category_no = $(this).data('cgrno');
				var category_color = $('#registerModal input[type=radio][name=category_color]:checked').attr('id');
				
				var attValue = $('#registerModal input[type=checkbox][name=attendees]').length;
		 	    console.log('len'+attValue);
		    	var attData = new Array(attValue);
		    	
		    	var j = 0;
		    	for(var i = 0; i < attValue; i++) {
		 	    	if($('#registerModal input[name=attendees]')[i].checked) {
		 	    		attData[j] = Number($('#registerModal input[name=attendees]')[i].value);
		 	    		j++;
		 	    	}
		    	}
				console.log('j....'+attData);
				
				var category = {category_no:category_no, emp_no:emp_no, category_name:$('input[name=category_name]').val(), category_color:category_color, attendees:attData};
				
				categoryService.update(category, function(result) {
					alert(result);
					
					modal.find("input").val("");
					$('#mask, .modal, #calendar-sub-info').hide();  
					console.log("result......."+result);
					 showList(); 
					 showCalendar();
				});
				
				});
			
			$('#deleteCgrBtn').on('click', function() {
				var category_no = $(this).data('cgrno');
				var params = {category_no:category_no, emp_no:emp_no};
				
				categoryService.remove(params, function(result) {
					alert(result);
					
					modal.find("input").val("");
					$('#mask, .modal, #calendar-sub-info').hide();  
					console.log("result......."+result);
					showList();
					showCalendar();
				})
				
			})
	
	</script>
	
	
	
	
	
	<!-- schedule service event -->
	<script type="text/javascript">
/* 		$('#datetimepicker1').datetimepicker({
		});

		$('#datetimepicker2').datetimepicker({
		}); */

		$('#registerSch').on('click', function() {
			modal.find("input").val("");
			modal.find('.attendees-group').empty();
			modal.find('.suggestList tbody').empty();
			modal.find("#pickColor").empty();
			hide('selColor');
			wrapWindowByMask('registerSch');
			$('#registerSchModal').show();
		});

		$('#selColor').on('click', 'li', function() {
			var color = $(this).next().val();
			var str = $(this).html();
			
			console.log('color'+color+'str'+str);
			$('#registerSchModal input[name=category_no]').val(color);
			$('#pickColor').html(str);
			
			var params = {category_no : color};
			
			categoryService.get(params, function(data) {
				$('#registerSchModal .attendees-group').empty();
				
				var attno = [];
				var attname = [];
				var attdept = [];
			
				attno = data.attendees;
				attname = data.emp_name;
				attdept = data.dept_name;
				
				var len = attname.length;
				console.log('성공'+len);

		    	for(var i = 0; i < len; i++) {
		    		$('#registerSchModal .attendees-group').append('<span id="members"><input type="checkbox" name="attendees" value="'+ attno[i] + '" checked="checked" style="display:none">'
							+ attname[i] +'-'+attdept[i]+' ['+attno[i]+']</input></span>');
		    	}
		    	
			})
			
			
			hide('selColor');
			$('#selColor > div').empty();
			$('#suggestList tbody').empty();
			
		})

		$('#pickColor').on('click', function() {
			console.log('성공');

			categoryService.getList(function(data){
				var html = '<ul>';
	
				$.each(data, function(index, item) {
					html += "<li class='myColorList' ><div class='colorSchList' style='background-color:" 
							+ item.category_color + "'></div>"+item.category_name+"</li><input type='hidden' value='"+item.category_no+"'>";
					console.log('d'+item.category_color);
				});
				
				html += '</ul>';
				console.log('성공');
				$('#selColor > div').append(html);
			});
			show('selColor');
		})
		
		$('#insertSchBtn').on('click', function() {
			var schedule = '';
			
			var emp_no = 12305;
			var category_no = $('#registerSchModal input[name=category_no]').val();
			var schedule_title = $('#registerSchModal input[name=schedule_title]').val();
			var schedule_contents = $('#registerSchModal input[name=schedule_contents]').val();
			var schedule_starttime = $('#registerSchModal input[name=schedule_starttime]').val();
			var schedule_endtime = $('#registerSchModal input[name=schedule_endtime]').val();			
			
			var attValue = $('#registerSchModal input[type=checkbox][name=attendees]').length;
	 	    console.log('len'+attValue);
	    	
	 	    var attData = new Array(attValue);
	    	var j = 0;
	    	for(var i = 0; i < attValue; i++) {
	 	    	if($('#registerSchModal input[name=attendees]')[i].checked) {
	 	    		attData[j] = Number($('#registerSchModal input[name=attendees]')[i].value);
	 	    		j++;
	 	    	}
	    	}
	    	
	    	console.log('j'+attData);
	    	
	    	var schedule = {emp_no : emp_no, category_no : category_no, schedule_title : schedule_title, schedule_contents : schedule_contents, schedule_starttime : schedule_starttime, schedule_endtime : schedule_endtime, attendees : attData};
			
			scheduleService.add(schedule, function(result) {
				alert(result);
				modal.find("input").val("");
				$('#mask, .modal').hide();  
				 showList(); 
				 showCalendar();
			})
			
		})
		
		function drag(ev) {     

			ev.dataTransfer.setData("text", ev.target.id); 
		}

		function drop(ev) { 
			ev.preventDefault(); 

			var data = ev.dataTransfer.getData("text"); 
			ev.target.appendChild(document.getElementById(data)); 
			
			var schedule_no = (Number) (data.substring(data.indexOf('-')+1));
			
			//20190201
			var transDate = ev.target.id;
			var transYear = transDate.substring(0,4);
			var transMonth = transDate.substring(4,6);
			var transDay = transDate.substring(6);
			var fs_transDate = transYear+'/'+transMonth+'/'+transDay;
			var fs_transDate2 = new Date(fs_transDate);
			
			console.log('transdate.....'+fs_transDate);
			
			//0000-00-00 00:00~0000-00-00 00:00
			var originDate = $('#'+data).attr("name");
			var s_originDate = originDate.substring(0,originDate.indexOf('~'));
			var e_originDate = originDate.substring(originDate.indexOf('~')+1);
			
			var s_Date = new Date(s_originDate.substring(0,10));
			var e_Date = new Date(e_originDate.substring(0,10));
			
			var diff = dateDiff(s_Date, fs_transDate2);
			
			
			var fe_transDate ='';
			if(s_Date < fs_transDate2) {
				fe_transDate = e_Date.setDate(e_Date.getDate() + diff); /* 날짜 + 1일 */
			}
			else {
				fe_transDate = e_Date.setDate(e_Date.getDate() - diff); /* 날짜 + 1일 */
			}
			var schedule_starttime = fs_transDate + s_originDate.substring(10);
			var schedule_endtime = moment(fe_transDate).format('YYYY/MM/DD')+e_originDate.substring(10);
			
			console.log('transdate.....'+schedule_starttime+':'+schedule_endtime);
			
			var schedule = {schedule_no : schedule_no, schedule_starttime : schedule_starttime, schedule_endtime : schedule_endtime};
			
			scheduleService.update(schedule, function(data) {
				alert(data);
				showList();
				showCalendar();
			})  
		}
		
		function allowDrop(ev) { 
			ev.preventDefault(); 
		}

</script>

</body>



<!------------------------------ 알림 -------------------------------------------->

<script type="text/javascript">
/* const $id = $('#notSch');
$('#notifi').hide();

var location_emp = $('input[name=location_emp]').val();
var location_noti = '';
	


var path = 'http://localhost:8080/test/events?key=babo'
console.log('path:'+path);
var goSSE = function () {
	const eventSource = new EventSource(path); 
	// eventSource 주소에서 메세지를 발생시키면 아래 메서드가 실행된다.
	eventSource.onmessage = function(event){
		console.log(event.data);
	  	console.log(event);
		$('#notifi').html('알림 도착'+event.data);
		$('#notifi').animate({top:'68px'});
		$('#notifi').show();
	};
};

(function() {
	goSSE();
	console.log('gogo');
})();


function fnOnLoad() {
	console.log('clicked');
	
	location_noti = $('input[name=attendees]').val();
	console.log('emp:'+location_noti);
	
	$.ajax({
	    url : '/test/signal',
	    type : 'POST',
	    data : {
	        'key' : 'babo'
	    },
	    dataType:'application/x-www-form-urlencoded',
	    success : function(data) { 
	    	
	    },
	    error : function(request,error)
	    {
	    }
	});	
}
	 */
	 
/* (function poll() {
	$.ajax({
		url: "/test/longpolling.do",
		dataType: "json",
		method: "post",
		complete: poll,
		timeout: 30000,
		success: function(data) {
			alert(data.success+" : "data.message);
		},
		error : function(request,error)
	    {
	    }
	})
})
 */
</script>
</html>