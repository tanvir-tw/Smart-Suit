<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

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

		var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('grandTotal').value+"");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
	    		
	}

	
	function chk()
	{
	var igstserv=document.getElementById("IGSTService").value;
	if(igstserv=="Yes")
		{
		return true;
		}
	else
		{
		
		return false;
		}
	
	
		
	}
	
	function calculate()
	{
		//alert("PPPPPPPPPPPPPPPPPPPPP");
	
		
		var a,ta=0;
		var tcg=0;
		var tsg=0;
		var tig=0;
		var totalgst=0;
		var z; var i;var total;var s=0;
		var rowCount = document.generatequo.checkedNumber.value;
	//	alert(rowCount);
		
		
		try{
			 for(i=0;i<rowCount;i++)									
			  {
				
				 var sac=document.getElementById("SAC"+i).value;
				// alert("SAC "+sac);
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
				 
				 var supstate=document.getElementById("supstate").value;
				 //alert("SupState :- "+supstate);
				 var billstate=document.getElementById("billstate").value;
				 //alert("BillState :- "+billstate);
				 
				 
					 
				 var cgst=document.getElementById("CGST"+i).value;
				 //alert("cgst "+cgst);
				  var sgst=document.getElementById("SGST"+i).value;
				 //alert("Sgst "+sgst);
					 
				 var igst=document.getElementById("IGST"+i).value;
				 //alert("igst "+igst);
				 
				 var a=chk();
				 if(a==true)
					 {
					 
					// alert("IGST Yes ");
					 
				 
					 if(igst!=0)
					 {
					 
					 }
				     else
					 {
					 alert("Please Enter Value For IGST");
					 return false;
					 }
			}
				 else
					 {
					 
					 //alert("IGSTNO");
					 
					 if(igst!=0)
					 {
					 
					 }
				 else{
					 
					 if(cgst!=0)
						 {
						 if(sgst!=0)
							 {
							 
							 }
						 else
							 {
							 alert("Please Enter Value For SGST");
							 return false;
							 }
						 }
					 else
						 {
						 
						 alert("Please Enter Value For CGST");
						 return false;
						 
						 }
				 }
					 }
				/*  if(cgst!=0 && sgst!=0)
					 {
					 
					 }
				 else
					 {
					 if(igst!=0)
						 {
						 
						 }
					 else
						 {
						 alert("Please Enter Value For IGST");
						 return false;
						 }
					 } */
					 
					//var tax=document.getElementById("tax"+i).value;
					var discount=document.getElementById("discount"+i).value;
					var qua=document.getElementById("quantity"+i).value;
					var unitprice=document.getElementById("sellingPrice"+i).value;
					
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
					if(tax1!=0)
						{
						//alert("In IGST Amount IF Loop ");
						document.getElementById('igstamt'+i).value=tax1.toFixed(2);
					
						}
					else{
						
						
						
						document.getElementById('cgstamt'+i).value=tax2.toFixed(2);
						document.getElementById('sgstamt'+i).value=tax3.toFixed(2);
						
					}
					
					
					tcg=tcg+tax2;
					//alert("Total CGST "+tcg);
					tsg=tsg+tax3;
					//alert("Total SGST "+tsg);
					tig=tig+tax1;
					//alert("Total IGST "+tig);
					
					totalgst=totalgst+tcg+tsg+tig;
					//alert("Total GST Amount "+totalgst);
					
					var discount1=(discount)/100*unitprice*qua;
					a=unitprice*qua-discount1;
					document.getElementById("amount"+i).value=a.toFixed(2);
					
		
					z=(document.getElementById("amount"+i).value);
					s=parseFloat(s)+parseFloat(z);
					
				ta=parseFloat(ta)+parseFloat(totalgst);
				
					  
			   }
			 
				document.getElementById('total').value=s.toFixed(2);
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
				
				//document.getElementById('grandTotal').value=Math.round((parseInt(s)+parseInt(pfi)+parseInt(frieght)+ta)).toFixed(2);
				
				document.getElementById('grandTotal').value=Math.round((parseInt(s)+parseInt(pfi)+parseInt(frieght)+tcg+tsg+tig)).toFixed(2);
		}	

		catch(e){ }


		    var junkVal=document.getElementById('grandTotal').value;
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
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,st_terms=null;
	
	String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String toDate="";
	//String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String fromdate=request.getParameter("fromdate");
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm").format(new java.util.Date());
	
	
	double sumAmount=0,amount=0.00,cgst=0.00,sgst=0.00,igst=0.00; 
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
	System.out.println("twrefno===============> "+twrefno);
		
String state=request.getParameter("state");
%>
<input type="hidden" name="supstate" id="supstate" value="<%=state %>"/>
<% 
System.out.println("state  "+state);

try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st_terms=conn.createStatement();
	} catch (Exception e) {
		
	}

