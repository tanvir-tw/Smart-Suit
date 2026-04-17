<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);



</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  




<html>
<body onkeypress="hideList(event);" onclick="hideOnClick();">
<script>
function formValidation()
{

	var v=document.getElementById("amount").value;
	
	
	
	document.getElementById("companynaw1").style.display='none';
	
	var compnaw=document.getElementById("companyName").value;
	
	if(compnaw.trim()=="" || compnaw.trim()==null )
		{
		document.getElementById("companynaw1").style.display="";
		return false;
		}
	
	//Amount Validation
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var amount=document.getElementById("amount").value;
//	var invalid=/^[a-zA-Z  .]+$/;
var invalid=/^\d+(\.\d+)?$/;
//var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(amount==""){
	document.getElementById("contact1").style.display="";
	return false;
}

if(!invalid.test(amount)){
document.getElementById("contact2").style.display="";
     return false;
 }		
}





//Amount Validation
function contactpersonfun()
{
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var amount=document.getElementById("amount").value;

var invalid=/^\d+(\.\d+)?$/;

if(amount=="")
{
	document.getElementById("contact1").style.display="";
		return false;
}
else if((amount<=0)||(amount==0.0))
	
	{
	alert("Please Enter valid Amount");
	document.getElementById("contact1").style.display="";
	return false;
	}
	
if(!invalid.test(amount)){
 document.getElementById("contact2").style.display="";
	     return false;
	 }	
}





 


var globalcompany;var flag=true;
function hideList(e)
{
if(e.which == 0){
	document.getElementById("ProspectList").style.visibility='hidden';
}
}
function hideOnClick()
{
    //	document.getElementById("ProspectList").style.visibility='hidden';
}

 



//Purpose validation
function funpurpose()
{
	
	var purpose=document.getElementById("purpose").value;
	
	
	var invalid=/^[^-\s][a-zA-Z_0-9\s-]+$/;
	

	if(invallid.test(purpose))
		{
		alert("Space should not be first character");
		return false;
		}
	
	
}


function getCompanies()
{
	document.getElementById('companyList').style.visibility = 'visible';
		//var company=document.ledgerDetails.companyNames.value;
	var company=document.getElementById("companyName").value;
		if(company=="")
		{
			document.getElementById('companyList').style.visibility = 'hidden';
		}else
		{
			company=company.replace(".", "");
			company=company.replace(",", "");
			company=company.replace("$", "");
			company=company.replace("#", "");
			company=company.replace("?", "");
			company=company.replace("-", "");
			company=company.replace("_", "");
			company=company.replace(" ", "");
			company=company.replace("(", "");
			company=company.replace(")", "");
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
				document.getElementById("companyList").innerHTML=reslt;
			} 
		}
		//alert("com:"+company);
		var queryString = "?company=" +company;
		ajaxRequest.open("GET", "AjaxGetLedgerCompanies.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}//end of else
	
}


function showVisitingCardDetails(companyName)
{
	//document.getElementById('visitingCard').style.visibility='visible';
	document.getElementById("companyName").value='';
	//document.getElementById('companyList').style.height = '10px'; 
	document.getElementById('companyList').style.visibility = 'hidden';

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

			var data=reslt.split("#");
			//alert("data[6] "+data[6]);
			//alert("data[5] "+data[5]);
			//alert("data[7] "+data[7]);
			document.getElementById("companyName").value=data[1];
			
			document.getElementById("comp").value=data[1];				
		}
	}
	var queryString = "?companyName=" +companyName;
	ajaxRequest.open("GET", "AjaxShowVisitingCard.jsp" + queryString, true);
	ajaxRequest.send(null); 


}

</script>
<%@ include file="header.jsp"%>
<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		%>
		
		<%



Statement stdynamicdrop = null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
//centnon1.getConnection();
// con1=centconn.ReturnConnection();
//stdynamicdrop=con1.createStatement();
String Category=request.getParameter("Category");
System.out.println("-CAt===="+Category);
Statement st = null, st1 = null, st3 = null, st4 = null,st2 = null,st5=null;

