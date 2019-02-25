
var categoryService = (function() {
	
	function add(category, callback, error) {
		console.log('add reply..................');
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			type : 'post',
			url : '/schedule/insertCgr',
			data : category,
			dataType: 'text',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			}
			
		})
		
	}
	
	function getList(callback, error) {
		console.log('add reply..................');
		$.ajax({
			type : 'get',
			url : '/schedule/listCgr.json',
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
	
	}
	
	function remove(params, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/schedule/deleteCgr',
			data : params,
			dataType: 'text',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
			
		});
	}
	
	function update(category, callback, error) {
		
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			type : 'post',
			url : '/schedule/updateCgr',
			data : category,
			dataType: 'text',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
	}
	
	function get(params, callback, error) {
		
		$.ajax({
			type : 'get', 
			url : '/schedule/getCgr',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		})
	}
	
function getPower(params, callback, error) {
		
		$.ajax({
			type : 'get', 
			url : '/schedule/getPowerList',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		})
	}
	
	// replyservice 의 리턴값
	return {add : add, getList : getList, remove : remove, update : update, get : get, getPower : getPower};
	
	// replyservice 호출 동시에 함수를 실행하자.
})();






var scheduleService = (function() {
	
	function add(schedule, callback, error) {
		console.log('add reply..................'+schedule.schedule_contents+':'+schedule.schedule_title);
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			type : 'post',
			url : '/schedule/insertSch',
			data : schedule,
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
			
		})
		
	}
	
	function update(schedule, callback, error) {
		$.ajax({
			type : 'post',
			url : '/schedule/updateSchJson',
			data : schedule,
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
			
		})
	}
	
	function get(params, callback, error) {
		$.ajax({
			type : 'get',
			url : '/schedule/getSchJson',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
			
		})
	}
	
	function getList(params, callback, error) {
		$.ajax({
			type : 'get',
			url : '/schedule/listSchJson.json',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
			
		})
	}
	
	// replyservice 의 리턴값
	return {add : add, update : update, get : get, getList : getList};
	
	// replyservice 호출 동시에 함수를 실행하자.
})();









var empService = (function() {
	
	function get(params, callback, error) {
		$.ajax({
			type : 'get',
			url : '/schedule/getEmpJson',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
			
		})
	}
	
	// replyservice 의 리턴값
	return {get : get};
	
	// replyservice 호출 동시에 함수를 실행하자.
})();





function wrapWindowByMask(str){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  

    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});  

    //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다. 
    $('#mask').fadeTo("fast",0.6);    

    //윈도우 같은 거 띄운다.
    $('#'+str+'Modal').show();
}

function startSuggest() {
	var keyword = '';
	if($('#temp1').val()) {
		keyword = $('#temp1').val();
	}
	
	if($('#temp2').val()) {
		keyword = $('#temp2').val();
	}

	console.log('keyword.........'+keyword);
	
	var keywordData = { "keyword": keyword };
	
	$.ajax({
		url : '/schedule/listEmp',
		type : 'get',
		data : keywordData,
		dataType : 'json',
		success : function(data) {
			$('#suggest tbody').html('');
			var html = "";
			$.each(data, function(index, item) {
				var str = item.emp_no + ":"+item.emp_name+":"+item.dept_name+":"+item.grade_name;
				console.log('str..........'+str);
				html += "<tr><td><a href=javascript:select('" + str + "')>" + item.emp_name + "</a></td><td>"+item.grade_name+"</td><td>" 
								+ item.dept_name + "</td><td>" + item.emp_no + "</td></tr>";
			});
			console.log('성공');
			$('#suggestList tbody').append(html);
			show('suggest');
		}
	});
}

function show(elementId) {
	var element = document.getElementById(elementId);
	console.log(element);
	if (element) {
		element.style.display = "";
	}
}

function select(selectKeyword) {
/*              		hide('suggest');  */
	var emp_no = selectKeyword.substring(0, selectKeyword.indexOf(':'));
	var temp_word = selectKeyword.substring(selectKeyword.indexOf(':')+1);
	var emp_name = temp_word.substring(0, temp_word.indexOf(':'));
	var dept_name = temp_word.substring(temp_word.indexOf(':')+1, temp_word.lastIndexOf(':'));
	var grade_name = temp_word.substring(temp_word.lastIndexOf(':')+1);
	
$('.attendees-group').append('<tr><td><input type="checkbox" name="attendees" value="'+ emp_no + '" checked="checked" style="display:none"></input><input type="checkbox" name="power_group" value="" checked="checked" style="display:none"></input>'+ emp_name +'</td><td>'+grade_name+'</td><td>'+dept_name+'</td><td>'+emp_no+'</td><td colspan="3">	<input type="checkbox" class="pickpwr" name="power_temp" checked id="열람" value="1" /> 열람 <input type="checkbox" class="pickpwr" name="power_temp" id="초대" value="2" /> 참석자 초대 <input type="checkbox" class="pickpwr" name="power_temp" id="편집" value="3" /> 편집</div><td><button id="delete-btn">X</button></td></tr>');
if($('#개인').is(':checked')) {
	$('#초대').prop('disabled', true);
	$('#초대').prop('checked', false);
	$('#편집').prop('disabled', true);
	$('#편집').prop('checked', false);
}
}

