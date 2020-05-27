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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shardul Rane
 */
public class registerstud extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String cid = request.getParameter("collegeid");
                String sid = request.getParameter("registernostud");
                String s_name = request.getParameter("name");
                String s_mail = request.getParameter("email");
                String s_dept = request.getParameter("sdept");
                String s_stream = request.getParameter("sstream");
                String s_course = request.getParameter("scourse");
                String s_year = request.getParameter("syear");
                String pass = request.getParameter("password");
                String div = request.getParameter("sdiv");
                String type = "Student";
                String uid = cid + "-" + sid;
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps1 = con.prepareStatement("select * from register_users where Cid=? and uid=? ");
                ps1.setString(1, cid);
                ps1.setString(2, uid);
                ResultSet i = ps1.executeQuery();
                if (i.next()) {
                    out.println("<script type='text/javascript'>alert('Oops !! User Already Registered...')\n" + "  window.location.href='registerstud.html';\n" + "</script>");
                    con.close();
                } else {
                    PreparedStatement ps = con.prepareStatement("insert into register_users(uid,name,mail,cid,eid,e_dept,pass,type) values(?,?,?,?,?,?,?,?)");
                    ps.setString(1, uid);
                    ps.setString(2, s_name);
                    ps.setString(3, s_mail);
                    ps.setString(4, cid);
                    ps.setString(5, sid);
                    ps.setString(6, s_dept);
                    ps.setString(7, pass);
                    ps.setString(8, type);
                    int s = ps.executeUpdate();
                    if (s != 0) {
                        PreparedStatement ps2 = con.prepareStatement("insert into reg_students(uid,Course,Stream,Year,Cid,Division) values(?,?,?,?,?,?)");
                        ps2.setString(1, uid);
                        ps2.setString(2, s_course);
                        ps2.setString(3, s_stream);
                        ps2.setString(4, s_year);
                        ps2.setString(5, cid);
                        ps2.setString(6, div);
                        
                        int p = ps2.executeUpdate();
                        if (p != 0) {
                            out.println("<script>alert('Registeration Successful !!! Welcome To Tyro')\n" + "  window.location.href='setupprofile.jsp';\n" + "</script>");
                            HttpSession session = request.getSession(true);
                            session.setAttribute("uid", uid);

                        } else {
                            out.println("<script type='text/javascript'>alert('Oops !! Some Error Occurred...')\n" + "  window.location.href='registerstud.html';\n" + "</script>");
                            con.close();

                        }

                    } else {
                        out.println("<script type='text/javascript'>alert('Oops !! Some Error Occured...')\n" + "  window.location.href='registerstud.html';\n" + "</script>");
                        con.close();

                    }
                }

            } catch (Exception e) {
                out.println("<script type='text/javascript'>alert('Oops !! Some Error Occured...')\n" + "  window.location.href='registerstud.html';\n" + "</script>");

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
