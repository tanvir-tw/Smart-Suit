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

function printpage() {
    //Get the print button and put it into a variable
    var printButton = document.getElementById("printGRN");
    //Set the print button visibility to 'hidden' 
    printButton.style.visibility = 'hidden';
    //Print the page content
    window.print()
    //Set the print button to 'visible' again 
    //[Delete this line if you want it to stay hidden after printing]
    printButton.style.visibility = 'visible';
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
	String newgrn=request.getParameter("newgrn");
	System.out.println("NewGRN-->>>"+newgrn);
	
	String oldgrn1="''";
		

	
	String sqlGrn="SElect * from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn where grnno='"+newgrn+"' ";
	ResultSet rsGrn=st.executeQuery(sqlGrn);
	if(rsGrn.next());
	
	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where pono='"+rsGrn.getString("PONo")+"'";
	ResultSet rspur=st6.executeQuery(sql);
	rspur.next();
	
	
	String sqlcheck="select grnno from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn where pono='"+rsGrn.getString("PONo")+"'and grnno not in ('"+newgrn+"')  ";
	ResultSet rscheck=st7.executeQuery(sqlcheck);
	while(rscheck.next()){
		oldgrn=rscheck.getString("grnno");
		oldgrn="'"+oldgrn+"'";
		oldgrn1=oldgrn1+","+oldgrn;
	}
	
	System.out.println("Old GRN no-->"+oldgrn1);
	
	String sqlcode="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+rsGrn.getString("SupplierCode")+"'";
	ResultSet rscode=st1.executeQuery(sqlcode);
	rscode.next();
//	String name=rscode.getString("SupplierName");
%>

<div align ="right" style="font-size: 1.5em; ">
Transworld Compressor Technologies Ltd.
</div>
<br><br>

	<div align="center" style="font-size: 1.5em; ">
	Goods Receipt For PO No. :<%=rspur.getString("PONo") %>  </a> 
	</div>
	<br>
	
	<form name="generategrn" method="post" action="purchaseGRN report.jsp">
	<%
	
	
	%>
	
	<table width="100%" border="1px" style="background-color: #F8F8FF">
	<tr>
	<td>GRN No:</td>
	<td><%=rsGrn.getString("grnno") %></td>
	<td>GRN Date:</td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsGrn.getString("grndate"))) %></td>
	</tr>
	<tr> 
	<td>PO No:</td>
	<td><%=rspur.getString("PONo") %></td>
	<td>PO Date:</td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rspur.getString("PODate"))) %></td>
	
	
	</tr>
	<tr>
	<td>Supplier Name:</td>
	<td><%=rscode.getString(1) %></td>
	<td>Ship Date : </td>
 	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsGrn.getString("ShipmentDate"))) %></td>
 	</tr>
 	<tr>
 	<td>Supplier Order:</td>
 	<td><%=rsGrn.getString("SupOrderNo") %></td>
 	<td>Carrier : </td>
 	<td><%= rsGrn.getString("carrier")%></td>
 	</tr>
 	
 	
	</tr>
  
	</table>

 <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
 
  
 	<table border="1px" align="center" class='sortable' style="align:center; font:normal 13px Arial,Helvtica,sans-serif;">
	<tr>
	 
	


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
	

	int number=Integer.parseInt(request.getParameter("checkedNumber"));	
	
	String SqlgrnDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items WHERE GRNno='"+newgrn+"' order by itemcode ";
 	System.out.println("*******    &&&&&&&&&&&&&&    "+SqlgrnDet);
 	ResultSet rsgrndet=st4.executeQuery(SqlgrnDet);
 	int i=0;
 	int j=0;
 	
 	
 	
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
		else
		{
			sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
			//System.out.println(sqlDisplayDesc);
			makeName="-"  ;
		}
	
		ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
		
		if(rsDisplayDesc.next())
		{	
	/* query to copy the records from 
	insert into twsql_twalldata.t_purchasegrn_items (GRNno,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity,TheTableToBeAccessed) select 98999,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity+1,TheTableToBeAccessed from twsql_twalldata.t_purchasegrn_items where GRNno=2309;

	*/

	
	
		if(j<number){
			String alreadyrec="";
			String sql10="select Sum(ReceivedQuantity) as quantity from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items where grnno in ("+oldgrn1+") and grnno not in ("+newgrn+") and ItemCode='"+itemCode+"' group by itemcode ";
			ResultSet rs10=st7.executeQuery(sql10);
			if(rs10.next()){
				alreadyrec=rs10.getString("quantity");
			}else
				alreadyrec="0";
			
%>
			

	<tr>
			
			<td><div align="left"><%=groupName %></div></td>
			<td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
			
			<td><div align="left"><input type="hidden" id="description" name="description"   value="<%=rsDisplayDesc.getString("Description")%>" /><%=rsDisplayDesc.getString("Description") %></div></td>
			<td><div align="right"><%=rsgrndet.getString("OrderedQuantity")  %></div></td>
			<td><div align="right"><%=alreadyrec%></div></td>
			
			<%
			String recquant=request.getParameter("quantity"+j);
			if(recquant=="" || recquant==" "){
				recquant="0";
			}
			%>
			<td><div align="right"><%= recquant%></div></td>
			
			<td><div align="right"><%=((Integer.parseInt(rsgrndet.getString("OrderedQuantity")))-(Integer.parseInt(alreadyrec))-(Integer.parseInt(recquant)))%></div></td>
	 
		
	</tr>
	
	<%
	//	i++;
	j++;
	}
		}
	}
	
	
	
%>
		</table>
		<br><br>	
	
	<div style="font-size: 1.0em" align="left">
	<table>
	<tr>
	<td>Proforma Invoice :</td> 
 	<td><%=rsGrn.getString("ProformaInvoiceNo") %></td>
 	</tr>
 	
 	<tr>
	<td></>Supplier Order :</td>
 	<td><%=rsGrn.getString("SupOrderNo") %></td>
 	
 	
 	<tr>
	<td></>Total Invoice Value : </td>
 	<td><%=rsGrn.getString("TotalInvoiceValue") %></td>
 </tr>
 	
 	<tr>
 	<td></>Gross Weight :</td>
 	<td><%=rsGrn.getString("GrossWeight") %></td>
 
 	</tr>
 	<tr>
 <td>
	Open Policy :</td>
 <td>	<%=rsGrn.getString("OpenPolicyNo") %></td>
 	</tr>
 	
 	<tr>
	<td></>Total Assessable Value :</td>
 	<td><%=rsGrn.getString("TotalAssessableValue") %></td>
 	</tr>
 		<tr>
	<td>Courier Name :</td>
 	<td><%=rsGrn.getString("CourierName") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Docket No :</td>
 	<td><%=rsGrn.getString("DocketNo") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Sender Person Details :</td>
 	<td><%=rsGrn.getString("SenderPersonDetails") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Material Details/UnitId's :</td>
 	<td><%=rsGrn.getString("MaterialDetails") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	</div>
 	</table>
 	
 	
 	<div align="center" style="margin-top: 3em;">
 	<!-- <a href="Print" onclick="window.print();return false;" title="Print"></a>  -->
 	<input type="submit" id="printGRN" name="printGRN" value="Print" onclick="printpage();return true;"  style="border: outset; background-color: #C6DEFF"  />
 	</div>
 	</form>
<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br>
	
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>