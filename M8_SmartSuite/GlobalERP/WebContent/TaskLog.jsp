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
	alert("Select Progress Index");
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
   Statement st = null,st3=null,st4=null;
%>
<%
 String totalTask = request.getParameter("totalTask");
 String frmDate = request.getParameter("frmDate");
 String toTime = request.getParameter("toTime");
 String user_id = request.getParameter("user_id");
  String user_name = request.getParameter("user_name");
  
  String taskid = request.getParameter("taskid");
  
  
  String currrentprogress="",taskname="",task_start_date="",task_end_date="",project_id="",task_hours_worked="",project_name="";
  

Class.forName("com.mysql.cj.jdbc.Driver");
//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");

st=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();


String userinfo="select * from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and a.task_id='"+taskid+"'";
ResultSet rs = st.executeQuery(userinfo);
System.out.println("The query is ==>>"+userinfo);
while(rs.next()){
	
	project_id=rs.getString("task_project");
	
	currrentprogress=rs.getString("task_percent_complete");
	
	taskname=rs.getString("task_name");
	System.out.println("task_name"+taskname);
	
// 	task_hours_worked=rs.getString("task_hours_worked");
	
	task_start_date=rs.getString("task_start_date");
	task_end_date=rs.getString("task_end_date");

}

String task_hours="select Sum(task_log_hours) as task_log_hours from dotproject.task_log where task_log_name='"+taskname+"'";
ResultSet rs4 = st4.executeQuery(task_hours);
System.out.println("The query is task_hours ==>>"+task_hours);
while(rs4.next()){
	task_hours_worked=rs4.getString("task_log_hours");
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
<form name="userform" action="TaskLogInsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<input type="hidden" name="projectid" value="<%=project_id %>"/>
<input type="hidden" name="userid" value="<%=user_id %>"/>			
 	<input type="hidden" name="username" value="<%= user_name%>"/>
    	<input type="hidden" name="taskid" value="<%=taskid%>"/> 
    		<input type="hidden" name="totaltask" value="<%=totalTask %>"/>			
 	<input type="hidden" name="frmDate" value="<%= frmDate%>"/>
    	<input type="hidden" name="toTime" value="<%=toTime%>"/> 
    	<input type="hidden" name="hours" value="<%=task_hours_worked%>"/> 
    	<input type="hidden" name="projectname" value="<%=project_name%>"/> 
        <input type="hidden" name="taskname" value="<%=taskname%>"/> 
    	
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Update Task Progress</b></font> </label></td></tr></tbody></table></div>


<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>ProjectId : </b><%=project_id%> </label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Project : </b><%=project_name%> </label></td>
<input type="hidden" name="EntryBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
</tr>

<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>UserId : </b><%=user_id%> </label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>User : </b><%=user_name%> </label></td>

</tr>

<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task Start Date : </b> <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_start_date)) %></label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task End Date : </b> <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_end_date))  %></label></td>
</tr>


<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Task : </b><%=taskname%> </label></td>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Hours Worked :</b></label><input id="hourstext" name="hourstext123"  class="element text medium" type="text"  value="" /></td>
			

</tr>

<tr>
<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Status% : </b> <%=currrentprogress%> </label></td>

<!-- <tr> -->
<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Progress:</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value=""/></textarea><br><br><br>6,1</td> -->
<!-- </tr> -->

			
			<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Progress% :</b> </label>
			<div id="state">
 				<select name="progess1" id="progress1" class="element select medium">

				<option value="Select">Select</option>
                 <option value="0">0</option>
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
                 <option value="40">40</option>
                <option value="50">50</option>
                <option value="60">60</option>
                <option value="70">70</option>
                <option value="80">80</option>
                <option value="90">90</option>
                <option value="100">100</option>
            </select>
            </div>
			</td>
			</tr>

<tr>
	<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Problem :</b><input type="checkbox" name="problem" value="problem"></label></td>

<td  align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b>Comments : </b> </label><textarea id="Description" name="Description"  class="element textarea medium"/></textarea>
</td>

</tr>

</table>
<!-- <div > -->
<br>

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