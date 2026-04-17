<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	
	<script src="sorttable.js" type="text/javascript"></script>
	
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>
	
	
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>
	<script type="text/javascript">

	function closeEnq()
	{
		//alert("Do YOU want to close This Enquiry??");
		var agree=confirm("Pls Enter Reason For Closing This Purchase Order");
		if (agree)
		{
		document.getElementById("header").style.visibility="visible";
		document.getElementById("cancellingreason").style.visibility="visible";
		document.getElementById("submitbutton").style.visibility="visible";
		return true ;
		}
		else
		return false ;
	}

	function calculate()
	{	
		//alert("HTTT  ");
		var a;var k=0;
		var Amount=new Array();
		var rowCount = document.getElementById("count").value;
		//alert(rowCount);
		for(k=0;k<rowCount;k++)
		{
			//var tax=document.getElementById("tax"+k).value;alert(tax);
			//var discount=document.getElementById("discount"+k).value;alert(discount);
			var qua=document.getElementById("quantity"+k).value;//alert(qua);
			var unitprice=document.getElementById("sellingprice"+k).value;//alert(unitprice);
			
			
			//var discount1=(discount)/100*unitprice*qua;
			a=unitprice*qua;//alert(a);
			Amount[k]=a.toFixed(2);
			document.getElementById("amount"+k).value=a.toFixed(2);
		}	
			var rowCount = document.getElementById("count").value; 
			var z; 
			var i;
			var total;
			var s=0;
			
			for(i=0;i<rowCount;i++)
			{
				var z=(document.getElementById("amount"+i).value);
				s=parseFloat(s)+parseFloat(z);
				//alert("S in For:"+s);
			}
			document.getElementById('total').value=parseInt(s);
			//alert(document.getElementById('total').value);
		    var junkVal=document.getElementById('total').value;
		    junkVal=Math.floor(junkVal);
		    var obStr=new String(junkVal);
		    numReversed=obStr.split("");
		    actnumber=numReversed.reverse();
            //alert(actnumber);
		    if(Number(junkVal) >=0){
		        //do nothing
		    }
		    else{
		    alert('wrong Number cannot be converted');
		    return false;
		    }
		    if(Number(junkVal)==0){
		        document.getElementById('container').innerHTML=obStr+''+'Rupees Zero Only';
		        return false;
		    }
		    if(actnumber.length>9){
		        alert('Oops!!!! the Number is too big to covertes');
		        return false;
		    }
		    
		    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
		    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
		    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety' ];
		    
		    var iWordsLength=numReversed.length;
		    var totalWords="";
		    var inWords=new Array();
		    var finalWord="";
		    j=0;
			for(i=0; i<iWordsLength; i++){
		    switch(i)
		        {
		        case 0:
		        if(actnumber[i]==0 || actnumber[i+1]==1 ) {
		                inWords[j]='';
		            }
		            else {
		                inWords[j]=iWords[actnumber[i]];
		            }
		            inWords[j]=inWords[j]+' Only';
		        break;
		        case 1:
		            tens_complication();
		            break;
		        case 2:
		       if(actnumber[i]==0) {
		           inWords[j]='';
		        }
		        else if(actnumber[i-1]!=0 && actnumber[i-2]!=0) {
		                inWords[j]=iWords[actnumber[i]]+' Hundred and';
		        }
		            else {
		            inWords[j]=iWords[actnumber[i]]+' Hundred';
		            }
		       break;
		        case 3:
		            if(actnumber[i]==0 || actnumber[i+1]==1) {
		                inWords[j]='';
		            }
		            else {2
		            inWords[j]=iWords[actnumber[i]];
		            }
		            if(actnumber[i+1] != 0 || actnumber[i] > 0){
		            inWords[j]=inWords[j]+" Thousand";
		        }
		            break;
		        case 4:
		            tens_complication();
		        break;
		        case 5:
		            if(actnumber[i]==0 || actnumber[i+1]==1) {
		            inWords[j]='';
		            }
		        else {
		            inWords[j]=iWords[actnumber[i]];
		        }
		            if(actnumber[i+1] != 0 || actnumber[i] > 0){
		                inWords[j]=inWords[j]+" Lacs";
		       }
		            break;
		        case 6:
		            tens_complication();
		            break;
		        case 7:
		            if(actnumber[i]==0 || actnumber[i+1]==1 ){
		                inWords[j]='';
		            }
		            else {
		                inWords[j]=iWords[actnumber[i]];
		            }
		            inWords[j]=inWords[j]+" Crore";
		            break;
		        case 8:
		            tens_complication();
		        break;
		        default:
		            break;
		    }
		        j++;
		}

			function tens_complication() {
		        if(actnumber[i]==0) {
		            inWords[j]='';
		        }
		        else if(actnumber[i]==1) {
		        inWords[j]=ePlace[actnumber[i-1]];
		        }
		        else {
		       inWords[j]=tensPlace[actnumber[i]];
		        }
			}
		inWords.reverse();
		for(i=0; i<inWords.length; i++) {
		    finalWord+=inWords[i];
		}
		    document.getElementById('rupees').value=finalWord;
		    //alert("finalWord="+finalWord);
		    
	}

	function redirect1(webadd,PurOrderNumber)
	{
		var reasonforcancel=document.getElementById("reasonforcancel").value;
		//alert(reasonforcancel);
		var type =document.getElementById("type").value;
		//alert(type);
	
		window.open(webadd+'?PurOrderNumber='+PurOrderNumber+'&reasonforcancel='+reasonforcancel+'&type='+type);
	}
	
	function redirect(webadd,PurOrderNumber)
	{
		window.open(webadd+'?PurOrderNumber='+PurOrderNumber);
	}
	
	function Pdfredirect(webadd,PurOrderNumber)
	{
		window.open(webadd+'?PurOrderNumber='+PurOrderNumber);
	}
	
	function closeInvoice()
	{
		//alert("HHHHHH");
		var agree=confirm("Are you sure you want to Reject This Order?");
		if (agree)
		{
		document.getElementById("header").style.visibility="visible";
		document.getElementById("terms123").style.visibility="hidden";
		document.getElementById("terms1234").style.visibility="hidden";
		document.getElementById("cancellingreason").style.visibility="visible";
		document.getElementById("submitbutton").style.visibility="visible";
		document.getElementById("closebutton").style.visibility="hidden";
		document.getElementById("printbutton").style.visibility="hidden";
		document.getElementById("pdfbutton").style.visibility="hidden";
		document.getElementById("Approve").style.visibility="hidden";
		return true ;
		}
		else return false;
	}
	
	function validrs(){ 

		var cancel=document.getElementById("reasoncancel").value;
		if(cancel=="")
			{
			alert("Please Insert Reason First");
			return false;
			}
		}
	</script>
	
	
	
	
	<script>

