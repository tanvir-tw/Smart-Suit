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
// Variable Declaration
String id=request.getParameter("id1");
String Name=request.getParameter("name");
String getyear="",month="",YEAR="",DayDate="",first="",last="";
int i=1;
String Month="",Year="",PresentDays="",OpeningBalance="",LeaveEarned="",LeaveApproved="",PaidLeaves="";
String LeaveBalance="",ClosingBalance="",EntDate="",Entrydate="";

 // Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null,st3=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{

    String getMonth="select MONTHNAME(NOW()) as Month";
	ResultSet rs=st.executeQuery(getMonth);
	if(rs.next())
	{
		month=rs.getString("Month");
		
	}
	month=month.substring(0,3);

	if(month.equalsIgnoreCase("JAN")|| month.equalsIgnoreCase("FEB") || month.equalsIgnoreCase("MAR"))
	{
	getyear="select YEAR(NOW() - INTERVAL 1 Year) as YEAR";
	}
	else
	{
	getyear="select YEAR(NOW()) as YEAR";
	}


	ResultSet rs1=st1.executeQuery(getyear);
	if(rs1.next())
	{
		YEAR=rs1.getString("YEAR");
	}
	
	 DayDate=YEAR+"-04-01";

	String daterange="select DATE('"+DayDate+"') as First ,LAST_DAY('"+DayDate+"' + INTERVAL 11 Month) as Last,YEAR(NOW()) ";

	System.out.println(daterange);

	ResultSet range=st2.executeQuery(daterange);
	if(range.next())
	{
		first=range.getString("First");
		last=range.getString("Last");
	}

	first=first+" 00:00:00";
	last=last+" 23:59:59";

	System.out.println(first);
	System.out.println(last);
	
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Leave Balance - <%=Name %></h5>
    </div>
</div>
  <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
               <th class="col-width-4">SrNo</th>
               <th>Name</th>
               <th>ID</th>
               <th>Month</th>
               <th>Year</th>
               <th>PresentDays</th>
               <th>OpeningBalance</th>
               <th>LeaveEarned</th>
               <th>LeaveApproved</th>
               <th>PaidLeaves</th>
               <th>LeaveBalance</th>
               <th>EntryDateTime</th>
                <th>ClosingBalance</th>
            </tr>
        </thead> 
        <tbody>
        <%
      String leaveMaster="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"LeaveBalanceMaster where EntryDateTime>='"+first+"'and  EntryDateTime<='"+last+"' and EmpID='"+id+"'";
      System.out.println("leaveMaster Query: "+leaveMaster);

     ResultSet rsleave=st3.executeQuery(leaveMaster);
      while(rsleave.next())
     {
	     Month=rsleave.getString("Month");
         Year=rsleave.getString("Year");
    	 PresentDays=rsleave.getString("PresentDays");
    	 OpeningBalance=rsleave.getString("OpeningBalance");
    	 LeaveEarned=rsleave.getString("LeaveEarned");
    	 LeaveApproved=rsleave.getString("LeaveApproved");
    	 PaidLeaves=rsleave.getString("PaidLeaves");
    	 LeaveBalance=rsleave.getString("LeaveBalance");
    	 ClosingBalance=rsleave.getString("ClosingBalance");
    		
    	 EntDate=rsleave.getString("EntryDateTime");
	     Entrydate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(EntDate)); 
	
	
	%>
	
	<tr>
    <td class="text-center"><%=i%></td>
	<td class="text-left"><%=Name%></td>
	<td class="text-center"><%=id%></td>
	<td class="text-left"><%=Month%></td>
	<td class="text-center"><%=Year%></td>
	<td class="text-center"><%=PresentDays%></td>
	<td class="text-center"><%=OpeningBalance%></td>
	<td class="text-center"><%=LeaveEarned%></td>
	<td class="text-center"><%=LeaveApproved%></td>
	<td class="text-center"><%=PaidLeaves%></td>
	<td class="text-center"><%=LeaveBalance%></td>
	<td class="text-right"><%=Entrydate%></td>
	<td class="text-center"><%=ClosingBalance%></td>
	</tr>
		
	<% 
	i++;
}
%>
</tbody>
 </table>
 </div>
 </div>  
 
 <br>
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
	        
	      //  keys: true,  //Keytable
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
	  	                        title: 'Leave Balance Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	  	                        title: 'Leave Balance Report', 
	                            orientation: 'landscape',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	  	                        title: 'Leave Balance Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	  	                        title: 'Leave Balance Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	  	                        title: 'Leave Balance Report', 
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