<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>

<%@page import="java.util.Date"%>
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

<script language="JavaScript1.2">


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
function validateQuantity(quant,balance,i)
{
//	var numericExpression = /^[0-9]+$/;
        var numericExpression = /^\d*(\.)?(\d{0,2})?$/;
	
	var j=i;
	var balance=balance;
	
	var quantity=quant;
	if(quantity!="")
	if(!(quantity.match(numericExpression))){
    	alert("Received Quantity Should Be Numeric Value");
    	document.getElementById("quantity"+j).value="";
		document.getElementById("quantity"+j).focus();
    	return false;
	}
	//alert(quantity);
	//var result=(quantity > balance) ? "Received Quantity Can Not Be Greater Than Balance Value ";
	//(parseInt(first)&gt;parseInt(second))
		//if(parseInt(quantity)&gt;parseInt(balance)){
			if(parseInt(quantity) > parseInt(balance)){
		alert("Received Quantity Can Not Be Greater Than Balance Value ");
		document.getElementById("quantity"+j).value="";
		document.getElementById("quantity"+j).focus();
		document.getElementById("quantity"+j).select();
		return false;
		
		
	}
	
	
}
function confirmSubmit()
{
	
	
	 alert("in function");

	var fup = document.forms.generategrn.formFileLg.value;
	var ext = fup.substring(fup.lastIndexOf('.') + 1);

//alert(">>"+fup+">>>>"+ext);
if(fup == "" ) 
{
      alert( "Please select file to upload.....!" );
      document.generategrn.formFileLg.focus() ;
       return false;
   } 
else{
    if(ext =="xls")
    {
      // return true;
    }
    else
    {
        alert("Upload Excel file only");
        return false;
    }
}
    var agree=confirm("Are you sure you wish submit this List?");
    if (agree){
    	return true ;
    }
    {
    else
    	return false ;
    }
	
	
</script>
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null;
	boolean isInvoiceSelected=false;
			
	double sumAmount=0; 
	int groupCode=0,makeCode=0;
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ";
	String sellingPrice="" ,priceAccepted="",quantity="";
	String scode=request.getParameter("supplierCode");
	System.out.println(">>>>>>Supplier Code   "+scode);
	String pono=request.getParameter("pono");
	System.out.println(">>>>>PoNo   <<<<< "+pono);
	int grnno=0;
//	String grnno="";
//	String grnno=request.getParameter("grnno");
//	System.out.println("GRNNo-->"+grnno);
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	String fromDate="";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_MONTH, -30);
	fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
			.getTime());
    
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
	st7 = conn.createStatement();
	} catch (Exception e) {
	}
Date d=new Date();
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	String oldgrn="";
	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where pono='"+pono+"'";
	ResultSet rspur=st6.executeQuery(sql);
	rspur.next();
	
	String oldgrn1="''";
	String sqlcheck="select grnno from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn where pono='"+pono+"'";
	ResultSet rscheck=st7.executeQuery(sqlcheck);
	while(rscheck.next()){
		oldgrn=rscheck.getString("grnno");
		oldgrn="'"+oldgrn+"'";
		oldgrn1=oldgrn1+","+oldgrn;
	}
	System.out.println("New Grnno-->"+grnno);
	
	
	
	String sqlcode="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+rspur.getString("SupplierCode")+"'";
	ResultSet rscode=st1.executeQuery(sqlcode);
	rscode.next();
//	String name=rscode.getString("SupplierName");
%>


