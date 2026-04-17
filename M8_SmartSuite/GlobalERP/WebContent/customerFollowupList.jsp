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
 String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
 String monthbefore=session.getAttribute("onemonthback").toString();
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

Calendar cal= Calendar.getInstance();
cal.add(Calendar.MONTH, -2);

Calendar cal1= Calendar.getInstance();
cal1.add(Calendar.MONTH, -3);

java.util.Date datetwomonth = cal.getTime();
java.util.Date datethreemonth = cal1.getTime();

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String twomonthbefore=formatter.format(datetwomonth);

String threemonthbefore=formatter.format(datethreemonth);
 // Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null,st3=null,st4=null,st5=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
String today=session.getAttribute("Today").toString();


String usermail="";
String repr="";
StringBuffer htmlString = new StringBuffer ("");
StringBuffer followUpData = new StringBuffer ("");
String headerstring;
StringBuffer tempData=new StringBuffer("");
int k;
int h=1;
int masterCounter=1;
String sqlFollowup="";		
String fromDateCal = "", toDateCal = "", sql = "",mainCustomer="";
fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String code=request.getParameter("Code1");
System.out.println("<><><><><><>      "+code);

String Custcount=request.getParameter("count1");
System.out.println("***********      "+Custcount);

String number=request.getParameter("number");
System.out.println("**&&&**&*&**&*&*    "+number);



String mrktName="";
String sqlMarktRep="Select MarketingRepName  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepCode='"+code+"'";

ResultSet rsMrktRep=st2.executeQuery(sqlMarktRep);
System.out.println(sqlMarktRep);

while(rsMrktRep.next())
{
	
	mrktName=rsMrktRep.getString("MarketingRepName");
}

