<%-- 
    Document   : deleteallot
    Created on : Jun 2, 2016, 12:46:21 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
        int id=Integer.parseInt(request.getParameter("id"));
        
        try{
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
      
            PreparedStatement ps = con.prepareStatement("DELETE FROM classreg WHERE Class_id=?");
            ps.setInt(1, id);
            int i=ps.executeUpdate();
            if(i!=0)
            {
                      out.println("<script>alert('The Class Has Been Deleted Successfully !!!')\n" + "  window.location.href='viewallot.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
            }
            else{
               
                       out.println("<script>alert('Some Error Occured !!!')\n" + "  window.location.href='viewallot.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
             }
        
        }
        catch(Exception e)
        {
                   out.println("<script>alert('Opps!! Some Error Occured..Please Try Again')\n" + "  window.location.href='viewallot.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        
                   
        
        }
        
        
        
        
        %>

