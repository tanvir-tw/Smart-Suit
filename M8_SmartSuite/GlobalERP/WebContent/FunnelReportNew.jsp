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
String bt="",type="",selected1="",departmentNew="",companymasterid="";
String Assignto="",empcode="",empname="",CompanyName="",ContactPerson="",Phone="",Email="",CustCode="",SalesCustCode="";
String CustType="",City="";
String LastCon="",dt1 ="",FollowStatus="";
int ck=0;
int cnt = 1;
String Query="";
String DateAdded="";

String funnelstage="",
potentialunits="",confidencelevel="",segment="",
ais140="",onetimecharge="",recurringcharge="",potentiallacs="",
specialcomment="",verticals="",remarks="",lastcontacteddate="",expectedclosuredate="",calculated="";

// Connection Initialization
Connection conn = null;
Statement st1 = null;
Statement st2 = null;
Statement st4 = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st4 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
type=request.getParameter("status");
selected1=request.getParameter("dept");
companymasterid=session.getAttribute("CompanyMasterID").toString();

if(selected1==null && departmentNew!=null)
{
	selected1=departmentNew;
}

String repname="Select distinct(EmpName),EmpCode from db_GlobalERP.UserMaster where empcode='"+type+"' and companymasterid='"+companymasterid+"'";
ResultSet rsrepname=st.executeQuery(repname);
if(rsrepname.next())
{
	empname=rsrepname.getString("EmpName");
	empcode=rsrepname.getString("EmpCode");
}else
{
	empname="-";
	empcode="0";
}
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Funnel Report</h5>
    </div>
</div> 
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-5"></div>
				
				<div class="col-md-2">
				  <label for="dropdown"><b>Representative</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="status" name="status">
                             <% if(bt == null) { %>
                               <option value="Select" selected>Select</option>
                                 <% } %>
                              <%
                              String EmpCode="",EmpName="";
                              String rep="select distinct(EmpCode),EmpName from db_GlobalERP.UserMaster where empcode in (select distinct(Allocatedto)  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster) and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by EmpName";
                      		ResultSet rsrep=st1.executeQuery(rep);
                      		while(rsrep.next())
                      		{ 
                      			EmpCode=rsrep.getString("EmpCode");
                      			EmpName=rsrep.getString("EmpName");
                      		%>
                      			<option value="<%=EmpCode%>" <%if(type!=null){ if(type.equals(EmpCode)){ %> selected <% } } %> ><%=rsrep.getString("EmpName") %></option>
                      			
                      		  <% } %>
                           </select>
                            
                             <script>
                            const mySel = document.getElementById("status");
                             const isBtNull = <%= bt == null %>;
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
		                </div>
			</div>				
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			
			<div class="col-md-3"></div>
			
		</div>
