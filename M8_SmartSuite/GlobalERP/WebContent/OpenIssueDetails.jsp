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
String status="",priority="", FromDate="",ToDate="",sql="";
String Issue_Id="" ,ReportedDate="" ,CustomerType ="" ,IssueRaisedBy ="",CustomerName ="",Priority ="",SystemName ="";
String ActionPoint ="" ,OpenIssue  ="" ,Description ="" ,TargetClosureDate ="" ,TargetDate ="" ,Department ="" ,Concern ="" ,TaskType ="",ClosureDate ="",OverdueDays="";
String ReportedDateNew="",TargetClosureDateNew="",TargetDateNew="",ClosureDateNew="";
int j=1;

 // Connection Initialization
Connection conn = null;
Statement st = null, stmain=null ;
ResultSet rsOverdue =null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    stmain = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%

status=request.getParameter("status");
priority=request.getParameter("priority");
System.out.println("priority"+priority);
FromDate=request.getParameter("FromDate");
ToDate=request.getParameter("ToDate");
if(priority==null && status==null){
	
	 sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where  Status != '-' and  ReportedDate >='"+FromDate+"' and "+"ReportedDate <='"+ToDate+"' and Priority!='-'";

}
else if(priority==null){
	 sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Status='"+status+"' and ReportedDate >='"+FromDate+"' and "+"ReportedDate <='"+ToDate+"' and Priority!='-'";
}
else if(status==null){
	 sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Priority='"+priority+"' and ReportedDate >='"+FromDate+"' and "+"ReportedDate <='"+ToDate+"' and Priority!='-'";
}
else {
	 sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Priority='"+priority+"' and Status='"+status+"' and ReportedDate >='"+FromDate+"' and "+"ReportedDate <='"+ToDate+"' and Priority!='-'";
}
System.out.println("sql==>"+sql);
ResultSet rs = st.executeQuery(sql);


try{
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Issue Details</h5>
    </div>
</div>
  <br>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
			<th>Issue ID</th>
			<th>Reported Date</th>
			<th>Customer Type</th>
			<th>Issue Raised By</th>
			<th>Customer Name</th>
			<th>Priority</th>
			<th>System</th>
			<th>Action Point</th>
			<th>Open Issue</th>
			<th >Description</th>
			<th>Target Closure Date</th>
			<th>Target Date</th>
			<th>Department</th>
			<th>Concern</th>
			<th>Task Type</th>
			<th>Closure Date</th>
			<th>Status</th>
			<th>Overdue Days</th>
            </tr>
        </thead> 
        <tbody>
        <%
        String Status ="";
        while(rs.next()){
       	 Issue_Id=rs.getString("Issue_SR_Id");
       	  //System.out.println("Issue_Id is : "+Issue_Id);
       	  
       	  ReportedDate=rs.getString("ReportedDate");
       	 
       	ReportedDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ReportedDate));
       	  
       	  CustomerType=rs.getString("CustomerType");
       	  IssueRaisedBy=rs.getString("IssueRaisedBy");
       	  CustomerName=rs.getString("CustomerName");
       	  Priority=rs.getString("Priority");
       	  SystemName=rs.getString("SystemName");
       	  ActionPoint=rs.getString("ActionPoint");
       	  OpenIssue=rs.getString("OpenIssue");
       	  Description=rs.getString("Description");
       	  TargetClosureDate=rs.getString("TargetClosureDate");
       	 // System.out.println("Target date== "+TargetClosureDate);
       	  if(TargetClosureDate.equals("-")){
       		  TargetClosureDateNew="-";
       	  }else{
       		  TargetClosureDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetClosureDate));
       	  }
       	  
       		  TargetDate=rs.getString("TargetDate");
       	  if(TargetDate.equals("-")){
       		  TargetDateNew="-";
       		
       	  }else{
       		 
       			TargetDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetDate));
       	  }
       	  
       	  Department=rs.getString("Department");
       	  Concern=rs.getString("Concern");
       	  TaskType=rs.getString("TaskType");
       	  ClosureDate=rs.getString("ClosureDate");
       	  System.out.println("ClosureDate == "+ClosureDate);

       	  if(ClosureDate.equals("-")){
       		  ClosureDateNew="-";

       	  }else{
       		  ClosureDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ClosureDate));

       	  }
       	  Status=rs.getString("Status");
       	  
       	  
       	  String sqlOverduedays="SELECT DATEDIFF( current_date, TargetDate) as OverdueDays,Status FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Issue_SR_Id='"+Issue_Id+"' and  Status != 'Close' and TargetDate!='0000-00-00'";
       	  System.out.println("sqlOverduedays == "+sqlOverduedays);

       	  rsOverdue = stmain.executeQuery(sqlOverduedays);

       	 if(rsOverdue.next()){
       	  OverdueDays=rsOverdue.getString("OverdueDays");	  
       	  System.out.println("OverdueDays == "+OverdueDays);

       	 }
       	 if(Status.equalsIgnoreCase("Close")){
       		 OverdueDays="-";
       		 
       	 }
       	 if(OverdueDays == null){
       		 OverdueDays="-";
       		 
       	 }
       	 %>
        
        <tr> 
	 <td class="text-center"><%=j%></td>
	 <td class="text-center"><%=Issue_Id%></td>
	 <td class="text-right"><%=ReportedDateNew%></td>
	 <td class="text-left"><%=CustomerType%></td>
	 <td class="text-left"><%=IssueRaisedBy%></td>
	 <td class="text-left"><%=CustomerName%></td>
	 <td class="text-left"><%=Priority%></td>
	 <td class="text-left"><%=SystemName%></td>
	 <td class="text-left"><%=ActionPoint%></td>
	 <td class="text-left"><%=OpenIssue%></td>
	 <td class="text-left"><%=Description%></td>
	 <td class="text-right"><%=TargetClosureDateNew%></td>
	 <td class="text-right"><%=TargetDateNew%></td>
	 <td class="text-left"><%=Department%></td>
	 <td class="text-left"><%=Concern%></td>
	 <td class="text-left"><%=TaskType%></td>
	 <td class="text-right"><%=ClosureDateNew%></td>
	 <td class="text-left"><%=Status%></td>
	 <td class="text-center"><%=OverdueDays%></td>				
				</tr>
				  <%
	 j++;
}

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
	       displayLength: 10,
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

	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)
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
	                         title: 'Issue Details ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Issue Details ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Issue Details ',		
                             },
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Issue Details ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Issue Details ',						},
					],
				},
           ], 
       });
   });
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>