package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shardul Rane
 */
public class registerhod extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String fname = request.getParameter("name");
            String mail = request.getParameter("email");
            //String dob=request.getParameter("birthdate");
            String cid = request.getParameter("collegeid");
            String eid = request.getParameter("registernoemp");
            String cname = request.getParameter("cname");
            String cadd = request.getParameter("caddress");
            String dept = request.getParameter("edept");
            String type = "HOD";
            String pass = request.getParameter("password");
            String uid = cid + "-" + eid;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps0 = con.prepareStatement("select * from college_dept where College_Code=? and Dept_Name=?");
                ps0.setString(1, cid);
                ps0.setString(2, dept);
                ResultSet rs0 = ps0.executeQuery();
                if (rs0.next()) {
                    //   out.println("<script type='text/javascript'>alert('Oops !! Your ID Is Not Registered As HOD...')\n" + "  window.location.href='registerhod.html';\n" + "</script>");
                    if (rs0.getString(2).equals(eid)) {
                        PreparedStatement ps = con.prepareStatement("insert into register_users(uid,name,mail,cid,eid,e_dept,pass,type) values(?,?,?,?,?,?,?,?)");
                        ps.setString(1, uid);
                        ps.setString(2, fname);

                        ps.setString(3, mail);

                        ps.setString(4, cid);

                        ps.setString(5, eid);
                        ps.setString(6, dept);
                        ps.setString(7, pass);
                        ps.setString(8, type);

                        PreparedStatement ps1 = con.prepareStatement("select * from register_users where uid = ?");
                        ps1.setString(1, uid);

                        ResultSet rs = ps1.executeQuery();

                        if (rs.next()) {
                            out.println("<script type='text/javascript'>alert('Oops !! User Already Registered...')\n" + "  window.location.href='registerhod.html';\n" + "</script>");
                            con.close();

                        } else {
                            int i = ps.executeUpdate();
                            //  out.println("<br>JOOOOOOOoafterex");
                            if (i != 0) {
                                out.println("<script>alert('Registeration Successful !!!')\n" + "  window.location.href='setupprofile.jsp';\n" + "</script>");
                                HttpSession session = request.getSession(true);
                                session.setAttribute("uid",uid);
                              

                                con.close();
                            }
                        }
                    }

                } else {

                }
            } catch (Exception e) {
                out.println(e);
            } finally {

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
