<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="header.jsp"%>
<link href="css/footer.css" rel="stylesheet" type="text/css" media="screen" />
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
	<script language="javascript">
	
	function validrs(){ 

		var cancel=document.getElementById("reasoncancel").value;
		if(cancel=="")
			{
			alert("Please Insert Reason First");
			return false;
			}
		}
	
		function popUp(webadd,trancactionId)
		{ 
				window.open(webadd+'?salesQuotation='+trancactionId);
		}

		function closeOrder()
		{
			//alert("HHHHHH");
			var agree=confirm("Are you sure you want to close this Order?");
			if (agree)
			{
			document.getElementById("header").style.visibility="visible";
			document.getElementById("cancellingreason").style.visibility="visible";
			document.getElementById("submitbutton").style.visibility="visible";
			
			return true ;
			}
			else return false;
		}



		function calculate()
		{	
			alert("HTTT  ");
			var a;var k=0;
			var rowCount = document.getElementById("count").value;alert(rowCount);
			for(k=0;k<rowCount;k++)
			{
				var tax=document.getElementById("tax"+k).value;alert(tax);
				var discount=document.getElementById("discount"+k).value;alert(discount);
				var qua=document.getElementById("quantity"+k).value;alert(qua);
				var unitprice=document.getElementById("sellingprice"+k).value;alert(unitprice);
				
				var tax1=(tax)/100*unitprice*qua;
				var discount1=(discount)/100*unitprice*qua;
				a=unitprice*qua+tax1-discount1;alert(a);
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
				}
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

		function redirect(webadd,salesOrder)
		{
		
			window.open(webadd+'?salesOrder='+salesOrder,'jav');
		}
	</script>
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
if(null!=request.getParameter("inserted")){
	%>
	<script language="javascript">
		alert('Quotaion saved successfully in System with ID <%=request.getParameter("salesOrder")%>');
	</script>
	<%
}


	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null, stlbl=null;
	
	int groupCode=0;
	int d=0,k=0;
	double tax=0,discount=0.00,amount=0;
	int i=0;
	String groupName="",makeName="",itemCode="",sellingPrice="",makeCode="";
	String refMakeNameTable="",fromdate="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	String type=request.getParameter("condition");
	System.out.println(type);
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
	
	Date today = new Date();
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	
	String salesOrderNumber=request.getParameter("salesOrder");
	
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
	}
	 
	NumberFormat nf = new DecimalFormat("#0.00");
	
    if(type.contains("View")) 
    { 
 	String SqlOrderDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+salesOrderNumber+"' ";
 	System.out.println("*******    &&&&&&&&&&&&&&    "+SqlOrderDet);
 	ResultSet rsOrderDet=st4.executeQuery(SqlOrderDet);
 		if(rsOrderDet.next()){
 			totalAmount=rsOrderDet.getString("Total");
 			totalAmountInWords=rsOrderDet.getString("TotalinWords");
 			termsconditions=rsOrderDet.getString("SOTermsAndConditions");
 			
 			ResultSet rs=st3.executeQuery("SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsOrderDet.getString("TheGroup")+"'");
 			if(rs.next())
 				groupName=rs.getString(1);
 			
 			rs=st3.executeQuery("SELECT SalesquoRefNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where SalesQuoNo="+rsOrderDet.getString("SalesQuoNo")+" ");
 			if(rs.next())
 				salesQuoNumber=rs.getString(1);
 			
 			if(rsOrderDet.getInt("InvoiceGenerated")==1)
 			{
 				status="Invoice Generated";	statusTD="Invoice ID :"; 
 			}
 			else if(rsOrderDet.getInt("SOCancelled")==1)
 			{
 				status="Cancelled"; statusTD="Reason For Cancelling :";
 			}
 			%>
 			
 			
 	<div align="center"
 		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
 	</div>
 	<div align="center"
 		style="margin-top:0.3em; margin-bottom:0.3em; font-size: 1.5em;">
 	Sales Order :<a><%=rsOrderDet.getString("SalesorderRefNo")%></a></div>
 			
 	<div align="center"
 		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB">
 	</div>
 		<% String CurDate=rsOrderDet.getString("SalesOrderDate");
 		System.out.println("Date==>"+CurDate);	
 		CurDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(CurDate));
 		System.out.println("Date==>"+CurDate);	%>
 		
 	<table border="0px" align="left" valign="top" width="100%">
 	<tr>
 	 <td>
 		<table border="0" align="left" valign="top" width="100%" >
 		
 		<tr>
 		<td><b>Quotation Date :</b></td>
      	<td><%=CurDate%></td>
 		<td><b>Sales Quotation :</b></td>
 		<td>
 		<a href="#" style="font-weight: bold;" onclick="popUp('viewQuotation.jsp','<%=rsOrderDet.getString("SalesQuoNo")%>')">
 		<%=salesQuoNumber %></a></td>
 		</tr>
 		<tr>
 		<td><b>Time :</b></td>
 		<td><font size="2.5"><%=rsOrderDet.getString("SalesOrderTime") %></font></td>
  
 		<td><b>Group :</b></td>
 		<td><%=groupName %></td>
 		</tr>
 		
 		<tr>
 		<td><b>Sales QuotNo :</b></td>
 		<td><font size="2.5"><%=rsOrderDet.getString("SalesQuoNo") %></font></td>
  
 		<td><b>Sign :</b></td>
 		<td><%=rsOrderDet.getString("TWEmpName") %></td>
 		</tr>
 		
 		<tr>
 		<td><b>CURRENCY :</b></td>
 		<td><font size="2.5"><%=rsOrderDet.getString("CurrType") %></font></td>
  
 		<td><b>Status :</b></td>
 		<td><%=status %></td>
 		</tr>
 		</table>
 	</td>
 	<td>	
 		<table  border="0" bgcolor="#C6DEFF" align="right" valign="top">
 		<tr>
 		<td><b>Company:</b></td>
 		<td><%=rsOrderDet.getString("CompanyName") %></td>
 		
 		<td><b>Contact:</b></td>
 		<td><%=rsOrderDet.getString("ContactPerson") %></td>
 		<td><b>Address:</b></td>
 		<td style="width: 250px;"><%=rsOrderDet.getString("Address") %></td>
 		</tr>
 		<td>&nbsp;</td>
 		<tr>
 		<td><b>City:</b></td>
 		<td><%=rsOrderDet.getString("city") %></td>
 		<td><b>State:</b></td>
 		<td><%=rsOrderDet.getString("State") %></td>
 		<td><b>Country:</b></td>
 		<td><%=rsOrderDet.getString("country") %></td>
 		</tr>
 		<td>&nbsp;</td>
 		<tr>
 		<td><b>Phone:</b></td>
 		<td><div align="left"><%=((rsOrderDet.getString("Phone")!=null) ? rsOrderDet.getString("Phone") : "-") %></div></td>
 		<td><b>Fax:</b></td>
 		<td><div align="left"><%=((rsOrderDet.getString("Fax")!=null) ? rsOrderDet.getString("Fax") : "-") %></div></td>
 		<td><b>Zip code:</b></td>
 		<td><div align="left"><%=((rsOrderDet.getString("Zip")!=null) ? rsOrderDet.getString("Zip") : "-") %></div></td>
 		</tr> 
 		 
 	  <%}%>	
 	  </table>
 	 </td>
 	</tr>
 	
 	<tr><td>&nbsp;</td></tr>
 	
 	</table>	
 <div>&nbsp;&nbsp;</div>
 		
 	

 	<table  class="sortable">
 	<tr>
 	<th>Sr No</th>
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
  	
 	i=0;
 	int cnt=1;
 	 		
 	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items WHERE SalesOrderNo='"+salesOrderNumber+"'";
 	System.out.println(sqlQuoItems);

 	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
 		while(rsQuoItems.next())
 		{
 			groupName="";makeName="";refMakeNameTable="";
 			groupCode=rsQuoItems.getInt("TheGroup");
 			makeCode=rsQuoItems.getString("Make");
 			itemCode=rsQuoItems.getString("ItemCode");
 			  
 			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
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
 			else{
 				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
 				makeName="-"  ;
 			}
 		
 			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
 			i=1;
 			if(rsDisplayDesc.next())
 			{
 		    %>
 		    <tr>
 			    <td><%=cnt++ %></td>
 			    <td><div align="left"><%=makeName %></div></td>
 			    <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
 			    <td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
 		   	    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
 			    <td><div align="right"><%=rsQuoItems.getString("Quantity") %></div></td>
 			    <td><div align="right"><%=rsQuoItems.getString("SellingPrice") %></div></td>
 			    <td><div align="right"><%=rsQuoItems.getString("DiscountPercent") %></div></td>
 			    <td><div align="right"><%=rsQuoItems.getString("STPercent") %></div></td>
 			    
 			<% double sp=rsQuoItems.getDouble("SellingPrice");
				      double dp=rsQuoItems.getDouble("DiscountPercent");
				      double stper=rsQuoItems.getDouble("STPercent");
				      double qty=rsQuoItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
 			  %>
 			    
 			    
 			    
 			    <td><div align="right"><%=nf.format(tot)%></div></td>
 		    </tr>
 		    <% 
 		   }
 			
 		   }
 %>	
 	</table>
 	<br>
 	<div align="left" style="position:absolute; font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
 	<div align="left" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea readonly="readonly" name="termsconditions"
 	    id="search-text" style='border:none; width: 430px; height: 130px;'><%=termsconditions %></textarea></div>
 	
 	
 	<div style="font-size: 1.0em" align="right">
 	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
 	</div>
 	
 	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
 		<b>Total In Words : </b></td><td>
 		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
 		</td></tr></table>
 	</div>
 
 <div align="center" id="printbutton" style="margin-top: 3em;">
	<input type="submit" name="printOrder" value="Print" onclick="redirect('printSalesOrder.jsp','<%=salesOrderNumber %>');"  style="border: outset; background-color: #C6DEFF"  />
</div>	
<%
 }
 %>
 <div>&nbsp;&nbsp;</div>
	<%
	
