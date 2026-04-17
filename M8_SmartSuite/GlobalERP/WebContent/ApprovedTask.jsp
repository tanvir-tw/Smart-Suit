<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"
	import=" java.text.*"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Total Task</title>
<link rel="stylesheet" href="css/css.css" type="text/css"
	charset="utf-8" />
<script src="sorttable.js" type="text/javascript"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script>
	function getcheckedrow() {
		//alert("Control inside deldte function"+id);

		var id = document.getElementById("taskid").value;
		//alert(id);

		window.location = "ActionApprovedTask.jsp?action=approve&id=" + id + "";

	}

	function getcheckedrow1() {
		//alert("Control inside deldte function"+id);

		var id = document.getElementById("taskid").value;
		var action = document.getElementById("action").value;
		var indxtype = document.getElementById("indxtype").value;
		var Sdept = document.getElementById("Sdept").value;
		var ename = document.getElementById("ename").value;
		var frdate = document.getElementById("frdate").value;
		var todate = document.getElementById("todate").value;
		
		//alert("id"+id)
		var rejcomment = document.getElementById("rejcomment").value;
        var p=	$("textarea").filter(function () {
		    return $(this).val().length == 0
		}).length == 0;
	    if(p==false)
		{
	    	alert("Add Rejection Comment");
	    	return false;
		}
	    
	    
	
		//alert(document.getElementById("rejcomment").value);
		 var values = $("textarea[name='rejcomment\\[\\]']")
        .map(function(){return $(this).val();}).get();
       // alert(values); 

		//window.location = "ActionApprovedTask.jsp?action=reject&id=" + id + "&rejcomment=" + values + "";
		//window.location="ActionApprovedTask.jsp?action=&id="+id+"&rejcomment="+rejcomment+"";
		 window.location = "ActionApprovedTask.jsp?action=reject&id=" + id + "&rejcomment=" + values + "&indxtype="+indxtype+"&dept="+Sdept+"&ename="+ename+"&frdate="+frdate+"&todate="+todate;
	}
</script>
</head>
<body>
<%!Connection conn = null;
	Statement st = null;
	Statement st1 = null;%>
<%
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


	//String UserN = request.getParameter("userName");
	String UserN = "";
String rejcomment="";
	System.out.println(">>>>>>>>id:" + id);
	System.out.println(">>>>>>>>Name:" + UserN);
%>


<%
	String[] arr = id.split(",");
	System.out.println("arr length" + arr.length);

	Class.forName("com.mysql.cj.jdbc.Driver");
	//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
	//conn = DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/dotproject", "fleetview", "1@flv");
	//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
	//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");
	conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);

	st = conn.createStatement();

	System.out.println("The total Tasks is :" + action);
	System.out.println("The frmDate is :");
	System.out.println("The toTime is :");
%>
<table align="center" width="100%">
	<tr align="center">
		<td align="center">
			<%-- <font size="3"><b>Task Report of <%= user_name %> Between <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate)) %> And <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toTime)) %></b></font> --%>
			<font size="3" color="black"><b>Approved Task Report</b></font>
		</td>
	</tr>
</table>
<br>
<br>

