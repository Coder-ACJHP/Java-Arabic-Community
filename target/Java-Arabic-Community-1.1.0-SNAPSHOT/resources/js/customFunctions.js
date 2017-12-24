window.onload = function() {
	
	
	var deleteDiv = document.getElementById('danger-zone');
	var deleteBtn = document.getElementById('delete-btn');
	var deleteQstn = document.getElementById('delete-qstn');
	var deleteAnswr = document.getElementById('delete-answr');
	var headerP = document.getElementById('nav-header-p');
	var logoutBtn = document.getElementById('log-out-link');
	
	if(deleteDiv) {
		deleteDiv.addEventListener("mouseover", function() {
			deleteDiv.style.backgroundColor = "#f6d5da";
			deleteDiv.style.borderRadius = '5px';
		});
	}
	
	if(deleteBtn) {
		deleteDiv.addEventListener("mouseout", function() {
			deleteDiv.style.backgroundColor = '#0000';
			
		});
	}
	
	if(deleteBtn) {
		deleteBtn.addEventListener("click", function() {
			swal({
				  title: "Are you sure?",
				  text: "Are you sure you want to delete this account?",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "Yes, delete it!",
				  cancelButtonText: "No, cancel plx!",
				  closeOnConfirm: false,
				  closeOnCancel: false
				},
				function(isConfirm){
				  if (isConfirm) {
					  window.location.href='${DeleteAccount}'; return false;
				  } else {
				    swal("Cancelled", "Your imaginary account is safe :)", "error");
				  }
				});
		});
	}

	
	if(deleteQstn) {
		deleteQstn.addEventListener("mouseover", function() {
			deleteQstn.style.cursor = 'pointer';
		});
		deleteQstn.addEventListener("click", function() {
			swal({
				title : "Are you sure?",
				text : "Are you sure you want to delete this question?",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "Yes, delete it!",
				cancelButtonText : "No, cancel plx!",
				closeOnConfirm : false,
				closeOnCancel : false
			},
			function(isConfirm) {
				if (isConfirm) {
					window.location.href = '${deleteQuestion}';
					return false;
				} else {
					swal("Cancelled", "Your imaginary question is safe :)","error");
				}
			});
		});
	}
	
	if(deleteAnswr) {
		deleteAnswr.addEventListener("mouseover", function() {
			deleteAnswr.style.cursor = 'pointer';
		});
		deleteAnswr.addEventListener("click", function() {
			swal({
				title : "Are you sure?",
				text : "Are you sure you want to delete this answer?",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "Yes, delete it!",
				cancelButtonText : "No, cancel plx!",
				closeOnConfirm : false,
				closeOnCancel : false
			},
			function(isConfirm) {
				if (isConfirm) {
					window.location.href = '${DeleteAnswer}';
					return false;
				} else {
					swal("Cancelled", "Your imaginary answer is safe :)","error");
				}
			});
		});
	}
	
	if(headerP) {
		headerP.addEventListener("click", function() {
			window.location.href = 'https://java-arabic-community.herokuapp.com/AllQuestions';
			return false;
		});
	}
	
}