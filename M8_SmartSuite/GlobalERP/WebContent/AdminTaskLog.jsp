<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
    <%@ include file="header.jsp"%>
    <link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Total Task</title>
<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
<script src="sorttable.js" type="text/javascript"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javascript">


function formValidation()
{
	
// var progress=document.getElementById("progress1");
if(document.getElementById("progress1").value=="Select")
	{
	alert("Please Select Status");
return false;	
	}
	
	
// var descript=document.getElementById("Description");
if(document.getElementById("Description").value=="" || document.getElementById("Description").value==null )
	{
	alert("Description Can not be empty ");
return false;	
	}

// return true;
}




function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.index_total_cat.action ="excel.jsp";
          document.forms["index_total_cat"].submit();
}



</script>
</head>
<%!Connection conn = null;
   Statement st = null,st1 = null,st3=null,st5=null;
%>
<%

  String taskid = request.getParameter("taskid");
String userid = request.getParameter("userid");
  
  String currrentprogress="",taskname="",task_start_date="",task_end_date="",project_id="",task_hours_worked="",Status="",username="";
  String project_name="",Problem="";

Class.forName("com.mysql.cj.jdbc.Driver");
//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");

st=conn.createStatement();
st1=conn.createStatement();
st3=conn.createStatement();
st5=conn.createStatement();

String userinfo="select * from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and a.task_id='"+taskid+"'";
ResultSet rs = st.executeQuery(userinfo);
System.out.println("The query is ==>>"+userinfo);
while(rs.next()){
	
	project_id=rs.getString("task_project");
	
	currrentprogress=rs.getString("task_percent_complete");
	
	taskname=rs.getString("task_name");
	System.out.println("task_name"+taskname);
	
	//task_hours_worked=rs.getString("task_hours_worked");
	
	task_start_date=rs.getString("task_start_date");
	task_end_date=rs.getString("task_end_date");

}

String userinfo1="select Sum(task_hours_worked) as task_hours_worked,Problem,Status  from db_GlobalERP.dotprojectTaskLogs where Task_id='"+taskid+"' ";
ResultSet rs1 = st1.executeQuery(userinfo1);
System.out.println("The query is ==>>"+userinfo1);
while(rs1.next()){
	
	task_hours_worked=rs1.getString("task_hours_worked");
	System.out.println("task_hours_worked----->"+task_hours_worked);
	
	Problem=rs1.getString("Problem");
	
	Status=rs1.getString("Status");




}

String Username="Select user_username from dotproject.users where user_id='"+userid+"' ";
ResultSet rs5 = st5.executeQuery(Username);
System.out.println("The query is ==>>"+Username);
while(rs5.next()){
	
	 username=rs5.getString("user_username");
System.out.println("username----->"+username);

}


String projectname="Select project_name from dotproject.projects where project_id='"+project_id+"'";
ResultSet rs3 = st3.executeQuery(projectname);
System.out.println("The query is ==>>"+projectname);
while(rs3.next()){
	
	project_name=rs3.getString("project_name");
	
	

}

// System.out.println("The total Tasks is :"+totalTask);
// System.out.println("The frmDate is :"+frmDate);
// System.out.println("The toTime is :"+toTime);
// System.out.println("The user_id is :"+user_id);
// System.out.println("The username is :"+user_name);
%>
<%-- <%@ include file="header.jsp"%>  --%>
<form name="userform" action="AdminTaskLogInsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<input type="hidden" name="projectid" value="<%=project_id %>"/>
<input type="hidden" name="userid" value="<%=userid %>"/>			
  	<input type="hidden" name="hours" value="<%= task_hours_worked%>"/> 
    	<input type="hidden" name="taskid" value="<%=taskid%>"/> 
    	<input type="hidden" name="taskname" value="<%=taskname%>"/> 
     		<input type="hidden" name="project_name" value="<%=project_name %>"/>			
<%--  	<input type="hidden" name="frmDate" value="<%= frmDate%>"/> --%>
<%--     	<input type="hidden" name="toTime" value="<%=toTime%>"/>  --%>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Approve Task Log</b></font> </label></td></tr></tbody></table></div>


<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>ProjectId : </b><%=project_id%> </label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Project : </b><%=project_name%> </label></td>
</tr>

<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>UserId : </b><%=userid%> </label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>User : </b><%=username%> </label></td>
</tr>


<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task Start Date : </b> <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_start_date)) %></label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task End Date : </b> <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_end_date))  %></label></td>
</tr>


<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task : </b><%=taskname%> </label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Hours Worked:</b><%=task_hours_worked%></label>
			
			</td>
</tr>
<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Current Status : </b> <%=Status%> </label></td>

<!-- <tr> -->
<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Progress:</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value=""/></textarea><br><br><br>6,1</td> -->
<!-- </tr> -->

			
			<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Status :</b> </label>
			<div id="state">
 				<select name="progess1" id="progress1" class="element select medium">
 				<option value="Select">Select</option>
                <option value="Approved">Approved</option>
                <option value="Rejected">Rejected</option>
                </select>
            </div>
			</td>
			</tr>
<!-- <tr> -->
<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Problem :</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value=""/></textarea><br><br><br>7,1</td> -->
<!-- </tr> -->
<tr>
	<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Problem :</b><%=Problem%></label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>HODComments : </b> </label><textarea id="Description" name="Description"  class="element textarea medium"/></textarea>
</td>

</tr>

</table>
<!-- <div > -->

<div align="center">
<table align="center" >
<tr>
<td>
<div align="center">
<!-- <label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="submit" name="submit"  class="button_text" type="submit"  value="Cancel" /> -->
</div>
</td>
<td>
<div align="right">
<label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="submit" name="submit"  class="button_text" type="submit"  value="Update" />
</div>
</td>
</tr>
</table>
</div>


</form>
<%-- </jsp:useBean> --%>
</html>
<%@ include file="footer_new.jsp" %>