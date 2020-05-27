<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%ResultSet resultset =null;%>
<%ResultSet resultset1 =null;%>
<!DOCTYPE html> 
<html lang="en">
	
	<head>
		<link rel="icon" href="../assets/images/favicon.ico">
		<title>Tyro | Attendance Sheet</title>
		<link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css" id="style-resource-1">
		<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css" id="style-resource-2">
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic" id="style-resource-3">
		<link rel="stylesheet" href="../assets/css/bootstrap.css" id="style-resource-4">
		<link rel="stylesheet" href="../assets/css/tyro-core.css" id="style-resource-5">
		<link rel="stylesheet" href="../assets/css/tyro-theme.css" id="style-resource-6">
		<link rel="stylesheet" href="../assets/css/tyro-forms.css" id="style-resource-7">
		<link rel="stylesheet" href="../assets/css/custom.css" id="style-resource-8">
		<script src="../assets/js/jquery-1.11.3.min.js"></script> 
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
		   
                <script type="text/javascript">
                       
                       
function loadXMLDoc()
{
    var search=document.searchform.search.value;
                    var college=document.searchform.college.value;
                    var dept=document.searchform.dept.value;
                    var gender=document.searchform.gender.value;
                    var pin=document.searchform.pin.value;
                   
var xmlhttp;
//var usertype = "HIIII";
//var userType= usertype .options[usertype .selectedIndex].value;
//var uname=document.search;
var urls="getbuddy.jsp?search="+search+"&college="+college+"&dept="+dept+"&gender="+gender+"&pin="+pin;
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4)
    {
        document.getElementById("searchres").innerHTML=xmlhttp.responseText;
     }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}
