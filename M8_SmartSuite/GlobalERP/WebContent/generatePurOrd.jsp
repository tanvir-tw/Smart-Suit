<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>

<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
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

		var agree=confirm("Please confirm following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('grandTotal').value+"");
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
		
		var a,ta=0;
		var tcg=0;
		var tsg=0;
		var tig=0;
		var totalgst=0;
		
		var z; var i;var total;var s=0;
		//alert("Hi");
		 var rowCount = document.generatequo.checkedNumber.value;
		//alert(rowCount); 
		try{
			 for(i=0;i<rowCount;i++)									
			  {
				 var sac=document.getElementById("SAC"+i).value;
					 //alert("SAC "+sac);
					 var hsn=document.getElementById("HSN"+i).value;
					 
					 //alert("HSN "+hsn);
					 
					 if(sac!=0)
						 {
						 
						 
						 }
					 else
						 {
						 if(hsn!=0)
						 {
						 	
						 }
						 else
						 {
							 alert("Please Enter value for either SAC or HSN Code");
							 	return false;
						 
						 }
						 
						 }
					 
				//	 var supstate=document.getElementById("supstate").value;
					 //alert("SupState :- "+supstate);
					// var billstate=document.getElementById("billstate").value;
					 //alert("BillState :- "+billstate);
					 
					 
						 
					 var cgst=document.getElementById("CGSTRate"+i).value;
					 //alert("cgst "+cgst);
					  var sgst=document.getElementById("SGSTRate"+i).value;
					 //alert("Sgst "+sgst);
						 
					 var igst=document.getElementById("IGSTRate"+i).value;
					 //alert("igst "+igst);
					 
					
					//var tax=document.getElementById("tax"+i).value;
					var discount=document.getElementById("discount"+i).value;
					var qua=document.getElementById("quantity"+i).value;
					var unitprice=document.getElementById("sellingPrice"+i).value;
					//var tax1=(tax)/100*unitprice*qua;
					
					var totgsttax=0;
					var tax2=0;
					var tax3=0;
					var tax1=0;
					
					if(igst!=0)
						{
						//alert("In IF");
						tax1=(igst)/100*unitprice*qua;	
						//alert("IGST :-"+tax1);
						totgsttax=tax1;
						}
					else
						{
						//alert("In Else");
						tax2=(cgst)/100*unitprice*qua;
						//alert("CGST :- "+tax2);
						tax3=(sgst)/100*unitprice*qua;
						//alert("SGST :- "+tax3);
						
						 totgsttax=tax2+tax3;
						
						//alert("totgsttax "+totgsttax);
						}
					//alert("Tax 1 "+tax1);
					//alert("Tax 2 "+tax2);
					//alert("Tax 3 "+tax3);
					
					/* if(tax1!=0)
						{
						alert("In IGST Amount IF Loop ");
						
						document.getElementById('IGSTAmt'+i).value=tax1.toFixed(2);
					
						}
					else{
						
						
						
						document.getElementById('CGSTAmt'+i).value=tax2.toFixed(2);
						document.getElementById('SGSTAmt'+i).value=tax3.toFixed(2);
						
					}
					 */
					
					tcg=tcg+tax2;
					//alert("Total CGST "+tcg);
					tsg=tsg+tax3;
					//alert("Total SGST "+tsg);
					tig=tig+tax1;
					//alert("Total IGST "+tig);
					
					totalgst=totalgst+tcg+tsg+tig;
					//alert("Total GST :- "+totalgst);
					
					var discount1=(discount)/100*unitprice*qua;
					//alert("Disc :- "+discount1);
					a = unitprice*qua-discount1;
	
					//alert("Disc a :- "+a);
					
					var b = a / parseFloat(document.getElementById('curr_value').value);
					
					//alert("Disc b :- "+b);
					
					document.getElementById("amount"+i).value = b.toFixed(2);
		
					z=(document.getElementById("amount"+i).value);
					s=parseFloat(s)+parseFloat(z);
					ta=parseFloat(ta)+parseFloat(totalgst);
					  
			   }
				document.getElementById('total').value = parseFloat(s).toFixed(2);
				//document.getElementById('tax').value=parseFloat(ta.toFixed(2));
				
				document.getElementById('CGST').value=tcg.toFixed(2);
				document.getElementById('SGST').value=tsg.toFixed(2);
				document.getElementById('IGST').value=tig.toFixed(2);
				var gst=tcg+tsg+tig;
				document.getElementById('TOTGST').value=gst.toFixed(2);
				
				var pfi=document.getElementById('pfi').value;
				//alert(pfi);
				if(pfi=="")
					
					pfi=0;
					
				
				
				var frieght=document.getElementById('frieght').value;
				if(frieght=="")
					
					frieght=0;
					
				
				
				//alert(s);
				//var t = parseInt(s)+parseInt(pfi)+parseInt(frieght)+ta;
				//alert(">>"+t);
				//document.getElementById('grandTotal').value=Math.round(parseInt(s)+parseInt(pfi)+parseInt(frieght)+ta);
				//document.getElementById('grandTotal').value = Math.round(parseInt(t));
				document.getElementById('grandTotal').value=Math.round((parseInt(s)+parseInt(pfi)+parseInt(frieght)+tcg+tsg+tig)).toFixed(2);
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
			document.getElementById("curr_value").value = 1;
			document.getElementById("curr_symbol").value = chunks[2];
		}			
		
		//alert(curr_val);
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
	</script>
	</head>
	<body>
	
<%  
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>  
	
<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
String comid=(String)session.getAttribute("CompanyMasterID");
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null;
	
	String fromDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String toDate="";
	String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	
	double sumAmount=0,amount=0; 
	int groupCode=0,makeCode=0;
	int sumOfQuotation=0,TWSalesRefNo=0;
	
	int i=0,a=0;
	int k=0;
	int d=0;
	String words="";
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ",salesquodate="",enqtime="",amountInWords="",termsconditions="",paymentconditions="";
	
	String addresscode1=request.getParameter("addresscode");
	String company=request.getParameter("company");
	System.out.println("COMPANY    COMPANY    "+company);
	String salesrefno=request.getParameter("SalesEnqRefNo");
	String pquono=request.getParameter("purchasequono");
	
	String sellingPrice=request.getParameter("sellingPrice");
	String remarks=request.getParameter("remarks");
	String quantity1=request.getParameter("quantity");
	System.out.println(sellingPrice);
	String group=request.getParameter("group");
	String check=request.getParameter("check");
	System.out.println("CHEDH NO IS CCCOOO<M<<   "+check);
	String description=request.getParameter("description");
	
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
	<div align="center" style="font-size: 1.6em;"><a> Generate Purchase Order</a></div>
 	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
							
	<br> 
	<form name="generatequo" method="get" action="insertPurchaseOrd.jsp" onSubmit="return validate();" >
			<table>
		<tr>
			<td>*<b>Select Currency :</b>
			</td>
			<td>
				<select name="curr" id="curr" onchange="getValues();"
					style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
				 			<option value="Select">Select</option>	
				 		<%
				 		try{
				 			String sql = "select distinct(CurrencyType), CurrencySymbol from db_GlobalERP."+comid+"currencydet";
				 			ResultSet rs = st3.executeQuery(sql);
				 			System.out.println("Query is =>"+sql);
				 			while(rs.next())
				 			{
				 				%><option value="<%=rs.getString("CurrencyType")%>"><%=rs.getString("CurrencyType") %></option><%
				 			}
				 		  }catch(Exception ex){
				 			  ex.printStackTrace();
				 		  }
				 		%>		 		
		   		</select>
		   	</td>
		   	<td>
		   	</td>
		   <td>
		   		<input  type = "hidden" name = "curr_value" id = "curr_value" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;"/>
		   </td>
		   <td>
		   		
		   	</td>
		   <td>
		   		<input  type = "hidden" name = "curr_symbol" id = "curr_symbol" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" readonly="readonly"/>
		   </td>
		   
		   
	</tr>
	</table>
	<input type="hidden" name="pquono" value="<%=pquono %>"/>
	 
	<%
	String terms="",payterms="";
	String sqlDet="SELECT * from "+comid+"purchasequo as a left outer join "+comid+"supplierdet  as b on (a.SupplierCode=b.SupplierCode ) where  a.PurQuoNo='"+pquono+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	if(rsDet.next()){
	terms=rsDet.getString("OtherTerms");
	payterms=rsDet.getString("TermsOfPayment");
	System.out.println(terms);
	%>
	<input type="hidden" id="buffer" name="buffer" value="<%=buffer %>">
	<table width="100%">
	<tr>
	 
		<td><b>Purchase Quo Date:</b></td>
		<td><input type="hidden" name="purorderdate" value="<%=todaysDate%>"/><%=todaysDate%></td>
		<td><b>Purchase QUo Time:</b></td>
		<td><input type="hidden" name="purordertime" value="<%=todaysTime%>"/><%=todaysTime %></td>
		

	<td><b>Contact Person</b></td>
	<td><%=rsDet.getString("ContactPerson") %></td>
	<td><b>Pur Quo Exp Date</b></td>
	<td>
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
	</script></div></td>
	</tr>
	<tr>
	<td><b>Sup Name:</b></td>
	<td name="suppliername"><%=rsDet.getString("SupplierName") %></td>
	<td><b>Address</b></td>
	<td><%=rsDet.getString("Address") %></td>
	<td><b>City</b></td>
	<td><%=rsDet.getString("City") %></td>
	<td><b>State</b></td>
	<td><%=rsDet.getString("State") %></td>
	</tr>
	<tr>
	<td><b>Delivery Date</b></td>
	<td>
	<div>
	<input type="text" id="deliverydate"
	name="deliverydate" value="<%=fromDate%>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF"/>
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "deliverydate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "deliverydatedate"       // ID of the button
	}
	);
	</script></div></td>
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
	<th>Unit Price</th>
	<th>SACCode</th>
	<th>HSNCode</th>
	<th>Discount %</th>
	<!-- <th>Tax %</th> -->
	<th>CGSTRate</th>
	<th>SGSTRate</th>
	<th>IGSTRate</th>
	<th>CGSTAmt</th>
	<th>SGSTAmt</th>
	<th>IGSTAmt</th>
	<th>Amount</th>	
	<th>Raised PO</th>
	</tr>
	
	<%  
 	//i=0;
 	double tax=0,discount=0.00 ,total=0.00;
	i=0;
	int p=1 ;		
	String Sql="";
	double CGSTRate=0.00,SGSTRate=0.00,IGSTRate=0.00,CGSTAmt=0.00,SGSTAmt=0.00,IGSTAmt=0.00,UnitPrice=0.00;
	String SACCode="";
	String HSNCode="";
	String ServiceCategary="";
	String sqlEnq="SELECT * FROM "+comid+"pquo_items WHERE PQNo='"+pquono+"'";
	
	System.out.println("+++++++++++++++++"+sqlEnq);

	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next())
	{
	
	groupName="";makeName="";refMakeNameTable="";
	String tableToBeAccessed="";
	
	
	groupCode=rsEnq.getInt("TheGroup");
	
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     
	     
	CGSTRate=rsEnq.getDouble("CGSTRate");
	SGSTRate=rsEnq.getDouble("SGSTRate");
	IGSTRate=rsEnq.getDouble("IGSTRate");
	CGSTAmt=rsEnq.getDouble("CGSTAmt");
	SGSTAmt=rsEnq.getDouble("SGSTAmt");
	
	if(IGSTRate!=0.00)
	{
		IGSTAmt=rsEnq.getDouble("IGSTAmt");
	}
	else
	{
		IGSTAmt=0.00;
	}
	
	ServiceCategary=rsEnq.getString("ServiceCategary");
	
	if(ServiceCategary.equals("Services"))
	{
	SACCode=rsEnq.getString("SACCode");
	HSNCode="-";
	}
	else
	{
		SACCode="-";
		HSNCode=rsEnq.getString("HSNCode");	
	}
	
	String sqlGroup="SELECT TheGroupName from "+comid+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";

	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5)
	{
		refMakeNameTable=comid+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
		String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		   
		ResultSet rsMakeName=st3.executeQuery(sqlMakename);
		if(rsMakeName.next())
		makeName=rsMakeName.getString(1);
		else
		makeName="-";
				      
		sqlDisplayDesc="SELECT * FROM "+comid+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else
	{
		sqlDisplayDesc="SELECT * FROM "+comid+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
		makeName="-"  ;
	}
	%>
	<input type="hidden" name="icode<%=k %>" id="icode<%=k %>" value="<%=itemCode %>"/>	
		<input type="hidden" name="gcode<%=k %>" id="gcode<%=k %>" value="<%=groupCode %>">
		<input type="hidden" name="mcode<%=k %>" id="mcode<%=k %>" value="<%=makeCode %>"/>
	    
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
			tableToBeAccessed="tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+"";
			System.out.println(tableToBeAccessed);
			}
			else
			{ 
				tableToBeAccessed="tbl_otherim_group"+groupCode;
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
		ResultSet rsSql=st2.executeQuery(sqlDisplayDesc);
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
	<td><div align="right"><input type="hidden" id="sellingPrice<%=d %>" name="sellingPrice<%=d %>"  value="<%=request.getParameter("sellingPrice"+k) %>" /><%=request.getParameter("sellingPrice"+k) %></div></td>
	<td style="width: 85px;"><div align="right"><input type="hidden" id="SAC<%=d %>" name="SAC<%=d %>"  value="<%=SACCode %>" /><%=SACCode%></div></td>
	<td style="width: 85px;"><div align="right"><input type="hidden" id="HSN<%=d %>" name="HSN<%=d %>"  value="<%=HSNCode %>" /><%=HSNCode%></div></td>
	<td style="width: 85px;"><input type="text"  id="discount<%=d %>"  name="discount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	<%-- <td style="width: 85px;"><input type="text"  id="tax<%=d %>" name="tax<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td> --%>
	
	<td style="width: 85px;"><input type="text"  id="CGSTRate<%=d %>" name="CGSTRate<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=nf1.format(CGSTRate) %>" readonly="readonly" /></td> 
	
	<td style="width: 85px;"><input type="text"  id="SGSTRate<%=d %>" name="SGSTRate<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=nf1.format(SGSTRate) %>" readonly="readonly" /></td> 
	
	<td style="width: 85px;"><input type="text"  id="IGSTRate<%=d %>" name="IGSTRate<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=nf1.format(IGSTRate) %>" readonly="readonly" /></td> 
	
	<td style="width: 85px;"><input type="text"  id="CGSTAmt<%=d %>" name="CGSTAmt<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=CGSTAmt %>"  readonly="readonly" /></td> 
	
	<td style="width: 85px;"><input type="text"  id="SGSTAmt<%=d %>" name="SGSTAmt<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=SGSTAmt %>" readonly="readonly" /></td> 
	
	<td style="width: 85px;"><input type="text"  id="IGSTAmt<%=d %>" name="IGSTAmt<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="<%=IGSTAmt %>"  readonly="readonly"/></td> 
	
	
	 <td style="width: 85px;"><input type="text" id="amount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%= nf1.format(amount)%>" /></td> 
	<td style="width: 85px;">NO</td>
	</tr>
	<input type="hidden" name="priceaccepted<%=d %>" id="priceaccepted<%=d %>" value="<%=request.getParameter("priceAccepted"+k )%>"/>  
<%   	
   
   sumOfQuotation++;d++;}
   }
   k=k+1;
   }
   }
   	
