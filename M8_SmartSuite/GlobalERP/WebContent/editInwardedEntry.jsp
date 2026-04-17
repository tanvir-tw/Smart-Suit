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
String sql="";
Connection con = null;
Statement st1=null, st2=null,st3=null;
try {
	
	
	/* System.out.println("twEmp:::::::::::::::::: "+twEmp); */
	con = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 
String refno=request.getParameter("refno");
%>
	<%
 	String twEmp = session.getAttribute("leaveempID").toString();
String datenew1="";
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString(); 
datenew1 = monthFirstDate;
%>
		<%

String manref="", iwno="", addr="", to="" ,category="", frm="", partyRef="",frmid="" ,subject="", actionDate="", priority="", remarks="", FileName="", BillNo="", BillAmt="", BillDate="", BillDueDate="";
String sqlEdit="select * from db_leaveapplication.t_inwarddetails where InwardRefNo='"+refno+"'";
System.out.println(sqlEdit);
System.out.println("\n\n after.......");
try
{
	ResultSet rsEdit=st.executeQuery(sqlEdit);
	if(rsEdit.next())
	{
		System.out.println("\n\n in try if.........");
		manref=rsEdit.getString("ManualRef");
		addr=rsEdit.getString("Address");
		category=rsEdit.getString("Category");
		frm=rsEdit.getString("FromParty");
		partyRef=rsEdit.getString("PartyRefNo");
		subject=rsEdit.getString("Subject");
		actionDate=rsEdit.getString("ActionDate");
		priority=rsEdit.getString("InwrdPriority");
		remarks=rsEdit.getString("senderRemark");
		FileName=rsEdit.getString("FileName");
		BillNo=rsEdit.getString("BillNo");
		BillAmt=rsEdit.getString("BillAmt");
		try
		{
			BillDate=rsEdit.getString("BillDate");
			BillDueDate=rsEdit.getString("BillDueDate");	
		}
		catch(Exception e)
		{
			System.out.println(e);
			e.printStackTrace();
		}
		
		iwno=rsEdit.getString("InwardNo");
		to=rsEdit.getString("ToEmailID");
		frmid=rsEdit.getString("EnteredById");
	}
}
catch(Exception e)
{
	System.out.println(e);
	e.printStackTrace();
}
System.out.println(to+"******"+frmid);
System.out.println(manref+"==="+iwno+"==="+addr+"==="+category+"==="+frm+"==="+partyRef+"==="+subject+"==="+actionDate+"==="+priority+"==="+remarks+"==="+FileName+"==="+BillNo+"==="+BillAmt+"==="+BillDate+"==="+BillDueDate);
String ss="display:none";
%>

<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Documents</h5>
		    		</div>
		             <br>
	<form action="EditInwardEmail.jsp" name="editform" method="get">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
  
  

    <div class="row">
      <div class="row col-12 mt-3"> 
       
      
           <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="inwardno" id="inwardno" value="<%=refno%>" placeholder="" >
          <label for="inwardno" class="floating-label">Inward Ref. No</label>
          <input type="hidden" name="inrefno" id="inrefno" value="<%=refno%>"	readonly />
        </div>
      </div>
     <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="manualref" id="manualref" value="<%=manref%>"  placeholder="" >
          <label for="amount" class="floating-label">Ref. No</label>
        </div>
      </div>
          <div class="col-3">
        <div class="input-container">    
        <label class="tcolor">Category</label>
            <select class="form-select"name="cat" id="cat" 
					onchange="getCategory(this.value);" required>            
           	<% 
				try{
/* 				String sqlCat="select distinct(InwrdCategory) from t_InwardCategory" ;
 */				
 String sqlCat="select distinct(InwrdCategory) from db_leaveapplication.t_InwardCategory" ;
 ResultSet rsCat=st.executeQuery(sqlCat);
				    while(rsCat.next())
				    { %>
						<option value="<%=rsCat.getString("InwrdCategory") %>">
							<%=rsCat.getString("InwrdCategory") %>
						</option>
						<%  } 
				}
				catch(Exception e){System.out.println("Exception======>>"+e);}%>
				</select>
        </div>
      </div>
       <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text"   name="from1" id="from1" autocomplete="off"
					value="<%= frm%>"
					onkeyup="if (event.keyCode == 27){document.getElementById('EmpList').style.display = 'none';} else { getEmp123(); }"  placeholder="" >
          <label for="from1" class="floating-label">From</label>
          	<input type="hidden"	name="SelectedEmpMail" id="SelectedEmpMail" value="" />
        </div>
        <div id='EmpList'></div>
      </div>
      
</div>
</div>
<div class="row">
      <div class="row col-12 mt-3"> 
       
      <%
		if(category.equals("Bills"))
		{
			ss="";
		}
		%>
      
           <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="blno" id="blno" value="<%=BillNo%>" placeholder="" >
          <label for="blno" class="floating-label">Bill No</label>
        </div>
      </div>
      <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="blamt" id="blamt" value="<%=BillAmt%>" placeholder="" >
          <label for="blamt" class="floating-label">Bill Amt</label>
        </div>
      </div>
       <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="bldate" name="bldate" value="<%=BillDate%>" readonly placeholder="" required>
                <label for="bldate" class="floating-label">Bill Date</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "bldate", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "bldate",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
       <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="blduedate" name="blduedate" value="<%=BillDueDate%>" readonly placeholder="" required>
                <label for="blduedate" class="floating-label">Bill Due Date</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "blduedate", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "blduedate",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
      </div>
      </div>
      <div class="row">
      <div class="row col-12 mt-3"> 
        <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="prno" id="prno" value="<%=partyRef%>" placeholder="" >
          <label for="prno" class="floating-label">Party Ref. No</label>
        </div>
      </div>
      <div class="col-3 mt-4">
        <div class="input-container">
          	 <textarea class="form-control floating-input"  name="address" id="address" rows="1" placeholder=""><%=addr%></textarea>
          	<label  for="address" class="floating-label">Address</label>         	
        </div>
    </div>
    <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="sub" id="sub" value="<%=subject%>" placeholder="" >
          <label for="sub" class="floating-label">Subject</label>
        </div>
      </div>
      <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="data" name="data" value="<%=actionDate%>" readonly placeholder="" required>
                <label for="data" class="floating-label">Action Date</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "data", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "data",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
     </div>
     </div>
    <div class="row">
      <div class="row col-12 mt-3"> 
        <div class="col-3">
        <div class="input-container">    
        <label class="tcolor">Priority</label>
            <select class="form-select" name="priority" id="priority" required>            
				<option value="Low">Low</option>
						<option value="Medium">Medium</option>
						<option value="High">High</option>
           
           </select>
        </div>
      </div>
         <div class="col-3 mt-4">
        <div class="input-container">
          	 <textarea class="form-control floating-input"  name="remark" id="remark" rows="1" placeholder=""><%=remarks%></textarea>
          	<label  for="remark" class="floating-label">Remarks</label>         	
        </div>
    </div>
      </div>
      </div>
       	<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn"id="search-submit" name="submitFollowUp" value="Submit" onclick="return validate();">Submit</button>
    </div>
       
     
</div>
</div>
<input type="hidden" name="to" id="to" value="<%= to %>">
<input type="hidden" name="frmMail" id="frmMail" value="<%= frmid %>">
<input type="hidden" name="AllFileNames" id="AllFileNames" value="<%= FileName %>">
<input type="hidden" name="rd" id="rd" value="<%= refno %>">
</form>
</div>
</div>
</div>
</div>
</section>
</div>
</div>

<script type="text/javascript">
var employeeList=null;
onunload=function()
{
	window.close();
}
/* 
function closeAllchildren()
{
	//window.opener=self;
	mywindow2.close(); 
} */
function otherCategory() 
{
	alert("@@@@@@@@@");	
} 
function validate()
{
	var v1=document.getElementById("to").value;
	var v2=document.getElementById("senderCmts").value;
	if(v1=="" || v1==null)
	{
		alert("Please Select Employee");
		return false;
	}
	return true;
}
function showVisitingCardDetails(eName,empMail)
{
	document.getElementById("from1").value=eName;
	document.getElementById("SelectedEmpMail").value=empMail;
	document.getElementById("EmpList").style.display='none';
}
function getEmp123()
{
	document.getElementById("EmpList").style.display='block';
	var emp=document.getElementById("from1").value;
	var ajaxRequest; 

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
			document.getElementById("EmpList").innerHTML=reslt;
		} 
	}
	var queryString = "?emp=" +emp+"&crg="+crg;
	ajaxRequest.open("GET", "SearchBoxForFromCategory.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function getCategory(catgry)
{
	var ct=catgry;
	crg=ct;

	if(crg=="Bills")
	{
		document.getElementById("frmParty1").style.display='none';
		document.getElementById("frmParty").style.display="";
		document.getElementById("billno").style.display="";
		document.getElementById("billamt").style.display="";
		document.getElementById("billdate").style.display="";
		document.getElementById("billduedate").style.display="";
	}
	else if(crg=="customer")
	{
		document.getElementById("frmParty1").style.display='none';
		document.getElementById("frmParty").style.display="";
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
	}
	else
	{
		document.getElementById("frmParty1").style.display="";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
	}
}

</script>
<%@ include file="footer.jsp" %>
</body>
</html>