<div align="center" style="width: 100%;" id="table1">
<form>
<input type="hidden" name="taskid" id="taskid" value="<%=id%>" />
<input type="hidden" name="action" id="action" value="<%=action%>" />
<input type="hidden" name="Sdept" id="Sdept" value="<%=Sdept%>" />
<input type="hidden" name="indxtype" id="indxtype" value="<%=indxtype%>" />
<input type="hidden" name="ename" id="ename" value="<%=ename%>" />
<input type="hidden" name="frdate" id="frdate" value="<%=frdate%>" />
<input type="hidden" name="todate" id="todate" value="<%=todate%>" />
<input type="hidden" name="indxtype" id="indxtype" value="<%=indxtype%>" />

	<table width="100%" border="1" align="center" class="sortable">


		<tr>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">SrNo</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">User
					Id</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Name</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">User
					Department</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Task
					ID</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Task
					Name</font></th>
			<!-- <th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Task Start Date & Time</font></th> -->
			<!-- <th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Task End Date & Time</font></th> -->
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Task
					Mail Date & Time</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Duration</font></th>
			<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Rejection Comment</font></th>


		</tr>
		<%
			int cnt = 1;
			for (int i = 1; i < arr.length; i++) {
				System.out.println("arr val" + arr[i]);

				int ck = 0;
				String task_id = "", task_name = "", task_owner = "", task_strtDateTime = "", Task_dur = "",
						taskEndDateTime = "", Task_per_com = "", task_project = "";
				String user_name = "";
				String maildatetime = "";
				double Task_dur1 = 0.00;
				//String sql_total ="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where user_id='"+user_id+"' and date(task_end_date)>='"+frmDate+"' AND date(task_end_date)<='"+toTime+"' ";
				//String sql_total="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='"+arr[i]+"' and date(taskenddate) >='2017-04-01 00:00:00' AND date(taskenddate) <='2017-04-01 11:00:00'";

				String sql_total = "select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='" + arr[i]
						+ "' limit 1";
				
				
				
				
				
				ResultSet rs = st.executeQuery(sql_total);
				System.out.println("The query is ==>>" + sql_total);
				DecimalFormat df = new DecimalFormat("0.00");
				while (rs.next()) {

					ck++;
					task_id = rs.getString("TaskID");
					task_name = rs.getString("TaskName");
					task_owner = rs.getString("TaskCreater");
					task_strtDateTime = rs.getString("TaskStartDate");
					Task_dur1 = rs.getDouble("AssignedDuration");
					taskEndDateTime = rs.getString("TaskEndDate");
					maildatetime = rs.getString("MailDateTime");
					Task_per_com = rs.getString("UserDepartment");
					task_project = rs.getString("UserId");
					
					String newq="select * from db_GlobalERP.UserMaster where (dotprojectid='"+task_project+"' or KRAdotprojectid='"+task_project+"')";
					System.out.println("The username is Quety :" + newq);
					st1 = conn.createStatement();
					ResultSet r=st1.executeQuery(newq);
					if(r.next())
					{
						user_name=r.getString("EmpName");
						System.out.println("The username is :" + user_name);
					}
		%>

		<tr>
			<td align="right"><div align="center"><%=cnt%></div></td>

			<%-- <td bgcolor="#0099cc"><div align="right"   ><a href="#" onclick="window.open('TaskLog.jsp?projectid=<%=task_project%>&taskid=<%= task_id %>&totalTask=<%=totalTask%>&frmDate=<%= frmDate%>&toTime=<%= toTime%>&user_id=<%=user_id%>&user_name=<%=user_name%>&width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 ')"><%= task_id %></a></div></td> --%>
			<td align="right"><div align="center"><%=task_project%></div></td>
			<td align="right"><div align="center"><%=user_name%></div></td>
			<td align="right"><div align="center"><%=Task_per_com%></div></td>
			<td align="left"><div align="center"><%=task_id%></div></td>
			<td align="left"><div align="center"><%=task_name%></div></td>
			<%-- <td align="right"><div align="right"><%= task_owner %></div></td> --%>
			<%-- <td align="right"><div align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_strtDateTime)) %></div></td> --%>

			<%-- <td align="right"><div align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(taskEndDateTime))  %></div></td> --%>
			<td align="right"><div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
							.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(maildatetime))%></div></td>
			<td align="right"><div align="center"><%=df.format(Task_dur1)%></div></td>
	 		<td> <textarea name="rejcomment[]" id="rejcomment" cols="45"
					rows="5" autofocus style="font-size: 12;" required></textarea> 
							<!-- <td> <input type="text" name="rejcomment[]" id="rejcomment" autofocus style="font-size: 12;"> -->
					
		</tr>
		<%
			}
//String newq="Select UserName from db_GlobalERP.UserMaster where UserId='"+task_project+"'";

				System.out.println("The user_id is :" + task_project);
				System.out.println("The username is :" + user_name);
				
				++cnt;
			}
		%>

	</table>
</div>
<input type="hidden" name="rejcomment1" id="rejcomment1" value="" />


<br>
<table align="center" style="width: 100%">
	<%
		if (action.equals("approve")) {
	%>
	<tr>
		<td align="center"><input type="button" name="Create Invoice"
			value="Approve" onclick="getcheckedrow()" /></td>
		<td></td>
		<td>
		<td></td>
		<%
			} else if (action.equals("reject")) {
		%>
	
	<tr>
		 <td align="center">
		 <input type="button" name="Create Invoice"
			value="Reject" onclick="getcheckedrow1()" /></td> 
			<!-- <td align="center"><input type="button" name="Create Invoice" id="cid"
			value="Reject" /></td> -->
		<td></td>
		<td>
		<td></td>
		<%
			}
		%>
		</tr>
		
</table>
</form>
</body>
</html>
<%@ include file="footer_new.jsp"%>