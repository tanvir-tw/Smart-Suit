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

	function closeInv()
	{
		//alert("Do YOU want to close This Enquiry??");
		var agree=confirm("Pls Enter Reason For Closing This Invoice");
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
		var rowCount = document.getElementById("count").value;//alert(rowCount);
		var pf1=document.getElementById("pf").value;
	//	alert(pf1);
		var frieght1=document.getElementById("frieght").value;
	//	alert(frieght1);
		var discount=document.getElementById("discount").value;
		//alert("discount:"+discount);
		var tax=document.getElementById("tax").value;
	//	alert("tax:"+tax);
		for(k=0;k<rowCount;k++)
		{
			
			
			var qua=document.getElementById("quant"+k).value;
		//	alert("qua:"+qua);
			var unitprice=document.getElementById("selling"+k).value;
			//alert("unitprice:"+unitprice);
			var tax1=(tax)/100*unitprice*qua;
			var discount1=(discount)/100*unitprice*qua;
			a=unitprice*qua+tax1-discount1;//alert("a:="+a);
			
			document.getElementById("amount"+k).value=a.toFixed(2);
			
		}	
			var rowCount = document.getElementById("count").value; 
			var z; 
			var i;
			var total;
			var s=0;
			
			for(i=0;i<rowCount;i++)
			{
				//alert("In For Loop");
				var z=(document.getElementById("amount"+i).value);
				s=parseFloat(s)+parseFloat(z);
				//alert("S in For:"+s);
			}
			s=s+parseInt(pf1)+parseInt(frieght1);
			//alert("after for s:"+s);
			document.getElementById('total').value=parseInt(s);
			
		    var junkVal=document.getElementById('total').value;
		    junkVal=Math.floor(junkVal);
		    var obStr=new String(junkVal);
		    numReversed=obStr.split("");
		    actnumber=numReversed.reverse();

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
		    
	}
	
	function redirect(webadd,PurInvoiceNumber)
	{
		window.open(webadd+'?PurInvoiceNumber='+PurInvoiceNumber);
	}
	
	function Pdfredirect(webadd,PurInvoiceNumber)
	{
		window.open(webadd+'?PurInvoiceNumber='+PurInvoiceNumber);
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
			
			Date today1 = new Date();
			String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today1);
			
			double stpercent=0,amount=0,sellingPrice=0;
			
			String type=request.getParameter("condition");
			System.out.println("TYPE IS    "+type);
			
			String PurEnqRefNumber = request.getParameter("transactionId");
			System.out.println(PurEnqRefNumber);
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",PurQuoNumber="",status="",statusTD="",fromdate="";
			NumberFormat nf = new DecimalFormat("#0.00");
			String pf="",frieght="";
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
	
	
	<div align="center" id=" " style="font-size: 1.5em;">Purchase Invoice : <a><%=request.getParameter("transactionId")%></a>
 </a></div>
	
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.6em; height: 3px; background-color: #339CCB">
	</div>
		<div>&nbsp;</div>
		
<%
if(type.contains("null"))
{
%>			

<%
	String PurInvNumber="",SupplierName="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurInvoiceNo = '"+ PurEnqRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		
				PurInvNumber=rsTransaction.getString("PurInvoiceNo");
%>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase Inv No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("PurInvoiceNo")%></label>
			</td>
			<td><b>Purchase Inv Date:</b></td>
			<td><label><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsTransaction.getString("PurInvoiceDate")))%></label>
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
			<th>Selling Price</th>
			<th>Price Entered On</th>
 
		</tr>
	<%
	int i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items WHERE PurInvoiceNo ='"+ PurInvNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity, makeName = "",groupName="";
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
							<td><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
							<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsSql.getString("EnteredonDate")))%></div></td>
				 	</tr>
<%
						}
					}
		}
	%>

</table>
<table style="width: 100%;">
<tr>
<td>
<div  align="center" id="printbutton" style="margin-top: 3em;margin-left:10em;">
	<input type="submit" name="printOrder" value="Print" onclick="redirect('printPurchaseInvoice.jsp','<%=PurInvNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td>
	 <td><div align="left" id="pdfbutton" style="margin-top: 3em; margin-left: 5em;">
	<input type="submit" name="pdfOrder" value="PDF" onclick="Pdfredirect('pdf_PurchaseInvoice.jsp','<%=PurInvNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div></td> 
</tr>
</table>
<%} %>

<div>&nbsp;</div>
<div>&nbsp;</div>		
		
