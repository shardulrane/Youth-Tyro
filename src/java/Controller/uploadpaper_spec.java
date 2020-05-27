package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Shardul Rane
 */
@MultipartConfig(maxFileSize = 15728640)//15MB
public class uploadpaper_spec extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // out.println("AAya mein Servlet Mein <br>");
            try {
                String ext = null;
                String uid = (String) request.getSession().getAttribute("uid");
                String combo[] = uid.split("-");
                String c_id = combo[0];
                String classes = request.getParameter("class");
                String sem = request.getParameter("sem");
                String sub = request.getParameter("sub");
                String type = request.getParameter("type_of_paper");

                InputStream inputStream = null;
                Part filePart = request.getPart("...");
                // out.println("Part Aaya");
                 if(filePart.getSize()<14728640)
                {
                inputStream = filePart.getInputStream();
                //   out.println("Input stream Gaya");
                String content = filePart.getContentType();

                String year = request.getParameter("year");
                //out.println("date aur eyar set hua<br>");
                switch (filePart.getContentType()) {
                    case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                        ext = null;
                        ext = "docx";
                        break;
                    case "application/msword":
                        ext = "doc";
                        break;
                    case "application/pdf":
                        ext = "pdf";
                        break;
                    case "image/jpeg":
                        ext = "jpeg";
                        break;
                    case "image/png":
                        ext = "png";
                        break;
                    default:
                        out.println("<script>alert('You Can Upload only Files with Extension as pdf,doc,docx,jpeg,jpg,& png !!!')\n" + "  window.location.href='hod/uploadquestionpaper.jsp';\n" + "</script>");
                        ext = "";
                        break;

                }
                if (ext != "") {

                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                    PreparedStatement ps1 = con.prepareStatement("SELECT * FROM register_users WHERE uid=?");
                    ps1.setString(1, uid);
                    ResultSet rs1 = ps1.executeQuery();
                    if (rs1.next()) {
                        String dept = rs1.getString(6);
                        PreparedStatement ps2 = con.prepareStatement("insert into question_papers(u_id,c_id,dept,classes,sem,sub,type,year,paper,Extension,Content_type) values(?,?,?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
                        ps2.setString(1, uid);
                        ps2.setString(2, c_id);
                        ps2.setString(3, dept);
                        ps2.setString(4, classes);
                        ps2.setString(5, sem);
                        ps2.setString(6, sub);
                        ps2.setString(7, type);
                        ps2.setString(8, year);
                        // out.println("sab initailize ho gaya hai");

                        if (inputStream != null) {
                            byte[] bytes = IOUtils.toByteArray(inputStream); //statement.set(4, bytes);
                            ps2.setBytes(9, bytes);
                            ps2.setString(10,ext);
                            ps2.setString(11,filePart.getContentType());
                            
                            // out.println("<br>data bytes mein gaya hai");
                                                    ps2.executeUpdate();
                            ResultSet keys = ps2.getGeneratedKeys();
                            if (keys.next()) {

                                int id = keys.getInt(1);
                                PreparedStatement ps3 = con.prepareStatement("select Dept_ID from department where Dept_Name=?");
                                ps3.setString(1, dept);
                                ResultSet rs3 = ps3.executeQuery();
                                if (rs3.next()) {
                                    String dept_id = rs3.getString("Dept_ID");

                                    PreparedStatement ps4 = con.prepareStatement("select Course_Name from course where Dept_ID=?");
                                    ps4.setString(1, dept_id);
                                    ResultSet rs4 = ps4.executeQuery();
                                    if (rs4.next()) {
                                        String course = rs4.getString("Course_Name");

                                        
                                        PreparedStatement ps5 = con.prepareStatement("select *  from reg_students where Cid=? and Course=? and Year=?");
                                        ps5.setString(1, c_id);
                                        ps5.setString(2, course);
                                        
                                        ps5.setString(3, year);
                                        

                                        ResultSet rs5 = ps5.executeQuery();
                                        while (rs5.next()) {
                                            PreparedStatement ps6 = con.prepareStatement("insert into notification(s_uid,cid,Course,uid,type,n_id) values(?,?,?,?,?,?)");
                                            ps6.setString(1, rs5.getString(2));
                                            ps6.setString(2, c_id);
                                            ps6.setString(3, course);
                                            ps6.setString(4, uid);
                                            ps6.setString(5, "Papers");
                                            ps6.setInt(6, id);
                                            ps6.execute();
                                        }

                                    }
                               
                           
                                out.println("<script>alert('Question Paper Has Been Uploaded Successfully !!!')\n" + "  window.location.href='special/uploadquestionpaper.jsp';\n" + "</script>");
                                con.close();
                            }
                            }else {
                                out.println("<script>alert('Some Problem Occured Please Check The Data Entered !!!')\n" + "  window.location.href='special/uploadquestionpaper.jsp';\n" + "</script>");
                                con.close();

                            }
                        }
                    }
                }
                }
                 else
                 {
                     out.println("<script>alert('You Con Upload Only file Upto 14MB !!!')\n" + "  window.location.href='special/uploadquestionpaper.jsp';\n" + "</script>");

                 }
            } catch (Exception e) {
                out.println("<script>alert('Some Problem Occured Please Check The Data Entered !!!')\n" + "  window.location.href='special/uploadquestionpaper.jsp';\n" + "</script>");

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
