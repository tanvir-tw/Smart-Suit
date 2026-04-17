 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
    <style>
/* visited link */
a:visited {
	color: #660066;
}
</style>       

<style type="text/css">
td.details-control {
    background: url('images/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('images/details_close.png') no-repeat center center;
}
</style>   
</head>
<body onload=" return loading();" onkeydown="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >	                	                                                                                                              
<%
//Variable Declaration
String sql="", data = "",id="";
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
String Customer1 = " ",ERPCode1 = " " ,category1 = " " ,CustomerType1 = " " ,Frequency1 = " " ,BillType1 = " " ,ToId1 = " " ,ToCc1 = " " ,BillStatus1 = " " ,OperationalStatus1 = " " ,fromdate1 = " " ,todate1 = " " ,billday1 = " " ,document1 = " ";
double Rate1 = 0.00, SLARate = 0.00 ;
String companyName="",customerType=" ",companyCode=" ";
// Connection Initialization
Connection conn = null;
Statement st1=null , st2 = null;;
ResultSet rs1=null, rs2=null;

String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 


try {
	conn = connection.getConnect("db_GlobalERP");    
		st1 = conn.createStatement();
	    st2 = conn.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 
%>
<% 
	if (null == request.getParameter("companyName"))
		companyName = "";
		else
			companyName = request.getParameter("companyName").replace("~","&");
			customerType = request.getParameter("type");
			companyCode =  request.getParameter("companyCode");

			System.out.println("Company Name =======>"+companyName);
			System.out.println("customerType  =======>"+customerType);
			System.out.println("companyCode  =======>"+ companyCode);
	%>
	<% 
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;

	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
try {

	String name=request.getParameter("companyNames");
	
	int i=1;
	if(name=="" || name==" " || name==null)
	{
		name="All";
	}
	
	name=name.replace("...","&");	
  	   String data11 = "select CustomerName,CustomerCode,ContarctFromDate,ContarctToDate,Document from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster  where CustomerCode="+companyCode+"";

%>
 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637"><a>Customer contract Summary - <%=companyName%></a></h5>
    </div>
</div>
<br>
<input type="hidden" id="custname" name="custname"  value="<%=companyName%>" readonly/>


<input type="hidden" id="compId" value=<%=session.getAttribute("CompanyMasterID").toString()%>>
<input type="hidden" id="from" value=<%=dt%>>
<input type="hidden" id="to" value=<%=dt1%>>
<div id='tempList' align="center" style="display: none;">						
</div>
<div id="reportData">	
<%
String compName="";

if(null!=request.getParameter("companyNames")&&""!=request.getParameter("companyNames"))
{
	compName=request.getParameter("companyNames");
	//compName=compName.replace("&","...");
	compName=compName.replace("...","&");

	compName=compName.replace("&","%26");
	
%>
<%}else{
	
	if(compName=="" || compName==" ")
	{
		compName="All";
	}
	System.out.println("*******************************************");
%>
<%}%>
</div>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a href="ContractNew.jsp?companyCode=<%=companyCode%>&custname=<%=companyName%>" style="color:blue;" class="text-decoration-none">Add Contract</a>
	    </div>
		<div class="col-8"></div>
	</div>
<div class="form">

<table id="example"  class="display" style="width:100%">
				<thead >
					<tr>
						<th class="col-width-4">Sr.No</th>
						<th >Customer</th>
						<th >CompanyCode</th>
						<th >Category</th>
						<th >CustomerType</th>
						<th >FromDate</th>
						<th >ToDate</th>
						<th >BillDay</th>
						<th >Document</th>
						<th >Rate</th>
						<th >SLA%</th>
						<th >Frequency</th>
						<th >BillType</th>
						<th >ToId</th>
						<th >ToCc</th>
						<th >BillStatus</th>
						<th >OperationalStatus</th>
						<th >Edit</th>
					</tr>

				</thead>
				<tbody>
      
	<%
    	if (datex1 == null) {
      		data = "select CustomerName,CustomerCode,ContarctFromDate,ContarctToDate,Document from db_GlobalERP."
      		+ session.getAttribute("CompanyMasterID").toString() + "CustomerContractMaster  where CustomerCode="
      		+ companyCode + "";

      		sql = "select BillDay,ToId,ToCc,category,Rate,SLARate,OperationalStatus,BillFrequency,BillStatus,BillType,CustomerType from db_GlobalERP."
      		+ session.getAttribute("CompanyMasterID").toString() + "CustomerBillMaster  where CustomerCode="
      		+ companyCode + "";
      		System.out.println("if check-------->" + data);
      	} else {
      		data = "select CustomerName,CustomerCode,ContarctFromDate,ContarctToDate,Document from db_GlobalERP."
      		+ session.getAttribute("CompanyMasterID").toString() + "CustomerContractMaster  where CustomerCode="
      		+ companyCode + "";

      		sql = "select BillDay,ToId,ToCc,category,Rate,SLARate,OperationalStatus,BillDay,BillFrequency,BillStatus,BillType,CustomerType from db_GlobalERP."
      		+ session.getAttribute("CompanyMasterID").toString() + "CustomerBillMaster  where CustomerCode="
      		+ companyCode + "";
      		System.out.println("else check-------->" + data);
      	}



      	
      rs1 = st1.executeQuery(data);
      	if (rs1.next()) {
      		try {

      			Customer1 = rs1.getString("CustomerName");
      			ERPCode1 = rs1.getString("CustomerCode");

      			fromdate1 = rs1.getString("ContarctFromDate");
      			todate1 = rs1.getString("ContarctToDate");
      			document1 = rs1.getString("Document");

      			if (document1.length() > 0) {
      		document1 = document1.substring(1);
      			} else {
      		document1 = "-";
      			}

      			System.out.println("sql-------->" + sql);
      		    rs2 = st2.executeQuery(sql);
      			if (rs2.next()) {

      		category1 = rs2.getString("category");
      		CustomerType1 = rs2.getString("CustomerType");
      		Rate1 = rs2.getDouble("Rate");
      		SLARate = rs2.getDouble("SLARate");
      		if (String.valueOf(SLARate) == null) {
      			SLARate = 0.00;
      		}
      		Frequency1 = rs2.getString("BillFrequency");
      		BillType1 = rs2.getString("BillType");
      		ToId1 = rs2.getString("ToId");
      		ToCc1 = rs2.getString("ToCc");
      		BillStatus1 = rs2.getString("BillStatus");
      		OperationalStatus1 = rs2.getString("OperationalStatus");

      		billday1 = rs2.getString("BillDay");
      	%>
      	<%
			
			String d1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1));
			
			
			String d2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate1));
			
			
			%>

					<tr>
						<td class="text-center" ><%=i%></td>
						<td class="text-left"><%=Customer1%></td>
						<td class="text-left"><%=ERPCode1%></td>
						<td class="text-left"><%=category1%></td>
						<td class="text-left"><%=CustomerType1%></td>
						<td class="text-right"><%=d1%></td>
						<td class="text-right"><%=d2%></td>
						<td class="text-left"><%=billday1%></td>
						
						<td class="text-left">
    <div style="width:250px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=document1%>
    </div>
</td>
						<td class="text-center"><%=Rate1%></td>
						<td class=text-left><%=SLARate%></td>
						<td class="text-left"><%=Frequency1%></td>
						<td class="text-left"><%=BillType1%></td>
						<td class="text-right"><%=ToId1%></td>
						<td class="text-right"><%=ToCc1%></td>
						<td class="text-left"><%=BillStatus1%></td>
						<td class="text-left"><%=OperationalStatus1%></td>
						<td ><a
							href="EditContractDetail.jsp?companyCode=<%=companyCode%>&custname=<%=Customer1%>"><%="Edit Details"%></a></td>
					</tr>
					<%
i++;	
%>  
    
   <%
		}}catch (Exception e) {
	e.printStackTrace();
} 
	}
	
	else
	{	
		%>
		<%
	}	
