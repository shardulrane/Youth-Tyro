<%-- 
    Document   : getsubdiv
    Created on : Jun 3, 2016, 1:33:41 AM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String sem = request.getParameter("sem");
    String buffer="<option value='0'>Please Select One Subject</option>";
    
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
         PreparedStatement ps3=con.prepareStatement("select Course,Year,Division from reg_students where uid=?");
           String uid=(String)session.getAttribute("uid");
           ps3.setString(1,uid);
           ResultSet resultset4=ps3.executeQuery();
           if(resultset4.next())
           {
               String Course=resultset4.getString("Course");
               String Year=resultset4.getString("Year");
               
                      PreparedStatement ps4=con.prepareStatement("select Dept_ID from course where Course_Name=?");
                      ps4.setString(1, Course);
                          ResultSet resultset5=ps4.executeQuery();
           if(resultset5.next())
           {
                            PreparedStatement ps5=con.prepareStatement("select Distinct Subject from syllabus where Dept_ID=? and Semester=? and Year=?");
                      ps5.setString(1, resultset5.getString("Dept_ID"));
                      ps5.setString(2, sem);
                      ps5.setString(3,Year);

                      ResultSet rs1=ps5.executeQuery();

                      
             while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString("Subject")+"'>"+rs1.getString("Subject")+"</option>";
                                };
                             buffer=buffer+"</select>";
        response.getWriter().write(buffer);


           }
           }
    }catch (Exception e) {

        e.printStackTrace();
    }

%>