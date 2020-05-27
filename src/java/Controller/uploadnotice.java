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
public class uploadnotice extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String ext = null;
                String uid = (String) request.getSession().getAttribute("uid");
                String collegeid = (String) request.getSession().getAttribute("cid");
                String title = request.getParameter("title");
                String typeofnotice = request.getParameter("typeofnotice");
                InputStream inputStream = null;
                Part filePart = request.getPart("notice_file");
                if (filePart.getSize() < 14728640) {
                    switch (filePart.getContentType()) {
                        case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                            ext = null;
                            ext = "docx";
                            break;
                        case "application/msword":
                            ext = "doc";
                            break;
                        case "application/vnd.openxmlformats-officedocument.presentationml.presentation":
                            ext = "pptx";
                            break;
                        case "application/vnd.ms-powerpoint":
                            ext = "ppt";
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
                        case "application/vnd.ms-excel":
                            ext = "xls";
                            break;
                        case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                            ext = "xlsx";
                            break;
                        default:
                            out.println("<script>alert('You Can Upload only Files with Extension as pdf,ppt,pptx,doc,docx,jpeg,jpg,xls,xlsx & png !!!')\n" + "  window.location.href='hod/uploadquestionpaper.jsp';\n" + "</script>");
                            ext = "";
                            break;

                    }
                    if (ext != "") {
                        if (typeofnotice.equals("Department Notices")) {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                            PreparedStatement ps1 = con.prepareStatement("SELECT * FROM college_dept WHERE HOD_ID=? and College_Code=?");
                            ps1.setString(1, (String) request.getSession().getAttribute("eid"));
                            ps1.setString(2, collegeid);
                            ResultSet rs1 = ps1.executeQuery();
                            while (rs1.next()) {
                                String dept = rs1.getString(4);
                                PreparedStatement ps2 = con.prepareStatement("insert into notices_college(College_Code,Notice_File,Ntype,Department,Title,Extension,Content_type) values(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);

                                ps2.setString(1, collegeid);
                                ps2.setString(3, typeofnotice);
                                ps2.setString(4, dept);
                                ps2.setString(5, title);
                                ps2.setString(6, ext);
                                ps2.setString(7, filePart.getContentType());

                                if (filePart != null) {

                                    inputStream = filePart.getInputStream();
                                }
                                if (inputStream != null) {
                                    byte[] bytes = IOUtils.toByteArray(inputStream); //statement.set(4, bytes);
                                    ps2.setBytes(2, bytes);
                                }
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

                                            PreparedStatement ps5 = con.prepareStatement("select *  from reg_students where Cid=? and Course=?");
                                            ps5.setString(1, collegeid);
                                            ps5.setString(2, course);

                                            ResultSet rs5 = ps5.executeQuery();
                                            while (rs5.next()) {
                                                PreparedStatement ps6 = con.prepareStatement("insert into notification(s_uid,cid,Course,uid,type,n_id) values(?,?,?,?,?,?)");
                                                ps6.setString(1, rs5.getString(2));
                                                ps6.setString(2, collegeid);
                                                ps6.setString(3, course);
                                                ps6.setString(4, uid);
                                                ps6.setString(5, "Notice");
                                                ps6.setInt(6, id);
                                                ps6.execute();
                                            }

                                            out.println("<script>alert('Notice Has Been Uploaded Successfully !!!')\n" + "  window.location.href='hod/uploadnotice.jsp';\n" + "</script>");

                                        }
                                    }
                                }
                            }
                        } else {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                            PreparedStatement ps1 = con.prepareStatement("SELECT * FROM college_dept WHERE HOD_ID=? and College_Code=?");
                            ps1.setString(1, (String) request.getSession().getAttribute("eid"));
                            ps1.setString(2, collegeid);
                            ResultSet rs1 = ps1.executeQuery();
                            if (rs1.next()) {
                                String dept = rs1.getString(4);
                                PreparedStatement ps2 = con.prepareStatement("insert into notices_college(College_Code,Notice_File,Ntype,Department,Title,Extension,Content_type) values(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);

                                ps2.setString(1, collegeid);
                                ps2.setString(3, typeofnotice);
                                ps2.setString(4, dept);
                                ps2.setString(5, title);
                                ps2.setString(6, ext);
                                ps2.setString(7, filePart.getContentType());

                                if (filePart != null) {

                                    inputStream = filePart.getInputStream();
                                }
                                if (inputStream != null) {
                                    byte[] bytes = IOUtils.toByteArray(inputStream); //statement.set(4, bytes);
                                    ps2.setBytes(2, bytes);
                                }
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

                                            PreparedStatement ps5 = con.prepareStatement("select *  from reg_students where Cid=? and Course=?");
                                            ps5.setString(1, collegeid);
                                            ps5.setString(2, course);

                                            ResultSet rs5 = ps5.executeQuery();
                                            while (rs5.next()) {
                                                PreparedStatement ps6 = con.prepareStatement("insert into notification(s_uid,cid,Course,uid,type,n_id) values(?,?,?,?,?,?)");
                                                ps6.setString(1, rs5.getString(2));
                                                ps6.setString(2, collegeid);
                                                ps6.setString(3, course);
                                                ps6.setString(4, uid);
                                                ps6.setString(5, "Notice");
                                                ps6.setInt(6, id);
                                                ps6.execute();
                                            }

                                            out.println("<script>alert('Notice Has Been Uploaded Successfully !!!')\n" + "  window.location.href='hod/uploadnotice.jsp';\n" + "</script>");

                                        }
                                    }
                                }
                            }
                        }

                    } 
                    else {
                        out.println("<script>alert('Please Upload file Upto 14MB only !!!')\n" + "  window.location.href='hod/uploadnotice.jsp';\n" + "</script>");

                    }
                }
            }catch (Exception e) {
                out.println("Error Occured" + e);
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
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
