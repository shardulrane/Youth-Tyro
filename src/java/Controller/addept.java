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

public class addept extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String c_code=request.getParameter("c_code");
            String deptid=request.getParameter("dept");
            String hod_id=request.getParameter("hod_id").toUpperCase();
            
          try {
                     Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
           PreparedStatement ps1=con.prepareStatement("select * from department where Dept_ID=?");
            ps1.setString(1,deptid);
            ResultSet rs=ps1.executeQuery();
                
            if (rs.next()) {
            String d_name=rs.getString(2);
           PreparedStatement ps=con.prepareStatement("insert into college_dept values(?,?,?,?)");
           ps.setString(1,deptid);
             ps.setString(2,hod_id);
             ps.setString(3,c_code);
             ps.setString(4, d_name);
              int i = ps.executeUpdate();
            //  out.println("<br>JOOOOOOOoafterex");
            if (i != 0) {
                out.println("<script>alert('Congo A New Department Is Now Registered Successfully')\n"+"  window.location.href='admin/home.html';\n"+"</script>");
               String redirectURL= "home.html";
                //response.sendRedirect(redirectURL);
                con.close();
            } else {
                out.println("failed to insert the data");
                con.close();
                
            }
            }
            } catch (Exception e) {
                out.println(e);
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
