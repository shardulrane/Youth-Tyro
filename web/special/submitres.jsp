<%-- 
    Document   : submitres
    Created on : Jun 1, 2016, 8:16:56 PM
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
        String combo=request.getParameter("combo");
        String combosplit[]=combo.split("-");
        String did=combosplit[0];
        String uid=combosplit[1];
        
        
        String solution=request.getParameter("sol");
        int Status=2;
        String buffer="The Solution For Doubt id Has Been Updated";
        try{
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
      
            PreparedStatement ps = con.prepareStatement("update doubts set resolved_date=?,solution=?,status=? where d_id=?");
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setString(2, solution);
            ps.setInt(3, Status);
            ps.setString(4,did);
            int i=ps.executeUpdate();
            if(i!=0)
            {
                buffer="The Solution has Been Updated";
                response.getWriter().write(buffer);
            }
            else{
                    buffer="There was  Some Problem";
                response.getWriter().write(buffer);
            
             }
        
        }
        catch(Exception e)
        {
            buffer="There was  Some Problem";
                response.getWriter().write(buffer);
        
        }
        
        
        
        
        %>
