<%@page import="java.util.Date"%>
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
 <style>
 #userlist {
    display: none;              /* hidden by default */
    position:absolute;
    background: aliceblue;           /* white background */
    border: 1px solid #ccc;     /* border */
    border-radius: 4px;         /* rounded corners */
    max-height: 200px;          /* limit height */
    width: 29%;                /* same width as input */
    overflow-y: auto;           /* vertical scroll if content is large */
    box-shadow: 0 2px 6px rgba(0,0,0,0.15); /* subtle shadow */
    z-index: 9999;              /* keep above other elements */
    padding: 5px;
    font-size: 13px;
}
#userlist div, #userlist li {
    padding: 6px 10px;
    cursor: pointer;
}
#userlist div:hover, #userlist li:hover {
    background-color: #f1f1f1;  /* hover effect */
}
 
 </style>
</head>
<body style="background-color:azure;">

<%
//Connection Initialization
Connection con = null;
Statement st1 = null,st2=null,st21=null,st3=null;

try {
		con = connection.getConnect("db_GlobalERP");       

	    st1=con.createStatement();
	    st2=con.createStatement();
	    st21=con.createStatement();
	    st3=con.createStatement();

} catch (Exception e) {
	e.printStackTrace();
} 

String UserName=request.getParameter("UserName");
System.out.println("User Name------------------------------------------------->"+ UserName);

%>

<%

	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String uname="",department="";
	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	
	%>

<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit User Details</h5>
		    		</div>
		             <br>




<form name="editNewUser" method="post" enctype="multipart/form-data" action="updateNewUser.jsp" onsubmit="return validate();">

