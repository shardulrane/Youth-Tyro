package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shardul Rane
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String username=request.getParameter("username");
            String password=request.getParameter("password");
          //  out.println(username);
           // out.println(password);
            try {
           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
            PreparedStatement ps1=con.prepareStatement("SELECT * FROM register_users WHERE mail=? and pass=?");
            ps1.setString(1, username);
            ps1.setString(2, password);
             ResultSet rs = ps1.executeQuery();
             if (rs.next() && username.equalsIgnoreCase(rs.getString("mail")) && password.equalsIgnoreCase(rs.getString("pass")) ) 
                        {
                                
               switch (rs.getString("type")) {
                   case "Teacher":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           response.sendRedirect("teacher/teacherhome.jsp");
                           //request.getRequestDispatcher("teacher/teacherhome.jsp").forward(request, response);
                           break;
                       }
                   case "HOD":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("hod/hodhome.jsp");
                           break;
                       }
                   case "Student":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           //  session.setAttribute("sid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("student/studenthome.jsp");
                           break;
                       }
                   case "Special":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("special/specialhome.jsp");
                           break;
                       }
                       case "Office":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("office/officehome.jsp");
                           break;
                       }
                       case "NGO":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("ngo/ngohome.jsp");
                           break;
                       }
                       
                       case "Other":
                       {
                           HttpSession session = request.getSession(true);
                           session.setAttribute("name", rs.getString(2));
                           session.setAttribute("uid",rs.getString(1));
                           session.setAttribute("cid", rs.getString(4));
                           session.setAttribute("eid", rs.getString(5));
                           ServletContext context = getServletContext();
                           //request.getRequestDispatcher("hod/hodhome.jsp").forward(request, response);
                           response.sendRedirect("other/otherhome.jsp");
                           break;
                       }
                   default:
                       break;
               }
                        } else 
                        {
                                request.setAttribute("wrongUser", username);

                                ServletContext context = getServletContext();
                                out.println("<script> alert('Wrong Username And Password')</script>");
                                request.getRequestDispatcher("index.html").include(request, response);
                            
                                // or you can write whole thing in one line as ........
                                // getServletContext().getRequestDispatcher("/fail").forward(request,
                                // response);
                        }
        out.close();
                        
            
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
