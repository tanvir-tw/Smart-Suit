]<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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

		var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('total').value+"");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
	}

	
	function calculate()
	{
		var a;var k=0; 
		var rowCount = document.generatequo.checkedNumber.value;
		var currval=document.generatequo.curval.value;
		
		var cusym=document.generatequo.cursmb.value;
		
		var curtyp=document.generatequo.type.value;

if(curtyp=="Select")
{

	alert("Please select currency");
	
	return false;
	
}

		
		for(k=0;k<rowCount;k++)
		{

			var tax=document.getElementById("tax"+k).value;
			var discount=document.getElementById("discount"+k).value;
			var qua=document.getElementById("quantity"+k).value;
			
			var unitprice=document.getElementById("sellingPrice"+k).value;
			
           var newunitprize=document.getElementById("sellingPrice"+k).value;
//alert(newunitprize);

          var n=parseInt(newunitprize)/parseFloat(currval);
         // alert(n);

           
			//alert("Unit prize is " +unitprice);
			//var u1=document.getElementById("sellingPrice"+k).value;
			//alert("Unit prize of u1 " +u1);
			//var unit1=parseInt(u1)/parseFloat(currval);
			//alert("Doller prize is " +unit1);
			//try{
			//document.getElementById("sellingPrice"+k).value=unit1.toFixed(2);
			//}catch(e)
			//{alert(e);}
			
			var tax1=(tax)/100*unitprice*qua;
			//alert("tax1 is " +tax1);
			
//alert("quantity is " +qua);
//alert("unitprice is " +unitprice);
//alert("discount is " +discount);


			
			var discount1=(discount)/100*unitprice*qua; 

//alert(discount1);



			
			a=unitprice*qua+tax1-discount1;
			
			//alert(a);
			
			a=parseInt(a)/parseFloat(currval);
			
			//alert(a);
			
			document.getElementById("amount"+k).value=a.toFixed(2);

	           document.getElementById("Newunit"+k).value=n.toFixed(2);
	           document.getElementById("NewunitD"+k).value=n.toFixed(2);

			
		}	



		

		var rowCount = document.generatequo.checkedNumber.value; 
			var z; 
			var i;
			var total;
			var s=0;
			var finalval=0;
			for(i=0;i<rowCount;i++)
			{
				var z=(document.getElementById("amount"+i).value);
				
				s=parseFloat(s)+parseFloat(z);
			}
			
			//finalval=parseInt(s)/parseFloat(currval);
			
			//alert(parseInt(finalval));
			
			var finalvalis=parseInt(s);
			
			document.getElementById('total').value=cusym+parseInt(s);
			document.getElementById('totalNew').value=parseInt(s);
			


		    var junkVal=finalvalis;
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


if(curtyp=="US Dollars")
{
	inWords[j]=inWords[j]+' US Dollars Only';
}
else if(curtyp=="Euro")
{
	inWords[j]=inWords[j]+' Euros Only';
}
else if(curtyp=="Pound")
{
	inWords[j]=inWords[j]+' Pounds Only';
}
else if(curtyp=="Yen")
{
	inWords[j]=inWords[j]+' Yens Only';
}
else if(curtyp=="Singapore Dollars")
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


			
			function tens_complication()

			 {
		        if(actnumber[i]==0) 
			        {
		            inWords[j]='';
		        }
		        else if(actnumber[i]==1)
			         {
		        inWords[j]=ePlace[actnumber[i-1]];
		        }
		        else 
			        {
		       inWords[j]=tensPlace[actnumber[i]];
		        }
			}
			
		inWords.reverse();
		for(i=0; i<inWords.length; i++) 
			{
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

function getcurval()
{
	var cyrtype=document.getElementById("type").value;
	//alert(cyrtype);
	if(cyrtype=="Select")
	{
		alert("Please choose currency type");
		return false;
	}else{
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
			var r;
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert()
			//alert(reslt);
			r=reslt.split("~");
			

			//alert(reslt[0]);
			
			document.getElementById("curval").value=r[0];
			document.getElementById("cursmb").value=r[1];
			
			
		} 
	}
	var queryString = "?type=" +cyrtype;
	ajaxRequest.open("GET", "GetcurrencyVal.jsp" + queryString, true);
	ajaxRequest.send(null); 

}
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
	String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	 
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

	
	String addresscode1=request.getParameter("addresscode");
	String company=request.getParameter("company");
	System.out.println("COMPANY    COMPANY    "+company);
	String salesrefno=request.getParameter("SalesEnqRefNo");
	String salesenqno1=request.getParameter("salesenqno");
	
	String sellingPrice=request.getParameter("sellingPrice");
	String remarks=request.getParameter("remarks");
	String quantity1=request.getParameter("quantity");
	System.out.println(sellingPrice);
	String group=request.getParameter("group");
	String check=request.getParameter("check");
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
	}

%>
	
	<div align="center" style="font-size: 1.6em;"><font face="Arial" size="4" color="black">Generate Quotation</font></div>
 	
							

	<form name="generatequo" method="get" action="insertexpquo.jsp" onSubmit="return validate();" >
	<input type="hidden" id="buffer" name="buffer" value="<%=buffer %>">
