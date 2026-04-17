<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
</head>
<body style="background-color:azure;">
<%
Connection conn= null;
Statement st1=null, st2=null, st3=null, st4=null, st5=null, st6=null,st11=null, st12=null, st13=null,st15=null, st14=null;
try {
	conn = connection.getConnect("db_leaveapplication");       
    st1=conn.createStatement();
    st2=conn.createStatement();
    st3=conn.createStatement();
    st4=conn.createStatement();
    st5=conn.createStatement();
    st6=conn.createStatement();
    st11=conn.createStatement();
    st12=conn.createStatement();
    st13=conn.createStatement();
    st14=conn.createStatement();
    st15=conn.createStatement();
} catch (Exception e) {
e.printStackTrace();
} 
%>
	<%
String status=request.getParameter("status");
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Contractor</h5>
		    		</div>
<form name="editempfrm" action="addNewEmployeeInsert.jsp?action=editemp" method="post">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
<%
System.out.println("status::::::::::::;;"+status);
if(status.equalsIgnoreCase("Yes"))
{
	String EmpID="", empid="", EmpName="",UserName="",Email="",weekoff="";
	String qry=""; 
	String deptname="",deptcode="",ReportingtoHod="", Urole ="";
try
{
	EmpID= request.getParameter("EmpID");
	System.out.println("EmpID"+EmpID);

qry = "select * from t_leaveadmin where EmpID='"+EmpID+"' and status='Yes'";
System.out.println("ROleeeeeeeeeeeeee-->"+qry);

ResultSet rs = st1.executeQuery(qry);
System.out.println("ROleeeeeeeeeeeeee-->"+qry);
while(rs.next())
{
	deptname=rs.getString("TypeValue");
	empid = rs.getString("EmpID");
	EmpName =  rs.getString("Name");
	UserName = rs.getString("UName");
	System.out.println("UserName :::::::::::;; "+UserName);
	Email = rs.getString("Email");
	weekoff = rs.getString("weekOff");
	Urole = rs.getString("URole");
	ReportingtoHod=rs.getString("ReportingtoHod");
	String sqldc="select DeptCode,DeptName from t_department where DeptName='"+deptname+"'";
	System.out.println("sqldc -->"+sqldc);

    ResultSet rsdc=st2.executeQuery(sqldc);
    if(rsdc.next())
    {
    	deptcode=rsdc.getString("DeptCode");
    }
  %>
    <div class="row">
     <div class="row col-12 mt-3"> 
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmpID" name="EmpID" placeholder="" readonly value="<%=empid%>" required>
          <label for="EmpID" class="floating-label">Contractor ID</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Name" name="Name" value="<%=EmpName %>" required>
          <label for="Name" class="floating-label">Contractor Name</label>
        </div>
      </div>
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="UName" name="UName" value="<%=UserName%>" placeholder="" required>
          <label for="UName" class="floating-label">User Name</label>
        </div>
      </div>
 </div>    
</div>	  
<div class="row">
 <div class="row col-12 mt-3">      
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Email" name="Email" value="<%=Email %>" placeholder="" required>
          <label for="Email" class="floating-label">Email Id</label>
        </div>
      </div>
     
    <div class="col-4 mt-2">
                <div class="input-container">
			    <label class="form-label d-block">Type Of User</label>
			
			    <div class="form-check form-check-inline">
			    <% if(Urole.contains("contractor"))
			    {
			    %>
			        <input class="form-check-input" type="radio" id="URole" name="URole" value="contractor" checked="checked">
			        <% }
			    else
			    { %> <input class="form-check-input" type="radio" name="URole" id="URole" value="contractor"> <% 
			    }
			    %>
			        <label class="form-check-label" for="in">Contractor</label>
			    </div>
			
			    <div class="form-check form-check-inline">
			    <% if(Urole.contains("hod"))
			    {	%> <input class="form-check-input" type="radio" name="URole" id="URole1" value="hod" checked="checked"> <% 
			    }
			    else
			    { %> <input class="form-check-input" type="radio" name="URole" id="URole1" value="hod">
								<% 
			    }
			    %>
			        <label class="form-check-label" for="out">HOD</label>
			    </div>
			</div>
        </div>							
	<div class="col-4">
       <div class="input-container">    
        <label class="tcolor">Type Of Department</label>
            <select class="form-select" id="deptName" name="deptName" required>            
           				<%
                                if(deptname!=null){ %>
                                <option value="<%=deptcode%>"><%=deptname%></option>
						<%  
							try
							{
								String sqlCat="select DeptCode,DeptName from t_department where status='Active' and DeptName!='"+deptname+"'";
							    System.out.println("sqlCat::::::"+sqlCat);
								ResultSet rsCat=st3.executeQuery(sqlCat);
							    while(rsCat.next())
							    { %>
										<option value="<%=rsCat.getString("DeptCode") %>">
											<%=rsCat.getString("DeptName") %>
										</option>
										<%  } 
							}
							catch(Exception e)
							{
								System.out.println("Exception======>>"+e);
							 } 
                                } 
                                else{
                                %>
									<option value="-1">Select</option>
									<%
						try
						{
							String sqlCat="select DeptCode,DeptName from t_department where status='Active'";
						    ResultSet rsCat=st4.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
									<option value="<%=rsCat.getString("DeptCode") %>">
										<%=rsCat.getString("DeptName") %>
									</option>
									<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }
						 
						 }%>
							</select>
        </div>
      </div>	
     </div>
   </div>
						<%
						String HodName="";
						
						   System.out.println("ReportingtoHod::::::::::::::;"+ReportingtoHod);
						
						String sqlhodname="select Name from t_leaveadmin where EmpID='"+ReportingtoHod+"'";
					   System.out.println("sqlhodname::::::::::::::;"+sqlhodname);
						ResultSet rshodname=st5.executeQuery(sqlhodname);
					    if(rshodname.next())
					    { 
					    	HodName=rshodname.getString("Name");
					    } 
						%>
<div class="row">
 <div class="row col-12 mt-3">	
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="hod" name="hod"onkeyup="getUserHod()"  value="<%=HodName%>" placeholder="" required>
          <label for="Username" class="floating-label">HOD</label>
          <input type="hidden" name="hodid" id="hodid" value="<%=ReportingtoHod%>"/>
        </div>
         <div>
		<table border="0" align="center" style="font-family: arial;font-size:12; border-left: 120px">
		<tr><td></td></tr>
		  <tr><td>
		  <div id='userlist' style="overflow: auto; background:#fffff;">
		</div>
		  </td></tr>
		</table>
		</div>
   </div>
<script type="text/javascript">document.getElementById("userlist").style.visibility="hidden";</script>
    
    
    <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Weekly Off</label>
            <select class="form-select" id="weekoff" name="weekoff" required>            
           	<%
				
				if(weekoff == null) weekoff="";
				String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
				%>
				<%
				for(int i=0;i<days.length;i++){
				%>
				<option value="<%=i%>" <%= String.valueOf(i).equals(weekoff)?"selected":"" %>>
				<%=days[i]%>
				</option>
				<%
				}
				%>
			</select>
        </div>
      </div>                            
   <div class="col-4">
        <div class="input-container">
         <label class="tcolor">Status</label>
            <select class="form-select" id="status" name="status" required>
            <%
				String stats=request.getParameter("status");
				String stat="";
				if(stats.equalsIgnoreCase("Yes"))
				{
					stat="Activate";
				}
				else
				{
					stat="DeActivate";
				}
				%>
						<option value="<%= request.getParameter("status")%>"><%=stat%></option>
										<% if(stat.equalsIgnoreCase("Activate")){ %>
											<option value="No">DeActivate</option>
                                     <%}else{ %>
									<option value="Yes">Activate</option>
									<%} %>
            </select>   
        </div>
   </div>
         </div>
         </div>
	<%} %>
<%
} catch(Exception e){
	e.printStackTrace();
}
}else
{
	String EmpID="", empid="", EmpName="",UserName="",Email="",weekoff="";
	String qry=""; 
	String deptname="",deptcode="",ReportingtoHod="", Urole="";
	try
	{
		EmpID= request.getParameter("EmpID");
		System.out.println("EmpID"+EmpID);
	qry = "select * from t_leaveadmin where EmpID='"+EmpID+"' and status='No'";
	System.out.println("Roleeeeeeeeeeeeee-->"+qry);
	ResultSet rs = st11.executeQuery(qry);
	if(rs.next())
	{
		deptname=rs.getString("TypeValue");
		EmpName =  rs.getString("Name");
		ReportingtoHod=rs.getString("ReportingtoHod");
		UserName = rs.getString("UName");
		Email = rs.getString("Email");
		Urole = rs.getString("URole");
		String sqldc="select DeptCode,DeptName from t_department where DeptName='"+deptname+"'";
		
		System.out.println("sqldc:::::"+sqldc);
	    ResultSet rsdc=st12.executeQuery(sqldc);
	    if(rsdc.next())
	    {
	    	deptcode=rsdc.getString("DeptCode");
	    }
	  %>
    <div class="row">
     <div class="row col-12 mt-3"> 
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmpID" name="EmpID" placeholder="" readonly value="<%=empid%>" required>
          <label for="FullName" class="floating-label">Contractor ID</label>
        </div>
      </div>
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Name" name="Name" value="<%=EmpName %>" required>
          <label for="Username" class="floating-label">Contractor Name</label>
        </div>
      </div>
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="UName" name="UName" value="<%=UserName%>" placeholder="" required>
          <label for="Username" class="floating-label">User Name</label>
        </div>
      </div>
 </div>    
</div>						
<div class="row">
 <div class="row col-12 mt-3">      
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Email" name="Email" value="<%=Email %>" placeholder="" required>
          <label for="Username" class="floating-label">Email Id</label>
        </div>
      </div>
     
    <div class="col-4 mt-2">
                <div class="input-container">
			    <label class="form-label d-block">Type Of User</label>
			
			    <div class="form-check form-check-inline">
			    <% if(Urole.contains("contractor"))
			    {
			    %>
			        <input class="form-check-input" type="radio" id="URole" name="URole" value="contractor" checked="checked">
			        <% }
			    else
			    { %> <input class="form-check-input" type="radio" name="URole" id="URole" value="contractor"> <% 
			    }
			    %>
			        <label class="form-check-label" for="in">Contractor</label>
			    </div>
			
			    <div class="form-check form-check-inline">
			    <% if(Urole.contains("hod"))
			    {	%> <input class="form-check-input" type="radio" name="URole" id="URole1" value="hod" checked="checked"> <% 
			    }
			    else
			    { %> <input class="form-check-input" type="radio" name="URole" id="URole1" value="hod">
								<% 
			    }
			    %>
			        <label class="form-check-label" for="out">HOD</label>
			    </div>
			</div>
        </div>							
	<div class="col-4">
       <div class="input-container">    
        <label class="tcolor">Type Of Department</label>
            <select class="form-select" id="deptName" name="deptName" required>            
           				<%
                                if(deptname!=null){ %>
                                <option value="<%=deptcode%>"><%=deptname%></option>
						<%  
							try
							{
								String sqlCat="select DeptCode,DeptName from t_department where status='Active' and DeptName!='"+deptname+"'";
							    ResultSet rsCat=st13.executeQuery(sqlCat);
							    while(rsCat.next())
							    { %>
										<option value="<%=rsCat.getString("DeptCode") %>">
											<%=rsCat.getString("DeptName") %>
										</option>
										<%  } 
							}
						
							catch(Exception e)
							{
								System.out.println("Exception======>>"+e);
							 } 
                                } 
                                else{
                                %>
									<option value="-1">Select</option>
									<%
						try
						{
							String sqlCat="select DeptCode,DeptName from t_department where status='Active'";
						    ResultSet rsCat=st14.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
									<option value="<%=rsCat.getString("DeptCode") %>">
										<%=rsCat.getString("DeptName") %>
									</option>
									<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }
						 
						 }%>
							</select>
        </div>
      </div>	
     </div>
   </div>
	<%
						String HodName="";
						String sqlhodname="select Name from t_leaveadmin where EmpID='"+ReportingtoHod+"'";
						System.out.println("Type of departmen::: "+sqlhodname);
					    ResultSet rshodname=st15.executeQuery(sqlhodname);
					    if(rshodname.next())
					    { 
					    	HodName=rshodname.getString("Name");
					    } 
						%>
 
<div class="row">
 <div class="row col-12 mt-3">	
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="hod" name="hod"onkeyup="getUserHod()"  value="<%=HodName%>" placeholder="" required>
          <label for="Username" class="floating-label">HOD</label>
          <input type="hidden" name="hodid" id="hodid" value="<%=ReportingtoHod%>"/>
        </div>
         <div>
		<table border="0" align="center" style="font-family: arial;font-size:12; border-left: 120px">
		<tr><td></td></tr>
		  <tr><td>
		  <div id='userlist' style="overflow: auto; background:#fffff;">
			</div>
		  </td></tr>
		</table>
		</div>
		<script type="text/javascript">document.getElementById("userlist").style.visibility="hidden";
		</script>
    </div>
    <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Weekly Off</label>
            <select class="form-select" id="weekoff" name="weekoff" required>            
           	<%
				
				if(weekoff == null) weekoff="";
				String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
				%>
				<%
				for(int i=0;i<days.length;i++){
				%>
				<option value="<%=i%>" <%= String.valueOf(i).equals(weekoff)?"selected":"" %>>
				<%=days[i]%>
				</option>
				<%
				}
				%>
			</select>
        </div>
      </div>  
		 <div class="col-4">
        <div class="input-container">
         <label class="tcolor">Status</label>
            <select class="form-select" id="status" name="status" required>
			<%
				String stats=request.getParameter("status");
				System.out.println("hod name ::: "+stats);
				String stat="";
				if(stats.equalsIgnoreCase("Yes"))
				{
					stat="Activate";
				}
				else
				{
					stat="DeActivate";
				}
				System.out.println("hod name ::: "+stats);				
				%>
				<option value="<%=request.getParameter("status")%>"><%=stat%></option>
										<% if(stat.equalsIgnoreCase("Activate")){ %>
											<option value="No">DeActivate</option>
                                     <%}else{ %>
									<option value="Yes">Activate</option>
									<%} %>
					</select>
			</div>
	</div>	
	</div>
	</div>
	
	<%} %>
		<%
	} catch(Exception e){
		System.out.println("Ecetion e "+e);
		e.printStackTrace();
	}
 }%>


 <div class="d-grid gap-2 col-3 mx-auto mt-5">
        <button class="btn" id="submit" name="Submit" onclick="return validate();" type="submit">Update</button>
  </div> 

