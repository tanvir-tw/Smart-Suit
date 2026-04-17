<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
#button {
    background-color: red;
    color: white;
    border: none;
    padding: 3px 10px;
    cursor: pointer;
    margin: 3px;
    border-radius: 4px;
}
</style>
</head>
 <body style="background-color:azure;">
<%
String companyCode = request.getParameter("companyCode");
String custname = request.getParameter("custname");
String billd=request.getParameter("Billday");
int k=1;
String ContarctFromDate1="";String ContarctToDate1="";

if(billd==null || billd.equals("null") || billd=="null")
{
	System.out.println("billd  "+billd);
	billd="1";
}
%> 

<%

Connection con = null;
Statement st1 = null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;

try {
	con = connection.getConnect("db_GlobalERP");        
     st1=con.createStatement();
     stmt1 = con.createStatement();
     stmt2 = con.createStatement();
     stmt3 = con.createStatement();
     stmt4 = con.createStatement();
     stmt5 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 

try{
	String sqlte1="select ContarctFromDate,ContarctToDate,Document from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster  where  CustomerCode="+companyCode+" "; 
	ResultSet rscat11=st1.executeQuery(sqlte1);
	if(rscat11.next()){
		ContarctFromDate1=rscat11.getString("ContarctFromDate");
		ContarctToDate1=rscat11.getString("ContarctToDate");
	}
	
	ContarctFromDate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ContarctFromDate1));
	ContarctToDate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ContarctToDate1));
	
%>
	<input type="hidden" name="ContarctFromDate1" id="ContarctFromDate1" value="<%=ContarctFromDate1%>">
	<input type="hidden" name="ContarctToDate1" id="ContarctToDate1" value="<%=ContarctToDate1%>" >
	
	<%
	String k1="";
String category1="";String CustomerType1=""; String Frequency1=""; String BillType1=" ";
String ToId1=" ",ToCc1=" ",BillStatus1="",OperationalStatus1="",BillDay1="";
Double Rate1=0.00;
	
String sqlte="select BillDay,ToId,ToCc,category,Rate,OperationalStatus,BillFrequency,SLARate,BillStatus,BillType,CustomerType FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster where  CustomerCode="+companyCode+" "; 
ResultSet rscat=stmt1.executeQuery(sqlte);
if(rscat.next()){
	category1=rscat.getString("category");
	CustomerType1=rscat.getString("CustomerType");
	Frequency1=rscat.getString("BillFrequency");
	BillType1=rscat.getString("BillType");
	ToId1=rscat.getString("ToId");
	ToCc1=rscat.getString("ToCc");
	BillStatus1=rscat.getString("BillStatus");
	Rate1=rscat.getDouble("Rate");
	
	BillDay1=rscat.getString("BillDay");

	OperationalStatus1=rscat.getString("OperationalStatus");
	
}%> 
		<input type="hidden" name="category1" value="<%=rscat.getString("category")%>">
		<input type="hidden" name="CustomerType1" value="<%=rscat.getString("CustomerType")%>">
		<input type="hidden" name="Frequency1" value="<%=rscat.getString("BillFrequency") %>">

		<input type="hidden" name="BillType1" value="<%=rscat.getString("BillType")%>">
		<input type="hidden" name="ToId1" value="<%=rscat.getString("ToId")%>">
		<input type="hidden" name="ToCc1" value="<%=rscat.getString("ToCc") %>">
		<input type="hidden" name="BillStatus1" value="<%=rscat.getString("BillStatus")%>">
		<input type="hidden" name="OperationalStatus1" value="<%=rscat.getString("OperationalStatus")%>">
		<input type="hidden" name="Rate1" value="<%=rscat.getDouble("Rate")%>">
		<input type="hidden" name="BillDay1" value="<%=rscat.getString("BillDay")%>">
	
		<input type="hidden" name="companyCode1" id="companyCode1" value="<%=companyCode%>">
		<input type="hidden" name="custname1" id="custname1" value="<%=custname%>" >