if(type.contains("close")) 
{ 
	String SqlOrderDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+salesOrderNumber+"' ";
	System.out.println("*******    &&&&&&&&&&&&&&    "+SqlOrderDet);
	ResultSet rsOrderDet=st4.executeQuery(SqlOrderDet);
		if(rsOrderDet.next()){
			totalAmount=rsOrderDet.getString("Total");
			totalAmountInWords=rsOrderDet.getString("TotalinWords");
			termsconditions=rsOrderDet.getString("SOTermsAndConditions");
			
			ResultSet rs=st3.executeQuery("SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsOrderDet.getString("TheGroup")+"'");
			if(rs.next())
				groupName=rs.getString(1);
			
			rs=st3.executeQuery("SELECT SalesquoRefNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where SalesQuoNo="+rsOrderDet.getString("SalesQuoNo")+" ");
			if(rs.next())
				salesQuoNumber=rs.getString(1);
			
			if(rsOrderDet.getInt("InvoiceGenerated")==1)
			{
				status="Invoice Generated";	statusTD="Invoice ID :"; 
			}
			else if(rsOrderDet.getInt("SOCancelled")==1)
			{
				status="Cancelled"; statusTD="Reason For Cancelling :";
			}
			%>
			
			
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
	<div align="center"
		style="margin-top:0.3em; margin-bottom:0.3em; font-size: 1.5em;">
	Sales Order :<a><%=rsOrderDet.getString("SalesorderRefNo")%></a></div>
			
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB">
	</div>
		
		
	<table border="0px" align="left" valign="top" width="100%">
	<tr>
	 <td>
		<table border="0" align="left" valign="top" width="100%" >
		
		<tr>
		<td><b>Quotation Date :</b></td>
     	<td><%=rsOrderDet.getString("SalesOrderDate").substring(0,10) %></td>
		<td><b>Sales Quotation :</b></td>
		<td>
		<a href="#" style="font-weight: bold;" onclick="popUp('viewQuotation.jsp','<%=rsOrderDet.getString("SalesQuoNo")%>')">
		<%=salesQuoNumber %></a></td>
		</tr>
		<tr>
		<td><b>Time :</b></td>
		<td><font size="2.5"><%=rsOrderDet.getString("SalesOrderTime") %></font></td>
 
		<td><b>Group :</b></td>
		<td><%=groupName %></td>
		</tr>
		
		<tr>
		<td><b>Sales QuotNo :</b></td>
		<td><font size="2.5"><%=rsOrderDet.getString("SalesQuoNo") %></font></td>
 
		<td><b>Sign :</b></td>
		<td><%=rsOrderDet.getString("TWEmpName") %></td>
		</tr>
		
		<tr>
		<td><b>CURRENCY :</b></td>
		<td><font size="2.5"><%=rsOrderDet.getString("CurrType") %></font></td>
 
		<td><b>Status :</b></td>
		<td><%=status %></td>
		</tr>
		</table>
	</td>
	<td>	
		<table  border="0" bgcolor="#C6DEFF" align="right" valign="top">
		<tr>
		<td><b>Company:</b></td>
		<td><%=rsOrderDet.getString("CompanyName") %></td>
		
		<td><b>Contact:</b></td>
		<td><%=rsOrderDet.getString("ContactPerson") %></td>
		<td><b>Address:</b></td>
		<td style="width: 250px;"><%=rsOrderDet.getString("Address") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>City:</b></td>
		<td><%=rsOrderDet.getString("city") %></td>
		<td><b>State:</b></td>
		<td><%=rsOrderDet.getString("State") %></td>
		<td><b>Country:</b></td>
		<td><%=rsOrderDet.getString("country") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>Phone:</b></td>
		<td><div align="left"><%=((rsOrderDet.getString("Phone")!=null) ? rsOrderDet.getString("Phone") : "-") %></div></td>
		<td><b>Fax:</b></td>
		<td><div align="left"><%=((rsOrderDet.getString("Fax")!=null) ? rsOrderDet.getString("Fax") : "-") %></div></td>
		<td><b>Zip code:</b></td>
		<td><div align="left"><%=((rsOrderDet.getString("Zip")!=null) ? rsOrderDet.getString("Zip") : "-") %></div></td>
		</tr> 
		 
	  <%}%>	
	  </table>
	 </td>
	</tr>
	
	<tr><td>&nbsp;</td></tr>
	
	</table>	
<div>&nbsp;&nbsp;</div>
		
	

	<table  class="sortable">
	<tr>
	<th>Sr No</th>
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
 	
	i=0;
	int cnt=1;
	 		
	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items WHERE SalesOrderNo='"+salesOrderNumber+"'";
	System.out.println(sqlQuoItems);

	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
		while(rsQuoItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItems.getInt("TheGroup");
			makeCode=rsQuoItems.getString("Make");
			itemCode=rsQuoItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
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
			else{
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
				makeName="-"  ;
			}
		
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			i=1;
			if(rsDisplayDesc.next())
			{
		    %>
		    <tr>
			    <td><%=cnt++ %></td>
			    <td><div align="left"><%=makeName %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
		   	    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("Quantity") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("SellingPrice") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("DiscountPercent") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("STPercent") %></div></td>
			    <% double sp=rsQuoItems.getDouble("SellingPrice");
				      double dp=rsQuoItems.getDouble("DiscountPercent");
				      double stper=rsQuoItems.getDouble("STPercent");
				      double qty=rsQuoItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
			    <td><div align="right"><%=nf.format(tot)%></td>
		    </tr>
		    <% 
		   }
			
		   }
%>	
	</table>
	<br>
	<div align="left" style="position:absolute; font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
	<div align="left" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea readonly="readonly" name="termsconditions"
	    id="search-text" style='border:none; width: 430px; height: 150px;'><%=termsconditions %></textarea></div>
	
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
		</td></tr></table>
	</div>
	
	
<div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeInvoice" value="close Order" onclick="closeOrder();"  style="border: outset; background-color: #C6DEFF"  />
</div>	

	
<form name="closeorder" method="get" action="closeOrder.jsp">	
	
<div align="left"  id="header" style="position:absolute;font-size: 1.1em"><b> &nbsp;Reason For Cancelling :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>

<div align="left"  id="cancellingreason" style="position:absolute; margin-top: 1em;font-size: 1.2em"> &nbsp;
<textarea name="reasonforcancel" align="right" id="reasoncancel" style='width: 430px; height: 130px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>
	
<div align="center" id="submitbutton" style="margin-top: 3em;">
	<input type="submit" name="Submit TT" value="Submit Reason" style="border: outset; background-color: #C6DEFF" onclick="return validrs();" />
	<script>document.getElementById("submitbutton").style.visibility="hidden";</script>
</div>	
	
<input type="hidden" name="salesorderno" value="<%=salesOrderNumber %>"/>	
<input type="hidden" name="reasonforcancel" value="reasonforcancel"/>
	
</form>	

<%
}
%>
<div>&nbsp;&nbsp;</div>
<%

//*****************************************   FOR REVISE *************************************************************************" 

if(type.contains("revise"))
{
	
		String SqlOrder="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+salesOrderNumber+"' ";
		System.out.println("^&&&&&&&&&&&&^^^^^^^^^^^^     *****     "+SqlOrder);
		ResultSet rsOrder=st4.executeQuery(SqlOrder);
		if(rsOrder.next()){
			
		%>	
<br>

		<div align="center" style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
		</div>
		<div align="center" style="margin-top:0.3em; margin-bottom:0.3em; font-size: 1.5em;">
		Sales Order :<%=rsOrder.getString("SalesorderRefNo") %><a></a></div>
		<div align="center" style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB">
		</div>

<form name="revise" method="get" action="ReviseOrder.jsp">

	<table border="0px" align="left" valign="top" width="100%">
	<tr>
	 <td>
		<table border="0" align="left" valign="top" width="100%" >
		
		<tr>
		<td><b>Order Date :</b></td>
     	<td><input type="hidden" name="orderdate" value="<%=todaysDate %>"/><%=todaysDate %></td>
		<td><b>Time :</b></td>
		<td><input type="hidden" name="ordertime" value="<%=todaysTime%>"/><font size="2.5"><%=todaysTime%></font></td>
 		</tr>
 		<%
 		String group="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsOrder.getString("TheGroup")+"' ";
 		System.out.println(group);
		ResultSet rs=st.executeQuery(group);
		if(rs.next())
			groupName=rs.getString(1);
 		%>
 		<tr>
		<td><b>Group :</b></td>
		<td><input type="hidden" name="groupname" value="<%=groupName %>"/><%=groupName %></td>
		<td><b>Expiry date:</b></td>
		<td><input type="hidden" name="expirydate" value="<%=fromdate %>"/>
					 <div id="seRefNo">
					 <input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
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
			</script></div>
		</td>	
		</tr>
		
		</table>
	</td>
	<td>	
		<table  border="0" bgcolor="#C6DEFF" align="right" valign="top">
		<tr>
		<td><b>Company:</b></td>
		<td><input type="hidden" name="company" value="<%=rsOrder.getString("CompanyName") %>"/><%=rsOrder.getString("CompanyName") %></td>
		
		<td><b>Contact:</b></td>
		<td><input type="hidden" name="contactperson" value="<%=rsOrder.getString("ContactPerson") %>"/><%=rsOrder.getString("ContactPerson") %></td>
		<td><b>Address:</b></td>
		<td style="width: 250px;"><input type="hidden" name="address" value="<%=rsOrder.getString("Address") %>"/><%=rsOrder.getString("Address") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>City:</b></td>
		<td><input type="hidden" name="city" value="<%=rsOrder.getString("city") %>"/><%=rsOrder.getString("city") %></td>
		<td><b>State:</b></td>
		<td><input type="hidden" name="state" value="<%=rsOrder.getString("State") %>"/><%=rsOrder.getString("State") %></td>
		<td><b>Country:</b></td>
		<td><input type="hidden" name="country" value="<%=rsOrder.getString("country") %>"/><%=rsOrder.getString("country") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>Phone:</b></td>
		<td><input type="hidden" name="phone" value="<%=rsOrder.getString("Phone") %>"/><div align="left"><%=((rsOrder.getString("Phone")!=null) ? rsOrder.getString("Phone") : "-") %></div></td>
		<td><b>Fax:</b></td>
		<td><input type="hidden" name="fax" value="<%=rsOrder.getString("Fax") %>"/><div align="left"><%=((rsOrder.getString("Fax")!=null) ? rsOrder.getString("Fax") : "-") %></div></td>
		<td><b>Zip code:</b></td>
		<td><input type="hidden" name="zip" value="<%=rsOrder.getString("Zip") %>"/><div align="left"><%=((rsOrder.getString("Zip")!=null) ? rsOrder.getString("Zip") : "-") %></div></td>
		</tr> 
		 
	  <%}%>	
	  </table>
	  
	  <input type="hidden" name="salesquono" value="<%=rsOrder.getString("SalesQuoNo") %>"/>
	  <input type="hidden" name="customercode" value="<%=rsOrder.getString("CustomerCode") %>"/> 	
	  <input type="hidden" name="groupcode" value="<%=rsOrder.getString("TheGroup") %>"/>   	  
	  <input type="hidden" name="addresscode" value="<%=rsOrder.getString("AddressCode") %>"/> 	   
	  </td>
	</tr>
	
	<tr><td>&nbsp;</td></tr>
	
	</table>

<div>&nbsp;</div>
<table border="1px" class="sortable">
	<tr>
	<th>Sr No</th>
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
 	
	i=0;
	int cnt=1;
	 		
	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items WHERE SalesOrderNo='"+salesOrderNumber+"'";
	System.out.println(sqlQuoItems);
	
	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
		while(rsQuoItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItems.getInt("TheGroup");
			makeCode=rsQuoItems.getString("Make");
			itemCode=rsQuoItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
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
			else{
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
				makeName="-"  ;
			}
			
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			i=1;
			if(rsDisplayDesc.next())
			{
		    %>
		    <tr>
		    <%double sp=rsQuoItems.getDouble("SellingPrice");
		      double dp=rsQuoItems.getDouble("DiscountPercent");
		      double stper=rsQuoItems.getDouble("STPercent");
		      double qty=rsQuoItems.getInt("Quantity");
		      double disval=(sp-((dp/100)*sp));
		      System.out.println("disc value-->"+disval);
		      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
		      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);%>
			    <td><%=cnt++ %></td>
			    <td><div align="left"><%=makeName %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
		   	    <td><div align="left"><input type="hidden" id="description<%=d %>" name="description<%=d %>" value="<%=rsDisplayDesc.getString("Description") %>"/><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td><div align="right"><input type="text"  id="quantity<%=d %>" name="quantity<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItems.getString("Quantity") %>" /></div></td>
			    <td><div align="right"><input type="text"  id="sellingprice<%=d %>" name="sellingprice<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItems.getString("SellingPrice") %>" /></div></td>
			    <td><div align="right"><input type="text"  id="discount<%=d %>" name="discount<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItems.getString("DiscountPercent") %>" /></div></td>
			    <td><div align="right"><input type="text"  id="tax<%=d %>" name="tax<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItems.getString("STPercent") %>" /></div></td>
			    <td><div align="right"><input type="text"  id="amount<%=d %>" name="amount<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=tot%>"/></td>
			    
			    
		    </tr>
		    <input type="hidden" name="groupcode<%=d %>" value="<%=groupCode%>"/>
	<input type="hidden" name="makecode<%=d %>" value="<%=makeCode%>"/>
	<input type="hidden" name="itemcode<%=d %>" value="<%=itemCode%>"/>
	<input type="hidden" name="quantity<%=d %>" value="<%=rsQuoItems.getString("Quantity") %>"/>
	<input type="hidden" name="tax<%=d %>" id="tax<%=d %>" value="<%=tax %>"/>
	<input type="hidden" name="discount<%=d %>" id="discount<%=d %>"  value="<%=discount %>"/>
	<input type="hidden" name="amount<%=d %>" id="amount<%=d %>" value="<%=amount %>"/>
	<input type="hidden" name="sellingPrice<%=d %>" id="sellingPrice<%=d %>" value="<%=rsQuoItems.getString("SellingPrice")  %>"/>
	
		    <% d++;
		   }
	   }
		int count=cnt-1;
%>  

	<tr>
	
	</tr>
	</table>
	
	<table>
	<tr>
	<td>
	<input type="hidden" id="salesorderno" name="salesorderno" value="<%=request.getParameter("salesOrder") %>"/>
	<input type="hidden" id="count" name="count" value="<%=count %>"/>
	
	</td>
	</tr>
	</table>
	
	<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="termsconditions"
	id="search-text" style='width: 430px; height: 160px;'></textarea></div>
	<input type="hidden" name="termsconditions" value="<%=termsconditions %>"/>
		
		
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	<br>
	<div style="font-size: 1.0em;" align="right">
	<b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	<input type="hidden" name="total" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
	<b>Total In Words : </b></td><td>
	<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
	</td></tr></table>
	<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
	</div>
	
	<div align="center">
	<table>
	<tr>
	<td>
	<input type="submit" style="border: outset; background-color: #C6DEFF;width: 165px;" name="ReviseQuotation" value="Revise Quotation" />
	</td>
	</tr>
	</table>
	</div>		
	</br>
	
	</form>
<%} %>
	
<!-- <br><br><br><br><br><br><br><br><br><br><br>  -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>