function redirect21(webadd,PurOrderNumber)
{
	/* alert(webadd);
	alert(PurOrderNumber); */
	
 	var reasonforcancel="Cancel";
	/* alert(reasonforcancel); */
	var type =document.getElementById("type").value;
/* 	alert(type); */
 
	 window.open(webadd+'?PurOrderNumber='+PurOrderNumber+'&reasonforcancel='+reasonforcancel+'&type='+type); 
}
</script>
	
	
	
	
	
	</head>
	<body>
    
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		    Connection conn = null;
			Statement st = null,st1=null,st2=null,st3=null;
			boolean isInvoiceSelected = false;
			int count=0;
			int d=0;
			Date today = new Date();
			String enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
			String date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enqDate));
			
			Date mothafter=new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH,+30);
			Date MonthAsDate=cal.getTime();
			String monthafter=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(MonthAsDate);
			String monthafterInMMM=new SimpleDateFormat("dd-MMM-yyyy hh:mm;ss").format(MonthAsDate);
			System.out.println(monthafterInMMM+"())))))))))))))))))))))  ");
			double stpercent=0.0,amount=0.0,sellingPrice=0.0;
			Date today1 = new Date();
			String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today1);
			
			String type=request.getParameter("condition");
			System.out.println("TYPE IS    "+type);
			
			if(type==null || type.equalsIgnoreCase("null"))
			{
				type="View";
			}
			System.out.println("TYPE IS    "+type);

			String PurOrderRefNumber = request.getParameter("transactionId");
			System.out.println(PurOrderRefNumber);
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",PurQuoNumber="",status="",statusTD="",fromdate="";
			NumberFormat nf = new DecimalFormat("#0.00");
			
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
			} catch (Exception e) {
			}
	%>
    
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
	
	
	<div align="center" id=" " style="font-size: 1.5em;">Purchase Order : <a><%=request.getParameter("transactionId")%></a>
 </a></div>
	
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.6em; height: 3px; background-color: #339CCB">
	</div>
		<div>&nbsp;</div>
		
