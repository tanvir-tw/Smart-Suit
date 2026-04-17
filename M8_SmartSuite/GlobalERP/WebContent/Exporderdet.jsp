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
<script language="JavaScript1.2">

function validate()
{
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


	var Cval=document.getElementById("currval").value;
	var Ctype=document.getElementById("currtype").value;
	var Csym=document.geneOrder.currsym.value;
	
//alert(Csym);

	
	cnt=0;
	for(i=0;i<document.geneOrder.checkedNumber.value;i++)									
		if(document.getElementById('check'+i).checked==true)
			cnt++;
	if(cnt==0)
	{
		alert("Please select atleast 1 item");
		document.getElementById('total').value=0;
		document.getElementById('rupees').value='';
	}
	var totalunitprice;
	var totaldiscount=0;
	var finaldiscount;var finaldiscount;
	var a;	
	var z; var i;var total;var s=0;
	//var unitprice=0;
	var rowCount = document.geneOrder.checkedNumber.value;
	try{
		 for(i=0;i<rowCount;i++)									
		  {
			  if(document.getElementById('check'+i).checked==true)
			  {
				var tax=document.getElementById("STPercent"+i).value;
				var discount=document.getElementById("discountPercent"+i).value;
				var qua=document.getElementById("quantity"+i).value;
				var unitprice=document.getElementById("sellingPrice"+i).value;


				var tax1=(tax)/100*unitprice*qua;


				
				//totalunitprice=unitprice*qua;
					
				//alert("TOTAL UNIT PRIZE   "+totalunitprice);
				//if(discount==0)
				//{
				//totaldiscount=0;
				//}
				//else
				//{
				//totaldiscount=(discount/100)*totalunitprice;

				var discount1=(discount)/100*unitprice*qua; 
				
				//}

				//if(tax==0)
				//{
				//tax1=0;
				//}
			//	else{
					
				//tax1=(tax/100)*(totalunitprice);//-totaldiscount);
				//}

			a=unitprice*qua+tax1-discount1;

				
				//a=totalunitprice+tax1-totaldiscount;

				
				//a=parseInt(a)/parseFloat(Cval);
				
				
				document.getElementById("amount"+i).value=a.toFixed(2);

				 z=(document.getElementById("amount"+i).value);
				  s=parseFloat(s)+parseFloat(z);
				//alert(z);
				//alert(s);

				
			  }
			  else
				  document.getElementById("amount"+i).value=0;
	  
		   }
		 
		 document.getElementById('totalNew').value=parseInt(s);
			document.getElementById('total').value=Csym+parseInt(s);
	}	
	catch(e){}

var finalval=parseInt(s);


	
	var junkVal=finalval;
	    junkVal=Math.floor(junkVal);
	    var obStr=new String(junkVal);
	    numReversed=obStr.split("");
	    actnumber=numReversed.reverse();

	    if(Number(junkVal) >=0)
		{
	    }
	    else
		    {
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

	        if(Ctype=="US Dollars")
	        {
	        	inWords[j]=inWords[j]+' US Dollars Only';
	        }
	        else if(Ctype=="Euro")
	        {
	        	inWords[j]=inWords[j]+' Euros Only';
	        }
	        else if(Ctype=="Pound")
	        {
	        	inWords[j]=inWords[j]+' Pounds Only';
	        }
	        else if(Ctype=="Yen")
	        {
	        	inWords[j]=inWords[j]+' Yens Only';
	        }
	        else if(Ctype=="Singapore Dollars")
	        {
	        	inWords[j]=inWords[j]+' Singapore Dollars Only';
	        }
	        else{

	        	            inWords[j]=inWords[j]+' Rupees Only';

	        }


            
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

function newwindow(webadd,salesquono,company)
{ 
	window.open(webadd+'?salesquono='+salesquono+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
}
	</script>
	</head>
	<body>
	
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
<%
	Connection conn = null;
		Statement st = null, st1 = null, st2 = null, st3 = null;
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
		String salesquono = request.getParameter("SalesQuoNo");
		String fromDate = "", terms = "";
		String check = request.getParameter("check");
		String Ctype=request.getParameter("Ctype");
		
		String Cval=request.getParameter("Cval");


		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_MONTH, -30);
		fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
				.getTime());

		String s = "";
		try {
			conn = erp.ReturnConnection();
			st = conn.createStatement();
			st2 = conn.createStatement();
			st1 = conn.createStatement();
			st3 = conn.createStatement();
		} catch (Exception e) {
		}
%>

	
	<div align="center" style="font-size: 1.5em"><font face="Arial" size="3" color="black">Export Quotation
	Of :<%=request.getParameter("SalesQuoRefNo")%>  For : <%=request.getParameter("CompanyName")%></font>
	</div>
	
<br></br>
	<form name="geneOrder" method="get" action="Expinsertorder.jsp" onSubmit="return validate();">
	<%
		String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"
					+ salesquono + "' ";
			System.out.println(sqlDet);
			ResultSet rsDet = st.executeQuery(sqlDet);
			if (rsDet.next()) {
	%>	
 
 
 <%
 String currsym="";
 String sqlcur="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"currencydet where CurrencyType='"+Ctype+"'";
 System.out.println("Currency value is " +sqlcur);
 
 ResultSet rscurr=st1.executeQuery(sqlcur);
 if(rscurr.next())
 {
	 currsym=rscurr.getString("CurrencySymbol");
 }
 System.out.println("Currency Sign  is " +currsym);

 %>
	
	<input type="hidden" id="currval" name="currval" value="<%=Cval %>" ></input>
	
		<input type="hidden" id="currtype" name="currtype" value="<%=Ctype %>" ></input>
		<input type="hidden" id="currsym" name="currsym" value="<%=currsym %>" ></input>
	
	
	
	 
	
	
	
	
	<table  border="0" align="left" valign="top" width="100%" cellpadding="0" cellspacing="0">
	
	<tr>
	<td><font face="Arial" size="2" color="black"><b>SQ Date :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="salesquodate" value="<%=rsDet.getString("SalesQuoDate")%>"/><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd").parse(rsDet
													.getString("SalesQuoDate")))%></font></td>
	<td><font face="Arial" size="2" color="black"><b>SQ Time :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="salesquotime" value="<%=rsDet.getString("SalesQuoTime")%>"/><%=rsDet.getString("SalesQuoTime")%></font></td>
	<td><font face="Arial" size="2" color="black"><b>Contact Person :</b></font></td>
	<td style="width: 250px;"><font face="Arial" size="2" color="black"><input type="hidden" name="contactperson" value="<%=rsDet.getString("ContactPerson")%>"/><%=rsDet.getString("ContactPerson")%></font></td>
		</tr>

	<tr>
	<td><font face="Arial" size="2" color="black"><b>SQ ExpiryDate :</b></font></td>
	<td><font face="Arial" size="2" color="black">
	<div>
	<input type="text" id="fromdate"
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
	</script></div></font></td>

	<td><font face="Arial" size="2" color="black"><b>Cust Category :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="" id="" value="-"/></font></td>
	<td><font face="Arial" size="2" color="black"><b>Address :</b></font></td>
	<td style="width: 300px;"><font face="Arial" size="2" color="black"><input type="hidden" name="address" value="<%=rsDet.getString("Address")%>"/><%=rsDet.getString("Address")%></font></td>
	