<%	
	String sql="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+request.getParameter("companyCode")+"' limit 1";
	ResultSet rs=st.executeQuery(sql);
	if(rs.next())
	{
	%>
		<input type="hidden" name="companyname" value="<%=rs.getString("CustomerCode")%>">
		<input type="hidden" name="companyname1" value="<%=rs.getString("CompanyName")%>">
		<input type="hidden" name="coreforms1" value="<%=rs.getString("CorEForms") %>">
		<input type="hidden" name="login1" value="<%=rs.getString("LoginName") %>">
		<input type="hidden" name="password" value="<%=rs.getString("CustPassword") %>">
		<input type="hidden" name="isdatavalid" value="<%=rs.getString("IsDataValid") %>">
		<input type="hidden" name="custdisc" value="<%=rs.getString("CustDiscountPercent") %>" >
		
		<input type="hidden" name="creditlimit" value="<%=rs.getString("CustCreditLimit") %>">
		<input type="hidden" name="paymentterms" value="<%=rs.getString("CustPaymentTerms") %>">
		<input type="hidden" name="paymentmode" value="<%=rs.getString("CustPaymentMode") %>">
		<input type="hidden" name="telephone2" value="<%=rs.getString("TelephoneNo2") %>">
		<input type="hidden" name="vendorcode" value="<%=rs.getString("VendorCode") %>">
		<input type="hidden" name="tallyname" value="<%=rs.getString("TallyName") %>">
		<input type="hidden" name="transactionexisted" value="<%=rs.getString("TransactionExisted") %>">


<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Contract Details of  :-<%=rs.getString("CompanyName") %></h5>
		    		</div>
<form action="uploaddoc.jsp" method="post" enctype="multipart/form-data" name="addCustomer" id="addCustomer" onsubmit="return  hel() ">
<div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">   
      <div class="row col-12 mt-3">
        <div class="col-4">
         <div class="input-container">
          <label for="PI_source" class="tcolor">Category</label>
            <select class="form-select" id="category" name="category" required>
            <option value="<%=category1%>"><%=category1%></option>
				 <% String sqlDropdown="SELECT distinct category FROM db_gps.t_transporter";
				  ResultSet rsDropdown=stmt2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString("category")%>">
				  <%=rsDropdown.getString("category")%></option>
							
						<% 	}%>
				</select>
          </div>
        </div>
		<div class="col-4 mt-3">
          <div class="input-container">
            <input id="fromdate" name="fromdate" class="form-control floating-input"
                   type="text"  value="<%=ContarctFromDate1%>" required>
            <label for="fromdate" class="floating-label">Contract From</label>
          </div>
        </div>
	<script type="text/javascript">
		Calendar.setup(
		{
		inputField  : "fromdate",         // ID of the input field
		ifFormat    : "%d-%b-%Y",     // the date format
		button      : "fromdate"       // ID of the button
		}
		);
	</script>
	
	
	 <div class="col-4 mt-3">
          <div class="input-container">
            <input id="todate" name="todate" class="form-control floating-input"
                   type="text"   value="<%=ContarctToDate1%>" required>
            <label for="todate" class="floating-label">Contract To</label>
          </div>
        </div>
<script type="text/javascript">
		Calendar.setup(
		{
		inputField  : "todate",         // ID of the input field
		ifFormat    : "%d-%b-%Y",    // the date format
		button      : "todate"       // ID of the button
		}
		);
</script>

</div>
<div class="row col-12">
        <div class="col-4 mt-4">
         <div class="input-container">
          <label for="PI_source" class="tcolor">Bill Day</label>
            <select class="form-select" id="Billday" name="Billday" required>
<option value="<%=BillDay1 %>"><%=BillDay1 %></option>

<%for(k=1;k<=31;k++)
{
	if(k<=9)
	{
		 k1="0"+k;
		System.out.println("KK"+k1);
	
%>
<option value="<%=k1 %>"><%=k1 %></option>
<%}else
{
	%>
	<option value="<%=k %>"><%=k %></option>
	<%
	
}
}%>

