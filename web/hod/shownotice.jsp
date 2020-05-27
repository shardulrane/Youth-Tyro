<%-- 
    Document   : shownotice
    Created on : Jun 3, 2016, 8:02:31 PM
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
									<th width="15%">Notice Title</th>
									<th>Level of Notice</th>
									<th>Date</th>
									<th>File</th>
                                                                        <th colspan="2">Action</th>
								</tr>
							</thead>
							<tbody>

<%
   
    String level=request.getParameter("level");
    String daterange=request.getParameter("daterange");
    
    String uid = (String)request.getSession().getAttribute("uid");
    String cid = (String)request.getSession().getAttribute("cid");
    
    String paper = null;
    String book = null;
    try {
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        PreparedStatement ps1 = con.prepareStatement("SELECT * FROM register_users WHERE uid=? and cid=?");
                    ps1.setString(1, uid);
                    ps1.setString(2, cid);
                    ResultSet rs1 = ps1.executeQuery();
                    if (rs1.next()) {
                        String dept = rs1.getString(6);
                      
            PreparedStatement ps = con.prepareStatement("select * from notices_college where College_Code=? and Ntype=? and Department=?");
            ps.setString(1, cid);
            ps.setString(2, level);
            ps.setString(3, dept);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
                  %>
                    <tr>
									<td><%=rs.getString(6)%></td>
									<td><%=rs.getString(4)%></td>
									<td><%=rs.getDate(7)%></td>
									
                                                                       <td><a href="../downloadnotice?id=<%=rs.getInt(1)%>"><button type="button" class="btn btn-black"> <i class="entypo-down"></i> </button></a></td>
									
                                                                        <td><center><a href="deletenotice.jsp?id=<%=rs.getInt(1)%>" onclick="return confirm('Are you sure want to Delete This Notice ??');"><button type="button" class="btn btn-red btn-icon">
									Delete
									<i class="entypo-cancel"></i> </button></a></center></td>
                    </tr>
                    
                    
    <%
        
            
    
}
%>
</tbody>
						</table>
					</div>
				</div>
    
    </body>
    <%
}
}
catch (Exception e) {

        e.printStackTrace();
    }

%>
</html>
