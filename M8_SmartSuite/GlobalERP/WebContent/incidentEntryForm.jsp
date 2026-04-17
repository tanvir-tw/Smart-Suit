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
</head>
 <body style="background-color:azure;">
<%
Date d = new Date();

Format df1 = new SimpleDateFormat("yyyy-MM-dd");
String dtoday = df1.format(d);

Format d2 = new SimpleDateFormat("HH:mm:ss");
String incdReg = d2.format(d);

String hrTime = incdReg.substring(0,2);
String minTime = incdReg.substring(3,5);

String date = new SimpleDateFormat("dd-MMM-yyyy").format(d);
%>
<%
String sql="";
Connection con = null;
Statement stmt1=null, stmt2=null;
try {
	con = connection.getConnect("db_leaveapplication");        
     stmt1 = con.createStatement();
     stmt2 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New User</h5>
		    		</div>
		             <br>

<form name="incident" method="post" action="generateIncident.jsp" onSubmit="return validate();">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4">
        <div class="input-container">
            <textarea class="form-control floating-input" name="desc" id="desc" rows="1" placeholder=""></textarea>
            <label for="desc"  class="floating-label">Description</label>
        </div>
    </div>
    
    <div class="col-4">
    <div class="input-container">
        <input type="text"
               id="incidentDate"
               name="incidentDate"
               class="form-control floating-input"
               value="<%=date%>"
               onchange="dateValidate(this.value,'<%=dtoday%>');"
               readonly>
        <label for="incidentDate" class="floating-label">Incident Date</label>
    </div>
</div>

<script type="text/javascript">
Calendar.setup({
    inputField : "incidentDate",
    ifFormat   : "%d-%b-%Y",
    showsTime  : false
});
</script>
 
 <div class="col-2">
    <div class="input-container">
        <select name="hrs" id="hrs" class="form-control floating-input">
            <option value="<%=hrTime%>"><%=hrTime%></option>

            <% for(int i = 0; i < 24; i++) { %>
                <option value="<%=i%>"><%=i%></option>
            <% } %>
        </select>
        <label for="hrs" class="floating-label">Hour</label>
    </div>
</div> 
<div class="col-2">
    <div class="input-container">
        <select name="mins" id="mins" class="form-control floating-input">
            <option value="<%=minTime%>"><%=minTime%></option>

            <% for(int i = 0; i < 60; i++) { %>
                <option value="<%=i%>"><%=i%></option>
            <% } %>
        </select>
        <label for="mins" class="floating-label">Minute</label>
    </div>
</div>  
      </div>
      <div class="row col-12 mt-3">

    <div class="col-4 mt-3">
        <div class="input-container">
            <label for="type" class="tcolor">Type</label>
            <select name="type" id="type" class="form-select">
                <option value="Select">Select</option>
                <option value="IT">IT</option>
                <option value="Non IT">Non IT</option>
            </select>
        </div>
    </div>

    <!-- Location -->
    <div class="col-4 mt-3">
        <div class="input-container">
            <label for="location" class="tcolor">Location</label>
            <select name="location" id="location" class="form-select">
                <option value="PG2 Service and Accounts">PG2 Service and Accounts</option>
                <option value="KP Marketing">KP Marketing</option>
                <option value="PG1 R and D">PG1 R and D</option>
            </select>
        </div>
    </div>

    <!-- Category -->
    <div class="col-4 mt-3">
        <div class="input-container">
         <label for="cat" class="tcolor">Category</label>
            <select name="cat" id="cat"  class="form-select" onchange="getAjxToolTip();">
                <option value="Select">Select</option>
                <option value="C1">C1</option>
                <option value="C2">C2</option>
                <option value="C3">C3</option>
            </select>
           
        </div>
    </div>

</div>
<div class="row col-12 mt-3">
    <!-- 1st Column: Related To -->
     <div class="col-4 mt-2">
        <div class="input-container">
            <label for="relTo" class="tcolor">Related To</label>
            <select name="relTo" id="relTo" class="form-select" onchange="updateRelatedTo(this.value)">
                <option value="Location">Location</option>
                <option value="Server">Server</option>
                <option value="Client">Client</option>
                <option value="Email">Email</option>
                <option value="Internet">Internet</option>
                <option value="Equipment">Equipment</option>
            </select>
        </div>
    </div>


    <!-- 2nd Column: Asset ID OR Special Escalation (depending on Related To) -->
    <div class="col-4 mt-4" id="secondCol">
        <!-- Asset ID (shown if Equipment) -->
        <div id="assetIdDiv" style="display:none;">
            <div class="input-container">
                <input type="text" name="assetId" id="assetId" class="form-control floating-input" placeholder="">
                <label for="assetId" class="floating-label">Asset ID</label>
            </div>
        </div>

        <!-- Special Escalation (shown if NOT Equipment) -->
        <div id="specialEsc2ndCol">
            <div class="input-container">
                <input type="text" 
                       name="EmpNames" 
                       id="EmpNames" 
                       class="form-control floating-input"
                       placeholder=""
                       autocomplete="off"
                       value=""
                       onkeyup="if(event.keyCode==27){document.getElementById('EmpList').style.display='none';} else { getEmp(); }" />
                <label for="EmpNames" class="floating-label">Special Escalation</label>
                <input type="hidden" name="SelectedEmpMail" id="SelectedEmpMail" value="" />
            </div>
            <div id='EmpList'></div>
        </div>
    </div>

    <!-- 3rd Column: Special Escalation ONLY for Equipment -->
    <div class="col-4 mt-4" id="thirdCol" style="display:none;">
        <div class="input-container">
            <input type="text" 
                   name="EmpNames3" 
                   id="EmpNames3" 
                   class="form-control floating-input"
                   placeholder=""
                   autocomplete="off"
                   value=""
                   onkeyup="if(event.keyCode==27){document.getElementById('EmpList').style.display='none';} else { getEmp(); }" />
            <label for="EmpNames3" class="floating-label">Special Escalation</label>
            <input type="hidden" name="SelectedEmpMail3" id="SelectedEmpMail3" value="" />
        </div>
        <div style="position: absolute;">
            <div id="EmpList"></div>
        </div>
    </div>
</div>


<script>
function updateRelatedTo(val) {
    if(val === "Equipment") {
        // Show Asset ID in 2nd column, hide regular Special Escalation
        document.getElementById("assetIdDiv").style.display = "block";
        document.getElementById("specialEsc2ndCol").style.display = "none";

        // Show Special Escalation in 3rd column
        document.getElementById("thirdCol").style.display = "block";
    } else {
        // Hide Asset ID, show normal Special Escalation in 2nd column
        document.getElementById("assetIdDiv").style.display = "none";
        document.getElementById("specialEsc2ndCol").style.display = "block";
        // Hide 3rd column
        document.getElementById("thirdCol").style.display = "none";
    }
}
</script>


    <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn " 
                id="search-submit" 
                name="submitFollowUp" 
                type="submit"
                onclick="return validate();">
            Submit
        </button>
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

<script type="text/javascript">
	function dateValidate(dt,today)
	{
		var d=new Date().getMonth();
		
		dy1=dt.substring(7,11);
		dy2=today.substring(0,4);
		
		dm1=d+1;
		dm2=today.substring(5,7);
		
		dd1=dt.substring(0,2);
		dd2=today.substring(8,10);

		//alert(dy1+"=="+dy2+"=="+dm1+"=="+dm2+"=="+dd1+"=="+dd2);

		if( (dd1>dd2 && dm1>=dm2) || (dm1>dm2 && dy1>=dy2) || (dy1>dy2) )
		{
			alert("Please Select Valid Date");
			return false;
		}
		
		return true;
	}
	function getAjxToolTip()
	{
		var v=document.getElementById("cat").value;
		if(v=="C1")
		{
			alert("\tServer Down, Access restricted,potential loss of data (Anything which is critical to business) \n\n"+
					"Immediate: CISO, Sys Admin, If not solved withing in turn around time, then report to CEO \n\n"+ 
					"Production server: 1Hr ERP:4 Hrs, Tally: 12 Any other C1 type incident: 4 Hrs");
		}
		else if(v=="C2")
		{
			alert("\tInternet down, infrastructure down etc (Anything which is causing delay in executing day to day tasks) \n\n"+
					"Immediate: System Admin If not solved within turn aroud time, then report to CEO \n\n"+
					"Internet access for any office: 4 hrs Infrastructure failure(Scanner/printer): 4 hrs");
		}
		else
		{
			alert("\tPC not functional, can not access internet, mail client not working,serial port not working etc(Anything which does not have major impact but needs to be resolved ) \n\n"+
					"Immediate: System Admin. If not solved withing turn aroud time, then report to CEO \n\n"+
					"2 days");
		}
	}
	function validate()
	{
		  var intFlag = 0;
		  var strErrMsg = "You have entered future date. Please enter valid date and try again !!!";

		 // var dtDate= document.incident.incidentDate.value;  Tue Oct 11 2011 13:51:3
		
		var description=document.incident.desc.value;
		var type=document.incident.type.value;
		var cat=document.incident.cat.value;
		if(description=="")
		{
			alert("Please describe the Incident");
			return false;
		}
		if(type=="Select")
		{
			alert("Please enter type of the incident");
			return false;
		}
		if(cat=="Select")
		{
			alert("Please enter Category");
			return false;
		}

	    return true ;
	}
	function showVisitingCardDetails(eName,empMail)
	{
		document.getElementById("EmpNames").value=eName;
		document.getElementById("SelectedEmpMail").value=empMail;
		document.getElementById("EmpList").style.display='none';
	}
	function getEmp()
	{
		document.getElementById("EmpList").style.display='block';
		var emp=document.getElementById("EmpNames").value;
		var ajaxRequest;  // The variable that makes Ajax possible!

		try{
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

		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				document.getElementById("EmpList").innerHTML=reslt;
			} 
		}
		var queryString = "?emp=" +emp;
		ajaxRequest.open("GET", "GenericAjaxSearch.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
	}

</script>
<%@ include file="footer.jsp" %>
</body>
</html>