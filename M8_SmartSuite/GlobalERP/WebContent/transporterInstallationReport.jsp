 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
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

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
Statement  st3 = null, st4 = null,st2 = null;

ResultSet rsdata=null,rsdata2=null,rsdata3=null,rsdata4=null;
String sql1="",sql2="",sql3="",sql4="";
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
 // Connection Initialization
Connection conn = null;
try {
	conn = connection.getConnect("db_GlobalERP");   
	st2 =conn.createStatement();
	st3 =conn.createStatement();
	st4 =conn.createStatement();
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
<%
	String instruction = request.getParameter("instruction");
	String peripherals = request.getParameter("peripherals");
	String unitid="";
 	
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Transporter Installation Report</h5>
    </div>
</div>

  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-2"></div>
		 
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
		    
             <div class="col-md-2">
				  <label for="dropdown"><b>Peripherals</b></label>
						<div class="input-group input-group-merge">
			                <select name="peripherals" id="peripherals" class="form-select">
				  	<option value="ALL">ALL</option>
				  <% String sqlDropdown1="select distinct(peripherals) from db_gps.t_unitmaster";
				  ResultSet rsDropdown1=st3.executeQuery(sqlDropdown1);
				  while(rsDropdown1.next()){
					  if(peripherals!=null)
					  {
					  if(peripherals.equalsIgnoreCase(rsDropdown1.getString(1)))
					  {
						  %>
						   <option selected="selected"><%=rsDropdown1.getString(1)%></option>
						  <%
					  }
					  else
					  {
						  %>
						  <option><%=rsDropdown1.getString(1)%></option>
								<%} 
					  }
					  else
					  {
				  %>
				  		<option><%=rsDropdown1.getString(1)%></option>
						<%} 	}%> 
				</select>
                            <script>
                            const mySel = document.getElementById("peripherals");
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; 
                             } else if (savedValue) {
                              mySel.value = savedValue;
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value);
                               });
                             </script>	 		
		                </div>
			</div>			
			
			<div class="col-md-2">
				  <label for="dropdown"><b>Instruction</b></label>
						<div class="input-group input-group-merge">
			               <select name="instruction" id="instruction" class="form-select">
				  	<option value="ALL">ALL</option>
				  <% String sqlDropdown2="select distinct(Instruction) from db_gps.t_vehicledetails";
				  ResultSet rsDropdown2=st4.executeQuery(sqlDropdown2);
				  while(rsDropdown2.next()){
					  if(instruction!=null)
					  {
					  if(instruction.equalsIgnoreCase(rsDropdown2.getString(1)))
					  {
						  %>
						   <option selected="selected"><%=rsDropdown2.getString(1)%></option>
						  <%
					  }
					  else
					  {
						  %>
							
						  <option><%=rsDropdown2.getString(1)%></option>
									
								<%} 
					 
					  }
					  else
					  {
				  %>
				  		<option><%=rsDropdown2.getString(1)%></option>
							
						<%} 	}%> 
				</select>
	                          <script>
	                            const mySel = document.getElementById("instruction");
	                             const savedValue = localStorage.getItem("selValue");
	                             if (isBtNull) {
	                             mySel.value = "Select"; 
	                             } else if (savedValue) {
	                              mySel.value = savedValue;
	                               }
	                              mySel.addEventListener("change", function () {
	                              localStorage.setItem("selValue", this.value);
	                               });
                             </script>	
		                </div>
			</div>				
			
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
						
		</div>
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
</form> 
 <br>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Transporter</th>
			<th>User Limit</th>
			<th>Unit Limit</th>
			<th>Instruction</th>
			<th>Installed Units</th>
			<th>Pending Installation</th>         		        
            </tr>
            
        </thead> 
        <%   
