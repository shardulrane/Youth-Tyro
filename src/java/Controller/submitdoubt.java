/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shardul Rane
 */
public class submitdoubt extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String uid = (String) request.getSession().getAttribute("uid");
            String sub = request.getParameter("sub");
            String doubt = request.getParameter("doubt");
            String combo[] = sub.split("-");
            String subname = combo[1];
            String paperno = combo[0];
            int status = 1;
//            out.println("uid "+uid);
//            out.println("<br>subname "+subname);
//            out.println("<br>paperno "+paperno);
//            out.println("<br>doubt "+doubt);

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("SELECT Dept_ID,Year,Stream,Course FROM syllabus where Paper=? and Subject=?");
                ps.setString(1, paperno);
                ps.setString(2, subname);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String dept = rs.getString("Dept_ID");
                    String year = rs.getString("Year");
                    String stream = rs.getString("stream");
                    PreparedStatement ps2 = con.prepareStatement("insert into doubts(uid,dept_id,year,paper,subject,doubt,status) values(?,?,?,?,?,?,?)");
                    ps2.setString(1, uid);
                    ps2.setString(2, dept);
                    ps2.setString(3, year);
                    ps2.setString(4, paperno);
                    ps2.setString(5, subname);
                    ps2.setString(6, doubt);
                    ps2.setInt(7, status);
                    int i=ps2.executeUpdate();
                    if(i!=0)
                    {
                          out.println("<script>alert('Your Doubt Has Been Submitted Successfully !!!')\n" + "  window.location.href='student/doubts.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
                    }
                    else
                    {
                      out.println("<script>alert('Some Error Occured !!!')\n" + "  window.location.href='student/doubts.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                   
                    }

                }

            } catch (Exception e) {
            //out.println("<script>alert('Some Error Occured !!!')\n" + "  window.location.href='student/doubts.jsp';\n" + "</script>");
              out.println(e);
            //sesssion.invalidate();

                   
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
