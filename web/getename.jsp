<%-- 
    Document   : getename
    Created on : May 15, 2016, 8:30:56 PM
    Author     : Shardul Rane
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String e_id = request.getParameter("ut");
            String c_id = request.getParameter("un");
            String book;
            try {

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("select * from employee where College_code=? and Emp_No=?");
                ps.setString(1, c_id);
                ps.setString(2, e_id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    book = rs.getString(2);
                } else {
                    book = "";
                }
                response.getWriter().write(book);

            } catch (Exception e) {

                e.printStackTrace();
            }

%>
