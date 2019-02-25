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
		$('#datetimepicker1').datetimepicker({
		});

		$('#datetimepicker2').datetimepicker({
		}); 
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
	
<script type="text/javascript">
	var emp_no = "<%=(String)session.getAttribute("emp_no")%>"
	var params = {emp_no : emp_no}
	var grade_no = '';
	empService.get(params, function(data) {
		console.log('dataname'+data.emp_name);
		grade_no = data.grade_no;
/* 		if(data.grade_no<40) {
			$('#registerModal #공유').attr('disabled', true);
			$('#registerSchModal #공유').attr('disabled', true);
			$('.popupLayer2 #편집').attr('disabled', true);
		} */
	})
</script>

	<!-- start container -->
	<div id="mask"></div>
	<div id="container">
	<div id="ca-header">
		<a href="/schedulePage/"><h3>일정 관리</h3></a>
			<div class="btn-group" style="position:absolute;top:90px;right:150px">
				<input type="button" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedulePage/' />'" value="캘린더" /> 
				<input type="button" class="btn btn-secondary" onclick="javascript:location.href='<c:url value='/schedulePage/listSch' />'" value="목록" /> 
			</div>
		<hr class="menu-line">
	</div>
			<div id="calendar-sub-info">
			<ul class="list-group">
				<li class="register list-group-item">생성</li>
				<li class="listedit list-group-item">편집</li>
			</ul>
		</div>
		<div id="side-bar">
		<ul id="calendar-info">
			<div class="list">
				<li class="sub" id="title">My Calendar</li>
				<table id="mylist" class="table"><tbody>
				<hr class="menu-line2 sub">
				<div id="개인캘린더"><label>내 캘린더</label></div>
				<hr class="menu-line2 sub">
				<div id="공유캘린더" ><label>공유 받은 캘린더</label></div>
				</tbody></table>
			</div>
		</ul>
		</div>

		<!-- start calendar -->
				<div id="content">
				<br>
				<table class="calendar-header">
					<tr>
					
					<td align="left">
						<input type="button" id="registerSch" class="btn btn-primary" value="일정 등록" />
						<input type="button" id="notSch" class="btn btn-primary" value="알림" />
