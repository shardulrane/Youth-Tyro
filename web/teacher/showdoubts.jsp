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
									<th><center>Doubt</center></th>
									<th><center>Asked When<center></th>
									<th colspan="2"><center>Action</center></th>
								</tr>
							</thead>
							<tbody>

<%
   String classes=request.getParameter("q");
    String sub = null;
    String uid = (String)request.getSession().getAttribute("uid");
    String paper = null;
    String book = null;
    try {
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
      
            PreparedStatement ps = con.prepareStatement("select DISTINCT Sub,Paper from classreg where Class=? and uid=?");
            ps.setString(1, classes);
            ps.setString(2, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
                sub=rs.getString("Sub");
                paper=rs.getString("Paper");
                PreparedStatement ps1 = con.prepareStatement("select * from doubts where subject=? and paper=? and status=1");
                ps1.setString(1, sub);
                ps1.setString(2, paper);
                ResultSet rs1 = ps1.executeQuery();
                while(rs1.next()) {
                    
                    %>
                    <tr>
									<td><img src="../getprofilepic?id=<%=rs1.getString("uid")%>" class="img-circle" alt=""  width="44" />
                                                                        </td>
									<td><%=rs1.getString(7)%></td>
									<td><%=rs1.getDate(8)%></td>
									
                                                                        <td><center><button type="button" class="btn btn-green btn-icon" onclick="jQuery('#<%=rs1.getInt(1)%>').modal('show', {backdrop: 'static'});">
									Resolve
									<i class="entypo-check"></i> </button></center></td>
                                                                        <td><center><a href="deletedoubt.jsp?id=<%=rs1.getInt(1)%>" onclick="return confirm('Are you sure want to Delete This Doubt ??');"><button type="button" class="btn btn-red btn-icon">
									Delete
									<i class="entypo-cancel"></i> </button></a></center></td>
                    </tr>
                    <div class="modal fade" id="<%=rs1.getInt(1)%>">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
						<h4 class="modal-title">Add The Solution To The Doubt</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">
                                                            <div class="form-group"> <label for="field-1" class="col-sm-3 control-label">Enter The Solution</label> 
                                                                <% 
                                                                    
                                                String combo=rs1.getInt(1)+"-"+rs1.getString(2);
                                                String textarea=combo+"sol";
                                                                %> 
                          									<textarea class="form-control" name="<%=textarea%>" id="<%=textarea%>" placeholder="Write The Solution  Here...."> </textarea>                                              
                                                            </div>
							</div>
	
                                  
						</div>
						
						
					</div>
                                    <div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
                                        <button type="button" class="btn btn-info" onclick="sendres('<%=combo%>','<%=textarea%>')">Submit Solution</button>
                                    </div>
				</div>
			</div>
        </div>
                    
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
