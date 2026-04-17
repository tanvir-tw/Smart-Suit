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
Statement st1=null,st2=null;
st1=con.createStatement();
st2=con.createStatement();


Statement stmt1 = con.createStatement();
Statement stmt2= con.createStatement();

String problem="",Description="",progess="",taskid="";

problem=request.getParameter("problem");

//  if(problem.equalsIgnoreCase("problem") || problem=="problem")
//  {
//  	problem="Yes";
//  	System.out.println("problem=====>"+problem);
//  }


Description=request.getParameter("Description");
System.out.println("Description=====>"+Description);
progess=request.getParameter("progess1");
System.out.println("progess=====>"+progess);
String Userid=request.getParameter("userid");
System.out.println("Userid=====>"+Userid);
String Username=request.getParameter("username");
System.out.println("Username=====>"+Username);
 taskid=request.getParameter("taskid");
System.out.println("taskid=====>"+taskid);

String hourstext=request.getParameter("hourstext123");
System.out.println("hourstext=====>"+hourstext);

String frmDate=request.getParameter("frmDate");
String toTime=request.getParameter("toTime");
String totalTask=request.getParameter("totaltask");
String Project_id=request.getParameter("projectid");
String hours=request.getParameter("hours");
System.out.println("hours=====>"+hours);
String projectname=request.getParameter("projectname");
System.out.println("projectname=====>"+projectname);
String taskname=request.getParameter("taskname");
System.out.println("taskname=====>"+taskname);

String EntryBy=request.getParameter("EntryBy");
System.out.println("EntryBy=====>"+EntryBy);


String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());




try{
	
	if(problem!=null)
	{
	problem="Yes";
		
    String insertString1="insert into  db_GlobalERP.dotprojectTaskLogs(EntryBy,task_name,project_name,Project_id,user_name,User_id,Task_id,task_hours_worked,Progess,Problem,Description) values('"+EntryBy+"','"+taskname+"','"+projectname+"','"+Project_id+"','"+Username+"','"+Userid+"','"+taskid+"','"+hourstext+"','"+progess+"','"+problem+"','"+Description+"') ";
    System.out.println("INSERT QUERRY====>"+insertString1);
    int sqlst=st1.executeUpdate(insertString1);
    
    out.println("<script type='text/javascript'>alert('Record Inserted Successfully');");

    out.println("location='TaskLog.jsp?projectid="+Project_id+"&taskid="+taskid+"&totalTask="+totalTask+"&frmDate="+frmDate+"&toTime="+toTime+"&user_id="+Userid+"&user_name="+Username+"'");
    out.println("</script>");
	
	}
	
	else
	{
		problem="No";
		
	    String insertString1="insert into  db_GlobalERP.dotprojectTaskLogs(EntryBy,task_name,project_name,Project_id,user_name,User_id,Task_id,task_hours_worked,Progess,Problem,Description) values('"+EntryBy+"','"+taskname+"','"+projectname+"','"+Project_id+"','"+Username+"','"+Userid+"','"+taskid+"','"+hourstext+"','"+progess+"','"+problem+"','"+Description+"') ";
	    System.out.println("INSERT QUERRY====>"+insertString1);
	    int sqlst=st1.executeUpdate(insertString1);
	    
	    out.println("<script type='text/javascript'>alert('Record Inserted Successfully');");

	    out.println("location='TaskLog.jsp?projectid="+Project_id+"&taskid="+taskid+"&totalTask="+totalTask+"&frmDate="+frmDate+"&toTime="+toTime+"&user_id="+Userid+"&user_name="+Username+"'");
	    out.println("</script>");
	}

out.println("<script type='text/javascript'>alert('Record Inserted Successfully');");

out.println("location='TaskLog.jsp?projectid="+Project_id+"&taskid="+taskid+"&totalTask="+totalTask+"&frmDate="+frmDate+"&toTime="+toTime+"&user_id="+Userid+"&user_name="+Username+"'");
out.println("</script>");

}
catch(Exception e)
{
	out.println("<script type='text/javascript'>alert('Record Not Inserted');");
	out.println("location='TaskLog.jsp?projectid="+Project_id+"&taskid="+taskid+"&totalTask="+totalTask+"&frmDate="+frmDate+"&toTime="+toTime+"&user_id="+Userid+"&user_name="+Username+"'");
	out.println("</script>");
}
}
 

	

catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
}
%>




