 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@ page import="java.util.Date" %>
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
// Variable Declaration
String todaysDate = session.getAttribute("today").toString(); 
String id=request.getParameter("id");
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="",fromDate="";
String sqldata="",invoiceno="",InvoiceNo1="",RevOfinvoiceRefNo1="",RevOfinvoiceRefNo2="",InvoiceDate1="",GrandTotal1="",CurrType1="",InvoiceCancelled1="",CompanyName1="",TWEmpName1="",ClosedBy1="",ReasonForCancelling1="",PODate1="";
String status="",fdate="",tdate="",ddate="",dt4="",dt6="",sqlGroup="";
int i=1;

 // Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null,st3=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
fromDate=new SimpleDateFormat("dd-MMM-yyyy").format(today30);

	if (bt== null || bt.equals("null")) {		
		datex1 = fromDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
	<% if(id.equals("proformaclose")){%>
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Proforma Close Invoice</h5>
     <%}else if(id.equals("proformarevise")){%>
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Proforma Revise Invoice</h5>
     <%}else{ %>
           <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=id%> Invoice</h5>
     <%} %>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-2"></div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
                <th class="col-width-4">SrNo.</th>
				<th>InvoiceRefNo</th>
				<% if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise") || id.equalsIgnoreCase("proformarevise"))
	                 {%>
				<th>Revised</th>
						<%} %>
				<% if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
	                   {%>
				<th>InvoiceDate</th>
					<%}  else if(id.equalsIgnoreCase("proformaclose") || id.equalsIgnoreCase("proformarevise")){ %>
				 <th>InvoiceDate</th>
						<%} %>
				<th>Amount</th>
				<th>Item Description</th>
		        <th>FromDate</th>
				<th>ToDate</th>
				<th>DueDate</th>
				<th>Group</th>
				<th>Status</th>
				<th>Customer</th>
				<th>Sign</th>
				    <% if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
                       	 {%>
				<th>ClosedBY</th>
				<th>ClosureReason</th>
						<%} %>
            </tr>
        </thead> 
        <tbody>
        <%
        if(id.equalsIgnoreCase("close"))
    	{
          	   sqldata = "select invoiceRefNo,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,invoiceno,TheGroup,RevOfinvoiceRefNo,InvoiceDate,GrandTotal,CurrType,InvoiceCancelled,CompanyName,TWEmpName,ClosedBy,ReasonForCancelling from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where InvoiceDate>='"+dttime+"' and InvoiceDate<='"+dt1time+"' order by InvoiceDate desc";       	  	
    	}
    	else if(id.equalsIgnoreCase("revise") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") )
    	{
    		sqldata = "select invoiceRefNo,PONo,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,invoiceno,TheGroup,RevOfinvoiceRefNo,InvoiceDate,GrandTotal,CurrType,InvoiceCancelled,CompanyName,TWEmpName,ClosedBy,ReasonForCancelling from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet where InvoiceDate>='"+dttime+"' and InvoiceDate<='"+dt1time+"' order by InvoiceDate desc";

    	}
    	else if(id.equalsIgnoreCase("proformaclose") || id.equalsIgnoreCase("proformarevise"))
    	{
    		sqldata = "select distinct(invoiceRefNo),CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,RevofInvoiceNo ,RevOfinvoiceRefNo,InvoiceDate,invoiceno,PODate,GrandTotal,CurrType,InvoiceCancelled,TheGroup,CompanyName,TWEmpName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  where InvoiceDate>='"+dttime+"' and InvoiceDate<='"+dt1time+"' order by InvoiceDate desc,  invoiceRefNo desc";

    		}
        System.out.println(sqldata);			
    	ResultSet rsdata=st1.executeQuery(sqldata);
   
    	while(rsdata.next()){ 

    			InvoiceCancelled1=rsdata.getString("InvoiceCancelled");
    			if(rsdata.getInt("InvoiceCancelled")==0)
    			{status="Invoiced";
    		    }
    			else
    			{	status="Closed";
    			}
    			
    			String ItemDescription2="";
    			 
    	if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
    	{
    	    invoiceno=rsdata.getString("invoiceno");
    	    InvoiceNo1=rsdata.getString("invoiceRefNo");
    		RevOfinvoiceRefNo1=(rsdata.getString("RevOfinvoiceRefNo") + ".");

    		 if(RevOfinvoiceRefNo1.toString()=="" || RevOfinvoiceRefNo1.toString()==" " ||  RevOfinvoiceRefNo1=="." || RevOfinvoiceRefNo1.toString().equalsIgnoreCase("0.") || RevOfinvoiceRefNo1.toString().equalsIgnoreCase("0.") || RevOfinvoiceRefNo1=="" || RevOfinvoiceRefNo1.toString().equalsIgnoreCase("null.") || RevOfinvoiceRefNo1.toString().equalsIgnoreCase(null) || rsdata.getString("RevOfinvoiceRefNo").equalsIgnoreCase(null) || rsdata.getString("RevOfinvoiceRefNo").equalsIgnoreCase("null") || rsdata.getString("RevOfinvoiceRefNo")=="" || rsdata.getString("RevOfinvoiceRefNo")==""|| rsdata.getString("RevOfinvoiceRefNo").equalsIgnoreCase(" ") || rsdata.getString("RevOfinvoiceRefNo")=="null." || rsdata.getString("RevOfinvoiceRefNo")==null  )
    		{
    			RevOfinvoiceRefNo1="-";
    	    }  
    		  else
    		 {
    			 RevOfinvoiceRefNo1=RevOfinvoiceRefNo1.substring(0,11);
    		 }  
    			 
    		fdate=rsdata.getString("FromDate");
    		if(fdate==null || fdate=="null" || fdate.equals("null") || fdate.equals("0000-00-00") || fdate.equals("-"))
    		{
    			fdate="-";
    		}else{
    		fdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fdate)); 
    		}

    		tdate=rsdata.getString("ToDate");
    		if(tdate==null || tdate=="null" || tdate.equals("null") || tdate.equals("0000-00-00") || tdate.equals("-"))
    		{
    			tdate="-";

    		}else{
    		tdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(tdate)); 
    		}
    		
    		ddate=rsdata.getString("DueDate");
    		if(ddate==null || ddate=="null" || ddate.equals("null") || ddate.equals("-"))
    		{
    			ddate="-";
    		}else{
    		ddate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ddate)); 
    		}

    		InvoiceDate1=rsdata.getString("InvoiceDate");
    		GrandTotal1=rsdata.getString("GrandTotal");
    		CurrType1=rsdata.getString("CurrType");
    		CompanyName1=rsdata.getString("CompanyName");
    		TWEmpName1=rsdata.getString("TWEmpName");
    		ClosedBy1=rsdata.getString("ClosedBy");
    		ReasonForCancelling1=(rsdata.getString("ReasonForCancelling") + ".");
    		if(ReasonForCancelling1.equalsIgnoreCase("-.")|| ReasonForCancelling1.toString()==" " ||  ReasonForCancelling1=="." || ReasonForCancelling1.toString().equalsIgnoreCase("0.") || ReasonForCancelling1.toString().equalsIgnoreCase("0.") || ReasonForCancelling1=="" || ReasonForCancelling1.toString().equalsIgnoreCase("null.") || ReasonForCancelling1.toString().equalsIgnoreCase(null) || ReasonForCancelling1.equalsIgnoreCase(null) || ReasonForCancelling1.equalsIgnoreCase("null") || ReasonForCancelling1=="" || ReasonForCancelling1==""|| ReasonForCancelling1.equalsIgnoreCase(" ") || ReasonForCancelling1=="null." || ReasonForCancelling1==null  )
    		{

    			ReasonForCancelling1="-";
    	    }  
    		  else
    		 {
    			 ReasonForCancelling1=ReasonForCancelling1;
    		 }   
    			
    		dt4 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(InvoiceDate1)); 
    	 }
    			 else if (id.equalsIgnoreCase("proformaclose") || id.equalsIgnoreCase("proformarevise"))
    				{
    				 RevOfinvoiceRefNo2=rsdata.getString("RevOfinvoiceRefNo");

    				    invoiceno=rsdata.getString("invoiceno");
    				    InvoiceNo1=rsdata.getString("invoiceRefNo");
    					InvoiceDate1=rsdata.getString("InvoiceDate");
    					PODate1=rsdata.getString("PODate");
    					GrandTotal1=rsdata.getString("GrandTotal");
    					CurrType1=rsdata.getString("CurrType");
    					CompanyName1=rsdata.getString("CompanyName");
    					TWEmpName1=rsdata.getString("TWEmpName");
    					
    					fdate=rsdata.getString("FromDate");
    					if(fdate==null || fdate=="null" || fdate.equals("null") || fdate.equals("0000-00-00") || fdate.equals("-"))
    					{
    						fdate="-";
    					}else{
    					fdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fdate)); 
    					}

    					tdate=rsdata.getString("ToDate");
    					if(tdate==null || tdate=="null" || tdate.equals("null") || tdate.equals("0000-00-00") || tdate.equals("-"))
    					{
    						tdate="-";
    					}else{
    					tdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(tdate)); 
    					}
    					
    					ddate=rsdata.getString("DueDate");
    					if(ddate==null || ddate=="null" || ddate.equals("null") || ddate.equals("-"))
    					{
    						ddate="-";
    					}else{
    					ddate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ddate)); 
    					}
    					
    					dt4 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(InvoiceDate1)); 
    				    dt6 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(PODate1)); 
    				}
    				    		
    		if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
    		{
    			 
    	 String sql1="";
    	 sql1="select  ItemDescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where invoiceno='"+rsdata.getString("invoiceno")+"'";
    		ResultSet rs22=st2.executeQuery(sql1);
  
    		int cnt=0;
    		while(rs22.next())
    		{
    			cnt++;
    			
    			ItemDescription2=ItemDescription2+","+rs22.getString("ItemDescription");

    		}
    		
    		if(ItemDescription2==" "||ItemDescription2=="")
    		{
    		ItemDescription2=ItemDescription2;
    		}
    		
    		else
    		{
    			ItemDescription2=ItemDescription2.substring(1);
    		}
    			
    		}
    		else if(id.equalsIgnoreCase("proformaclose") || id.equalsIgnoreCase("proformarevise"))
    		{
    			 String sql1="";
    			 sql1="select  ItemDescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items where invoiceno='"+rsdata.getString("invoiceno")+"'";
    			 ResultSet rs22=st2.executeQuery(sql1);

    				int cnt=0;
    				while(rs22.next())
    				{
    					cnt++;
    					ItemDescription2=ItemDescription2+","+rs22.getString("ItemDescription");
    					
    				}
    				
    				if(ItemDescription2==" "||ItemDescription2=="")
    				{
    				ItemDescription2=ItemDescription2;
    				}
    				else
    				{
    					
    				ItemDescription2=ItemDescription2.substring(1);
    				
    				}
    		}
    		
    		String TheGroupName1=" ";
    		 sqlGroup="SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode='"+rsdata.getString("TheGroup")+"' ";
    		 ResultSet rsGroup=st3.executeQuery(sqlGroup);
    		// System.out.println(sqlGroup);
    	while(rsGroup.next())
    	{
    		TheGroupName1=rsGroup.getString("TheGroupName");
    	}
    	%>
           <tr> 
           		<td class="text-center"><%=i%></td>
						<% if((id.equalsIgnoreCase("close") && status!="Closed")){ %>
                <td class="text-left"><a href="viewInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=close"
							target="_blank"><%=InvoiceNo1%></a></td>
				        <%} 
	                    else if((id.equalsIgnoreCase("revise"))&& status!="Closed"){%>
				<td class="text-left"><a href="invoicedet.jsp?salesOrderNumber=<%=rsdata.getString("PONo")%>&Invoiceno=<%=invoiceno%>&condition=revise"
							target="_blank"><%=InvoiceNo1%></a></td>
                          <%} 
	                    else if((id.equalsIgnoreCase("close") ||  id.equalsIgnoreCase("revise"))&& status=="Closed"){%>
				<td class="text-left"><%=InvoiceNo1%></td>
						  <%}  
	                     else if ((id.equalsIgnoreCase("View") ||  id.equalsIgnoreCase("null"))){ %>
				<td class="text-left"><a href="viewInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=View"
							target="_blank"><%=InvoiceNo1%></a></td>
						  <%}  
	                     else if ((id.equalsIgnoreCase("proformarevise"))&& status!="Closed") { %>
				<td class="text-left"><a href="detailForProInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=proformarevise"
							target="_blank"><%=InvoiceNo1%></a></td>
						<%} 
	                       else if ((id.equalsIgnoreCase("proformarevise"))&& status=="Closed") { %>
				<td class="text-left"><%=InvoiceNo1%></td>
						<%} 	 
	                        else if (id.equalsIgnoreCase("proformaclose")&& status!="Closed") { %>
				<td class="text-left"><a href="detailForProInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=proformaclose"
							target="_blank"><%=InvoiceNo1%></a></td>
						<%} 
	                          else if (id.equalsIgnoreCase("proformaclose")&& status=="Closed") { %>
				<td class="text-left"><%=InvoiceNo1%></td>
						<%} %>
						<% 
	                        if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise") )
	                       {%>
				<td class="text-center"><%=RevOfinvoiceRefNo1%></td>
						<%}  else if (id.equalsIgnoreCase("proformarevise")) { %>
				<td class="text-center"><%=RevOfinvoiceRefNo2%></td>
						<%} %>	
						<% 
	                    if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
	                      {%>
				<td class="text-right"><%=dt4%></td>
						<%} else if(id.equalsIgnoreCase("proformaclose") || id.equalsIgnoreCase("proformarevise")){%>
				<td class="text-right"><%=dt4%></td>
						<%} %>
				<td class="text-center"><%=GrandTotal1%></td>
				<td class="text-left"><%=ItemDescription2%></td>
				<td class="text-right"><%=fdate%></td>
				<td class="text-right"><%=tdate%></td>
				<td class="text-right"><%=ddate%></td>
				<td class="text-left"><%=TheGroupName1%></td>
				<td class="text-left"><%=status%></td>
				<td class="text-left"><%=CompanyName1%></td>
				<td class="text-left"><%=TWEmpName1%></td>
						<% 
	                  if(id.equalsIgnoreCase("close") || id.equalsIgnoreCase("View") || id.equalsIgnoreCase("null") || id.equalsIgnoreCase("revise"))
	                    {%>
				<td class="text-left"><%=ClosedBy1%></td>
				<td class="text-left"><%=ReasonForCancelling1%></td>
						<%} %>
					
			</tr>
			<%i++;} %>
        </tbody>
 </table>
 </div>
 
 <%
   	
   }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	    var id = "<%=id%>"; // Dynamic id value
		 // Capitalize
		    id = id.charAt(0).toUpperCase() + id.slice(1).toLowerCase();

	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	          fixedColumns: { 
	            left: 2      //To freeze two columns
	        },  
	      //  keys: true,  //Keytable
	        stateSave: true,
	        
	        /* //for adding checkbox to first column
            columnDefs: [{
                orderable: false,
                className: 'select-checkbox',
                targets: 0
            }],
            select: {
                style: 'multi',
                selector: 'td:first-child'
            },
            order: [[1, 'asc']],
            //end adding checkbox to first column */

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
								title: id + ' Invoice List Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: id + ' Invoice List Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'Portrait',
	                            pageSize: 'A3',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: id + ' Invoice List Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: id + ' Invoice List Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: id + ' Invoice List Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
					],
				},
				
           ], 
       
       });

   });
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>