<%
if(type.contains("null") || type.contains("Pending") || type.contains("Approved") || type.contains("Rejected") || type.contains("View") || type.contains("Cancelled"))
{

String sqlPurchase ="";
	String PurOrderNumber="",SupplierName="",Total="",GrandTotal="",TotalInWords="",Terms="";

if(type.equals("Pending") || type.contains("Approved") || type.contains("Rejected") || type.contains("Cancelled") )
{
	 sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PONo = '"+ PurOrderRefNumber + "' ";
}
else
{
	 sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PONo = '"+ PurOrderRefNumber + "' ";
}

	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODueDate")));
				} catch (Exception e) {
				}
				String DelvDate = "NA";
				try {
					DelvDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DeliveryDate")));
				} catch (Exception e) {
				}
				if(type.contains("Approved"))
				{
					PurOrderNumber=rsTransaction.getString("ActualPONo");
				}
				else
				{
				PurOrderNumber=rsTransaction.getString("PONo");
				}
				Total=rsTransaction.getString("Total");
				GrandTotal=rsTransaction.getString("GrandTotal");
				TotalInWords=rsTransaction.getString("TotalinWords");
				Terms=rsTransaction.getString("Terms");
%>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase Order No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("PONo")%></label>
			</td>
			<td><b>Purchase Order Date:</b></td>
			<td><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<td><label><%=rsTransaction.getString("SupplierName")%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><label><%=rsTransaction.getString("ContactPerson")%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><label><%=rsTransaction.getString("Phone")%></label></td>
			<td><b> Fax:</b></td>
			<td><label><%=rsTransaction.getString("Fax")%></label></td>
		</tr>
		<tr>
			
			<td><b>Address:</b></td>
			<td><label><%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("City") + " , "
							+ rsTransaction.getString("Zip") + " , "
							+ rsTransaction.getString("State") + " , "
							+ rsTransaction.getString("Country")%></label>
			</td>
			<td><b>Sent By:</b></td>
			<td><label><%=rsTransaction.getString("SentBy")%></label></td>
			<td><b>PODue Date:</b></td>
			<td><input type="hidden" name="duedate" value="<%=dueDate%>"/><label><%=dueDate%></label></td>
		</tr>
		<tr>
			<td><b>PODelivery Date:</b></td>
			<td><input type="hidden" name="delvdate" value="<%=DelvDate%>"/><label><%=DelvDate%></label></td>
		</tr>
			
		
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
		  
   
	<table class="sortable">
		<tr>
		    <th>Sr. No</th>
			<th>Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<th>Price</th>
 
		</tr>
	<%
	int i=1;
	String refMakeNameTable="", NewDescribtion="", descrition="";
	String sqlPurDet ="";
	if(type.contains("null") || type.contains("Pending") || type.contains("Rejected") || type.contains("Cancelled"))
	{
	 sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items WHERE PONo ='"+ rsTransaction.getString("PONo") + "'  ";
	}
	else
	{
	 sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE PONo ='"+ PurOrderNumber + "'  ";
	}
	
		
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						NewDescribtion = rsPurDet.getString("description");
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
						System.out.println("NewDescribtionNewDescribtionNewDescribtionNewDescribtionNewDescribtion           "+NewDescribtion );
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						while(rsSql.next())
						{
							descrition = rsSql.getString("Description");
							descrition = NewDescribtion;
						System.out.println("NewDescribtion00000000000000000000   "+ NewDescribtion);
						
	%>
						<tr>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=NewDescribtion%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="right"><%=quantity%></div></td>
							<td><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
				 	</tr>
<%
						}
								}
		
	%>


           
           
            
</table>




  
	
<div>&nbsp;</div>		
<div align="left"  id="terms123" name="terms123" style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
			
		<div align="left"   id="terms1234" name="terms1234" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="search-text" style='width: 300px; height: 100px;'><%=Terms%></textarea></div>
	
	
	
<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value=""><%=Total %></input>
	</div>
	