<%
if(type.contains("close"))
{
	System.out.println("IN CLOSE     ****   ");
%>	

<%
String PurInvNumber="",SupplierName="";
String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurInvoiceNo = '"+ PurEnqRefNumber + "' ";
ResultSet rsTransaction = st.executeQuery(sqlPurchase);
System.out.println("****************             "+sqlPurchase);
if (rsTransaction.next()) 
{
	SupplierName=rsTransaction.getString("SupplierName");		
	
			PurInvNumber=rsTransaction.getString("PurInvoiceNo");
%>

<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
	<tr>
		<td><b>Purchase Inv No:</b></td>
		<td style="width: 200px;"><label><%=rsTransaction.getString("PurInvoiceNo")%></label>
		</td>
		<td><b>Purchase Inv Date:</b></td>
		<td><label><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsTransaction.getString("PurInvoiceDate")))%></label>
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
		<th>Selling Price</th>
		<th>Price Entered On</th>

	</tr>
<%
int i=1;
String refMakeNameTable="";
	String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items WHERE PurInvoiceNo ='"+ PurInvNumber + "'  ";

			ResultSet rsPurDet = st.executeQuery(sqlPurDet);
			System.out.println("****************             "+sqlPurDet);
			while (rsPurDet.next()) {
					String makeCode = "", itemCode = "",  quantity, makeName = "",groupName="";
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
						<td><div align="right"><%=rsSql.getString("Partno")%></div></td>
						<td><div align="left"><%=makeName %></div></td>
						<td><div align="left"><%=rsSql.getString("Model")%></div></td>
						<td><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
						<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsSql.getString("EnteredonDate")))%></div></td>
			 	</tr>
<%
					}
				}
	}
%>

</table>
<div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeInvoice" value="close Invoice" onclick="closeInv();"  style="border: outset; background-color: #C6DEFF"  />
</div>

<form name="form2" method="get"  action="closePurInv.jsp" >

<div align="left"  id="header" style="position:absolute;   font-size: 1.1em"><b> &nbsp;Reason For Cancelling :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>
<div align="left"  id="cancellingreason" name="cancellingreason" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="reasonforcancel"
	id="search-text" style='width: 430px; height: 160px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>

<input type="hidden" name="reasonforcancel" value="reasonforcancel"/>
<input type="hidden" name="purinvoiceno" value="<%=PurInvNumber %>"/>

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
	System.out.println("IN Revise     ****   ");
%>	

<%
String PurInvNumber="",SupplierName="",Terms="",Total="";
double Tax=0,Discount=0;
String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurInvoiceNo = '"+ PurEnqRefNumber + "' ";
ResultSet rsTransaction = st.executeQuery(sqlPurchase);
System.out.println("****************             "+sqlPurchase);
if (rsTransaction.next()) 
{
	SupplierName=rsTransaction.getString("SupplierName");		
	
			PurInvNumber=rsTransaction.getString("PurInvoiceNo");
			Terms=rsTransaction.getString("Terms");
			Total=rsTransaction.getString("Total");
			Tax=rsTransaction.getDouble("TaxPercent");
			Discount=rsTransaction.getDouble("DiscountPercent");
			pf=rsTransaction.getString("PFIPercent");
			frieght=rsTransaction.getString("FreightAmount");

			%>
			<form name="revise" method="post" action="RevisePurInvoice.jsp">
			<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
			<tr>
					<td><b>Purchase Inv No:</b></td>
					<td style="width: 200px;"><label><%=rsTransaction.getString("PurInvoiceNo")%></label></td>
					<td><b>Purchase Inv Date:</b></td>
		<td><input type="hidden" name="pidate" id="pidate" value="<%=rsTransaction.getString("PurInvoiceDate")%>"/><label><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsTransaction.getString("PurInvoiceDate")))%></label>
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
		<td><b> Fax:</b></td>
		<td><input type="hidden" name="fax" id="fax" value="<%=rsTransaction.getString("Fax")%>"/><label><%=rsTransaction.getString("Fax")%></label></td>
	</tr>
	<tr>
		
		<td><b>Address:</b><input type="hidden" name="address" id="address" value="<%=rsTransaction.getString("Address")%>"/></td>
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
				<input type="hidden" name="pitime" id="pitime" value="<%=rsTransaction.getString("PurInvoiceTime") %>"/>
				<input type="hidden" name="supinvref" id="supinvref" value="<%=rsTransaction.getString("SupInvoiceRef") %>"/>	
						
			    <input type="hidden" name="discount" id="discount" value="<%=rsTransaction.getString("DiscountPercent") %>"/>
			    <input type="hidden" name="cstmst" id="cstmst" value="<%=rsTransaction.getString("CSTorMST") %>"/>
			    <input type="hidden" name="reason" id="reason" value="<%=rsTransaction.getString("Reason") %>"/>
			    <input type="hidden" name="payDuedate" id="payDuedate" value="<%=rsTransaction.getString("PaymentDueDate") %>"/>
			    <input type="hidden" name="excise" id="excise" value="<%=rsTransaction.getString("ExciseTax") %>"/>
			    <input type="hidden" name="po" id="po"value="<%=rsTransaction.getString("PONo") %>"/>
	   </td>
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
		<th>Selling Price</th>
		<th>Amount</th>

	</tr>
