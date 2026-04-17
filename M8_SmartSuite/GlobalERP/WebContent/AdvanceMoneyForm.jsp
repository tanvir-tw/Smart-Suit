             
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>

	<%@ include file="header.jsp"%>
	<%@page import="java.util.Date"%>
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Route Management</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<link href='https://fonts.googleapis.com/css?family=Arial+Web:400,300,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/style123.css">
    <link rel="stylesheet" href="css/123multiple-select.css" />
<script type="text/javascript" src="jquery-1.4.2.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>

<!--Requirement jQuery-->

	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!--Load Script and Stylesheet -->
	<script type="text/javascript" src="css/jquery.simple-dtpicker.js"></script>
	<link type="text/css" href="css/jquery.simple-dtpicker.css" rel="stylesheet" />
	
	  
	 

     

 
	
<style type="text/css">



::placeholder {
    color: black;
    
}



.top-row > div {
    float: left;
    width: 13%;
    margin-right: 4%;
}

.multiselect-container .input-group{margin:5px}.multiselect-container .multiselect-reset .input-group{width:93%}.multiselect-container>li{padding:0}.multiselect-container>li>a.multiselect-all label{font-weight:700}.multiselect-container>li.multiselect-group label{margin:0;padding:3px 20px;height:100%;font-weight:700}.multiselect-container>li.multiselect-group-clickable label{cursor:pointer}.multiselect-container>li>a{padding:0}.multiselect-container>li>a>label{margin:0;height:100%;cursor:pointer;font-weight:400;padding:3px 20px 3px 40px}.multiselect-container>li>a>label.checkbox,.multiselect-container>li>a>label.radio{margin:0}.multiselect-container>li>a>label>input[type=checkbox]{margin-bottom:5px}.btn-group>.btn-group:nth-child(2)>.multiselect.btn{border-top-left-radius:4px;border-bottom-left-radius:4px}.form-inline .multiselect-container label.checkbox,.form-inline .multiselect-container label.radio{padding:3px 20px 3px 40px}.form-inline .multiselect-container li a label.checkbox input[type=checkbox],.form-inline .multiselect-container li a label.radio input[type=radio]{margin-left:-20px;margin-right:0}

</style>	
	
	<!---->
<script type="text/javascript">

function lookup(RequesterName) {
if(RequesterName.length == 0) {
$('#suggestions').hide();
} else {
$.post("searchRequesterName.jsp", {queryString: ""+RequesterName+""}, function(data){
if(data.length >0) {
$('#suggestions').show();
$('#autoSuggestionsList').html(data);
}
});
}
}
function fill(thisValue) {
$('#RequesterName').val(thisValue);
setTimeout("$('#suggestions').hide();", 200);
}
</script>


 <script type="text/javascript">
 function chk()
 {

 	
 	
 	var chkf="";
 	var chkt="";
 	var objFromDate = document.getElementById("data").value;
 	
 	
 	var fdate=objFromDate.split("-");
 	if(fdate[1]=="Jan")
 	{
 		chkf="01";
 	}
 	if(fdate[1]=="Feb")
 	{
 		chkf="02";
 	}
 	if(fdate[1]=="Mar")
 	{
 		chkf="03";
 	}
 	if(fdate[1]=="Apr")
 	{
 		chkf="04";
 	}
 	if(fdate[1]=="May")
 	{
 		chkf="05";
 	}
 	if(fdate[1]=="Jun")
 	{
 		chkf="06";
 	}
 	if(fdate[1]=="Jul")
 	{
 		chkf="07";
 	}
 	if(fdate[1]=="Aug")
 	{
 		chkf="08";
 	}
 	if(fdate[1]=="Sep")
 	{
 		chkf="09";
 	}
 	if(fdate[1]=="Oct")
 	{
 		chkf="10";
 	}
 	if(fdate[1]=="Nov")
 	{
 		chkf="11";
 	}
 	if(fdate[1]=="Dec")
 	{
 		chkf="12";
 	}
 	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
     var objToDate = document.getElementById("data1").value;
     var tdate=objToDate.split("-");
     if(tdate[1]=="Jan")
 	{
     	chkt="01";
 	}
 	if(tdate[1]=="Feb")
 	{
 		chkt="02";
 	}
 	if(tdate[1]=="Mar")
 	{
 		chkt="03";
 	}
 	if(tdate[1]=="Apr")
 	{
 		chkt="04";
 	}
 	if(tdate[1]=="May")
 	{
 		chkt="05";
 	}
 	if(tdate[1]=="Jun")
 	{
 		chkt="06";
 	}
 	if(tdate[1]=="Jul")
 	{
 		chkt="07";
 	}
 	if(tdate[1]=="Aug")
 	{
 		chkt="08";
 	}
 	if(tdate[1]=="Sep")
 	{
 		chkt="09";
 	}
 	if(tdate[1]=="Oct")
 	{
 		chkt="10";
 	}
 	if(tdate[1]=="Nov")
 	{
 		chkt="11";
 	}
 	if(tdate[1]=="Dec")
 	{
 		chkt="12";
 	}
     var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
      
     var date1 = new Date(objFromDate1);
     var date2 = new Date(objToDate1);
     
     //alert("from > "+date1+" Todate > "+date2);
     
     var date3 = new Date();
     var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
     var currentDate = new Date(date4);
      
         if(date1 > date2)
         {
             alert("Departure Date Should be Less Than Return Date");
             return false; 
         }
//          else if(date1 > currentDate)
//          {
//              alert("From Date should be less than current date");
//              return false; 
//          }
//          else if(date2 > currentDate) 
//          {
//              alert("To Date should be less than current date");
//              return false; 
//          }

         return true;
 	
 }
 
