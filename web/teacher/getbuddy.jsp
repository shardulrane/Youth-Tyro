<%-- 
    Document   : getbuddy
    Created on : May 31, 2016, 12:40:16 AM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    
    <body>
        
        
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String search = request.getParameter("search");
    String college = request.getParameter("college");
    
    String dept = request.getParameter("dept");
    String gender = request.getParameter("gender");
    String pin = request.getParameter("pin");
    String uid = null;
    String cid = null;
    String college_name = null;
    String deptname = null;
    String year = null;
    String dob = null;
    String book = null;
    try {
        
        if(college.equals("0"))
        {
        college="";
        }
        if(dept.equals("0"))
        {
        dept="";
        }
        if(gender.equals("0"))
        {
        gender="";
        }
        if(pin.equals(" "))
        {
        pin="";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
         if (search != "") {
             String query="select * from register_users where name like '%"+search+"%' and e_dept like '%"+dept+"%' and gender like'%"+gender+"%' and zip like '"+pin+"%'";
            PreparedStatement ps = con.prepareStatement(query);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                uid = rs.getString(1);
                cid = rs.getString(4);
                PreparedStatement ps1 = con.prepareStatement("select Name from colleges_codes where College_code=?");
                ps1.setString(1, cid);
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) {
                    college_name = rs1.getString("Name");
                    deptname = rs.getString(6);
                    %>
      <div class="member-entry">
					<a href="showuser.jsp?id=<%=uid%>" class="member-img"> <img src="../getprofilepic?id=<%=uid%>" class="img-rounded" /> <i class="entypo-forward"></i> </a> 
					<div class="member-details">
						<h4> <a href="showuser.jsp?id=<%=uid%>"><%=rs.getString(2)%></a> </h4>
						<div class="row info-list">
							<div class="col-sm-4"> <i class="entypo-briefcase"></i>
								Studying At <a href="#"><%=rs1.getString("Name")%></a> 
							</div>
							<div class="col-sm-4"> <i class="entypo-drive"></i> <a href="#"><%=rs.getString(6)%></a> </div>
							<div class="col-sm-4"> <i class="entypo-graduation-cap"></i> <a href="#"></a> <%=rs.getString(8)%></div>
							<div class="clear"></div>
							<div class="col-sm-4"></div>
							<div class="col-sm-4"> <i class="entypo-mail"></i> <a href="#"><%=rs.getString(3)%></a> </div>
							<div class="col-sm-4"> </div>
						</div>
					</div>
				</div>
    </body>
                  
    <%
        
            }
    }
}
}
catch (Exception e) {

        e.printStackTrace();
    }

%>
</html>
