<%-- 
    Document   : getclassdiv
    Created on : May 27, 2016, 1:43:09 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String uid=(String)request.getSession().getAttribute("uid");
    
    String sem = request.getParameter("q");
    String classes=request.getParameter("classes");
    String buffer="<option value='0'>Please Select One Division</option>";
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("SELECT Distinct Div FROM classreg WHERE Class =? And Sem=? and uid=?");
            ps1.setString(1, classes);
            ps1.setString(2, sem);
            ps1.setString(3, uid);
            
            ResultSet rs1=ps1.executeQuery();
             while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString("Div")+"'>"+rs1.getString("Div")+"</option>";
                                };
                             buffer=buffer+"</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>