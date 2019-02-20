<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="/resources/css/detailProject.css">
<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

</style>
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
            <li><a href="/loginafter">메인</a></li>
            <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/listProjectForm">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
            <li class="active"><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
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
	
	<h3 align="center">프로젝트 상세보기</h3>
	<hr>
	<table class="detail" width="1000" border="1" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td>번호</td>
			<td>${project.project_No }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${project.project_Regdate }</td>
		</tr>
		<tr>
			<td>프로젝트 제목</td>
			<td>${project.project_Title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${project.project_Writer }</td>
		</tr>
		<tr>
			<td>담당자</td>
			<td>${project.project_Manager }</td>
		</tr>
		<tr>
			<td>기간</td>
			<td>${project.project_Term }</td>
		</tr>
		<tr>
			<td>계획시작일</td>
			<td>${project.project_Start_Date }</td>
		</tr>
		<tr>
			<td>계획종료일</td>
			<td>${project.project_End_Date }</td>
		</tr>
		<tr>
			<td>프로젝트 종류</td>
			<td>${project.project_Kind }</td>
		</tr>
		<tr>
			<td>진행상태</td>
			<td>${project.project_Situation }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${project.project_Contents }</td>
		</tr>
	</table>
	
			<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        
        <div class='uploadResult'> 
          <ul>
          </ul>
        </div>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
	
	
	<button data-oper="update" class="btn btn-primary pull" style="text-align: center">수정하기</button>
	<button data-oper="delete" class="btn btn-primary pull" style="text-align: center">삭제하기</button>
	<button data-oper="list" class="btn btn-primary pull" style="text-align: center">목록</button>

	
	<form id='listAction' action="project/listProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
	<form id='deleteFormAction' action="project/deleteProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
	<form id='updateFormAction' action="project/updateProjectForm" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
<script type="text/javascript">
$(document).ready(function () {
	 
		(function(){
			
	  var project_No = '<c:out value="${project.project_No}"/>';
	  
	  $.getJSON("/project/getAttachList", {project_No: project_No}, function(arr){
		
		  console.log(arr);
		  
		  var str="";
		  
		  $(arr).each(function(i, attach){
		         if(attach.project_fileName){
/*  		             var fileCallPath =  encodeURIComponent( attach.project_uploadPath+ "/s_"+attach.project_uuid +"_"+attach.project_fileName);
		             
 		             str += "<li data-path='"+attach.project_uploadPath+"' data-uuid='"+attach.project_uuid+"' data-filename='"+attach.project_fileName+"'><div>";
		             str += "<img src='/project/display?project_fileName="+fileCallPath+"'>";
		             str += "</div>";
		             str +"</li>";
		           }else{ */
		               
		             str += "<li data-path='"+attach.project_uploadPath+"' data-uuid='"+attach.project_uuid+"' data-filename='"+attach.project_fileName+"'><div>";
		             str += "<span> "+ attach.project_fileName+"</span><br/>";
		             str += "<img src='/resources/images/attach.png'></a>";
		             str += "</div>";
		             str +"</li>";
		          } 
		         });
		         
		         $(".uploadResult ul").html(str);
		         
		         
		       });//end getjson

		      
		    })();//end function

$(".uploadResult").on("click","li", function(e){
    
    //console.log("view image");
    
    var liObj = $(this);
    
    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    
    if(liObj.data("uuid") == null){
    	showImage(path.replace(new RegExp(/\\/g),"/"));
    }else {
      //download 
      self.location ="/project/download?fileName="+path
    }
    
});
  });
  
</script>
<script type="text/javascript">

	$(document).ready(function() {
		var listAction = $("#listAction");
		var updateFormAction = $("#updateFormAction");
		var deleteFormAction = $("#deleteFormAction");

		$("button[data-oper='update']").on("click", function(e) {
			updateFormAction.attr("action", "/project/updateProjectForm").submit();
	}); 

		$("button[data-oper='list']").on("click", function(e) {
			listAction.find("#project_No").remove();
			listAction.attr("action", "/project/listProjectForm")
			listAction.submit();
	});
	
		$("button[data-oper='delete']").on("click", function(e) {
			deleteFormAction.attr("action", "/project/deleteProjectForm").submit();
	}); 
	
	});
</script>
	
	</div>
	
	
</body>
</html>