<input type="hidden" name="type<%=cnt %>" id="type<%=cnt %>" value="<%=CustType%>">
<input type="hidden" name="code<%=cnt %>" id="code<%=cnt %>" value="<%=CustCode%>">
<input type="hidden" name="custname<%=cnt %>" id="custname<%=cnt %>" value="<%=CompanyName%>">
</form> 
<br> 
<table id="example" class="display" style="width:100%">        
       <thead>
					<tr>
						<th>SrNo</th>
						<th>Funnel Stage</th>
						<th>Customer</th>
						<th>Added Date</th>
						<th>Type</th>
						<th>Rep Name</th>
						<th>Verticals</th>
						<th>Segment</th>
						<th>Sub Group</th>
						<th>Solution</th>
						<th>Potential Units</th>
						<th>One Time Charge</th>
						<th>Recurring Charge</th>
						<th>Contract Value</th>
						<th>Contact</th>
						<th>FollowUp</th>
						<th>Last Contacted Date</th>
						<th>Confidence Level</th>
                    </tr>
				</thead> 
        <tbody>
       <%
       
		
		if(bt==null || bt==" " || bt=="")
		{
	 		Query="select * from db_GlobalERP."+companymasterid+"prospectivecustmaster where    Allocatedto ='No Data' and Allocatedto!=0  order by Updatedatetime asc limit 3";
		}
		else{
			Query="select distinct(CompanyName),CustomerCode,PotentialValue,NoOfUnits,solution,SalesCustomerCode,City,EMail,ContactPerson,Phone,verticals,segment,subgroup,confidencelevel,onetimecharge,recurringcharge,ProspCustAddedOn ,contractvalue from db_GlobalERP."+companymasterid+"prospectivecustmaster where  Allocatedto='"+type+"' order by CompanyName asc";
		}
		System.out.println("Query :-"+Query);
		ResultSet RsQuery=st2.executeQuery(Query);
		while(RsQuery.next()){
			CompanyName=RsQuery.getString("CompanyName");
			City=RsQuery.getString("City");
			Email=RsQuery.getString("EMail");
			Phone=RsQuery.getString("Phone");
			ContactPerson=RsQuery.getString("ContactPerson");
			CustCode=RsQuery.getString("customercode");
			DateAdded=RsQuery.getString("ProspCustAddedOn"); 
				
				if (DateAdded != null && !DateAdded.trim().isEmpty()) {
				  
				} else {
				    DateAdded = "-";
				}
				SalesCustCode=RsQuery.getString("salescustomercode");
				
				if(Integer.parseInt(SalesCustCode)==0 && Integer.parseInt(CustCode)!=0)
				{
					CustType="Prospect";
				}else{
					CustType="Customer";
					CustCode=SalesCustCode;
				}
			
				int countcon=0;
			String concnt="select count(*) as cnt from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode='"+CustCode+"'";
			System.out.println("concnt :-"+concnt);
			ResultSet rsconcnt=st1.executeQuery(concnt);
			if(rsconcnt.next())
			{
				countcon=rsconcnt.getInt("cnt");
			}
			else
			{
				countcon=0;
			}
			int visitspermonth=0,phonecallpermonth=0;
			
			funnelstage="";potentialunits="";confidencelevel="";segment="";ais140="";onetimecharge="";recurringcharge="";potentiallacs="";specialcomment="";verticals="";remarks="";lastcontacteddate="";expectedclosuredate="";calculated="";
						
			 LastCon="";dt1 ="";FollowStatus="";
			 if(CompanyName.contains("'")){
				 CompanyName="-";
			 }
		
			//String follow="SELECT CONCAT(FollowUpDate,' ', FollowUpTime) as LastContact,Status,FollowUpType,NextFollowUpDate,Comments,MarketingRepcode FROM "+companymasterid+"followup where ProspCustName='"+ CompanyName+ "' and FollowUpType <> 'Assigned' ORDER BY FollowUpDate Desc limit 3";
			String follow="SELECT CONCAT(FollowUpDate,' ', FollowUpTime) as LastContact,Status,FollowUpType,NextFollowUpDate,Comments,MarketingRepcode FROM "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+ CompanyName+ "' and FollowUpType <> 'Assigned'"
							+ " ORDER BY FollowUpDate Desc limit 3";
			
			System.out.println("follow :-"+follow);
			ResultSet rsfollow=st4.executeQuery(follow);
			if(rsfollow.next())
			{
			
				LastCon=rsfollow.getString("LastContact");
				FollowStatus=rsfollow.getString("Status");
				
				 dt1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(LastCon));

				
			}else{
				
				dt1="No Data";
				FollowStatus="No Data";
			}
%>
 <tr>
<td align="right"><%= cnt %></td>
<td align="left"><%=FollowStatus %></td>

	<%if(CustType.equals("Prospect"))
		{%>    
<td align="center"> <a href="Editprospect.jsp?companyName=<%=CustCode%>"><%=CompanyName%></a></td>
	<%}else{ %>
	<td align="center"> <a href="EditCompaany.jsp?companyCode=<%=CustCode%>"><%=CompanyName%></a></td>
	<%} %>
		<td align="left"><%=DateAdded %></td>
	<td align="left"><%=CustType %></td>
	
	<td style="width: 85px;"><%=empname%>
        <input type="hidden" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="border:none;text-align:left;"  value="<%=empname%>" readonly/>
</td>
        <td align="left"><%=RsQuery.getString("verticals") %></td>
		<td align="left"><%=RsQuery.getString("segment") %></td>
		<td align="left"><%=RsQuery.getString("subgroup") %></td>			
        <td align="right"><%=RsQuery.getString("solution") %></td>
		<td align="left"><%=RsQuery.getString("NoOfUnits") %></td>
		<td align="left"><%=RsQuery.getString("onetimecharge") %></td>
		<td align="left"><%=RsQuery.getString("recurringcharge") %></td>
		<td align="left"><%=RsQuery.getString("contractvalue") %></td>
		<td align="center"><a href="contactdetails.jsp?companyname=<%=CompanyName%>&Type=<%=CustType%>&customercode=<%=CustCode%>"><b><%=countcon %></b></a></td>
		<td align="center"><a href="followupEntryForm.jsp?Prospect=<%=CompanyName %>&type=<%=CustType %>&phone=<%=Phone %>&email=<%=Email %>&customercode=<%=CustCode%>&Company=<%=CompanyName %>&companycode=<%=CustCode%>&companyNames=<%=CompanyName %>&companyCity=<%=City %>&companyContactPerson=<%=ContactPerson %>&customerCity=<%=City %>&customerContactPerson=<%=ContactPerson%>"><b>Add</b></a></td>
		<td align="right"><%= dt1 %></td>
		<td align="left"><%=RsQuery.getString("confidencelevel") %></td>
      </tr> 
<%
cnt++;
ck++;
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
  var rep = $("#status option:selected").text();
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        //scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	     //   scrollCollapse: true,
	       fixedColumns: { 
	            left: 3      //To freeze two columns
	        },
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A2',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Funnel Report - '+rep,							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Funnel Report - '+rep,
                                orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Funnel Report - '+rep,							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Funnel Report - '+rep,							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Funnel Report - '+rep,							},
					],
				},
           ], 
       
       });

   });
   
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>