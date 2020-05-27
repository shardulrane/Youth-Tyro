<%-- 
    Document   : deletedoubt
    Created on : Jun 2, 2016, 12:44:44 AM
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
      
            PreparedStatement ps = con.prepareStatement("DELETE FROM doubts WHERE d_id=?");
            ps.setInt(1, id);
            int i=ps.executeUpdate();
            if(i!=0)
            {
                      out.println("<script>alert('The Doubt Has Been Deleted Successfully !!!')\n" + "  window.location.href='viewdoubts.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
            }
            else{
               
                       out.println("<script>alert('Some Error Occured !!!')\n" + "  window.location.href='viewdoubts.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
             }
        
        }
        catch(Exception e)
        {
                   out.println("<script>alert('Opps!! Some Error Occured..Please Try Again')\n" + "  window.location.href='viewdoubts.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        
                   
        
        }
        
        
        
        
        %>
