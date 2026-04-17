<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>

<%
String supp="?";
Connection conn = null;
Statement st1=null,st2=null,st3=null;

String selectedName="", FollowUpType = "";
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

	if(request.getParameter("searchBy")!=null)
		if(request.getParameter("searchBy").equalsIgnoreCase("Supplier"))
		supp=request.getParameter("supplier");
%>
<body style="background-color:azure;" onload="showVisitingCard('<%=supp %>')">
	<%
	try {

		conn = connection.getConnect("db_leaveapplication");    
		st1 = conn.createStatement();
	    st2 = conn.createStatement();
	    st3 = conn.createStatement();

	} catch (Exception e) {
	    e.printStackTrace();
	} 
			
	String monthFirstDate = session.getAttribute("onemonthback").toString();  
	String todaysDate = session.getAttribute("today").toString(); 			
	%>
	<%
			if(request.getParameter("data")!=null)
			{
				datex1=request.getParameter("data");
				datex2=request.getParameter("data1");
			}else {
				datex1 = monthFirstDate;
				datex2 = todaysDate;
			}
	%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Inward Global Search</h5>
    </div>
</div>	
<form name='itemSearch' action="GlobalSearch_1.jsp" method="get" >
  <div class="row col-12">
  <div class="col-md-1"></div>
            <div class="col-md-2">
    <label class="form-label fw-bold d-block">Status</label>

    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="searchBy" id="statusAll"
               value="All" checked onclick="hideOptions()">
        <label class="form-check-label" for="statusAll">All</label>
    </div>

    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="searchBy" id="statusChecked"
               value="Checked" onclick="hideOptions()">
        <label class="form-check-label" for="statusChecked">Checked</label>
    </div>

    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="searchBy" id="statusUnchecked"
               value="Unchecked" onclick="hideOptions()">
        <label class="form-check-label" for="statusUnchecked">Unchecked</label>
    </div>
</div>

    	 		<div class="col-md-2">
				  <label for="dropdown"><b>Type</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="rd" name="rd">
			               	<option value="all">All</option>
					 		<option value="bill">Bill</option>
					 		<option value="doc">Document</option>
			               </select>
			               <script>
    const mySel = document.getElementById("rd");

    // On page load
    const savedValue = localStorage.getItem("selValue");

    if (!savedValue) {
        mySel.value = "Select";   // default
    } else {
        mySel.value = savedValue; // restore
    }

    // Save on change
    mySel.addEventListener("change", function () {
        localStorage.setItem("selValue", this.value);
    });
</script>

			           </div>
			           
			           
			    </div>
    		<div class="col-md-2" id="saerchbox">
                <label for="input"><b>Search</b></label>
                <input class="form-control form-control-sm" type="text" id="item" name="item" value="" onkeyup="timer(1)">
			 </div>
    	
    	<div class="col-md-1" style="width: 30px;">
		    <label class="form-label fw-bold d-block">All</label>
		    <div class="form-check">
		        <input class="form-check-input" type="checkbox" name="all" id="all" value="all" checked="checked" onchange="timer(1)">
		    </div>
    </div>		
    
    		<div class="col-md-2" id="frmdt">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  onmousedown="unCheckAll();" onchange="timer(1)" class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todt">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  onmousedown="unCheckAll()" onclick="timer(1)" onchange="timer(1)" class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
    	
    		<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="submit" value="Submit" style="visibility: hidden;">
			</div>
		
   			<input type="hidden" name="supplier" id="supplier" value="supplier" />
   			<input type="hidden" name="counter" id="counter" value="10" />
			<input type="hidden" name="supplierData" id="supplierData" value="supplierData" />
			 <input type="hidden" name="itemDescriptioncopy" id="itemDescriptioncopy" /> 	
	</div>	
</form>
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
	 
	  <center><span id="wait" style="display: none;"><font color="red">Please Wait...</font> </span></center>
	 
	 <input type="hidden" name="itemDescriptioncopy" id="itemDescriptioncopy" />
	 
	 <div id="itemDescription" style="overflow:auto;height: auto; width: 100%;background-color: white; ">
			<div style="height: 100%; width: 100%; overflow: auto;">
			
			</div>
			
			</div>
			<br><br><center><span id="wait1" style="display: none;"><font color="red"> Please Wait... </font></span></center>
			