</script>


	</head>
	<body class="page-body">
		
		<div class="page-container">
			
			<div class="sidebar-menu">
				<div class="sidebar-menu-inner">
					<header class="logo-env">
						<!-- logo --> 
						<div class="logo"> <a href="../dashboard/main/index.html"> <img src="../assets/images/logo_2x.png" width="120" alt="" /> </a> </div>
						<!-- logo collapse icon --> 
						<div class="sidebar-collapse">
							<a href="#" class="sidebar-collapse-icon">
								 <i class="entypo-menu"></i> 
							</a>
						</div>
						
						<div class="sidebar-mobile-menu visible-xs">
							<a href="#" class="with-animation">
								 <i class="entypo-menu"></i> 
							</a>
						</div>
					</header>
					<ul id="main-menu" class="main-menu">
						<li class="has-sub">
									<a href="#"><i class="entypo-list-add"></i><span class="title">Attendance</span></a> 
									<ul>
										<li> <a href="allotattendance.jsp"><i class="entypo-plus-circled"></i><span class="title">Allot Attendance</span></a> </li>
									</ul>
							</li>
						<li class="has-sub">
							<a href="#"><i class="entypo-book"></i><span class="title">Notes</span></a> 
							<ul>
								<li> <a href="uploadnotes.jsp"><i class="entypo-upload"></i><span class="title">Upload Notes</span></a> </li>
								<li> <a href="viewnotes.jsp"><i class="entypo-book"></i><span class="title">View Notes</span></a> </li>
							</ul>
						</li>
						
						<li class="has-sub">
						<a href="#"><i class="entypo-user"></i><span class="title">Student Services</span></a>
						<ul>
							<li>
							<a href="viewdoubts.jsp"><i class="entypo-help"></i><span class="title">View Asked Doubts</span></a> 
							</li>
							
						</ul>
						</li>
					 
						<li class="has-sub"><a href="#"><i class="entypo-docs"></i><span class="title">Notify Students</span></a> 							 
							<ul>
								<li> <a href="uploadnotice.jsp"><i class="entypo-alert"></i><span class="title">Send A Notification</span></a> </li>
							</ul>
						</li>
						
					</ul>
				</div>
			</div>
			<div class="main-content">
				 
				<div class="row">
					<!-- Profile Info and Notifications --> 
					<div class="col-md-3 col-sm-3 clearfix">
							<ul class="user-info pull-left pull-none-xsm">
							<!-- Profile Info --> 
							<li class="profile-info dropdown">
								 <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <img src="../getprofilepic?id=<%=(String)request.getSession().getAttribute("uid")%>" class="img-circle" alt=""  width="44" />
								 <%=session.getAttribute("name") %>
								
								</a> 
								<ul class="dropdown-menu">
									<!-- Reverse Caret --> 
									<li class="caret"></li>
									<!-- Profile sub-links --> 
									<li> <a href="teachersetprofile.jsp"> <i class="entypo-user"></i>
										Edit Profile
										</a> 
									</li>
									<li> <a href="../mailbox/main/index.html"> <i class="entypo-mail"></i>
										Inbox
										</a> 
									</li>
									<li> <a href="../calendar/index.html"> <i class="entypo-calendar"></i>
										Calendar
										</a> 
									</li>
									<li> <a href="#"> <i class="entypo-clipboard"></i>
										Tasks
										</a> 
									</li>
								</ul>
							</li>
						</ul>
						<ul class="user-info pull-left pull-right-xs pull-none-xsm">
							<!-- Raw Notifications --> 
							<li class="notifications dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true"> <i class="entypo-attention"></i> <span class="badge badge-info">6</span> </a> 
								<ul class="dropdown-menu">
									
									<li class="top">
										<p class="small"> <a href="#" class="pull-right">Mark all Read</a>
											You have <strong>3</strong> new notifications.
										</p>
									</li>
									<li>
										<ul class="dropdown-menu-list scroller">
											<li class="unread notification-success"> <a href="#"> <i class="entypo-user-add pull-right"></i> <span class="line"> <strong>New user registered</strong> </span> <span class="line small">
												30 seconds ago
												</span> </a> 
											</li>
											<li class="unread notification-secondary"> <a href="#"> <i class="entypo-heart pull-right"></i> <span class="line"> <strong>Someone special liked this</strong> </span> <span class="line small">
												2 minutes ago
												</span> </a> 
											</li>
											<li class="notification-primary"> <a href="#"> <i class="entypo-user pull-right"></i> <span class="line"> <strong>Privacy settings have been changed</strong> </span> <span class="line small">
												3 hours ago
												</span> </a> 
											</li>
											<li class="notification-danger"> <a href="#"> <i class="entypo-cancel-circled pull-right"></i> <span class="line">
												John cancelled the event
												</span> <span class="line small">
												9 hours ago
												</span> </a> 
											</li>
											<li class="notification-info"> <a href="#"> <i class="entypo-info pull-right"></i> <span class="line">
												The server is status is stable
												</span> <span class="line small">
												yesterday at 10:30am
												</span> </a> 
											</li>
											<li class="notification-warning"> <a href="#"> <i class="entypo-rss pull-right"></i> <span class="line">
												New comments waiting approval
												</span> <span class="line small">
												last week
												</span> </a> 
											</li>
										</ul>
									</li>
									<li class="external"> <a href="#">View all notifications</a> </li>
								</ul>
							</li>
							<!-- Message Notifications --> 
						</ul>
						</li>
					</div>
					<div class="col-md-6 col-md-6 clearfix">
                                            <form method="post" class="search-bar" action="#" name="searchform">
						<div class="input-group">
                                                    <input type="text" class="form-control" name="search" placeholder="Search for something..." onkeyup="loadXMLDoc()"> 
										<div class="input-group-btn">
                                                                                    <button type="button" class="btn btn-info" onclick="loadXMLDoc()">Search</button>&nbsp;&nbsp;&nbsp; <a href="javascript:;" onclick="jQuery('#modal-6').modal('show', {backdrop: 'static'});" class="btn btn-primary"><i class="fa fa-filter"></i></a> 
												</div>
											</div>
							
						
					</div>
					<!-- Raw Links --> 
					<div class="col-md-3 col-sm-3 clearfix hidden-xs">
						<ul class="list-inline links-list pull-right">
							<li class="sep"></li>
							<li> <a href="#" data-toggle="chat" data-collapse-sidebar="1"> <i class="entypo-chat"></i>
								Chat
								<span class="badge badge-success chat-notifications-badge is-hidden">0</span> </a> 
							</li>
							<li class="sep"></li>
							<li> <a href="../LogoutServlet">
								Log Out <i class="entypo-logout right"></i> </a> 
							</li>
						</ul>
					</div>
				</div>
				<hr />
		<%
                 try {
                      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
           PreparedStatement ps=con.prepareStatement("select Name from colleges_codes");
           
           resultset1=ps.executeQuery();
                %>                                
			<div class="modal fade" id="modal-6">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
						<h4 class="modal-title">Add Filter To Search Your Buddy</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6">
                                                            <div class="form-group"> <label for="field-1" class="control-label">Select College</label><select class="selectboxit" id="college" name="college">
                                                                    <option value="0">Select Your Buddy's College</option>
                                                                     <%  while(resultset1.next()){ %>
                                                                                                        <option value="<%= resultset1.getString("Name")%>"><%= resultset1.getString("Name")%></option>
                                                                                                        <% } %>		
                                                                </select>
                                                                        
                                                            </div>
							</div>
	<%
          PreparedStatement ps1=con.prepareStatement("SELECT distinct Dept_Name FROM college_dept");
           
          resultset=ps1.executeQuery();
             
        %>
                                                                <div class="col-md-6">
                                                            <div class="form-group"> <label for="field-2" class="control-label">Select Department</label> <select class="selectboxit" id="dept" name="dept">
                                                                    <option value="0">Select Studying Department Of Your Buddy </option>
                                                                     <%  while(resultset.next()){ %>
                                                                                                        <option value="<%= resultset.getString("Dept_Name")%>"><%= resultset.getString("Dept_Name")%></option>
                                                                                                        <% } %>	
                                                                </select> </div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
                                                            <div class="form-group"> <label for="field-3" class="control-label">Select Gender</label> <select class="selectboxit" id="gender" name="gender">
                                                                    <option value="0">Select Gender</option>
                                                                    <option value="Male">Male</option>
                                                                    <option value="Female">Female</option>
                                                                </select> </div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4"> 
                                                            <div class="form-group"> <label for="field-6" class="control-label">Enter Pincode Area</label> <input type="number" class="form-control" id="pin" name="pin" placeholder="123456"> </div>
							</div>
						</div>
						
					</div>
                                    <div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> <button type="button" class="btn btn-info" onclick="loadXMLDoc()">Apply Filter</button> </div>
				</div>
			</div>
                                            </form>
		</div>




		
				<br>
 <div id="searchres">
                                </div>
                                <form name="sheet" action="../submitattendanceteach">                   
 <div class="row">
						<div class="col-md-12">
						<table class="table table-bordered responsive">
							<thead>
								<tr>
									<th>Name Of Student</th>
									<th>Div</th>
									<th>Present</th>
									<th>Absent</th>
									
								</tr>
							</thead>
							<tbody>
                                
                                
                                
                                <%
       String classes=request.getParameter("class");
       String sem=request.getParameter("sem");
       String sub=request.getParameter("sub");
       String type=request.getParameter("type_of_lect");
       String div=request.getParameter("div");
       String nooflect=request.getParameter("nooflect");
       String date=request.getParameter("date");
       String starttime=request.getParameter("starttime");
       
       String endtime=request.getParameter("endtime");
       String year=null;
       if(classes.startsWith("FY"))
       {
       year="First";
       }
       if(classes.startsWith("SY"))
       {
       year="Second";
       }
       if(classes.startsWith("TY"))
       {
       year="Third";
       }
       String cid=(String)request.getSession().getAttribute("cid");
       int length=classes.length();
       int i=0;
       String course=classes.substring(2,length);
           PreparedStatement sheet=con.prepareStatement("select uid from reg_students where Course=? and Year=? and Division=? and Cid=?");
           sheet.setString(1, course);
           sheet.setString(2, year);
           sheet.setString(3, div);
           sheet.setString(4, cid);
         ResultSet showsheet=sheet.executeQuery();
           while(showsheet.next())
           {
            i=i+1;
               PreparedStatement stud=con.prepareStatement("select name from register_users where uid=? and cid=?");
                stud.setString(1, showsheet.getString("uid"));
                stud.setString(2, cid);
           ResultSet showname=stud.executeQuery();
            if(showname.next())
            {
                String present=showsheet.getString("uid")+"@Present";
                String absent=showsheet.getString("uid")+"@Absent";
                
       
       %>        
                                
                                
        <tr>
									<td><%=showname.getString("name")%></td>
									<td><%=div%></td>
                                                                        <td><input type="radio" tabindex="8" class="icheck-11" id="<%=i%>" name="<%=i%>" value="<%=present%>" checked></td>
                                                                        <td><input type="radio" tabindex="8" class="icheck-11" id="<%=i%>"  name="<%=i%>" value="<%=absent%>"></td>
                                                                        
                                                                        
                    </tr>                         
                                
       <%}

} %>
				</tbody>
						</table>
					
                                                
                                                </div>
                                <div class="form-group">
								<center>
								<button type="submit" class="btn btn-green btn-icon">
									Submit Attendance<i class="entypo-check"></i></button>
									&nbsp;
									<button type="reset" class="btn" >
									Reset</button>
									</center>
						</div>
                                
				</div>
                                <%
                                
                    PreparedStatement noofstud=con.prepareStatement("select count(*) as noofstud from reg_students where Course=? and Year=? and Division=? and Cid=?");
           noofstud.setString(1, course);
           noofstud.setString(2, year);
           noofstud.setString(3, div);
           noofstud.setString(4, cid);
         ResultSet showcount=noofstud.executeQuery();
           if(showcount.next())
           {              
                                
                                
                                %>
				<br>
                                <div class="row"> Total Number of Students <input type="text" readonly="true" name="noofstud" id="noofstud" value="<%=showcount.getInt("noofstud")%>">
                                <input type="hidden" readonly="true" name="class" id="class" value="<%=classes%>">
                                <input type="hidden" readonly="true" name="sem" id="sem" value="<%=sem%>">
                                <input type="hidden" readonly="true" name="div" id="div" value="<%=div%>">
                                <input type="hidden" readonly="true" name="sub" id="sub" value="<%=sub%>">
                                <input type="hidden" readonly="true" name="type" id="type" value="<%=type%>">
                                <input type="hidden" readonly="true" name="date" id="date" value="<%=date%>">
                                
                                <input type="hidden" readonly="true" name="nooflect" id="nooflect" value="<%=nooflect%>">
                                <input type="hidden" readonly="true" name="starttime" id="starttime" value="<%=starttime%>">
                                <input type="hidden" readonly="true" name="endtime" id="endtime" value="<%=endtime%>">
                                
                                
                                
                                
                                </div>
                                <%}%>
                                
                                
                        </form>
				<footer class="main">
					
				</footer>
                                                                <%
                
        
}
        catch(Exception e)
        {
          
        }