<div style="font-size: 1.0em" align="right">
	 <b>Grand Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value=""><%=GrandTotal %></input>
	</div>	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea  name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=TotalInWords %></textarea>
		</td></tr></table>
	</div>
	
	<form name="quotation" id="quotation" method="get" action="PendingActiontOrder.jsp">
<script>document.getElementById("quotation").style.visibility="hidden";</script>
	<div align="left"  id="header" style="position:absolute;   font-size: 1.1em"><b> &nbsp;Reason For Rejection :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>
<div align="right">&nbsp;&nbsp;</div>
	<div align="left"  id="cancellingreason" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;
<textarea name="reasonforcancel" id="reasoncancel" style='width: 300px; height: 50px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>

<div align="center" id="submitbutton" style="margin-top: 3em; margin-right: 20em;">&nbsp;

	<input type="submit" name="SubmitTT" value="SubmitReason" style="border: outset; background-color: #C6DEFF" onclick="return validrs();"/>
	<script>document.getElementById("submitbutton").style.visibility="hidden";</script>
</div>

 <input type="hidden" name="PurOrderNumber" value="<%=PurOrderNumber %>">
 <input type="hidden" name="type" id="type" value="<%=type %>">
<%-- <input type="hidden" name="invoiceRefNo" value="<%=invoicerefNo %>"/>
<input type="hidden" name="customercode" value="<%=rsInvoiceDet.getString("CustomerCode") %>"/> 
<input type="hidden" name="reasonforcancel" value="reasonforcancel"> --%>
</form>	
	<table align="center">
	<tr align="center">
	<%-- <td>
	<div  align="center" id="printbutton" style="margin-top: 3em; margin-left: 10em;">
	<input type="submit" name="printOrder" value="Print" onclick="redirect('printPurchaseOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	 <td><div align="center" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="pdfOrder" value="PDF" onclick="Pdfredirect('pdf_PurchaseOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td> --%>

<%
if(type.contains("null")  || type.contains("Approved") || type.contains("View"))
{
%>
<td>
<div  align="center" id="printbutton" style="margin-top: 3em; margin-left: 10em;">
	<input type="submit" name="printOrder" value="Print" onclick="redirect('printPurchaseOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	 <td><div align="center" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="pdfOrder" value="PDF" onclick="Pdfredirect('pdf_PurchaseOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td> 
<%} %>

<%
String dept=session.getAttribute("department").toString();
System.out.println("department is------------->"+dept);

if(dept.equals("Purchase")&&(type.equals("Pending")))
{
%>
<!--code 1  -->
 <td><div align="center" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="cancelorder" value="CancelOrder" onclick="redirect21('PendingActiontOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>

<% 
}
%>
</tr>

<%
String Admin=session.getAttribute("Admin").toString();
if(Admin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level5") || session.getAttribute("userLevel").toString().equalsIgnoreCase("level6"))
{
if(type.equals("Pending"))
{
	System.out.println("Pending "+type);
%>
<tr align="center">
<% if(Sesrole.equals("AllAdmin")) 
 {  %>
<td>
<div  align="center" id="Approve" name="Approve" style="margin-top: 3em;margin-left: 10em;">
	<input type="submit" name="Approve" value="Approve" onclick="redirect1('PendingActiontOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	<%} %>
<input type="hidden" name="reasonforcancel" id="reasonforcancel" value="Approved">
<input type="hidden" name="type" id="type" value=<%=type%>>
<td>
<div  align="center" id="closebutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="closeQuotation" value="Reject Order" onclick="closeInvoice();"  style="border: outset; background-color: #C6DEFF"  />
	
	<!--code 2  -->
	<td><div align="center" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="cancelorder" value="CancelOrder" onclick="redirect21('PendingActiontOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	
	<%} 

%>
<input type="hidden" name="PurOrderNumber" value="<%=PurOrderNumber %>">
 <input type="hidden" name="type" value="<%=type %>">
 </td>
</input></input></div></input></input></tr></table>
 <%
            
	}else{
		if(Sesrole.equals("AllAdmin")) 
		 {  

if(type.equals("Pending"))
{
	System.out.println("Pending "+type);
%>
<tr align="center">

<td>
<div  align="center" id="Approve" name="Approve" style="margin-top: 3em;margin-left: 10em;">
	<input type="submit" name="Approve" value="Approve" onclick="redirect1('PendingActiontOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>

<input type="hidden" name="reasonforcancel" id="reasonforcancel" value="Approved">
<input type="hidden" name="type" id="type" value=<%=type%>>
<td>
<div  align="center" id="closebutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="closeQuotation" value="Reject Order" onclick="closeInvoice();"  style="border: outset; background-color: #C6DEFF"  />
	
	<!--code 2  -->
	<td><div align="center" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="cancelorder" value="CancelOrder" onclick="redirect21('PendingActiontOrder.jsp','<%=PurOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	
	<%} 

%>
<input type="hidden" name="PurOrderNumber" value="<%=PurOrderNumber %>">
 <input type="hidden" name="type" value="<%=type %>">
 </td>
</input></input></div></input></input></tr></table>
 <%

		 }
	}
 %>

	<%
	
	}
	
} %>		
<div>&nbsp;</div>
<div>&nbsp;</div>
<%
if(type.contains("close"))
{
	System.out.println("IN CLOSE     ****   ");
%>
<%
	String PurOrderNumber="",SupplierName="",Total="",GrandTotal="",TotalInWords="",Terms="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PONo = '"+ PurOrderRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODueDate")));
				} catch (Exception e) {
				}
				String DelvDate = "NA";
				try {
					DelvDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DeliveryDate")));
				} catch (Exception e) {
				}
				PurOrderNumber=rsTransaction.getString("PONo");
				Total=rsTransaction.getString("Total");
				GrandTotal=rsTransaction.getString("GrandTotal");
				TotalInWords=rsTransaction.getString("TotalinWords");
			Terms=rsTransaction.getString("Terms");
%>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase Order No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("PONo")%></label>
			</td>
			<td><b>Purchase Order Date:</b></td>
			<td><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<td><label><%=rsTransaction.getString("SupplierName")%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><label><%=rsTransaction.getString("ContactPerson")%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><label><%=rsTransaction.getString("Phone")%></label></td>
			<td><b> Fax:</b></td>
			<td><label><%=rsTransaction.getString("Fax")%></label></td>
		</tr>
		<tr>
			
			<td><b>Address:</b></td>
			<td><label><%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("City") + " , "
							+ rsTransaction.getString("Zip") + " , "
							+ rsTransaction.getString("State") + " , "
							+ rsTransaction.getString("Country")%></label>
			</td>
			<td><b>Sent By:</b></td>
			<td><label><%=rsTransaction.getString("SentBy")%></label></td>
			<td><b>PODue Date:</b></td>
			<td><input type="hidden" name="duedate" value="<%=dueDate%>"/><label><%=dueDate%></label></td>
		</tr>
		<tr>
			<td><b>PODelivery Date:</b></td>
			<td><input type="hidden" name="delvdate" value="<%=DelvDate%>"/><label><%=DelvDate%></label></td>
		</tr>
			
		
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
		  
   
	<table class="sortable">
		<tr>
		    <th>Sr. No</th>
			<th>Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<th>Selling Price</th>
 
		</tr>
	<%
	int i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE PONo ='"+ PurOrderNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "",itemCode ="",quantity="", makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
	
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						while(rsSql.next())
						{
						  
						 
						
						
	%>
						<tr>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="left"><%=quantity%></div></td>
							<td><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
				 	</tr>
<%
						}
								}
		
	%>


           
           
            
</table>
  
	
<div>&nbsp;</div>		
<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="search-text" style='width: 450px; height: 150px;'><%=Terms%></textarea></div>
	
<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value=""><%=Total %></input>
	</div>
	
<div style="font-size: 1.0em" align="right">
	 <b>Grand Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value=""><%=GrandTotal %></input>
	</div>	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea  name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=TotalInWords %></textarea>
		</td></tr></table>
	</div>
	
 <%
            
	}
 %>
 <div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeOrder" value="close Order" onclick="closeEnq();"  style="border: outset; background-color: #C6DEFF"  />
