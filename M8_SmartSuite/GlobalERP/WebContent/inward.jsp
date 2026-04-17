<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
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
 <body style="background-color:azure;" ONKEYDOWN="if (event.keyCode == 27){document.getElementById('EmpList').style.display = 'none';}">
<%!Connection con;%>
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
	<%
	String msg = (String)session.getAttribute("errormsg");
	String datenew1=request.getParameter("data");
if(null==datenew1)
{
	datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
%>
<%
try {	
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Inward Entry</h5>
		    		</div>
		             <br>
		<%
//======Get new iwno and iwrefno============================================================================
int i=0,j=0,iwno=0;
String refno="",dt="",a="";
String date=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
java.text.DecimalFormat df = new java.text.DecimalFormat("00");
try
{
	    refno="IW";
        String sqlIwno="SELECT rid,InwardRefNo  from t_inwarddetails  where InwardRefNo like ('"+refno+""+date+"%') ORDER BY InwardRefNo DESC LIMIT 1";
		ResultSet rst=stmt2.executeQuery(sqlIwno);
		if(rst.next())
		{
			String a1=rst.getString(2);
			System.out.println(">>>>>>>>  "+a1);
			iwno=rst.getInt("rid");
			refno=rst.getString(2).substring(0,rst.getString(2).length()-2)+df.format(Integer.parseInt(rst.getString(2).substring(rst.getString(2).length()-2, rst.getString(2).length()))+1);		
		}
		else
		{
			refno+=date+"001";	
		}
}
catch(Exception e)
{
	out.println("Exception=================>>"+e);
}
//==================================================================================
%>
<form action="inwardTest.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
  <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">   
    <%iwno=iwno+1;%>
      <div class="row col-12 mt-2">
       <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="custype1" name="custype1" value="<%=iwno%>"  placeholder="" readonly>
          		
          		<label for="custype1" class="floating-label">Inward No</label>
          		
        </div>  
      </div>
      <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="custype1" name="custype1" value="<%=refno%>"  placeholder="" readonly>
          		
          		<label for="custype1" class="floating-label">Inward Ref. No</label>
          		
        </div>  
      </div>
      <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="manualref" name="manualref"  placeholder="">
          		
          		<label for="custype1" class="floating-label">Reference No</label>
          		
        </div>  
      </div>
     </div>
    <div class="row col-12 mt-2">
       <div class="col-3 mt-4">
        	<div class="input-container">
          		<textarea class="form-control floating-input" id="address" name="address" rows="1"></textarea>
           		<label for="reason" class="floating-label">Address</label>
        	</div> 
      </div>
      <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Category</label>
                 <select class="form-select" name="cat" id="cat" onchange="getCategory(this.value);" required>
                   		<% 
		try{
		String sqlCat="select distinct(InwrdCategory) from t_InwardCategory" ;
		   ResultSet rsCat=stmt1.executeQuery(sqlCat);
		    while(rsCat.next())
		    { %>
			<option value="<%=rsCat.getString("InwrdCategory") %>">
			<%=rsCat.getString("InwrdCategory") %>
			</option>
		<%  } 
		}
		catch(Exception e)
		{
			System.out.println("Exception======>>"+e);
			
		}%>
                 </select>
            </div>
        </div>
           
          <div class="col-3 mt-4" id="frmParty" style="position: relative;">
    <div class="input-container">
        <input class="form-control floating-input"
               type="text"
               id="from1"
               name="from1"
               autocomplete="off"
               onkeyup="if (event.keyCode == 27 || event.keyCode == 13){
                   document.getElementById('EmpList').style.display='none';
               } else {
                   getEmp123();
               }">

        <label class="floating-label">From</label>
    </div>

    <div id="EmpList" class="emp-dropdown"></div>
</div>
          
         
         <div class="col-3 mt-4"> 
           <div class="input-container" id="frmParty1" style="display:none; ">
       			<input class="form-control floating-input" type="text" id="from" name="from" placeholder="">
       			<label for="companyNames" class="floating-label">From</label>
        </div>
       </div>
       
       <div class="col-3 mt-4" id="custLink" style="display: none">
			<a href="" onclick="getAddContact()" style="text-decoration: none;">Add Contact</a>
       </div>
      </div>
        
   
     <!--  <div class="row col-12 mt-2">
       <div class="col-4" id="custLink" style="display: none">
			<a href="" onclick="getAddContact()" style="text-decoration: none;">Add Contact</a>
       </div>
      </div> --> 
    <div class="row col-12 mt-2">
       <div class="col-3" id="billno" style="display: none">
        	<div class="input-container">
          		<input class="form-control floating-input" type="text" id="blno" name="blno"  placeholder="">
           		<label for="reason" class="floating-label">Bill No.</label>
        	</div> 
     	</div>
     	 <div class="col-3" id="billamt" style="display: none">
        	<div class="input-container">
          		<input class="form-control floating-input" type="text" id="blamt" name="blamt" placeholder="">
           		<label for="reason" class="floating-label">Bill Amount</label>
        	</div> 
     	</div>
     	
     	<div class="col-3" id="billdate" style="display: none">
        	<div class="input-container">
          		<input class="form-control floating-input" type="text" id="bldate" name="bldate" value="<%=datenew1%>" readonly  placeholder="">
           		<label for="reason" class="floating-label">Bill Date</label>
        	</div> 
        	<script type="text/javascript">
						  Calendar.setup(
						    {
						      inputField  : "bldate",         // ID of the input field
						      ifFormat    : "%d-%b-%Y",    // the date format									
						      button      : "bldate"       // ID of the button
						    }
						  );
					</script>
     	</div>
     	 <div class="col-3" id="billduedate" style="display: none">
        	<div class="input-container">
          		<input class="form-control floating-input" type="text" id="blduedate" name="blduedate" value="<%=datenew1%>" readonly placeholder="">
           		<label for="reason" class="floating-label">Bill Due Date</label>
        	</div> 
        	<script type="text/javascript">
						  Calendar.setup(
						    {
						      inputField  : "blduedate",         // ID of the input field
						      ifFormat    : "%d-%b-%Y",    // the date format
						      button      : "blduedate"       // ID of the button
						    }
						  );
					</script>
     	</div>
    </div>
    
     <div class="row col-12 mt-2" id="agreement" style="display: none;">
       <div class="col-3" id="agrParty" style="display: none">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="agreementParty" name="agreementParty" placeholder="">
          		<label for="companyNames" class="floating-label">Agreement Party</label>
        </div>  
      </div>
      
      <div class="col-3" id="agreementDate" style="display: none">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="agreementDate" name="agreementDate" value="<%=datenew1%>" placeholder="" readonly>
          		<label for="companyNames" class="floating-label">Agreement Date</label>
        </div>  
        		<script type="text/javascript">
						  Calendar.setup(
						    {
						      inputField  : "agreementDate",         // ID of the input field
						      ifFormat    : "%d-%b-%Y",    // the date format									
						      button      : "agreementDate"       // ID of the button
						    }
						  );
					</script>
      </div>
       <div class="col-3" id="agrFrom" style="display: none">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="agreementFrom" name="agreementFrom" value="<%=datenew1%>" placeholder="" readonly>
          		<label for="companyNames" class="floating-label">Agreement From</label>
        </div>  
        		<script type="text/javascript">
						  Calendar.setup(
						    {
						      inputField  : "agreementFrom",         // ID of the input field
						      ifFormat    : "%d-%b-%Y",    // the date format									
						      button      : "agreementFrom"       // ID of the button
						    }
						  );
					</script>
      </div>
     
      <div class="col-3" id="agreementTo" style="display: none">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="agreementTo" name="agreementTo" value="<%=datenew1%>" placeholder="" readonly>
          		<label for="companyNames" class="floating-label">Agreement From</label>
        </div>  
        		<script type="text/javascript">
						  Calendar.setup(
						    {
						      inputField  : "agreementTo",         // ID of the input field
						      ifFormat    : "%d-%b-%Y",    // the date format									
						      button      : "agreementTo"       // ID of the button
						    }
						  );
					</script>
      </div>
     </div>
      <div class="row col-12 mt-2">
        <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="prno" name="prno" placeholder="">
          		<label for="companyNames" class="floating-label">Party Ref No</label>
        </div>  
      </div>
      <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Department</label>
                 <select class="form-select" id="dept" name ="dept" onchange="getEmp(this.value);" required>
                    <option selected="selected" value="Select">Select</option>
                   		<% sql="select distinct(TypeValue) as Dept from t_leaveadmin order by Dept asc" ;
							ResultSet rst3=stmt1.executeQuery(sql);
							while(rst3.next())
							  { %>
									<option value="<%=rst3.getString("Dept") %>">
									<%=rst3.getString("Dept") %>
									</option><%  } %>
                 </select>
            </div>
        </div>
        <div class="col-3">
            <div class="input-container">
                <label class="tcolor">To</label>
                 <select class="form-select" id="to" name ="to" onchange="selectoption();" required>
                    <option selected="selected" value="Select">Select</option>
                 </select>
            </div>
        </div>
         <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="sub" name="sub"  placeholder="" required>
          		<label for="companyNames" class="floating-label">Subject</label>
        </div>  
      </div>
     </div>
     
      <div class="row col-12 mt-2">
       <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="data" name="data"  value="<%=datenew1%>" readonly>
          		<label for="companyNames" class="floating-label">Action Date</label>
        </div>  
      </div>
      <script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
	</script>
	
	
	  <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Priority</label>
                 <select class="form-select" id="priority" name ="priority" required>
                   		<option value="Low">Low</option>
						<option value="Medium">Medium</option>
						<option value="High">High</option>
                 </select>
            </div>
        </div>
         <div class="col-4 mt-4">
        	<div class="input-container">
          		<textarea class="form-control floating-input" id="remark" name="remark" rows="1"></textarea>
          	 	<label for="reason" class="floating-label">Remarks</label>
        	</div>
       	</div>
      </div>
      <div class="row col-12 mt-2">
      	<div class="col-4 mt-4">       
	        	<div class="input-container">
	        	<label for="MyFile" class="">Multiple file Upload</label>
	        	<input type="file" class="form-control"name="MyFile" id="MyFile"/>
	        	<input type="hidden" name="fileName" id="fileName" value=""></input>
          		
        	</div>
       	</div>
       	<div class="col-8 mt-4">       
        	<div class="input-container">
          		<label for="companyNames" class="">List Of Documents</label>
          		<div id="files_list" style="font-size: 12px"></div>
        	</div>
       	</div>		
       	
       	
      </div>	
     
      <div class="row mt-3">
    
    <div class="col-md-2 col-sm-12 d-flex align-items-center">
        <input class="form-check-input me-2" type="radio" name="sendType" value="link" checked>
        <label class="form-label fw-bold mb-0">Send Intimation</label>
    </div>

    <div class="col-md-2 col-sm-12 d-flex align-items-center">
        <input class="form-check-input me-2" type="radio" name="sendType" value="attach">
        <label class="form-label fw-bold mb-0">Send Attachment</label>
    </div>

    <div class="col-md-2 col-sm-12 d-flex align-items-center">
        <input class="form-check-input me-2" type="radio" name="sendType" value="save">
        <label class="form-label fw-bold mb-0">Send File</label>
    </div>

</div>
<div class="d-flex justify-content-center gap-2 mt-3">
    <button class="btn btn-secondary px-4" type="button" onclick="this.form.reset()">Reset</button>
    <button class="btn btn-primary px-4" type="submit" onclick="return validate();">Send</button>
</div>
</div>
</div>
  <input type="hidden" name="inno" id="inno" value="<%=iwno%>" readonly />
  <input type="hidden" name="inrefno" id="inrefno" value="<%=refno%>" readonly />
  <input type="hidden" name="SelectedEmpMail" id="SelectedEmpMail" value="" />
  <input type="hidden" name="fileName" id="fileName" value="" />
  <input type="hidden" name="flag" id="flag" value="false"/>
</form>
							
			<%
}catch(Exception e)
{
	out.print("Exception -->"+e);
}

