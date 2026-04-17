<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
<style>
    /* This container ensures the list stays aligned with the input field */
    .hod-wrapper {
        position: relative;
    }

    /* This makes the list 'float' so it doesn't push the Submit button down */
#supplierList {
    position: relative; /* This causes it to push the button down */
    z-index: 1000;
    background: white;
    border: 1px solid #ccc;
    width: 100%; 
    max-height: 200px;
    overflow-y: auto;
    box-shadow: 0px 4px 8px rgba(0,0,0,0.1);
    display: none; /* Hidden by default */
    margin-top: 5px;
}
    
    .supplier-item {
        padding: 10px;
        cursor: pointer;
        border-bottom: 1px solid #f0f0f0;
    }
    .supplier-item:hover {
        background-color: #e9ecef;
    }
</style>
</head>
 <body style="background-color:azure;">
  	<%
String sql="";
Connection con = null;
Statement st1=null, st2=null,st3=null;
try {

	con = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 
%>
 <div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Create New Department</h5>
		    		</div>
		             <br>
	<form name="departmentCreation" action="deptData.jsp" method="post">

<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">

     <%String sendMsg=request.getParameter("sendMsg");
	if(!(sendMsg==null))
			{
	%> <b><font size="2" color="#151B54"><%= sendMsg%></font></b> <%} %>
<div class="row">
    <div class="col-1"></div>

    <div class="col-5">
        <div class="input-container">   
        <label class="tcolor">Company Name</label>
           <select class="form-select" name="cmpName" id="cmpName" onchange="getDeptData(this.value);">
<option value="Select">Select</option>

<%
String sqlCat="select CompanyCode,OurCompanyName from t_ourcompanydet";
ResultSet rsCat=st1.executeQuery(sqlCat);
while(rsCat.next())
{
%>
<option value="<%=rsCat.getString("CompanyCode")%>">
<%=rsCat.getString("OurCompanyName")%>
</option>
<%
}
%>
</select>
        </div>
      </div>

       <div class="col-5 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="deptName" id="deptName"	onblur="checkDuplicatedeptname(this.value);" placeholder="" required>
          <label for="deptName" class="floating-label">Department Name</label>
        </div>
      </div>
          <div class="col-1"></div>
      
  
  </div>    


<div class="row mt-3">
          <div class="col-1"></div>

    <div class="col-5">
      <div class="input-container"> 
        <label class="tcolor">Under Department</label>
          <select class="form-select" name="underDept" id="underDept">         
				<option value="">Select</option>
           
           </select>
            <input type="hidden" name="uD" id="uD"></input>
        </div>
      </div>

<div class="col-5 mt-4">
    <div class="input-container">
        <input class="form-control floating-input" type="text" name="hod" id="hod" onkeyup="getHodName(this.value);" autocomplete="off" placeholder="" required>
        <label for="hod" class="floating-label">HOD Name</label>
    </div>
    <div id='supplierList'></div>
</div>
 <div class="col-1"></div>

  </div>    

<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit" id="submit1"	value="Submit" onclick="return validate();">Submit</button>
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
  
 <script LANGUAGE="JavaScript" type="text/javascript">

function getsupplierDetails(i) {
    document.getElementById("hod").value = document.getElementById("hodname" + i).value;
    document.getElementById("supplierList").innerHTML = "";
      document.getElementById("supplierList").style.display = 'none'; 
}
function getDeptData(cmpCode)
{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
		  document.getElementById("underDept").innerHTML=xmlhttp.responseText;		  
		  }
		}
		xmlhttp.open("GET","AjxDeptData.jsp?cmpCode="+cmpCode,true);
		xmlhttp.send(null);
		
}
function getHodData(deptCode)
{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
		  document.getElementById("hod").innerHTML=xmlhttp.responseText;
		  }
		}
		xmlhttp.open("GET","AjxHodData.jsp?deptCode="+deptCode,true);
		xmlhttp.send(null);
		
}

function getHodName(hodname)
{
	document.getElementById("supplierList").style.display='block';
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else if (window.ActiveXObject)
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	else
	  {
	  alert("Your browser does not support XMLHTTP!");
	  }
	xmlhttp.onreadystatechange=function()
	{
	if(xmlhttp.readyState==4)
	  {
	  var reslt=xmlhttp.responseText;
	  document.getElementById("supplierList").innerHTML=reslt;
	  }
	}
	xmlhttp.open("GET","AjxHodNameData.jsp?hodname="+hodname,true);
	xmlhttp.send(null);
	
}


function checkDuplicatedeptname(deptName)
{
	var cmpName = document.getElementById("cmpName").value;
			 
		if( deptName !="")
		{ 
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
			reslt=reslt.replace(/^\s+|\s+$/g,"");
			if(reslt=="yes")
			{
				document.getElementById("deptName").value="";
				alert("Department already present!");
				document.getElementById("deptName").focus();
				
				return false;
				
			}else
			{
			}
		} 
	}
	
	 var queryString ="?deptName=" +deptName+"&cmpName="+cmpName;
	 ajaxRequest.open("GET", "ajaxDuplicatedeptname.jsp" + queryString, true);
	 ajaxRequest.send(null); 

		}//end of if
		else
		{
			alert("Department Name is Empty");
			return false;
		}
		
	}	
function validate()
{
	var val1 = document.getElementById("cmpName").value;
	var val2 = document.getElementById("deptName").value;
	var val3 = document.getElementById("underDept").value;
	var val4 = document.getElementById("hod").value;

	if(val1=="" || val1=="Select")
	{
		alert("Please select the Company Name ");
		return false;
	}
	if(val2=="" || val2=="Select")
	{
		alert("Please select the Department");
		return false;
	}
	if(val3=="" || val3=="Select")
	{
		alert("Please select the Under Department");
		return false;
	}
	if(val4=="" || val4=="Select")
	{
		alert("Please select the HOD for Department");
		return false;
	}
	return true;
}
</script>
 
 <%@ include file="footer.jsp" %>
</body>
</html>