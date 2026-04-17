<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
<style type="text/css">
@import url(jscalendar-1.0/calendar-blue.css);
</style>
	
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
<script type="text/javascript" src="convert.js">
	</script>
	
<script>

function hello()
{
	

//	alert("helll");
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("fromdate").value;
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
    var objToDate = document.getElementById("todate").value;
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
     
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
    
    
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }
//         

        return true;
}
</script>
<script language="JavaScript1.2">

function validate()
{
	calculate();
	var cnt=0;
	for(i=0;i<document.generateInvoice.checkedNumber.value;i++)									
		if(document.getElementById('check'+i).checked==true)
			cnt++;
	if(cnt==0)
	{	
		alert("Please select atleast 1 item");
		return false;
	}
            var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('grandTotal').value+"");
    		if (agree){
    		return true ;
    	
    		
    		}else
    			return false ;
		
}

function calculate()
{
	//alert("Hi");
	cnt=0;
	for(i=0;i<document.generateInvoice.checkedNumber.value;i++)									
		if(document.getElementById('check'+i).checked==true)
			cnt++;
	if(cnt==0)
	{
		alert("Please select atleast 1 item");
		document.getElementById('total').value=0;
		document.getElementById('rupees').value='';
	}
	
	var a;	var finaldiscount;
	var totalunitprice;
	var totaldiscount=0;var tax1=0;
	var z; var i;var total;var s=0;var finalamt;
	var igsttaxamt=0;
	var cgsttaxamt=0;
	var sgsttaxamt=0;
	var a1=0,tax2=0;
	var rowCount = document.generateInvoice.checkedNumber.value;
	try{
		 for(i=0;i<rowCount;i++)									
		  {
			  if(document.getElementById('check'+i).checked==true)
			  {
				  s=0;
				var tax=document.getElementById("STPercent"+i).value;
				var cgsttax=document.getElementById("CGST"+i).value;
				var sgsttax=document.getElementById("SGST"+i).value;
				var igsttax=document.getElementById("IGST"+i).value;
				//alert("CGST :- "+cgsttax);
				//alert("SGST :- "+sgsttax);
				//alert("IGST :- "+igsttax);
				var discount=document.getElementById("discountPercent"+i).value;
			//alert("DISCOUNT ENTERED   ::  "+discount);
				var qua=document.getElementById("quantity"+i).value;
				var unitprice=document.getElementById("sellingPrice"+i).value;
				
				totalunitprice=unitprice*qua;	
				//alert("TOTAL UNIT PRIZE   "+totalunitprice);
				if(discount==0){
				totaldiscount=0;}	
				else
				{
				totaldiscount=(discount/100)*totalunitprice;
				}	 
					
				//alert("TOTAL DISCOUNt  "+totaldiscount);
				if(cgsttax==0 && sgsttax==0 && igsttax==0)
					{
					tax1=0;
					
					}
				else
					{
					if(igsttax!=0)
						{
						igsttaxamt=(totalunitprice-totaldiscount) * (igsttax/100);
						//alert(" IGST amt :- "+igsttaxamt);
						tax1=igsttaxamt;
						}
					else
						{
						cgsttaxamt=(totalunitprice-totaldiscount) * (cgsttax/100);
						//alert(" CGST amt :- "+cgsttaxamt);
						
						sgsttaxamt=(totalunitprice-totaldiscount) * (sgsttax/100);
						//alert(" SGST amt :- "+sgsttaxamt);
						tax1=cgsttaxamt+sgsttaxamt;
						}
					
					a=totalunitprice+tax1-totaldiscount;
				//	alert("Total :- "+a);
					a1=a1+a;
					}
				///alert("A1 :- "+a1);
				 if(tax1==0)
				{
			// alert("In If");
					tax1=0;
				a=totalunitprice+tax1-totaldiscount;
				//alert(a);
				a1=a1+a;
				
				//alert("Total :- "+a);
				
				//document.getElementById("amount"+i).value=Math.round(a.toFixed(2));
				
				//z=(document.getElementById("amount"+i).value);
				z=a1;
				s=parseFloat(s)+parseFloat(z);
				
				}
				 else{
					
				//alert("In Else");
					//alert("FINAL AMOUNT  "+a1);		
						//document.getElementById("amount"+i).value=Math.round(a1.toFixed(2));
			
						//z=(document.getElementById("amount"+i).value);
						z=a1;
						//alert("yyyyyyyyyy::::" +s);

						s=parseFloat(s)+parseFloat(z);
						//alert("yyyyyyy222222::::"+s);
					//	alert(z);
					 
				 }
				 
				//alert("TAX TAx   "+tax1);
				//tax1=a;
									
				
				//alert("FINAL AMOUNT  "+s);
				tax2=tax2+tax1;
				//alert(" Total tax  "+tax2);
			  }
			  
			  else{
				  document.getElementById("amount"+i).value=0;
			  }
		   }
	//	alert("yyyyyyy333::::"+s);
		 //document.getElementById("amount"+i).value=parseInt(s);
			document.getElementById('total').value=(s-tax2).toFixed(2);
			var pfi=document.getElementById('pfi').value;
			//alert("pfi:  "+pfi);
			if(pfi=="")
				pfi=0;

            var pfi1=parseFloat(s)*(parseFloat(pfi)/100);
           // alert("new pfi1:  "+pfi1);
			var frieght=document.getElementById('frieght').value;
			if(frieght=="")
				frieght=0;
			
			document.getElementById('grandTotal').value=Math.round(parseFloat(s)+parseFloat(pfi1)+parseFloat(frieght));
	}	

	catch(e){ }

	var junkVal=document.getElementById('grandTotal').value;
	    junkVal=Math.floor(junkVal);
	    var obStr=new String(junkVal);
	     numReversed=obStr.split("");
	    actnumber=numReversed.reverse();

	   if(Number(junkVal) >=0){
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
	            else {
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

function checkAll()
{
	var field=document.getElementsById('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = true ;
	}catch(e){alert(e);}
}

function unCheckAll()
{
var field=document.getElementsById('check');
var i;
try{
for (i = 0; i < field.length; i++)
field[i].checked = false ;
}catch(e){alert(e);}
}

function newwindow(webadd,salesOrderNumber,company)
{ 
		window.open(webadd+'?salesOrderNumber='+salesOrderNumber+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
}


function Redirect1()
{
	
	alert("Invoice Already Generated");
	

window.location.href="home.jsp";
	
	    
	
}
	</script>
	</head>
	<body onload="calculate()">
	
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
<%
	    Connection conn = null;
		Statement st = null, st1 = null, st2 = null, st3 = null,st4 = null,st5 = null,st6 = null,ST123=null,stlbl=null;
		boolean isInvoiceSelected = false;
		 String label1="";
		 String label2="";
		 String label3="";
		 String po="";
		 String deli="";

		double sumAmount = 0, total = 0;
		double total1 = 0;
		int groupCode = 0, makeCode = 0, a = 0;
		String groupName = "", makeName = "", itemCode = "";
		String refMakeNameTable = "";
		String sqlDisplayDesc = " ";
		String words = "",CustomerCode="";
		String sellingPrice = "", priceAccepted = "", quantity = "",salesOrderNumber="";
		String datenew2="",datenew1="";
		String fromDate1="",toDate="",fromDateCal="",toDateCal="",CompanyName="",duedate="",duedate1="";
		String prorefno=request.getParameter("proformaRefNo");
		System.out.println("*(((((*******())(())()****    "+prorefno);
		
		String proformaNumber = request.getParameter("proformaNumber");
		String fromDate = "", terms = "",status="Pending";
		String check = request.getParameter("check");
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_MONTH, -30);
		fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
				.getTime());

		String s = "";
		

		Date today = new Date();
		cal.setTime(today);
		cal.add(Calendar.DAY_OF_MONTH, +30);
		Date today30 = cal.getTime();
		
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		
		toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		duedate1=new SimpleDateFormat("dd-MMM-yyyy").format(today30);

		
	
		if (!(null == request.getParameter("due_date"))){
			duedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("due_date")));
			duedate1=request.getParameter("due_date");
		}

		
		try {
			conn = erp.ReturnConnection();
			st = conn.createStatement();
			st2 = conn.createStatement();
			st1 = conn.createStatement();
			st3 = conn.createStatement();
			st4 = conn.createStatement();
			st5 = conn.createStatement();
			st6 = conn.createStatement();
			ST123 = conn.createStatement();
			stlbl = conn.createStatement();
		} catch (Exception e) {
		}
		
		 int InvoiceGenerated=0;
		 int InvoiceCancelled=0;
			String sqlRef="select InvoiceGenerated,InvoiceCancelled from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where invoiceRefNo='"+prorefno+"' ";
			System.out.println("sqlRef  "+sqlRef);
			Statement strno11=conn.createStatement();
			ResultSet rsreport11 = strno11.executeQuery(sqlRef);
			if(rsreport11.next())
			{
				InvoiceGenerated = rsreport11.getInt("InvoiceGenerated");
				System.out.println("InvoiceGenerated "+InvoiceGenerated);
				
				InvoiceCancelled = rsreport11.getInt("InvoiceCancelled");
				System.out.println("InvoiceCancelled "+InvoiceCancelled);

			}
			
			if((InvoiceGenerated==1)&&(InvoiceCancelled==0) || (InvoiceGenerated==0)&&(InvoiceCancelled==1))
			{
				
				out.println("<script>  Redirect1();</script>");		
		

			} 


		String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
        ResultSet rsdata241= ST123.executeQuery(companydata);
        rsdata241.next();
        String companyname=rsdata241.getString("Companyname");
        String address=rsdata241.getString("address");
        String phone=rsdata241.getString("phone");
        String mail=rsdata241.getString("emailid");
        String website=rsdata241.getString("website");
        String fax=rsdata241.getString("fax");
        String State=rsdata241.getString("state");
		
        DecimalFormat df = new DecimalFormat("0.00");
        NumberFormat formatter = new DecimalFormat("0.00");
		
		String sqlDet ="SELECT InvoiceNo,CustomerCode,InvoiceDate,TheGroup,Total,Discount,CST,PFI,FreightAmt,GrandTotal,Terms,TotalInWords,PONo,PODate,DespatchMode,FreightType,PaymentMode,Insurance,ShippedBy,ShipmentDate,DespCheckListCheckedBy,PackingSlipCheckedBy,DocketFilledBy,InvoiceCancelled,RevofInvoiceNo,NoofRevisions,ReasonForCancelling,SEandSQRefNo,InvoiceTime,InvoiceRaisedby,Annexure,ExpIECno,RBIcodeNo,OtherExpInfo,BuyerOtherThanConsig,CountryOfOrigin,CountryOfFinalDestin,PreCarriageBy,PlaceofRecptByPreCar,PortOfLoading,PortOfDischarge,FinalDestination,NoandKindOfPacking,WeightInKgs,CurrType,CurrValue,TWSalesOrderNo,DebitNote,TWEmpName,InvoiceGenerated,AddressCode,CompanyName,ContactPerson,Address,city,Zip,State,country,Phone,Fax,invoiceRefNo,TWSalesorderRefNo,RevOfinvoiceRefNo,InvoiceType,InvoicePrinted,CustPurON,CustPurDT,InvRaisedBillAdd,InvRaisedShipAdd,InvRaisedConDet,InvRaisedCompName,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue,BillingGSTIN,ShippingGSTIN,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,CASE WHEN DeliveryDate ='0000-00-00' THEN null ELSE DeliveryDate END as DeliveryDate from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet WHERE InvoiceNo='"
					+ proformaNumber + "' ";
			System.out.println(sqlDet);
			ResultSet rsDet = st.executeQuery(sqlDet);