%>      
        </tbody>     
    </table> 
 </div>
    
</div>

<%
	}catch (Exception e) {
	e.printStackTrace();
}
%>
 
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
	        keys: true,  //Keytable
	        stateSave: true,
        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
								title: 'Customer contract Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Customer contract Report from  '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Customer contract Report from  '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Customer contract Report from  '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Customer contract Report from  '+$("#data").val()+ 'to' +$("#data1").val(),
							},
					],
				},
           ], 
       });
   });
</script>
<script type="text/javascript">
function showVisitingCardDetails(companyName,customerCode){
	alert(companyName);
	document.getElementById("companyNames").value=companyName;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	/* document.data.companyNames.value=''; */
	document.getElementById("companyNames").value='';
}

function getCompanies(type)
{
	var company=document.getElementById("companyNames").value;
	company=company.replace("...","&");
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
			
			document.getElementById("companyList").innerHTML=reslt;
		} 
	}
	var queryString = "?company=" +company+"&type="+type+"&limitcount=20";
	ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
	ajaxRequest.send(null); 	
}
function openInvoice(Address,InvoiceRefNo,Invoiceno,condition,status,name)
 {
	//alert("ssss"+status+"  "+name+"");     
	if(status=="Closed")
	{alert("This Invoice is closed by "+name);	
	}	
	window.open(Address+'?InvoiceRefNo='+InvoiceRefNo+'&Invoiceno='+Invoiceno+'&condition='+condition+" ");	
}

