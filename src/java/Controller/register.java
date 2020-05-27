package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns = {"/register"})
public class register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String dept = null;
            String fname = request.getParameter("name");
            String mail = request.getParameter("email");
            //String dob=request.getParameter("birthdate");
            String cid = request.getParameter("collegeid");
            String eid = request.getParameter("registernoemp");
            String cname = request.getParameter("cname");
            String cadd = request.getParameter("caddress");
            dept = request.getParameter("edept");
            String type = "Teacher";
            String pass = request.getParameter("password");
            String uid = cid + "-" + eid;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("insert into register_users(uid,name,mail,cid,eid,e_dept,pass,type) values(?,?,?,?,?,?,?,?)");
                ps.setString(1, uid);
                ps.setString(2, fname);
                ps.setString(3, mail);
                ps.setString(4, cid);
                ps.setString(5, eid);
                ps.setString(6, dept);
                ps.setString(7, pass);
                ps.setString(8, type);
                int i = ps.executeUpdate();
                if (i != 0) {
                   out.println("<script>alert('Registeration Successful !!!')\n" + "  window.location.href='setupprofile.jsp';\n" + "</script>");
                   request.setAttribute("uid",uid);
                          HttpSession session = request.getSession(true);
                                session.setAttribute("uid",uid);
                              
                   
                    con.close();
                } else {
                    out.println("<script>alert('Oops !! User Already Registered...')\n" + "  window.location.href='registeremp.jsp';\n" + "</script>");
                    con.close();

                }

            } catch (Exception e) {

                out.println("<script>alert('Oops !! " + e + "')\n" + "  window.location.href='registeremp.html';\n" + "</script>");

            } finally {

            }

//            
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
