<%-- 
    Document   : deletenotice
    Created on : Jun 4, 2016, 12:44:16 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
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
          PreparedStatement gettitle = con.prepareStatement("select Title FROM notices_college WHERE Notice_Id=?");
        gettitle.setInt(1, id);
        ResultSet r=gettitle.executeQuery();
        if(r.next())
        {
        
        String title=r.getString("Title");
            PreparedStatement ps = con.prepareStatement("DELETE FROM notices_college WHERE Title=?");
            ps.setString(1, title);
            int i=ps.executeUpdate();
            if(i!=0)
            {
        PreparedStatement ps1 = con.prepareStatement("delete from notification where uid=? and type=? and n_id=?");
            ps1.setString(1, (String)session.getAttribute("uid"));
            ps1.setString(2, "Notice");
            ps1.setInt(3, id);
            int j=ps1.executeUpdate();
            if(j!=0)
            {
            
                out.println("<script>alert('Selected Notice Has Been Deleted Successfully !!!')\n" + "  window.location.href='viewnotice.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
            }   
            }
            else{
               
                       out.println("<script>alert('Some Error Occured !!!')\n" + "  window.location.href='viewnotice.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
             }
        }
        }
        catch(Exception e)
        {
                   out.println("<script>alert('Opps!! Some Error Occured..Please Try Again')\n" + "  window.location.href='viewnotice.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        
                   
        
        }
        
        
        
        
        %>