</script>





<script type="text/javascript">
function move() {
	
	var quantity = document.getElementById("quantity").value;
	if(quantity>0){
		  var x = document.getElementById("myProgress");
		  x.style.display = "block";
	
	  var elem = document.getElementById("myBar");   
	  var width = 0;
	  var id = setInterval(frame, 10);
	  function frame() {
	    if (width >= 100) {
	      clearInterval(id);
	    } else {
	      width++; 
	      elem.style.width = width + '%'; 
	      elem.innerHTML = width * 1  + '%';
	    }
	  }
	}
}
</script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

var i=0;
$(document).ready(function(){
    $("#btnAdd").click(function(){
    
        $("#auto").clone().appendTo("#clone");
        
        i++;
        if(i==1)
		{
		
		document.getElementById("btnrm").style.visibility = "visible";
		}
        
        
        
    	$("#origin").val('');
    	$("#amount").val('');
    	
		$("#destination").val('');
	
    });
});
</script>



<script>
$(document).ready(function(){
    $("#btnrm").click(function(){
    	if(i==1)
    		{
    		
    		document.getElementById("btnrm").style.visibility = "hidden";
    		}
        $("#auto").remove();
        i--;
        
        
    });
});


</script>


<script language="JavaScript1.2">





function addRow(tableID)
{
	//alert("IN FUB");
	try{
		  if(document.getElementById("group").options[document.getElementById("group").selectedIndex].value=='Select')
		  {
			  alert("Please select group!");
			  return(false);
		  }
		  /*
		  if(document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value== '0::1::a::0')
		  {
			  alert("Please select make!");
			  return(false);
		  }

		  if(document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value==null)
		  {
			  alert("Please select model!");
			  return(false);
		  }
		  if(document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value==null)
		  {
			  alert("Please select part No!");
			  return(false);
		  }*/
		  if(document.purchaseDetails.quantity.value=='')
		  {
			  alert("Please enter Quantity");
			  return(false);
		  }
	}catch(e)
	{
		alert(e);
	}	  

		  var rcnt = parseInt(document.getElementById("rcnt").value);
		  rcnt = rcnt + 1;
		  //alert(rcnt);	
		  document.getElementById("rcnt").value = rcnt;
		  //alert(document.getElementById("rcnt").value);
		  
	    var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
	    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];

        document.purchaseDetails.a1.value=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
		//alert(document.purchaseDetails.a1.value);

	    
	    var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
	    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
		var model=document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value.split("::")[0];
		//alert("?????????  /  "+model);
		var partNo=document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value.split("::")[0];        
		//alert(partNo);
		var desc=document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value.split("::")[0];
	    var specification=document.getElementById("specification").value;
		var quantity=document.purchaseDetails.quantity.value;
		var modelNotKnown="false";
		if(document.purchaseDetails.modelNotKnown.checked)
			modelNotKnown="true";
	                                                                                                           	
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
            var tab = document.getElementById(tableID);
            var rowCnt = tab.rows.length;
			
	        var queryString = "?make="+makeCode+"&group="+groupCode+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown="+modelNotKnown+"&specification="+specification;
	       	/* alert(queryString); */
	        ajaxRequest.open("GET", "AjaxSalesEnq.jsp" + queryString, true);
	       	ajaxRequest.send(null); 
	       	ajaxRequest.onreadystatechange = function()
	         {
	                if(ajaxRequest.readyState == 4)
	                {
	                        var reslt=ajaxRequest.responseText;
	                        var data=reslt.split("#");
	                        if(data[1].indexOf('Yes')!=-1)
	                        {
			                        var table = document.getElementById(tableID);
		
			                        var rowCount = table.rows.length;
			                        var row = table.insertRow(rowCount);

					                        
			                        var cell1 = row.insertCell(0);
			                	   var element1=document.createElement("input") ;
			                        element1.type = "checkbox";
			                       element1.name = "chk";
			                       cell1.appendChild(element1);
			                      //  cell1.innerHTML = "<div align='left'><a href=#><img src=images/delete.JPG  width=20px height=18px style=border-style: none  onclick=deleteRow('dataTable')></img></a></div>";


			                        var cell2 = row.insertCell(1);
			                        cell2.innerHTML = counter++ ;

			                        var cell3 = row.insertCell(2);
			                        cell3.innerHTML = "<div align='left'>"+groupName+"</a></div>";

			                        var cell4 = row.insertCell(3);
			                        cell4.innerHTML = "<div align='left'>"+makeName+"</a></div>";
			                        
			                        var cell5 = row.insertCell(4);
			                        cell5.innerHTML = "<div align='left'>"+model+"</a></div>";
		
			                        var cell6 = row.insertCell(5);
			                        cell6.innerHTML =  "<div align='left'>"+partNo+"</a></div>";
                       
			                        var cell7 = row.insertCell(6);
			                        cell7.innerHTML = "<div align='left'>"+desc+"</a></div>";
			                       // cell7.innerHTML = "<div align='left'><a href=#  onclick='toggleDetails("+desc+",true)'  title='Click To See the Details'>"+desc+"</a></div>";
           
			                        var cell8 = row.insertCell(7);
			                        cell8.innerHTML =  "<div align='right'>"+quantity+"</div>";
		
			                        var cell9 = row.insertCell(8);
			                        cell9.innerHTML =  "<div align='left'>"+specification+"</div>";
	                        }
	                        else
		                        alert("!!! ERROR while adding data to GRID due to Server Side problem. Please try again.");
	                        

	                        
	                }
	         
	         }
	    	
	       	document.getElementById("purchaseEntry").style.visibility="hidden"; 
	
}
      

