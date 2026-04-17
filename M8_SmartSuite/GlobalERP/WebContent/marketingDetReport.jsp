 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*" import="java.util.Date"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<style>
    #delete {
    text-decoration: none;
    font-size: inherit;
    font-weight: bold;
    }
</style>
</head>
 <body style="background-color:azure;">
<%
String fromdate=request.getParameter("fromDate");
String newfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromDate")));
String todate=request.getParameter("toDate");
String newtodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("toDate")));
String number=request.getParameter("Number");
String repcode=request.getParameter("repCode");
String condition="",sqlVisits="",name="",rname="";
String CompanyName="",ProspCustAddedOn="",ContactPerson="", City="",Address="";
String ProspCustName="",FollowUpDate="",NextFollowUpDate="",Comments="",FollowUpSubject="",Reply="";
int i=1;

// Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null;

try {
	conn = connection.getConnect("db_GlobalERP"); 
	st1 = conn.createStatement();
	st2 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%try{

	String sqlName="select 	MarketingRepName from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepCode='"+repcode+"'" ;
	ResultSet rsName=st1.executeQuery(sqlName);
	if(rsName.next()){
		 name=rsName.getString("MarketingRepName");
	} 
%>
<div class="container-fluid mt-2" id="main">

<%if(number.contains("6")){
	rname="\"Prospects Details of:"+name+" Between "+newfromdate+" to "+newtodate+"\"";
	%>
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Prospects Details of:<%=name%> Between <%=newfromdate %> to <%=newtodate %></h5>
    </div>
</div>
<br><br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
              <th class="col-width-4">SrNo</th>
              <th>Name</th>
           	  <th>Prospects Customer Added On</th>
	          <th>Contact Person</th>
	          <th>City</th>
	          <th>Address</th>
           </tr>
        </thead> 
        <tbody>

<% 
String sqlVisits1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustEnteredByRep = '"+name+"' and ProspCustAddedOn >= '"+fromdate+" 00:00:00' and  ProspCustAddedOn  <= '"+todate+" 23:59:59'";
System.out.println("sql Visit-----------"+sqlVisits1);
ResultSet rsVisit=st2.executeQuery(sqlVisits1);
while(rsVisit.next()){
	
	CompanyName=rsVisit.getString("CompanyName");
	ProspCustAddedOn=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsVisit.getString("ProspCustAddedOn")));
	ContactPerson=rsVisit.getString("ContactPerson"); 
	City=rsVisit.getString("City");
	Address=rsVisit.getString("Address"); 
%>
	<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-left"><%=CompanyName%></td>
	<td class="text-right"><%=ProspCustAddedOn%></td>
	<td class="text-left"><%=ContactPerson%></td>
	<td class="text-left"><%=City%></td>
	<td class="text-left"><%=Address%></td>
	</tr>
<% 	
	  i++;
	}
%>
        </tbody>
 </table>
<%}
else
{
%>

<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
    <%if(number.contains("1")){ 
	condition="'Visit'";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Visit Details - <%=name%> Between <%=newfromdate %> To <%=newtodate %></h5>
    <%
	rname="\"Visit Details -"+name+" Between "+newfromdate+" to "+newtodate+"\"";

    }%>	
	 <%if(number.contains("2")){ 
	condition="'phoneCall','Ph Call'";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Phone Call Details of:<%=name%> Between <%=newfromdate %> To <%=newtodate %></h5>
    <%
	rname="\"Phone Call Details of:"+name+" Between "+newfromdate+" to "+newtodate+"\"";

	 }%>	
     <%if(number.contains("3")){ 
    	 condition="Letter";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Letters Details of:<%=name%> Between <%=newfromdate %> To <%=newtodate %></h5>
    <%
	rname="\"Letters Details of:"+name+" Between "+newfromdate+" to "+newtodate+"\"";

     }%>	
     <%if(number.contains("4")){ 
        condition="'E-mail','E mail','Mail','Email'";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Email Details of:<%=name%> Between <%=newfromdate %> To <%=newtodate %></h5>
    <%
	rname="\"Email Details of:"+name+" Between "+newfromdate+" to "+newtodate+"\"";

     }%>	
     <%if(number.contains("5")){ 
    		condition="'Meeting'";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Meetings Details of:<%=name%> Between <%=newfromdate %> to <%=newtodate %> </h5>
    <%
	rname="\"Meetings Details of:"+name+" Between "+newfromdate+" to "+newtodate+"\"";

     }%>	
     <%if(number.contains("8")){ 
    		condition="FollowUpDate";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Yesterday's Follow Up Report </h5>
    <%
	rname="\"Yesterday's Follow Up Report\"";

    }%>	
     <%if(number.contains("9")){ 
    		condition="NextFollowUpDate";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Today's Follow up Report</h5>
    <%
	 rname="\"Today's Follow up Report\"";

    }%>	
     <%if(number.contains("10")){ 
    		condition="NextFollowUpDate";
      %>
     <h5 class="content-header-title text-center mb-0" style="color: #060637">Tomorrow's Follow up Report</h5>
    <%
	 rname="\"Tomorrow's Follow up Report\"";

     }%>	
    </div>
</div>
<br><br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
              <th class="col-width-4">SrNo</th>
	          <th>Customer</th>
	          <th>Follow Up Date</th>
	          <th>Comments</th>
	          <th>Next Followup</th>
	          <th>Followup Subject</th>
	          <th>Contact Person</th>
	          <th>City</th>
	          <th>Address</th>
	          <th>Reply</th>
           </tr>
        </thead> 
        <tbody>

<% 
if(number.contains("8") || number.contains("9") || number.contains("10")) 
{
	sqlVisits="Select * from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+repcode+"' and "+condition+" between '"+fromdate+"' and '"+todate+"'";
}
else{
	if(!number.contains("6"))
	{
		sqlVisits="Select * from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType in ("+condition+")  and MarketingRepcode='"+repcode+"'	and FollowUpDate between '"+fromdate+"' and '"+todate+"'";
	}
	
}
	ResultSet rsVisit=st2.executeQuery(sqlVisits);
	
	System.out.println("sql Visit-----------"+sqlVisits);
	while(rsVisit.next()){
		
    ProspCustName=rsVisit.getString("ProspCustName");
	FollowUpDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsVisit.getString("FollowUpDate")));
	NextFollowUpDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsVisit.getString("NextFollowUpDate")));
	Comments=rsVisit.getString("Comments");

	FollowUpSubject=rsVisit.getString("FollowUpSubject"); 

	ContactPerson=rsVisit.getString("ContactPerson"); 
	City=rsVisit.getString("City");
	Address=rsVisit.getString("Address"); 
	Reply=rsVisit.getString("Reply"); 

%>
	<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-left"><%=ProspCustName%></td>
	<td class="text-right"><%=FollowUpDate%></td>
    <td class="text-left"><%=Comments%></td>
	<td class="text-right"><%=NextFollowUpDate%></td>
	<td class="text-left"><%=FollowUpSubject%></td>
	<td class="text-left"><%=ContactPerson%></td>
	<td class="text-left"><%=City%></td>
	<td class="text-left"><%=Address%></td>
	<td class="text-left"><%=Reply%></td>
	</tr>
<% 	
	  i++;
	}
%>
        </tbody>
 </table>

<%} %>
<input type="hidden" id="rname" name="rname" value=<%=rname%>>
 </div>

 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	      /*    fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
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
                             title: $("#rname").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
                             title: $("#rname").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: $("#rname").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: $("#rname").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
                             title: $("#rname").val(),
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