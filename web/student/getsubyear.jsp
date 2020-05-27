<%-- 
    Document   : getsubyear
    Created on : Jun 3, 2016, 11:51:16 AM
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
    String buffer = "<option value='0'>Please Select One Year</option>";
    //String uid = (String) request.getSession().getAttribute("uid");
    String cid = (String)session.getAttribute("cid");
    String monthString=null;
    int i=0;
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        PreparedStatement ps5 = con.prepareStatement("select  Distinct year from question_papers where c_id=? and sub=? and sem=?");
        
        ps5.setString(1, cid);
        ps5.setString(2, sub);
        ps5.setString(3, sem);
        ResultSet rs1 = ps5.executeQuery();

        while (rs1.next()) {
            String[] str = {"January",      
   "February",
   "March",        
   "April",        
   "May",          
   "June",         
   "July",         
   "August",       
   "September",    
   "October",      
   "November",     
   "December"};
           String yearsmonth=rs1.getString("year");
           String splityears[]=yearsmonth.split("-");
           i=Integer.parseInt(splityears[1]);
           String onlyear=splityears[0];
           
            if(i<str.length){
    monthString = str[i-1];
    String print=monthString+"-"+onlyear;  
    buffer = buffer + "<option value='" + rs1.getString("year") + "'>"+print+"</option>";
      
            }
            else{
    monthString = "Invalid month";
        }   
        };
        buffer = buffer + "</select>";
        response.getWriter().write(buffer);

    } catch (Exception e) {

          
    }

%>