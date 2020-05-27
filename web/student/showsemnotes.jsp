<%-- 
    Document   : showsemnotes
    Created on : Jun 3, 2016, 2:26:45 AM
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
         <div class="row">
						<div class="col-md-12">
						<table class="table table-bordered responsive">
							<thead>
								<tr>
									<th width="15%">Class</th>
									<th>Semester</th>
									<th>Subject</th>
                                                                        <th>Title of Notes</th>
									<th>File</th>
									
								</tr>
							</thead>
							<tbody>
        
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
         String cid=(String)request.getSession().getAttribute("cid");
               
    String uid=(String)request.getSession().getAttribute("uid");
    String sub =request.getParameter("sub");
    String sem =request.getParameter("sem");
    try {
        
        if(sem.equals("0"))
        {
        sem="";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
         if (sem != "") {
             String query=null;
            
             
             PreparedStatement ps3=con.prepareStatement("select Course,Year,Division from reg_students where uid=?");
           ps3.setString(1,uid);
           ResultSet resultset4=ps3.executeQuery();
           if(resultset4.next())
           {
               String Course=resultset4.getString("Course");
               String Year=resultset4.getString("Year");
               String Div=resultset4.getString("Division");
                      PreparedStatement ps4=con.prepareStatement("select Dept_ID from course where Course_Name=?");
                      ps4.setString(1, Course);
                          ResultSet resultset5=ps4.executeQuery();
           if(resultset5.next())
           {
                   
                PreparedStatement ps = con.prepareStatement("select * from College_notes where c_id=? and sub=? and sem=? and div=?");
            ps.setString(1,cid); 
            ps.setString(2,sub);
            //ps.setString(3,Paper);
            ps.setString(3,sem);
            ps.setString(4,Div);
            
            
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
%>
      <tr>
									<td><%=rs.getString(5)%></td>
									<td><%=rs.getString(6)%></td>
									<td><%=rs.getString(8)%></td>
									<td><%=rs.getString(9)%></td>
									<td><a href="../downloadcode?id=<%=rs.getInt(1)%>"><button type="button" class="btn btn-black"> <i class="entypo-down"></i> </button></a></td>
									
                    </tr>
          
    <%
        }
            
}}}
}

catch (Exception e) {

        e.printStackTrace();
    }

%>
</tbody>
						</table>
					</div>
				</div>
    
    </body>
            
</html>
