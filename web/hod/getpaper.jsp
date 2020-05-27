<%-- 
    Document   : getpaper
    Created on : May 18, 2016, 6:26:32 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String sub = request.getParameter("q");

    String buffer=null;
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("SELECT Paper FROM Syllabus WHERE Subject =?");
            ps1.setString(1, sub);
            ResultSet rs1=ps1.executeQuery();
            if(rs1.next())
            {
                buffer=rs1.getString("Paper");
             }
            
         else {
            buffer = "";
        }
        
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>