<div align="center"
		style="font-size: 1.5em; margin-top: 0.5em; margin-bottom: 0.3em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.5em; ">
	Goods Receipt For PO No. :<%=pono %>  </a> 
	</div>
	<div align="center"
		style="font-size: 1.5em; margin-top:0.3em; margin-bottom:0.5em; height: 3px; background-color: #339CCB">
	</div>
	
	<form name="generategrn" id="generategrn" method="post" action="insertGrn.jsp" enctype="multipart/form-data" onsubmit="return confirmSubmit();" >
	<%
	
	
	%>
	
	<table width="100%">
	
	<tr> 
	<td>PO Date:</td>
	<td><%=new SimpleDateFormat(	"dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rspur.getString("PODate"))) %></td>
	
	<td>Supplier Name:</td>
	<td><%=rscode.getString(1) %></td>
	</tr>
	<tr>
	<td>Ship Date : </td>
 	<td><input type="text" id="shipdate"
name="shipdate"  value="<%=dtoday %>"  size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
<script type="text/javascript">
Calendar.setup(
{
inputField  : "shipdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "shipdate"       // ID of the button
}
);
</script></td>
	<td>Carrier : </td>
 	<td><input type="text" name="carrier" id="carrier"  size="7" value="" /></td>
 	
 	<td>Delivery Date :</td>
 	<td><input type="text" id="dtdate"
name="dtdate"  value="<%=dtoday %>"  size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
<script type="text/javascript">
Calendar.setup(
{
inputField  : "dtdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "dtdate"       // ID of the button
}
);
</script></td>
 	
	</tr>

	</table>

 <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
 
 	<table  align="center" class='sortable' style="align:center; font:normal 13px Arial,Helvtica,sans-serif;">
	<tr>
	 
	<th style="width: 125px;"><a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
	<font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a> <a href="#"
	onclick="unCheckAll()"> <font color="white">UnChk all</font></a></th>


    <th>Group</th>
	<th>Part No</th>
	<th>Description</th>
	<th>Ordered</th>
	<th>Already Received</th>
	<th>Received In This GRN</th>
	<th>Balance</th>
	
	</tr>
	
	<%
	String grnnumber="";
	int balance=0;
/*	String sqlpono=" SELECT * from twsql_twalldata.t_purchaseorder where Pono='"+pono+"' " ;
	System.out.println("SQlPono-->"+sqlpono);
	ResultSet rspono=st5.executeQuery(sqlpono);
	int i=0;
	while(rspono.next()){
		grnnumber=rspono.getString("GRNno");
		System.out.println("GRNNUmber-->"+grnnumber);
	*/
	String SqlgrnDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE pono='"+pono+"' order by itemcode";
 	System.out.println("*******    &&&&&&&&&&&&&&    "+SqlgrnDet);
 	ResultSet rsgrndet=st4.executeQuery(SqlgrnDet);
 	int i=0;
	while(rsgrndet.next())
	{	
		groupName="";makeName="";refMakeNameTable="";
		groupCode=rsgrndet.getInt("TheGroup");
		makeCode=rsgrndet.getInt("Make");
		itemCode=rsgrndet.getString("ItemCode");
		  
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
			System.out.println(sqlDisplayDesc);
		}
		else{
			sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
			System.out.println(sqlDisplayDesc);
			makeName="-"  ;
		}
	
		ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
		
		if(rsDisplayDesc.next())
		{	
			
			
			String alreadyrec="";
			String sql10="select Sum(ReceivedQuantity) as quantity from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items where grnno in ("+oldgrn1+") and Itemcode='"+itemCode+"'  group by itemcode ";
			ResultSet rs10=st7.executeQuery(sql10);
			if(rs10.next()){
				alreadyrec=rs10.getString("quantity");
			}else
			{
			
				alreadyrec="0";
			}
			
			System.out.println("alreadyrec :- "+alreadyrec);
			System.out.println("quantity  :- "+rsgrndet.getString("Quantity"));
			
	/* query to copy the records from 
	insert into twsql_twalldata.t_purchasegrn_items (GRNno,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity,TheTableToBeAccessed) select 98999,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity+1,TheTableToBeAccessed from twsql_twalldata.t_purchasegrn_items where GRNno=2309;

	*/
%>

	<tr>
			<td><input type="checkbox" checked="checked" name="check<%=i %>"   id="check<%=i %>" value="check<%=i %>" /></td>
			<td><div align="left"><%=groupName %></div></td>
			<td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
			
			<td><div align="left"><input type="hidden" id="description<%=i %>" name="description<%=i %>"   value="<%=rsDisplayDesc.getString("Description")%>" /><%=rsDisplayDesc.getString("Description") %></div></td>
			<td><div align="right"><%=rsgrndet.getString("Quantity")  %></div></td>
			<td><div align="right"><%=alreadyrec %></div></td>
			
			<td><div align="right" ><input type="text"  id="quantity<%=i %>" name="quantity<%=i %>" onblur="validateQuantity(this.value,'<%=((Double.parseDouble(rsgrndet.getString("Quantity")))-(Integer.parseInt(alreadyrec)))  %>','<%=i %>')" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="" /></div></td>
			<td><div align="right" id="balance" name="balance"><%=((Double.parseDouble(rsgrndet.getString("Quantity")))-(Integer.parseInt(alreadyrec)))%></div></td>
	 		<input type="hidden" id ="grnnumber" name="grnnumber" value="<%= grnnumber%>" />
		
	</tr>
	
	<%
		i++;
//	balance=((Integer.parseInt(rsgrndet.getString("OrderedQuantity")))-(Integer.parseInt(rsgrndet.getString("ReceivedQuantity"))));
		}
	//}
	}
	
	
