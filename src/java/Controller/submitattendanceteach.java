package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shardul Rane
 */
public class submitattendanceteach extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");

                String classes = request.getParameter("class");
                String sem = request.getParameter("sem");
                String sub = request.getParameter("sub");
                String type = request.getParameter("type");
                String div = request.getParameter("div");
                int nooflect = Integer.parseInt(request.getParameter("nooflect"));
                String date = request.getParameter("date");
                String starttime = request.getParameter("starttime");
                int noofstud = Integer.parseInt(request.getParameter("noofstud"));
                String endtime = request.getParameter("endtime");
                String year = null;
                if (classes.startsWith("FY")) {
                    year = "First";
                }
                if (classes.startsWith("SY")) {
                    year = "Second";
                }
                if (classes.startsWith("TY")) {
                    year = "Third";
                }
                String cid = (String) request.getSession().getAttribute("cid");
                String uid = (String) request.getSession().getAttribute("uid");

                int length = classes.length();
                String course = classes.substring(2, length);

                //Time And Date Conversion is below
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date parsed = format.parse(date);
                java.sql.Date sqlfrom = new java.sql.Date(parsed.getTime());
                //starttime
                String combotime[] = starttime.split(":");
                String combo1[] = combotime[1].split(" ");
                int min = Integer.parseInt(combo1[0]);
                String type1 = combo1[1];
                int hours = 0;
                if (type1.equals("AM")) {
                    hours = Integer.parseInt(combotime[0]);

                }
                if (type1.equals("PM")) {
                    hours = Integer.parseInt(combotime[0]) + 12;

                }
//System.out.println("Hours" + hours + "<br>");
                int ms = 0;
                Time startsqltime = new Time(hours, min, ms);
//end time
                String comboendtime[] = endtime.split(":");
                String comboend1[] = comboendtime[1].split(" ");
                int min1 = Integer.parseInt(comboend1[0]);
                String type2 = comboend1[1];
                int hours1 = 0;
                if (type2.equals("AM")) {
                    hours1 = Integer.parseInt(combotime[0]);

                }
                if (type2.equals("PM")) {
                    hours1 = Integer.parseInt(combotime[0]) + 12;

                }
                int ms1 = 0;
                System.out.println("Hours" + hours + "<br>");
                Time endsqltime = new Time(hours1, min1, ms1);
                PreparedStatement qdept_id = con.prepareStatement("select e_dept from register_users where uid=?");
                qdept_id.setString(1, (String) request.getSession().getAttribute("uid"));
                ResultSet r1 = qdept_id.executeQuery();
                if (r1.next()) {
                    System.out.println("Got Deptname");

                    String dept = r1.getString("e_dept");
                    PreparedStatement gdept_id = con.prepareStatement("select Dept_ID from department users where Dept_Name=?");
                    gdept_id.setString(1, dept);
                    ResultSet r2 = gdept_id.executeQuery();
                    if (r2.next()) {
int id;
                        System.out.println("Got deptid");
                        String dept_id = r2.getString("Dept_ID");
                        //  out.println(startsqltime);
                        PreparedStatement insertlect = con.prepareStatement("insert into lectureinfo(uid,cid,Class,Dept_ID,Semester,Subject,Date,No_of_Lectures,Lecture_Type,Lec_Start_Time,Lec_End_Time) values(?,?,?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
                        insertlect.setString(1, uid);
                        insertlect.setString(2, cid);
                        insertlect.setString(3, classes);
                        insertlect.setString(4, dept_id);
                        insertlect.setString(5, sem);
                        insertlect.setString(6, sub);
                        insertlect.setDate(7, sqlfrom);
                        insertlect.setInt(8, nooflect);
                        insertlect.setString(9, type);
                        insertlect.setTime(10, startsqltime);
                        insertlect.setTime(11, endsqltime);
                        insertlect.executeUpdate();
ResultSet keys = insertlect.getGeneratedKeys();
                if(keys.next())
                {
                    id = keys.getInt(1);
                    
                
                    //    out.println("Got lecture report inserted");
                      //  out.println(dept_id);
                        
                      
                        String counter = null;
                        String record = null;
                        String sid = null;
                        String status = null;
                        String combo[] = null;
                      
                            PreparedStatement allotaten = con.prepareStatement("insert into attendance(Lecture_id,cid,uid,status) values(?,?,?,?)");
                            System.out.println("statement prepare hua");

                            allotaten.setInt(1, id);
                            allotaten.setString(2, cid);
                            System.out.println("set hua ");

                            for (int j = 1; j <= nooflect; j++) {
                                System.out.println("loop mein ghussa");

                                for (int i = 1; i <= noofstud; i++) {
                                    counter = Integer.toString(i);
                                    record = request.getParameter(counter);
                                    combo = record.split("@");
                                    sid = combo[0];
                                    status = combo[1];

                                    allotaten.setString(3, sid);
                                    allotaten.setString(4, status);
                                    allotaten.execute();

                                }
                            }
                            out.println("<script>alert('Attendance Has Been Granted Successfully With Submission OF lecture Report !!!')\n" + "  window.location.href='teacher/allotattendance.jsp';\n" + "</script>");
                            con.close();

                        }
                    }
                    }
                
            } catch (Exception e) {
                    out.println("<script>alert('Oops Some Problem Occured !!!')\n" + "  window.location.href='teacher/allotattendance.jsp';\n" + "</script>");
                        
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
