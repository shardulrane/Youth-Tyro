<%-- 
    Document   : showallot1
    Created on : Jun 2, 2016, 1:02:45 PM
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
									<th><center>Faculty Name</center></th>
									<th><center>Class</center></th>
									<th><center>Semester</center></th>
									<th><center>Subject</center></th>
                                                                        <th colspan="2"><center>Type</center></th>
                                                                        <th><center>Action</center></th>
                                                                        
								</tr>
							</thead>
							<tbody>
        
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    
    String dept = request.getParameter("dept");
    String classs = request.getParameter("classs");
    String sem = request.getParameter("sem");
    try {
        
        if(dept.equals("0"))
        {
        dept="";
        }
        if(classs.equals("0"))
        {
        classs="";
        }
        if(sem.equals("0"))
        {
        sem="";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
         if (dept != "") {
             String query="select * from classreg where Class like '%"+classs+"%' and Sem like '"+sem+"'";
            PreparedStatement ps = con.prepareStatement(query);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PreparedStatement ps1 = con.prepareStatement("select cid,name from register_users where uid=?");
                ps1.setString(1, rs.getString(2));
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) {
                if(rs1.getString("cid").equals((String)request.getSession().getAttribute("cid")))
                {
%>
      <tr>
									<td><img src="../getprofilepic?id=<%=rs.getString("uid")%>" class="img-circle" alt=""  width="44" /><%=rs1.getString("name")%>
                                                                        </td>
									<td><%=rs.getString(4)%></td>
									<td><%=rs.getString(5)%></td>
									<td><%=rs.getString(7)%></td>
									<td><%=rs.getString(9)%></td>
									<td><%=rs.getString(10)%></td>
									
                                                                        <td><center><a href="deleteallot.jsp?id=<%=rs.getInt(1)%>" onclick="return confirm('Are you sure want to Delete This Class ??');"><button type="button" class="btn btn-red btn-icon">
									Delete
									<i class="entypo-cancel"></i> </button></a></center></td>
                    </tr>
          
    <%
        }
            }
    }
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

