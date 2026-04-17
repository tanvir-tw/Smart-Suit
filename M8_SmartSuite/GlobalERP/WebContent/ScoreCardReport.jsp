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
 <style type="text/css">
 .input-group-text {
    background: transparent;
    border: 0;
    font-size: 11px;
    margin-bottom: 7px;
}
 </style>
</head>
 <body style="background-color:azure;">
 <%
// Connection Initialization
Connection con = null;

int k=2000;
String usr="";

try {
	con = connection.getConnect("db_GlobalERP");       
} catch (Exception e) {
   e.printStackTrace();
} 
		
%>

<div class="container-fluid" id="main">
<section class="container" style="max-width: 800px;" id="basic--layouts" >
    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Score Card Report</h5>
		    		</div>
		             <br>
		             
<form name="addCustomer" action="AddScores.jsp" method="post">
  <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">
      
      <!-- Contractor ID & Department -->
      <div class="row col-md-12 ms-1">
	 <div class="col-md-4">
	 <%String user=session.getAttribute("EmpName").toString();
 			 %> 
 			 <input type="hidden" id="flag" name="flag" value="Save">
            <div class="input-container">
                	<label class="tcolor">Employee Name</label>
                 	<select class="form-select" id="empName" name="empName" required>
                 	<option value="Select" selected>Select</option>
                 	<% 
				  String qryEmp="";
				  if(session.getAttribute("EmpName").equals("Vikram Puri"))
				  {
					  qryEmp="select EmpName,EmpCode from db_GlobalERP.UserMaster where HODReport like '%%' and ActiveStatus='Yes'";
				  }
				  else
				  {
				  		qryEmp="select EmpName,EmpCode  from db_GlobalERP.UserMaster where HODReport like '"+session.getAttribute("EmpName").toString()+"' and EmpName!='"+session.getAttribute("EmpName")+"' and ActiveStatus='Yes'"; 
				  }
				  PreparedStatement ps = con.prepareStatement(qryEmp);
				  ResultSet rs=ps.executeQuery();
				 int i=0;
				  while(rs.next())
				  {i++;
					  usr=rs.getString(1);
					  System.out.println(usr);
				  %>
				  <option value="<%=rs.getString("EmpCode")%>" ><%=rs.getString("EmpName")%></option>
				 			
						<% System.out.println("Count : "+i);	}%> 
                 </select>
            </div>
            </div>
             <div class="col-md-4">
            <div class="input-container">
                	<label class="tcolor">Month</label>
                 	<select class="form-select" id="month" name="month" required>
		              <option value="Select" selected>Select</option>
							<option value="JAN">JAN</option>
							<option value="FEB">FEB</option>
							<option value="MAR">MAR</option>
							<option value="APR">APR</option>
							<option value="MAY">MAY</option>
							<option value="JUN">JUN</option>
							<option value="JLY">JLY</option>
							<option value="AUG">AUG</option>
							<option value="SEPT">SEPT</option>
							<option value="OCT">OCT</option>
							<option value="NOV">NOV</option>
							<option value="DEC">DEC</option>
				<%
				if(request.getParameter("month") != null){
					String mon=request.getParameter("month");
					System.out.println("Month :-"+mon);
				}
				%>
                 </select>
            </div>
            </div>
             <div class="col-md-4">
            <div class="input-container">
                	<label class="tcolor">Year</label>
                 	<select class="form-select" id="year" name="year" required>
		              <option value="Select" selected>Select</option>
		            <%for(k=2017;k<=2050;k++)
					{
					%>
					<option value="<%=k %>"><%=k %></option>
					<%} %>
					<%
					if(request.getParameter("year") != null){
							
							 %><option value=<%=request.getParameter("year")%> selected><%=request.getParameter("year") %></option><%
					}
					%>
                  
                 </select>
            </div>
        </div>
      </div>
