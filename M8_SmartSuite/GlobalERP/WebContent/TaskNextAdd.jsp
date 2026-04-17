<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@page import="java.util.*" %>
     <%@ include file="header.jsp"%>
     <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.stream.*"%>
   <%@ page import="java.util.*" %>
      
  <html> 
<head>
<style>

</style>




<script >
function Redirect()
{
	
	
	
	var userId=document.getElementById("userId1").value;
	//alert("userId is --->>" + userId);
		var HOD=document.getElementById('HOD1').value;
		//alert("HOD is---->>" + HOD);
		
		var Dept=document.getElementById('Dept1').value;
	//alert("Dept is---->>" + Dept);
		var TaskID=document.getElementById('TaskID1').value;
	//	alert("TaskID is---->>" + TaskID);
		var dd=document.getElementById('datenew1').value;
	//	alert("dd  is---->>" + dd);
		var dd1=document.getElementById('datenew2').value;
	//	alert("dd1  is---->>" + dd1);

		var Status=document.getElementById('Status1').value;
	//	alert("Status is---->>" + Status);
		var Role=document.getElementById('Role1').value;
	//	alert("Role is---->>" + Role);
		var Usern=document.getElementById('Usern1').value;
	//	alert("Usern is---->>" + Usern);
		

		alert("Task Submitted Succesfully ");
	location.assign("TaskDetReport.jsp?userId="+userId+"&fromdate="+dd+"&todate="+dd1+"&HOD="+HOD+"&Dept="+Dept+"&User="+Usern+"&Status="+Status+"&Role="+Role);
		
	
    
	
}
</script>
</head>
<body>



<%

Connection con=null;

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con.createStatement(); 

System.out.println("Connection done");

DecimalFormat df = new DecimalFormat("0.00");


SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));


String usrid11=request.getParameter("userId1");
System.out.println("usrid11 :- "+usrid11);

String tskid1=request.getParameter("tskid1");
System.out.println("tskid1 :- "+tskid1);

String comments311=request.getParameter("comments311");
System.out.println("comments311 :- "+comments311);

String datefrom=request.getParameter("datefrom");
String dateto=request.getParameter("dateto");
String hod=request.getParameter("hod");
String dep=request.getParameter("dep");
String usr=request.getParameter("usr");
String rol=request.getParameter("rol");
String stst=request.getParameter("stst");


%>
<input type="hidden" name="userId1" id="userId1"  value="<%=usrid11%>" >
                                                                <input type="hidden" name="Usern1" id="Usern1" value="<%=usr%>" /></input>   
  <input type="hidden" name="TaskID1" id="TaskID1" value="<%=tskid1%>" /></input>
  <input type="hidden" name="datenew1" id="datenew1" value="<%=datefrom%>" /></input>  
  <input type="hidden" name="datenew2" id="datenew2" value="<%=dateto%>" /></input>
   <input type="hidden" name="Status1" id="Status1" value="<%=stst%>" /></input>  
                <input type="hidden" name="HOD1" id="HOD1" value="<%=hod%>" /></input>   
                                <input type="hidden" name="Dept1" id="Dept1" value="<%=dep%>" /></input>   
                                                      <input type="hidden" name="Role1" id="Role1" value="<%=rol%>" /></input> 
               
<%
System.out.println("ALL :- "+datefrom+" "+dateto+" "+hod+" "+usr+" "+rol+" "+stst+" "+dep);


String sql ="update dotproject.tasks set task_description='"+comments311+"' where task_id='"+tskid1+"'";
System.out.println("The query is :"+sql);
stmt1.execute(sql);

	 out.println("<script>  Redirect();</script>");



%>
  
                    
</body>
</html>
