var replyService = (function() {
	
	function add(reply, callback, error) {
		console.log('add reply..................');
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
			
		})
		
	}
	
	function getList(param, callback, error) {
		
		var bno = param.bno;
		var page = param.page;
		
		$.ajax({
			type : 'get',
			url : '/replies/pages/' + bno + '/' + page +'.json',
			success : function(data) {
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
	
	function remove(rno, callback, error) {
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
			
		});
	}
	
	function update(reply, callback, error) {
		
		$.ajax({
			type : 'put',
			url : '/replies/'+ reply.rno,
			data : JSON.stringify(reply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
	}
	
	function get(rno, callback, error) {
		
		$.ajax({
			type : 'get', 
			url : '/replies/'+rno+'.json',
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
	return {add : add, getList : getList, remove : remove, update : update, get : get};
	
	// replyservice 호출 동시에 함수를 실행하자.
})();


