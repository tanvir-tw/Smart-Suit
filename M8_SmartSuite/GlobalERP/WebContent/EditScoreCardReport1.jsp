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
Connection con1 = null;

int k=2000;
String usr="";

try {
	con1 = connection.getConnect("db_GlobalERP");       
} catch (Exception e) {
   e.printStackTrace();
} 
		
%>

<% 
String Sesrole1=session.getAttribute("role").toString();
if(Sesrole1.equals("-"))
{
	%>
	<h2>You dont have access to Edit the Records</h2>
	<%
}
else
{
%>
 <div class="container-fluid" id="main">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Score Card Report</h5>
		    		</div>
		             <br>
		             
<form name="addCustomer" action="AddScores.jsp" method="post" onsubmit="return formValidation();">
<div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">
     <div class="row col-md-12 ms-1 mt-3">
 <%
	
 String user=session.getAttribute("EmpName").toString();

 String empId=request.getParameter("SrNo1");
 System.out.println("Emp SrNo : "+empId);
 
 String selectQry="select * from test.EmpPersonalscore where SrNo="+empId;
 PreparedStatement ps = con1.prepareStatement(selectQry);
 ResultSet rs = ps.executeQuery();
 while(rs.next())
 {
 %> 
<div class="col-md-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmpName" name="EmpName" value="<%=rs.getString("EmpName")%>" placeholder="" required>
          <label for="personal_email" class="floating-label">Employee Name</label>
        </div>
      </div>
 
 		<div class="col-md-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="month" name="month" value="<%=rs.getString("month")%>" placeholder="" required>
          <label for="personal_email" class="floating-label">Month</label>
        </div>
      </div>
      
      <div class="col-md-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="year" name="year" value="<%=rs.getString("year")%>" placeholder="" required>
          <label for="personal_email" class="floating-label">Year</label>
        </div>
      </div>
		<input type="hidden" id="flag" name="flag" value="Edit">
        <input type="hidden" id="empId" name="empId" value="<%=empId %>">
        <input type="hidden" id="month" name="month" value="<%=rs.getString("month") %>">
        <input type="hidden" id="year" name="year" value="<%=rs.getString("year") %>">

</div>

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
               title="Level of expertise in respective functional area." value="<%=rs.getString("ProficiencyScore") %>"   onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="ProficiencyCmt" name="ProficiencyCmt"
             value="<%=rs.getString("ProficiencyCmt") %>" class="form-control floating-input">
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
               title="Clarity of thinking, interpretation, and communication." value="<%=rs.getString("CommunicationScore") %>"
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="CommunicationCmt" name="CommunicationCmt"
           value="<%=rs.getString("CommunicationCmt") %>" class="form-control floating-input">
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
               value="<%=rs.getString("CommitmentScore") %>" title ="Willing to take ownership of his/her own and team goals and commit to them." 
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="CommitmentCmt" name="CommitmentCmt"
           value="<%=rs.getString("CommitmentCmt") %>"  class="form-control floating-input">
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
                value="<%=rs.getString("DependabilityScore") %>" title ="A person who can be depended upon to deliver his commitments without being asked, followed up or tracked. Someone who volunteers to help when his team needs it and does not wait to be asked." onblur="return score(this.value);" required
               onblur="return score(this.value);">
        <span class="input-group-text bg-transparent border-0">/10</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="DependabilityCmt" name="DependabilityCmt"
             value="<%=rs.getString("DependabilityCmt") %>" class="form-control floating-input">
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
               value="<%=rs.getString("TurnOutScore") %>" title="Appearance, dress appropriate to his/her job, profile and the occasion. Personal heigene, grooming and presentation of his/her self i.e. how he/she walk, talk and interact." onblur="return score5(this.value);" required>
        <span class="input-group-text bg-transparent border-0">/5</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="TurnOutCmt" name="TurnOutCmt"
           value="<%=rs.getString("TurnOutCmt") %>"  class="form-control floating-input">
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
               value="<%=rs.getString("PunctualityScore") %>" title="On time every day and leaves permitted."  onblur="return score5(this.value);" required>
        <span class="input-group-text bg-transparent border-0">/5</span>
      </div>
    </div>
    <div class="col-sm-5">
      <input type="text" id="PunctualityCmt" name="PunctualityCmt"
             value="<%=rs.getString("PunctualityCmt") %>" class="form-control floating-input">
    </div>
  </div>

  <!-- Submit Button -->
  
  <div class="row mt-4">
    <div class="col text-center">
      <button type="submit" class="btn btn-primary px-4" onclick="return sub()">Submit</button>
    </div>
  </div>
</div>



       <%} }%>
       
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

