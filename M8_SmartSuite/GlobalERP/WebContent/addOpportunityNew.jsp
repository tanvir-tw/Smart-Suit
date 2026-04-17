<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Opportunity Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>


<!-- <style>-->
<!--th-->
<!--{-->
<!--background: #C6DEFF;-->
<!--}-->
<!--</style>-->
<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.categoryform.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["categoryform"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteRow(id)
{
	// alert(id);
	 var id=id;
	 var agree=confirm("Do You Want To Deactivate This Record?");
	 //alert(agree);
	 if(agree)
	 {
	 	 
	 var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(">>>    "+reslt);
				var data=reslt.split("#");
				//alert("<*****  "+data);
				if(data[1].indexOf('Yes')!=-1)
				{alert("De-activated successfully.....");					
			    	window.location.reload();
			    	
				}
			
			} 
		}
		
		var queryString = "?action=delete&Id="+id;
		
		
		ajaxRequest.open("GET", "opportunityCancel.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 }
	 else
	 	 {
	 	 
	 	  return false;
	     }
	 
	
}  


function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,k=1,flag="t";
	var chklength=document.getElementsByName("chkbx");
//	alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
	var i=1,j,cnt=0;
	var id="";
	//alert("hiiiii1");
	
	if(flag == "success")
	{
	for(cnt=0;cnt<chklength.length;cnt++)
	{
		//alert("for"+chklength.length);
		
		if(document.getElementById("chk"+i).checked)
		{
			//alert("if");
			id=id+","+document.getElementById("net_id1"+i).innerHTML;
		}
		i++;
	}
	//alert("check"+id);
	DeleteRow(id);
	}
	else
	{
		alert("Please Select Category For Deactivation");
	}
	
}
function getCustomer(customer){
	alert("hi");
	alert(document.getElementById('customer').value=customer);
}
</script>
</head>
<body>

<% erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD); %>
<%!
Connection conn=null;
%>

<%

conn=erp.ReturnConnection();
Statement st=conn.createStatement();
Statement st1=conn.createStatement();
%>

<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";

	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	
	String companyname=request.getParameter("companyname");
	companyname=companyname.replace("...","&");
	%>
	 
	
<div align="center">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<table  align="center" style="width: 70%;">
<tr>
<td align="center" colspan="4">
<a align="center" style="font-size:1.6em"><b>Opportunity Report</b></a></td>

<tr>
	
	<td>
         <b><font size="2">Customer:</font></b>
           <select name="companyname" id="companyname" style="width: 125px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
            <option selected><%=companyname%></option>  
            <%
            String customer="";
       	String sqlregno = "SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName";
		System.out.println("*******"+sqlregno);
        ResultSet rsregno = st.executeQuery(sqlregno);
		while(rsregno.next())
		{
			 
			 customer=rsregno.getString("CompanyName");
			 
			 System.out.println("Customer-->"+customer);
			%>
			<option value="<%=customer%>"><%=customer%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
          
		<%System.out.println("Date from-"+dtoday);
		System.out.println("Date to-"+dtoday);
		%>
		<td id="frmDT" align="left" style="display:'' "><b><font size="2">From : </font></b>&nbsp;&nbsp; <input
			type="text" size="8" id="data" name="data"
			value="<%=fromDate1 %>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td id="toDT" align="left" style="display:''"><b><font size="2">To : </font></b>&nbsp;&nbsp; <input
			type="text" size="8" id="data1" name="data1"
			value="<%=dtoday %>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td align="left"><input type="submit" name="submit" id="submit"
			value="submit"></td>
	</tr>
</tr>


</table>
</form>
</div>

<div>
<table width ="100%" border="0">	
<tr align="left"><td><a href="new_opportunityMaster.jsp?companyNames=<%=request.getParameter("companyname")%>&customercode=<%=request.getParameter("customercode")%>&customertype=<%=request.getParameter("customertype")%>"><b>Add New</b></a></td>

<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('dept','tableHTML');"/>

	           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>					
		</tr></table>
</div>

<form  name="categoryform"id="categoryform" action="" method="post" name="">
<%
String exportFileName="opportunity_report.xls"; 
String company= request.getParameter("companyname");

//System.out.println("company :- "+company);

//String c1="";



//System.out.println("C1-->"+c1);


//String company= session.getAttribute("Company").toString();
//System.out.println("Session Company-->"+session.getValue("Company").toString());
//session.setAttribute("Company", request.getParameter("companyNames"));
//String user=request.getParameter("companyNames");
	//session.setAttribute("Company",user) ; 
System.out.println("Company in Session-->"+session.getAttribute("company"));
// GIVE YOUR REPORT NAME
%>




		
<div id='dept' align="center" style="height: 400px;">

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

			
			
			
<tr></tr>		
<table align="center" id="reporttbl" class="sortable" border="3" style=" color: black;border-collapse:collapse; width: 100%;" >
<thead>
<tr>
<th><b>Deactivate</b></th>
<th><b>Edit</b></th>
<th><b>Sr.</b></th>
<th><b>Customer Name</b></th>
<th><b>Marketing Rep.Name</b></th>
<th><b>Opportunity Branch</b></th>
<th><b>Billing Branch</b></th>
<th><b>Consignor</b></th>
<th><b>Consignee</b></th>
<th><b>Origin</b></th>
<th><b>Destination</b></th>
<th><b>Freight Type</b></th>
<th><b>Load Type</b></th>
<th><b>Monthly Volume(Tons)</b></th>
<th><b>Products</b></th>
<th><b>Lead Reference</b></th>
<th><b>Existing Transporter Name</b></th>
<th><b>Collection Staff</b></th>
<th><b>Liaison</b></th>
<th><b>LiaisonContact</b></th>
<th><b>Risk Involved</b></th>
<th><b>Valid From</b></th>
<th><b>Valid To</b></th>
<th><b>Commission</b></th>
<th><b>Remarks</b></th>
<th><b>Entry By</b></th>
<th><b>Entry DateTime</b></th>


</tr>
</thead>


<%
/////////
 
 String date="",status1="";
String cust="",date1="",date2="";
cust=request.getParameter("companyname");
cust=cust.replace("and","&");
String customercode=request.getParameter("customercode");
if (!(null == request.getParameter("data"))) {
	System.out.println("In request get");
	cust=request.getParameter("companyname");
	
	cust= cust.replaceAll("'", "''");
	cust=cust.replace("and","&");
	
	System.out.println("Customer name is"+cust);
	 date1=request.getParameter("data");
	date2=request.getParameter("data1");
	
	System.out.println("Customer-----------"+cust+"Code For Customer"+customercode);

	fromDate = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(date1));
	
	toDate = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(date2));
	
}
	String fromDateTime = fromDate + " " + "00:00:00";
	String toDateTime = toDate + " " + "23:59:59";
	String sql="";	

  //if(cust.equals("All")){
	//sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where entrydatetime>='"+fromDateTime+ "' and entrydatetime<='"+toDateTime+"' and Status='Yes' order by entrydatetime desc  ";
