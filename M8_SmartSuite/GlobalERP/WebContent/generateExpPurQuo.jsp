<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	
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
	<script type="text/javascript" src="convert.js">
	</script>
	<script type="text/javascript" >
	function popUp(webadd,trancactionId,company)
	{ 
			window.open(webadd+'?company='+company+'&transactionId='+trancactionId,'jav','width=870,height=500,top=150,left=250,resizable=no');
	}


	function validate()
	{
			
		calculate();
		var cnt=document.generatequo.checkedNumber.value;

		var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('grandTotal').value+"");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
	}

	
	function calculate()
	{
		//alert("PPPPPPPPPPPPPPPPPPPPP");
		var curr_val = document.getElementById("curr").value;
		if(curr_val == "Select")
		{
			alert("Please select Currency!");
			return false;
		}
		
		var a;	
		var z; var i;var total;var s=0;
		var rowCount = document.generatequo.checkedNumber.value;
	//	alert(rowCount);
		try{
			 for(i=0;i<rowCount;i++)									
			  {
				 
					var tax=document.getElementById("tax"+i).value;
					var discount=document.getElementById("discount"+i).value;
					var qua=document.getElementById("quantity"+i).value;
					var unitprice=document.getElementById("sellingPrice"+i).value;
					var tax1=(tax)/100*unitprice*qua;
					var discount1=(discount)/100*unitprice*qua;
					a = unitprice*qua+tax1-discount1;

					var b = a / parseFloat(document.getElementById('curr_value').value);
					document.getElementById("amount"+i).value = b.toFixed(2);
		
					z=(document.getElementById("amount"+i).value);
					s=parseFloat(s)+parseFloat(z);
				 
					  
			   }
				document.getElementById('total').value = parseFloat(s).toFixed(2);
				var pfi=document.getElementById('pfi').value;
				//alert(pfi);
				if(pfi=="")
					pfi=0;

				var frieght=document.getElementById('frieght').value;
				if(frieght=="")
					frieght=0;
				//alert(s);
				var t = parseInt(s)+parseInt(pfi)+parseInt(frieght);
				//alert(">>"+t);
				document.getElementById('grandTotal').value = parseInt(t);
			}	

		catch(e){ }

			var curr_val = document.getElementById("curr").value;
			var chunks = curr_val.split(",");
			var curr_type = chunks[0];
		    var junkVal = document.getElementById('grandTotal').value;
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
	            
		            inWords[j]=inWords[j]+' '+curr_type+' Only';
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
	
	
	function checkAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = true ;
	}catch(e){alert(e);}
	}

	function unCheckAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = false ;
	}catch(e){alert(e);}
	}

	function newwindow(webadd,salesenqno1,company)
	{ 
		
			window.open(webadd+'?salesenqno1='+salesenqno1+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}

	function newwindow1(webadd,salesenqno1,company)
	{
		window.open(webadd+'?salesenqno1='+salesenqno1+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}

	function getValues()
	{
		//alert(">>>");
		//var curr_val = document.currencyselection.curr.value;
		var curr_val = document.getElementById("curr").value;
		//alert(curr_val);
		if(curr_val == "Select")
		{
			document.getElementById("curr_value").value = "";
			document.getElementById("curr_symbol").value = "";
		}
		else
		{
			var chunks = curr_val.split(",");
			document.getElementById("curr_value").value = chunks[1];
			document.getElementById("curr_symbol").value = chunks[2];
		}			
		
		//alert(curr_val);
	}	
	</script>
	</head>
	<body>
	
<%  
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>  
	
<%
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null;
	
	String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String toDate="";
	//String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String fromdate=request.getParameter("fromdate");
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm").format(new java.util.Date());
	
	
	double sumAmount=0,amount=0; 
	int groupCode=0,makeCode=0;
	int sumOfQuotation=0,TWSalesRefNo=0;
	
	int i=0,a=0;
	int k=0;
	int d=0;
	String words="";
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ",salesquodate="",enqtime="",amountInWords="",termsconditions="";
	String scd=request.getParameter("supcode");
	System.out.println("SUIPPLIER CODE   ."+scd);
	String addresscode1=request.getParameter("addresscode");
	String company=request.getParameter("company");
	System.out.println("COMPANY    COMPANY    "+company);
	String salesrefno=request.getParameter("SalesEnqRefNo");
	String penqno=request.getParameter("purchaseenqno");
	
	String sellingPrice=request.getParameter("sellingPrice");
	String remarks=request.getParameter("remarks");
	String quantity1=request.getParameter("quantity");
	System.out.println(sellingPrice);
	String group=request.getParameter("group");
	System.out.println("GROUP IS     "+group);
	String check=request.getParameter("check");
	System.out.println("CHEDH NO IS CCCOOO<M<<   "+check);
	String description=request.getParameter("description");
	String contact=request.getParameter("contactper");
	String supplier=request.getParameter("supplier");
	System.out.println("supplier  "+supplier);
		String city=request.getParameter("city");
		System.out.println("city  "+city);
	String address=request.getParameter("address");
	System.out.println("address "+address);
	
	String twrefno=request.getParameter("twrefno");
	System.out.println("twrefno=============> "+twrefno);
		
String state=request.getParameter("state");
System.out.println("state  "+state);

	
	String text = "";
	
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	} catch (Exception e) {
	}
	
	StringBuffer buffer=new StringBuffer(","); 
	while( i!=(Integer.parseInt(request.getParameter("checkedNumber").toString())))
	{
	if(request.getParameter("check"+i)!=null)
	buffer.append(i+",");
 	i++;
 	System.out.println("*         ******   ??????????    "+buffer);
	}
	
%>


<div align="center"	style="font-size: 1.5em; margin-top: 0.6em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.6em;"><a> Generate Export Purchase Quotation</a></div>
 	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
	
	<form name="generatequo" method="get" action="insertExpPurchaseQuo.jsp" onSubmit="return validate();" >
		<table>
		<tr>
			<td><b>Select Currency :</b>
			</td>
			<td>
				<select name="curr" id="curr" onchange="getValues();"
					style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
				 			<option value="Select">Select</option>	
				 		<%
				 		try{
				 			String sql = "select distinct(CurrencyType),CurrencyValue ,CurrencySymbol from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"currencydet";
				 			ResultSet rs = st3.executeQuery(sql);
				 			System.out.println("Query is =>"+sql);
				 			while(rs.next())
				 			{
				 				%><option value="<%=rs.getString("CurrencyType")%>,<%=rs.getString("CurrencyValue")%>,<%=rs.getString("CurrencySymbol")%> "><%=rs.getString("CurrencyType") %></option><%
				 			}
				 		  }catch(Exception ex){
				 			  ex.printStackTrace();
				 		  }
				 		%>		 		
		   		</select>
		   	</td>
		   	<td>
		   		<b>Enter Currency Value :</b>
		   	</td>
		   <td>
		   		<input  type = "text" name = "curr_value" id = "curr_value" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;"/>
		   </td>
		   <td>
		   		<b>Currency Symbol :</b>
		   	</td>
		   <td>
		   		<input  type = "text" name = "curr_symbol" id = "curr_symbol" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" readonly="readonly"/>
		   </td>
		   
		   
	</tr>
	</table>
	 <input type="hidden" name=twrefno id="twrefno" value="<%=twrefno %>"/>
	</div>
	 
	<%
	String sqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq as a left outer join "+session.getAttribute("CompanyMasterID").toString()+"supplierdet  as b on (a.Suppliercode=b.SupplierCode ) where  a.PurchaseEnqNo='"+penqno+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	if(rsDet.next()){
	
	%>
	<input type="hidden" id="buffer" name="buffer" value="<%=buffer %>">
	<table width="100%">
	<tr>
	 
		<td><b>Date:</b></td>
		<td><input type="hidden" name="purquodate" value="<%=todaysDate%>"/><%=todaysDate%></td>
		<td><b>Time:</b></td>
		<td><input type="hidden" name="purquotime" value="<%=todaysTime%>"/><%=todaysTime %></td>
		

	<td><b>Contact Person:</b></td>
	<td><%=contact%></td>
	<td><b>Expiry Date:</b></td>
	<td>
	<div>
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromdate%>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "fromdate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "fromdate"       // ID of the button
	}
	);
	</script></div></td>
	</tr>
	<tr>
	<td><b>Supplier Name:</b></td>
	<td name="suppliername"><%=supplier %></td>
	<td><b>Address</b></td>
	<td><%=address %></td>
	<td><b>City</b></td>
	<td><%=city%></td>
	<td><b>State</b></td>
	<td><%=state %></td>
	</tr>
   <%}%> 
   <input type="hidden" name="suppliercode" value="<%=rsDet.getString("SupplierCode") %>"/>
	</table>

 <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
 