try
{
	System.out.println("INsT===>"+instruction+"Pheri"+peripherals);
	if(instruction.equals("ALL") && peripherals.equals("ALL"))
			{
	 sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as a where  a.InstalledDate between '"+dttime+"' and '"+dt1time+"' group by OwnerName ";
			}
	else if(peripherals.equals("ALL"))
	{
		
		sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as a where a.Instruction='"+instruction+"' and  a.InstalledDate between '"+dttime+"' and '"+dt1time+"' group by OwnerName ";
		
	}else if(instruction.equals("ALL"))
	{
		sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as a,"+session.getAttribute("CompanyMasterID").toString()+"unitmaster as b where a.unitid=b.unitid and b.peripherals='"+peripherals+"'  and  a.InstalledDate between '"+dttime+"' and '"+dt1time+"'  group by OwnerName";
	}
	else
	{
		sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as a,"+session.getAttribute("CompanyMasterID").toString()+"unitmaster as b where a.Instruction='"+instruction+"' and a.unitid=b.unitid and b.peripherals='"+peripherals+"'  and  a.InstalledDate between '"+dttime+"' and '"+dt1time+"' group by OwnerName ";
	}
	
}
catch(Exception e)
{
	sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as a where  a.InstalledDate between '"+dttime+"' and '"+dt1time+"' ";
}
System.out.println("QUERY FOR REPORT====>>"+sql1);
rsdata=st.executeQuery(sql1);
int cnt=0,cnt1=0,i=1;
while(rsdata.next())
{
	System.out.println("Vehicle Code==********==>"+rsdata.getInt("VehicleCode"));
	String Transporter=rsdata.getString("OwnerName");
	sql2="select Userlimit,Unitlimit from "+session.getAttribute("CompanyMasterID").toString()+"transporter as t,"+session.getAttribute("CompanyMasterID").toString()+"vehicledetails as v where t.TypeValue='"+Transporter+"' and  v.OwnerName=t.TypeValue and  v.InstalledDate between '"+dttime+"' and '"+dt1time+"'";
	rsdata2=st2.executeQuery(sql2);
	System.out.println("Query for Limit"+sql2);
	
	 
	if(rsdata2.next())
	{
		int Unitlimit=rsdata2.getInt("Unitlimit");
		int Userlimit=rsdata2.getInt("Userlimit");
		String Instruction=rsdata2.getString("Instruction");
		
		
		sql3="select count(*) as cnt from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails where OwnerName='"+Transporter+"' and status <> 'Deleted'" ;//  and InstalledDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		rsdata3=st3.executeQuery(sql3);
		System.out.println("Query for cnt==****=> "+sql3);
		if(rsdata3.next())
		{
		 cnt=rsdata3.getInt("cnt");
		}
		int total=Unitlimit-cnt;
		sql4="select count(*) as cnt from "+session.getAttribute("CompanyMasterID").toString()+"vehicledetails where OwnerName='"+Transporter+"' and status <> 'Deleted'  and InstalledDate between '"+dttime+"' and '"+dt1time+"'";
		rsdata4=st4.executeQuery(sql4);
		System.out.println("Query for cnt==****=> "+sql4);
		if(rsdata4.next())
		{
		 cnt1=rsdata4.getInt("cnt");
		}
%>
        <tbody>
        
         <tr>
			<td class="text-center"><%= i++%> </td>
			<td class="text-left"><a href="transporterVehicleDetailsReport.jsp?transporterName=<%=Transporter%>&date1=<%=fromDate %>&date2=<%=toDate %>" target="_blank"><%=Transporter%></a></td>
			<td class="text-right"><%=Userlimit %> </td>
			<td class="text-right"><%=Unitlimit %> </td>
			<td class="text-left"><%=Instruction %> </td>
			<td class="text-right"><%=cnt1%></td>
			<td class="text-right"><%=total%></td>
		</tr>
<%
	}
}   // end of while  

	%>				 
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
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        // fixedColumns: { 
	     //       left: 3      //To freeze two columns
	     //   }, 
	        //keys: true,  //Keytable
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
	                         title: 'Transporter Installation Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Transporter Installation Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Transporter Installation Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Transporter Installation Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
							title: 'Transporter Installation Report '+$("#data").val()+ ' to ' +$("#data1").val(),
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