<%
	String sql="select * from UserMaster where UserName='"+UserName+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
	System.out.println("Sql->"+sql); 
 	ResultSet rs = st1.executeQuery(sql);
 	while(rs.next())
	{
		
%>
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Selectuser" name="Selectuser" value="<%=rs.getString("EmpName") %>" placeholder="" required>
          <label for="FullName" class="floating-label">Employee Name</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
        <%uname=rs.getString("UserName"); %>
          <input class="form-control floating-input" type="text" id="UserName" name="UserName" class="element text" placeholder="" value="<%=uname%>" required>
          <label for="Username" class="floating-label">User Name</label>
        </div>
      </div>

      <div class="col-4 ">
        <div class="input-container">    
        <label class="tcolor">User Level</label>
            <select class="form-select" id="UserLevel" name="UserLevel" required>            
				<option value="Level1" <% if(rs.getString("UserLevel").equalsIgnoreCase("Level1")){ %> Selected<%}%>>Level1</option>
				<option value="Level2" <% if(rs.getString("UserLevel").equalsIgnoreCase("Level2")){ %> Selected<%}%>>Level2</option>
				<option value="Level3" <% if(rs.getString("UserLevel").equalsIgnoreCase("Level3")){ %> Selected<%}%>>Level3</option>
				<option value="Level4" <% if(rs.getString("UserLevel").equalsIgnoreCase("Level4")){ %> Selected<%}%>>Level4</option>
				<option value="Level5" <% if(rs.getString("UserLevel").equalsIgnoreCase("Level5")){ %> Selected<%}%>>Level5</option>
           </select>
        </div>
      </div>
  </div>    
</div>
<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
<div class="input-container">    
        <label class="tcolor">Department</label>
            <select class="form-select" id="Department" name="Department" required>            
           	<%
           	String sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            
    		System.out.println("*******"+sql1);
            ResultSet rsdept = st2.executeQuery(sql1);
    		while(rsdept.next())
    		{
    			department=rsdept.getString("department");
    			 System.out.println("department-->"+department);
    			%>
    			<option value="<%=department%>" <% if(rs.getString("Dept").equalsIgnoreCase(department)){ %> Selected<%}%>><%=department%></option>
     <%
          }
    		%>		
           
           </select>
        </div>
      </div>
      
      <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="UserLevelAccess" name="UserLevelAccess" placeholder="" value="1,2,3" required>
          <label for="EmpCode" class="floating-label">Company UserLevel Access</label>
        </div>
      </div>
      
        <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmpCode" name="EmpCode" placeholder="" value="<%=rs.getString("EmpCode") %>" required>
          <label for="EmpCode" class="floating-label">Employee Code</label>
        </div>
      </div>
</div>
</div>
<%
String TALEVEL="";
if(rs.getString("TALevel")==null)
{
	TALEVEL="-";
}
else
{
	TALEVEL=rs.getString("TALevel");
}
%>


<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">TA Level</label>
            <select class="form-select" id="TALevel" name="TALevel" required> 
				<option value="M1" <% if(TALEVEL.equalsIgnoreCase("M1")){ %> Selected<%}%>>M1</option>
				<option value="M2" <% if(TALEVEL.equalsIgnoreCase("M2")){ %> Selected<%}%>>M2</option>
				<option value="M3" <% if(TALEVEL.equalsIgnoreCase("M3")){ %> Selected<%}%>>M3</option>
				<option value="M4" <% if(TALEVEL.equalsIgnoreCase("M4")){ %> Selected<%}%>>M4</option>
				<option value="M5" <% if(TALEVEL.equalsIgnoreCase("M5")){ %> Selected<%}%>>M5</option>
</select>
 </div>
</div>

 <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="mobileno" name="mobileno" value="<%=rs.getString("mobileno") %>" placeholder="" required>
          <label for="Mobno" class="floating-label">Mobile Number</label>
        </div>
      </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="email" id="email" name="email" value="<%=rs.getString("email") %>" placeholder="" required>
          <label for="emailid" class="floating-label">Email-Id</label>
        </div>
      </div>
</div>
</div>

<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Active Status</label>
            <select class="form-select" id="ActiveStatus" name="ActiveStatus" required>            
				<option value="Yes" <% if(rs.getString("ActiveStatus").equalsIgnoreCase("Yes")){ %> Selected<%}%>>Yes</option>
				<option value="No" <% if(rs.getString("ActiveStatus").equalsIgnoreCase("No")){ %> Selected<%}%>>No</option>
           </select>
        </div>
      </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="hod" name="hod" placeholder="" value="<%=rs.getString("HodReport") %>" onkeyup="getUserHod();" required>
          <label for="hod" class="floating-label">HOD</label>
        </div>
    <div id="userlist" style="display:none;"></div>
      </div>
       <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="dotid" name="dotid" placeholder="" value="<%=rs.getString("dotprojectid") %>" required>
          <label for="hod" class="floating-label">DotProjectId</label>
        </div>
      </div>
</div>
</div>
<div class="row">
 <div class="row col-12 mt-3"> 
   <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="kradotid" name="kradotid" placeholder="" value="<%=rs.getString("KRAdotprojectid") %>" required>
          <label for="hod" class="floating-label">KRADotprojectid</label>
        </div>
      </div>
 
      <div class="col-4">
	 	<div class="input-container">    
        <label class="tcolor">Role</label>
            <select class="form-select" id="rolenew" name="rolenew" required>            
<%
String role123="";
	String rolequery="select distinct(Role) from UserMaster order by Role";
	ResultSet rsrole=st21.executeQuery(rolequery);
	if(rs.getString("Role").equals("-"))
	{
		%>
		<option value="<%=rs.getString("Role")%>" selected>Contractor</option>
		<% 
	}
	
	else
	{%>
	
	<option value="<%=rs.getString("Role")%>" selected><%=rs.getString("Role") %></option>
	
<% }
while(rsrole.next())
	{
		role123=rsrole.getString("Role");
	
		System.out.println("Role is:---------------------------------------->:"+role123);
	if(role123.equals("-"))
	{
		String role45="Contractor";
		%>
		<option value="<%=role123%>"><%=role45 %></option>
		<%
	}
	else
	{	
	%>
	<option value="<%=role123 %>" ><%=role123 %></option>
	<% 
	}
	}
	%>
 </select>
        </div>
      </div>
      
      
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">User Access</label>
            <select class="form-select" id="UAL" name="UAL" required>
            
<%String UTC="",Usertype="",UserTypecode=""; %>
<%
if(rs.getString("UserTypeCode") == null)
{
	UTC="-";
}

else
{
String query123="select * from UserTypeMaster where UserTypeCode='"+rs.getString("UserTypeCode")+"'";
System.out.println("Query is----------->:"+query123);

UserTypecode=rs.getString("UserTypeCode");


System.out.println("UserTypecode is:"+UserTypecode);
ResultSet rs123=st3.executeQuery(query123);
if(rs123.next())
{
	
Usertype=rs123.getString("UserType");
}
else
{
	Usertype="-";
	
}

}

String sqlDeatils1="Select * from db_GlobalERP.UserTypeMaster where UserType !='Super Admin' and UserType !='"+Usertype+"'" ;
System.out.println("*********((((((((((((    "+sqlDeatils1);
ResultSet rsDetails12=strno.executeQuery(sqlDeatils1);


%>
<option value="<%=UserTypecode %>" selected><%=Usertype %></option>

<%while(rsDetails12.next()){ %>

<option value="<%=rsDetails12.getInt("UserTypeCode") %>" <% if(UTC.equalsIgnoreCase(rsDetails12.getString("UserTypeCode"))){ %> <%}%>><%=rsDetails12.getString("UserType") %></option>
<%} %>
</select>

</div>
</div>

</div>
</div>

<div class="row col-12"> 
<div class="col-5 mt-4">
  <div class="input-container">
    <input class="form-control floating-input" type="file" id="sign" name="sign" accept="image/*">
    <label for="sign" class="floating-label">Sign</label>
  </div>
</div>

<div class="col-5 mt-4">
  <div class="input-container">
    <a style="text-decoration: none;" href="#" onclick="viewSign('viewImage.jsp')">View Previous Signature </a> 
    <label for="sign" class="floating-label"></label>
  </div>
</div>

<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="edit" name="Submit" type="submit">Submit</button>
    </div>
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
	<%} %>

