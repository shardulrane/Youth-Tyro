<%-- 
    Document   : getclasssub
    Created on : May 25, 2016, 12:56:03 PM
    Author     : Shardul Rane
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String sem = request.getParameter("q");
    String classes=request.getParameter("classes");
    String buffer="<option value='0'>Please Select One Subject</option>";
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("SELECT * FROM classreg WHERE Class =? And Sem=?");
            ps1.setString(1, classes);
            ps1.setString(2, sem);
            ResultSet rs1=ps1.executeQuery();
             while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString(7)+"'>"+rs1.getString(7)+"</option>";
                                };
                             buffer=buffer+"</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>