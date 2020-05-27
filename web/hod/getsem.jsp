<%-- 
    Document   : getsem
    Created on : May 18, 2016, 12:12:05 PM
    Author     : Shardul Rane
--%>

<%
    String year = request.getParameter("q");
       String buffer="<option value='0'>Select Semester</option>"; 
   
    //String book=null;
    if(year.matches("First"))
    {
        buffer=buffer+"<option value='I'>I</option><option value='II'>II</option>";
        
    }
    if(year.matches("Second"))
    {
    buffer=buffer+"<option value='III'>III</option><option value='IV'>IV</option>";
        
    }
    
    if(year.matches("Third"))
    {
    buffer=buffer+"<option value='V'>V</option><option value='VI'>VI</option>";
        
    }
    buffer=buffer+"</select>";
        response.getWriter().write(buffer);


%>