</div>
</div>
</form>
</div>
</div>
</div>
</div>
</section>
</div>
</div>


<%
String sendMsg=request.getParameter("sendMsg");
%>
						<input type="hidden" name="sendMsg" id="sendMsg"
							value="<%=sendMsg %>"></input>
						<%
if(!(sendMsg==null))
{
	System.out.println("======="+sendMsg+"=======");
	%>
<script lang="JavaScript" type="text/javascript">
	
	//alert("company created");
	var sendMsg=document.getElementById("sendMsg").value;
	alert(sendMsg+"\n");

	</script>

						<%}%>


<script type="text/javascript">
function showVisitingCardDetailsHod(username,hodid)
{
	 document.getElementById("hod").value=username;
	 document.getElementById("hodid").value=hodid;
	 document.getElementById("userlist").style.visibility='hidden';
	 document.getElementById("userlist").style.height="0";
}
function getUserHod()
{
	 var uname=document.getElementById("hod").value;
		 if(uname.length=="")
			{
			 document.getElementById("userlist").style.visibility="hidden";
			 document.getElementById("hod").value="";
			 document.getElementById("userlist").style.height="0"
			}
		 else
		 {
			 document.getElementById("userlist").style.visibility='visible';
			 document.getElementById("userlist").style.height="100px";
	 		var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
			ajaxRequest = new XMLHttpRequest();
	    }  
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					alert("Your browser broke!");
					return false;
				}
			}
		}

		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				document.getElementById("userlist").innerHTML=reslt;
			} 
		}
		
		var queryString = "?action=hod&name="+uname;
		ajaxRequest.open("GET", "AjaxGetHOD.jsp" + queryString, true);
		ajaxRequest.send(null); 
		 }//end of else
}
function getHodDetails(transporter)
{
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("reportingto").value=transporter;
}