</div>
 <script type="text/javascript">
		function showPO(no,search){
		window.open('PODetails.jsp?transactionId='+no+'&condition=null');
		
	}
	function showPI(no,search,supplier){
		window.open('PEDetails.jsp?transactionId='+no+'&condition=null&supplier='+supplier);
	}
	function showPE(no,search,supplier){
		window.open('PQDetails.jsp?transactionId='+no+'&condition=null');
	}
	function showPurIn(no,search){
		window.open('PIDetails.jsp?transactionId='+no+'&condition=null');
	}
	function showSO(no,search){
		window.open('viewOrder.jsp?salesOrder='+no+'&condition=View');
	}
	function showSQ(no,search){
		window.open('viewQuotation.jsp?salesQuotation='+no+'&condition=View');
	}
	function showSE(no,search){
		window.open('SEDetails.jsp?company=&transactionId='+no+'&condition=View');
	}
	function showSI(no,no1,search){
		window.open('viewInvoice.jsp?InvoiceRefNo='+no+'&Invoiceno='+no1+'&condition=View');
	}
	function showSPI(no,no1,search){
		window.open('detailForProInvoice.jsp?InvoiceRefNo='+no+'&Invoiceno='+no1+'&condition=View');
	}
			
	function popUpSupplier(webadd,itemDesc,itemCode,tableToBeAccessed,makecode)
	{ 
			window.open(webadd+'?itemDesc='+itemDesc+'&itemCode='+itemCode+'&tableToBeAccessed='+tableToBeAccessed+'&makecode='+makecode,'jav','width=870,height=500,top=150,left=250,resizable=yes');
	}

	function hideRows(){
		alert(document.getElementById("tr2"));
		document.getElementById("tr2").style.display="none";
		}
function showSupplier(supplierCode,supplierName)
{
	document.getElementById("visitingCard").style.visibility="visible";
	document.itemSearch.item.value=supplierName;
	document.getElementById("itemDescription").style.visibility="hidden";
	document.itemSearch.supplier.value=supplierCode;

	var searchBy;
	for (var i=0; i < document.itemSearch.supplierReport.length; i++)
	   {
	   if (document.itemSearch.supplierReport[i].checked)
	      {
		   searchBy = document.itemSearch.supplierReport[i].value;
	      }
	   }
	document.itemSearch.supplierData.value=searchBy;


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
            var mySplitResult = reslt.split("#");
            document.getElementById("supplierName").innerHTML=mySplitResult[0];
            document.getElementById("contactPerson").innerHTML=mySplitResult[1];
            document.getElementById("address").innerHTML=mySplitResult[2];
            document.getElementById("phoneNo").innerHTML=mySplitResult[3];
            document.getElementById("city").innerHTML=mySplitResult[4];
            document.getElementById("email").innerHTML=mySplitResult[5];
            document.getElementById("supplierProduct").innerHTML=mySplitResult[6];
            document.getElementById("supplierCategory").innerHTML=mySplitResult[7];
            document.getElementById("supplierFax").innerHTML=mySplitResult[8];
            document.getElementById("supplierWebsite").innerHTML=mySplitResult[9];
 
		} 
	}
	
	var queryString = "?supplierCode=" +supplierCode;
	ajaxRequest.open("GET", "AjaxGetSupplierVisitingCard.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
 function showVisitingCard(supplierCode)
 {
	
		var v=document.getElementById("itemDescriptioncopy").value; 
		//alert(v);
		document.getElementById("itemDescription").innerHTML=v; 
	 if(supplierCode!='?')
	 {
	 document.getElementById("visitingCard").style.visibility="visible";
		var searchBy;
		for (var i=0; i < document.itemSearch.supplierReport.length; i++)
		   {
		   if (document.itemSearch.supplierReport[i].checked)
		      {
			   searchBy = document.itemSearch.supplierReport[i].value;
		      }
		   }
		document.itemSearch.supplierData.value=searchBy;

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
	            var mySplitResult = reslt.split("#");
	            document.getElementById("supplierName").innerHTML=mySplitResult[0];
	            document.getElementById("contactPerson").innerHTML=mySplitResult[1];
	            document.getElementById("address").innerHTML=mySplitResult[2];
	            document.getElementById("phoneNo").innerHTML=mySplitResult[3];
	            document.getElementById("city").innerHTML=mySplitResult[4];
	            document.getElementById("email").innerHTML=mySplitResult[5];
	            document.getElementById("supplierProduct").innerHTML=mySplitResult[6];
	            document.getElementById("supplierCategory").innerHTML=mySplitResult[7];
	            document.getElementById("supplierFax").innerHTML=mySplitResult[8];
	            document.getElementById("supplierWebsite").innerHTML=mySplitResult[9];
	 
			} 
		}
		
		var queryString = "?supplierCode=" +supplierCode;
		ajaxRequest.open("GET", "AjaxGetSupplierVisitingCard.jsp" + queryString, true);
		ajaxRequest.send(null); 
	 }	 
	 else
		 document.getElementById("visitingCard").style.visibility="hidden";
 }