<table border="1px"  class="sortable">
	<tr>
	<th>Sr No</th>
	<th>Make</th>
	<th>Part No</th>													
	<th>Description</th>
	<th>Quantity</th>
	<th>Unit prize</th>
	<th>Discount %</th>
	<th>Tax %</th>
	<th>Amount</th>	
	<th>Raised PO</th>
	</tr>
	
	<%  
 	//i=0;
 	double tax=0,discount=0.00 ,total=0.00;
	i=0;
	int p=1 ;		
	String Sql="";
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo='"+penqno+"'";
	
	System.out.println("+++++++++++++++++"+sqlEnq);

	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next())
	{
	
	groupName="";makeName="";refMakeNameTable="";
	String tableToBeAccessed="";

	
	groupCode=rsEnq.getInt("TheGroup");
	
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     
	     
	String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";

	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5)
	{
		refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
		String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		   
		ResultSet rsMakeName=st3.executeQuery(sqlMakename);
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
	%>
	<script type="text/javascript">
	document.getElementById('groupTop').value='<%=groupName%>';
	</script>
	<%  
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$    "+sqlDisplayDesc);
	ResultSet rsDetails1=st.executeQuery(sqlDisplayDesc);
	if(rsDetails1.next())
	{
		if(rsEnq.getString("TheTableToBeAccessed").equals("-"))
		{	
			System.out.println("---------------------------------------    ");
			if(groupCode<5){
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+"";
			System.out.println(tableToBeAccessed);
			}
			else
			{ 
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
				System.out.println(tableToBeAccessed);
			}
			Sql="SELECT * FROM "+tableToBeAccessed+" WHERE ItemCode='"+itemCode+"' ";
			System.out.println(Sql);
		}
		else
		{
			Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";
		}
		System.out.println("???????                         >>>>>>"+Sql);
		ResultSet rsSql=st2.executeQuery(Sql);
		if(rsSql.next())
		{
	if(buffer.toString().contains(","+k+","))
	{
%> 	
	<tr>

	<td><div align="right"><%=p++ %></div></td>
	<td><div align="left"><input type="hidden" name="make<%=d %>" id="make<%=d %>" value="<%=makeName %>"/><%=makeName %></div></td>
	<td><div align="left"><%=rsSql.getString("Partno") %></div></td>
	<td><div align="left"><input type="hidden" id="description<%=d %>"  name="description<%=d %>" value="<%=request.getParameter("description"+k)%>" /><%=request.getParameter("description"+k) %></div></td>
	<td><div align="right"><input type="hidden"  id="quantity<%=d %>" name="quantity<%=d %>" value="<%=request.getParameter("quantity"+k)%>" /><%=request.getParameter("quantity"+k) %></div></td>
	<td><div align="right"><input type="hidden" id="sellingPrice<%=d %>" name="sellingPrice<%=d %>"  value="<%=request.getParameter("sellingPrice"+k) %>" /><%=request.getParameter("sellingPrice"+k) %></td>
	<td style="width: 85px;"><input type="text"  id="discount<%=d %>"  name="discount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	<td style="width: 85px;"><input type="text"  id="tax<%=d %>" name="tax<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	<td style="width: 85px;"><input type="text" id="amount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%= amount%>" /></td>
	<td style="width: 85px;">NO</td>
	</tr>
	<input type="hidden" name="priceaccepted<%=d %>" id="priceaccepted<%=d %>" value="<%=request.getParameter("priceAccepted"+k )%>"/>  
	<input type="hidden" name="icode<%=d %>" id="icode<%=d %>" value="<%=itemCode %>"/>	
		<input type="hidden" name="gcode<%=d%>" id="gcode<%=d %>" value="<%=groupCode %>">
		<input type="hidden" name="mcode<%=d %>" id="mcode<%=d %>" value="<%=makeCode %>"/>
	    
<%   	
   
   sumOfQuotation++;d++;}
   }
   k=k+1;
   }
   }
   	
%>  
	</table>
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=sumOfQuotation %>"/>
	<input type="hidden" name="purchaseenqno" id="purchaseenqno" value="<%=penqno %>"/>
	<input type="hidden" name="groupname" id="groupname" value="<%=groupName %>"/>
	
	<br>
	<div align="left"  style="position:absolute;   font-size: 1.1em">
	<table border="1">
	<tr>
	<b>TERMS & CONDITIONS :</b><br>
	<textarea name="termsconditions"
	id="search-text" style='width: 430px; height: 80px;'></textarea>
	</tr>
	<br>
	<br>
	
	<tr>
	<b>PAYMENT TERMS :</b><br>
	<textarea name="paymentterms"
	id="search-text" style='width: 430px; height: 80px;'></textarea>
	</tr>
</table>
</div>
	
	
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	</div>
	<div style="font-size: 1.0em" align="right">
	 <b>P & F & I:</b> &nbsp;&nbsp;<input type="text" name="pfi" id="pfi" 
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
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
	<div align="right"  >
		<input type="submit"  
	value="Save Purchase Quotation" style="border: outset; background-color: #C6DEFF; width: 165p"/>
	</div>
	</br>
	</form>
	<br><br><br><br><br><br><br><br>        
	<br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>