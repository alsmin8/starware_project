console.log("projectBoard Module...........");

var projectboardservice = (function() {

	function add(project_Board_Contents, callback, error) {

		console.log("add board...........");

		$.ajax({

			type : 'post',
			url : '/projectboard/register',
			data : JSON.stringify(project_Board_Contents),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});

	}
	
	function getList(param, callback, error) {
		
		var project_No = param.project_No;
		
		$.getJSON("/projectboard/pages/" + project_No + ".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	
	function remove(project_Board_No, callback, error) {
		
		$.ajax({
			
			type : 'delete',
			url : '/projectboard/' + project_Board_No,
			success : function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
		
		
	}
	
	function update(project_Board_Contents, callback, error) {
		
		console.log("project_Board_No : " + project_Board_Contents.project_Board_No);
		
		$.ajax({
			
			type : 'put',
			url : '/projectboard/' +  project_Board_Contents.project_Board_No,
			data : JSON.stringify(project_Board_Contents),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
			
		});
		
		
	}
	
	function get(project_Board_No, callback, error) {
		
		$.get("/projectboard/" + project_Board_No + ".json", function(result) {
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
		
	}
	
	return{
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};

})();
