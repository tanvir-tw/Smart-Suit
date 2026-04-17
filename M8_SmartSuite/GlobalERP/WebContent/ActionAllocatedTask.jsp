<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<script>
function Redirect(dept,name,issuestatus,chkbx,fd,td)
{
	alert("Task Is Allocated Successfully");
   window.location="OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chkbx+"&status=action "; 
	
}

</script>
<%@ include file="conn.jsp"%>
<%
		Date today = new Date();
		int k=0,j=0;
 		String chkedbx="",chkedtsk="",taskid="",first="";
		StringBuffer buffer=new StringBuffer(","); 
     		
 		int len=Integer.parseInt(request.getParameter("checkedNumber").toString());
 		System.out.println("len::"+len);
 		
 		int newlen=len+1;
 		
 		//while( j!=(Integer.parseInt(request.getParameter("checkedNumber").toString())))
 		while(j!=newlen)	
 		{
 		if(request.getParameter("check"+j)!=null)
 		buffer.append(j+",");
 		
 		String s=request.getParameter("check"+j);
 		System.out.println(j+"-s::"+s);

 		
 			j++;
 		}
 		
 		System.out.println("buffer::"+buffer);
 		
 		
 		for(int h=0;h <= len;h++)
 		{
 			

 		if(buffer.toString().contains(","+k+","))
 		{

 			 first=request.getParameter("net_id1"+k) ;
 			taskid=request.getParameter("task_id"+k) ;
 			
 			System.out.println("first::"+first);
 			System.out.println("task id ::"+taskid);
 			
 			chkedbx=chkedbx+","+first;
 			chkedtsk=chkedtsk+","+taskid;
 						
	 		System.out.println("chkedbx::"+chkedbx);
	 	    System.out.println("chkedtsk::"+chkedtsk);
	 		
 		}
 		
 		k++;
 		}
%>

<%
Connection con=null ;
try
{
	
Class.forName(DB_Driver_OI);
con = DriverManager.getConnection(DB_NAME_OI,DB_USERNAME_OI,DB_PASSWORD_OI);
	  
Statement st1=null,st2=null,st=null,st3=null;
st1=con.createStatement();
st2=con.createStatement();
st3=con.createStatement();

String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deptnew="",ename="",issuestatus="",chbk="",fd="",td="";

String Description=request.getParameter("Description");
System.out.println(">>>>>>>>Description:"+Description);

String issueId=request.getParameter("issue_id");
System.out.println(">>>>>>>>issueId:"+issueId);

String Desc=issueId+","+Description;
System.out.println(">>>>>>>>Desc:"+Desc);


String ComplaintID=request.getParameter("ComplaintID");
String CustomerType=request.getParameter("CustomerType");
String IssueRaisedBy=request.getParameter("IssueRaisedBy");
String Priority=request.getParameter("Priority");
String SystemName=request.getParameter("SystemName");
String ActionPoint=request.getParameter("ActionPoint");
String OpenIssue=request.getParameter("OpenIssue");
String TargetClosureDate=request.getParameter("TargetClosureDate");
String TaskType=request.getParameter("TaskType");
String IssueStatus=request.getParameter("IssueStatus");
String TargetDate=request.getParameter("TargetDate");
String Department=request.getParameter("Dept");
String Concern=request.getParameter("Concern");
String ClosureDate=request.getParameter("ClosureDate");


deptnew = request.getParameter("deptnew");
ename = request.getParameter("ename");
issuestatus = request.getParameter("issuestatus");
chbk = request.getParameter("chbk");
fd = request.getParameter("fd");
td = request.getParameter("td");

System.out.println("fd :"+fd+"  td "+td+"   deptnew "+deptnew+"  empnamenew "+ename+" issuestatusnew "+issuestatus+" checkall "+chbk);

System.out.println("Dept="+Department+"&User="+Concern+"&Status=Assigned&Description="+Description+"&issue_id="+issueId+"&ComplaintID="+ComplaintID+"&CustomerType="+CustomerType+"&IssueRaisedBy="+IssueRaisedBy+"&Priority="+Priority+"&SystemName="+SystemName+"&ActionPoint="+ActionPoint+"&OpenIssue="+OpenIssue+"&TargetClosureDate="+TargetClosureDate+"&TargetDate="+TargetDate+"&TaskType="+TaskType+"&ClosureDate="+ClosureDate+"&Status="+IssueStatus+" ");

%>
<% 

String  id="",task_id = "";

id=chkedtsk.replaceFirst(",","");
System.out.println(">>>>>>>>id:"+id);

String []arr=id.split(",");
System.out.println("arr length"+arr.length);

for(int i=0;i<arr.length;i++)
{
		
	String sql_total="select * from dotproject.tasks where task_id='"+arr[i]+"'";
	System.out.println("The query is ==>>"+sql_total);
	ResultSet rs = st1.executeQuery(sql_total);
	if(rs.next()){
		//ck++;
		task_id = rs.getString("task_id");
		
}
	
try{

		String updatetask="update dotproject.tasks set task_description='"+Desc+"' where task_id='"+task_id+"'";
		System.out.println("UPDATE QUERRY====>"+updatetask);
	    st2.executeUpdate(updatetask);

	    String sql = "update db_GlobalERP.100000OpenIssueTracker set ComplaintID='"+ComplaintID+"',CustomerType='"+CustomerType+"',IssueRaisedBy='"+IssueRaisedBy+"',Priority='"+Priority+"',SystemName='"+SystemName+"',ActionPoint='"+ActionPoint+"',OpenIssue='"+OpenIssue+"',TargetClosureDate='"+TargetClosureDate+"',TargetDate='"+TargetDate+"',Department='"+Department+"',Concern='"+Concern+"',TaskType='"+TaskType+"',ClosureDate='"+ClosureDate+"',Status='"+IssueStatus+"' where  Issue_SR_Id='"+issueId+"'";
		
		System.out.println("Sql Query for Update == "+sql);
		 
		st3.executeUpdate(sql);
		
		out.println("<script>  Redirect('"+deptnew+"','"+ename+"','"+issuestatus+"','"+chbk+"','"+fd+"','"+td+"');</script>");
	    
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