<%
if(request.getParameter("Billday") != null){
		
		 %><option value=<%=request.getParameter("Billday")%> selected><%=request.getParameter("Billday") %></option><%
}
%>
</select>
</div>
</div>
	<div class="col-4 mt-4">
	 <div class="input-container">
          <label for="PI_source" class="tcolor">Operational Status</label>
            <select class="form-select" id="operationalstatus" name="operationalstatus" required>			
			<option value="<%=OperationalStatus1%>"><%=OperationalStatus1%></option>
				 <% String sqlDropdown6="SELECT distinct OperationalStatus FROM db_gps.t_transporter";
				  ResultSet rsDropdown6=stmt3.executeQuery(sqlDropdown6);
				  while(rsDropdown6.next()){
				  %>
				  <option value="<%=rsDropdown6.getString("OperationalStatus")%>">
				  <%=rsDropdown6.getString("OperationalStatus")%></option>
							
						<% 	}%>
				</select>
			</div>
		</div>
		<div class="col-4 mt-4">
         <div class="input-container">
          <label for="PI_source" class="tcolor">Customer Type</label>
            <select class="form-select" id="customertype" name="customertype" required>	
			<option value="<%=CustomerType1%>"><%=CustomerType1%></option>
				 <% String sqlDropdown2="SELECT distinct CustomerType FROM db_gps.t_transporter";
				  ResultSet rsDropdown2=stmt4.executeQuery(sqlDropdown2);
				  while(rsDropdown2.next()){
				  %>
				  <option value="<%=rsDropdown2.getString("CustomerType")%>">
				  <%=rsDropdown2.getString("CustomerType")%></option>
							
						<% 	}%>
				</select>
			</div>
		</div>
	</div>
<div class="row col-12 mt-3">
        <div class="col-4 mt-4">       
        	<div class="input-container">
            <input id="rate" name="rate" class="form-control floating-input" type="text" readonly  value="<%=Rate1%>" onblur="return ratevalidate();">
            <label for="todate" class="floating-label">Rate</label>
            <label id="phone4"  style="display: none; color: red; font-size: 10px">Only Positive Numeric value allowed</label>
          	<label id="phone6"  style="display: none; color: red; font-size: 10px">Please Enter Rate</label>
          </div>
        </div>				
<div class="col-4 mt-4">       
        	<div class="input-container">
            <input id="SLA" name="SLA" class="form-control floating-input" type="text" readonly  value="<%=rscat.getDouble("SLARate") %>" onblur="return slaratevalidate();">
            <label for="todate" class="floating-label">SLA Rate (%)</label>
            <label id="phone41"  style="display: none; color: red; font-size: 10px">Only Positive Numeric value allowed</label>
          	<label id="phone61"  style="display: none; color: red; font-size: 10px">Please Enter Rate</label>
          </div>
        </div>	
	 <div class="col-4 mt-4">       
        	<div class="input-container">
          	<textarea class="form-control floating-input" id="email" name="email" onblur="return ValidateEmail();"rows="1"><%=rscat.getString("ToId") %></textarea>
           	<label for="reason" class="floating-label">To Id</label>
           	<label  id="email1" style="display: none; color: red; font-size: 10px">Please Enter EmailID & if no email id enter '-'</label> 
			<label  id="email2" style="display: none; color: red; font-size: 10px">Please Enter valid EmailID & if no email id enter '-'</label> 
			<label  id="email3" style="display: none; color: red; font-size: 10px">Please Enter EmailID & if no email id enter '-'</label> 
           
        	</div>
        </div>
    </div>
<div class="row col-12 mt-3">
        <div class="col-4 mt-4">       
        	<div class="input-container">
			<textarea class="form-control floating-input" id="email0" name="email0" onblur="return ValidateEmail1();"rows="1"><%=rscat.getString("ToCc") %></textarea>
           	<label for="reason" class="floating-label">To Cc</label>
            <label  id="email11" style="display: none; color: red; font-size: 10px">Please Enter EmailID & if no email id enter '-'</label> 
			<label  id="email12" style="display: none; color: red; font-size: 10px">Please Enter valid EmailID & if no email id enter '-'</label> 
			<label  id="email13" style="display: none; color: red; font-size: 10px">Please Enter EmailID & if no email id enter '-'</label> 
          </div>
        </div>     
 			