function hide(elementId) {
	var element = document.getElementById(elementId);
	if (element) {
		
		element.style.display = "none";
	}
} 


function showList() {
	$('#개인캘린더 tr').remove();
	$('#공유캘린더 tr').remove();
	$('#회사캘린더 tr').remove();
	categoryService.getList(function(data){
		var html = '';
		$.each(data, function(index, item) {
				html = "<tr><td class='type1'><input type='checkbox' class='cgrmb' name='select-cgr' checked='checked' value='cgr-"+item.category_no+"' style='position:absolute;z-index:100;left:169px;'></input><div class='colorMainList' style='background-color:" 
								+ item.category_color + "'></div></td><td class='type2'>" + item.category_name + "</td></tr>";
				console.log('ddd'+item.category_type);
					$('#'+item.category_type+'캘린더').append(html);
			});
		
			console.log('성공');
		});
	};
	

	function dateDiff(_date1, _date2) {
	    var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
	    var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
	 
	    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
	    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
	 
	    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24));
	 
	    return diff;
	}

	 function showCalendar(cgrData) {
		console.log('params'+cgrData);
		jQuery.ajaxSettings.traditional = true;
		var params = '';
		if(cgrData!=null) {
			params = {cgr_no : cgrData};
		}
			
		$.ajax({
			type : 'get', 
			url : '/schedule/listSchJson.json',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr){
				$('.new').remove();
				$.each(data, function(index, item) {

					/*if($('')==item.category_no)*/
					var start = item.schedule_starttime;
					var end = item.schedule_endtime;
					var start_day = new Date(start.substring(0,10));
					var end_day = new Date(end.substring(0,10));
					
					//0000-00-00 00:00
/*					if(start.substring(5,7)==$('#mth').attr('name')||start.substring(6,7)==$('#mth').attr('name')) {
						if(start.substring(8,9)=='0'||end.substring(8,9)=='0') {
							start_day = start.substring(9,10);
							end_day = end.substring(9,10);
						}
						else {
							start_day = start.substring(8,10);
							end_day = end.substring(8,10);
						}*/
						
						var len = dateDiff(start_day, end_day);
						console.log('start_day..'+start_day+'end..'+end_day);
						
						var len2 = '';
						var remain = 7-(start_day.getDay());
						
						if((len+1) > (remain)) {
							len2 = (remain)*100;
							
							var re_day = new Date(start_day);
							re_day = re_day.setDate(re_day.getDate()+remain);
							
							var len3 = (dateDiff(re_day, end_day)+1)*100;
							
							var reformatDate = moment(re_day).format('YYYYMMDD');
							$("td[id='"+ reformatDate + "']").append("<div class='new' style='background-color:"+item.category_color+";width:"+len3+"%'><div class='colorCalendar' style='background-color:" 
									+ item.category_color + "'></div><a class='imgSelect'>"
									+item.schedule_title+" ("+item.attcount+")</a></div>");
						}
						else {
							len2 = (len+1) * 100;
						}
						
						console.log('len2..'+(7-(start_day.getDay()))+':'+(len+1));
						
						var formattedDate = moment(start_day).format('YYYYMMDD');
						
						console.log('date.......'+formattedDate+'len.......'+len);
						$("td[id='"+ formattedDate + "']").append("<div class='new' id='schno-"+item.schedule_no+"' name = '"+item.schedule_starttime+"~"+item.schedule_endtime+"' draggable='true' ondragstart='drag(event)' style='background-color:"
								+item.category_color+";width:"+len2+"%'><div class='colorCalendar' style='background-color:" 
									+ item.category_color + "'></div><a href='/schedulePage/getSch?schedule_no="+item.schedule_no+"'>"
						+item.schedule_title+" ("+item.attcount+") </a></div>");
						
/*					}*/
				});
	        },
	        error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
				
		}; 

$(document).ready(function(){
    //검은 막 띄우기
	var modal = $('.modal');
    $('.register').click(function(){
    	modal.find("input").val("");
        $('div[class=attendees-group]').empty();
        $('.color-selector .color').css('border', '');
        
        $('.member-contents').empty();
        $('#member-group').css('display', 'none');
        
        wrapWindowByMask('register');
        $('#insertCgrBtn').show();
        $('#updateCgrBtn').hide();
        $('#deleteCgrBtn').hide();
        $('#listCgrBtn').hide();
    });

    //닫기 버튼을 눌렀을 때
    $('.modal .close').click(function (e) {  
        //링크 기본동작은 작동하지 않도록 한다.
        e.preventDefault();  
        $('#mask, .modal, #calendar-sub-info').hide();  
    });       

    //검은 막을 눌렀을 때
    $('#mask').click(function () {  
        $(this).hide();  
        $('.modal').hide();  
    });      
    
    $('#calendar-info #title').on('click', function() {
    	console.log('성공');
    	$('#calendar-sub-info').show();
    })
    
    $('.color-selector .color').on('click', function() {
    	
    	$('.color-selector .color').css('border', '');
    	// 아래 코드 작동되는지 확인 필요
 		$(this).next('input[type=radio][name=category_color]').prop('checked', true);
 		$(this).css('border','3.5px #BDBDBD solid');
 		var colort = $(this).attr('id');
    	var colorValue = $('input[type=radio][name=category_color]').length;
 	    console.log('len'+colort);
    	var colorData = new Array(colorValue);
 	    for(var i=0; i<colorValue; i++){                          
 	    	colorData[i] = $('input[type=radio][name=category_color]')[i].checked;
 	    	console.log('-----'+colorData[i]);
 	    }
 	    
 	});
    
	$('.attendees-group').on('click', 'button', function(e) {
		e.preventDefault();

		$(this).parents('tr').remove();

	}) 

	/*$('#calendar-info #menu').click(function() {
		$('#calendar-info .sub').show();
		$(this).click(function() {
			$('#calendar-info .sub').hide();
		})
	});*/

});


function closeLayer( obj ) {
	$(obj).parent().parent().hide();
}

/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
$(document).on('click', '.imgSelect', function(e)
{
	e.stopImmediatePropagation();
	console.log('성공');
	$('#detail-content').empty();
	var sWidth = window.innerWidth;
	var sHeight = window.innerHeight;

	console.log('성공');
	
	var oWidth = $('.popupLayer').width();
	var oHeight = $('.popupLayer').height();

	// 레이어가 나타날 위치를 셋팅한다.
	var divLeft = e.clientX + 10;
	var divTop = e.clientY + 5;

	// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
	if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
	if( divTop + oHeight > sHeight ) divTop -= oHeight;

	// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
	if( divLeft < 0 ) divLeft = 0;
	if( divTop < 0 ) divTop = 0;
	
	var temp = $(this).parent('div[class=new]').attr('id');
	var schedule_no = (Number) (temp.substring(6));
	console.log('temp...'+temp+'sno...'+schedule_no);
	
	var params = {schedule_no:schedule_no};
	
	scheduleService.get(params, function(data) {
		console.log('성공'+data);

		$('#detail-content').append('일정명: '+data.schedule_title+
				'<br>시작일: '+data.schedule_starttime+
				'<br>종료일: '+data.schedule_endtime+'<br>내용: '+data.schedule_contents);

		var name = data.emp_name2;
		var dept = data.dept_name2;
		
		var html = '<br>참여자: ';

		for(var i = 0; i < name.length; i++) {
			html += name[i]+'-'+dept[i]+', ';

		}
		$('#detail-content').append(html);

	});

	$('.popupLayer').css({
		"top": divTop,
		"left": divLeft,
		"position": "absolute"
	}).show();
});

	var id = '';
	var wth = '';
	var num = '';
	var itDate = '';
	var schedule_1 ='';
	
	 $(document).on('mousemove', '.new', function(e){
		 e.stopImmediatePropagation();
	  var x = e.pageX-$(this).position().left;
	  var y = e.pageY-$(this).position().top;
	  var z = $(this).width();

	  if((x>(z-10)&&x<z)){
		  $("#aaa").html('a');
		  $(this).css("cursor", "e-resize");
		  $(this).resizable({
			  minHeight:21,
			  maxHeight:21,
			  maxWidth:800
	   });
	   
	   origin = $(this).attr('name');
	   var html = $(this).html();

	   itDate = origin.substring(origin.indexOf('~')+1);
	   
	   wth = $(this).css('width');
	   wth = parseInt(wth.substring(0, wth.indexOf('p')));
	   	
	   console.log('이동후 wht'+wth);
	   
		 if(wth>135) {
			   num = parseInt(wth / 112);
			   num = num-1;
			   console.log('...이동후.'+num);
		   }
		 $(this).css("cursor", "default");
		 
	   var tr_date = new Date(itDate);
	   temp_date = tr_date.setDate(tr_date.getDate()+num);
	   
	   var origin_id = $(this).attr('id');
	   console.log('id....'+origin_id);
	   
	   var schedule_no = (Number) (origin_id.substring(origin_id.indexOf('-')+1));
	   var schedule_starttime = origin.substring(0, origin.indexOf('~'));
	   var schedule_endtime = moment(temp_date).format('YYYY/MM/DD HH:mm');
	   
	   schedule_1 = {schedule_no : schedule_no, schedule_starttime : schedule_starttime, schedule_endtime : schedule_endtime};
	   
	   console.log('schedule'+typeof(schedule_no)+' '+schedule_starttime+' '+schedule_endtime);
		
	  }else{
	   $(this).css("cursor", "default");
	   
	  }
	  
	  return false;
	 }).on('mouseup', '.new', function(){

	   scheduleService.update(schedule_1, function(data) {
			alert(data);
			showList();
			showCalendar();
		}) 
		
		$(this).css("cursor", "default");
		
		return false;
	 });

	 