%>  
	</table>
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=sumOfQuotation %>"/>
		<input type="hidden" name="groupname" id="groupname" value="<%=group %>"/>
	<br>
		<div align="left"  style="position:absolute;   font-size: 1.1em">
	<table border="1">
	<tr>
	<b>TERMS & CONDITIONS :</b><br>
	<textarea name="termsconditions" id="search-text" style='width: 430px; height: 80px;'>
	<%=terms%>
	</textarea>
	</tr>
	<br>
	<br>
	
	<tr>
	<b>PAYMENT TERMS :</b><br>
	<textarea name="paymentterms" id="search-text" style='width: 430px; height: 80px;'><%=payterms%></textarea>
	</tr>
</table>
</div>
	<input type="hidden" name="paymentconditions" value="paymentconditions"/>
	<input type="hidden" name="termsconditions" value="termsconditions"/>
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	</div>
	
	<!-- <div style="font-size: 1.0em" align="right">
	 <b>Tax:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="tax" id="tax" style="width: 230px; border: none;" value=""/>
	</div> -->
	
	<div style="font-size: 1.0em" align="right">
	 <b>CGST:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="CGST" id="CGST" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>SGST:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="SGST" id="SGST" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>IGST:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="IGST" id="IGST" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>TotalGST:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="TOTGST"  id="TOTGST" style="width: 230px; border: none;" value="0"/>
	</div>
	
	
	
	<!-- <div style="font-size: 1.0em" align="right">
	 <b>P & F & I:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="PFI"  id="PFI" style="width: 230px; border: none;" value="0"/>
	</div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>Frieght:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="FRI"  id="FRI" style="width: 230px; border: none;" value="0"/>
	</div> -->
	
	
	
	
	
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
	value="Save Purchase Order" style="border: outset; background-color: #C6DEFF; width: 165p"/>
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