%>
		</table>
			<div align="center" style="margin-top: 3em;">
		<input type="hidden" name="grnnumber" value="<%= grnnumber%>" />
		<input type="hidden" name="pono" value="<%=pono %>"/>
		<input type="hidden" name="suppliercode" value="<%=rspur.getString("SupplierCode") %>"/>
		
		<input type="hidden" name="quantity" value="<%request.getParameter("quantity"); %>"/>
	    <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i %>"/>  
	 
		
	</div>
	

	<div style="font-size: 1.0em;margin-right:2%;" align="right" >
	Proforma Invoice No. : &nbsp;&nbsp;
 	<input type="text" name="pin" id="pin"  size="8" value="" />
 	</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Supplier Order No. : &nbsp;&nbsp;
 	<input type="text" name="son" id="son"  size="8" value="" />
 	</div>	
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Total Invoice Value : &nbsp;&nbsp;
 	<input type="text" name="invval" id="invval"  size="8" value="" />
 	</div>
 	
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Gross Weight : &nbsp;&nbsp;
 	<input type="text" name="gross" id="gross"  size="8" value="" />
 	</div>
 	
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Open Policy No. : &nbsp;&nbsp;
 	<input type="text" name="policy" id="policy"  size="8" value="" />
 	</div>
 	
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Total Assessable Value : &nbsp;&nbsp;
 	<input type="text" name="assval" id="assval"  size="8" value="" />
 	</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Courier Name : &nbsp;&nbsp;
 	<input type="text" name="courier" id="courier"  size="8" value="" />
 	</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Docket No. : &nbsp;&nbsp;
 	<input type="text" name="docketno" id="docketno"  size="8" value="" />
 	</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Sender Person Details : &nbsp;&nbsp;
 	<input type="text" name="spd" id="spd"  size="8" value="" />
 	</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
			Specifications : &nbsp;&nbsp; <input type="text" name="specifications"
				id="specifications" size="8" value="" />
		</div>
		<div style="font-size: 1.0em;margin-right:2%;" align="right">
			warranty : &nbsp;&nbsp; <input type="text" name="warranty"
				id="warranty" size="8" value="" />
		</div>
		<div style="font-size: 1.0em;margin-right:2%;" align="right">
			Expiry Date : &nbsp;&nbsp; <input type="text" id="expdate" name="expdate"
					value="<%=dtoday%>" size="15" readonly
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />

					<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
					<script type="text/javascript">
						Calendar.setup({
							inputField : "expdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "expdate" // ID of the button
						});
					</script>
		</div>
		<div style="font-size: 1.0em;margin-right:2%;" align="right">
			Material Name : &nbsp;&nbsp; <input type="text" name="materialname"
				id="materialname" size="8" value="" />
		</div>
 	<div style="font-size: 1.0em;margin-right:2%;" align="right">
	Material Details/UnitId's: &nbsp;&nbsp;
 	<!-- <input type="text" name="materialdet" id="materialdet"  size="30" value="" /> -->
 	<textarea id="materialdet" name="materialdet" rows="2" cols="30"></textarea><br></br>
 	</div>
 	
 	<div style="font-size: 1.0em" align="right">
 	   <label for="formFileLg"><b>Upload Excel</b></label> 
 	   <input class="form-control" type="file" id="formFileLg" name="formFileLg" size="8" value=""><br>
	</div><br>

 	<div style="font-size: 1.0em;margin-right:11%;" align="right">
	 <label for="SampleFormat"><b>Sample Format</b></label>
			<a href="http://twtech.in/TransworldDocs/ERPDocs/100000/GRNDocs/Sample.xls" style="font-weight: bold; color: black; " >
	        <img src="images/excel.jpg" width="20px" height="20px" style="border-style: none" title="download excel format"></img></a>
 	</div>
 	
 	
 	<div align="center" style="margin-top: 3em;">
 	<input type="submit" value="submit"  style="border: outset; background-color: #C6DEFF"  />
 	</div>
 	</form>
<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