function getCompanies()
{
		//alert("TYYYYYYY");
		
document.getElementById('companyList').style.visibility = 'visible';
			var company=document.purchaseDetails.companyNames.value;

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
				
			}
			else
			{
				document.getElementById('companyList').style.visibility = 'visible';
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
			var queryString = "?company=" +company;
			/*  ajaxRequest.open("GET", "AjaxGetCustomerList.jsp" + queryString, true); */
			ajaxRequest.open("GET", "AjaxGetCustomer.jsp" + queryString, true);
			ajaxRequest.send(null);

			}//end of else 
		
}
		

//////
function addRowForSupplier(suppliercode,tableID,suppliername) 
{
//	alert("IN TABLE  ");
	
	document.purchaseDetails.supplier.value=document.purchaseDetails.supplier.value+","+suppliername;
	document.getElementById('companyList').style.visibility = 'hidden';

    var table = document.getElementById(tableID);
   // alert("11111  ");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    
    //var cell1 = row.insertCell(0);
   // var element1 = document.createElement("input");
    //element1.type = "checkbox";
    //cell1.appendChild(element1);
    
    var cell2 = row.insertCell(0);
    cell2.innerHTML = suppliername;
 //   alert("after table   ");
    if(listTable==null)
    {
    	listTable=suppliername;
    }
    else
    {
    	listTable=listTable+","+suppliername;
    	
    }
	
    /* alert(suppliername); */
    
}