%>
		</div>
	</div>
	</div>
</div>
</section>
</div>
</div>
		
<script>
var dispAtchFile=null;
var crg=null;


function selectoption()
{
	document.form1.to.focus();
}

function getAddContact()
{
	try
	{
		window.open('p','mywindow','width=1200, height=550, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
}
function showVisitingCardDetails(eName,empMail)
{
	document.getElementById("from1").value=eName;
	document.getElementById("SelectedEmpMail").value=empMail;
	document.getElementById("EmpList").style.display='none';
}
function getEmp123()
{
	//alert("============================>>"+crg);
	document.getElementById("EmpList").style.display='block';
	var emp=document.getElementById("from1").value;
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
	var queryString = "?emp=" +emp+"&crg="+crg;
	ajaxRequest.open("GET", "SearchBoxForFromCategory.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
//	var date2=document.getElementById("data1").value;
  
	var dm1,dd1,dy1;//,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
//	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
//	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
//	dd2=date2.substring(8,10);
//    var d2date=date2.substring(0,2);
    var d1date=date1.substring(0,2);
    var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	return true;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

			// File element counter
			this.count++;
			// Most recent element
			this.current_element = element;
			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};

	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element ){

		// Row div
		var new_row = document.createElement( 'div' );

		// Delete button
		var new_row_button = document.createElement( 'input' );
		new_row_button.type = 'button';
		new_row_button.value = 'Delete';
		new_row_button.id = 'button';
		
		

		// References
		new_row.element = element;

		//**cal 2 add atched files*****************************************
		if(dispAtchFile==null || dispAtchFile=="")
		{
			dispAtchFile=new_row.element.value;
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
			
			//-----------------------------------------------------------------
			removeFileList(dispAtchFile,dispDelFile);
			//-----------------------------------------------------------------	
			
			//******************************************************************
			

			// Decrement counter
			this.parentNode.element.multi_selector.count--;

			// Re-enable input element (if it's disabled)
			this.parentNode.element.multi_selector.current_element.disabled = false;
				
			// Appease Safari
			//    without it Safari wants to reload the browser window
			//    which nixes your already queued uploads
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
	//ajaxRequest.open("GET","fileDataDeleteBk.jsp?AddName="+AddName+"&DelName="+DelName,true);
	ajaxRequest.open("GET","fileDataDelete.jsp?AddName="+AddName+"&DelName="+DelName,true);
	ajaxRequest.send(null);
}
function testIt(p1)
{
//	alert(p1);
	dispAtchFile=p1.replace(/\s+/g,'');
//	alert(dispAtchFile);
	document.getElementById("fileName").value=dispAtchFile;
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function getEmp(deptName)
{
	deptName=escape(deptName);
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
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
		  //alert(xmlhttp.responseText);
		  document.getElementById("to").innerHTML=xmlhttp.responseText;
		  }
		}
		xmlhttp.open("GET","getEmployee.jsp?deptName="+deptName,true);
		xmlhttp.send(null);
		
}

function isDecimal(str)
{
	if(isNaN(str) || str.indexOf(".")<0)
	{
		alert("Enter Decimal Number");
	}
	else
	{
		str=parseFloat(str);
		alert ("Entered number is decimal");
	}
}

function validate()
{
	
	var val1 = document.getElementById("inno").value;
	var val2 = document.getElementById("inrefno").value;
	var val3 = document.getElementById("from").value;
	var frm = document.getElementById("from1").value;
	var val4 = document.getElementById("prno").value;
	var val8 = document.getElementById("dept").value;
	var val5 = document.getElementById("to").value;//document.to.value;
	var val7 = document.getElementById("sub").value;
	var val9 = document.getElementById("cat").value;
	var actDate= document.getElementById("data").value;
	var priority=document.getElementById("priority").value;
	var val10 = document.getElementById("fileName").value.replace(/\s+/g,'');
		
	var bn= document.getElementById("blno").value;
	var bmt= document.getElementById("blamt").value;

	var billdate=document.getElementById("bldate").value;
	var billduedate=document.getElementById("blduedate").value;

	if(val9=="" || val9=="Select"){
		alert("Please Select Category");
		return false;
	}

	if(val9=="Bills")
	{
		if(bn==null || bn=="")
		{
			alert("Please Enter Bill No.");
			return false;
		}
		if(bmt==null || bmt=="")
		{
			alert("Please Enter Bill Amt");
			return false;
		}
		else if(isNaN(bmt))
      	{
      		alert("Please Enter Numeric Value For Bill Amount");
      		return false;
      	}	
		
	}
	
	if(val3=="" && frm==""){
		alert("Please Enter Inward From Party Name");
		return false;
	}
	
	if(val8==""){
		alert("Please Enter Department");
		return false;
	}
	if(val5==""){
		alert("Please Select Employee Name");
		return false;
	}
	if(val7==""){
		alert("Please Enter Subject");
		return false;
	}
	
	if(priority=="" || priority=="Select"){
		alert("Please Select Priority");
		return false;
	}

	if(val10=="" || val10==null){
		alert("Please Select File For Upload");
		return false;
	}
	
	return true;
}
function getCategory(catgry)
{
	var ct=catgry;
	crg=ct;

	if(crg=="Bills")
	{
		document.getElementById("frmParty1").style.display='none';

		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agreementTo").style.display="none";
		document.getElementById("agreementDate").style.display="none";
		document.getElementById("frmParty").style.display="";
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display="";
		document.getElementById("billamt").style.display="";
		document.getElementById("billdate").style.display="";
		document.getElementById("billduedate").style.display="";
		
	}
	else if(crg=="customer")
	{
		document.getElementById("frmParty1").style.display='none';

		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agreementTo").style.display="none";
		document.getElementById("agreementDate").style.display="none";
		document.getElementById("frmParty").style.display="";
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		
	}
	else if(crg=="Visiting Card")
	{

		document.getElementById("frmParty1").style.display="";

		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agreementTo").style.display="none";
		document.getElementById("agreementDate").style.display="none";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display="";
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
	}
	else if(crg=="Agreement")
	{
		
		document.getElementById("agreement").style.display="";
		document.getElementById("frmParty1").style.display="";
		document.getElementById("agrParty").style.display="";
		document.getElementById("agreementDate").style.display="";
		document.getElementById("agreementTo").style.display="";
		document.getElementById("agrFrom").style.display="";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		
	}
	else
	{
		document.getElementById("frmParty1").style.display="";
		document.getElementById("agreementTo").style.display="none";
		document.getElementById("agreementDate").style.display="none";
		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
	}
}
</script>
<script type="text/javascript">
var multi_selector = new MultiSelector( document.getElementById('files_list'), 5 );
multi_selector.addElement( document.getElementById('MyFile'));
</script>
</body>
<%@include file="footer.jsp" %>
</html>