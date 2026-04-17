<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="header.jsp"%>
 <jsp:useBean id="erp1" class="com.erp.beans.ERP" scope="page">
 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
	<script type="text/javascript">
		function showPO(no,search){
		//alert(no);alert(search);
		//PODetails.jsp?transactionId=5557&condition=null
		window.open('PODetails.jsp?transactionId='+no+'&condition=null');
		
	}
	function showPI(no,search,supplier){
		//alert(no);alert(search);
		//PODetails.jsp?transactionId=5557&condition=null
		window.open('PEDetails.jsp?transactionId='+no+'&condition=null&supplier='+supplier);
		
	}
	function showPE(no,search,supplier){
		//alert(no);alert(search);
		//PQDetails.jsp?transactionId=2558&condition=null
		window.open('PQDetails.jsp?transactionId='+no+'&condition=null');
	}
	function showPurIn(no,search){
		//alert(no);alert(search);
		//PIDetails.jsp?transactionId=2556&condition=null
		window.open('PIDetails.jsp?transactionId='+no+'&condition=null');
	}
	function showSO(no,search){
		//alert(no);alert(search);
		//viewOrder.jsp?salesOrder=6717&condition=View
		window.open('viewOrder.jsp?salesOrder='+no+'&condition=View');
	}
	function showSQ(no,search){
		//alert(no);alert(search);
		//viewQuotation.jsp?salesQuotation=10631&condition=View
		window.open('viewQuotation.jsp?salesQuotation='+no+'&condition=View');
	}
	function showSE(no,search){
		//alert(no);alert(search);
		//SEDetails.jsp?company=&transactionId=SE300515001&condition=View
		window.open('SEDetails.jsp?company=&transactionId='+no+'&condition=View');
	}
	function showSI(no,no1,search){
		//alert(no);alert(search);
		//viewInvoice.jsp?InvoiceRefNo=SI260615001&Invoiceno=16365&condition=View
		window.open('viewInvoice.jsp?InvoiceRefNo='+no+'&Invoiceno='+no1+'&condition=View');
	}
	function showSPI(no,no1,search){
		//alert(no);alert(search);
		//detailForProInvoice.jsp?InvoiceRefNo=SP020615001&Invoiceno=2087&condition=View
		window.open('detailForProInvoice.jsp?InvoiceRefNo='+no+'&Invoiceno='+no1+'&condition=View');
	}
		
	
	
			
	function popUpSupplier(webadd,itemDesc,itemCode,tableToBeAccessed,makecode)
	{ 
		//alert("1");	
	
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
	
	 var fromDate=document.itemSearch.fromdate.value;
	 var toDate=document.itemSearch.todate.value;
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
	//alert("KK--"+count);
	document.getElementById("wait1").style.display="";
	setTimeout("timer("+count+")", 10);
}
function timer(count){
	document.getElementById("wait").style.display="";
	setTimeout("fun("+count+")", 3000);
}	
 function fun(num){
// 	 document.getElementById("wait").style.display="";
// 	 document.getElementById("wait1").style.display="";
	 var item=document.itemSearch.item.value;
	/*  if(item==""){
		 document.getElementById("itemDescription").innerHTML="";
	 } */
	 
	var searchBy;

	// alert(item);
	 
	 for (var i=0; i < document.itemSearch.searchBy.length; i++)
	   {
	   if (document.itemSearch.searchBy[i].checked)
	      {
		   searchBy = document.itemSearch.searchBy[i].value;
	      }
	   }
	//alert(searchBy);
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
			//alert(reslt);
			document.getElementById("wait").style.display="none";
			document.getElementById("wait1").style.display="none";
			ajaxRequest.abort();
			ajaxRequest.abort();
			//alert("lklklk");
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
	
 	var fromdate=document.getElementById("fromdate").value;
 	var todate=document.getElementById("todate").value;
 	var all=document.getElementById("all").checked;;
 	//alert(fromdate+"--"+todate+all);
	++num;
	//alert(num);
	var queryString = "?&limitcount="+num+"&item=" +item+"&searchBy="+searchBy+"&fromdate="+fromdate+"&todate="+todate+"&all="+all;
	ajaxRequest.open("GET", "AjaxGetItemList_Global.jsp" + queryString, true);
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
alert("kkkk");
		document.getElementById("itemDescription").style.visibility="visible";
	
	}
	 
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat ";
	


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

