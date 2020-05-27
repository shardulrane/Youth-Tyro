package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Shardul Rane
 */
@MultipartConfig(maxFileSize = 6177215)

public class updatespecialprofile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try{
   HttpSession sesssion = request.getSession();
                String uid = (String) sesssion.getAttribute("uid");

                //String uid=(String)request.getAttribute("uid");
                String nick = request.getParameter("nick_name");
                String dob = request.getParameter("birthdate");
                String mobile = request.getParameter("mobile_number");
                String phone = request.getParameter("phone_number");
                String gender = request.getParameter("gender");
                String about = request.getParameter("about");
                String quotes = request.getParameter("quotes");
                String street = request.getParameter("street");
                String door = request.getParameter("door_no");
                String address = request.getParameter("address_line_2");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String zip = request.getParameter("zip");
                String achieve = request.getParameter("achieve");
                String religious = request.getParameter("aboutreligion");
                String political = request.getParameter("aboutpolitical");
                String interested = request.getParameter("interested");

                String relation = request.getParameter("relationship_status");
                 //   out.println(uid + "<br>" + nick + "<br>" + dob + "<br>" + mobile + "<br>" + phone + "<br>" + gender);
                InputStream inputStream = null;
                Part filePart = request.getPart("...");
                //  out.println("Part Aaya");

                if (filePart != null) {
                    // prints out some information for debugging
//                   System.out.println(filePart.getName());
//                   System.out.println(filePart.getSize());
//                   System.out.println(filePart.getContentType());

                   // obtains input stream of the upload file
                    inputStream = filePart.getInputStream();
                          // out.println("Input stream Gaya");

                    //System.out.println("FileUploadDBServlet.doPost()"+bytes.toString());
                }
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
                PreparedStatement ps = con.prepareStatement("update profile set profile_pic=?,nick_name=?,dob=?,mobile=?,phone=?,gender=?,aboutyou=?,quotes=?,street=?,door=?,address2=?,city=?,state=?,zip=?,achievement=?,religious_view=?,political_view=?,interested_in=?,relationship=? where uid=?");
                  //out.println("statement prepare ho gyaa");

                ps.setString(20, uid);

                ps.setString(2, nick);
                ps.setString(3, dob);
                ps.setString(4, mobile);
                ps.setString(5, phone);
                ps.setString(6, gender);
                ps.setString(7, about);
                ps.setString(8, quotes);
                ps.setString(9, street);
                ps.setString(10, door);
                ps.setString(11, address);
                ps.setString(12, city);
                ps.setString(13, state);
                ps.setString(14, zip);
                ps.setString(15, achieve);
                ps.setString(16, religious);
                ps.setString(17, political);
                ps.setString(18, interested);
                ps.setString(19, relation);
                 //out.println("image ke alava sab set ho gaya");

                if (inputStream != null) {
                    byte[] bytes = IOUtils.toByteArray(inputStream); //statement.set(4, bytes);
                    ps.setBytes(1, bytes);
                     //   out.println("image bytes set ho gyaa");

                    int i = ps.executeUpdate();
                    if (i != 0) {
                            // out.println("execute hua");
 PreparedStatement ps1 = con.prepareStatement("update register_users set gender=?,zip=? where uid=?");
                        ps1.setString(1, gender);
                        ps1.setString(2, zip);
                        ps1.setString(3, uid);
                int f=ps1.executeUpdate();
                if(f!=0)
                {
                        out.println("<script>alert('Profile Has Been Updated Successfully !!!')\n" + "  window.location.href='special/specialhome.jsp';\n" + "</script>");
                        //sesssion.invalidate();

                        con.close();
                    } 
                    }else {
                        out.println("<script>alert('Oops !!Some Error Occured...Please Login and Setup Your Profile')\n" + "  window.location.href='special/specialhome.jsp';\n" + "</script>");
                        con.close();
                     //   sesssion.invalidate();
                    }

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
