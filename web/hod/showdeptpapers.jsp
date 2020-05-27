<%-- 
    Document   : showdeptpapers
    Created on : Jun 3, 2016, 3:09:17 PM
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
									<th><center>Semester</center></th>
									<th><center>Subject</center></th>
                                                                        <th><center>Type</center></th>
									<th><center>Year</center></th>
                                                                        <th colspan="2"><center>Action</center></th>
									
								</tr>
							</thead>
							<tbody>
        
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
         String cid=(String)request.getSession().getAttribute("cid");
     String dept =request.getParameter("dept");
              
    String uid=(String)request.getSession().getAttribute("uid");
     
    try {
        
     
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps = con.prepareStatement("select * from question_papers where c_id=? and u_id=? and classes like '%"+dept+"%'");
            ps.setString(1,cid); 
             ps.setString(2,uid);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
%>
      <tr>
	<td><%=rs.getString(6)%></td>
																	
          <td><%=rs.getString(7)%></td>
									<td><%=rs.getString(8)%></td>
									<td><%=rs.getString(9)%></td>
									<td><a href="../downloadpaper?id=<%=rs.getInt(1)%>"><button type="button" class="btn btn-black"> <i class="entypo-down"></i> </button></a></td>
									<td><center><a href="deletepaper.jsp?id=<%=rs.getInt(1)%>" onclick="return confirm('Are you sure want to Delete This Question Paper ??');"><button type="button" class="btn btn-red btn-icon">
									Delete
									<i class="entypo-cancel"></i> </button></a></center></td>
                    </tr>
          
    <%
        
}
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

