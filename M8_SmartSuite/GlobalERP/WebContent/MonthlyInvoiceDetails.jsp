 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>GlobalERP</title>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String fromDate="",toDate="",toDate1 ="",mnth3="";
String Owner="",ERPCode="",CustCode="",BranchName="";
String Invoiceno="",InvoiceType="",InvDate="",Category="",TWSalesorderRefNo="";
String dt4="";
int i=1;
 // Connection Initialization
Connection conn = null;
Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
	st7 = conn.createStatement();
	st8 = conn.createStatement();
	st9 = conn.createStatement();
	st10 = conn.createStatement();
	st11 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Monthly Service Invoice Report</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post" onsubmit="return validate()">
		    <div class="row col-12">
		    <div class="col-md-3"></div>
				
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <%
        String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
        String[] monthValues = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};

        String requestMonth = request.getParameter("month");
    %>
    <option value="Select" <%= (requestMonth == null || requestMonth.isEmpty()) ? "selected" : "" %>>Select</option>
    <%
        for (int j = 0; j < months.length; j++) {
            String monthName = months[j];  
            String monthValue = monthValues[j];  
            boolean isSelected = monthValue.equals(requestMonth);  
    %>
    <option value="<%= monthValue %>" <%= isSelected ? "selected" : "" %>><%= monthName %></option>
    <%
        }
    %>
</select>

			
		                  <script>
                            const mySel = document.getElementById("month");

                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
		  		       </div>              
			</div>	
			<div class="col-md-2">
				  <label for="year"><b>Year</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="year" name="year">
    <%
        String selectedYear = request.getParameter("year");
    %>
    <option value="Select" <%= (selectedYear == null || selectedYear.isEmpty()) ? "selected" : "" %>>Select</option>
    <%
    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

        for (int year1 = 2016; year1 <= currentYear; year1++) {
            boolean isSelected = Integer.toString(year1).equals(selectedYear);
    %>
    <option value="<%= year1 %>" <%= isSelected ? "selected" : "" %>><%= year1 %></option>
    <%
        }
    %>
</select>
		                  <script>
                            const mySel = document.getElementById("year");

                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
		      		  </div>          
			</div>				
<div class="col-md-2">
    <label for="type"><b>Type</b></label>
    <div class="input-group input-group-merge">
        <select class="form-select" id="Type" name="Type" style="font-size:12px;">
            <%
                String selectedType = request.getParameter("Type");
            %>
            <option value="Select" <%= (selectedType == null || selectedType.isEmpty() || "Select".equals(selectedType)) ? "selected" : "" %>>Select</option>
            <option value="Autogenerated" <%= "Autogenerated".equals(selectedType) ? "selected" : "" %>>Autogenerated</option>
            <option value="Manual" <%= "Manual".equals(selectedType) ? "selected" : "" %>>Manual</option>
        </select>
    </div>              
</div>
	
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			
			<div class="col-md-1"></div>
			
		</div>
</form> 
<br> 

<%
String year1=request.getParameter("year");

 if(year1==null)
{
	year1="1999";
	
}
else 
{
	 year1=request.getParameter("year");
} 
String month1=request.getParameter("month");
 if(month1==null)
	
{
	month1="12";
	
}
else
{
	month1=request.getParameter("month");
} 
 
String InvType=request.getParameter("Type");
if(InvType==null)
	
{
	InvType="Manual";
	
}
else
{
	 InvType=request.getParameter("Type");
} 

