<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/bootstrap.js"></script>
  <script>
$( function() {
	  
	$("#today").text(new Date().toLocaleDateString());
	  
    $( "#start" ).datepicker({ 
    	dateFormat: 'yy-mm-dd',
    	onClose: function( selectedDate ) {    
            // 시작일(fromDate) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#start").datepicker( "option", "minDate", selectedDate );
        }       
    });
	
 	 $( "#end" ).datepicker({ 
 		 dateFormat: 'yy-mm-dd',
 		onClose: function(selectedDate){
 			$("#start").datepicker("option", "maxDate", selectedDate);
 		} 
 	 });
  });
  </script>
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
			response.sendRedirect("/login");
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
            <li class="active"><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
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

<form role="form" id="form" name="form" action="noticeUpdate" method="post" >
	<input type="hidden" name="notice_no" value="${notice.notice_no}">
	<input type="hidden" name="notice_hitCount" value="${notice.notice_hitCount}">
	<input type="hidden" name="notice_regdate" value="${notice.notice_regdate}">
	<input type="hidden" name="emp_no" value="${notice.emp_no}">
	<input type='hidden' name='pageNum' value='<c:out value="${ncri.pageNum }"/>'>
    <input type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
	
	
	<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd;">
	<thead>
		<tr><th colspan="4"><h4>공지사항 수정</h4></th></tr>
	</thead>
		
	<tbody>
		<tr>
			<td style="width: 110px;"><h5>카테고리</h5></td>
			<td colspan="3" style="text-align: left">
				<select name="notice_subject" id="notice_subject">
					<option label="안 내">안 내</option>
					<option label="인 사">인 사</option>
					<option label="기 타">기 타</option>
				</select>
			</td>
		</tr>
	
		<tr>
			<td style="width: 110px;"><h5>제목</h5></td>
			<td colspan="3"><input class="form-control" type="text"
										name="notice_title" value="${notice.notice_title }"></td>
		</tr>
	
		<tr>
			<td style="width: 110px;"><h5>내용</h5></td>
			<td colspan="3">
			<textarea rows="10" cols="100" name="notice_contents"> ${notice.notice_contents }</textarea>
		</tr>
	
		<tr>
			<td style="width: 110px;"><h5>시작일</h5></td>
			<td style="width: 40%">
			<input class="form-control" type="text" id="start" name="notice_startDate" 
				value="${notice.notice_startDate}">
			</td>
			<td style="width: 110px;" colspan="2">
			</td>
				
		</tr>
		<tr>
			<td style="width: 110px;"><h5>종료일</h5></td>
			<td style="width: 40%">
				<input class="form-control" type="text" id="end" name="notice_endDate" 
					value="${notice.notice_endDate}">
			</td>
			<td style="width: 110px;"><h5>진행상태</h5></td>
			<td style="text-align: left">
				<select name="notice_state">
					<option label="진행중">진행중</option>
					<option label="완료">완료</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="text-align: left" colspan="4">
				<div align="right">
					<button type="submit" data-oper='update' class="btn btn-default">수정</button>
					<button type="submit" data-oper='list' class="btn btn-default">취소</button>
				 </div>
			 </td>
		</tr>
	
	</tbody>
	</table>

</form>

<div>
			<table class="table table-bordered table-hover"
				style="text-align: left; border: 1px solid #dddddd;">
				<thead></thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>&nbsp; &nbsp; 파일첨부</h5></td>
						<td>
						<div class='uploadDiv'>
						<input type="file" name="uploadFile" multiple="multiple">
						</div>
						<div class='uploadResult'>
						<ul>
						
						</ul>
						</div>
						
						</td>
					</tr>
				</tbody>
			</table>

		</div>










</div>


