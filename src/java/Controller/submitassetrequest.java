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
public class submitassetrequest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String uid = (String) request.getSession().getAttribute("uid");
                String cid = (String) request.getSession().getAttribute("cid");

                String asset = request.getParameter("asset");
                String reason = request.getParameter("reason");
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("select * from reg_students where uid=? and Cid=?");
                ps.setString(1, uid);
                ps.setString(2, cid);
                ResultSet rs1 = ps.executeQuery();
                if (rs1.next()) {
                    int status=1;
                    PreparedStatement ps1 = con.prepareStatement("insert into college_assets(uid,c_id,stream,course,year,div,request_doc,reason,status) values(?,?,?,?,?,?,?,?,?)");
                    ps1.setString(1, uid);
                    ps1.setString(2, cid);
                    ps1.setString(3, rs1.getString(4));
                    ps1.setString(4, rs1.getString(3));
                    ps1.setString(5, rs1.getString(5));
                    ps1.setString(6, rs1.getString(7));
                    ps1.setString(7, asset);
                    ps1.setString(8, reason);
                    ps1.setInt(9, status);
                    
                    int i = ps1.executeUpdate();
                    if (i != 0) {

                        out.println("<script>alert('Your Request For "+asset+" Has Been Submitted Successfully !!!')\n" + "  window.location.href='student/reqassets.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();

                    } else {
                        out.println("<script>alert('Some Error Occcured !!!')\n" + "  window.location.href='student/reqassets.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();

                    }

                }

            } catch (Exception e) {
                out.println("<script>alert('Oops!!! Some Error Occured !!!')\n" + "  window.location.href='student/reqassets.jsp';\n" + "</script>");
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
