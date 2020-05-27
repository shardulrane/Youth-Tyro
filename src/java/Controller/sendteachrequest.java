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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shardul Rane
 */
public class sendteachrequest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           String uid1=request.getParameter("uid1");
           String uid2=request.getParameter("uid2");
           int status=1;
           try {
                         Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
           PreparedStatement ps=con.prepareStatement("insert into friends(uid1,uid2,status,action_uid) values(?,?,?,?)");
           ps.setString(1, uid1);
           ps.setString(2, uid2);
           ps.setInt(3, status);
           ps.setString(4, uid1);
           int i=ps.executeUpdate();
           if(i!=0)
           {
               
               out.println("<script>alert('Friend Request Has Been Send Successfully')\n" + "  window.location.href='teacher/showuser.jsp?id="+uid2+"';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                 
           }
           else
           {
           
                   out.println("<script>alert('Some Error Occured.. Please Try Later')\n" + "  window.location.href='teacher/showuser.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
           
           }
           
           
          
                
                
                
            } catch (Exception e) {
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