if (rsDet.next()) 
{
	 
     label1=rsDet.getString("FromDate");
	System.out.println("label1:: "+label1);


	
	 po=rsDet.getString("CustPurON");
		System.out.println("po:: "+po);

		 deli=rsDet.getString("DeliveryDate");
			System.out.println("deli:: "+deli);

	
     label2=rsDet.getString("ToDate");
	System.out.println("label2:: "+label2);

     
%>

	 
	 
<%

	
	salesOrderNumber=rsDet.getString("TWSalesorderRefNo");
	CustomerCode=rsDet.getString("CustomerCode");
	terms=rsDet.getString("Terms");
	if(rsDet.getInt("InvoiceGenerated")==1)
		status="Invoice Generated";
	
	if(rsDet.getInt("InvoiceCancelled")==1)
		status="Cancelled";
	%>	
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.5em; margin-bottom:0.2em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.5em">Domestic Order
	Of :<a><%=rsDet.getString("invoiceRefNo")%> </a> For: <a><%=rsDet.getString("CompanyName")%>
	</a></div>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.5em; height: 3px; background-color: #339CCB">
	</div>
	
	<form name="generateInvoice" method="get" action="insertInvoiceFrmProInvc.jsp" onSubmit="return validate();">
	
	 <table border="0" width="100%"><tr>
	 <input type="hidden" name="prorefno" value="<%=prorefno %>"/>
	 <td style="width: 40%">
	 
	 	<div class="TabView" id="TabView">
			<div class="Tabs" style="width: 100%;"><a>SO Details</a>
			<a> CheckList </a>
			<a>SI Raised By </a></div>
			<div class="Pages" style="width: 450px; height: 135px;">
			<div class="Page">
			<div class="Pad">
	 
				<table  align="left" width="100%" cellpadding="3" cellspacing="3">
				<tr>
				<td><b>SO Date:</b></td>
				<td><%=new SimpleDateFormat(
								"dd-MMM-yyyy")
								.format(new SimpleDateFormat( 
										"yyyy-MM-dd")
										.parse(rsDet.getString("InvoiceDate")))%></td>
				
				</tr>
				<tr>
				<td><b>Group:</b></td>
				<td><input type="text" value="-" id="groupTop" readonly="readonly"  name="groupTop" style="border: none;" />
				<input type="hidden" name="addresscode" value="<%= rsDet.getString("AddressCode") %>"/>
				</td>
						<td><b>Currency:</b></td>
				<td><input type="hidden" name="currencyType" value="<%= rsDet.getString("CurrType") %>"  />
				<%= rsDet.getString("CurrType") %>
				</td>
				</tr>
				
				<tr>
				<td><b>Order Ref No:</b></td>
				<td><%= rsDet.getString("TWSalesorderRefNo") %>
				</td>
				
				<td><b>Status:</b></td>
				<td><%= status %>
				</td>
				</tr>
				
				<td><b>DeliveryDate:</b></td>
				<td><%= rsDet.getString("DeliveryDate") %>
				</td>
				
				<tr>
				
				<td><b>PO Date:</b></td>
				<td><%=(rsDet.getString("CustPurDT"))%>
								
								
				</td>
				<td><b>PO No:</b></td>
				<td><%= rsDet.getString("CustPurON") %>
				</td>
				</tr>
				</table>
			
			</div>
			</div>
		
			<div class="Page">
			<div class="Pad">
				<table>
					<tr>
						<td><b>Frieght: </b></td>
						<td>
						<select
							name="frieghtType" id="frieghtType"    style="
					  		width: 120px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
							 >
							 <option>Collect(To Pay)</option>
							 <option>Prepaid(Bill Us)</option>
							 </select>
						 </td>
						 
						 <td><b>Payment Mode: </b></td>
						<td>
						<select
							name="paymentMode" id="paymentMode"    style="
					  		width: 80px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
							 >
							 <option>COD</option>
							 <option>CVC</option>
							 <option>COD/CVC</option>
							 <option>By Us</option>
							 <option>Through Bank</option>
							 </select>
						 </td>
					</tr>
					
					<tr>
						<td><b>Insurance: </b></td>
						<td>
						<select
							name="insurance" id="insurance"    style="
					  		width: 120px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
							 >
							 <option>Ins Cert Enclosed</option>
							 <option>By Customer</option>
							 <option>By Carrier</option>
							 <option>By Us</option>
							 </select>
						 </td>
						 
						 <td><b>Date Of Shipment: </b></td>
						<td>
						<input type="text" id="dateOfShipment"
						name="dateOfShipment" value="<%=fromDate %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
						<script type="text/javascript">
							  Calendar.setup(
							    {
							      inputField  : "dateOfShipment",         // ID of the input field
							      ifFormat    : "%d-%b-%Y",     // the date format
							      button      : "dateOfShipment"       // ID of the button
							    }
							  );
						</script>
			
						 </td>
					</tr>
					
					<tr>
						<td><b>Shipped By: </b></td>
						<td>
			 				<input type="text" name="shippedBy" id="search-text" style="width: 120px;" />
						 </td>
						 
						 <td><b>Docket Filled By: </b></td>
						<td>
			 				<input type="text" name="docketFilledBy" id="search-text" style="width: 120px;" />
						 </td>
					</tr>
					
					<tr>
						<td><b>Checked By: </b></td>
						<td>
			 				<input type="text" name="checkedBy" id="search-text" style="width: 120px;" />
						 </td>
						 
						 <td><b>Packing Slip Checked By: </b></td>
						<td>
			 				<input type="text" name="packingSlipCheckedBy" id="search-text" style="width: 120px;" />
						 </td>
					</tr>
					
				</table>
			 </div>
			 </div>
			 
			<div class="Page">
			<div class="Pad">
			<div align="center">
				<textarea  name="SIRaisedBy" rows="4" id="search-text"
				style='width: 300px; height: auto; margin-top: 1em; '>Transworld Compressor Technologies Ltd.
C-3/8,Rakshalekha
KoregaonPark,Pune-411001</textarea>
			 	</div>
			 </div>
			 </div>
			 
		</div>
		</div>
			 
	<script type="text/javascript">
		tabview_initialize('TabView');
	</script>
	
	</td>
	
	<%
	
	if(label1==null || label1=="null" || label1.equals("null"))
	{
		label1="0000-00-00";
	}
	else
	{%>
	
	<td align="left">
	<b>From::</b>
	<%=new SimpleDateFormat(
								"dd-MMM-yyyy")
								.format(new SimpleDateFormat( 
										"yyyy-MM-dd")
										.parse(label1))%>	
	<%}
	%>
	
		</td>
			<%
	
	if(label2==null || label2=="null" || label2.equals("null"))
	{
		label2="0000-00-00";
	}
	else
	{%>
	
	<td align="left">
	<b>To::</b>
	<%=new SimpleDateFormat(
								"dd-MMM-yyyy")
								.format(new SimpleDateFormat( 
										"yyyy-MM-dd")
										.parse(label2))%>	
	<%}
	%>
	
		</td>
	
	<td align="left">
	<b>Duedate</b>
 <input type="text" id="due_date"
	name="due_date" value="<%=duedate1 %>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 				
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "due_date",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "due_date"       // ID of the button
	}
	);
	</script>

	
	
	
	
	
	
	<td><input type="hidden" name="customercode" value="<%=rsDet.getString("CustomerCode")%>"/>
		<table  bgcolor="#C6DEFF" align="right" valign="top" cellpadding="3" cellspacing="3" >
		<tr>
		<td><b>Cust name:</b></td>
		<td><input type="hidden" name="company" value="<%=rsDet.getString("CompanyName") %>"/><%=rsDet.getString("CompanyName") %></td>
		<td><b>Contact Person:</b></td>
		<td><%=rsDet.getString("ContactPerson") %></td>
		<td><b>Address:</b></td>
		<td style="width: 250px;"><%=rsDet.getString("Address") %></td>
		</tr>
		<tr>
		<td><b>City:</b></td>
		<td><%=rsDet.getString("city") %></td>
		<td><b>State:</b></td>
		<td><%=rsDet.getString("State") %></td>
		<td><b>Country:</b></td>
		<td><%=rsDet.getString("country") %></td>
		</tr>
		<tr>
		<td><b>Phone:</b></td>
		<td><div align="left"><%=((rsDet.getString("Phone")!=null) ? rsDet.getString("Phone") : "-") %></div></td>
		<td><b>Fax:</b></td>
		<td><div align="left"><%=((rsDet.getString("Fax")!=null) ? rsDet.getString("Fax") : "-") %></div></td>
		<td><b>Zip code:</b></td>
		<td><div align="left"><%=((rsDet.getString("Zip")!=null) ? rsDet.getString("Zip") : "-") %></div></td>
		</tr>
	<%}%>        		
	   	</table>
   	
   	</td></tr></table>
