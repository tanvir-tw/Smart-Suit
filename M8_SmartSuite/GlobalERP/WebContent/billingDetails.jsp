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
</head>
  <body style="background-color:azure;">
 
 <%
// Connection Initialization
Connection conn = null;
Statement st = null;
String companyName="",customerType=" ",companyCode=" ";
String id="", Customer1=" ",ERPCode1=" ",category1=" ",CustomerType1=" ",Rate1=" ",Frequency1=" ", BillType1=" ",ToId1=" ",ToCc1=" ",BillStatus1=" ",OperationalStatus1=" ",data="";
try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
	st = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%> 
<%
try{
	if (null == request.getParameter("companyName"))
		companyName = "";
		else
			companyName = request.getParameter("companyName").replace("~","&");
			customerType = request.getParameter("type");
			companyCode =  request.getParameter("companyCode");
			String name=request.getParameter("companyNames");

	int i=1;
	if(name=="" || name==" " || name==null)
	{
		name="All";
	}
	
	name=name.replace("...","&");
	
%>


	<div class="container-fluid mt-2" id="main">
	<div class="content-header-col-md-7-mt-10 col-12">
	    <div class="row breadcrumbs-top">
	                <h5 class="content-header-title text-center mb-0" style="color: #060637"><a>Billing Profile Summary -<%=companyName%></a></h5>
	    </div>
	</div>
	<br>
	<table id="example"  class="display" style="width:100%">
			<thead>

				<tr>
					<th class="col-width-4">Sr.No</th>
					<th>Customer</th>
					<th>ERPCode</th>
					<th>Category</th>
					<th>CustomerType</th>
					<th>Rate</th>
					<th>Frequency</th>
					<th>BillType</th>
					<th>ToId</th>
					<th>ToCc</th>
					<th>BillStatus</th>
					<th>OperationalStatus</th>
					<th>Edit</th>
				</tr>

			</thead>
			<tbody>
      
	<%
	   data = "select TypeValue as Customer,ERPCode,category,CustomerType,ERPTransporterRate as Rate ,BillFrequency as Frequency,BillType,ToId,ToCc,BillStatus,OperationalStatus from db_gps.t_transporter  where ERPCode="+companyCode+"";
	System.out.println("check-------->"+data);
	st=conn.createStatement();
	ResultSet rs1=st.executeQuery(data);
	if(rs1.next())
	{
	try{
		
		Customer1=rs1.getString("Customer");
		ERPCode1=rs1.getString("ERPCode");
		category1=rs1.getString("category");
		CustomerType1=rs1.getString("CustomerType");
		Rate1=rs1.getString("Rate");
		Frequency1=rs1.getString("Frequency");
		BillType1=rs1.getString("BillType");
		ToId1=rs1.getString("ToId");
		ToCc1=rs1.getString("ToCc");
		BillStatus1=rs1.getString("BillStatus");
		OperationalStatus1=rs1.getString("OperationalStatus");
			%>
	
            <tr>
    <td class="text-center"><%=i%></td>
    <td class="text-left"><%=Customer1%></td>
    <td class="text-center"><%=ERPCode1%></td>
    <td class="text-left"><%=category1%></td>
    <td class="text-left"><%=CustomerType1%></td>
    <td class="text-center"><%=Rate1%></td>
    <td class="text-left"><%=Frequency1%></td>
    <td class="text-left"><%=BillType1%></td>
    <td class="text-left"><%=ToId1%></td>
    <td class="text-left"><%=ToCc1%></td>
    <td class="text-left"><%=BillStatus1%></td>
    <td class="text-left"><%=OperationalStatus1%></td>
    <td class="text-left">
        <a href="EditbillingDetails.jsp?companyCode=<%=companyCode%>" target="_blank"><%="Edit Details"%></a>
    </td>
</tr>
            
   <%
i++;

	
%>  
    
   <%
	}catch (Exception e) {
	e.printStackTrace();
} 
	}
	else
	{
		out.println("<script>  Redirect();</script>");
	}
		
%>      
        </tbody>
      
    </table>
   
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
	        //keys: true,  //Keytable
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
								title: 'Billing Details from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Billing Details from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Billing Details from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Billing Details from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Billing Details from '+$("#data").val()+ 'to' +$("#data1").val(),
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
	//document.getElementById("companyList").style.display='block';
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
 {//alert("ssss"+status+"  "+name+""); 
    
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
/* 	document.getElementById("comlist").style.display="none"; */
	
	
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
		/* alert(document.getElementById("oct1").value); */
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
				//document.getElementById("cctype").value=cctype;
				//alert(document.getElementById("cctype").value);
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
				//alert(reslt);
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
	
	/* alert("Company"+companyNme); */
	var fromdt=document.getElementById("from").value;
	var todt=document.getElementById("to").value;
	var dt=document.getElementById("fromdate").value;
	var dt1=document.getElementById("todate").value;
	/* alert("To Date"+todt); */
	var queryString ="&fromdate="+fromdt+"&todate="+todt+"&CompId="+compId;
	/* alert("Query String Is"+queryString); */
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

function Redirect()
{
	alert("CustomerCode Not Matches With Diary System ERP Code  ");
    window.location="home.jsp";
	
}
</script>
 <%@ include file="footer.jsp" %>
</body>
</html>