<script type="text/javascript">
function viewSign(webadd){
	var user=document.getElementById("UserName").value;
	window.open(webadd+'?UserName='+user,'View Signature','left=200,top=200,width=500,height=300,toolbar=0,resizable=0'); return false;
}

function getUserHod()
{
	 //alert(" in fun");
	 
	 //alert("1");
	 var username=document.getElementById("hod").value.trim();

	
		 if(username.length=="")
			{
		        document.getElementById("userlist").style.display = "none";
		        document.getElementById("userlist").innerHTML = "";
			}

	 		//alert(username);
	 		var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
	    }  
		catch (e)
		{
			// Internet Explorer Browsers
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
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if (ajaxRequest.readyState === 4 && ajaxRequest.status === 200) {
	            var reslt = ajaxRequest.responseText.trim();
	            //alert(reslt);
	            if (reslt !== "") {
	                document.getElementById("userlist").style.display = "block";
	                document.getElementById("userlist").innerHTML = reslt;
	            } else {
	                document.getElementById("userlist").style.display = "none";
	                document.getElementById("userlist").innerHTML = "";
	            }
	        }
		}
		
		var queryString = "?action=hod&name="+username;
		//alert(queryString);
		
		ajaxRequest.open("GET", "AjaxEditUser.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 
}
function showVisitingCardDetailsHod(username)
{
	 //alert("in fun");
	 document.getElementById("hod").value=username;
	 //Changing(username);
	 document.getElementById("userlist").style.display="none";
	 
}

 function validate()
 {
 	var username=document.editNewUser.UserName.value;
 	if(username=="")
 	{
 	alert("Please Enter the User Name");
      return false;
 	}

 	var ulaccess=document.editNewUser.UserLevelAccess.value;
 	if(ulaccess=="")
 	{
        alert("Please Enter the Company User Level Access");
        return false;
 	}

 	if(document.editNewUser.rolenew.value=="")
 		{
 		alert("Please Enter Role");
 		return false;
 		}

 	 if(document.editNewUser.Department.value=="Select")
     {
     	alert("Please Select Department");
     	return false;
     }
     
 	var empcode=document.editNewUser.EmpCode.value;
      if(empcode=="")
      {
        alert("Please Enter Employee Code");
        return false;
      }
 	
 	var mob=document.editNewUser.mobileno.value;
 	if(mob=="")
 	{
 	alert("Please Enter the Mobile Number");
 	return false;
 	}
 	if(isNaN(mob))
 	{
 	alert("Enter the Valid Mobile Number(10 Digit Number)");
 	return false;
 	}
 	if((mob.length<10)||(mob.length>10))
 	{
 	alert("Your Mobile Number Should be Valid 10 Digit Number");
 	document.editNewUser.mobileno.select();
 	return false;
 	}

 	var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
 	var email=emailfilter.test(document.editNewUser.email.value);
 	if(email==false)
 	{
 	alert("Please Enter valid E-Mail ID");
 	return false;
 	}


 	var status = /^[YesNoyesno]+$/;  
	var status=status.test(document.editNewUser.ActiveStatus.value);
    if(status==false)
     {     
         alert('Status must be(Yes/No)');  
          return false;  
      }  

    if(document.editNewUser.hod.value=="")
    {
    	alert("Please Enter Hod Name");
    	return false;
    }
 	
 }

</script>
<%@ include file="footer.jsp" %>
</body>
</html>