<script>
$(document).ready(function(){
	
	 (function(){

		var notice_no='<c:out value="${notice.notice_no}"/>';
	
		$.getJSON("/notice/getAttachList", {notice_no: notice_no}, function(arr){
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i, attach){
	
			var fileCallPath =  encodeURIComponent("/"+attach.notice_uploadPath+ "/s_"+attach.notice_uuid+"_"+attach.notice_fileName);
		        		  
		        	 str += "<li data-path='"+attach.notice_uploadPath+"' data-uuid='"+attach.notice_uuid+"' data-filename='"+attach.notice_fileName+"'><div>";
		        	 str += "<span> "+ attach.notice_fileName+"</span>";
		        	 str += "<img src='/resources/images/notice_attach.jpg' style='width: 30px; height: 30px;'></a>";
		        	 str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-default'><i class='fa fa-times'></i></button>";
		        	 str += "</div>";
		        	 str +"</li>";
		        	 	 
		        	   });
		        	 		         
		        $(".uploadResult ul").html(str);
		      
		}); //end getJSON	
	})(); //end function
	
	$(".uploadResult").on("click", "button", function(e){
	
		if(confirm("Remove this file?")){
			
			var targetLi=$(this).closest("li");
			targetLi.remove();
		}
		
	});
	
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
	  
	  function checkExtension(fileName, fileSize){
	    
	    if(fileSize >= maxSize){
	      alert("파일 사이즈 초과");
	      return false;
	    }
	    
	    if(regex.test(fileName)){
	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
	      return false;
	    }
	    return true;
	  }
	
	
	  $("input[type='file']").change(function(e){
		    var formData = new FormData();
		    
		    var inputFile = $("input[name='uploadFile']");
		    
		    var files = inputFile[0].files;
		    
		    for(var i = 0; i < files.length; i++){
		      if(!checkExtension(files[i].name, files[i].size) ){
		        return false;
		      }
		      formData.append("uploadFile", files[i]);
		      
		    }
	  
		    $.ajax({
			      url: '/notice/uploadAjaxAction',
			      processData: false, 
			      contentType: false,
			      data: formData,
			      type: 'POST',
			      dataType:'json',
			        success: function(result){
			          console.log(result); 
			          showUploadedFile(result); //업로드 결과 처리 함수 
			      }
			    }); //$.ajax  
	
	
});
	  
		function showUploadedFile(uploadResultArr){
			
			if(!uploadResultArr||uploadResultArr.length==0){return;}

			var uploadUL=$(".uploadResult ul");
			
			var str = "";
		
			 $(uploadResultArr).each(function(i, obj) {

				 
				if(!obj.image){
					var fileCallPath =  encodeURIComponent("/"+ obj.uploadPath+ "/"+obj.uuid+"_"+obj.fileName);
					var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str+="<li "
					str+="data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
					str+="<span>"+obj.fileName+"</span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-default'><i class='fa fa-times'></i></button>";
					str+="<img src='/resources/images/notice_attach.jpg' style='width: 30px; height: 30px;'></a>";
					str+="</div>";
					str+"</li>";
			
				}else{
					
					 var fileCallPath =  encodeURIComponent("/"+obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
					 
					 str+="<li data-path='"+obj.uploadPath+"'";
					 str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
					 str+=" ><div>";
					 str+="<span> "+obj.fileName+"</span>";
					 str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-default'><i class='fa fa-times'></i></button>";
					 str+="<img src='/notice/display?fileName="+fileCallPath+"'>";
					 str+="</div>";
					 str+"</li>";
					 
		
				}
			});
			 uploadUL.append(str);
		}



})

</script>




<script type="text/javascript">
$(document).ready(function() {
	var noticeUpdateForm=$("form");
    var title=document.form.notice_title;
	var contents=document.form.notice_contents;
	var start=document.form.notice_startDate;
	var end=document.form.notice_endDate;
	
	$('button').on("click", function(e){
		e.preventDefault();
		var noticeoper=$(this).data("oper");
		console.log(noticeoper);
		
		if(noticeoper==='update'){
			if(title.value==''||contents.value==''){
				  window.alert("제목과 내용을 입력해야 합니다.")
				  document.form.notice_title.focus();
				  document.form.notice_contents.focus();
				  return false;
			}
			if(end.value!=''&&start.value==''){
				window.alert('시작일을 입력해야 합니다.')
				document.form.notice_startDate.focus();
				return false;
			}
			
			 var str = "";
	  	        
	  	        $(".uploadResult ul li").each(function(i, obj){
	  	          
	  	          var jobj = $(obj);
	  	          
	  	          console.dir(jobj);
	  	          
	  	          str += "<input type='hidden' name='attachList["+i+"].notice_fileName' value='"+jobj.data("filename")+"'>";
	  	          str += "<input type='hidden' name='attachList["+i+"].notice_uuid' value='"+jobj.data("uuid")+"'>";
	  	          str += "<input type='hidden' name='attachList["+i+"].notice_uploadPath' value='"+jobj.data("path")+"'>";
	  	          
	  	        });
	  	      noticeUpdateForm.append(str).submit();
			
		
			noticeUpdateForm.attr("action", "/notice/noticeUpdate");
	
		}else if(noticeoper==='list'){
			noticeUpdateForm.attr("action", "/notice/noticeList").attr("method", "get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
		    var amountTag = $("input[name='amount']").clone();
		  	var keywordTag = $("input[name='keyword']").clone();
		    var typeTag = $("input[name='type']").clone(); 
			
		    noticeUpdateForm.empty();
		    noticeUpdateForm.append(pageNumTag);
		    noticeUpdateForm.append(amountTag);
		    
		}
		noticeUpdateForm.submit();
	});
});
</script>



	




</body>
</html>