<%-- 
    Document   : getsub
    Created on : May 18, 2016, 6:04:10 PM
    Author     : Shardul Rane
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String eid = (String) session.getAttribute("eid");
    String cid = (String) session.getAttribute("cid");

    String sem = request.getParameter("q");
    String sdept = request.getParameter("dept");

    String buffer="<option value='0'>Please Select One Subject</option>";
    String dept=null;
    try {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        PreparedStatement ps = con.prepareStatement("select Dept_ID from college_dept where College_Code=? and HOD_ID=? and Dept_Name=?");
        ps.setString(1, cid);
        ps.setString(2, eid);
        ps.setString(3, sdept);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            
            dept=rs.getString("Dept_ID");
            PreparedStatement ps1 = con.prepareStatement("SELECT * FROM Syllabus WHERE Dept_ID =? AND Semester =?");
            ps1.setString(1, dept);
            ps1.setString(2, sem);
            ResultSet rs1=ps1.executeQuery();
                while(rs1.next()){
                                buffer=buffer+"<option value='"+rs1.getString(2)+"'>"+rs1.getString(2)+"</option>";
                                };
                             buffer=buffer+"</select>";
                             
            
            
        } else {
            buffer = "";
        }
        
        response.getWriter().write(buffer);

    } catch (Exception e) {

        e.printStackTrace();
    }

%>