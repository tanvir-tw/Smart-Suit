<%@ include file="conn.jsp"%>
<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"
	import="javax.mail.Session"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page
	import="java.util.Date, 
javax.activation.DataSource,         
javax.activation.FileDataSource,     
javax.mail.Address,                  
javax.mail.BodyPart,                 
javax.mail.Message,                  
javax.mail.Multipart,                
javax.mail.Session,                  
javax.mail.Transport,                
javax.mail.internet.InternetAddress, 
javax.mail.internet.MimeBodyPart,    
javax.mail.internet.MimeMessage,     
javax.mail.internet.MimeMultipart,
 java.io.File,                  
 java.io.FileNotFoundException, 
 java.io.FileOutputStream,      
 java.io.IOException,           
 java.text.ParseException"%>
 
 <script>
 function fun(){
		
		
		
		
	  //alert("a");
	  var  agree=confirm("Do You Want To Deactivate This Record? ");
	  //alert(agree);
	  
	  
	  
	  var Id=document.getElementById("Id").value;
	  
	  if(agree)
	  {
		 	
		 window.location="opportunityCancle.jsp?&Id="+Id+""
		 return true ;
	  }	  	   
	  else
	  {
		  //alert("D") ;
		 
		 window.location="OpportunityReport.jsp";
	     return false ;
	  }	  	   

}
 </script>
<%! 
Connection con ;
%>
<%
		

String Id=request.getParameter("Id");
System.out.println("Id======>>>"+Id);
%>

<input type="hidden" id="Id" name="Id" value="<%=Id%>" />


<% 
   String action=request.getParameter("action");

%>

<input type="hidden" id="action" name="action" value="<%=action%>" />


<% 

/* int Id=Integer.parseInt(request.getParameter("Id")); */
%>

<%-- <input type="hidden" id="Id" name="Id" value="<%=Id%>" /> --%>


<% 
			%>
<script>
window.onload=fun ;
</script>
		
</body>
</form>
</html>