</script>


<script>

function disable(v)
{
	if(v=="Hotel Expenses")
		{
		
		$("#origin").val('');
		$("#destination").val('');
	     document.getElementById("origin").readOnly='true';
	     document.getElementById("destination").readOnly='true';
		}
	else
		{
		
		document.getElementById('origin').removeAttribute('readonly');
		//document.getElementById("origin").contentEditable="true";
		document.getElementById('destination').removeAttribute('readonly');
		}
	
	 
	return true;
	
	
}


</script>

<script type="text/javascript">
function makereset()
{

	document.getElementById("search-text").value='';
}


</script>




<script>

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
	
	
	return chk();
	
	
	
}

</script>


<script type="text/javascript">

function welcome1()
{
	var v=document.getElementById("amount1").value;
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
	
	
	return true;
	
	
	
}

</script>






</head>


<style>
#myProgress {
  width: 100%;
  background-color: #ddd;
}

#myBar {
  width: 0%;
  height: 30px;
  background-color: #4CAF50;
  text-align: center;
  line-height: 30px;
  color: white;
}
</style>
<style type="text/css">

.suggestionsBox {

left: 260px;
margin: 0px 0px 0px 0px;
width: 200px;
background-color: #7845DD;
-moz-border-radius: 7px;
-webkit-border-radius: 7px;
border: 2px solid #000;
color: #fff;
}
.suggestionList {
margin: 0px;
padding: 0px;
}
.suggestionList li {
margin: 0px 0px 3px 0px;
padding: 3px;
cursor: pointer;
}
.suggestionList li:hover {
background-color: #DD45CD;
}
</style>



<body>


<%!
Connection con1;


%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con1.createStatement();
Statement st5=con1.createStatement();
%>

<%


String dept=session.getAttribute("department").toString();

System.out.println("---->"+dept);


String selected=request.getParameter("status");

System.out.println("--------"+selected);

String datex1, datex2, data1, data2;
String ddx = request.getQueryString();

if (ddx == null) {
	
	System.out.println(" In First If  " );
	
	datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new java.util.Date());
	
		
	data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new java.util.Date());

	Calendar c = Calendar.getInstance();   // this takes current date
    c.set(Calendar.DAY_OF_MONTH, 1);
    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());


} else {
	
	System.out.println(" In First Else  " );
	
	data1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data")));
	data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data1")));
	
	
	

	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");
	
}

String Bt=request.getParameter("button");
System.out.println(" Button :- " +Bt);

if(Bt==null || Bt==" " || Bt=="")
{
	datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
	.format(new java.util.Date());
data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new java.util.Date());

Calendar c = Calendar.getInstance();   // this takes current date
c.set(Calendar.DAY_OF_MONTH, 1);
System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
	
}
else
{
	data1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data")));
data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data1")));




datex1 = request.getParameter("data");
datex2 = request.getParameter("data1");
}

System.out.println(" datex1 "+datex1+" datex2 "+datex2);


String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex2));

System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);

%>















