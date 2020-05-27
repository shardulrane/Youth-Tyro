<%-- 
    Document   : getclasssubn
    Created on : May 27, 2016, 1:45:29 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String div = request.getParameter("q");
    String classes=request.getParameter("classes");
    String sem=request.getParameter("sem");
    String buffer="<option value='0'>Please Select One Subject</option>";
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("SELECT Sub FROM classreg WHERE Class =? And Sem=? and Div=?");
            ps1.setString(1, classes);
            ps1.setString(2, sem);
            ps1.setString(3, div);
            ResultSet rs1=ps1.executeQuery();
             while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString("Sub")+"'>"+rs1.getString("Sub")+"</option>";
                                };
                             buffer=buffer+"</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>
