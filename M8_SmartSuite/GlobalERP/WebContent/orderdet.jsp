<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%> --%>
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
	
	<script src="sorttable.js" type="text/javascript"></script>
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/footer.css" rel="stylesheet" type="text/css"
		media="screen" />
		<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
		
	
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
	</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	<script type="text/javascript" src="convert.js">
	</script>
<script language="JavaScript1.2">

function validate()
{
	var so=document.geneOrder.SON.value;
	var sd=document.geneOrder.SOD.value;
	var sd1=document.geneOrder.SOD1.value;

	
	if(sd>sd1)
		{
		alert("Please Do not Select Customer PO Date Greater than Delivery Date");
return false;
		//alert("hhhh");
		}
	//alert(sd);
	//alert(sd1);

	
	if(sd=="Select")
	{
		alert("Please Select PO Date");
		return false;
	}
	
	
	if(sd1=="Select")
	{
		alert("Please Select delivery date");
		return false;
	}
	
	if(so=="")
	{
		alert("Please Enter Customer Purchase Order No.");
		return false;
	}
	
	if(so=="-")
	{
		alert("Please Do Not Enter '-' as Customer Purchase Order No.");
		return false;
	}
	calculate();
	var cnt=0;
	for(i=0;i<document.geneOrder.checkedNumber.value;i++)									
		if(document.getElementById('check'+i).checked==true)
			cnt++;
	if(cnt==0)
	{	
		alert("Please select atleast 1 item");
		return false;
	}
	 
	
            var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('total').value+"");
    		if (agree)
    			return true ;
    		else
    			return false ;
}