<%
double tax=0,discount=0.00 ,total=0.00;
int i=1;
String refMakeNameTable="",unit="";
	String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items WHERE PurInvoiceNo ='"+ PurInvNumber + "'  ";

			ResultSet rsPurDet = st.executeQuery(sqlPurDet);
			System.out.println("****************             "+sqlPurDet);
			while (rsPurDet.next()) 
			{
					String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
					int groupCode=0;
					makeCode = rsPurDet.getString("Make");
					itemCode = rsPurDet.getString("ItemCode");
					groupCode = rsPurDet.getInt("TheGroup");
					quantity = rsPurDet.getString("Quantity");
                    unit=rsPurDet.getString("UnitPrice");
					System.out.println("Unit Price"+unit);
                    
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
					  
					 //System.out.println("In While");
					
					
%>
					<tr>
							<td><div align="right"><%=i++ %></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="right"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="right"><input type="text"  id="quant<%=d%>" name="quant<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=quantity %>"/></div></td>
	           				
							<td><div align="right"><input type="text"  id="selling<%=d%>" name="selling<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               				border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	              				color: #000000;" value="<%=unit %>" /></div></td>
							<td style="width: 85px;"><div align="right"><input type="text"  id="amount<%=d %>" name="amount<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=amount%>" /></div> </td>
			   
				</tr>
			<input type="hidden" name="groupcode<%=d%>" id="groupcode<%=d %>" value="<%=groupCode%>"/>
			<input type="hidden" name="makecode<%=d%>" id="makecode<%=d %>" value="<%=makeCode%>"/>
			<input type="hidden" name="itemcode<%=d%>" id="itemcode<%=d %>" value="<%=itemCode%>"/>
			<input type="hidden" name="quant<%=d%>" id="quantity<%=d %>" value="<%=quantity  %> "/>
			<input type="hidden" name="selling<%=d%>" id="sellingprice<%=d %>" value="<%=unit  %> "/>
			
<%
          d++;
					}
				}
			 count=i-1;
			 System.out.println(">>>>>>>>>>>>>>>count:="+count);
%>

</table>
<%
}
%>
  <div>&nbsp;</div>		
<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="terms" style='width: 450px; height: 150px;'><%=Terms%></textarea></div>
<div align="right">
<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
</div>
<br></br>	

	<div style="font-size: 1.0em" align="right">
	<b>PF:(Rs)</b>&nbsp;&nbsp;
	<input type="text"  id="pf" name="pf" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=pf%>"/>
    </div>
    <br>
	<div style="font-size: 1.0em" align="right">
	<b>Freight:(Rs)</b>&nbsp;&nbsp;<input type="text" name="frieght" id="frieght" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=frieght%>"/>
	</div>
	 <br></br>
	<div style="font-size: 1.0em" align="right">
	
	<b>Tax:</b>&nbsp;&nbsp;<input type="text" name="tax" id="tax" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=Tax %>"/>
	</div>
	 <br></br>
    <div style="font-size: 1.0em" align="right">
	
	<b>Discount:</b>&nbsp;&nbsp;<input type="text"  id="discount" name="discount" style="width : 70px; padding: 4px 5px 2px 5px;
	               				border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	              				color: #000000;" value="<%=Discount  %>" />
	              				</div>
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text"  name="total" id="total" style="width: 200px; border: none;" value="<%=totalAmount%>"></input>
	<input type="hidden" name="total" id="total" value="<%=totalAmount%>"/>
	</div>
	<div style="font-size: 1.0em" align="right">
	<table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea  name="rupees" id="rupees"   style="width: 230px; border: none;" value="<%=totalAmount%>"></textarea>
		<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
		</td></tr></table>
	</div>
   
	
	<input type="hidden" name="pf" id="pf" value="<%=pf %>"/>
	<input type="hidden" name="freight" id="freight" value="<%=frieght%>"/>
	<input type="hidden" name="count"  id="count" value="<%=count %>"/>
	<input type="hidden" name="PurInvNumber" id="PurInvNumber" value="<%=request.getParameter("transactionId") %>"/>
	<input type="hidden" name="tax" id="tax" value="<%=Tax%>"/>
	<input type="hidden" name="discount" id="discount"  value="<%=Discount %>"/>
	
<br>	
<br></br>	
<br></br>	
<br></br>	
<br></br>	
	<div align="center">
	<input type="submit" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick=""	name="RevisePurInvoice" value="Revise PurInvoice" />
	</div>		
	</br>
	</br>
	


</form>

	<%} %>		


	

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
<%@ include file="footer_new.jsp"%>