function getHod(num)
{
	try{
	var b=0;
	var hodName=document.getElementById("reportingto").value;
    if(hodName.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			document.editempfrm.counter.value=b;
			document.editempfrm.counter.value=b*document.editempfrm.counter.value;
			counter=document.editempfrm.counter.value;
		} 
	};
	var queryString = "?hodName="+hodName+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxGetHodName.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
	}
}

</script>
<script lang="JavaScript" type="text/javascript">
function validate()
{
	var name=document.getElementById("Name").value;
	var uname=document.getElementById("UName").value;
	var Email =document.getElementById("Email").value;
	var URole = document.getElementById("URole").checked;
	var URole1 = document.getElementById("URole1").checked;
	var department=document.getElementById("deptName").value;
	var hod =document.getElementById("hod").value;
	if(name=="")
	{
		alert("Please Enter the Contractor Name");
		return false;
	}
	if(uname=="")
	{
		
		alert("Please Enter the User Name");
		return false;
	}
	else
	{
		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		    if (!filter.test(uname)) {
		    alert('Please provide a valid User Name');
		    return false;
					} 
	}
	if(Email=="")
	{
		alert("Please Enter the Email ID");
		return false;
	}
	else
	{
		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		    if (!filter.test(Email)) {
		    alert('Please provide a valid email ID');
		   
		    return false;
			} 
	}
	if( department == "-1" )
	{
  	alert( "Please Select Department" );
  	return false;
	}
	
	

	if( URole==true )
	{
	}else if(URole1==true)
	{//alert("hi1");
	}else
	{	alert("Please select Type Of User");
		return false;
	}

	if(hod=="")
	{
		alert("Please Enter HOD");
		return false;
	}
	return true;
}
</script>
<%@ include file="footer.jsp"%>
</body>
</html>