<%

	String SqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo='"+salesenqno1+"' ";
	ResultSet rsDet=st.executeQuery(SqlDet);
	while(rsDet.next()){
	
%>	
	<div class="TabView" id="TabView">
					<div class="Tabs" style="width: 90%;height: auto;"><a>Export</a> <a>
					Currency </a><!--  <a>Supplier</a> --></div>
					<div class="Pages" style="width:100%; height: 19%">
					
					<div class="Page">
					<div class="Pad">
					
	
	
	<table border="0" align="left"  width="100%">
	
	<tr>
	<td><font face="Arial" size="2" color="black"><b>Export ID :</b></font></td>
	<td>
<!--	<a href="#" style="font-weight: ;" onclick="popUp('SEDetails.jsp','< %=rsDet.getString("SalesEnqRefNo")%>','< %=rsDet.getString("CompanyName") %>')">-->
	
	<font face="Arial" size="2"><%=rsDet.getString("SalesEnqRefNo") %></font></td>
	
	
	<td><font face="Arial" size="2" color="black"><b>Export Expiry date :</b></font></td>
	<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, +30);
	Date today30 = cal.getTime();
	String expdate=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	%>
	<td><input type="text" id="todate" onmousedown="unCheckAll()"
	name="todate" value="<%=expdate %>" size="15"
	readonly="readonly"
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />

	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "todate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",    // the date format
	button      : "todate"       // ID of the button
	}
	);
	</script></td>
	
	<td><font face="Arial" size="2" color="black">
	<b>Group :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></font></td>

	<td><font face="Arial" size="2" color="black"><b>Code :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="customercode" value="<%=rsDet.getString("CustomerCode") %>"/><%=rsDet.getString("CustomerCode") %></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>Contact :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="contactperson" value="<%=rsDet.getString("ContactPerson") %>"/><%=rsDet.getString("ContactPerson") %></font></td>
	</tr>
	
	<tr>
	
	<td><font face="Arial" size="2" color="black"><b>Address :</b></font></td>
	<td  style="width: 220px;"><font face="Arial" size="2" color="black"><input type="hidden" name="address" value="<%=rsDet.getString("Address") %>"/><%=rsDet.getString("Address") %></font></td>
	
	<td><font face="Arial" size="2" color="black"><b>City :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="city" value="<%=rsDet.getString("city") %>"/><%=rsDet.getString("city") %></font></td>
	<td><font face="Arial" size="2" color="black"><b>State :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="state" value="<%=rsDet.getString("State") %>"/><%=rsDet.getString("State") %></font></td>
	<td><font face="Arial" size="2" color="black"><b>Country :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="country" value="<%=rsDet.getString("country") %>"/><%=rsDet.getString("country") %></font></td>

	<td><font face="Arial" size="2" color="black"><b>Phone :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="phone" value="<%=rsDet.getString("Phone") %>"/><div align="left"><%=((rsDet.getString("Phone")!=null) ? rsDet.getString("Phone") : "-") %></div></font></td>
	</tr><tr>
	<td><font face="Arial" size="2" color="black"><b>Fax :</b></font></td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="fax" value="<%=rsDet.getString("Fax") %>"/><div align="left"><%=((rsDet.getString("Fax")!=null) ? rsDet.getString("Fax") : "-") %></div></font></td>
	<td><font face="Arial" size="2" color="black"><b>Zip code :</b></font>
	</td>
	<td><font face="Arial" size="2" color="black"><input type="hidden" name="zip" value="<%=rsDet.getString("Zip") %>"/><div align="left"><%=((rsDet.getString("Zip")!=null) ? rsDet.getString("Zip") : "-") %></div></font></td>
	</tr> 
<%}%>	
	</table>
	</div>
	</div>
	
		<div class="Page">
				<div class="Pad"> 
				
				<table style="background: white;" align="" border="0">
						<tr>
						<td><font face="Arial" size="2" color="black"><b>Currency Type :</b></font></td>
							<td>
							<select id="type" name="type" style="width: 100%" onchange="getcurval();" >
							<option value="Select">-Select-</option>
							<%
							String sqlcu="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"currencydet order by CurrencyType";
							ResultSet rsc=st.executeQuery(sqlcu);
							while(rsc.next())
							{
								%>
								<option value="<%=rsc.getString("CurrencyType") %>"><%=rsc.getString("CurrencyType") %></option>
								<%
							}
							%>
							
							</select>
							</td>
							</tr>
							<tr>
							
													<td><font face="Arial" size="2" color="black"><b>Currency Value :</b></font></td>
							<td><input type="text" id="curval" name="curval" value=""></input></td>
							</tr>
							<tr>
							
													<td><font face="Arial" size="2" color="black"><b>Currency Symbol :</b></font></td>
							<td><input type="text" id="cursmb" name="cursmb" value="" readonly="readonly"></input></td>
							</tr>
							</table>
							</div>
							</div>
							
							
							
							</div>
							</div>
						
	
	
	
	
	<br>
	
																					
	<br>
	<input type="hidden" name="addresscode" id="addresscode" value="<%=addresscode1 %>">
	<input type="hidden" id="check" name="check" value="<%=i%>" />   
	<input type="hidden" name="company" id="company" value="<%=company %>"/>
          
	<table border="1px"  class="sortable">
	<tr>
	<th>Option No</th>
	<th>Insert Or</th>
	<th>Make</th>
	<th>Part No</th>													
	<th>Description</th>
	<th>Quantity</th>
	<th>Unit Price</th>
	<th>Discount %</th>
	<th>Tax %</th>
	<th>Amount</th>	
	<th>Raised PO</th>
	</tr>
