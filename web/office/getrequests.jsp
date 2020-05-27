<%-- 
    Document   : showdoubts
    Created on : Jun 1, 2016, 6:30:16 PM
    Author     : Shardul Rane
--%>

<%@page import="Controller.submitdoubt"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
                                                                    <th><center>Asked By</center></th>
									<th><center>Course</center></th>
									<th><center>Year<center></th>
									<th><center>Div</center></th>
                                                                        <th><center>Requested Document</center></th>
                                                                        <th><center>Reason</center></th>
                                                                        <th><center>Requested Date</center></th>
                                                                        <th><center>Notify Student</center></th>
								</tr>
							</thead>
							<tbody>

<%
   String stream=request.getParameter("stream");
    String uid = (String)request.getSession().getAttribute("uid");
    String cid = (String)request.getSession().getAttribute("cid");
    
    String paper = null;
    String book = null;
    try {
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
      
                
                PreparedStatement ps1 = con.prepareStatement("select * from college_assets where c_id=? and stream=?  and status=1");
                ps1.setString(1, cid);
                ps1.setString(2, stream);
                ResultSet rs1 = ps1.executeQuery();
                while(rs1.next()) {
                PreparedStatement ps2 = con.prepareStatement("select * from register_users where uid=?");
                ps2.setString(1, rs1.getString("uid"));
                ResultSet rs2 = ps2.executeQuery();
                while(rs2.next()) {
                    
                    
                    %>
                    <tr>
									<td><img src="../getprofilepic?id=<%=rs1.getString("uid")%>" class="img-circle" alt=""  width="44" /><%=rs2.getString("name")%>
                                                                        </td>
									<td><%=rs1.getString(5)%></td>
									<td><%=rs1.getString(6)%></td>
									<td><%=rs1.getString(7)%></td>
									<td><%=rs1.getString(8)%></td>
                                                                        
									<td><%=rs1.getString(9)%></td>
									<td><%=rs1.getDate(10)%></td>
									
                                                                        <td><center><a href="../notifyupdate?id=<%=rs1.getInt(1)%>" class="btn btn-green btn-icon">
									Notify
									<i class="entypo-check"></i> </a></center></td>
                                                                        
                    </tr>
                   
                    
    <%
        
     }       
    
}
%>
</tbody>
						</table>
					</div>
				</div>
    
    </body>
    <%
}
catch (Exception e) {

        e.printStackTrace();
    }

%>
</html>
