<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/bootstrap.js"></script>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<title>STARWARE(Groupware)</title>


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
				<li class="active"><a href="/chat/messengerFind">메세지함<span
						id="unread" class="label label-info"></span></a></li>
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
		<form role="form" action="insertProject" method="post">
			
			<input type="hidden" name="emp_No" value="12301">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="5"><h4>프로젝트 등록</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>작성자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Writer" name="project_Writer" maxlength="20"
							value="${emp_name}"></td>

						<td><h5>프로젝트 종류</h5></td>
						<td colspan="2"><select name="project_Kind"
							onChange="getSelectValue(this.form);" class="form-control">
								<option value="품질개선">품질개선</option>
								<option value="검증">검증</option>
								<option value="유지보수">유지보수</option>
								<option value="개발">개발</option>
						</select></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>담당자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Manager" name="project_Manager" maxlength="20"></td>

						<td style="width: 110px;"><h5>진행상태</h5></td>
						<td colspan="2"><select name="project_Situation"
							onChange="getSelectValue" class="form-control">
								<option value="예정">예정</option>
								<option value="완료">완료</option>
								<option value="보류">보류</option>
								<option value="폐기">폐기</option>
						</select></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>팀원</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Members" name="project_Members" maxlength="20"></td>

						<td style="width: 110px;"><h5>계획시작일</h5></td>
						<td colspan="2"><input class="form-control" type="date"
							id="project_Start_Date" name="project_Start_Date" maxlength="20"></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>제목</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Title" name="project_Title" maxlength="20"></td>

						<td style="width: 110px;"><h5>계획종료일</h5></td>
						<td colspan="2"><input class="form-control" type="date"
							id="project_End_Date" name="project_End_Date" maxlength="20"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>기간</h5></td>
						<td colspan="2"><input class="form-control" type="number"
							id="project_Term" name="project_Term" maxlength="20"></td>
					</tr>
					<tr>

						<td style="width: 110px;"><h5>내용</h5></td>
						<td colspan="2"><textarea class="form-control" rows="10"
								cols="120" name="project_Contents" maxlength="20"></textarea></td>
						<td colspan="2" rowspan="2"></td>
					</tr>
				</tbody>
			</table>
				<div class="row">
					<div class="uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					</div>
			<button type="submit" class="btn btn-primary pull" style="margin-left: 485px">프로젝트 저장</button>
			<input type="button" class="btn btn-primary pull" value="프로젝트 목록" onclick="location.href='listProjectForm'">
		</form>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(e){
			
			 var formObj = $("form[role='form']");
			  
			  $("button[type='submit']").on("click", function(e){
			    
			    e.preventDefault();
			    
			    console.log("submit clicked");
			    
			    var str = "";
			    
			    $(".uploadResult ul li").each(function(i, obj){
			      
			      var jobj = $(obj);
			      
			      console.dir(jobj);
			      console.log("-------------------------");
			      console.log(jobj.data("filename"));
			      
			      
			      str += "<input type='hidden' name='attachList["+i+"].project_fileName' value='"+jobj.data("filename")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].project_uuid' value='"+jobj.data("uuid")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].project_uploadPath' value='"+jobj.data("path")+"'>";
			      
			    });
			    
			    console.log(str);
			    
			    formObj.append(str).submit();
			    
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
			      url: '/project/uploadAjaxAction',
			      processData: false, 
			      contentType: false,data: 
			      formData,type: 'POST',
			      dataType:'json',
			        success: function(result){
			          console.log(result); 
					  showUploadResult(result); //업로드 결과 처리 함수 

			      }
			    }); //$.ajax
			    
		  });
			    function showUploadResult(uploadResultArr){
				    
			        if(!uploadResultArr || uploadResultArr.length == 0){ return; }
			        
			        var uploadUL = $(".uploadResult ul");
			        
			        var str ="";
			        
			        $(uploadResultArr).each(function(i, obj){
			    			var fileCallPath =  encodeURIComponent( obj.project_uploadPath+"/"+ obj.project_uuid +"_"+obj.project_fileName);			      
			    		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			    		      
			    			str += "<li "
			    			str += "data-path='"+obj.project_uploadPath+"' data-uuid='"+obj.project_uuid+"' data-filename='"+obj.project_fileName+"' ><div>";
			    			str += "<span> "+ obj.project_fileName+"</span>";
			    			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
			    			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			    			str += "<img src='/resources/images/attach.png'></a>";
			    			str += "</div>";
			    			str +"</li>";
			        });
			        
			        uploadUL.append(str);
			      }

			    $(".uploadResult").on("click", "button", function(e){
				    
			        console.log("delete file");
			          
			        var targetFile = $(this).data("file");
			        var type = $(this).data("type");
			        
			        var targetLi = $(this).closest("li");
			        
			        $.ajax({
			          url: '/project/deleteFile',
			          data: {fileName: targetFile, type:type},
			          dataType:'text',
			          type: 'POST',
			            success: function(result){
			               alert(result);
			               
			               targetLi.remove();
			             }
			        }); //$.ajax
			       });
			    
			  });  
	</script>
	<script type="text/javascript">
	function getSelectValue(frm) {
		frm.project_Situation.value = frm.situation.option[frm.project_Situation.selectedIndex].text;
		frm.project_Kind.value = frm.Kind.option[frm.project_Kind.selectedIndex].text;
	};
</script>
	
	
</body>
</html>