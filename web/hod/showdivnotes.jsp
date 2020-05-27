<%-- 
    Document   : showdivnotes
    Created on : Jun 2, 2016, 11:10:34 PM
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
                                                                        <th>Division</th>
                                                                        <th>Title of Notes</th>
									<th>File</th>
									<th>Action</th>
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
   // String sub=request.getParameter("sub");
    String div =request.getParameter("div");
    String classs=request.getParameter("classs");
    String sem =request.getParameter("sem");
    try {
        
        
        if(div.equals("0"))
        {
        div="";
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
         if (classs != "") {
             String query=null;
            PreparedStatement ps = con.prepareStatement("select * from College_notes where classes=? and u_id=? and c_id=? and sem=? and div=?");
            ps.setString(1,classs);
            ps.setString(2,uid);
            ps.setString(3,cid);
            ps.setString(4,sem);
            ps.setString(5,div);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if(rs.getString("c_id").equals(cid))
                {
%>
      <tr>
									<td><%=rs.getString(5)%></td>
									<td><%=rs.getString(6)%></td>
									<td><%=rs.getString(8)%></td>
									<td><%=rs.getString(7)%></td>
									<td><%=rs.getString(9)%></td>
									<td><a href="../downloadcode?id=<%=rs.getInt(1)%>"><button type="button" class="btn btn-black"> <i class="entypo-down"></i> </button></a></td>
									
                                                                        <td><center><a href="deletenotes.jsp?id=<%=rs.getInt(1)%>" onclick="return confirm('Are you sure want to Delete This Notes ??');"><button type="button" class="btn btn-red btn-icon">
									Delete
									<i class="entypo-cancel"></i> </button></a></center></td>
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