</tr>
	
	<tr>
	<td><font face="Arial" size="2" color="black"><b>Customer Code :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="customercode" value="<%=rsDet.getString("CustomerCode")%>"/><%=rsDet.getString("CustomerCode")%></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>City :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="city" value="<%=rsDet.getString("city")%>"/><%=rsDet.getString("city")%></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>State :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="state" value="<%=rsDet.getString("State")%>"/><%=rsDet.getString("State")%></font></td>
	</tr>
	
	<tr>
	
	<td><font face="Arial" size="2" color="black"><b>Country :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="country" value="<%=rsDet.getString("Country")%>"/><%=rsDet.getString("Country")%></font></td>
	<td><font face="Arial" size="2" color="black"><b>Zip Code :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="zip" value="<%=rsDet.getString("Zip")%>"/><%=rsDet.getString("Zip")%></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>Phone :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="phone" value="<%=rsDet.getString("Phone")%>"/><%=rsDet.getString("Phone")%></font></td>
	</tr>
	<tr>
	<td><font face="Arial" size="2" color="black"><b>TWSales RefNo :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="twsalesrefno" value="<%=rsDet.getString("TWSalesRefNo")%>"/><%=rsDet.getString("TWSalesRefNo")%></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>Fax :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="fax" value="<%=rsDet.getString("Fax")%>"/><%=rsDet.getString("Fax")%></font></td>
	</tr>
	<tr>
	<td><font face="Arial" size="2" color="black"><b>address code :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="addresscode" value="<%=rsDet.getString("AddressCode")%>"/><%=rsDet.getString("AddressCode")%></font></td>
	<td><font face="Arial" size="2" color="black"><b>Group :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></font></td>
	</tr>	
	
			
