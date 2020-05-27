<%-- 
    Document   : getsdept
    Created on : May 26, 2016, 11:41:42 PM
    Author     : Shardul Rane
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
    try {
        String e_id = request.getParameter("ut");
        String c_id = request.getParameter("un");
        String book=null;
        String book1=null;

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        PreparedStatement ps = con.prepareStatement("select Dept_ID from student_info where College_code=? and sid=?");
        ps.setString(1, c_id);
        ps.setString(2, e_id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            book1 = rs.getString(1);
            PreparedStatement ps1 = con.prepareStatement("select Dept_Name from department where Dept_ID=?");
            ps1.setString(1, book1);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                book = rs1.getString(1);
            }

        } else {
            book = "";
        }
        response.getWriter().write(book);

    } catch (Exception e) {

        e.printStackTrace();
    }
%>