if(year1 !=null && month1 !=null){
 fromDate = year1+"-"+month1+"-"+"01";
 toDate="";
 toDate1 ="select last_day ('"+fromDate+"') as monthname3";
System.out.println("monthname 1:- "+toDate1);
ResultSet rsmonthname3=st.executeQuery(toDate1);
rsmonthname3.next();
 mnth3=rsmonthname3.getString("monthname3");
toDate=mnth3;

  if(fromDate !=null && toDate !=null) {
	String fromDTime =fromDate+" 00:00:00";
	String toDTime =toDate+" 23:59:59";
}
  
}
%>
 <div class="container" style="width:80%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
					<tr>
						<th class="col-width-4">SrNo.</th>
                        <th>OwnerName</th>
                        <th>CustomerCode</th>
                        <th>BranchName</th>
                        <th><div style="width:100px;">Date</div></th>
                        <th>Invoice</th>
                        <th>Category</th>
                         <th>Sign</th>
					</tr>
				</thead> 
        <tbody>
      <%

	String Type=InvType;
	
	//String Ownername="select distinct(ERPTransporterCode) from db_gps.t_billingdetails where Month1='"+fromDate+"'  and ERPTransporterCode='4562' order by Transporter ";
	if(Type.equals("Autogenerated"))
	{
	String Ownername="select distinct(ERPTransporterCode) from db_gps.t_billingdetails where Month1='"+fromDate+"'  order by Transporter ";
		System.out.println("***********  Ownername query***************** "+Ownername);
	ResultSet rsOwenername=st1.executeQuery(Ownername);
	
	while(rsOwenername.next())
	{
		ERPCode=rsOwenername.getString("ERPTransporterCode");
		
		Owner="";InvoiceType="";InvDate="";Category="";Invoiceno="";TWSalesorderRefNo="";dt4="No Data";
		String Name="select distinct(CompanyName) as CompanyName,CustomerCode,ifnull(BranchName,'-') as BranchName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where customercode='"+ERPCode+"'";
		System.out.println("Name query"+Name);
		ResultSet rsName=st2.executeQuery(Name);
		
				if(rsName.next())
				{
					Owner=rsName.getString("CompanyName");
					CustCode=rsName.getString("CustomerCode");
					BranchName=rsName.getString("BranchName");
				}
								
		String InvoiceDetails="select distinct(invoiceRefNo),InvoiceDate,CompanyName,TWEmpName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet where  InvoiceDate>='"+fromDate+"' and InvoiceDate<='"+toDate+"' and InvoiceCancelled='0' and TWEmpName='Autogenerated' and CustomerCode='"+ERPCode+"'";
	System.out.println("***********  InvoiceDetails query***************** "+InvoiceDetails);
		ResultSet rsInvoiceDetails=st3.executeQuery(InvoiceDetails);
		if(rsInvoiceDetails.next())
		{
			Invoiceno=rsInvoiceDetails.getString("invoiceRefNo");
			InvDate=rsInvoiceDetails.getString("InvoiceDate");
			InvoiceType=rsInvoiceDetails.getString("TWEmpName");
			Category="Invoice";
			if(InvDate=="No Data" || InvDate.equals("No Data"))
			{
				
			}
			else
			{
			 dt4= new SimpleDateFormat("dd-MMM-yyyy")
	        .format(new SimpleDateFormat("yyyy-MM-dd")
	                .parse(InvDate));
			} 
			
			%>	
			<tr>
				<td class="text-center"><%=i%></td>
				<td class="text-left"><%=Owner%></td>
				<td class="text-center"><%=CustCode%></td>
				<td class="text-left"><%=BranchName%></td>
				<td class="text-right"><%=dt4%></td>
				<td class="text-left"><%=Invoiceno%></td>
				<td class="text-left"><%=Category%></td>
				<td class="text-left"><%=InvoiceType%></td>

			<%
			i++;
			
		}
		else
		{
			//Owner="";
			Invoiceno="";InvoiceType="";InvDate="";Category="";dt4="No Data";
			TWSalesorderRefNo="";
			
	    String InvoiceDetails1="select distinct(invoiceRefNo),InvoiceDate,CompanyName,TWEmpName,TWSalesorderRefNo,invoicegenerated from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where  InvoiceDate>='"+fromDate+"' and InvoiceDate<='"+toDate+"' and InvoiceCancelled='0'  and TWEmpName='Autogenerated' and CustomerCode='"+ERPCode+"'";
		System.out.println("***********  Proforma  InvoiceDetails ***************** "+InvoiceDetails1);
		ResultSet rsInvoiceDetails1=st4.executeQuery(InvoiceDetails1);
		if(rsInvoiceDetails1.next())
		{

			Invoiceno=rsInvoiceDetails1.getString("invoiceRefNo");
			InvDate=rsInvoiceDetails1.getString("InvoiceDate");
			InvoiceType=rsInvoiceDetails1.getString("TWEmpName");
			Category="ProForma";
			TWSalesorderRefNo=rsInvoiceDetails1.getString("TWSalesorderRefNo");
			String invoicegenerated=rsInvoiceDetails1.getString("invoicegenerated");

		}
		else{
			
			Invoiceno="No Data";
			InvDate="No Data";
			InvoiceType="No Data";
			Category="No Data";
		}
		
		if(InvDate=="No Data" || InvDate.equals("No Data"))
		{
			
		}
		else
		{
		 dt4= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(InvDate));
		} 
		%>	
		<tr>
			
			<td class="text-center"><%=i%></td>
			<td class="text-left"><%=Owner%></td>
			<td class="text-center"><%=CustCode%></td>
			<td class="text-left"><%=BranchName%></td>
			<td class="text-right"><%=dt4%></td>
			<td class="text-left"><%=Invoiceno%></td>
			<td class="text-left"><%=Category%></td>
			<td class="text-left"><%=InvoiceType%></td>

		<%
		i++;
		}

		}
	
	System.out.println("***********  Proforma  TO Main  ***************** ");
	
	//String ProToMain="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where TWSalesorderRefNo='"+TWSalesorderRefNo+"' and CustomerCode='"+ERPCode+"' and InvoiceCancelled='0' ";
	
	String ProToMain="select distinct(b.invoiceRefNo),b.InvoiceDate,a.CustomerCode,a.CompanyName,b.TWEmpName,a.TWSalesorderRefNo,a.invoicegenerated,b.InvoiceCancelled from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet a,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet b where a.TWSalesorderRefNo=b.TWSalesorderRefNo and a.invoicegenerated=1 and a.InvoiceCancelled='0' and a.TwEmpName='Autogenerated' and a.invoicedate >='"+fromDate+"' and a.invoicedate <='"+toDate+"' order by a.invoiceno";
	ResultSet rsProToMain=st5.executeQuery(ProToMain);
	
	System.out.println("***********  Proforma  To Main  Query  ***************** "+ProToMain);
	
	while(rsProToMain.next())
	{
		Invoiceno=rsProToMain.getString("b.invoiceRefNo");
		Owner=rsProToMain.getString("a.CompanyName");
		InvDate=rsProToMain.getString("b.InvoiceDate");
		InvoiceType=rsProToMain.getString("b.TWEmpName");
		Category="ProForma To Invoice";
		
		if(InvDate=="No Data" || InvDate.equals("No Data"))
		{
			
		}
		else
		{
		 dt4= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(InvDate));
		} 
		%>	
		<tr>
			
			<td class="text-center"><%=i%></td>
			<td class="text-left"><%=Owner%></td>
			<td class="text-center"><%=CustCode%></td>
			<td class="text-left"><%=BranchName%></td>
			<td class="text-right"><%=dt4%></td>
			<td class="text-left"><%=Invoiceno%></td>
			<td class="text-left"><%=Category%></td>
			<td class="text-left"><%=InvoiceType%></td>
		<%
		i++;
		}
	}

	//System.out.println("***********  Proforma  InvoiceDetails ***************** "+i++);
		
		if(Type.equals("Manual"))
		{
		String inv="";	
		
		/* String Ownername1="select distinct(ERPTransporterCode) from db_gps.t_billingdetails where Month1='"+fromDate+"'  order by Transporter ";
		
		ResultSet rsOwenername1=st1.executeQuery(Ownername1); */
		String Owner1="",ERPCode1="",CustCode1="",BranchName1="";
		String Invoiceno1="",Invoicenorefno="",InvoiceType1="",InvDate1="",Category1="",TWSalesorderRefNo1="";
		String dt41="";
		int i1=1;
		
		dt41="No Data";
		/* while(rsOwenername1.next())
		{ */
			
			//ERPCode1=rsOwenername1.getString("ERPTransporterCode");
		
					//System.out.println("***********  InvoiceDetails ***************** "+Owner);
			Owner1="";
				InvoiceType1="";
				InvDate1="";
				Invoicenorefno="";
				Category1="";
				Invoiceno1="";
				TWSalesorderRefNo1="";		
			String InvoiceDetails="select distinct(invoiceRefNo),InvoiceDate,invoiceno,CompanyName,TWEmpName,CustomerCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet where  InvoiceDate>='"+fromDate+"' and InvoiceDate<='"+toDate+"' and InvoiceCancelled='0' and TWEmpName!='Autogenerated' ";
		//	System.out.println("***********  InvoiceDetails ***************** "+InvoiceDetails);
			ResultSet rsInvoiceDetails1=st6.executeQuery(InvoiceDetails);
			while(rsInvoiceDetails1.next())
			{
				
				Owner1=rsInvoiceDetails1.getString("CompanyName");
				
				String BName="select ifnull(BranchName,'-') as BranchName,CustomerCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+Owner1+"' and CustomerCode='"+rsInvoiceDetails1.getString("CustomerCode")+"'";
				ResultSet rsName1=st7.executeQuery(BName);
						if(rsName1.next())
						{
							CustCode1=rsName1.getString("CustomerCode");

							BranchName1=rsName1.getString("BranchName");
						}
				Invoicenorefno=rsInvoiceDetails1.getString("invoiceRefNo");
				Invoiceno1=rsInvoiceDetails1.getString("invoiceno");
				
				String invitem="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where ItemDescription like 'Monthly%' and Invoiceno='"+Invoiceno1+"'";
				ResultSet Rsinvitem=st8.executeQuery(invitem);
				System.out.println("***********  InvoiceDetails ***************** "+invitem);
				if(Rsinvitem.next())
				{
					
					System.out.println("Inside Manual Monthly ");
					
					InvDate1=rsInvoiceDetails1.getString("InvoiceDate");
					InvoiceType1=rsInvoiceDetails1.getString("TWEmpName");
					Category1="Manual Invoice";
					if(InvDate1=="No Data" || InvDate1.equals("No Data"))
					{
						
					}
					else
					{
					 dt41= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(InvDate1));
					}
				}
				else
				{
					
				}

				%>	
				<tr>
					
					<td class="text-center"><%=i1%></td>
					<td class="text-left"><%=Owner1%></td>
					<td class="text-center"><%=CustCode1%></td>
			        <td class="text-left"><%=BranchName1%></td>
					<td class="text-right"><%=dt41%></td>
					<td class="text-left"><%=Invoicenorefno%></td>
					<td class="text-left"><%=Category1%></td>
					<td class="text-left"><%=InvoiceType1%></td>
				<%
				i1++;
			}

			Owner1="";
			InvoiceType1="";
			InvDate1="";
			Invoicenorefno="";
			Category1="";
			Invoiceno1="";
			TWSalesorderRefNo1="";
			
			String ProToMain="select distinct(b.invoiceRefNo),b.InvoiceDate,a.CustomerCode,b.CustomerCode,b.invoiceno,b.CompanyName,b.TWEmpName,a.TWSalesorderRefNo,a.invoicegenerated,b.InvoiceCancelled from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet a,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet b where a.TWSalesorderRefNo=b.TWSalesorderRefNo and a.invoicegenerated=1 and a.InvoiceCancelled='0' and a.TwEmpName!='Autogenerated' and a.invoicedate >='"+fromDate+"' and a.invoicedate <='"+toDate+"' order by a.invoiceno";
			ResultSet rsProToMain=st9.executeQuery(ProToMain);
			
			System.out.println("***********  Proforma  To Main  Query  ***************** "+ProToMain);
			
			while(rsProToMain.next())
			{
				
				
				
				Owner1=rsProToMain.getString("b.CompanyName");
				Invoicenorefno=rsProToMain.getString("b.invoiceRefNo");
				Invoiceno1=rsProToMain.getString("b.invoiceno");
				
				String BName="select ifnull(BranchName,'-') as BranchName,CustomerCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+Owner1+"' and CustomerCode='"+rsProToMain.getString("b.CustomerCode")+"'";
				ResultSet rsName2=st10.executeQuery(BName);
						if(rsName2.next())
						{
							CustCode1=rsName2.getString("CustomerCode");

							BranchName1=rsName2.getString("BranchName");
						}
						
				String invitem="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where ItemDescription like 'Monthly%' and Invoiceno='"+Invoiceno1+"'";
				ResultSet Rsinvitem=st11.executeQuery(invitem);
				System.out.println("***********  InvoiceDetails ***************** "+invitem);
				if(Rsinvitem.next())
				{
					
					System.out.println("Inside Manual Monthly ");
					
					InvDate1=rsProToMain.getString("InvoiceDate");
					InvoiceType1=rsProToMain.getString("TWEmpName");
					Category1="ProForma To Invoice";
					if(InvDate1=="No Data" || InvDate1.equals("No Data"))
					{
						
					}
					else
					{
					 dt41= new SimpleDateFormat("dd-MMM-yyyy")
			        .format(new SimpleDateFormat("yyyy-MM-dd")
			                .parse(InvDate1));
					}
				}
				else
				{
					
				}
				 
				%>	
				<tr>
					
					<td class="text-center"><%=i1%></td>
					<td class="text-left"><%=Owner1%></td>
					<td class="text-right"><%=CustCode1%></td>
			        <td class="text-left"><%=BranchName1%></td>
					<td class="text-right"><%=dt41%></td>
					<td class="text-left"><%=Invoicenorefno%></td>
					<td class="text-left"><%=Category1%></td>
					<td class="text-left"><%=InvoiceType1%></td>

				<%
				i1++;
				}
			
		}