<%
					terms = rsDet.getString("TermsAndConditions");
			}
%>  
	</table> 
	
	
	
	<table  align="center" class='sortable'>
	<br></br>
	
	<tr>
	<br></br>
		<th style="width: 125px;">Check</th>
		<th>Option No</th>
		<th>Insert Or</th>
		<th>Make</th>
		<th>Model</th>
		<th>Part No</th>
		<th>Description</th>
		<th>Quantity</th>
		<th>Unit Price</th>
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
					System.out.println("group find query is " +sqlGroup);

					
					if (rsGroup.next())
						groupName = rsGroup.getString("TheGroupName");
					
					System.out.println("groupName  name is " +groupName);
					
					
					if (groupCode < 5) 
					{
						refMakeNameTable = session.getAttribute("CompanyMasterID").toString()+"tbl_" + groupName.substring(0, 5)
								+ "makemaster";

						
						
						System.out.println("Make table name is " +refMakeNameTable);
						
						
						
						
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
	  			}
					else 
					{
	  				sqlDisplayDesc = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"
	  						+ groupCode + " where ItemCode='" + itemCode
	  						+ "' ";
	  				makeName = "-";
	  			}

	  			System.out.print("?????" + sqlDisplayDesc);

	  			System.out.println(">>>>>>>>>  " + sqlDisplayDesc);
	  			ResultSet rsDetails1 = st.executeQuery(sqlDisplayDesc);
	  			while (rsDetails1.next()) {

	  				String Sql = "SELECT * FROM "
	  						+ rsEnq.getString("TheTableToBeAccessed")
	  								.toLowerCase() + " WHERE ItemCode='"
	  						+ itemCode + "' ";

	  				//System.out.println("22222222222222222222222222222");
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
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("Quantity")%>" /></div></td>
	<td style="width: 85px;"><div align="right"><input type="text" id="sellingPrice<%=i%>" name="sellingPrice<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("SellingPrice")%>" /></div></td>
	<td style="width: 85px;"><div align="right"><input type="text" id="discountPercent<%=i%>" name="discountPercent<%=i%>" style="width:70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("DiscountPercent")%>"/></div></td>
	<td style="width: 85px;"><div align="right"><input type="text" id="STPercent<%=i%>" name="STPercent<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " value="<%=rsEnq.getString("STPercent")%>" /></div></td>
	<td style="width: 85px;"><div align="right"><input type="text" id="amount<%=i%>" name="amount<%=i%>" style="width:70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background: inherit;" value="<%=amount%>" /></div></td>



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
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;<font face="Arial" size="2" color="black"><b>TERMS & CONDITIONS : </b></font> &nbsp;&nbsp;*Editable</div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="terms" 
	id="search-text" style='width: 450px; height: 150px;'><%=terms%></textarea></div>
	
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 150px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <font face="Arial" size="2" color="black"><b>Total :</b></font> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	 <input type="hidden" name="totalNew" id="totalNew" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
	<font face="Arial" size="2" color="black">	<b>Total In Words : </b></font></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
	<div align="right"  >
		<input type="submit"  name="submitOrder"
	value="Save Sales Order" style="border: outset; background-color: #C6DEFF; width: 150px; " />
	</div>
	
	
	</form>
	
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>