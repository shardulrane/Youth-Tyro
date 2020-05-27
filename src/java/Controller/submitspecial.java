package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shardul Rane
 */
public class submitspecial extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //out.println("Hii I am About To set A sepcial Teacher");
            String cid = (String) request.getSession().getAttribute("cid");
            String dept = request.getParameter("department");
            String teacher_uid = request.getParameter("teacher");
            String teacher_eid[]=teacher_uid.split("-");
            
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps1 = con.prepareStatement("UPDATE register_users SET type='Special' WHERE uid=? and e_dept=?");
                ps1.setString(1, teacher_uid);
                ps1.setString(2,dept);
                int i=ps1.executeUpdate();
                if(i!=0)
                {
                      out.println("<script>alert('Special Teacher Of "+dept+" With Employee ID "+teacher_eid[1]+" Has Been Updated Successfully !!!')\n" + "  window.location.href='hod/allotspecial.jsp';\n" + "</script>");
                            con.close();
                }
                else
                {
                 out.println("<script>alert('Some Problem Occured Please Check The Data Entered !!!')\n" + "  window.location.href='hod/allotspecial.jsp';\n" + "</script>");
                            con.close();
                }
            } catch (Exception e) {
             out.println("<script>alert('Some Problem Occured Please Check The Data Entered !!!')\n" + "  window.location.href='hod/allotspecial.jsp';\n" + "</script>");
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