String companydata="select * from db_GlobalERP.CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
System.out.println("Com :- "+companydata);
ResultSet rsdata123=st_terms.executeQuery(companydata);
String BillingState="";
while (rsdata123.next())
{
String companyname=rsdata123.getString("Companyname");
String address123=rsdata123.getString("address");
String phone123=rsdata123.getString("phone");
String mail=rsdata123.getString("emailid");
String website=rsdata123.getString("website");
String fax=rsdata123.getString("fax");
String godownaddress=rsdata123.getString("godownaddress");  
String GSTINNO=rsdata123.getString("GSTINNO");
String PANNo=rsdata123.getString("PANNo");
 BillingState=rsdata123.getString("State");
 
 %>
 
 <input type="hidden" name="billstate" id="billstate" value="<%=BillingState %>"/>
 
 <% 

}
	
	String text = "";
	
	
	
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
	<div align="center" style="font-size: 1.6em;"><a> Generate Purchase Quotation</a></div>
 	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
							
	<br> 
	<form name="generatequo" method="post" action="insertPurchaseQuo.jsp" onSubmit="return validate();" >
	 <input type="hidden" name=twrefno id="twrefno" value="<%=twrefno %>"/>
	 
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
	<th>Unit Price</th>
	<th>Discount %</th>
	<th>SACCode</th>
	<th>HSNCode</th>
	<%if(BillingState.contains(state))
	{ %>
	<th>CGST %</th>
	<th>SGST %</th>
	<%}else{ %>
	<th>IGST %</th>
	<%} %>
	<th>Amount</th>	
	<%if(BillingState.contains(state))
	{ %>
	<th>CGST</th>
	<th>SGST</th>
	<%}else{ %>
	<th>IGST</th>
	<%} %>
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
	
	<td style="width: 85px;"><input type="text"  id="SAC<%=d %>" name="SAC<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	
	<td style="width: 85px;"><input type="text"  id="HSN<%=d %>" name="HSN<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	
	<% 
	if(BillingState.contains(state))
	{
	%>
	
	
	<td style="width: 85px;"><input type="text"  id="CGST<%=d %>" name="CGST<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	
	<td style="width: 85px;"><input type="text"  id="SGST<%=d %>" name="SGST<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	
	<input type="hidden" id="IGST<%=d %>" name="IGST<%=d %>" value="0"/>
	<input type="hidden" id="IGSTService" name="IGSTService" value="No"/>
	<%}
	else
		{%>
	<td style="width: 85px;"><input type="text"  id="IGST<%=d %>" name="IGST<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	
	<input type="hidden" id="CGST<%=d %>" name="CGST<%=d %>" value="0"/>
	<input type="hidden" id="SGST<%=d %>" name="SGST<%=d %>" value="0"/>
	<input type="hidden" id="IGSTService" name="IGSTService" value="Yes"/>
	<%} %>
	
	<td style="width: 85px;"><input type="text" id="amount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%= amount%>" /></td>
	
	<% 
	if(BillingState.contains(state))
	{
	%>
	 <td style="width: 85px;"><input type="text" name="cgstamt<%=d %>" id="cgstamt<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="0.00" /></td>
	
	
	<td style="width: 85px;"><input type="text" name="sgstamt<%=d %>" id="sgstamt<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="0.00" /></td>
	
	<%}else
		{%>
	<td style="width: 85px;"><input type="text" name="igstamt<%=d %>" id="igstamt<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="0.00" /></td>
	
	<%} %>
	
	<td style="width: 85px; text-align:left;">NO</td>
	
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
	id="search-text" style='width: 430px; height: 80px;'>
	<%-- <%
	Statement st_terms1=conn.createStatement();
	String terms_sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"termsAndConditions";

	ResultSet rs_terms=st2.executeQuery(terms_sql);
	while(rs_terms.next()){
		out.println(rs_terms.getString("ID")+":-"+rs_terms.getString("terms"));
	}
	%> --%>
	</textarea>
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