function unCheckAll()
{
	document.itemSearch.all.checked=false;
	timer(1);
}


function frmSubmit(make,group,item,itemName,makeName,part)
{
	
	 var fromDate=document.itemSearch.data.value;
	 var toDate=document.itemSearch.data1.value;
	 var all=null;
	 if(document.itemSearch.all.checked==true)
		 all="all";
	window.location='?all='+all+'&fromdate='+fromDate+'&todate='+toDate+'&purchaseDetails=purchaseDetails&make='+make+'&group='+group+'&itemCode='+item+'&itemName='+itemName+'&makeName='+makeName+'&part='+part;
}


function showOptions()
{
	document.getElementById("options").style.display="block";
	document.itemSearch.submit.style.visibility="visible";
}

function hideOptions()
{
	document.getElementById("options").style.display="none";
	document.itemSearch.submit.style.visibility="hidden";
	document.itemSearch.item.value="";
}


	 
function showItemDetails(item,searchBy)
{
	window.location="?item="+item+"&searchBy="+searchBy;
	
}
function timer1(count){
	document.getElementById("wait1").style.display="";
	setTimeout("timer("+count+")", 10);
}
function timer(count){
	document.getElementById("wait").style.display="";
	setTimeout("fun("+count+")", 3000);
}	
 function fun(num){

	 var item=document.itemSearch.item.value;
	var searchBy;

	 for (var i=0; i < document.itemSearch.searchBy.length; i++)
	   {
	   if (document.itemSearch.searchBy[i].checked)
	      {
		   searchBy = document.itemSearch.searchBy[i].value;
		   
	      }
	   }
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

			
			document.getElementById("itemDescription").innerHTML=reslt;
			document.getElementById("itemDescriptioncopy").value=reslt;
			document.getElementById("wait").style.display="none";
			document.getElementById("wait1").style.display="none";
			ajaxRequest.abort();
			ajaxRequest.abort();
		} 
	}
	var counter=document.getElementById("counter").value;
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
 	var fromdate=document.getElementById("data").value;
 	var todate=document.getElementById("data1").value;
 	var rd=document.getElementById("rd").value;

 	var all=document.getElementById("all").checked;;
 	//alert(fromdate+"--"+todate+all);
	++num;
	//alert("nnnn"+num);
	var queryString = "?&limitcount="+num+"&item=" +item+"&rd="+rd+"&searchBy="+searchBy+"&fromdate="+fromdate+"&todate="+todate+"&all="+all;
	ajaxRequest.open("GET", "inwardglobalajax.jsp" + queryString, true);
	ajaxRequest.send(null); 

	document.getElementById("itemDescription").style.visibility="visible";


	}
	function getItems()
	{
		
		var item=document.itemSearch.item.value;

		var searchBy;
		for (var i=0; i < document.itemSearch.searchBy.length; i++)
		   {
		   if (document.itemSearch.searchBy[i].checked)
		      {
			   searchBy = document.itemSearch.searchBy[i].value;
		      }
		   }

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
				alert("krn");
				var reslt=ajaxRequest.responseText;
				document.getElementById("itemDescription").innerHTML=reslt;
				alert(reslt);
				ajaxRequest.abort();
				alert(ajaxRequest.abort());
			} 
		}
		
		var queryString = "?item=" +item+"&searchBy="+searchBy;
		ajaxRequest.open("GET", "AjaxGetItemList.jsp" + queryString, true);
		//ajaxRequest.send(null); 
		document.getElementById("itemDescription").style.visibility="visible";
	
	}
	 
	if (document.all || document.getElementById)
    function popUp(Address,id,type,companyName)
    { 
        if(type=="PO")
                    window.open(Address+'?companyName='+companyName+'&PONo='+id,'jav','width=870,height=700,top=150,left=250,resizable=yes,scrollbars=yes');
        else
            window.open(Address+'?companyName='+companyName+'&InvoiceNo='+id,'jav','width=870,height=700,top=150,left=250,resizable=yes');
    }

    function addSupplier()
    {
            //alert("asfagsdbdn");
       window.open("addNewSupplier.jsp",'jav');
            }
</script>
<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Inward Global Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Inward Global Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Inward Global Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Inward Global Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Inward Global Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
</body>
<%@include file="footer.jsp" %>
</html>