function calculate()
{
	var a=0;var k=0;
	var rowCount = document.geneOrder.checkedNumber.value;
	for(k=0;k<rowCount;k++)
	{
		var tax=document.getElementById("STPercent"+k).value;
		var discount=document.getElementById("discountPercent"+k).value;
		var qua=document.getElementById("quantity"+k).value;
		
		var unitprice=document.getElementById("sellingPrice"+k).value;
		var discount1=((discount)*unitprice/100);
		//alert("disc"+discount1);
		var afterdiscprice=unitprice-discount1;
		//alert("aft disc"+afterdiscprice);
		var tax1=((tax)*afterdiscprice)/100;
		//alert("aft tax"+tax1);
		unitprice++;
		unitprice--;
		tax1++;
		tax1--;
		a=unitprice+tax1;
		//alert("a vvv"+a);
		a=a-discount1;
		//alert("a vvv11"+a);
		var bb=a*qua;
		//alert("valll"+bb);
		a++;
		a--;
		
		//alert("after calc-->"+a);
		//var tax1=(tax)/100*unitprice*qua;
		//var discount1=(discount)/100*unitprice*qua;
		 
		//a=unitprice*qua+tax1-discount1;
		document.getElementById("amount"+k).value=bb.toFixed(2);
	}	
		var rowCount = document.geneOrder.checkedNumber.value; 
		var z; 
		var i;
		var total;
		var s=0;
		var sss=0;
		for(i=0;i<rowCount;i++)
		{
			//alert("Inside Addition");
			var z=(document.getElementById("amount"+i).value);
			//alert("val of amt=====>"+z);
			s=parseFloat(s)+parseFloat(z);
			sss=s+z;
			//alert("after round of"+s);
		}
		//var s1=s1+s;
		var s = Math.round(s).toFixed(2); // "160678.00"

		//alert("after round S111111 "+s);
		document.getElementById('total').value=s;



	    var junkVal=document.getElementById('total').value;
	    /* alert("junkVal-----------"+junkVal);
	    if(junkVal.indexOf('.')!=-1)
		{
		junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);
		
		alert("In junkVal paisa"+junkVal);
		if(junkVal.length==0 || junkVal.length=='00')
		{
			
		}
		else
			{
			junkVal1=junkVal.replace("junkVal","");
			alert("in calculate junkVal1-------"+	junkVal1);
			}*/
			
	   junkVal=Math.floor(junkVal); 
	    var obStr=new String(junkVal);
	 
	 
	     numReversed=obStr.split("");
	     actnumber=numReversed.reverse();
	 //    alert("Number1--------------"+actnumber);
	 
	  var result = sss.lastIndexOf(".");
	     
	    // alert("result--before-"+ result);

	     result = sss.substring(sss.lastIndexOf(".")+1);
	   //  alert("result---"+ result);
	     
	     

	   if(Number(junkVal) >=0){
	        //do nothing
	    }
	    else{
	    alert('wrong Number cannot be converted');
	    return false;
	    }
	    /* if(Number(junkVal)==0){
	        document.getElementById('container').innerHTML=obStr+''+'Rupees Zero Only';
	        return false;
	    } */
	    if(actnumber.length>9){
	        alert('Oops!!!! the Number is too big to covertes');
	        return false;
	    }
	 
	    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
	    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
	    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninty' ];
	 
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
	            inWords[j]=inWords[j];
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
	    //document.getElementById('rupees').value=finalWord;
	return finalWord;
	    
}
function calculate1()
{
	var a=0;var k=0;
	var rowCount = document.geneOrder.checkedNumber.value;
	for(k=0;k<rowCount;k++)
	{
		var tax=document.getElementById("STPercent"+k).value;
		var discount=document.getElementById("discountPercent"+k).value;
		var qua=document.getElementById("quantity"+k).value;
		
		var unitprice=document.getElementById("sellingPrice"+k).value;
		var discount1=((discount)*unitprice/100);
		//alert("disc"+discount1);
		var afterdiscprice=unitprice-discount1;
		//alert("aft disc"+afterdiscprice);
		var tax1=((tax)*afterdiscprice)/100;
		//alert("aft tax"+tax1);
		unitprice++;
		unitprice--;
		tax1++;
		tax1--;
		a=unitprice+tax1;
		//alert("a vvv"+a);
		a=a-discount1;
		//alert("a vvv11"+a);
		var bb=a*qua;
		//alert("valll"+bb);
		a++;
		a--;
		
		//alert("after calc-->"+a);
		//var tax1=(tax)/100*unitprice*qua;
		//var discount1=(discount)/100*unitprice*qua;
		 
		//a=unitprice*qua+tax1-discount1;
		document.getElementById("amount"+k).value=bb.toFixed(2);
	}	
		var rowCount = document.geneOrder.checkedNumber.value; 
		var z; 
		var i;
		var total;
		var s=0;
		var sss=0;
		for(i=0;i<rowCount;i++)
		{
			//alert("Inside Addition");
			var z=(document.getElementById("amount"+i).value);
			//alert("val of amt=====>"+z);
			
			//alert("z----------------"+z);
			s=parseFloat(s)+parseFloat(z);
			sss=s+z;
			//alert("after round of"+s);
		}
		var s1=z;
		//alert("s1------------------"+s1);
		//document.getElementById('total').value=s1;



	    var junkVal=document.getElementById('total').value;
	   // alert("junkVal--------------"+junkVal);

	    if(junkVal.indexOf('.')!=-1)
{
	    	

junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);
}

	   //junkVal=Math.floor(junkVal); 
	    var obStr=new String(junkVal);
	 

	    numReversed=obStr.split("");
	     actnumber=numReversed.reverse();
	      var result = sss.lastIndexOf(".");
 

 result = sss.substring(sss.lastIndexOf(".")+1);
 


	   if(Number(junkVal) >=0){
	        //do nothing
	    }
	    else{
	    alert('wrong Number cannot be converted');
	    return false;
	    }
	    if(Number(result)==0){
	        document.getElementById('container').innerHTML=obStr+''+'Rupees Paisa Only';
	        return false;
	    }
	    if(actnumber.length>9){
	        alert('Oops!!!! the Number is too big to covertes');
	        return false;
	    }
	 
	    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
	    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
	    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninty' ];
	 
	    var iWordsLength=numReversed.length;
	    var totalWords="";
	    var inWords=new Array();
	    var finalWord1="";
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
	            inWords[j]=inWords[j];
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
	    finalWord1+=inWords[i];
	}
	    //document.getElementById('rupees').value=finalWord1;
	return finalWord1;

}
function convert_amount_into_rupees_paisa()

{
	//alert("Hi");
var finalWord1 = calculate();

//alert("finalWord1-----------"+finalWord1);
var finalWord2 = "";


 var junkVal=document.getElementById('total').value;
 var actual_junkVal=document.getElementById('total').value;
 
 
if(junkVal.indexOf('.')!=-1)
{
junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);



if(junkVal==0 || junkVal=='00')
{
finalWord2 = "zero paisa only";
}
else
{
finalWord2 = calculate1() + " paisa only";
}
//alert("finalWord1------------"+finalWord1+".......finalWord2.."+finalWord2);

document.getElementById('rupees').value=finalWord1 +" Rupees and "+finalWord2;
}
else
{
document.getElementById('rupees').value=finalWord1 +" Rupees Only";
}
/* finalWord2="and "+calculate1() +" paisa only";

document.getElementById('rupees').value = finalWord1 +" Rupees "+finalWord2; */
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

