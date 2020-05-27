<%-- 
    Document   : signup
    Created on : May 13, 2016, 7:10:13 PM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">
	
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="description" content="tyro Admin Panel" />
		<meta name="author" content="Laborator.co" />
		<link rel="icon" href="assets/images/favicon.ico">
		<title>TYRO | Register</title>
		<link rel="stylesheet" href="assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css" id="style-resource-1">
		<link rel="stylesheet" href="assets/css/font-icons/entypo/css/entypo.css" id="style-resource-2">
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic" id="style-resource-3">
		<link rel="stylesheet" href="assets/css/bootstrap.css" id="style-resource-4">
		<link rel="stylesheet" href="assets/css/tyro-core.css" id="style-resource-5">
		<link rel="stylesheet" href="assets/css/tyro-theme.css" id="style-resource-6">
		<link rel="stylesheet" href="assets/css/tyro-forms.css" id="style-resource-7">
		<link rel="stylesheet" href="assets/css/custom.css" id="style-resource-8">
		<script src="assets/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js" id="script-resource-2"></script> 
		
		<script src="assets/js/jquery-1.11.3.min.js"></script>
                
             <script LANGUAGE="JavaScript">
                        function ValidateForm(form){
                                ErrorText= "";
                                if ( ( form.type[0].checked == false ) && ( form.type[1].checked == false ) && ( form.type[2].checked == false ) ) 
                                    {
                                        alert ( "Please Select Your Login Type To Proceed..." ); 
                                        return false;
                                    }
                                if (ErrorText= "") { form.submit() }
}
</script>
                
              <script type="text/javascript">
					jQuery(document).ready(function($)
					{
					// Skins
					$('input.icheck-1').iCheck({
					checkboxClass: 'icheckbox_minimal',
					radioClass: 'iradio_minimal'
					});
					$('input.icheck-8').iCheck({
					checkboxClass: 'icheckbox_minimal-yellow',
					radioClass: 'iradio_minimal-yellow'
					});
					// Styles
					$('input.icheck-11').iCheck({
					checkboxClass: 'icheckbox_square-blue',
					radioClass: 'iradio_square-yellow'
					});
					$('input.icheck-15').each(function(i, el)
					{
					var self = $(el),
					label = self.next(),
					label_text = label.text();
					label.remove();
					self.iCheck({
					checkboxClass: 'icheckbox_line-green',
					radioClass: 'iradio_line-red',
					insert: '<div class="icheck_line-icon"></div>' + label_text
					});
					});
					});
				</script>
				  
                
	</head>
    <body class="page-body login-page login-form-fall" data-url="http://demo.tyrotheme.com">
         <script type="text/javascript">
            var baseurl = 'index.html';
        </script> 
                
        <div class="login-container">
            <div class="login-header login-caret">
                <div class="login-content">
                    <a href="dashboard/main/index.html" class="logo"> <img src="assets/images/logo_2x.png" width="120" alt="" /> </a> 
                    <p class="description">Create an account, it's free and takes few moments only!</p>
                    <p class="description">Select Your Login Type</p>
                </div>
            </div>
            <div class="login-progressbar">
                <div></div> 
            </div>
            <div class="login-form">
                <div class="login-content">
                    <form method="post" role="form" id="form_register" action="checktype" name="reg">
                        <div class="form-steps">

        
                        
                            <div class="step current" id="step-1">
                                

                                <div class="form-group">                                
                                    <div class="input-group">
                                        <span class="input-group-addon"><input tabindex="8" class="icheck-11" type="radio" id="TEACHER" name="type" value="TEACHER"></span>
                                         <input type='text' class="form-control" placeholder="Teacher" readonly="true" />
                                    </div>
                                </div>
                               <div class="form-group">                                
                                    <div class="input-group">
                                        <span class="input-group-addon"><input tabindex="8" class="icheck-11" type="radio" id="HOD" name="type" value="HOD"></span>
                                         <input type='text' class="form-control" placeholder="H.O.D" readonly="true" />
                                    </div>
                                </div>
                               <div class="form-group">                                
                                    <div class="input-group">
                                        <span class="input-group-addon"><input tabindex="8" class="icheck-11" type="radio" id="STUDENT" name="type" value="STUDENT"></span>
                                         <input type='text' class="form-control" placeholder="Student" readonly="true" />
                                    </div>
                                </div>
                                <div class="form-group"> <button type="submit" class="btn btn-primary btn-block btn-login" onclick="return ValidateForm(this.form)"> <i class="entypo-right-open-mini"></i>
                                    Next Step
                                    </button> 
                                </div>
                                    <div class="form-group">
                                    Step 1 of 3
                                </div>
                            </div>

                            </div>
    
                    </form>
                    <div class="login-bottom-links"> <a href="../login/index.html" class="link"> <i class="entypo-lock"></i>
                        Return to Login Page
                        </a> <br /> <a href="#">Tyro</a> - <a href="#">Privacy Policy</a> 
                    </div>
                </div>
            </div>
        </div>
    <link rel="stylesheet" href="assets/js/icheck/skins/minimal/_all.css" id="style-resource-1">
        <link rel="stylesheet" href="assets/js/icheck/skins/square/_all.css" id="style-resource-2">
        
        <script src="assets/js/gsap/TweenMax.min.js" id="script-resource-1"></script>
         <script src="assets/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js" id="script-resource-2"></script> 
         <script src="assets/js/bootstrap.js" id="script-resource-3"></script> 
         <script src="assets/js/joinable.js" id="script-resource-4"></script> 
<script src="assets/js/cookies.min.js" id="script-resource-7"></script> 
           <script src="assets/js/icheck/icheck.min.js" id="script-resource-8"></script> 
           <script src="assets/js/tyro-chat.js" id="script-resource-9"></script> 
                   

         <script src="assets/js/resizeable.js" id="script-resource-5"></script>
          <script src="assets/js/tyro-api.js" id="script-resource-6"></script> 
          <script src="assets/js/cookies.min.js" id="script-resource-7"></script> 
          <script src="assets/js/jquery.validate.min.js" id="script-resource-8"></script> 
          <script src="assets/js/tyro-register.js" id="script-resource-9"></script> 
        <script src="assets/js/jquery.inputmask.bundle.js" id="script-resource-10"></script> 
        <!-- JavaScripts initializations and stuff --> 
        <script src="assets/js/tyro-custom.js" id="script-resource-11"></script> 
        <!-- Demo Settings --> 
        <script src="assets/js/tyro-demo.js" id="script-resource-12"></script> 
        <script src="assets/js/tyro-skins.js" id="script-resource-13"></script> 
    </body>
    
</html>

