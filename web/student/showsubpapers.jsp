<%-- 
    Document   : showsubpapers
    Created on : Jun 3, 2016, 12:48:16 PM
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
									<th>Semester</th>
									<th>Subject</th>
                                                                        <th>Type</th>
									<th>Year</th>
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
    String year=request.getParameter("year");
    String type=request.getParameter("type");
    try {
        
        if(sem.equals("0"))
        {
        sem="";
        }
        if(sub.equals("0"))
        {
        sub="";
        }
        if(year.equals("0"))
        {
        sem="";
        }
        if(type.equals("0"))
        {
        sem="";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
         if (sem != "") {
             
            PreparedStatement ps1 = con.prepareStatement("select e_dept from register_users where cid=? and uid=?");
            ps1.setString(1,cid); 
            ps1.setString(2,uid); 
            ResultSet rs1 = ps1.executeQuery();
            if(rs1.next())
            {
                String dept=rs1.getString("e_dept");
            PreparedStatement ps = con.prepareStatement("select * from question_papers where c_id=? and classes like '%"+dept+"%' and sem like '%"+sem+"%' and sub like '%"+sub+"%' and year like '%"+year+"%' and type like '%"+type+"%'");
            ps.setString(1,cid); 
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
%>
      <tr>
									<td><%=rs.getString(6)%></td>
									<td><%=rs.getString(7)%></td>
									<td><%=rs.getString(8)%></td>
									<td><%=rs.getString(9)%></td>
									<td><a href="../downloadpaper?id=<%=rs.getInt(1)%>"><button type="button" class="btn btn-black"> <i class="entypo-down"></i> </button></a></td>
									
                    </tr>
          
    <%
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