</div>

<form name="form2" method="get"  action="closePurOrder.jsp" >

<div align="left"  id="header" style="position:absolute;   font-size: 1.1em"><b> &nbsp;Reason For Cancelling :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>
<div align="left"  id="cancellingreason" name="cancellingreason" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="reasonforcancel"
	id="search-text" style='width: 430px; height: 160px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>

<input type="hidden" name="reasonforcancel" value="reasonforcancel"/>
<input type="hidden" name="purorderno" id="purorderno" value="<%=PurOrderNumber %>"/>

<div align="center" id="submitbutton" style="margin-top: 3em;">
	<input type="submit" name="Submit TT" value="Submit Reason" style="border: outset; background-color: #C6DEFF"  />
	<script>document.getElementById("submitbutton").style.visibility="hidden";</script>
</div>
</form>

	<%} %>	
	<div>&nbsp;</div>
	<div>&nbsp;</div>
<%
if(type.contains("revise"))
{
	System.out.println("IN Revise    ****   ");
%>
<%
	String PurOrderNumber="",SupplierName="",Total="",GrandTotal="",TotalInWords="",Terms="",PurQuoNo="",Discount="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PONo = '"+ PurOrderRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try 
				{
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODueDate")));
				} catch (Exception e) {
				}
				String DelvDate = "NA";
				try {
					DelvDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DeliveryDate")));
				} catch (Exception e) {
				}
				PurOrderNumber=rsTransaction.getString("PONo");
				Total=rsTransaction.getString("Total");
				GrandTotal=rsTransaction.getString("GrandTotal");
				TotalInWords=rsTransaction.getString("TotalinWords");
				Terms=rsTransaction.getString("Terms");
				Discount=rsTransaction.getString("DiscountPercent");
				
%>

              
			<div align="center" style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
		</div>
		
		
<form name="revise" method="post" action="RevisePurOrder.jsp">
	
	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase Order No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("PONo")%></label>
			</td>
			<td><b>Purchase Order Date:</b></td>
			<td><input type="hidden" name="podate" id="podate" value="<%=rsTransaction.getString("PODate")%>"/><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<td><label><%=rsTransaction.getString("SupplierName")%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><input type="hidden" name="contactperson" id="contactperson" value="<%=rsTransaction.getString("ContactPerson")%>"/><label><%=rsTransaction.getString("ContactPerson")%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><input type="hidden" name="phone" id="phone" value="<%=rsTransaction.getString("Phone")%>"/><label><%=rsTransaction.getString("Phone")%></label></td>
			<td><b>Fax:</b></td>
			<td><input type="hidden" name="fax" id="fax" value="<%=rsTransaction.getString("Fax")%>"/><label><%=rsTransaction.getString("Fax")%></label></td>
		</tr>
		<tr>
			<td><input type="hidden" name="address" id="address" value="<%=rsTransaction.getString("Address")%>"/>
			<b>Address:</b></td>
			<td><label><%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("City") + " , "
							+ rsTransaction.getString("Zip") + " , "
							+ rsTransaction.getString("State") + " , "
							+ rsTransaction.getString("Country")%></label>
			</td>
			<td>
				<input type="hidden" name="city" id="city"value="<%=rsTransaction.getString("City") %>"/>
				<input type="hidden" name="zip"  id="zip" value="<%=rsTransaction.getString("Zip") %>"/>
				<input type="hidden" name="state" id="state" value="<%=rsTransaction.getString("State") %>"/>
				<input type="hidden" name="country" id="country" value="<%=rsTransaction.getString("Country") %>"/>	
				<input type="hidden" name="supliercode" id="supliercode" value="<%=rsTransaction.getString("SupplierCode") %>"/>		
				<input type="hidden" name="potime" id="potime" value="<%=rsTransaction.getString("POTime") %>"/>
				<input type="hidden" name="revofpono" id="revofpono" value="<%=rsTransaction.getString("RevOfPOno") %>"/>	
				<input type="hidden" name="noofrev" id="noofrev" value="<%=rsTransaction.getString("NoOfRev") %>"/>	
				<input type="hidden" name="reason" id="reason" value="<%=rsTransaction.getString("ReasonForCancelling") %>"/>		
			    <input type="hidden" name="discount" id="discount" value="<%=rsTransaction.getString("DiscountPercent") %>"/>
			    <input type="hidden" name="poref" id="poref" value="<%=rsTransaction.getString("POReference") %>"/>
			    <input type="hidden" name="desaddr" id="desaddr" value="<%=rsTransaction.getString("despatchAddress") %>"/>
			    <input type="hidden" name="pendpo" id="pendpo" value="<%=rsTransaction.getString("PendingPODetails") %>"/>
			    <input type="hidden" name="reasonp" id="reasonp" value="<%=rsTransaction.getString("ReasonforPendingPO") %>"/>
			    <input type="hidden" name="curtype" id="curtype" value="<%=rsTransaction.getString("CurrType") %>"/>
			    <input type="hidden" name="curvalue" id="curvalue" value="<%=rsTransaction.getString("CurrValue") %>"/>
			    <input type="hidden" name="purquo" id="purquo" value="<%=rsTransaction.getString("PurQuoNo") %>"/>
			    <input type="hidden" name="po" id="po" value="<%=rsTransaction.getString("PORaisedByCompany") %>"/>
			    
              
			</td>
			<td><b>Sent By:</b></td>
			<td><input type="hidden" name="sentby" id="sentby" value="<%=rsTransaction.getString("SentBy") %>"/>	<label><%=rsTransaction.getString("SentBy")%></label></td>
			<td><b>PODue Date:</b></td>
			<td><input type="hidden" name="duedate" id="duedate" value="<%=dueDate%>"/><label><%=dueDate%></label></td>
		</tr>
		<tr>
			<td><b>PODelivery Date:</b></td>
			<td><input type="hidden" name="delvdate" id="delvdate" value="<%=DelvDate%>"/><label><%=DelvDate%></label></td>
		</tr>
			
		
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
		  
   
	<table class="sortable">
		<tr>
		    <th>Sr.No</th>
			<th>Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<th>Price</th>
			<th>Amount</th>
 
		</tr>
	<%
	int i=1;
	String refMakeNameTable="",unit="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE PONo ='"+ PurOrderNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) 
				{
					  System.out.println(">>>>>>In while loop");
					    System.out.println(">>>>>UnitPrice=:" +rsPurDet.getString("UnitPrice"));
						
					    String makeCode = "", itemCode = "",  quantity, makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
						unit=rsPurDet.getString("UnitPrice");
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						while(rsSql.next())
						{
										
	%>
						<tr>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="right"><input type="text"  id="quantity<%=d %>" name="quantity<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=rsPurDet.getString("Quantity") %>"/></div></td>
							<td><div align="right"><input type="text"  id="sellingprice<%=d %>" name="sellingprice<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               				border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	              				color: #000000;" value="<%=rsPurDet.getString("UnitPrice")%>" /></div></td>
							<td style="width: 85px;"><div align="right"><input type="text"  id="amount<%=d %>" name="amount<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=amount%>" /></div>
			    </td>
			   	 	   </tr>
			   	 	   <input type="hidden" id="groupcode<%=d%>" name="groupcode<%=d %>" value="<%=groupCode%>"/>
				 	   <input type="hidden" id="makecode<%=d%>" name="makecode<%=d %>" value="<%=makeCode%>"/>
				 	   <input type="hidden" id="itemcode<%=d%>" name="itemcode<%=d %>" value="<%=itemCode%>"/>
				 	   <input type="hidden" name="quantity<%=d %>" id=quantity<%=d %>" value="<%=rsPurDet.getString("Quantity") %> "/>
				 	   
<%
                        d++;
						}
					   
					}count=i-1;
				}
	%>

        
           
            
</table>
   
   <div>&nbsp;</div>		
<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="terms" style='width: 450px; height: 150px;'><%=Terms%></textarea></div>
<div align="right">
<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
</div>
<br></br>	
<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value="<%=totalAmount%>"></input>
	<input type="hidden" name="total" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea  name="rupees" id="rupees"   style="width: 230px; border: none;" value="<%=totalAmount%>"></textarea>
		<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
		</td></tr></table>
	</div>
   
	<script>
	
	
	</script>
	<input type="hidden" name="count"  id="count" value="<%=count %>"/>
	<%-- <input type="hidden" name="PurOrderRefNumber" id="PurOrderRefNumber" value="<%=request.getParameter("transactionId") %>"/> --%>
	
	
<br>	
<br></br>	
<br></br>	
<br></br>	
<br></br>	
	<div align="center">
	<input type="submit" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick=""	name="RevisePurOrder" value="Revise PurOrder" />
	</div>		
	</br>
	</br>
	




	<%
	
} %>		
<!-- 	<br> <br> <br> <br><br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<br> <br> <br> <br><br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	
	
	</body>
	</html>
	
</jsp:useBean>
<%-- <%@include file="footer_new.jsp"%> --%>