<br></br>
	<table  align="center" class='sortable'>
	<tr>
	<th style="width: 125px;">Sr No</th>
	<%
		String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
	<th>Quantity</th>
	<th>Unit prize</th>
	<th>Discount %</th>
	<th>CGST %</th>
	<th>SGST %</th>
	<th>IGST %</th>
	<!-- <th>Tax %</th> -->
	<th>Amount</th>
	</tr>	
	<%
			String sqlEnq = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items WHERE InvoiceNo='"
						+ proformaNumber + "'";
				int i = 0;
				ResultSet rsEnq = st1.executeQuery(sqlEnq);
			while (rsEnq.next()) {

					groupName = "";
					makeName = "";
					refMakeNameTable = "";

					double amount = 0.00;

					groupCode = rsEnq.getInt("TheGroup");

					makeCode = rsEnq.getInt("Make");
					itemCode = rsEnq.getString("ItemCode");

					String sqlGroup = "SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"
							+ groupCode + "'";
					ResultSet rsGroup = st2.executeQuery(sqlGroup);
					if (rsGroup.next())
						groupName = rsGroup.getString("TheGroupName");
					if (groupCode < 5) {
						refMakeNameTable = session.getAttribute("CompanyMasterID").toString()+"tbl_" + groupName.substring(0, 5)
								+ "makemaster";

						String sqlMakename = "SELECT MakeName FROM "
								+ refMakeNameTable.toLowerCase()
								+ "  WHERE makecode='" + makeCode + "' ";

						ResultSet rsMakeName = st3.executeQuery(sqlMakename);
						if (rsMakeName.next())
							makeName = rsMakeName.getString(1);
						else
							makeName = "-";
		%>

	<script type="text/javascript">
	document.getElementById('groupTop').value='<%=groupName%>';
	  
	  </script>
	  <%
	  	sqlDisplayDesc = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"
	  						+ groupName.substring(0, 5).toLowerCase()
	  						+ "im_make" + makeCode + " where ItemCode='"
	  						+ itemCode + "'";
	  			} else {
	  				sqlDisplayDesc = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"
	  						+ groupCode + " where ItemCode='" + itemCode
	  						+ "' ";
	  				makeName = "-";
	  			}


	  			ResultSet rsDetails1 = st.executeQuery(sqlDisplayDesc);
	  			while (rsDetails1.next()) {

	  				String Sql = "SELECT * FROM  "+ rsEnq.getString("TheTableToBeAccessed").toLowerCase() + " WHERE ItemCode='"
	  						+ itemCode + "' ";

	  				ResultSet rsSql = st2.executeQuery(Sql);

					while (rsSql.next()) 
					{
						String taxrate="select ItemCode,SACCode,HSNCode,Description,ServiceCategory  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitems where ItemCode="+itemCode+" and ServiceCategory!='-' ";
						
						ResultSet rstaxrate=st4.executeQuery(taxrate);
						
						
						String SACCode="",HSNCode="",ServiceCategory="";
						double rate=0.00,CGST=0.00,SGST=0.00,IGST=0.00;
						if(rstaxrate.next())
						{
							System.out.println("HSN SAC code :- "+taxrate);
							SACCode=rstaxrate.getString("SACCode");
							HSNCode=rstaxrate.getString("HSNCode");
							
							 %>
							 <input type="hidden" id="SACCode" name="SACCode" value="<%=SACCode%>"/>
							 <input type="hidden" id="HSNCode" name="HSNCode" value="<%=HSNCode%>"/>
							 <% 
							ServiceCategory=rstaxrate.getString("ServiceCategory");
							String dynamictaxrate="";
							 if(SACCode.equals("-"))
							{
							dynamictaxrate="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"GSTINRateMaster where Code='"+HSNCode+"' and Category='"+ServiceCategory+"' ";
							}
							else
							{
								dynamictaxrate="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"GSTINRateMaster where Code='"+SACCode+"' and Category='"+ServiceCategory+"' ";
							}
							
							ResultSet rsdynamictaxrate=st5.executeQuery(dynamictaxrate);
							System.out.println(" Tax Rate :- "+dynamictaxrate);
							if(rsdynamictaxrate.next())
							{
								rate=rsdynamictaxrate.getDouble("TaxRate");
							} 
							
							//rate=18;
							
							String custmaster="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+CustomerCode+"'";
							System.out.println(" cust amster :- "+custmaster);
							ResultSet rscustmaster=st6.executeQuery(custmaster);
							System.out.println(" cust amster :- "+custmaster);
							String ShippingState="",BillingState="",Shipstin="",Billgstin="";
							if(rscustmaster.next())
							{
								ShippingState=rscustmaster.getString("ShippingState");
								if(ShippingState.equals("null") || ShippingState==null || ShippingState=="" || ShippingState==" ")
								{
									ShippingState=rscustmaster.getString("BillingState");
								}
							
								double qty=rsEnq.getDouble("Quantity");
								double SellPrice=rsEnq.getDouble("SellingPrice");
								double discount=rsEnq.getDouble("DiscountPercent");
								double cgsttax=0.00;
								double sgsttax=0.00;
								double igsttax=0.00;
								double totaldiscount=(discount/100)*(qty*SellPrice);
								amount=(qty*SellPrice)-totaldiscount;
							
							if(State.equals(ShippingState))
							{
								CGST=rate/2;
								 cgsttax=amount*(CGST/100);	
								SGST=rate/2;
								 sgsttax=amount*(SGST/100);
								
							}
							else
							{
								IGST=rate;
								 igsttax=amount*(IGST/100);	
							}
							System.out.println("CGSTTAx :-"+cgsttax);
							System.out.println("SGSTTAx :-"+sgsttax);
						amount=amount+igsttax+cgsttax+sgsttax;
						System.out.println("amount :-"+amount);
							
							}
						
						  %>
					<tr>
						<td><input type="checkbox" checked="checked" name="check<%=i%>"   id="check<%=i%>" value="check<%=i%>" /></td>
						<td><div align="left"><%=makeName%></div></td>
						<td><div align="left"><%=rsSql.getString("Model")%></div></td>
						<td><div align="right"><%=rsSql.getString("Partno")%></div></td>
						
						<td>
							<div align="left">
								<input type="hidden" id="description<%=i%>" name="description<%=i%>" value="<%=rsEnq.getString("ItemDescription")%>" />
								<%=rsEnq.getString("ItemDescription")%>
							</div>
						</td>
						
						<td style="width: 85px;">
							<input type="text"  id="quantity<%=i%>" name="quantity<%=i%>" style="width:70px; padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="<%=rsEnq.getString("Quantity")%>" readonly/>
						</td>
						
						<td style="width: 85px;">
							<input type="text" id="sellingPrice<%=i%>" name="sellingPrice<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="<%=rsEnq.getString("SellingPrice")%>" readonly/>
						</td>
						
						<td style="width: 85px;">
							<input type="text" id="discountPercent<%=i%>" name="discountPercent<%=i%>" style="width:70px; padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000;text-align: right; " value="<%=rsEnq.getString("DiscountPercent")%>"readonly/>
						</td>
						
						<td style="width: 85px;">
							<input type="text" id="CGST<%=i%>" name="CGST<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="<%=formatter.format(CGST)%>" readonly/>
						</td>
						<td style="width: 85px;">
							<input type="text" id="SGST<%=i%>" name="SGST<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="<%=formatter.format(SGST)%>" readonly/>
						</td>
						<td style="width: 85px;">
							<input type="text" id="IGST<%=i%>" name="IGST<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
							border: none;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="<%=formatter.format(IGST)%>" readonly/>
						</td>
						
						
						
						<td style="width: 85px;">
							<input type="text" id="amount<%=i%>" name="amount<%=i%>" style="text-align:right; width:70px;padding: 4px 5px 2px 5px;
							border: none;	background: inherit;	
							" value="<%=formatter.format(amount)%>" readonly/>
							
								
							<input type="hidden" id="quantity<%=i%>" name="quantity<%=i%>" value="<%=rsEnq.getString("Quantity")%>" />
							<input type="hidden" id="discountPercent<%=i%>" name="discountPercent<%=i%>" value="<%=rsEnq.getString("DiscountPercent")%>"/>
							<input type="hidden" id="STPercent<%=i%>" name="STPercent<%=i%>" value="<%=rsEnq.getString("STPercent")%>"/>
							<input type="hidden" id="CGST<%=i%>" name="CGST<%=i%>" value="<%=formatter.format(CGST)%>"/>
							<input type="hidden" id="SGST<%=i%>" name="SGST<%=i%>" value="<%=formatter.format(SGST)%>"/>
							<input type="hidden" id="IGST<%=i%>" name="IGST<%=i%>" value="<%=formatter.format(IGST)%>"/>
							<input type="hidden" id="sellingPrice<%=i%>" name="sellingPrice<%=i%>" value="<%=rsEnq.getString("SellingPrice")%>"/>
							<input type="hidden" id="mcode<%=i%>" name="mcode<%=i%>" value="<%=makeCode%>"/>
							<input type="hidden" id="icode<%=i%>" name="icode<%=i%>" value="<%=itemCode%>"/>
							<input type="hidden" id="gcode<%=i%>" name="gcode<%=i%>" value="<%=groupCode%>"/>
						</td>
					</tr>


					<%
						i++;
									}
			}

		}
			}