<!-- <hr> -->
<div class="container mt-3">
  <!-- Header Row -->
  <div class="row mb-2 fw-bold text-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2">Particulars</div>
    <div class="col-sm-3">Scores</div>
    <div class="col-sm-5">Comments</div>
  </div>

  <!-- Proficiency -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Proficiency</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input class="form-control floating-input" type="text" id="ProficiencyScore" name="ProficiencyScore" maxlength="2"
               title="Level of expertise in respective functional area."
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="ProficiencyCmt" name="ProficiencyCmt"
             class="form-control floating-input">
    </div>
  </div>

  <!-- Communication -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Communication</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input type="text" id="CommunicationScore" name="CommunicationScore"
               maxlength="2" class="form-control floating-input"
               title="Clarity of thinking, interpretation, and communication."
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="CommunicationCmt" name="CommunicationCmt"
            class="form-control floating-input">
    </div>
  </div>

  <!-- Commitment -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Commitment</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input type="text" id="CommitmentScore" name="CommitmentScore"
               maxlength="2" class="form-control floating-input"
               title="Ownership of goals and commitment."
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="CommitmentCmt" name="CommitmentCmt"
             class="form-control floating-input">
    </div>
  </div>

  <!-- Dependability -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Dependability</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input type="text" id="DependabilityScore" name="DependabilityScore"
               maxlength="2" class="form-control floating-input"
               title="Reliable and proactive in commitments."
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="DependabilityCmt" name="DependabilityCmt"
             class="form-control floating-input">
    </div>
  </div>

  <!-- Turn Out -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Turn Out</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input type="text" id="TurnOutScore" name="TurnOutScore"
               maxlength="2" class="form-control floating-input"
               title="Appearance, grooming, and presentation."
               onblur="return score5(this.value);">
        <span class="input-group-text bg-transparent border-0">/5</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="TurnOutCmt" name="TurnOutCmt"
             class="form-control floating-input">
    </div>
  </div>

  <!-- Punctuality -->
  <div class="row mb-2 align-items-center">
  <div class="col-sm-1"></div>
    <div class="col-sm-2"><label><b>Punctuality</b></label></div>
    <div class="col-sm-3">
      <div class="input-group">
        <input type="text" id="PunctualityScore" name="PunctualityScore"
               maxlength="2" class="form-control floating-input"
               title="On time and with permitted leaves."
               onblur="return score5(this.value);">
        <span class="input-group-text bg-transparent border-0">/5</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="PunctualityCmt" name="PunctualityCmt"
             class="form-control floating-input">
    </div>
  </div>

  <!-- Submit Button -->
  
  <div class="row mt-4">
    <div class="col text-center">
      <button type="submit" class="btn btn-primary px-4" onclick="return sub()">Submit</button>
    </div>
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

<script>
 function score(sid)
	{
		var invalid=/^[0-9]+$/; 
		if(!invalid.test(sid))
		{
	//	alert("Value should be digits");
		sid.focus();
		return false;
		}
		if((sid>10)||(sid<=0))
			{
			alert("Please enter values from 1 to 10");
			sid.focus();
			return false;
			}
		return true;
	 }
 
 function score5(sid)
	{
		
		var invalid=/^[0-9]+$/; 
		if(!invalid.test(sid))
		{
		// alert("Value should be digits");
		sid.focus();
		return false;
		}
		if((sid>5)||(sid<=0))
			{
			alert("Please enter values from 1 to 5");
			sid.focus();
			return false;
			}
		return true;
	 }

var flag=true;
function sub() {

    function validateScore(id, min, max, label) {
        var value = document.getElementById(id).value.trim();
        var num = Number(value);

        if (value === "") {
            alert(label + " should not be empty");
            document.getElementById(id).focus();
            return false;
        }

        if (isNaN(num)) {
            alert(label + " should contain digits only");
            document.getElementById(id).value = "";
            document.getElementById(id).focus();
            return false;
        }

        if (num < min || num > max) {
            alert("Please enter values from " + min + " to " + max + " for " + label);
            document.getElementById(id).value = "";
            document.getElementById(id).focus();
            return false;
        }
        return true;
    }

    // Employee
    var emp = document.getElementById("empName").value;
    if (emp === "Select") {
        alert("Please Select Employee");
        document.getElementById("empName").focus();
        return false;
    }

    // Month
    var month = document.getElementById("month").value;
    if (month === "Select") {
        alert("Please select the month");
        document.getElementById("month").focus();
        return false;
    }

    // Year
    var year = document.getElementById("year").value;
    if (year === "Select") {
        alert("Please select the year");
        document.getElementById("year").focus();
        return false;
    }

    // Scores validation
    if (!validateScore("ProficiencyScore", 1, 10, "Proficiency Score")) return false;
    if (!validateScore("CommunicationScore", 1, 10, "Communication Score")) return false;
    if (!validateScore("CommitmentScore", 1, 10, "Commitment Score")) return false;
    if (!validateScore("DependabilityScore", 1, 10, "Dependability Score")) return false;
    if (!validateScore("TurnOutScore", 1, 5, "TurnOut Score")) return false;
    if (!validateScore("PunctualityScore", 1, 5, "Punctuality Score")) return false;

    return true;
}
</script>


<%@ include file="footer.jsp" %>
</body>
</html>