//}else
	//  sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where (customer='"+cust+"' Or consigner='"+cust+"' Or consignee='"+cust+"') and entrydatetime>='"+fromDateTime+ "' and entrydatetime<='"+toDateTime+"' and Status='Yes' order by entrydatetime desc  ";
	
	  if(cust.equals("All")){
			sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where Status='Yes' order by entrydatetime desc  ";
		}else
			  sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where (customer='"+cust+"') order by entrydatetime desc  ";
	  /* Or consigner='"+cust+"' Or consignee='"+cust+"' */						

System.out.println("Sql->"+sql);
 ResultSet rs = st1.executeQuery(sql);
 String name="",color="";
 int j=0;
 int i=0;
 while(rs.next())
 {  
	
	j++; 
	 if (rs.getString("Status").equalsIgnoreCase("Yes")) 
	{
		 color = "#FF8080";

		} else 
		{

			color = "#CCFF99";
		}
	 System.out.println("colorrrrrrr"+color);
	 
 %>
 <tr style="background:<%=color%>;">
 <td style="width: 2%"><a href="#"  style="font-weight: bold; color: black; "  onclick="DeleteRow('<%= rs.getString("srno")%>') "><img src="images/delete.JPG"  width="20px" height="18px"  style="border-style: none"  ></img></a></td>
<td  width="" align="right"><a href="Edit_newopportunityMaster.jsp?Id=<%=rs.getString("srno")%>&companyNames=<%=rs.getString("customer")%>"><img src="images/edit.JPG" width ="18px" height="18px"></a></td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= ++i%></td>	
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("customer")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("markRep")%></td>				
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("branchName")%></td>	
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("billBranch")%></td>	
 <td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("consigner")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("consignee")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("locationFrom")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("locationTo")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("frttype")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("loadType")%></td>		
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("monthVal")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("product")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("loadRef")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("existTrans")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("ColloectionStaffName")%>	</td>	
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("LiaisonOfficer")%>	</td>	
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("LiaisonContact")%>	</td>					
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("riskInvolved")%>	</td>					
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("validFrom"))) %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=  new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("validTo"))) %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("commission")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("remark")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("EntryBy")%></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=  new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rs.getString("entrydatetime"))) %></td>
																			
 
 <%
 String status="";
 try{
	 //status=rs.getString("Status") ;
	// if(status.equalsIgnoreCase("Deactivate"))
	 {
		 status="Deactive";
	 }
	 //else
	 {
		 status="Active";
	 }
 }catch(Exception e)
 {
	 status="test";
	 System.out.println("exception------>"+e);
 }
 
 
 %>

 </tr>
<% }conn.close();%>
</table></div></form>
</body>
</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>