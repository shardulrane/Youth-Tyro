<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : adddept
    Created on : May 11, 2016, 6:48:06 PM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script type="text/javascript">
	function get(str)
    {
        var xmlhttp=new XMLHttpRequest();
        xmlhttp.onreadystatechange=function()
          {
          if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
              document.getElementById("cname").value=xmlhttp.responseText;
            }
          }
        xmlhttp.open("GET","../getcname?q="+str,true);
        xmlhttp.send();
        showcadd(str);
    }
</script>
    </head>
    <body>
        Welcome 
<br>
<a href="home.html">Home</a><br>
<a href="Logout">Logout</a><br>

<br>
<form name="addept" action="../addept">
	<table>
		<tr>
			<td>Enter College Code</td>
			<td><input type="text" name="c_code" id="c_code" onchange="get(this.value)" /></td>
		</tr>

		<tr>
			<td>Check College Name</td>
                        <td><input type="text" name="cname" id="cname" readonly="true"/></td>
		</tr>
                <%
                 try {
                      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=sa;password=niit#123");
           PreparedStatement ps=con.prepareStatement("select * from department");
           resultset=ps.executeQuery();
                %>
                
		<tr>
			<td>Add Department</td>
                        <td><select id="dept" name="dept">
                                <option value="0">
                                Select Department
                                </option>
        <%  while(resultset.next()){ %>
        <option value="<%= resultset.getString(1)%>"><%= resultset.getString(2)%></option>
        <% } %>
        </select></td>
		</tr>
<%

        }
        catch(Exception e)
        {
             out.println("wrong entry"+e);
        }
%>
		<tr>
			<td>Enter HOD'S Employee ID</td>
			<td><input type="text" name="hod_id" id="hod_id"/></td>
		</tr>
                 <tr>
			<td colspan="2"><input type="submit"/></td>
		</tr>
	</table>
</form>
    </body>
</html>