<div class="col-4">
            <div class="input-container">
                <label class="tcolor">Frequency</label>
                 <select class="form-select" id="frequency" name ="frequency">
                  <option value="<%=Frequency1%>"><%=Frequency1%></option>
                   <% String sqlDropdown3="SELECT distinct BillFrequency FROM db_gps.t_transporter";
				  ResultSet rsDropdown3=stmt3.executeQuery(sqlDropdown3);
				  while(rsDropdown3.next()){
				  %>
				  <option value="<%=rsDropdown3.getString("BillFrequency")%>">
				  <%=rsDropdown3.getString("BillFrequency")%></option>
						<% 	}%>
                   
                 </select>
            </div>
        </div>
 <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Bill Type</label>
                 <select class="form-select" id="billtype" name ="billtype">
                 <option value="<%=BillType1%>"><%=BillType1%></option>
				 <% String sqlDropdown4="SELECT distinct BillType FROM db_gps.t_transporter";
				  ResultSet rsDropdown4=stmt5.executeQuery(sqlDropdown4);
				  while(rsDropdown4.next()){
				  %>
				  <option value="<%=rsDropdown4.getString("BillType")%>">
				  <%=rsDropdown4.getString("BillType")%></option>
							
						<% 	}%>
				</select>
            </div>
        </div>
</div>     

	<div class="row col-12">
					 <%
					 String resendMsg=request.getParameter("resendMsg");
					 if(!(resendMsg==null))
					 {
					 %>
					 <div class="col-4 mt-4">       
        	<div class="input-container">
        	<input class="form-control floating-input" type="text" value="<%=resendMsg %>"  placeholder="">
          		<label for="companyNames" class="floating-label"></label>
        	</div>
       	</div>
				
					 <%}
					 else
					 { %>
					 <div class="col-4 mt-4">       
	        	<div class="input-container">
	        	<label for="MyFile" class="">Multiple file Upload</label>
	        	<input type="file" class="form-control"name="MyFile" id="MyFile"/>
	        	<input type="hidden" name="fileName" id="fileName" value=""></input>
          		
        	</div>
       	</div>
					 <%}%>
					 
				<div class="col-8 mt-4">       
        	<div class="input-container">
          		<label for="companyNames" class="">List Of Documents</label>
          		<div id="files_list" style="font-size: 12px"></div>
        	</div>
       	</div>
       	 		       
					      
</div>


	
	 <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button  id="submit" name="submit" class="btn" type="submit" onclick="return chk()  && slaratevalidate() && ratevalidate() && ValidateEmail() && ValidateEmail1() ">Submit</button>
  </div>
<%} %>

</div>

</div>


<%}catch(Exception e){System.out.print(e);
e.printStackTrace();

	}%>

					 </form>
					 
					 
					 </div>
					 </div>
					 </div>
					 </div>
					 </section>
					 </div>
					 </div>
					 

<script LANGUAGE="JavaScript" type="text/javascript">
var dispAtchFile=null;
function MultiSelector( list_target, max ){

	var fileList=null;
	this.list_target = list_target;
	this.count = 0;
	this.id = 0;
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	this.addElement = function( element ){
		if( element.tagName == 'INPUT' && element.type == 'file' ){

			element.name = 'file_' + this.id++;
			element.multi_selector = this;
			element.onchange = function(){
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				new_element.className = 'form-control';
				this.parentNode.insertBefore( new_element, this );
				this.multi_selector.addElement( new_element );
				this.multi_selector.addListRow( this );
				this.style.position = 'absolute';
				this.style.left = '-1000px';
				
				
				
			};
			if( this.max != -1 && this.count >= this.max ){
				element.disabled = true;
			};

			this.count++;
			this.current_element = element;
			
		} else {
			alert( 'Error: not a file input element' );
		};

	};

	this.addListRow = function( element ){
		var new_row = document.createElement( 'div' );
		var new_row_button = document.createElement( 'input' );
		new_row_button.type = 'button';
		new_row_button.value = 'Delete';
		new_row_button.id = 'button';

		new_row.element = element;

		//**cal 2 add atched files*****************************************
		if(dispAtchFile==null || dispAtchFile=="")
		{
			dispAtchFile=new_row.element.value;
			//alert("add files===="+dispAtchFile);

		}
		else
		{
			//alert("add files===="+dispAtchFile);
			dispAtchFile=dispAtchFile+","+new_row.element.value;
		}
		testIt(dispAtchFile);
	//	document.getElementById("fileName").value=dispAtchFile;
		//******************************************************************

		// Delete function
		new_row_button.onclick= function(){

			// Remove element from form
			this.parentNode.element.parentNode.removeChild( this.parentNode.element );

			// Remove this row from the list
			this.parentNode.parentNode.removeChild( this.parentNode );

			//***cal 2 remove deltd files***************************************
			var dispDelFile=null;
			if(dispDelFile==null)
			{
				dispDelFile=this.parentNode.element.value;
			}
			else
			{
				dispDelFile=dispDelFile+","+this.parentNode.element.value;
			}
			
			removeFileList(dispAtchFile,dispDelFile);		

			// Decrement counter
			this.parentNode.element.multi_selector.count--;

			// Re-enable input element (if it's disabled)
			this.parentNode.element.multi_selector.current_element.disabled = false;
				
			return false;
		};

		// Set row value
		new_row.innerHTML = element.value;
		if(fileList==null)
		{
			fileList=new_row.innerHTML;
		}
		else
		{
			fileList=fileList+","+new_row.innerHTML;
		}
		
		// Add button
		new_row.appendChild( new_row_button );
		//alert(fileList);
			
		// Add it to the list
		this.list_target.appendChild( new_row );		
	};
//	response.sendRedirect("fileData.jsp?fileList="+fileList);
};