%>
	</table>
<br>
<input type="hidden" name="label1" id="label1" value="<%=label1 %>"/>
	 	 <input type="hidden" name="label2" id="label2" value="<%=label2 %>"/>
	 	 	 <input type="hidden" name="label3" id="label3" value="<%=label3 %>"/>
	 	 				<input type="hidden" id="POO" name="POO" value="<%=po%>" />
	 	 	 	 				<input type="hidden" id="deli" name="deli" value="<%=deli%>" />
	 	 
				<input type="hidden" id="SONumber" name="SONumber" value="<%=salesOrderNumber%>" />
				<input type="hidden" id="PInNumber" name="PInNumber" value="<%=proformaNumber%>" />
				<input type="hidden" id="group" name="group" value="<%=groupName%>"/>
				
			    <input type="hidden" name="twempname" id="twempname" value='<%=session.getAttribute("EmpName")%>'/>
				<input type="hidden" id="check" name="chk" value="<%=check%>" />  
				<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i%>"/>
					 
			<div align="left"   style="position:absolute;   font-size: 1.1em">
			<b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="search-text" style='width: 450px; height: 150px;'><%=terms%></textarea></div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b>&nbsp;&nbsp; &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" 
	 style="width: 75px; border: none;" value=""/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	  <div style="font-size: 1.0em" align="right">
	 <b>P & F & I(%):</b> &nbsp;&nbsp;<input type="text" name="pfi" id="pfi" 
							style="width:70px;padding: 4px 5px 2px 5px;
							border: 1px solid black;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	 <div style="font-size: 1.0em" align="right">
	 <b>Frieght:</b> &nbsp;&nbsp;<input type="text" name="frieght" id="frieght" 
							style="width:70px;padding: 4px 5px 2px 5px; margin-top:0.1em;
							border: 1px solid black;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
							color: #000000; text-align: right;" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	
		<div style="font-size: 1.0em;margin-top: 0.1em;" align="right" >
	 <b>Grand Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly"  name="grandTotal" id="grandTotal" 
	style="width: 75px; border: none;"/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words :</b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
		<div align="right" style="margin-bottom: 0.1em;">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 150px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	
		

	<div align="right" >
		<input type="submit"  name="submitOrder"
	value="Save Invoice"  onclick="return hello()" style="border: outset; background-color: #C6DEFF; width: 150px; " />
	</div>
	
	</form>
	
<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>