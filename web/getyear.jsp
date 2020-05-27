<%-- 
    Document   : getyear
    Created on : May 27, 2016, 12:04:16 AM
    Author     : Shardul Rane
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String s_id = request.getParameter("ut");
            String c_id = request.getParameter("un");
            String book;
            try {

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("select * from student_info where College_Code=? and sid=?");
                ps.setString(1, c_id);
                ps.setString(2, s_id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    book = rs.getString(6);
                } else {
                    book = "";
                }
                response.getWriter().write(book);

            } catch (Exception e) {

                e.printStackTrace();
            }

%>
