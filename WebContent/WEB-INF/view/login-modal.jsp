	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login-modal.css">
    <!-- Modal -->
      <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content" style="width: 450px;">
            <div class="modal-header">
              <img src="${pageContext.request.contextPath}/resources/images/miniLogo.png" width="50" height="50"><label style="font-size: 1.5em;">You already a member?</label>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">              	
	              <div class="row">
	              	<div class="col-sm-12">
		              	<div class="input-group" style="height:40px;">
						  <span class="input-group-addon">@</span>
						  <input type="email" name="email" id="Email" class="form-control" title="We'll never share your email with anyone else." 
						  	placeholder="Email address" required="required" style="height:40px;">
					  	</div>
				    </div>
	              </div><br>
	              <div class="row">
	              	<div class="col-sm-12">
		              	<div class="input-group" style="height:40px;">
						  <span class="input-group-addon"><b>*</b></span>
						  <input type="password" name="password" id="Password" class="form-control" placeholder="Password" 
						  		required="required" style="height:40px;">
					  	</div>
				  	</div>
				  </div><br>
	              <div class="row">
	                  <div class="col-sm-12">
	                    <button type="button" class="modal-outline" id="login">Login</button>
	                  </div>
	              </div>
	              <div id="generalErrorMessage" class="error-lbl" style="display:none;"></div>
              </div>
              <div class="modal-footer" style="padding: 8px;">
                      <div class="col-lg-4">
                        <button type="button" class="modal-close" data-dismiss="modal">Close</button>
                      </div>  
                      <div class="col-lg-3"></div>
                      <div class="col-lg-5">
                      	<p></p>
                        <a href="${pageContext.request.contextPath}/ForgotPassword"><font style="color:black; font-size:15px;">Forgot password ?</font></a>
                      </div>  
                </div>
              </div>
          </div>
        </div>
<script type="text/javascript">
	function openModal() {
		$('#exampleModal').modal('show');
	}
</script>
<!-- AJAX LOGIN (POST) -->
<script type="text/javascript">
	$(document).ready(function() {
				
		$('#login').click(function(event) {
						
			event.preventDefault();
						
 			var EMAIL = $("#Email").val();
 			var PASSWORD = $("#Password").val();
			
			$.ajax({
				
				type : "POST",
				url : "ModalLogin", 
				data : "email=" + EMAIL + "&password=" + PASSWORD,
				success : function(response) {
					
					if(response.status == 'FAIL') {
						showFormError(response.errorMessageList);
						clearError();
					} else {
						$('#exampleModal').modal('hide');
 						window.location.reload();
					}
				},
				error : function(ex) {
					console.log(ex);
				}
			});
		});

		var PasswordField = $('#Password');
		var EmailField = $('#Email');
		var GeneralErrorField = $('#generalErrorMessage');
		
		function showFormError(errorVal) {
			
			//show error messages and change border to red.
			for(var i=0; i < errorVal.length; i++) {
				
				if(errorVal[i].fieldName === 'email') {
					EmailField.val('');
					EmailField.attr("placeholder", errorVal[i].message).css("border", " 1px solid red");
				}
				
				else if(errorVal[i].fieldName === 'password'){
					PasswordField.val('');
					PasswordField.attr("placeholder", errorVal[i].message).css("border", " 1px solid red");
				}
				
				else if(errorVal[i].fieldName === 'FORM FAIL'){
					clearForm();
					GeneralErrorField.css("display", "block").html(errorVal[i].message);
				}
				
			}
			
		}
		
		function clearError() {
			//clear all and return it as default.
			$('#Email').focus(function() {
				GeneralErrorField.css("display", "none");
				EmailField.css("border", "1px solid lightgrey");
				EmailField.attr("placeholder", "Email address");
			});	
			$('#Password').focus(function() {
				PasswordField.val('');
				PasswordField.css("border", "1px solid lightgrey");
				PasswordField.attr("placeholder", "Password");
			});
		}
		
		function clearForm() {
			EmailField.val('');
			PasswordField.val('');
			GeneralErrorField.css("display", "none");
		}
		
	});
</script>