%>
</tr>
</tbody>
 </table>
 </div>
 </div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script>
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
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
		                        title: 'Monthly Service Invoice Report For '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Monthly Service Invoice Report For '+$("#month").val()+'-'+$("#year").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
 	                        title: 'Monthly Service Invoice Report For '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
 	                        title: 'Monthly Service Invoice Report For '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Monthly Service Invoice Report For '+$("#month").val()+'-'+$("#year").val(), 
							},
 
					],
				},
				
           ], 
       
       });

   });
   
</script>
<script>
function validate() {
	 
	    var current_date = new Date();
	    var current_year = current_date.getFullYear();
	    var current_month = current_date.getMonth() + 1; // getMonth() is zero-based, so add 1

	    var monthNames = [
	        "January", "February", "March", "April", "May", "June", 
	        "July", "August", "September", "October", "November", "December"
	    ];
	    var current_month_name = monthNames[current_month - 1]; 
	
	
		var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
		if(month=="Select")
			{
			alert("Please select Month");
			return false;
			}
		
		var year=document.getElementById("year").options[document.getElementById("year").selectedIndex].value;
		if(year=="Select")
		{
		alert("Please select Year");
		return false;
		}
		
		 if (year == current_year && month >= current_month) {
		        alert("Please Select a Month Before " + current_month_name);
		        return false;
		    }
				
		var Type = document.getElementById("Type").options[document.getElementById("Type").selectedIndex].value;
		if(Type=="Select") {
				
			alert("Please Select Type!");
			return false;
		}	
		return true;
		
	}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>