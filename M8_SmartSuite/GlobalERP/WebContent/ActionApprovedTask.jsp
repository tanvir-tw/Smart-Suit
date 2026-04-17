<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<script>
function Redirect(indxtype,dept,ename,frdate,todate)
{
	alert("Task Is Approved Successfully");
    window.location="TaskMailDownLodedDataReport.jsp?Index="+indxtype+"&companyName1="+dept+"&EmpName="+ename+"&from_date1="+frdate+"&to_date1="+todate;
}
function Redirect1(indxtype,dept,ename,frdate,todate)
{
	alert("Task Is Rejected");
    window.location="TaskMailDownLodedDataReport.jsp?Index="+indxtype+"&companyName1="+dept+"&EmpName="+ename+"&from_date1="+frdate+"&to_date1="+todate;	
}
</script>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
try
{
		
Class.forName("com.mysql.cj.jdbc.Driver");
//con = DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/dotproject","erp","1@erp");
con = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
Statement st1=null,st2=null,st=null,st3=null,st4=null,st5=null,st6=null,st7=null;
st1=con.createStatement();
st2=con.createStatement();
st3=con.createStatement();
st4=con.createStatement();
st5=con.createStatement();
st6=con.createStatement();
st7=con.createStatement();

Statement stmt1 = con.createStatement();
Statement stmt2= con.createStatement();


String problem="",Description="",progess="",taskid="";
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

String id=request.getParameter("id");
System.out.println(">>>>>>>>id:"+id);
String action=request.getParameter("action");
System.out.println(">>>>>>>>Action:"+action);
String indxtype=request.getParameter("indxtype");
System.out.println(">>>>>>>>indxtype:"+indxtype);
String Sdept=request.getParameter("dept");
System.out.println(">>>>>>>>Sdept:"+Sdept);
String ename=request.getParameter("ename");
System.out.println(">>>>>>>>ename:"+ename);
String frdate=request.getParameter("frdate");
System.out.println(">>>>>>>>frdate:"+frdate);
String todate=request.getParameter("todate");
System.out.println(">>>>>>>>todate:"+todate);

/* for(int i=1;i<rejcomment2.length;i++)
{
	System.out.println("values"+rejcomment2[i]);
} */
%>
<input type="hidden" name="taskid" id="taskid" value="<%=id%>"/>
<% 
String []arr=id.split(",");
System.out.println("arr length"+arr.length);

for(int i=1;i<arr.length;i++)
{
	String  task_id = "",task_name = "",task_owner = "",task_strtDateTime = "",Task_dur = "",taskEndDateTime = "",Task_per_com = "",task_project="";
	String maildatetime="",username="",dept="",userid="";
	double Task_dur1=0.00;
	//String sql_total ="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where user_id='"+user_id+"' and date(task_end_date)>='"+frmDate+"' AND date(task_end_date)<='"+toTime+"' ";
	String sql_total="select * from dotproject.tasks where task_id='"+arr[i]+"'";
	System.out.println("The query is ==>>"+sql_total);
	ResultSet rs = st1.executeQuery(sql_total);
	System.out.println("The query is ==>>"+sql_total);
	DecimalFormat df = new DecimalFormat("0.00");
	if(rs.next()){
		//ck++;
		task_id = rs.getString("task_id");
		task_name = rs.getString("task_name");
		task_owner = rs.getString("task_project");
		Task_dur1 = rs.getDouble("task_duration");
}
	
	System.out.println("task_id "+task_id);
	System.out.println("TaskName "+task_name);
	
	System.out.println("Project Id "+task_owner);
	System.out.println("Duration "+Task_dur1);
	String MailDateTime="";
	String user="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='"+task_id+"' ";
	ResultSet rs1=st2.executeQuery(user);
	if(rs1.next())
			{
				//String userdetails="select * from dotproject.active_users where user_id='"+rs1.getString("UserId")+"'";
			MailDateTime=rs1.getString("MailDateTime");	
				
				String userdetails="select a.user_id,b.EmpName,b.Dept from dotproject.user_tasks a ,db_GlobalERP.UserMaster b where (a.user_id=b.dotprojectid or a.user_id=b.KRAdotprojectid) and task_id='"+task_id+"' and ActiveStatus='Yes' ";
				ResultSet rs3=st3.executeQuery(userdetails);
				if(rs3.next())
				{
					username=rs3.getString("b.EmpName");
					dept=rs3.getString("b.Dept");
					userid=rs3.getString("a.user_id");
				}	
			}
	System.out.println("User Name  "+username);
	System.out.println("Department "+dept);
	System.out.println("User Id  "+userid);
	
try{

	if(action.equals("approve"))
	{
		String insertString1="insert into  db_GlobalERP.dotprojectTaskLogs(EntryBy,task_name,Project_id,UserName,User_id,Task_id,Progess,Status,Approvedby) values('"+session.getAttribute("EmpName").toString()+"','"+task_name+"','"+task_owner+"','"+username+"','"+userid+"','"+task_id+"','100','Approved','"+session.getAttribute("EmpName").toString()+"') ";
	    System.out.println("INSERT QUERRY====>"+insertString1);
      st1.executeUpdate(insertString1);
	    
		String updatetask="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata set TaskStatus='Approved' where TaskID='"+task_id+"'";
		System.out.println("UPDATE QUERRY====>"+updatetask);
	    st4.executeUpdate(updatetask);
		
	    String updatetaskmaster="update dotproject.tasks set task_percent_complete='100' ,task_completion_date_time='"+MailDateTime+"' where task_id='"+task_id+"'";
		System.out.println("UPDATE Task Master QUERRY====>"+updatetaskmaster);
		st5.executeUpdate(updatetaskmaster);
		
		out.println("<script>  Redirect('"+indxtype+"','"+Sdept+"','"+ename+"','"+frdate+"','"+todate+"');</script>");
	    //out.println("<script type='text/javascript'>alert('Record Inserted Successfully');");

	  //  out.println("location='TaskLog.jsp?projectid="+Project_id+"&taskid="+taskid+"&totalTask="+totalTask+"&frmDate="+frmDate+"&toTime="+toTime+"&user_id="+Userid+"&user_name="+Username+"'");
	    //out.println("</script>");
	}
	    else
		{
	    	String rejcomment=request.getParameter("rejcomment");
	    	StringBuffer str = new StringBuffer(rejcomment);
	    	str.insert(0,',');
	    	System.out.println(">>>>>>>>Rejectiom:"+str);
	    	String p1=str.toString();
	    	String []rejcomment2=p1.split(",");
			System.out.println("arr val"+arr[i]);
			System.out.println("comment ForRejection"+rejcomment2[i]);
	    	int count=0;
			String updatetask="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata set TaskStatus='Rejected',TaskRejectionComment='"+rejcomment2[i]+"' where TaskID='"+task_id+"'";
			System.out.println("UPDATE QUERRY====>"+updatetask);
	    	count=st6.executeUpdate(updatetask);
			System.out.println("How many"+count);
			//String p="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='"+task_id+"'";
	      // ResultSet r=st7.executeQuery(p);
			//while(r.next())
		//	{
				//System.out.println("rejcomm"+rs.getString("TaskName"));
			//	System.out.println("rejcomm"+rs.getString("TaskRejectionComment"));
			//}
			out.println("<script>  Redirect1('"+indxtype+"','"+Sdept+"','"+ename+"','"+frdate+"','"+todate+"');</script>");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
}
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
} 

%>
