<%-- 
    Document   : getsem1
    Created on : Jun 2, 2016, 12:14:10 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String classes = request.getParameter("class");
    String buffer="<option value='0'>Please Select One Semester</option>";
    
    try {
        //String query="select Distinct Class from classreg where Class like '%"+dept+"%'";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("select Distinct Sem from classreg where Class=?");
            ps1.setString(1, classes);
            ResultSet rs1=ps1.executeQuery();
             while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString("Sem")+"'>"+rs1.getString("Sem")+"</option>";
                                };
                             buffer=buffer+"</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>