<%
String supp="?";
	if(request.getParameter("searchBy")!=null)
		if(request.getParameter("searchBy").equalsIgnoreCase("Supplier"))
		supp=request.getParameter("supplier");
%>
<body onload="showVisitingCard('<%=supp %>')">
	 
	<%
		erp1.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
	java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
	
			Connection conn1 = null;
			Statement st_1 = null, st1_1 = null;
			Statement st2_1 = null;
			String selectedName;
			String FollowUpType = "";
	%>
	<%
		String fromDateCal_1 = "", toDateCal_1 = "",sql="";
			fromDateCal_1 = toDateCal_1 = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new java.util.Date());
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date result = cal.getTime();
			fromDateCal_1 = new SimpleDateFormat("dd-MMM-yyyy").format(result);
			System.out.println("--<<>>"+fromDateCal_1);
			if(request.getParameter("fromdate")!=null)
			{
				fromDateCal_1=request.getParameter("fromdate");
				toDateCal_1=request.getParameter("todate");
				
			}
			System.out.println("--<<>>"+fromDateCal_1);
			try {
				conn1 = erp1.ReturnConnection();
				st_1 = conn1.createStatement();
				st1_1 = conn1.createStatement();
				st2_1 = conn1.createStatement();
			} catch (Exception e) {
				e.printStackTrace();
			}
 
	%>
	<div
		style="font-size: 1.8em; text-align: center; " ><a> 

		  Global Search</a>
 </div>

<form name='itemSearch' action="GlobalSearch_1.jsp" method="get" >
<!-- <table >
<tr>
	<td>Category :</td>
	
	<td><input type="radio" name="searchBy" value="PO" checked="checked" onclick="hideOptions()" />PO</td>
	<td><input type="radio" name="searchBy" value="Item"  onclick="hideOptions()" />Desc                                          </td>
	<td><input type="radio" name="searchBy" value="Company" onclick="hideOptions()"/>Make                                                      </td>
	<td><input type="radio" name="searchBy" value="Model" onclick="hideOptions()" />Model                                                          </td>
	<td><input type="radio" name="searchBy" value="Part" onclick="hideOptions()"/>Part                                                            </td>
	<td><input type="radio" name="searchBy" value="Supplier" onclick="showOptions()" />Supplier                       </td>
	<td> <input type="submit" name="AddSupplier"  style="border: outset; visibility: hidden;" value="Add Supplier" onclick='addNewSupplier.jsp'></input></td>
	<td align="right" rowspan="6" style="height: 30px;" valign="top">
    <a href="#" ><input type="button" onclick="addSupplier()"
                                              style="font-size:small; color: black; background-color: #C6DEFF;border-style: outset"
                                                name="addsupplier" value="Add Supplier" /></a>
</td>
</tr>

</table>
 -->


<table  align="center" border="1" cellspacing="0" style="border-color: rgb(74, 76, 219);"><tr><td>
<table  width="100%" >
<tr>
<td colspan="3" align="left">
<table>

<tr>
<td>Category :</td>
<td><input type="radio" name="searchBy" value="cust"  checked="checked" onclick="hideOptions()" />Customer</td>
<td><input type="radio" name="searchBy" value="pros"  onclick="hideOptions()" />Prospects</td>
</tr>
<tr>
	
	<td></td>
	<td><input type="radio" name="searchBy" value="Item"  onclick="hideOptions()" />Desc                                          </td>
	<td><input type="radio" name="searchBy" value="Company" onclick="hideOptions()"/>Make                                                      </td>
	<td><input type="radio" name="searchBy" value="Model" onclick="hideOptions()" />Model                                                          </td>
	<td><input type="radio" name="searchBy" value="Part" onclick="hideOptions()"/>Part                                                            </td>