function score5(sid)
{
	var invalid=/^[0-9]+$/; 
	if(!invalid.test(sid))
	{
	alert("Value should be digits");
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
 function score(sid)
	{
		var invalid=/^[0-9]+$/; 
		if(!invalid.test(sid))
		{
		alert("Value should be digits");
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

function sub()
{
			 var ProficiencyScore=document.getElementById("ProficiencyScore").value;
			 if(ProficiencyScore.length<1)
				 {
				 alert("Score shold not be Emptry");
				 document.getElementById("ProficiencyScore").focus();
				 return false;
				 }
			 var invalid=/^[0-9]+$/; 
			 if(!invalid.test(ProficiencyScore))
				{
				alert("Value should be digits");
				document.getElementById("ProficiencyScore").focus();
				return false;
				}
			 if((ProficiencyScore>10)||(ProficiencyScore<=0))
				{
				alert("Please enter values from 1 to 10 for ProficiencyScore");
				document.getElementById("ProficiencyScore").focus();
				return false;
				}
			 var ProficiencyCmt=document.getElementById("ProficiencyCmt").value;
			 var CommunicationScore=document.getElementById("CommunicationScore").value;
			 if(CommunicationScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("CommunicationScore").focus();
			 	return false;
			 }
			 if(!invalid.test(CommunicationScore))
				{
				alert("Value should be digits");
				document.getElementById("CommunicationScore").focus();
				return false;
				}
			 if((CommunicationScore>10)||(CommunicationScore<=0))
				{
				alert("Please enter values from 1 to 10 for CommunicationScore");
				document.getElementById("CommunicationScore").focus();
				return false;
				}
			 var CommunicationCmt=document.getElementById("CommunicationCmt").value;
			 var CommitmentScore=document.getElementById("CommitmentScore").value;
			 if(CommitmentScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("CommitmentScore").focus();
			 	return false;
			 }
			 if(!invalid.test(CommitmentScore))
				{
				alert("Value should be digits");
				document.getElementById("CommitmentScore").focus();
				return false;
				}
			 if((CommitmentScore>10)||(CommitmentScore<=0))
				{
				alert("Please enter values from 1 to 10 for CommitmentScore");
				document.getElementById("CommitmentScore").focus();
				return false;
				}
			 var CommitmentCmt=document.getElementById("CommitmentCmt").value;
			
			 var DependabilityScore=document.getElementById("DependabilityScore").value;
			 if(DependabilityScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("DependabilityScore").focus();
			 	return false;
			 }
			 if(!invalid.test(DependabilityScore))
				{
				alert("Value should be digits");
				document.getElementById("DependabilityScore").focus();
				return false;
				}
			 if((DependabilityScore>10)||(DependabilityScore<=0))
				{
				alert("Please enter values from 1 to 10 for DependabilityScore");
				document.getElementById("DependabilityScore").focus();
				return false;
				}
			 var DependabilityCmt=document.getElementById("DependabilityCmt").value;
			 var TurnOutScore=document.getElementById("TurnOutScore").value;
			 if(TurnOutScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("TurnOutScore").focus();
			 	return false;
			 }
			 if(TurnOutScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("TurnOutScore").focus();
			 	return false;
			 }
			 if(!invalid.test(TurnOutScore))
				{
				alert("Value should be digits");
				document.getElementById("TurnOutScore").focus();
				return false;
				}
			 if((TurnOutScore>5)||(TurnOutScore<=0))
				{
				alert("Please enter values from 1 to 5 for TurnOut Score");
				document.getElementById("TurnOutScore"	).value=null;
				document.getElementById("TurnOutScore").focus();
				return false;
				}
			 var TurnOutCmt=document.getElementById("TurnOutCmt").value;
			 var PunctualityScore=document.getElementById("PunctualityScore").value;
			 if(PunctualityScore.length<1)
			 {
				 alert("Score shold not be Emptry");
			 	document.getElementById("PunctualityScore").focus();
			 	return false;
			 }
			 if(!invalid.test(PunctualityScore))
				{
				alert("Value should be digits");
				document.getElementById("PunctualityScore").focus();
				return false;
				}
			 if((PunctualityScore>5)||(PunctualityScore<=0))
				{
				alert("Please enter values from 1 to 5 for Punctuality Score");
				document.getElementById("PunctualityScore").focus();
				document.getElementById("PunctualityScore"	).value=null;
				return false;
				}
			 var PunctualityCmt=document.getElementById("PunctualityCmt").value;
		return true;
	}	
</script>