function newwindow(webadd,salesquono,company)
{ 
	window.open(webadd+'?salesquono='+salesquono+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
}



function Redirect1()
{
	
	alert("Order Already Generated");
	

window.location.href="home.jsp";
	
	    
	
}



	</script>
	</head>
	
	<body onload="convert_amount_into_rupees_paisa()">
	
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
<%
	Connection conn = null;
		Statement st = null, st1 = null, st2 = null, st3 = null,stlbl=null;
		boolean isInvoiceSelected = false;

		double sumAmount = 0, total = 0;
		double total1 = 0;
		int groupCode = 0, makeCode = 0, a = 0;
		String groupName = "", makeName = "", itemCode = "";
		String refMakeNameTable = "";
		String sqlDisplayDesc = " ";
		String words = "";
		String sellingPrice = "", priceAccepted = "", quantity = "";
		String company = request.getParameter("CompanyName");
		System.out.println(company);
		String salesquorefno = request.getParameter("SalesQuoRefNo");
		System.out.println("salesquorefno  "+salesquorefno);

		String salesquono = request.getParameter("SalesQuoNo");
		System.out.println("salesquono"+salesquono);

/* 		String acc = request.getParameter("acc");
		System.out.println("acc"+acc); 
		/*  */
		String exdate = request.getParameter("date111");

		String fromDate = "", terms = "";
		String check = request.getParameter("check");

		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
				.getTime());

		String s = "";
		try {
			conn = erp.ReturnConnection();
			st = conn.createStatement();
			st2 = conn.createStatement();
			st1 = conn.createStatement();
			st3 = conn.createStatement();
			stlbl = conn.createStatement();
		} catch (Exception e) {
		}
		
		
		
		int ThisIsSalesOrder=0;
			String sqlRef="select ThisIsSalesOrder from " +session.getAttribute("CompanyMasterID").toString()+"salesquo_det where SalesQuoNo='"+salesquono+"' ";
			System.out.println("sqlRef  "+sqlRef);
			Statement strno11=conn.createStatement();
			ResultSet rsreport11 = strno11.executeQuery(sqlRef);
			if(rsreport11.next())
			{
				ThisIsSalesOrder = rsreport11.getInt("ThisIsSalesOrder");
				System.out.println("ThisIsSalesOrder "+ThisIsSalesOrder);

			}
			
			if(ThisIsSalesOrder==1)
			{
				out.println("<script>  Redirect1();</script>");		

				System.out.println("ThisIsSalesOrder "+ThisIsSalesOrder);

			} 
			
			%>
						<input type="hidden" name="ThisIsSalesOrder"  id="ThisIsSalesOrder" value="<%=ThisIsSalesOrder%>"></input>
			
			<%