<div class="form">
      
      <ul class="tab-group">
        <li class="tab active"><a href="#people">Salary Advance</a></li>
        <li class="tab "><a href="#material">Travel Advance</a></li>
      </ul>
      
      <div class="tab-content">
      
  <!-- People Movement -->    
        <div id="people">
          
          <form class="people" role="form" method="post" onsubmit=" return welcome1();"  action="AdvanceMoneyRequest.jsp">
          
          <div class="top-row">
            
            <input type="hidden" name="entryby" id="entryby" value="<%=session.getAttribute("fname") %>" readonly="readonly"/>  
            <input type="hidden" required style="color: black;"  name="type" id="type"  value="Salary" readonly="readonly"/>
           <input type="hidden" name="TypeValue" id="TypeValue" value="<%=session.getAttribute("usertypevalue") %>" readonly="readonly"/>  
           
   
           
			<%-- 
			<div class="field-wrap">
           <font color="red"> *</font>Department  
            <input type="text" name="Department" id="Department" required style="color: black; align-content: relative;"  placeholder="Department"/>
          </div>
			
          <div class="field-wrap">
           <font color="red"> *</font>OnBehalfOf
           
           <select id="status" name="bhalf" style="width:150px; height: 30px;"  class="element select medium">
								
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
           
           <!--   <input type="text" name="RequesterCompanyName" id="RequesterCompanyName" required style="color: black; align-content: relative;"  placeholder="OnBehalfOf"/> -->
          </div>
 --%>          
           <div  class="field-wrap">
          </div>       
            
      </div>
           
          <div class="top-row">
          

         
         
          
         
           </div>
           <div class="top-row">
          <div class="field-wrap">
          <font color="red"> *</font>Amount
            <input type="text" required="required" onblur="return welcome1();" style="color: black;" size="16" name="amount1" id="amount1" value="" >
	
            </div>
         
          
          <div class="field-wrap">
            <font color="red"> *</font>Purpose  
          <!--    <input type="text"required style="color: black;" value=""  name="RequesterName" id="RequesterName" placeholder="Name of Requester"/>
          -->   
 <!--  <input type="text" required="required" style="color: black;" value="" pattern="[A-Za-z\s]*" title="Enter Only Characters" name="RequesterName"  id="RequesterName" placeholder="Purpose"/> -->
      <textarea  required="required" name="purpose1" id="purpose1" rows="5" cols="5" style="color: black; "></textarea>
         	 </div>
          <div class="field-wrap">
           
          </div>
           
          </div>  
         <!--  <div class="top-row">
         <div  class="field-wrap"> 
          <font color="red"> *</font>Mode <br>
            <select id="mode" name="mode" required="required">
            <option id="mode" value="Mode">Select</option>
            <option id="mode" value="shared">Shared</option>
            <option id="mode" value="dedicated">Dedicated</option>
          	</select>          
          </div>
         
          <div class="field-wrap">
            <font color="red"> *</font>Quantity  
            <input type="text"required style="color: black;" pattern="[0-9\s]*"  name="quantity" id="quantity" placeholder="Enter Quantity"/>
          </div>
           
          <div  class="field-wrap"> 
          <font color="red"> *</font>SKU  <br>
           <select id="sku" name="sku"> <option id="sku" value="sku">Select</option>
            <option id="sku" value="Number">Number</option>
           
          	</select>          
          </div>
          </div> -->
          
           <div id="myProgress" style="display: none;">
  				<div id="myBar">0%</div>
			</div>
          <div align="right">
          <button type="submit" class="button button-block" onclick="move()" >Submit Request</button>
          </div>
         
          </form>
