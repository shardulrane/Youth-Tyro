<%-- 
    Document   : addcolg
    Created on : May 11, 2016, 6:47:30 PM
    Author     : Shardul Rane
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
  
        <body>
Welcome 
<br>
<a href="home.html">Home</a><br>
<a href="Logout">Logout</a><br>

<br>
<form name="addclg" action="../addclg">
<table>
	<tr>
	<td>College Name</td>
		<td><input type="text"  id="cname" name="cname"/></td>

	</tr>

	<tr>
	<td>College Address</td>
		<td><textarea id="cadd" name="cadd">Enter College Address</textarea></td>
		
	</tr>

	<tr>
	<td>College Code</td>
		<td><input type="text"  id="ccode" name="ccode"/></td>
		
	</tr>
	<tr>
			<td colspan="2"><input type="submit"/></td>
		</tr>
</table>
</form>
</body>
 
</html>