%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.5em; margin-bottom:0.2em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.5em">Domestic Quotation
	Of :<a><%=request.getParameter("SalesQuoRefNo")%> </a> For: <a><%=request.getParameter("CompanyName")%>
	</a> </a></div>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.5em; height: 3px; background-color: #339CCB">
	</div>

	<form name="geneOrder" method="get" action="insertorder.jsp" onSubmit="return validate();">
	<%
		String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"
					+ salesquono + "' ";
			System.out.println(sqlDet);
			ResultSet rsDet = st.executeQuery(sqlDet);
			if (rsDet.next()) {
	%>	
 
	
	<table  border="0" align="left" valign="top" width="100%" cellpadding="3" cellspacing="3">
	
	<tr>
	<td><b>SQ Date:</b></td>
	<td><input type="hidden" name="salesquodate" value="<%=rsDet.getString("SalesQuoDate")%>"/><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd").parse(rsDet
													.getString("SalesQuoDate")))%></td>
	<td><b>SQ Time:</b></td>
	<td><input type="hidden" name="salesquotime" value="<%=rsDet.getString("SalesQuoTime")%>"/><%=rsDet.getString("SalesQuoTime")%></td>
	<td><b>Contact Person:</b></td>
	<td style="width: 250px;"><input type="hidden" name="contactperson" value="<%=rsDet.getString("ContactPerson")%>"/><%=rsDet.getString("ContactPerson")%></td>
	
	<td><b>SQ ExpiryDate:</b></td>
	<td>
	<div>
	<%-- <input type="text" id="fromdate"
	name="fromdate" value="<%=fromDate%>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "fromdate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "fromdate"       // ID of the button
	}
	);
	</script> --%>
	
	<label><%=exdate %></label>
	
	</div></td>
	</tr>

	<tr>
	<td><b>Cust Category:</b></td>
	<td><input type="hidden" name="" id="" value="-"/></td>
	<td><b>Address:</b></td>
	<td style="width: 300px;"><input type="hidden" name="address" value="<%=rsDet.getString("Address")%>"/><%=rsDet.getString("Address")%></td>
	

	<td><b>Customer Code:</b></td>
	<td><input type="hidden" name="customercode" value="<%=rsDet.getString("CustomerCode")%>"/><%=rsDet.getString("CustomerCode")%></td>
	
	<td><b>City:</b></td>
	<td><input type="hidden" name="city" value="<%=rsDet.getString("city")%>"/><%=rsDet.getString("city")%></td>
	</tr>
	
	<tr>
	<td><b>State:</b></td>
	<td><input type="hidden" name="state" value="<%=rsDet.getString("State")%>"/><%=rsDet.getString("State")%></td>
	<td><b>Country:</b></td>
	<td><input type="hidden" name="country" value="<%=rsDet.getString("Country")%>"/><%=rsDet.getString("Country")%></td>
	<td><b>Zip Code:</b></td>
	<td><input type="hidden" name="zip" value="<%=rsDet.getString("Zip")%>"/><%=rsDet.getString("Zip")%></td>
	<td><b>Phone:</b></td>
	<td><input type="hidden" name="phone" value="<%=rsDet.getString("Phone")%>"/><%=rsDet.getString("Phone")%></td>
	</tr>
	
	<tr>
	<td><b>TWSales RefNo:</b></td>
	<td><input type="hidden" name="twsalesrefno" value="<%=rsDet.getString("TWSalesRefNo")%>"/><%=rsDet.getString("TWSalesRefNo")%></td>
	
	<td><b>Fax:</b></td>
	<td><input type="hidden" name="fax" value="<%=rsDet.getString("Fax")%>"/><%=rsDet.getString("Fax")%></td>
	<td><b>address code:</b></td>
	<td><input type="hidden" name="addresscode" value="<%=rsDet.getString("AddressCode")%>"/><%=rsDet.getString("AddressCode")%></td>
	<td><b>Group :</b></td>
	<td><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></td>
	</tr>
	
	
	<tr>
	<td colspan="2" align="right"><b>Customer PO No.:</b></td>
	
	<td align="left"><input type="text" id="SON"  name="SON" /></td>
	
	</tr>
	<tr>
	<td colspan="2" align="right"><b>Customer PO Date :</b></td>

	<td align="left">
	<input type="text" id="SOD"
	name="SOD" value="Select" size="15" readonly
	style="width: 100px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "SOD",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "SOD"       // ID of the button
	}
	);
	</script>
	
	
	</td>
	</tr>
	
	<tr>
	<td colspan="2" align="right"><b>Delivery Date :</b></td>

	<td align="left">
	<input type="text" id="SOD1"
	name="SOD1" value="Select" size="15" readonly
	style="width: 100px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "SOD1",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "SOD1"       // ID of the button
	}
	);
	</script>
	
	
	</td>
	</tr>
	
			
<%
					terms = rsDet.getString("TermsAndConditions");
			}
%>  
	</table> 