%>                                  
			</div>
			
			<div id="chat" class="fixed" data-current-user="Art Ramadani" data-order-by-status="1" data-max-chat-history="25">
				<div class="chat-inner">
					<h2 class="chat-header"> <a href="#" class="chat-close"><i class="entypo-cancel"></i></a> <i class="entypo-users"></i>
						Chat
						<span class="badge badge-success is-hidden">0</span> 
					</h2>
					<div class="chat-group" id="group-1"> <strong>Favorites</strong> <a href="#" id="sample-user-123" data-conversation-history="#sample_history"><span class="user-status is-online"></span> <em>Catherine J. Watkins</em></a> <a href="#"><span class="user-status is-online"></span> <em>Nicholas R. Walker</em></a> <a href="#"><span class="user-status is-busy"></span> <em>Susan J. Best</em></a> <a href="#"><span class="user-status is-offline"></span> <em>Brandon S. Young</em></a> <a href="#"><span class="user-status is-idle"></span> <em>Fernando G. Olson</em></a> </div>
					<div class="chat-group" id="group-2"> <strong>Work</strong> <a href="#"><span class="user-status is-offline"></span> <em>Robert J. Garcia</em></a> <a href="#" data-conversation-history="#sample_history_2"><span class="user-status is-offline"></span> <em>Daniel A. Pena</em></a> <a href="#"><span class="user-status is-busy"></span> <em>Rodrigo E. Lozano</em></a> </div>
					<div class="chat-group" id="group-3"> <strong>Social</strong> <a href="#"><span class="user-status is-busy"></span> <em>Velma G. Pearson</em></a> <a href="#"><span class="user-status is-offline"></span> <em>Margaret R. Dedmon</em></a> <a href="#"><span class="user-status is-online"></span> <em>Kathleen M. Canales</em></a> <a href="#"><span class="user-status is-offline"></span> <em>Tracy J. Rodriguez</em></a> </div>
				</div>
				<!-- conversation template --> 
				<div class="chat-conversation">
					<div class="conversation-header"> <a href="#" class="conversation-close"><i class="entypo-cancel"></i></a> <span class="user-status"></span> <span class="display-name"></span> <small></small> </div>
					<ul class="conversation-body"> </ul>
					<div class="chat-textarea"> <textarea class="form-control autogrow" placeholder="Type your message"></textarea> </div>
				</div>
			</div>
			<!-- Chat Histories --> 
			<ul class="chat-history" id="sample_history">
				<li>
					<span class="user">Art Ramadani</span> 
					<p>Are you here?</p>
					<span class="time">09:00</span> 
				</li>
				<li class="opponent">
					<span class="user">Catherine J. Watkins</span> 
					<p>This message is pre-queued.</p>
					<span class="time">09:25</span> 
				</li>
				<li class="opponent">
					<span class="user">Catherine J. Watkins</span> 
					<p>Whohoo!</p>
					<span class="time">09:26</span> 
				</li>
				<li class="opponent unread">
					<span class="user">Catherine J. Watkins</span> 
					<p>Do you like it?</p>
					<span class="time">09:27</span> 
				</li>
			</ul>
			<!-- Chat Histories --> 
			<ul class="chat-history" id="sample_history_2">
				<li class="opponent unread">
					<span class="user">Daniel A. Pena</span> 
					<p>I am going out.</p>
					<span class="time">08:21</span> 
				</li>
				<li class="opponent unread">
					<span class="user">Daniel A. Pena</span> 
					<p>Call me when you see this message.</p>
					<span class="time">08:27</span> 
				</li>
			</ul>
		</div>
		<link rel="stylesheet" href="../assets/js/selectboxit/jquery.selectBoxIt.css" id="style-resource-1">
	<link rel="stylesheet" href="../assets/js/dropzone/dropzone.css" id="style-resource-1">
	<link rel="stylesheet" href="../assets/js/icheck/skins/minimal/_all.css" id="style-resource-1">
        <link rel="stylesheet" href="../assets/js/icheck/skins/square/_all.css" id="style-resource-2">
     
           <script src="../assets/js/jquery.validate.min.js" id="script-resource-8"></script> 
        
               <script src="../assets/js/icheck/icheck.min.js" id="script-resource-8"></script> 
    
		<link rel="stylesheet" href="../assets/css/font-icons/font-awesome/css/font-awesome.min.css" id="style-resource-1">
		<script src="../assets/js/gsap/TweenMax.min.js" id="script-resource-1"></script> 
		<script src="../assets/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js" id="script-resource-2"></script> 
		<script src="../assets/js/bootstrap.js" id="script-resource-3"></script> 
		<script src="../assets/js/joinable.js" id="script-resource-4"></script> 
		<script src="../assets/js/resizeable.js" id="script-resource-5"></script> 
		<script src="../assets/js/tyro-api.js" id="script-resource-6"></script> 
		<script src="../assets/js/cookies.min.js" id="script-resource-7"></script> 
		<script src="../assets/js/tyro-chat.js" id="script-resource-8"></script> 
		<script src="../assets/js/tyro-custom.js" id="script-resource-9"></script>  
		<script src="../assets/js/tyro-demo.js" id="script-resource-10"></script> 
		<script src="../assets/js/tyro-skins.js" id="script-resource-11"></script> 
	<script src="../assets/js/selectboxit/jquery.selectBoxIt.min.js" id="script-resource-11"></script> 
	</body>
	
</html>