<div style="height: 0px; width: 250px;">
Note : (<font color="red">*</font>) Fields are Mandatory Fields.
</div>
        </div>
  
  <!-- Material Movement -->
        
        
  
        
        
        
        <div id="material">   
        
        
        
        
        
        
        
        
        
        
        
        
      <form class="material"  name="purchaseDetails"role="form" method="post" onsubmit=" return welcome();"  action="AdvanceMoneyRequest.jsp">
          <fieldset>
          <legend><font size=3>Travel Data</font></legend>
          <div class="top-row">
            
            <input type="hidden" name="entryby" id="entryby" value="<%=session.getAttribute("fname") %>" readonly="readonly"/>  
              <input type="hidden" required style="color: black;"  name="type" id="type"  value="Travel" readonly="readonly"/>
          <input type="hidden" name="TypeValue" id="TypeValue" value="<%=session.getAttribute("usertypevalue") %>" readonly="readonly"/>  
           
   
            <div class="field-wrap">
             <font color="red"> *</font>Persons Travel
             <input type="text"required style="color: black;" value="" pattern="[0-9\s]*" title="Enter Only digit" name="pTravel" id="RequesterName"/>
           <!--  <input type="text"required style="color: black;" value=""  name="RequesterName" id="RequesterName" placeholder="Name of Requester" onkeyup="lookup(this.value);" onblur="fill();"/>
 -->            <div class="suggestionsBox" id="suggestions" style="display: none;">
			<div class="suggestionList" id="autoSuggestionsList">
         	</div></div>
         	 </div>
			
			 
			
        
          
           <div  class="field-wrap">
           <font color="red"> *</font>Purpose
            <input type="text" name="purpose" id="purpose" required style="color: black; width: 150px; align-content: relative;"  />
          </div>
          
          <div  class="field-wrap">
           <font color="red"> *</font>Cost Center
          <select   id="Status" name="costcenter"  style="width: 125px; font-size: 12px; color:black;Arial; height: 27px;" >
           
    <option value="Fleetview">FleetView</option>
    <option value="SmartGrid">SmartGrid</option>
    <option value="GlobalERP">GlobalERP</option>
    
          </select>
           
        <!--  <input type="text" name="address" id="address" required style="color: black; width: 150px; align-content: relative;"  placeholder="Cost Center"/> --> 
          </div>
         
          <div  class="field-wrap">
			 
				  <font color="red"> *</font>Select Customer

  <table align="center" width="80%" border="0" style="background-color: white;" cellpadding="0" cellspacing="0">
  <tr>
 
  
  	<td  valign="top" >
  	 							<div id="companyNames" > 
								<input type="text" name="companyNames" id="search-text"  style="width: 150px;" 
									onkeyup="getCompanies()" onblur="makereset()" /></div>
	
	
							<div id='companyList' style="width: 350px;position: relative;" >
							</div>

	</td>
	
    <td  valign="top">
    
         
   
    </td>
 <input type="hidden" name="supplier" id="supplier" value="" style="font-color: red;"/></td>
  </tr>
   </table>
 <div id='itemDescription' style="margin-left: 14%;background-color: white;width: 76%;"></div> <br>
 <br>

 <br>
     <div id="purchaseEntry" style="position:absolute;margin-left:330px ;margin-top:40px;background-color:White;border:solid thin black;">