<br></br>
	<table  align="center" class='sortable'>
	<tr>
		<th style="width: 125px;">Check</th>
		<th>Option No</th>
		<th>Insert Or</th>
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
		<th>Tax %</th>
		<th>Amount</th>
	</tr>	
	<%
			String sqlEnq = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"
						+ salesquono + "'";

				System.out.println(sqlEnq);
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

					//System.out.println("++++++++++++++++++++++++++++++++++++");

					String sqlGroup = "SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"
							+ groupCode + "'";
					ResultSet rsGroup = st2.executeQuery(sqlGroup);
					if (rsGroup.next())
						groupName = rsGroup.getString("TheGroupName");
					if (groupCode < 5) {
						refMakeNameTable =session.getAttribute("CompanyMasterID").toString()+"tbl_" + groupName.substring(0, 5)
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

	  			System.out.print("?????=>" + sqlDisplayDesc);

	  			System.out.println(">>>>>>>>>  " + sqlDisplayDesc);
	  			ResultSet rsDetails1 = st.executeQuery(sqlDisplayDesc);
	  			while (rsDetails1.next()) {

	  				String Sql = "SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed")
	  								.toLowerCase() + " WHERE ItemCode='"
	  						+ itemCode + "' ";

	  				System.out.println(Sql);
	  				ResultSet rsSql = st2.executeQuery(Sql);

	  				while (rsSql.next()) {
	  %>
	<tr>
	<td><input type="checkbox" checked="checked" name="check<%=i%>"   id="check<%=i%>" value="check<%=i%>" /></td>
	<td><div align="right"><%=rsEnq.getString("TheOptionNo")%></div></td>
	<td><div align="right"><%=rsEnq.getString("InsertOR")%></div></td>
	<td><div align="left"><%=makeName%></div></td>
	<td><div align="left"><%=rsSql.getString("Model")%></div></td>
	<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
	<td><div align="left"><input type="hidden" id="description<%=i%>" name="description<%=i%>" value="<%=rsSql.getString("Description")%>"><%=rsSql.getString("Description")%></div></td>
	<td style="width: 85px;"><input type="text" id="quantity<%=i%>" name="quantity<%=i%>" style="width:70px; padding: 4px 5px 2px 5px;
	border: none; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("Quantity")%>" readonly/></div></td>
	
	<td style="width: 85px;"><div align="right"><input type="text" id="sellingPrice<%=i%>" name="sellingPrice<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border: none; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("SellingPrice")%>" readonly/></div></td>
	
	<td style="width: 85px;"><div align="right"><input type="text" id="discountPercent<%=i%>" name="discountPercent<%=i%>" style="width:70px; padding: 4px 5px 2px 5px;
	border:  none; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("DiscountPercent")%>" readonly/></div></td>
	
	<td style="width: 85px;"><div align="right"><input type="text" id="STPercent<%=i%>" name="STPercent<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border: none; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("STPercent")%>" readonly/></div></td>
	
	<td style="width: 85px;"><div align="right"><input type="text" id="amount<%=i%>" name="amount<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background: inherit;" value="<%=amount%>" readonly/></div></td>



	</tr>
	<input type="hidden" id="companyname" name="companyname" value="<%=company%>">
		<input type="hidden" id="group" name="group" value="<%=groupName%>">
		<input type="hidden" id="mcode<%=i %>" name="mcode<%=i %>" value="<%=makeCode%>"/>
		<input type="hidden" id="icode<%=i %>" name="icode<%=i %>" value="<%=itemCode%>"/>
		<input type="hidden" id="gcode<%=i %>" name="gcode<%=i %>" value="<%=groupCode%>"/>
		<input type="hidden" id="quantity<%=i%>" name="quantity<%=i%>" value="<%=rsEnq.getString("Quantity")%>">
		<input type="hidden" id="discountPercent<%=i%>" name="discountPercent<%=i%>" value="<%=rsEnq.getString("DiscountPercent")%>">
		<input type="hidden" id="STPercent<%=i%>" name="STPercent<%=i%>" value="<%=rsEnq.getString("STPercent")%>">
		<input type="hidden" id="sellingPrice<%=i%>" name="sellingPrice<%=i%>" value="<%=rsEnq.getString("SellingPrice")%>">
<%
	i++;
				}
			}

		}
%>
	</table>
	<%
		if (!(session.getAttribute("userLevel").toString()
					.equalsIgnoreCase("level5"))) {
	%>
    <input type="hidden" name="twempname" id="twempname" value='<%=session.getAttribute("EmpName")%>'/>
	 <%
	 	}
	 %>
	 <input type="hidden" id="salesquono" name="salesquono" value="<%=salesquono%>" />  
	 
	<input type="hidden" id="check" name="chk" value="<%=check%>" />  
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i%>"/>
	<br>
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS : </b> &nbsp;&nbsp;*Editable</div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="search-text" style='width: 450px; height: 150px;'><%=terms%></textarea></div>
	
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 150px;" onclick="convert_amount_into_rupees_paisa();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
	<div align="right"  >
		<input type="submit"  name="submitOrder"
	value="Save Sales Order" style="border: outset; background-color: #C6DEFF; width: 150px; " />
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