<!-- 	<td><input type="radio" name="searchBy" value="Supplier" onclick="showOptions()" />Supplier                       </td> -->
	<!-- <td> <input type="submit" name="AddSupplier"  style="border: outset; visibility: hidden;" value="Add Supplier" onclick='addNewSupplier.jsp'></input></td> -->
</tr>

<tr>
	<td></td>	
	<td><input type="radio" name="searchBy" value="PO" onclick="hideOptions()" />Purchase Order</td>
	<td><input type="radio" name="searchBy" value="PI" onclick="hideOptions()" />Purchase Enquiry</td>
	<td><input type="radio" name="searchBy" value="PQ" onclick="hideOptions()" />Purchase Quotation</td>
	<td><input type="radio" name="searchBy" value="PIn" onclick="hideOptions()" />Purchase Invoice</td>
	
</tr>
<tr>
<td></td>
<td><input type="radio" name="searchBy" value="SO"  onclick="hideOptions()" />Sales Order</td>
<td><input type="radio" name="searchBy" value="SE"  onclick="hideOptions()" />Sales Enquiry</td>
<td><input type="radio" name="searchBy" value="SQ"  onclick="hideOptions()" />Sales Quotation</td>
<td><input type="radio" name="searchBy" value="SI"  onclick="hideOptions()" />Sales Invoice</td>
<td><input type="radio" name="searchBy" value="SPI" onclick="hideOptions()" />Sales Proforma Invoice</td>
</tr>
<tr><td></td>
<td colspan="6"><font style="color: red; font-size: small;">&nbsp;&nbsp;(Do not add text while searching for Sales/Purchase Number)</font></td>
</tr>
</table>
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<!-- <td align="right" rowspan="6" style="height: 30px;" valign="top">
    <a href="#" ><input type="button" onclick="addSupplier()"
                                              style="font-size:small; color: black; background-color: #C6DEFF;border-style: outset"
                                                name="addsupplier" value="Add Supplier" /></a>
</td> -->
</tr>
<tr>
<td colspan="3">
			<div id="options" style="display: none;">
			<table >
				<tr>
					<td style="width: 290px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					<div id="pos" ><input
						type="radio" name="supplierReport" value="pos" checked="checked" />POs</div>
					</td>
					<td>
					<div id="pos" ><input
						type="radio" name="supplierReport" value="ledger" /> Ledger Account</div>
					</td>
				</tr>
			</table>
			</div>
			</td>
</tr>
		<tr>
			<td align="left" valign="top" >
		&nbsp;Search :</td>
			<td align="left" valign="top" >
			<div id="item" >
		 <input type="text" name="item" id="search-text" style="width: 235px;" value="" onkeyup="timer(1)"/></div>

			</td>
			<td align="left" style="width: 250px; overflow: auto;" rowspan="3">

			<!-- <div id='itemDescription' style="overflow: ">
			<div style="height: 90px; width: 400px; overflow: auto;">
			<table  style="display: none;">

			</table>

			</div>
			</div> -->
			</td>
			 

		</tr>
		<tr>

			<td align="left" valign="top" colspan="2">
 
			  <table border="0"><tr><td>
			<input type="checkbox" name="all" id="all" value="all" checked="checked" onchange="timer(1)"/></td><td>
			All </td><td>&nbsp;&nbsp;&nbsp;&nbsp;	</td>
			<td>
			 
			<input type="text" id="fromdate" onmousedown="unCheckAll();" onchange="timer(1)"
						name="fromdate" value="<%=fromDateCal_1 %>" size="15" readonly="readonly"
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script>
 </td><td valign="middle">
			<b>To </b></td><td>
			 <input type="text" id="todate" onmousedown="unCheckAll()" onclick="timer(1)" onchange="timer(1)"
						name="todate" value="<%=toDateCal_1 %>" size="15" readonly="readonly"
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "todate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "todate"       // ID of the button
			    }
			  );
			</script>
			</td><td>
						
			<input type="hidden" name="supplier" id="supplier" value="supplier" />
			<input type="hidden" name="supplierData" id="supplierData" value="supplierData" />
			 
			
	 <input type="submit" name="submit" id="submit" style="border: outset; visibility: hidden;"
				value="GO"></input></td>
				  </tr>
				 
				  </table>
				 </td>
		</tr>
		 
				 
		 <tr><td>
		 
		 </td></tr>
		  
	</table>
	</td>