<%-- 						<input type="button" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedulePage/' />'" value="오늘" /> --%>
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
						<div class="form-row">
							<div class='form-group col-md-8' style="margin:0px;padding:0px;">
							<input type='text' class='form-control' name='' style="margin:0px;padding:0px;margin-right:-50px">
							</div>

							<input type="button" id="searchSch" class="btn btn-primary" onclick="javascript:location.href='<c:url value='/schedulePage/listSch' />'"  value="검색"/>

						</div>
					<%-- 	<div class="btn-group">
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="day" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="week" /> 
							<input type="button" class="btn btn-secondary border-dark" onclick="javascript:location.href='<c:url value='/schedule/scheduleMain' />'" value="month" />
						</div> --%>
					</td>
					</tr>
				</table>
				<br>
				<!-- 캘린더 컨텐츠 -->
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
						<button type='' id='listPwrBtn' data-cgrno=''
							class='btn btn-primary'
							style="position: absolute; left: 138px; top: 12px;">목록</button>
						<button type='' id='updatePwrBtn' data-cgrno=''
							class='btn btn-primary'
							style="position: absolute; left: 200px; top: 12px;">수정</button>
					</div>

					<div class='modal-body'>
					</div>
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
								<label>카테고리 종류</label><br> 
								<input type='radio' name='category_type' id='개인' />개인
								<input type='radio' name='category_type' id='공유' />공유
							</div>
								
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
							
							<div id="member-group" class='form-group col-md-12' style="display:none">
								<label>참여자</label>
								<div id='nome_iscrizione' class='member-contents'></div>
							</div>
							
							<div id="add-group" class='form-group col-md-12'>
								<label>참여자</label>
						<table class="table table-bordered">
											<thead>
												<tr>
													<td>사원명</td>
													<td>직급명</td>
													<td>부서명</td>
													<td>사번</td>
													<td colspan="3">권한</td>
													<td>삭제</td>
												</tr>
											</thead>
											<tbody class="attendees-group">
											</tbody>
										</table>
							</div>
							
							<div id="search-group" class='form-group col-md-12'>
								<label>참여자 검색</label> <input class="form-control" type="text"
									maxlength="20" id="temp1" onkeyup="startSuggest()">
								<div id="suggest">
									<div class="form-control"
										style="background-color: white; overflow-y: scroll; position: absolute; text-align: left; width: 95%; height: 120px">
										<table class="table table-bordered" id="suggestList">
											<thead>
												<tr>
													<td>사원명</td>
													<td>직급명</td>
													<td>부서명</td>
													<td>사번</td>
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

				<input type='hidden' name='schedule_no' value=''> <input
					type='hidden' name='emp_no' value='12305'>

				<div class='form-group col-md-12'>
					<label>일정명</label> <input type='text' class='form-control'
						name='schedule_title'>
				</div>

				<div class="form-row">
					<div class='form-group col-md-6'>
						<label>카테고리 색상</label><br> <input type='hidden'
							class='form-control' name='category_no' value=''>
						<div id='pickColor' class='form-control'>클릭하세요.</div>
						<div id='selColor'>
							<div class='form-control'
								style='background-color: white; overflow-y: scroll; position: absolute; text-align: left; width: 96%; height: 280%; z-index: 1000'>
							</div>
						</div>
					</div>

					<div class='form-group col-md-6'>
						<label>카테고리 종류</label><br> <input type='radio'
							name='category_type' id='개인' />개인 <input type='radio'
							name='category_type' id='공유' />공유
					</div>
				</div>

				<div class="form-row">
					<div class='form-group col-md-6'
						style="position: absolute; top: 160px;">
						<label>시작일</label> <input type='text' class='form-control'
							id='datetimepicker1' name='schedule_starttime'>
					</div>

					<div class='form-group col-md-6' style="margin-top: 9px">
						<label>종료일</label> <input type='text' class='form-control'
							id='datetimepicker2' name='schedule_endtime'>
					</div>
				</div>

				<!-- 							<div class='form-group col-md-12'>
								<label>파일첨부</label> 
								<input type='file' name=''>
							</div> -->

				<div class='form-group col-md-12'>
					<label>내용</label> <input type='text' class='form-control'
						name='schedule_contents'>
				</div>

				<!-- <div class='form-group col-md-12'>
								<label>remind 알림</label> 
								<input type='radio' name='not_remindyn' value='1'>YES
								<input type='radio' name='not_remindyn' value='0'>NO
							</div>  -->

				<div id="member-group" class='form-group col-md-12'>
					<label>참여자</label>
					<div id='nome_iscrizione' class='member-contents'></div>
				</div>

				<div id="add-group" class='form-group col-md-12'>
					<label>참여자</label>
					<!-- <div id='nome_iscrizione' class='attendees-group'></div> -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<td>사원명</td>
								<td>직급명</td>
								<td>부서명</td>
								<td>사번</td>
								<td colspan="3">권한</td>
								<td>삭제</td>
							</tr>
						</thead>
						<tbody class="attendees-group">
						</tbody>
					</table>

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
											<td>직급명</td>
											<td>부서명</td>
											<td>사번</td>
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
				<span onClick="closeLayer(this)"
					style="cursor: pointer; font-size: 1.5em" title="닫기">X</span>
			</div>
			<div id="detail-content">여긴 레이어~ 클릭하면 바로 나타나는 레이어에요^^</div>
		</div>
	
	</div>


<!--  category service event -->
	<script type="text/javascript">
		var category = '';
		var modal = $('.modal');
		
		$('#registerModal').on('click', '#편집', function() {
			if(grade_no<40) {
				$(this).prop('disabled', true);
				$(this).prop('checked', false);
				alert('권한 없음'+grade_no);
			}
		})
		