</div>
			  
			  
			  </div>
          
 
           <div>
          
             <table id="listTable" border='0' valign="top" align="left"   style="background-color: White; font-size:14px; width: 200%; border: 1em; ">
          <div><font color="red" size="1"> *</font>List Of Customer</div>
          
  	
		 <tr>
		
		 </tr>
		 
		 </table>
       </div> 
          
 
 </div>
 
 		
 		
 		 <div class="top-row">
            <div class="field-wrap">
             <font color="red"> *</font> Departure Date	
             <input type="text" id="data" height="10px" name="data" value="<%=datex1%>" size="13px" readonly  class="element text medium" style="width: 125px; font-size: 12px; height: 27px; color:black"  /> 
			 <script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "data"       // ID of the button
			    }
			  );
			
			  
			  </script>
            
            <!-- <font color="red"> *</font> Departure Date	
			<input type="text" style="color: black;" size="16" name="pickup_date" id="pickup_date" placeholder="Departure Date"> -->
				
		</div> 
            <div class="field-wrap">
            <font color="red"> *</font>Return Date
            
            <input type="text" id="data1" name="data1" value="<%=datex2%>" size="13px" readonly   class="element text medium" style="width: 125px;font-size: 12px; height: 27px; color:black"  onblur="return chk()"/> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script>
           <!--  <input type="text"required style="color: black;"  name="drop_date" id="drop_date" placeholder="Return Date"/> -->
          </div>
          
          
          <div class="field-wrap">
            <font color="red"> *</font>Comments
         <!--    <input type="text"required style="color: black;"  name="drop_date" id="drop_date" placeholder="Comment"/> -->
           <textarea  name="comments" id="comments" rows="2" cols="1"  style="color: black;  width:125px;  " >
                  </textarea>
          </div>
          
          
          
     
           
       </div>
           
         </fieldset>
         
         
         
         
         
         
       
          
          
          
          
          
        
          
           
           <br></br>
           <fieldset>
           
         <legend>  <font size="4">Anticipated Expense</font></legend>
               <div class="top-row">
            <div class="field-wrap">
          <font color="red"> </font> <br>
           <button type="button"  id="btnAdd" value="+"  >+</button>
               <button type="button"  id="btnrm" value="-"  Style="Visibility:hidden" >-</button>
     
          </div>
          
   </div>
           
           
            <div id="clone">
   
        </div>
        
           
           <div id="auto" class="top-row">
          
       
       <div class="field-wrap">
            <font color="red"></font>Type of expense
          <select id="TypeOfExpense" name="TypeOfExpense"  onchange="disable(this.value)" style="width: 125px; font-size: 12px; color:black;Arial; height: 27px;"> 
          
          <option value="Journey Fare">Journey Fare</option>
          <option value="Hotel Expenses">Hotel Expenses</option>
          <option value="Other">Other</option>
          
          </select>
            
          </div>
          
       
       
       
          
          <div class="field-wrap">
            <font color="red"> *</font>Mode <br>
          <select id="Status" name="mode"  style="width: 125px; font-size: 12px; color:black;Arial; height: 27px;"> 
          
          <option value="Bus">Bus</option>
          <option value="Train">Train</option>
          <option value="Other">Other</option>
          
          </select>
            
          </div>
           
         
          
          
          
          <div class="field-wrap">
            <font color="red"> *</font>Origin 
            <input type="text"required style="color: black;"  name="origin" id="origin" />
          </div>
          <div class="field-wrap">
            <font color="red"> *</font>Destination  
            <input type="text"required style="color: black;  width: 150px;"  name="destination" id="destination" />
          </div>
         
         <div class="field-wrap">
         
            <font color="red"> *</font>Amount 
            <input type="text"required style="color: black;"  name="amount" id="amount" />&nbsp;
          

          </div>
          
          
          
                      
            </div>
            
        
        
      
        
        
          
        </fieldset> 
	
            
          
           
 
          
            
          
    
        
        
        
         
        
         
         
         <!--   <div class="top-row">
          <div class="field-wrap">
            <font color="red"> *</font>GetValues  
            <input type="text"required style="color: black;"  name="ProductName" id="ProductName" placeholder="Product Name"/>
          </div>
          
         <div  class="field-wrap"> 
          <font color="red"> *</font>Mode  <br>
            <select id="mode" name="mode"><option id="mode" value="Mode">Select</option>
            <option id="mode" value="shared">Shared</option>
            <option id="mode" value="dedicated">Dedicated</option>
          	</select>          
          </div>
         
          <div class="field-wrap">
            <font color="red"> *</font>Quantity  
            <input type="text"required style="color: black;" pattern="[0-9\s]*" title="Select Only Number"  name="quantity" id="quantity" placeholder="Enter Quantity"/>
          </div>
           
          <div  class="field-wrap"> 
          <font color="red"> *</font>SKU  <br>
            <select id="sku" name="sku" required="required"><option id="sku" value="sku">Select</option>
            <option id="sku" value="Number">Number</option>
            <option id="sku" value="Number">Litre</option>
            <option id="sku" value="KG">KG</option>
            <option id="sku" value="TON">Ton</option>
            <option id="sku" value="Number">Gallon</option>
          	</select>          
          </div>
          </div> --> 
          
           <div id="myProgress" style="display: none;">
  				<div id="myBar">0%</div>
			</div>
          <div align="right">
          <button type="submit" class="button button-block" onclick="move()" >Submit Request</button>
          </div>
         
          </form>
          <div style="height: 0px; width: 250px;">
Note : (<font color="red">*</font>) Fields are Mandatory Fields.
</div>
        </div>
        
      </div><!-- tab-content -->
      
</div> 

<!-- /form -->
 <script  src="js/indexclaim.js"></script> 
<!-- <script type="text/javascript" src="js/bootstrap.min.js"></script> -->
<!-- <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

  


<script type="text/javascript" src="js/jquery-1.8.3.min.js" charset="UTF-8"></script>
 -->



</body>
<br><br>



</html>
<%@ include file="footer_new.jsp"%>
<%-- <%@ include file="footernew.jsp"%> --%>