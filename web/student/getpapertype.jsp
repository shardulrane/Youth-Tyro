<%-- 
    Document   : getpapertype
    Created on : Jun 3, 2016, 12:35:52 PM
    Author     : Shardul Rane
--%>


<%@page import="java.time.Month"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String sem = request.getParameter("sem");
    String sub = request.getParameter("sub");
    String year=request.getParameter("year");
    String buffer = "<option value='0'>Please Select One Type</option>";
    //String uid = (String) request.getSession().getAttribute("uid");
    String cid = (String)session.getAttribute("cid");
    String monthString=null;
    int i=0;
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        PreparedStatement ps5 = con.prepareStatement("select  Distinct type from question_papers where c_id=? and sub=? and sem=? and year=?");
        
        ps5.setString(1, cid);
        ps5.setString(2, sub);
        ps5.setString(3, sem);
        ps5.setString(4, year);
        ResultSet rs1 = ps5.executeQuery();

        while (rs1.next()) {
       
    buffer = buffer + "<option value='" + rs1.getString("type") + "'>"+rs1.getString("type")+"</option>";
      
       
    monthString = "Invalid month";
          
        };
        buffer = buffer + "</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

          
    }

%>
