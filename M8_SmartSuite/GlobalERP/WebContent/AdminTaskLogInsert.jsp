<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
try
{
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=null,st2=null,st3=null,st4=null,st8=null;
st1=con.createStatement();
st2=con.createStatement();
st3=con.createStatement();
st4=con.createStatement();
st8=con.createStatement();

String Status="",Progess="",Descriptionerp="";

Statement stmt1 = con.createStatement();
Statement stmt2= con.createStatement();

String problem="",Description="",progess="",taskid="";

String Assignedby=request.getParameter("assignedBy");
System.out.println("Assignedby=====>"+Assignedby);
problem=request.getParameter("problem");
System.out.println("problem=====>"+problem);
Description=request.getParameter("Description");
System.out.println("Description=====>"+Description);
Status=request.getParameter("progess1");
System.out.println("progess=====>"+progess);
String Userid=request.getParameter("userid");
System.out.println("Userid=====>"+Userid);

String hourstext=request.getParameter("hourstext123");
System.out.println("hourstext=====>"+hourstext);

 taskid=request.getParameter("taskid");
System.out.println("taskid=====>"+taskid);

String taskname=request.getParameter("taskname");
System.out.println("taskname=====>"+taskname);



String hours=request.getParameter("hours");
System.out.println("hours=====>"+hours);
String projectname=request.getParameter("project_name");
System.out.println("projectname=====>"+projectname);

 String Project_id=request.getParameter("projectid");

String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());



	
	String userinfo1="select * from db_GlobalERP.dotprojectTaskLogs where Task_id='"+taskid+"' ";
	ResultSet rs1 = st1.executeQuery(userinfo1);
	System.out.println("The query is ==>>"+userinfo1);
	while(rs1.next()){
		Descriptionerp=rs1.getString("Description");
		Progess=rs1.getString("Progess");
		System.out.println("Progess----->"+Progess);



	}

	if(problem!=null)
	{
		problem="1";
		System.out.println("Problem"+problem);
	}
	else{
		problem="0";
		System.out.println("problem"+problem);
	}
	
	
		
	if(Status.equals("Approved"))
	{

  	
  	
  	
  	
   	String updateSql="Update db_GlobalERP.dotprojectTaskLogs SET Status='"+Status+"',HodComments='"+Description+"',Approvedby='"+Assignedby+"'  where task_id='"+taskid+"'";
    	st2.executeUpdate(updateSql);
    	System.out.println("updateSql:---"+updateSql);
 	
    	String updateSql1="Update dotproject.tasks SET task_name='"+taskname+"',task_percent_complete='"+Progess+"' where task_id='"+taskid+"'  ";
    	st3.executeUpdate(updateSql1);
    	System.out.println("updateSql1:---"+updateSql1);
	
	
     	String updateSql2="insert into dotproject.task_log (task_log_description,task_log_hours,task_log_problem,task_log_task,task_log_name,task_log_creator,task_log_date) Values ('"+Descriptionerp+"','"+hours+"','"+problem+"','"+taskid+"','"+taskname+"','"+Userid+"','"+todaysDateTime+"')";
     	st8.executeUpdate(updateSql2);
     	System.out.println("updateSql1:---"+updateSql2);
  	
  	

out.println("<script type='text/javascript'>alert('Approved');");
out.println("location='AdminTaskLog.jsp?userid="+Userid+"&taskid="+taskid+"'");
out.println("</script>");

	}
 	else{
 		System.out.println("HEREHEREHEREHEREHERE=====Else Condtion inside Dn ");
		
  		String updateSql="Update db_GlobalERP.dotprojectTaskLogs SET Status='"+Status+"',HodComments='"+Description+"',Approvedby='"+Assignedby+"' where task_id='"+taskid+"'";
  	 	st2.executeUpdate(updateSql);
  	 	System.out.println("updateSql:---"+updateSql);
 	
        out.println("<script type='text/javascript'>alert('Rejected');");
 	 	//out.println("location='showperipheralsDet.jsp'");
 	 	//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
 	 	out.println("location='AdminTaskLog.jsp?userid="+Userid+"&taskid="+taskid+"'");
 	 	out.println("</script>");
 	}
//  	}
// }
// catch(Exception e)
// {
// 	out.println("<script type='text/javascript'>alert('Record Not Inserted');");
// 	//out.println("location='showperipheralsDet.jsp'");
// 	//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
// 	out.println("location='AdminTaskLog.jsp?userid="+Userid+"&taskid="+taskid+"'");
// 	out.println("</script>");
// }
}

catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
}
%>




