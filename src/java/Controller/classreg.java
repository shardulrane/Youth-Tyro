package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shardul Rane
 */
public class classreg extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String stream = null;
            String stream1 = null;
            String classes = null;
            String ename = null;
            String uid = null;
            String collegeid = (String) request.getSession().getAttribute("cid");
            //  String cid=(String)session.getAttribute("name");
            String hod_dept = request.getParameter("department");
            String sem = request.getParameter("sem");
            String year = request.getParameter("year");
            String sub = request.getParameter("sub");
            String paper = request.getParameter("paper");
            String div = request.getParameter("div");
            String edept = request.getParameter("edepartment");
            String teacherid = request.getParameter("faculty");
            String theory = request.getParameter("types");
            String practical = request.getParameter("type");
            uid = collegeid + "-" + teacherid;
            try {
                //            out.println(hod_dept+"<br>");
//            out.println(year+"<br>");
//            out.println(sub+"<br>");
//            out.println(paper+"<br>");
//            out.println(div+"<br>");
//            out.println(edept+"<br>");
//            out.println(teacherid+"<br>");
//            out.println(theory+"<br>");
//            out.println(practical+"<br><br><br>");
//            out.println(collegeid+"<br>");
                String year1 = null;
                if (year.equals("First")) {
                    year1 = "FY";
                }
                if (year.equals("Second")) {
                    year1 = "SY";
                }
                if (year.equals("Third")) {
                    year1 = "TY";
                }

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps1 = con.prepareStatement("SELECT * FROM Syllabus WHERE Subject=? and Semester=?");
                ps1.setString(1, sub);
                ps1.setString(2, sem);
                ResultSet rs = ps1.executeQuery();
                if (rs.next()) {
                    stream = rs.getString(7);
                    if (stream.equals("Commerce")) {
                        stream1 = "BCom";
                    }
                    if (stream.equals("Science")) {
                        stream1 = "BSc";
                    }
                    if (stream.equals("Arts")) {
                        stream1 = "BA";
                    }
                    classes = year1 + stream1 + "(" + hod_dept + ")";
                   // out.println(classes);
                    PreparedStatement ps2 = con.prepareStatement("SELECT * FROM employee WHERE Emp_No=? and College_Code=?");
                    ps2.setString(1, teacherid);
                    ps2.setString(2, collegeid);
                    ResultSet rs1 = ps2.executeQuery();
                    if (rs1.next()) {
                        ename = rs1.getString(2);
                        PreparedStatement ps4 = con.prepareStatement("select * from classreg where Paper=? And Theory='Lecture' And Practical='Practical' and Div=?");
                        ps4.setString(1,paper);
                        ps4.setString(2, div);
                        //int check=ps4.executeUpdate();
                        ResultSet r2=ps4.executeQuery();
                        if(r2.next())
                        {
                                 out.println("<script>alert('Oops!!! Class Has Been Already Alloted..Please Modidy Or Delete From View Section !!!')\n" + "  window.location.href='hod/allotclass.jsp';\n" + "</script>");
                       
                        }
                        else
                        {
                        
                        PreparedStatement ps3 = con.prepareStatement("insert into classreg(uid,Name,Class,Sem,Div,Sub,Paper,Theory,Practical,year) values(?,?,?,?,?,?,?,?,?,?)");
                        ps3.setString(1, uid);
                        ps3.setString(2, ename);
                        ps3.setString(3, classes);
                        ps3.setString(4, sem);
                        ps3.setString(5, div);
                        ps3.setString(6, sub);
                        ps3.setString(7, paper);
                        ps3.setString(8,theory);
                        ps3.setString(9,practical);
                        ps3.setString(10,year);
 
                        int i = ps3.executeUpdate();
                        if (i != 0) {
                            out.println("<script>alert('A Class Has Been Alloted Successfully !!!')\n" + "  window.location.href='hod/allotclass.jsp';\n" + "</script>");
                        }
                        else
                        {
                                out.println("<script>alert('Oops Class Can't Be Registered!!!')\n" + "  window.location.href='hod/allotclass.jsp';\n" + "</script>");
                        
                        }
                        }
                    }
                }

            } catch (Exception e) {
                out.println("Some Error Occured" + e);
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