function getCustomerInfo(type, code) 
{
	
	if(type == "" || type==null)
	{
		alert("Error  ");
	}
	else
	{
	document.getElementById("companyList").style.visibility="hidden";
	var ajaxRequest;  
	// The variable that makes Ajax possible!
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

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			
			var reslt = ajaxRequest.responseText;

			reslt=reslt.replace(/^\s+|\s+$/g,""," ");
			
			if(reslt == "NO")
			{
				    alert(" Data Not Available");
				    document.getElementById("CompanyCount").innerHTML = "";
				    document.addFolloUp.companyNames.value="";
				    document.addFolloUp.companyNames.value=""; 
					document.addFolloUp.companyCode.value="";
					document.addFolloUp.companyEnteredBy.value="";
					document.addFolloUp.companyCity.value="";
					document.addFolloUp.oct.value="--";
					document.addFolloUp.companyPhoneNumber.value="";
					document.addFolloUp.companyProduct.value="";
					document.addFolloUp.companyContactPerson.value="";
					document.addFolloUp.companyEmail.value="";
					document.addFolloUp.companyfax.value="";
					document.addFolloUp.companyWebSite.value="";
					document.addFolloUp.companyProduct.value=""; 
					document.addFolloUp.customerWeeklyOff.value="";
					document.addFolloUp.custType.value="";
					document.addFolloUp.assignedBy.value="";
					document.addFolloUp.leadRef.value="";
					document.addFolloUp.addedOnDate.value="";
			}else
			{
				
			document.getElementById("tempList").innerHTML = reslt;
			getCustomerDetails();
			
			}
			
			
		}
		
	}
	var queryString = "?code=" +code+"&type="+type;
	ajaxRequest.open("GET", "AjaxGetCustomerInfo.jsp" + queryString, true);
	 
	ajaxRequest.send(null);
	}//end of else
}


function getCustomerDetails() 
{
	
	try{
		document.getElementById("companyNames").innerHTML=document.getElementById("Name").value;
		document.getElementById("companyNames").value =document.getElementById("Name").value; 
		document.addFolloUp.companyCode.value=document.getElementById("Code").value;
		document.addFolloUp.companyEnteredBy.value=document.getElementById("RepName").value;
		document.addFolloUp.companyCity.value=document.getElementById("City").value;
		document.addFolloUp.oct.value=document.getElementById("oct1").value;	
		document.addFolloUp.companyPhoneNumber.value=document.getElementById("MobileNo").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value;
		document.addFolloUp.companyContactPerson.value=document.getElementById("ContactPerson").value;
		document.addFolloUp.companyEmail.value=document.getElementById("Email").value;
		document.addFolloUp.companyfax.value=document.getElementById("Fax").value;
		document.addFolloUp.companyWebSite.value=document.getElementById("WebSite").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value; 
		document.addFolloUp.customerWeeklyOff.value=document.getElementById("WeeklyOff").value;
		document.addFolloUp.custType.value=document.getElementById("custtype").value;		
		document.addFolloUp.assignedBy.value=document.getElementById("assignby").value;
		document.addFolloUp.leadRef.value=document.getElementById("leadref").value;
		document.addFolloUp.addedOnDate.value=document.getElementById("addedondate").value;
		
		
	}catch(e)
	{
		//alert(e);
	}
		
	    var cctype=document.addFolloUp.custType.value;
		var company=document.addFolloUp.companyCode.value;
		var companyName=document.addFolloUp.companyNames.value;
		companyName=companyName("...","&");
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				
				var reslt=ajaxRequest.responseText;
				var mySplitResult = reslt.split("#");
				var tr=mySplitResult[0];
				var fl=mySplitResult[1];
				
				document.getElementById("tr").innerHTML=tr;
				document.getElementById("fl").innerHTML=fl;
				document.getElementById("CompanyCount").innerHTML = mySplitResult[3];
				} 
		}
			
		var queryString = "?company="+company+"&companyName="+companyName+"&cctype="+cctype;
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 

	}
function getfollowup()
{
	/* alert("hiiiiiiiiii"); */
	var a=chk();
	if(a==true)
	{	
	var compId=document.getElementById("compId").value;
	var companyNme=document.getElementById("companyNames").value;
	companyNme=companyNme.replace("...","&");
	
	if(companyNme==" " || companyNme==null || companyNme=="")
		{
		companyNme="All";
		}
	var fromdt=document.getElementById("from").value;
	var todt=document.getElementById("to").value;
	var dt=document.getElementById("fromdate").value;
	var dt1=document.getElementById("todate").value;
	var queryString ="&fromdate="+fromdt+"&todate="+todt+"&CompId="+compId;
	if(companyNme=="" || companyNme==" " ) 
	{
		companyNme="All";

	}else
	{
		/* document.getElementById("myframe").src="http://twtech.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString+"&companyname="+companyNme+"&dt="+dt+"&dt1="+dt1+"&__showtitle=false";	
 */	}
	document.getElementById("footer").style.display="none";
return true;	
	}
else
	{
		return false;
	}
}

</script>
<script type="text/javascript">

function Redirect()
{
	alert("CustomerCode Not Matches With Diary System ERP Code  ");
    window.location="home.jsp";	
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>