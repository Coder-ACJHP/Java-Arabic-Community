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
                        deleteDiv.style.transition = '0.8s';
		});
	}
	
	if(deleteBtn) {
		deleteDiv.addEventListener("mouseout", function() {
			deleteDiv.style.backgroundColor = '#0000';
			
		});
	}

	
	if(deleteQstn) {
		deleteQstn.addEventListener("mouseover", function() {
			deleteQstn.style.cursor = 'pointer';
		});
	}
	
	if(deleteAnswr) {
		deleteAnswr.addEventListener("mouseover", function() {
			deleteAnswr.style.cursor = 'pointer';
		});
	}
	
	if(headerP) {
		headerP.addEventListener("click", function() {
			window.location.href = 'https://java-arabic-community.herokuapp.com/AllQuestions';
			return false;
		});
	}
	
}