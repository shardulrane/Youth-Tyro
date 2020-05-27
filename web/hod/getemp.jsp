<%-- 
    Document   : getemp
    Created on : May 18, 2016, 6:45:13 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    //gets hods college id
    String cid = (String) session.getAttribute("cid");
    String cid1=cid;
//gets the department of the employee to allot class
    String dept = request.getParameter("q");

    String buffer="<option value='0'>Please Select One Faculty</option>";
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        //get the employee from employee table from the same college    
        PreparedStatement ps1 = con.prepareStatement("SELECT * FROM employee WHERE Dept_ID =? AND College_Code =?");
            ps1.setString(1, dept);
            ps1.setString(2, cid1);
            ResultSet rs1=ps1.executeQuery();
            
                while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString(1)+"'>"+rs1.getString(2)+"</option>";
                                };
                             buffer=buffer+"</select>";
                             
            
            
         // else {
          //  buffer = "";
       // }
        
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>
