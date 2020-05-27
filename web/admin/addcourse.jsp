<%-- 
    Document   : addcourse
    Created on : May 11, 2016, 6:47:47 PM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
<%ResultSet resultset1 =null;%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
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
        showdept(str);
    }    
    
       function showdept(str)
{
   var xmlhttp;
var usertype = str;
var urls="../getdept?q="+usertype;

if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4)
    {
    document.getElementById("dept").innerHTML=xmlhttp.responseText;
             }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();

}

     function getdept(str)
    {
        var xmlhttp=new XMLHttpRequest();
        xmlhttp.onreadystatechange=function()
          {
          if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
                
              document.getElementById("dept").innerHTML=xmlhttp.responseText;
            }
          }
        xmlhttp.open("GET","../getdept?q="+str,true);
        xmlhttp.send();
      
    }    
    
        </script>
    </head>
    <body>
       Welcome 
<br>
<a href="home.html">Home</a><br>
<a href="Logout">Logout</a><br>

<br>
<form name="addept" action="../addcourse">
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
                   String code=getInitParameter("c_code");
                      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           Connection con=DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=sa;password=niit#123");
           PreparedStatement ps=con.prepareStatement("select DISTINCT Stream from course ");
           resultset=ps.executeQuery();
                %>
                <div id="deptshow">
                    <tr>
			<td>Select Department</td>
                        <td><select id="dept" name="dept"> 
				<option value="0">Please Select Dept</option>
                                

				</select></td>
		</tr>
                </div>
		
		<tr>
			<td>
				Link A Course
			</td>
			<td><select id="course" name="course">
				<option value="0">Please Select Stream</option>
                                <%  while(resultset.next()){ %>
        <option value="<%= resultset.getString(1)%>"><%= resultset.getString(1)%></option>
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
			<td colspan="2"><input type="submit"/></td>
		</tr>
	</table>
</form>
    </body>
</html>