<% 
 	 //i=0;
 	double tax=0,discount=0.00 ,total=0.00;
	i=0;
	 		
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items WHERE SalesEnqNo='"+salesenqno1+"'";
	System.out.println(sqlEnq);
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next()){
	
	groupName="";makeName="";refMakeNameTable="";
	groupCode=rsEnq.getInt("TheGroup");
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     
	//System.out.println("++++++++++++++++++++++++++++++++++++");
	  
	String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5){
	refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
	   	  	
	String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
	ResultSet rsMakeName=st3.executeQuery(sqlMakename);
	if(rsMakeName.next())
	makeName=rsMakeName.getString(1);
	else
	makeName="-";
			      
	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else{
	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
	makeName="-"  ;
	}
	
	System.out.println(k+"///////  "+groupCode);
	  %>
		<input type="hidden" name="icode<%=k %>" id="icode<%=k %>" value="<%=itemCode %>"/>	
		<input type="hidden" name="gcode<%=k %>" id="gcode<%=k %>" value="<%=groupCode %>">
		<input type="hidden" name="mcode<%=k %>" id="mcode<%=k %>" value="<%=makeCode %>"/>
	    
	    <script type="text/javascript">
	  	document.getElementById('groupTop').value='<%=groupName%>';
	  
	  </script>
	  <%   
	
	ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
	
	while(rsSql.next()){
		
	
	if(buffer.toString().contains(","+k+","))
	{
%>	
	<tr>
	<%
	System.out.println("Option number is " +rsEnq.getString("TheOptionNo"));
	%>
	<td><div align="right"><%=rsEnq.getString("TheOptionNo") %></div></td>
	<td><div align="left"><%=rsEnq.getString("InsertOR") %></div></td>
	<td><div align="left"><input type="hidden" name="make<%=d %>" id="make<%=d %>" value="<%=makeName %>"/><%=makeName %></div></td>
	<td><div align="left"><%=rsSql.getString("Partno") %></div></td>
	<td><div align="left"><input type="hidden" id="description<%=d %>"  name="description<%=d %>" value="<%=request.getParameter("description"+k)%>" /><%=request.getParameter("description"+k) %></div></td>
	<td><div align="right"><input type="hidden"  id="quantity<%=d %>" name="quantity<%=d %>" value="<%=request.getParameter("quantity"+k)%>" /><%=request.getParameter("quantity"+k) %></div></td>
	
	
	
	<td>
	
	<div align="right">
	
	<input type="hidden" id="sellingPrice<%=d %>" name="sellingPrice<%=d %>"  value="<%=request.getParameter("sellingPrice"+k) %>" />
	
	<input type="text" id="Newunit<%=d %>" id="Newunit<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%=request.getParameter("sellingPrice"+k) %>" readonly="readonly" />
	
		<input type="hidden" id="NewunitD<%=d %>" name="NewunitD<%=d %>"  value="" />
	
	</div>
	</td>
	
	
	
	
	
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
<% 	
sumOfQuotation++;d++;
   }
   k=k+1;
   
   }
   }
		
%>

  	<input type="hidden" name="tax<%=k %>" id="tax<%=k %>" value="<%=tax %>"/>
	<input type="hidden" name="discount<%=k %>" id="discount<%=k %>"  value="<%=discount%>"/>
	</table>
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=sumOfQuotation %>"/>
	<%if(!(session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
    <input type="hidden" name="twempname" id="twempname" value="<%=session.getAttribute("EmpName") %>"/>
	<%} %>
  	
	
	<input type="hidden" name="remarks" id="remarks" value="<%=remarks %>"/>
	<input type="hidden" name="salesenqno" value="<%=salesenqno1 %>" />
	<input type="hidden" name="group" value="<%=groupName %>"/>
	<br>
	
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;<font face="Arial" size="2" color="black">TERMS & CONDITIONS :</font></b></div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="termsconditions"
	id="search-text" style='width: 430px; height: 160px;'></textarea></div>
	
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <font face="Arial" size="2" color="black"><b>Total:</b></font> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	 	 <input type="hidden" name="totalNew" id="totalNew" style="width: 230px; border: none;" value=""/>
	 
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<font face="Arial" size="2" color="black"><b>Total In Words : </b></font></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
	<div align="right"  >
		<input type="submit"  
	value="Save sales Quotation" style="border: outset; background-copurchalor: #C6DEFF; width: 165p" onclick="insertexpquo.jsp" />
	</div>
	
	<input type="hidden" name="termsconditions" value="termsconditions">
</form>
<script type="text/javascript">
					tabview_initialize('TabView');
				</script>
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