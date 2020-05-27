<%-- 
    Document   : setupprofile
    Created on : May 23, 2016, 12:38:10 PM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html> 
<html lang="en">
	
	<head>
		<link rel="icon" href="assets/images/favicon.ico">
		<title>Tyro | Profile</title>
		<link rel="stylesheet" href="assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css" id="style-resource-1">
		<link rel="stylesheet" href="assets/css/font-icons/entypo/css/entypo.css" id="style-resource-2">
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic" id="style-resource-3">
		<link rel="stylesheet" href="assets/css/bootstrap.css" id="style-resource-4">
		<link rel="stylesheet" href="assets/css/tyro-core.css" id="style-resource-5">
		<link rel="stylesheet" href="assets/css/tyro-theme.css" id="style-resource-6">
		<link rel="stylesheet" href="assets/css/tyro-forms.css" id="style-resource-7">
		<link rel="stylesheet" href="assets/css/custom.css" id="style-resource-8">
		<script src="assets/js/jquery-1.11.3.min.js"></script> 
	</head>
	<body class="page-body">
		
		<div class="page-container">
			
			<div class="sidebar-menu">
				<div class="sidebar-menu-inner">
					<header class="logo-env">
						<!-- logo --> 
						<div class="logo"> <a href="dashboard/main/index.html"> <img src="assets/images/logo_2x.png" width="120" alt="" /> </a> </div>
						<!-- logo collapse icon --> 
					
					</header>

				</div>
			</div>
			<div class="main-content">
				 
				
				 
				<hr />
				<div class="well well-sm">
					<h4>Please fill the details to register new account.</h4>
				</div>
                                <form id="rootwizard-2" method="post" action="setprofile" class="form-wizard validate" enctype="multipart/form-data">
					<div class="steps-progress">
						<div class="progress-indicator"></div>
					</div>
					<ul>
						<li class="active"> <a href="#tab2-1" data-toggle="tab"><span>1</span>Personal Info</a> </li>
						<li> <a href="#tab2-2" data-toggle="tab"><span>2</span>Address</a> </li>
						<li> <a href="#tab2-3" data-toggle="tab"><span>3</span>Social Info</a> </li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab2-1">
						<div class="row">
							<div class="form-group">
										<label class="col-sm-3 control-label">Upload your image</label> 
										<div class="col-sm-5">
											<div class="fileinput fileinput-new" data-provides="fileinput">
												<div class="fileinput-new thumbnail" style="width: 200px; height: 150px;" data-trigger="fileinput"> <img src="http://placehold.it/200x150" alt="..."> </div>
												<div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px"></div>
                                                                                                <div> <span class="btn btn-white btn-file"> <span class="fileinput-new">Select image</span> <span class="fileinput-exists">Change</span> <input type="file" name="..." id="..." accept="image/*"> </span> <a href="#" class="btn btn-orange fileinput-exists" data-dismiss="fileinput">Remove</a> </div>
											</div>
										</div>
									</div>
						</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group"> <label class="control-label" for="nick_name">Nick Name</label> <input class="form-control" name="nick_name" id="nick_name" data-validate="required" placeholder="Your nick name" /> </div>
								</div>
								<div class="col-md-6">
									<div class="form-group"> <label class="control-label" for="birthdate">Date of Birth</label> <input class="form-control" name="birthdate" id="birthdate" data-validate="required" data-mask="date" placeholder="Pre-formatted birth date" /> </div>
								</div>
							</div>
							<div class="row">
							<div class="col-md-6">
									<div class="form-group"> <label class="control-label" for="mobile_number">Mobile Number</label> <input class="form-control" name="mobile_number" id="mobile_number" data-validate="number" placeholder="Numbers only" required="required" /> </div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
								<label class="control-label" for="phone">Phone Number</label>
                                                                <input type="text" class="form-control" data-mask="phone" id="phone_number" name="phone_number" /> </div>
							</div>
							</div>
							<div class="row">
								<div class="col-md-6">
										<label class="col-sm-6 control-label">Gender</label> 
										
											<select class="form-control" name="gender" id="gender">
												<option value="Male">Male</option>
												<option value="Female">Female</option>
                                                                                                <option value="Other">Other</option>
											</select>
									</div>
							</div>
							<br>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="about">Write Something About You</label> <textarea class="form-control autogrow" name="about" id="about" rows="5" placeholder="Something about you"></textarea> </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="about">Favorite Quotes</label> <textarea class="form-control autogrow" name="quotes" id="quotes" rows="3" placeholder="Could be used also as Motivation Letter"></textarea> </div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab2-2">
							<div class="row">
								<div class="col-md-8">
									<div class="form-group"> <label class="control-label" for="street">Street</label> <input class="form-control" name="street" id="street" data-validate="required" placeholder="Enter your street address" /> </div>
								</div>
								<div class="col-md-4">
									<div class="form-group"> <label class="control-label" for="door_no">Door no.</label> <input class="form-control" name="door_no" id="door_no" data-validate="number" placeholder="Numbers only" /> </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="address_line_2">Address Line 2</label> <input class="form-control" name="address_line_2" id="address_line_2" placeholder="(Optional) Address Line 2" /> </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-5">
									<div class="form-group"> <label class="control-label" for="city">City</label> <input class="form-control" name="city" id="city" data-validate="required" placeholder="Current city" /> </div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label" for="state">State</label> 
                                                                                <select name="test" class="selectboxit" name="state" id="state">
											<optgroup label="India">
												<option value="1">Maharashtra</option>
												<option value="2">Jammu and Kashmir</option>
												<option value="3">Punjab</option>
											</optgroup>
										</select>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group"> <label class="control-label" for="zip">Zip</label> <input class="form-control" name="zip" id="zip" data-mask="*** ***" data-validate="required" placeholder="Zip Code" /> </div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab2-3">
							<strong>Social Info</strong> <br /> <br /> 
							<div class="row">
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="about">Achievements and Rewards/Lifetime Events</label> <textarea class="form-control autogrow" name="achieve" id="achieve" rows="5" placeholder="Something about your achievement"></textarea> </div>
								</div>
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="about">Religious View</label> <textarea class="form-control autogrow" name="aboutreligion" id="aboutreligion" rows="5" placeholder="Something about your religious view"></textarea> </div>
								</div>
								<div class="col-md-12">
									<div class="form-group"> <label class="control-label" for="about">Political View</label> <textarea class="form-control autogrow" name="aboutpolitical" id="aboutpolitical" rows="5" placeholder="Something about your political view"></textarea> </div>
								</div>
								<div class="col-md-12">
                                                                    <div class="form-group"> <label class="control-label" for="about">Interested In</label> <select class="form-control" id="interested" name="interested">
										<option value="Men">Men</option>
										<option value="Women">Women</option>
                                                                                <option value="Girls">Girls</option>
                                                                                <option value="Boys">Boys</option>
									</select>
									</div>
								</div>
								<div class="col-md-12">
                                                                    <div class="form-group"> <label class="control-label" for="about">Relationship Status</label> <select class="form-control" name="relationship_status" id="relationship_status">
										<option value="Single">Single</option>
										<option value="Mingled">Mingled</option>
                                                                                <option value="Engaged">Engaged</option>
                                                                                <option value="Divorced">Divorced</option>
                                                                                <option value="Married">Married</option>
                                                                               <option value="Not Interested">Not Interested</option>
                                                                               
									</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="checkbox checkbox-replace"> <input type="checkbox" name="chk-rules" id="chk-rules" data-validate="required" data-message-message="You must accept rules in order to complete this registration."> <label for="chk-rules">By registering I accept terms and conditions.</label> </div>
							</div>
							<div class="form-group"> <button type="submit" class="btn btn-primary">Finish Registration</button> </div>
						</div>
						
						
						<ul class="pager wizard">
							<li class="previous"> <a href="#"><i class="entypo-left-open"></i> Previous</a> </li>
							<li class="next"> <a href="#">Next <i class="entypo-right-open"></i></a> </li>
						</ul>
					</div>
				</form>


				<br>			
				<footer class="main">
					&copy; 2016 <strong>Tyro</strong> 
				</footer>
			</div>
			
		</div>
		<link rel="stylesheet" href="assets/js/selectboxit/jquery.selectBoxIt.css" id="style-resource-1">
		<link rel="stylesheet" href="assets/js/dropzone/dropzone.css" id="style-resource-1">
		<script src="assets/js/gsap/TweenMax.min.js" id="script-resource-1"></script> 
		<script src="assets/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js" id="script-resource-2"></script> 
		<script src="assets/js/bootstrap.js" id="script-resource-3"></script> 
		<script src="assets/js/joinable.js" id="script-resource-4"></script> 
		<script src="assets/js/resizeable.js" id="script-resource-5"></script> 
		<script src="assets/js/tyro-api.js" id="script-resource-6"></script> 
		<script src="assets/js/cookies.min.js" id="script-resource-7"></script> 
		<script src="assets/js/jquery.bootstrap.wizard.min.js" id="script-resource-8"></script> 
		<script src="assets/js/jquery.validate.min.js" id="script-resource-9"></script> 
		<script src="assets/js/jquery.inputmask.bundle.js" id="script-resource-10"></script> 
		<script src="assets/js/selectboxit/jquery.selectBoxIt.min.js" id="script-resource-11"></script> 
		<script src="assets/js/bootstrap-datepicker.js" id="script-resource-12"></script> 
		<script src="assets/js/bootstrap-switch.min.js" id="script-resource-13"></script> 
		<script src="assets/js/jquery.multi-select.js" id="script-resource-14"></script> 
		<script src="assets/js/tyro-chat.js" id="script-resource-15"></script> 
		<script src="assets/js/fileinput.js" id="script-resource-8"></script> 
		<script src="assets/js/dropzone/dropzone.js" id="script-resource-9"></script> 
		<!-- JavaScripts initializations and stuff --> 
		<script src="assets/js/tyro-custom.js" id="script-resource-16"></script> 
		<!-- Demo Settings --> 
		<script src="assets/js/tyro-demo.js" id="script-resource-17"></script> 
		<script src="assets/js/tyro-skins.js" id="script-resource-18"></script>
	</body>
	
</html>