<!-- 	<td valign="top"> -->
<!-- 	 <div id="visitingCard" style="visibility: hidden;"> -->
<!-- 		<table  width="100%" border="0" bgcolor="#C6DEFF" > -->
<!-- 			<tr> -->
<!-- 				<td><b>Supplier:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="supplierName"> </div> -->
<!-- 				</td> -->
<!-- 								<td><b>Contact:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="contactPerson"> </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td valign="top"><b>Address:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="address"> </div> -->
<!-- 				</td> -->
<!-- 								<td valign="top"><b>Phone:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="phoneNo"> </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td><b>City:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="city"> </div> -->
<!-- 				</td> -->
<!-- 								<td><b>Email:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="email"> </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td valign="top"><b>Product:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="supplierProduct"> </div> -->
<!-- 				</td> -->
<!-- 								<td><b>Category:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="supplierCategory"> </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 						<tr> -->
<!-- 				<td valign="top"><b>Fax:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="supplierFax"> </div> -->
<!-- 				</td> -->
<!-- 								<td><b>Website:</b> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<div id="supplierWebsite"> </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			
<!-- 		</table> -->
<!--  </div> -->
<!-- 	</td> -->
	</tr></table>
	<input type="hidden" name="counter" id="counter" value="10" />
	 </form>
	 <br><br>
	 <center><span id="wait" style="display: none;"><font color="red">Please Wait...</font> </span></center>
	 
	 <input type="hidden" name="itemDescriptioncopy" id="itemDescriptioncopy" />
	 
	 <div id="itemDescription" style="overflow:auto;height: auto; width: 100%;background-color: white; ">
			<div style="height: 100%; width: 100%; overflow: auto;">
			</div>
			
			</div>
			<br><br><center><span id="wait1" style="display: none;"><font color="red"> Please Wait... </font></span></center>
	 
		 <%
			if(request.getParameter("supplier")!=null)
				{
				if(request.getParameter("supplierReport").equalsIgnoreCase("pos"))
				{
					String sqlSupplier="SELECT *                                                                 "+
					" FROM                                                "+
					"   "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a  "+
					" left outer JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items AS b ON ( a.POno = b.PONo )           "+
					" left outer JOIN "+session.getAttribute("CompanyMasterID").toString()+"searchitems AS c ON ( b.make = c.makeCode                 "+
					" AND b.ItemCode = c.ItemCode and b.TheGroup=c.groupcode )  LEFT  OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn AS d ON (a.PONo =d.PONo )                                        "+
					" WHERE a.SupplierCode ='"+request.getParameter("supplier")+"'"  ;      
					
					if(request.getParameter("all")==null){
						String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("fromdate")));
						String toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("todate")));
						
						 
							   sqlSupplier="SELECT *                                                                 "+
								" FROM                                                "+
								"   "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a  "+
								" left outer JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items AS b ON ( a.POno = b.PONo )           "+
								" left outer JOIN "+session.getAttribute("CompanyMasterID").toString()+"searchitems AS c ON ( b.make = c.makeCode                 "+
								" AND b.ItemCode = c.ItemCode and b.TheGroup=c.groupcode  )                                          "+
								" WHERE a.SupplierCode ='"+request.getParameter("supplier")+"'"  +
								" and a.PODate>='"+fromDate+" 00:00:00' and a.PODate "+
						   		" <='"+toDate+" 23:59:59'";
						
					}
					System.out.println(sqlSupplier);
						%>
					<%-- 				 	<div
			style="font-size: 1.4em; color:black; text-align: center;  " > 
	Product supply details of  <a><%=request.getParameter("item").toString().replace("`","\"").replace("~","&") %></a> 
	 </div>
	 
						<table  border='1px'  class='sortable' >
							<tr>
								<th>Sr. No</th>
								<th>Desc</th>
								<th>PO No</th>
								<th>Cancelled</th>
								<th>PO Date</th>
								<th>Rate</th>
								<th>Make</th>
								<th>Model</th>
								<th>Qty.</th>
							</tr>
							
							<%
							ResultSet rsSupplier=st2_1.executeQuery(sqlSupplier);
							int i=1;
							String Status="No";
							while(rsSupplier.next())
							{
								 if(rsSupplier.getString("POCancelled").equalsIgnoreCase("1"))
									Status="Yes";
								%>
									<tr>
									<td><div align="center"><%=i++ %></div></td>
									<td><div align="left"><%=((rsSupplier.getString("Description")!=null) ? rsSupplier.getString("Description") : "-") %></div></td>
									<td><div align="right"><a href="#" onclick="popUp('123.jsp','<%=rsSupplier.getString("PONo")%>','PO','<%=request.getParameter("item").toString().replace("`","\"").replace("~","&") %>')"><%=rsSupplier.getString("PONo")%></a></div></td>
									
									<td><div align="right"><%=Status %></div></td>
									
									<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
											(rsSupplier.getString("PODate"))) %></div></td>
									<td><div align="right"><%=rsSupplier.getString("UnitPrice") %></div></td>
										
									<td><div align="left"><%=((rsSupplier.getString("makename")!=null) ? rsSupplier.getString("makename") : "-") %></div></td>
									<td><div align="left"><%=((rsSupplier.getString("model")!=null) ? rsSupplier.getString("model") : "-") %></div></td>
									<td><div align="right"><%=rsSupplier.getString("Quantity") %></div></td>
									</tr>	
									
								<%
							}
							if(i==1){
							%>
							<tr><td colspan="8">.</td></tr><tr><td colspan="8"><b>---NO DATA ---</b></td></tr>
							<%} %>
						</table>
						<%
					}
					else
					{
			                String sqlSupplier1="SELECT *                                                                 "+
											" FROM                                                "+
								"   "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails    "+
										"WHERE SupplierCode ='"+request.getParameter("supplier")+"'" ;
						
							if(request.getParameter("all")==null){
								String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
										.parse(request.getParameter("fromdate")));
								String toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("todate")));
								
								
				                  sqlSupplier1="SELECT *                                                                 "+
												" FROM                                                "+
									"   "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails    "+
											"WHERE SupplierCode ='"+request.getParameter("supplier")+"'"  +
											" and InvoiceDate>='"+fromDate+" 00:00:00' and InvoiceDate "+
									   		" <='"+toDate+" 23:59:59'";      
							}
							System.out.println(sqlSupplier1);
							%>
										 	<div
				style="font-size: 1.4em; color:black; text-align: center; " > 
		Product supply details of  <a><%=request.getParameter("item").toString().replace("`","\"").replace("~","&")%></a> 
		 </div>
								<table  border='1px'  class='sortable' >
							<tr>
								<th>Sr No</th>
								<th>Invo No</th>
								<th>Invo Value</th>
								<th>Invo Date</th>
								<th style="width: 400px;">Payment Details</th>
								<th>Amount Paid</th>
								<th>Balance</th>
								<th>Payment Date</th>
								<th>Payment Done Till Now</th>
							</tr>
							
							<%
							ResultSet rsSupplier=st2_1.executeQuery(sqlSupplier1);
							int i=1;
							while(rsSupplier.next())
							{
								%>
									<tr>
									<td><div align="center"><%=i++ %></div></td>
									<td><div align="right"><a href="#" onclick="popUp('123.jsp','<%=rsSupplier.getString("InvoiceNo")%>','invoiceNo','<%=request.getParameter("item").toString().replace("`","\"").replace("~","&") %>')"><%=rsSupplier.getString("InvoiceNo")%></a></div></td>
									<td><div align="right"><%=((rsSupplier.getString("InvoiceValue")!=null) ? rsSupplier.getString("InvoiceValue") : "-") %></div></td>
									
									<td><div align="right"><%=rsSupplier.getString("InvoiceDate") %></div></td>
									<td><div align="left"><%=rsSupplier.getString("PaymentDetails") %></div></td>
									
									<td><div align="right"><%=rsSupplier.getString("AmountPaid") %></div></td>
										
									<td><div align="right"><%=((rsSupplier.getString("Balance")!=null) ? rsSupplier.getString("Balance") : "-") %></div></td>
									<td><div align="left"><%=((rsSupplier.getString("PaymentDate")!=null) ? rsSupplier.getString("PaymentDate") : "-") %></div></td>
									<td><div align="right"><%=rsSupplier.getString("PaymentDoneTillNow") %></div></td>
									</tr>	
									<%
						
					}
							if(i==1){
								%>
								<tr><td colspan="7">.</td></tr>
								<tr><td colspan="7"><b>---NO DATA ---</b></td></tr>
								<%} %>
							 
							
						</table><%
				}
				}
		 
		 if(request.getParameter("item")!=null && request.getParameter("supplier")==null) {
			
		 String item=request.getParameter("item");
	String  searchBy=request.getParameter("searchBy");
	if(!(searchBy.equalsIgnoreCase("Supplier"))){
	%>
		 	<div
			style="font-size: 1.4em; color:black; text-align: center;  " > 
	Options for <a><%=item.replace("`","\"").replace("~","&") %></a>
			  
	 </div>
			 <table  border='1px'  class='sortable' >
			 	<tr>
	   						<th>Sr no</th>
	 					   <th>Desc.</th>
						   <th>Make Name</th>
						   <th>Make Code</th>
						   <th>ItemCode</th>
						   <th>Model</th>
						   <th>Part No</th>
						   <th></th>
				 </tr>
	<%
	item=item.replace("`","\"").replace("~","&");  
	if(searchBy.equalsIgnoreCase("Item"))	   
		sql="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE Description='"+item+"' ORDER BY Description";
	
	else if(searchBy.equalsIgnoreCase("Company"))
	   sql="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE makename='"+item+"' ORDER BY makename ";
	   
		else if(searchBy.equalsIgnoreCase("Model"))
		sql="SELECT  makename,makecode,ItemCode,Model,groupcode,PartNo,Description,makedettable  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE Model='"+item+"' ORDER BY Model";
		   
	else if(searchBy.equalsIgnoreCase("Part"))
	   sql="SELECT  makename,makecode,ItemCode,Model,groupcode,PartNo,Description,makedettable  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE PartNo='"+item+"' ORDER BY Partno";
	
	System.out.println("<><><>"+sql);
	
	ResultSet rs=st_1.executeQuery(sql);
	int i=1;
	String make="",model="",itemSelected="",part="";
	while(rs.next())
	{
		make=rs.getString("makecode");
		itemSelected=rs.getString("ItemCode");
		model=rs.getString("Model") ;
		part=rs.getString("PartNo");
		%>
	   <tr>
	   				<td><div align='left'><%=i %></div></td>
				   <td align='left'><div align='left'>
				    <%
				    item=item.replaceAll("\"","`").replaceAll("~","&");
				    //System.out.println("|||||||| "+make+" "+rs.getString("groupcode")+" "+itemSelected+" "+item+" "+rs.getString("makename")+" "+part+" "+rs.getString("Description")); %>
				    <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');">  <%=rs.getString("Description")%></a>
				     
				    </td>
				   <td align='left'> <div align='left'> <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');"> <%=rs.getString("makename")	%></a></div></td>
				   <td align='right'><div align='right'><a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');"> <%=make %></a></div></td>
				   <td align='right'><div align='right'><a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');"> <%=itemSelected	%></a></div></td>
				   <td align='left'> <div align='left'> <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');"> <%=model 	%></a></div></td>
				   <td align='left'> <div align='left'> <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs.getString("makename") %>','<%=part %>');"> <%= part 	%></a></div></td>
					<td align='left'><a href="#" style="font-weight: bold;" onclick="popUpSupplier('viewSupplierDetails.jsp','<%=item%>','<%=itemSelected %>','<%=rs.getString("makedettable") %>')">View Suppliers</a></td>
				 </tr>
				 <%
	   i++;
	}
	if(i==1){
		%>
		<tr><td colspan="8">.</td><td colspan="8"><b>--- NO DATA ---</b></td></tr>
		<%} %>
	
			 </table>
		 <%}
			 } %>
	 		 
	<%if(request.getParameter("purchaseDetails")!=null){
		
		%>
			 	<div
		style="font-size: 1.4em; color:black; text-align: center; " > 
Purchase Details for  <a><%=request.getParameter("itemName").toString().replace("`","\"").replace("~","&") %></a> of <%=request.getParameter("makeName") %> (Part no <%=request.getParameter("part") %>) 
		  
 </div>
		<table  border='1px'  class='sortable' >
		 	<tr>
		 		<th>Sr No</th>
		 		<th>P/O No</th>
		 		<th>Supplier code</th>
		 		<th>Supplier Name</th>
		 		<th>Date</th>
		 		<th>Rate</th>
		 		<th>Group</th>
		 		<th>Make</th>
		 		<th>Model</th>
			</tr>
			
		<%
		int i=1;
		String make="",model="",itemCode="",group="";
		make=request.getParameter("make");
		group=request.getParameter("group");
		itemCode=request.getParameter("itemCode");
		String sqlDesc="";			
		
		String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(request.getParameter("fromdate").toString()));
		String toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(request.getParameter("todate").toString()));
		
		String compareMake="  ",compareMakeAtEnd=" ",inDateRange=" ";
		if(Integer.parseInt(group)<5)
		{
			compareMake="  b.makecode = a.make AND ";
			compareMakeAtEnd=" AND a.make ="+make+"  ";
		}	
		if(request.getParameter("all")==null || request.getParameter("all").equalsIgnoreCase("null"))
			inDateRange=" c.PODate >='"+fromDate+"'   AND c.PODate <='"+toDate+"'   AND ";   
		
		 sqlDesc= "SELECT *                                                   "+
		" FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items AS a                                           "+
		" LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"searchitems AS b ON (      "+
			compareMake+
		"  b.ItemCode = a.ItemCode and a.TheGroup=b.groupcode )                                             "+
		" LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder AS c ON ( c.PONo = a.PONo )               "+
		" LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet AS d ON ( d.SupplierCode = c.SupplierCode ) "+
		" WHERE      "+inDateRange+"                                        "+
		"   a.itemCode ="+itemCode+"                                              "+
		" "+compareMakeAtEnd+" and a.TheGroup='"+group+"'         ";    
		
	 System.out.println(sqlDesc);
	 	 ResultSet rsDesc=st1_1.executeQuery(sqlDesc);
		 while(rsDesc.next()){
			%>
				<tr>
				<td><div align="right"><%=i %></div></td>
				<td><div align="right"><a href="#" onclick="popUp('123.jsp','<%=rsDesc.getString("PONo")%>','PO','<%=rsDesc.getString("SupplierName") %>')"><%=rsDesc.getString("PONo")%></a></div></td>
				<td><div align="right"><%=rsDesc.getString("SupplierCode")%></div></td>
				<td><div align="left"><%=rsDesc.getString("SupplierName")%></div></td>
				<td><div align="left"><%=new SimpleDateFormat(
				"dd-MMM-yyyy")
				.format(new SimpleDateFormat(
						"yyyy-MM-dd")
						.parse(rsDesc.getString("PODate")))%></div></td>
				<td><div align="right"><%=df.format(rsDesc.getDouble("UnitPrice"))%></div></td>
				<td><div align="left"><%=rsDesc.getString("GroupName")%></div></td>
				<td><div align="left"><%=rsDesc.getString("makename")%></div></td>
				<td><div align="left"><%=rsDesc.getString("model")%></div></td>
				</tr>
			
			<% 
			i++;
		 }
		 if(i==1){
		%>
		<tr><td colspan="10"><b>.</b></td></tr><tr><td colspan="10"><b>---  NO DATA  ---</b></td></tr>
		<%} %>
		</table> --%>
		<%
	}
	}
	try{
	conn1.close();
	}catch(Exception e){e.printStackTrace();}
	%>
 

<!-- 	<br><br><br><br><br><br> -->
<!-- 	<br><br><br><br> -->
<!-- 	 	<br><br><br><br><br><br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>