%>  
<%
try{
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
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
<div class="content-header-col-md-7-mt-10 col-12"> <!-- Added text-center class -->
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=mrktName%> Customers</h5>
    </div>
</div>
	

<table id="example" class="display" style="width: 100%">        
       <thead>
        <%if(number.contains("1")){ %>
            <tr>
            	<th class="col-width-4">SrNo.</th>
				  <th>Company</th>
				  <th>Contact Person</th>
				  <th>Phone</th>
				  <th>Mobile</th>
				  <th>City</th>
            </tr>
            <%}else if(number.contains("2")){ %>
            <tr>
            		<th class="col-width-4">SrNo.</th>
				  	<th>Company</th>
				  	<th>Contact Person</th>
				  	<th>Phone</th>
				  	<th>Mobile</th>
				  	<th>City</th>
				 	<th>FollowUps(This Month)</th>
            </tr>
            <%}else if(number.contains("3")){ %> 
            <tr>
			  <th class="col-width-4">Sr No</th>
			  <th>Company</th>
			  <th>Contact Person</th>
			  <th>Phone</th>
			  <th>Mobile</th>
			  <th>City</th>
			  <th>FollowUps(30-60 Days )</th>
			</tr>
            <%}else if(number.contains("4")){ %> 
            
               <tr>
            		<th class="col-width-4">SrNo.</th>
				  	<th>Company</th>
				  	<th>Contact Person</th>
				  	<th>Phone</th>
				  	<th>Mobile</th>
				  	<th>City</th>
				 	<th>FollowUps(This Month)</th>
            </tr>
            
            <%} %>
        </thead> 
        <tbody>
        <%if(number.contains("1")){ %>
         <% 	    
			 int j=1;String Customer="";
			 String sqlList="select ProspCustName,ContactPerson,Address,City from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  Group By ProspCustName";
			System.out.println(sqlList);	
			 ResultSet rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
			 while(rsList.next())
			 {
			  Customer=rsList.getString("ProspCustName");	
			  System.out.println("CUSTOMER IOS    **********   "+Customer);
			  String phone="",email="",mobile="",type= "",salescode = "", city="";
			  String sqldata="Select Phone,EMail,MobileNo,SalesCustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster "+ 
			 					 "where CompanyName='"+Customer.trim()+"'";
			System.out.println(sqldata);	
			  ResultSet rsdata=st.executeQuery(sqldata);
			  if(rsdata.next())
			  {
				 phone=rsdata.getString("Phone");	 
				 email=rsdata.getString("EMail"); 
				 mobile=rsdata.getString("MobileNo");
				 salescode=rsdata.getString("SalesCustomerCode");
				 city = rsList.getString("City");
				 if(salescode == "0" || salescode.equals("0"))
					 type = "Prospect";
				 else
					 type = "Customer";
			  }
			  
			 %>	
			 <tr>
				<td class="text-center"><%=j%></td>
				<td class="text-left"><%=Customer%>
				</td>
				<td class="text-left"><%=rsList.getString("ContactPerson")%></td>
				<%
				if (phone == null || phone.isEmpty()) { 
				    phone = "-";
				}
				%>
				<td class="text-center"><%= phone %></td>
				<td class="text-center"><%=mobile%></td>
				<%
				if (city.contains("null")|| city.isEmpty()) { 
					city = "-";
				}
				%>
				<td class="text-center"><%=city%></td>
			</tr>
         	<%
				j++;
				}
				
				%>
		

 <%} else if(number.contains("2")){ 
			int l=1;
			String Customer="";
			String sqllistformonth="select ProspCustName,ContactPerson,Address,City from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-' AND FollowUpDate < '"+todaysDate+"' and FollowUpDate > '"+monthbefore+"' Group By ProspCustName";
			ResultSet rsListformonth=st2.executeQuery(sqllistformonth);
			System.out.println(sqllistformonth);
			while(rsListformonth.next())
			{
				  Customer=rsListformonth.getString("ProspCustName");
				  int count=0;
				  String sqlCount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+Customer+"' AND FollowUpDate < '"+todaysDate+"' and FollowUpDate > '"+monthbefore+"'";
				  ResultSet rsCount=st.executeQuery(sqlCount);
				  System.out.println("*********************************      "+sqlCount);
				  rsCount.next();
				  count=rsCount.getInt(1); 
				
				  String phone="",email="",mobile="",City="",Product="",salescode = "",type = "";
				  String sqldata="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+Customer+"'";
				  ResultSet rsdata=st.executeQuery(sqldata);
				  if(rsdata.next())
				  {
					 phone=rsdata.getString("Phone");	 
					 email=rsdata.getString("EMail"); 
					 mobile=rsdata.getString("MobileNo");
					 City=rsdata.getString("City");
					 Product=rsdata.getString("IntrestedProduct");
					 salescode=rsdata.getString("SalesCustomerCode");
					 
					 if(salescode == "0" || salescode.equals("0"))
						 type = "Prospect";
					 else
						 type = "Customer";
				  }
				  
			%>
			<tr>
				<td class="text-center"><%=l%></td>
				<td class="text-left"><%=Customer%></td>
				<td class="text-left"><%=rsListformonth.getString("ContactPerson")%></td>
				<td class="text-center"><%=phone%></td>
				<td class="text-center"><%=mobile%></td>
				<td class="text-center"><%=rsListformonth.getString("City")%></td>
				<td class="text-center"><a href="#" onclick="followupPopup('customerWiseFollowUpReport.jsp','<%=Customer %>','<%=rsListformonth.getString("ContactPerson") %>','<%=phone %>','<%=email %>','<%=City %>','<%=Product %>')"><%=count%></a></td>
			</tr>
				<%
				l++;
				}%>
				
			
<%} else if(number.contains("3")){ %>

		    <% 	       
			int p=1;String Customer="";
			String sqllistfor2month="select ProspCustName,ContactPerson,Address,City from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'AND  FollowUpDate < '"+monthbefore+"' AND FollowUpDate > '"+twomonthbefore+"' Group By ProspCustName";
			ResultSet rsListfor2month=st3.executeQuery(sqllistfor2month);
			System.out.println("&*&*&*   "+sqllistfor2month);
			while(rsListfor2month.next())
			{
				  Customer=rsListfor2month.getString("ProspCustName");
				  int count=0;
				  String sqlCount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+Customer+"' AND FollowUpDate < '"+monthbefore+"' and FollowUpDate > '"+twomonthbefore+"'";
				  ResultSet rsCount=st.executeQuery(sqlCount);
				  System.out.println("*********************************      "+sqlCount);
				  rsCount.next();
				  count=rsCount.getInt(1); 
				  
				  String phone="",email="",mobile="",city="",product="",salescode = "",type ="";
				  String sqldata="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+Customer+"'";
				  ResultSet rsdata=st.executeQuery(sqldata);
				  if(rsdata.next())
				  {
					 phone=rsdata.getString("Phone");	 
					 email=rsdata.getString("EMail"); 
					 mobile=rsdata.getString("MobileNo");
					 city=rsdata.getString("City");
					 product=rsdata.getString("IntrestedProduct");
					 salescode=rsdata.getString("SalesCustomerCode");
					 
					 if(salescode == "0" || salescode.equals("0"))
						 type = "Prospect";
					 else
						 type = "Customer";
				  }
	        %>		
	        <tr>
				<td class="text-center"><%=p%></td>
				<td class="text-left"><a href="#"  onclick=""><a href="javascript:toggleDetails('<%=Customer %>','true','<%=p%>')" /><%=Customer%>
				
				<div align="right" class="popup" id="popup<%=p %>"style="display:none;position:fixed;">
			    <table width="70%" align="right" border="1"  bgcolor="#C6DEFF" cellpadding="0" cellspacing="0" style="position: absolute;">
				    <tr><td><div align="center"><a href="javascript:showentryform('<%=Customer%>')"/>Enter Followup</a></div></td></tr>
				   <tr><td><div align="center"><a href="ledgerdetails.jsp?companyName=<%=Customer %>&companyPerson=<%=rsListfor2month.getString("ContactPerson") %>&companyPhone=<%=phone %>&companyEmail=<%=email %>&companyCity=<%= rsListfor2month.getString("City")%>"/>View Ledger Details</a></div></td></tr>
				   <tr><td><div align="center"><a href="customerDetails.jsp?companyName=<%=Customer%>&type=<%=type%>"/>Show Details</a></div></td></tr>
				   <tr><td><div align="center"><a href="javascript:toggleDetails('<%=Customer%>','false','<%=p %>')" />close</a></div></td></tr>
				</table>
				</div>
				</a>
			
				</td>
				<td class="text-left"><%=rsListfor2month.getString("ContactPerson")%></td>
				<td class="text-center"><%=phone%></td>
				<td class="text-center"><%=mobile%></td>
				<td class="text-center"><%=rsListfor2month.getString("City")%></div></td>
				<td class="text-center"><a href="#" onclick="followupDet('followUpDet.jsp','<%=Customer %>','<%=monthbefore %>','<%= twomonthbefore%>')"><%=count%></a></td>
			
			</tr>
			<%
			p++;
			}
			%>
		
	<%} else if(number.contains("4")){ %>

		    <%
		    int o=1;String Customer="";
			String sqlListin60to90="select ProspCustName,ContactPerson,Address,City from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-' AND FollowUpDate < '"+twomonthbefore+"' AND FollowUpDate > '"+threemonthbefore+"' Group By ProspCustName";
			ResultSet rsList60to90=st4.executeQuery(sqlListin60to90);
			System.out.println(sqlListin60to90);
			while(rsList60to90.next())
			{
				
				  Customer=rsList60to90.getString("ProspCustName");
				  
				  int count=0;
				  String sqlCount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+Customer+"' AND FollowUpDate < '"+twomonthbefore+"' and FollowUpDate > '"+threemonthbefore+"'";
				  ResultSet rsCount=st.executeQuery(sqlCount);
				  System.out.println("*********************************      "+sqlCount);
				  rsCount.next();
				  count=rsCount.getInt(1); 
				  
				  
				  String phone="",email="",mobile="",city="",product="",salescode = "",type = "";
				  String sqldata="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+Customer+"'";
				  ResultSet rsdata=st.executeQuery(sqldata);
				  if(rsdata.next())
				  {
					 phone=rsdata.getString("Phone");	 
					 email=rsdata.getString("EMail");
					 mobile=rsdata.getString("MobileNo");
					 city=rsdata.getString("City");
					 product=rsdata.getString("IntrestedProduct");
					 salescode=rsdata.getString("SalesCustomerCode");
					 
					 if(salescode == "0" || salescode.equals("0"))
						 type = "Prospect";
					 else
						 type = "Customer";
				  }
				
				
			//	out.println(rsList.getString("ProspCustName"));
         	%>		
	        <tr>
				<td class="text-center"><%=o%></td>
				<td class="text-left"><a href="#"  onclick=""><a href="javascript:toggleDetails('<%=Customer %>','true','<%=o %>')" /><%=Customer%>
				
				<div align="right" class="popup" id="popup<%=o %>" style="display:none;position:fixed;">
			    <table width="70%" align="right" border=1 bgcolor="#C6DEFF" cellpadding="0" cellspacing="0" style="position: absolute;margin-left: 5%;">
				    <tr><td><div align="center"><a href="javascript:showentryform('<%=Customer%>')"/>Enter Followup</a></div></td></tr>
				   <tr><td><div align="center"><a href="ledgerdetails.jsp?companyName=<%=Customer %>&companyPerson=<%=rsList60to90.getString("ContactPerson") %>&companyPhone=<%=phone %>&companyEmail=<%=email %>&companyCity=<%= rsList60to90.getString("City")%>"/>View Ledger Details</a></div></td></tr>
					  <tr><td><div align="center"><a href="customerDetails.jsp?companyName=<%=Customer%>&type=<%=type%>"/>Show Details</a></div></td></tr>
				   <tr><td><div align="center"><a href="javascript:toggleDetails('<%=Customer%>','false','<%=o %>')" />close</a></div></td></tr>
				</table>
				</div>
				</a>
				</td>
				<td class="text-left"><%=rsList60to90.getString("ContactPerson")%></td>
				<td class="text-center"><%=phone%></td>
				<td class="text-center"><%=mobile%></td>
				<td class="text-center"><%=rsList60to90.getString("City")%></td>
				<td class="text-center"><a href="#" onclick="followupDet('followUpDet.jsp','<%=Customer %>','<%=twomonthbefore %>','<%= threemonthbefore%>')"><%=count%></a></td>
			
			</tr>
			<%
			o++;
			}
			%>
		
	<%} %>
	
	</tbody>
	</table>
	</div>
 
 <%
 }catch(Exception e){
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
	                         title: 'Customers of <%=mrktName%>',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Customers of <%=mrktName%>',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Customers of <%=mrktName%>',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Customers of <%=mrktName%>',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Customers of <%=mrktName%>',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

							
<script>
function toggleDetails(customer,show,row) 
{
//	alert(customer);
//	alert(show);
	alert(row);
	var popupx = document.getElementById("popup"+row);
	alert(popupx+" +++++    "+row);
	if(show=="true") 
	{
		alert("in visible");
		popupx.style.display = "block";
		popupx.setfocus();
	} 
	else 
	{
		popupx.style.visibility = "hidden";
	}
}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>