function removeFileList(AddName,DelName)
{
	//alert(employeeList+"==="+delEmployee);
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

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
	        testIt(reslt);
		} 
		
	}
	ajaxRequest.open("GET","fileDataDeleteBk.jsp?AddName="+AddName+"&DelName="+DelName,true);
	ajaxRequest.send(null);
}
function testIt(p1)
{
	dispAtchFile=p1.replace(/\s+/g,'');
	//alert("in testIt=====<>"+dispAtchFile);
	document.getElementById("fileName").value=dispAtchFile;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function validate()
{
	var val1 = document.getElementById("fileName").value.replace(/\s+/g,'');
	if(val1=="")
	{
		alert("Please Select File For Upload");
		return false;
	}
	return true;
}
</script>

<script>


 
 
function Validation()
{

	//******************Validation for ToId *****************************  
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;
	
	var valid= true;
	  
	/* valid = emails.forEach(function(email){
		
			validate(email.trim());
	}); */
	valid = emails.every(validate);


	function validate(email){
		var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;
		  
	//alert(email);
	if(email.trim()=="" )
	{
		//alert(email);
	document.getElementById("email3").style.display="";
	return false;
	}

	if(!text.test(email) && !(email.trim() == "-") )
	{
	document.getElementById("email2").style.display="";
	return false;

	}

	return true;
	}

	return valid;
	
 

	//******************Validation for Rate *****************************  
	
	
	document.getElementById("phone4").style.display="none";
  document.getElementById("phone6").style.display="none";
//var invalid=/^[0-9 ,]+$/; \   
//var invalid=/^\d*\.?\d*$/;
//before decimal 2 values and after 1 /^[0-9]{1,2}(\.[0-9])?$/
//var invalid = /^[1-9][0-9](\\.\\d)?$/;
var invalid=/^\d+(\.\d{2})?$/;
 var mob=document.getElementById("rate").value;

  if(!(mob==""))
		{
	   if(!invalid.test(mob))
				{
					document.getElementById("phone4").style.display="";
					return false;
				}	
				 
		}
		else
		{
			mob="";
			document.getElementById("phone6").style.display="";
		    return false;	
		}
  
//******************Validation for ToCc *****************************  
	
  document.getElementById("email13").style.display="none";
	document.getElementById("email11").style.display="none";
	document.getElementById("email12").style.display="none";

	var txtEmail=document.getElementById("email0").value;
	
	var emails = txtEmail.split(",");
	
	
	  
	emails.forEach(function(email){
		
			validate(email.trim());
	});

	function validate(email){
			var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;
			  
//	alert(email);
		if(email.trim()=="" )
		{
			//alert(email);
		document.getElementById("email13").style.display="";
		return false;
		}

	if(!text.test(email) && !(email.trim() == "-") )
	{
	document.getElementById("email12").style.display="";
	return false;

	}
		} 
 
	
	  
} 

function ValidateEmail()
{
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;
	
	var emails = txtEmail.split(",");
	
	var valid= true;
	  
/* valid = emails.forEach(function(email){
	
		validate(email.trim());
}); */
valid = emails.every(validate);


function validate(email){
	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;
	  
//alert(email);
if(email.trim()=="" )
{
	//alert(email);
document.getElementById("email3").style.display="";
return false;
}

if(!text.test(email) && !(email.trim() == "-") )
{
document.getElementById("email2").style.display="";
return false;

}

return true;
}

return valid;
}


  function ValidateEmail1()
{
	document.getElementById("email13").style.display="none";
	document.getElementById("email11").style.display="none";
	document.getElementById("email12").style.display="none";

	var txtEmail=document.getElementById("email0").value;
	
	var emails = txtEmail.split(",");
	
	var valid= true;
	valid = emails.every(validate);

	  
	function validate(email){
			var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;
			  
	//alert(email);
		if(email.trim()=="" )
		{
			//alert(email);
		document.getElementById("email13").style.display="";
		return false;
		}

	if(!text.test(email) && !(email.trim() == "-") )
	{
	document.getElementById("email12").style.display="";
	return false;

	}
	
	return true;
		}

	return valid;

	}
	 
  </script>
  
  <script>
  

  function slaratevalidate()
  {
	  
	  
	  document.getElementById("phone41").style.display="none";
	  document.getElementById("phone61").style.display="none";
	  var invalid1=/^\d+(\.\d+)?$/; 
	//var invalid=/^\d*\.?\d*$/;
	//before decimal 2 values and after 1 /^[0-9]{1,2}(\.[0-9])?$/
	//var invalid = /^[1-9][0-9](\\.\\d)?$/;
	//var invalid=/^\d+(\.\d{2})?$/;
	 var mob1=document.getElementById("SLA").value;

	  if(!(mob1==""))
			{
		   if(!invalid1.test(mob1))
					{
						document.getElementById("phone41").style.display="";
						return false;
					}	
					 
			}
			else
			{
				mob="";
				document.getElementById("phone61").style.display="";
			    return false;	
			}
	  ratevalidate();
  }
  
  </script>
  <script>

function ratevalidate()
{
document.getElementById("phone4").style.display="none";
  document.getElementById("phone6").style.display="none";
  var invalid=/^\d+(\.\d+)?$/; 
//var invalid=/^\d*\.?\d*$/;
//before decimal 2 values and after 1 /^[0-9]{1,2}(\.[0-9])?$/
//var invalid = /^[1-9][0-9](\\.\\d)?$/;
//var invalid=/^\d+(\.\d{2})?$/;
 var mob=document.getElementById("rate").value;

  if(!(mob==""))
		{
	   if(!invalid.test(mob))
				{
					document.getElementById("phone4").style.display="";
					return false;
				}	
				 
		}
		else
		{
			mob="";
			document.getElementById("phone6").style.display="";
		    return false;	
		}
  
  slaratevalidate();
}


function testIt(p1)
{
	dispAtchFile=p1.replace(/\s+/g,'');
	//alert("in testIt=====<>"+dispAtchFile);
	document.getElementById("fileName").value=dispAtchFile;
}

function validate()
{
	var val1 = document.getElementById("fileName").value.replace(/\s+/g,'');
	if(val1=="")
	{
		alert("Please Select File For Upload");
		return false;
	}
	return true;
}

function hel()
{
	
	
	
	//alert("JJJ");
	
	  var invalid=/^\d+(\.\d+)?$/; 
	//var invalid=/^\d*\.?\d*$/;
	//before decimal 2 values and after 1 /^[0-9]{1,2}(\.[0-9])?$/
	//var invalid = /^[1-9][0-9](\\.\\d)?$/;
	//var invalid=/^\d+(\.\d{2})?$/;
	 var mob=document.getElementById("rate").value;

	  if((mob==""))
			{
		  
		  alert("Enter Rate");
			return false;

			}
		  else  if(!invalid.test(mob))
					{
			  alert("Enter Proper Value");
						return false;
					}	
		  else
			  {
			  return true;
			  }
		
	}
</script>
	<script type="text/javascript">
var multi_selector = new MultiSelector( document.getElementById('files_list'), 7);
multi_selector.addElement( document.getElementById('MyFile'));
</script>	
<%@ include file="footer.jsp" %>
</body>
</html> 