String selectedName;
String FollowUpType = "";String company="";
st = con1.createStatement();
st1 = con1.createStatement();
st2 = con1.createStatement();
st3 = con1.createStatement();
st4 = con1.createStatement();
st4 = con1.createStatement();

st5=con1.createStatement();


%>


<script type="text/javascript">
function welcome()
{
	
	var v=document.getElementById("amount").value;
	var invalid=/^\d+(\.\d+)?$/;
	if(v=="0")
		{
		alert("Please Enter valid Amount");
		return false;
		}
	if(!invalid.test(v))
		{
		alert("Please enter valid amount");
		return false;
		}
	
	
	var purpose=document.getElementById("purpose").value;
	var invalid=/^[^-\s][a-zA-Z_0-9\s-]+$/;
	
	if(!invallid.test(purpose))
		{
		alert("Space not be first character");
		return false;
		}
	
	

	
	
	
	
}


</script>

<form name="addCustomer" action="AdvanceEntry.jsp" method="post" onsubmit=" return welcome();">



	<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3px" color="black"><b></b></font> </label></td></tr></tbody></table></div>

<br></br><br></br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3px" color="black"><b>AdvanceRequest</font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>

<tr>
 <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Category :&nbsp;&nbsp;&nbsp;<br></b> </label><select id="status" name="cat" style="width:150px; height: 30px;"  class="element select medium" required="required">
								
								<option id="status" selected="selected" value="">Select</option>
								
								
						<% 
						String query="select Category from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ClaimCategory ORDER BY Category ASC;";
						ResultSet rs1=st.executeQuery(query);
						while(rs1.next())
						{
							%>
							<option id="status" value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
							<% 
							
							
						}
						
						%>
						
					</select>
					<input type="hidden" name="assignedBy" value=""  />
			</td> 
			<br>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Amount :</b> </label><input id="amount" name="amount"  class="element text medium" type="text" required="required" value=""  onblur="return contactpersonfun(); "/></input>
<div><label id="contact1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Amount</font></label>  
 	<label id="contact2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Valid Amount</font></label> 
 </div>

</td>

</tr>

<tr>

<tr>

 <td><label id="element_1" name="element_1"  class="description" for="element_1"><br><b>On Behalf Of: :&nbsp;&nbsp;&nbsp;<br></b> </label><select id="status" name="bhalf" style="width:150px; height: 30px;"  class="element select medium">
								
								<option id="status" value="Select">Select</option>
								
								
						<%
	try{
	String sqlbhalf="select EmpName,Dept from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"security order by EmpName ASC";
	ResultSet rsbhalf=st5.executeQuery(sqlbhalf);
	
	System.out.println("%%%%%%%%%%%%%"+sqlbhalf);
	while(rsbhalf.next())
	{
	%>
	<option value='<%=rsbhalf.getString("EmpName")%>'><%=rsbhalf.getString("EmpName")%> </option>	
		
	<% } System.out.println();
	}catch(Exception e){e.printStackTrace();}
	%>
						
					</select>
					<input type="hidden" name="assignedBy" value=""  />
			</td> 






<tr>


<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Customer :<br></b> </label><input id="companyName" name="cust" maxlength="15" "element text medium" type="text" required="required" value=""  onkeyup="getCompanies()" /></textarea>
<input type="hidden" name='comp1' id='comp1'> </input>
		      <td>
<label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Purpose :</b> </label><textarea id="purpose"  name="purpose"  style='width: 200px; height:50px' class="element textarea medium" required="required" onblur="return funpurpose();"/></textarea><br><br><!--11,2--></td>
</td>
</tr>
					 	<tr>
			
			<td align="left" style="width: 250px;">
			<div id='companyList'>
			<div style="height: 10px; width: 400px; overflow: auto;"></div>
			</div>
			</td>
			</tr>
</table>
<div align="center">
<br>
<label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="submit" name="submit"  class="button_text" type="submit"  value="Submit" /></textarea><br><br>
</div>
</form>

</jsp:useBean>

<%-- <%@include file="footer_new.jsp"%> --%>

<%@ include file="footer_new.jsp"%>
</body>
</html>