/* 		$('.attendees-group').on('change', '.pickpwr', function(){
			if ($(this).is(':checked')) {
					var pickmb = $(this).closest('tr').find('input[type=checkbox][name=attendees]').val();
		        	pickmb += $(this).val();
		        	$(this).parents('tr').find('input:checkbox[name=power_group]').val(pickmb);
			}
	    	}); */
	
		$('#insertCgrBtn').on('click', function() {
			
			var category_type = $('input[type=radio][name=category_type]:checked').attr('id');
			console.log('type'+category_type);
			var colorValue = $('#registerModal input[type=radio][name=category_color]').length;
	    	var colorData = new Array(colorValue);
	    	
	    	var attValue = $('#registerModal input[type=checkbox][name=power_group]').length;
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
	 	    	if($('#registerModal input[name=power_group]')[i].checked) {
	 	    		attData[j] = $('#registerModal input[name=power_group]')[i].value;
	 	    		j++;
	 	    	}
	    	}
	    	
	    	console.log('j'+attData);

	    	category = {category_type : category_type, category_name : $('#registerModal input[name=category_name]').val(), 
	    							category_color : category_color, power_group : attData};
		
			categoryService.add(category, function(result) {	
				alert(result);
				$('#registerModal .attendees-group').empty();
				$('#registerModal #suggestList tbody').empty();
				modal.find("input").val("");
				$('#mask, .modal, #calendar-sub-info').hide();  
				 showList(); 
				 showCalendar();
			});
			
		})
		
		$('.listedit, #listCgrBtn, #listPwrBtn').on('click', function(e) {
			
			$('#listeditModal').hide();
			$('#registerModal').hide();
			 wrapWindowByMask('listedit');

			e.preventDefault();
			
			categoryService.getList(function(data){
				
				var html = '';
				html += '<table class="table table-bordered"><thead><tr><td>캘린더 타입</td><td>캘린더 색상</td><td>캘린더 명</td><td>편집</td></tr></thead><tbody>';
				
				$.each(data, function(index, item) {
					console.log('color.......'+item.category_color);
 					html += "<tr><td>"+item.category_type+"</td><td><div class='colorModalList' style='background-color:" 
 									+ item.category_color + "'></div></td><td>" + item.category_name + "</td><td class='edit-area'><button class='cgr-edit-btn' data-cgrtype='"+item.category_type+"' data-cgrpwr='"+item.cgr_power+"' data-cgrno='"+item.category_no+"'>편집</button><button class='power-edit-btn' data-cgrtype='"+item.category_type+"' data-cgrpwr='"+item.cgr_power+"' data-cgrno='"+item.category_no+"'>권한 수정</button></td></tr>";
 				});
				
 				html += '</tbody></table>';
 				console.log('성공');
 				$('#listeditModal .modal-body').html(html);

			});
		});
		
		$('#listeditModal').on('click', 'button[class=power-edit-btn]', function() {
			if($(this).data('cgrpwr')<3 && $(this).data('cgrtype')=='공유') {
				alert('권한이 없습니다.');
			}
			else {
			$('#registerModal').hide();
			$('#listPwrBtn').show();
			$('#updatePwrBtn').show();
			var category_no = $(this).data('cgrno');
			var params = {category_no : category_no};
			
			categoryService.getPower(params, function(data){
				
				var html = '';
				var num = '';
				$('#listeditModal .modal-body').empty();
				html = '<table class="table table-bordered"><thead><tr><td>사원명</td><td>직급명</td><td>부서명</td><td>사번</td><td colspan="3">권한</td></tr></thead><tbody>';
				$('#listeditModal .modal-body').append(html);
				$.each(data, function(index, item) {
 					num = num +1;
					html = "<tr class='table-bordered'><td><input type='checkbox' name='attendees' value='"+ item.emp_no 
 					+ "' checked='checked' style='display:none'></input><input type='checkbox' name='power_group' value='' checked='checked' style='display:none'></input>"
 					+item.emp_name+"</td><td>" + item.grade_name + "</td><td>" + item.dept_name + "</td><td>" 
 					+ item.emp_no + "</td><td colspan='3'><input type='checkbox' class='pickpwr' id='"+num+"pwr-1' name='power_temp' value='1'></input> 열람  <input type='checkbox' id='"+num+"pwr-2' class='pickpwr' name='power_temp' value='2' /> 참석자 초대  <input type='checkbox' id='"+num+"pwr-3' class='pickpwr' name='power_temp' value='3' /> 편집 </td></tr>";
 					$('#listeditModal tbody').append(html);
 					
 					$('#'+num+'pwr-'+item.cgr_power).attr('checked', 'checked');
 					console.log('...'+item.cgr_power);
				});
 				html = '</tbody></table>';
 				$('#listeditModal .modal-body').append(html);
 				console.log('성공');
			});
		}
		});

			$('#listeditModal').on('click', 'button[class=cgr-edit-btn]', function() {
				
				if($(this).data('cgrpwr')<3 && $(this).data('cgrtype')=='공유') {
					alert('권한이 없습니다.');
				}
				else {
				$('#listeditModal').hide();
				$('#insertCgrBtn').hide();
				$('#updateCgrBtn').show();
				$('#deleteCgrBtn').show();
				$('#listCgrBtn').show();
				$('.color-selector .color').css('border', '');
				
				$('div[class=attendees-group]').empty();
				$('.member-contents').empty();
			    $('#member-group').css('display', 'none');
			    $('#registerModal .attendees-group').empty();
				$('#registerModal #suggestList tbody').empty();
				$('#listPwrBtn').css('display', 'none');
				$('#updatePwrBtn').css('display', 'none');
				
				var category_no = $(this).data('cgrno');
				var params = {category_no:category_no};

				categoryService.get(params, function(data) {
					
					$('#registerModal input[name=category_name]').val(data.category_name);
					$('#registerModal input[name=category_type][id='+data.category_type+']').prop('checked', true);
					console.log('type'+data.category_type);
					
	 				for(var i = 0; i < 5; i++) {
	 					if($('#registerModal input[name=category_color]')[i].id==data.category_color) {
	 						console.log('색상 확인'+data.category_color);
	 						$('.color'+(i+1)).prop('checked', true);
	 						$('.color'+(i+1)).prev().css('border','3.5px #BDBDBD solid');
	 	 				}
	 				}
	 				
	 				$('#updateCgrBtn').data('cgrno', data.category_no);
	 				$('#deleteCgrBtn').data('cgrno', data.category_no);
	 									
	 				categoryService.getPower(params, function(data) {
						$.each(data, function(index, item) {
							$('#registerModal .member-contents').append(item.emp_name+"-");
							$('#registerModal .member-contents').append(item.grade_name+"-");
							$('#registerModal .member-contents').append(item.dept_name+" [");
							$('#registerModal .member-contents').append(item.emp_no+"], ");
							
						});
					})
					console.log('data'+data.cgr_power);
					if(data.category_type=="공유"&&data.cgr_power<2) {
						// 삭제버튼 삭제
						$('#deleteCgrBtn').hide();
						// 참여자 부분 삭제 
						$('#member-group').hide();
						$('#add-group').hide();
						$('#search-group').hide();
					}
					if(data.category_type=="개인") {
						// 삭제버튼 삭제
						$('#deleteCgrBtn').hide();
						// 참여자 부분 삭제 
						$('#member-group').hide();
						$('#add-group').hide();
						$('#search-group').hide();
					}
					else {
						$('#deleteCgrBtn').show();
						$('#member-group').show();
						$('#add-group').show();
						$('#search-group').show();
						$('#add-group label').html('추가할 참여자');
						$('#member-group').show();
					}
					$('#registerModal').show();
				});
			}
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
				
				var category = {category_no:category_no, category_name:$('input[name=category_name]').val(), category_color:category_color, attendees:attData};
				
				categoryService.update(category, function(result) {
					alert(result);
					
					modal.find("input").val("");
					$('#mask, .modal, #calendar-sub-info').hide();  
					console.log("result......."+result);
					$('div[class=attendees-group]').empty();
					$('.member-contents').empty();
				    $('#member-group').css('display', 'none');
				    $('#registerModal .attendees-group').empty();
					$('#registerModal #suggestList tbody').empty();
					 showList(); 
					 showCalendar();
				});
				
				});
			
			$('#deleteCgrBtn').on('click', function() {
				var category_no = $(this).data('cgrno');
				var params = {category_no:category_no};
				
				categoryService.remove(params, function(result) {
					alert(result);
					
					modal.find("input").val("");
					$('#mask, .modal, #calendar-sub-info').hide();  
					console.log("result......."+result);
					$('div[class=attendees-group]').empty();
					$('.member-contents').empty();
				    $('#member-group').css('display', 'none');
				    $('#registerModal .attendees-group').empty();
					$('#registerModal #suggestList tbody').empty();
					showList();
					showCalendar();
				})
				
			})
	
	</script>
	
	
	
	
	
	<!-- schedule service event -->
	<script type="text/javascript">

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
			$('.member-contents').empty();
		    $('#member-group').css('display', '');
		    
			var params = {category_no : color};
			
			categoryService.get(params, function(data) {
				$('#registerSchModal input[name=category_type][id='+data.category_type+']').prop('checked', true);

 				categoryService.getPower(params, function(data) {
					$.each(data, function(index, item) {
						console.log('성공....item.emp_name'+item.emp_name);
						$('#registerSchModal .member-contents').append(item.emp_name+"-");
						$('#registerSchModal .member-contents').append(item.grade_name+"-");
						$('#registerSchModal .member-contents').append(item.dept_name+" [");
						$('#registerSchModal .member-contents').append(item.emp_no+"], ");
						
					});
				})
				if(data.category_type=='공유'&&data.cgr_power<2){
					$('#member-group').hide();
					$('#add-group').hide();
					$('#search-group').hide();
				}
				else {
					$('#add-group label').html('추가할 참여자');
				}
				
			});
			
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
		
		$('.list').on('change', '.cgrmb', function() {
			var cgrValue = $("input:checkbox[name=select-cgr]").length;
			var cgrtemp = $("input:checkbox[name=select-cgr]:checked").length;
		 	console.log('.....길이!!'+cgrtemp);
			 var cgrData = [];
			    for(var i=0; i<cgrValue; i++){                          
			    	if($("input:checkbox[name=select-cgr]")[i].checked) {
			    		cgrData[i] = $("input:checkbox[name=select-cgr]")[i].value;
			    		cgrData[i] = (Number) (cgrData[i].substring(cgrData[i].indexOf('-')+1));
			    		console.log('.....!!'+cgrData[i]+'type'+typeof(cgrData[i]));
			    	}
			    	else {
			    		$("input:checkbox[name=select-cgr]")[i].checked = false;
			    	}
			    }
			    showCalendar(cgrData);
		})

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