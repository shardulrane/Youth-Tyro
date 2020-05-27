<%-- 
    Document   : getclasssem
    Created on : May 25, 2016, 11:59:30 AM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
    String classs = request.getParameter("q");
    String uid=(String)request.getSession().getAttribute("uid");
    String buffer="<option value='0'>Please Select Semester</option>";
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1 = con.prepareStatement("SELECT Distinct Sem FROM classreg WHERE Class =? and uid=?");
            ps1.setString(1, classs);
            ps1.setString(2,uid);
            
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