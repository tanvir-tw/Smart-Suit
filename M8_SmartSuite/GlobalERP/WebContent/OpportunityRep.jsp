 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Opportunity Report</title>
</head>
 <body style="background-color:azure;">
 <%
//Variable Declaration
 String custtype="",Opportunitycode="", Address="",opportunitycount="",companyname="",customercode="", City="",Zip="",State="",Country="",ContactPerson="",Phone="",Fax="",Email="",WebSite="",WeeklyOffOn="",Category="",STDCode="",MobileNo="",ResiNo="",Comments="",OpportunityName="",insertDate="",EntryBy="",alternatenumber="",Assignto="",LeadRefNo="",product="",potentialValue="",noofunits="", bt="";
//Connection Initialization
Connection conn = null;
Statement st1 = null;
Statement st2 = null;
 try {
		conn = connection.getConnect("db_GlobalERP");    
	    st1 = conn.createStatement();
	    st2=conn.createStatement();
	} catch (Exception e) {
	    e.printStackTrace();
	} 
 %>
<%
try{
bt=request.getParameter("button");
String cmp=request.getParameter("companyname").replace("...","&");

%>

<%

String com="";
try{
com=request.getParameter("companyname");
if(com==null)
	com="";
}catch(Exception e){
	com="";
}
	
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Opportunity Report</h5>
    </div>
</div>
<br>
<form action="">
   <div class="row col-12">
		      <div class="col-md-4"></div>
   
   <div class="col-md-3">
                <label for="input"><b>Company Name</b></label>
              <input class="form-control form-control-sm" type="text" id="companynames" name="companyname"  value="<%=cmp%>" autocomplete="off" value="" placeholder="Enter Input" onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies('quotation'); }"></td>
			  
			   <div id="companyList"></div>

			 </div> 
	 		<input type="hidden" id="newcom" name="newcom">
	      	<input type="hidden" id="codecom" name="codecom">
			<div class="col-md-1 mt-4">
	        <input type="submit" class="btn btn-primary"  name="button" id="button" value="Submit">	
			</div>
			<div class="col-md-4"></div>
  </div>			  
  </form>
<% 
String newcompany=request.getParameter("newcom");
String newcodecom=request.getParameter("codecom");
String compa=request.getParameter("companyname");
String company1=compa.replace("...","&");
String customercode1=request.getParameter("customercode");
System.out.println("customercode1"+customercode1);
String customertype1=request.getParameter("customertype");
String companynew=company1.replace("&", "...");
String cname=request.getParameter("companyname");
String Bt=request.getParameter("button");
%>
<%
String cname2="";
if(Bt==null)
{
	System.out.println("Company NAme----------->:"+cname);
	
 cname2=cname.replace("&","...");
	
%>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		  <a href="addNewOpportunity.jsp?companyname=<%=cname2 %>&customercode=<%=customercode1 %>&customertype=<%=customertype1%>" style="text-decoration: none;"><font size="2"><b>Add New</b></font></a>
	    </div>
		
		<div class="col-10"></div>
	</div>
<%}
else
{
	cname2=cname.replace("&","...");
	String getd="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where companyname='"+cname+"'";
	 ResultSet rsgetd=st2.executeQuery(getd);
	if(rsgetd.next())
	{
		customertype1=rsgetd.getString("custtype");
		
		if(customertype1.equals("Customer"))
		{
				customercode1=rsgetd.getString("origcustorsalescode");
		}
		else
		{
			customercode1=rsgetd.getString("customercode");
		}
		
	} 	
	%>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		  <a href="addNewOpportunity.jsp?companyname=<%=cname2 %>&customercode=<%=customercode1 %>&customertype=<%=customertype1%>" style="text-decoration: none;"><font size="2"><b>Add New</b></font></a>
	    </div>
		
		<div class="col-10"></div>
	</div>
	<% 
}
%>
<%	
		cmp=cmp.replace("&","%26");
%>		
<table id="example" class="display" style="width: 100%">    
<thead>
<tr>
    <th class="col-width-4">SrNo</th>
    <th>Edit</th>
    <th>Customer</th>
    <th>Contact Person</th>
    <th>Opportunity</th>
    <th>Address</th>
    <th>Assigned</th>
    <th>Lead Ref</th>
    <th>City</th>
    <th>Phone</th>
    <th>Email</th>
    <th>Website</th>
    <th>Mobile No</th>
    <th>Alternate No</th>
    <th>Comments</th>
    <th>Insert Date</th>
    <th>Potential Value</th>
    <th>Units</th>
</tr>
</thead>
<tbody>

<% 
	if(Bt==null)
	{		
		String cname1=cname.replace("...", "&");
		
		System.out.println("Inside Button  not Press");
		%>		
<%
String query="select custtype,Opportunitycode,Address,opportunitycount,companyname,customercode,City,Zip,State,Country,ContactPerson,Phone,Fax,Email,WebSite,WeeklyOffOn,Category,STDCode,MobileNo,ResiNo,Comments,OpportunityName,insertDate,DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') as UpdatedDate,EntryBy,alternatenumber,Assignto,LeadRefNo,product,potentialValue,noofunits from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where  companyname='"+cname1+"'";
System.out.println("Query to get Data after removing ..."+query);

ResultSet rs1=st1.executeQuery(query);
int i=1;

while(rs1.next())
{
	
	 custtype=rs1.getString("custtype");
	 Opportunitycode=rs1.getString("Opportunitycode");
	 Address=rs1.getString("Address");
	 opportunitycount=rs1.getString("opportunitycount");
	 companyname=rs1.getString("companyname");
	 customercode=rs1.getString("customercode");
	 City=rs1.getString("City");
	 Zip=rs1.getString("Zip");
	 State=rs1.getString("State");
	 Country=rs1.getString("Country");
	 ContactPerson=rs1.getString("ContactPerson");
	 Phone=rs1.getString("Phone");
	 Fax=rs1.getString("Fax");
	 Email=rs1.getString("Email");
	 WebSite=rs1.getString("WebSite");
	 WeeklyOffOn=rs1.getString("WeeklyOffOn");
	 Category=rs1.getString("Category");
	 STDCode=rs1.getString("STDCode");
	 MobileNo=rs1.getString("MobileNo");
	 ResiNo=rs1.getString("ResiNo");
	 Comments=rs1.getString("Comments");
	 OpportunityName=rs1.getString("OpportunityName");
	 	 
	 try{
	 insertDate=rs1.getString("insertDate");
	 
	 String date123 = new SimpleDateFormat("dd-MMM-yyyy")
		        .format(new SimpleDateFormat("yyyy-MM-dd")
		                .parse(insertDate));
	 
	 System.out.println("insertdate!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!:"+insertDate);
	 insertDate=date123;
	
	 }
	 catch(Exception e)
	 {
		 
		 insertDate="-";
	 } 
	 EntryBy=rs1.getString("EntryBy");
	 alternatenumber=rs1.getString("alternatenumber");
	 Assignto=rs1.getString("Assignto");
	 LeadRefNo=rs1.getString("LeadRefNo");
	 product=rs1.getString("product");
	 potentialValue=rs1.getString("potentialValue");
	 noofunits=rs1.getString("noofunits");
 
	 System.out.println("Customer Type=================>:"+custtype);
	 	%>
	
	<tr>
	<td class="text-center"><%=i %></td>
	<td class="text-left"><a href="Editopportunity.jsp?custtype=<%=custtype%>&companyname=<%=cname%>&customercode=<%=customercode%>&category=<%=Category%>&address=<%=Address%>&city=<%=City%>&state=<%=State%>&zip=<%=Zip%>&country1=<%=Country%>
&contactperson=<%=ContactPerson%>&phone=<%=Phone%>&fax=<%=Fax%>&email=<%=Email%>&website=<%=WebSite%>&weeklyoffon=<%=WeeklyOffOn%>&std=<%=STDCode%>&mobile=<%=MobileNo%>&comments=<%=Comments%>&alternateNumber=<%=alternatenumber%>&opportunityname=<%=OpportunityName%>
&assignto=<%=Assignto%>&leadRef=<%=LeadRefNo%>&product=<%=product%>&potentialValue=<%=potentialValue%>&noofunits=<%=noofunits%>&opportunitycount=<%=opportunitycount%>&Opportunitycode=<%=Opportunitycode%>">Edit</a></td>
	<td class="text-left"><%=rs1.getString("companyname") %></td>
	<td class="text-left" ><%=rs1.getString("ContactPerson") %></td>
	<td class="text-left"><%=OpportunityName %></td>
	<td class="text-left"><%=rs1.getString("Address") %></td>
	<td class="text-left"><%=rs1.getString("Assignto") %></td>
	<td class="text-left"><%=rs1.getString("LeadRefNo") %></td>
	<td class="text-left"><%=rs1.getString("City") %></td>
	<td class="text-center"><%=rs1.getString("ResiNo") %></td>
	<td class="text-left"><%=rs1.getString("Email") %></td>
	<td class="text-left"><%=rs1.getString("WebSite") %></td>
	<td class="text-center"><%=MobileNo %></td>
	<td class="text-center"><%=rs1.getString("alternatenumber") %></td>
	<td class="text-left"><%=rs1.getString("Comments") %></td>
	<td class="text-right"><%=insertDate %></td> 
	<td class="text-left"><%=rs1.getString("potentialValue") %></td>
	<td class="text-left"><%=rs1.getString("noofunits") %></td>
	
	</tr>
	

	<% 
	i++;
}
		%>	
		<% 
	}
	else
	{		
		System.out.println("Inside bbutton Press");		
		%>			
<%
System.out.println("new Company code :"+newcodecom);

System.out.println("new Company code :"+companynew);


String query="select custtype,Opportunitycode,Address,opportunitycount,companyname,customercode,City,Zip,State,Country,ContactPerson,Phone,Fax,Email,WebSite,WeeklyOffOn,Category,STDCode,MobileNo,ResiNo,Comments,OpportunityName,insertDate,DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') as UpdatedDate,EntryBy,alternatenumber,Assignto,LeadRefNo,product,potentialValue,noofunits from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where  companyname='"+cname+"'";

System.out.println("Query to get Data:"+query);
ResultSet rs1=st1.executeQuery(query);
int i=1;
while(rs1.next())
{	
	 custtype=rs1.getString("custtype");
	 Opportunitycode=rs1.getString("Opportunitycode");
	 Address=rs1.getString("Address");
	 opportunitycount=rs1.getString("opportunitycount");
	 companyname=rs1.getString("companyname");
	 customercode=rs1.getString("customercode");
	 City=rs1.getString("City");
	 Zip=rs1.getString("Zip");
	 State=rs1.getString("State");
	 Country=rs1.getString("Country");
	 ContactPerson=rs1.getString("ContactPerson");
	 Phone=rs1.getString("Phone");
	 Fax=rs1.getString("Fax");
	 Email=rs1.getString("Email");
	 WebSite=rs1.getString("WebSite");
	 WeeklyOffOn=rs1.getString("WeeklyOffOn");
	 Category=rs1.getString("Category");
	 STDCode=rs1.getString("STDCode");
	 MobileNo=rs1.getString("MobileNo");
	 ResiNo=rs1.getString("ResiNo");
	 Comments=rs1.getString("Comments");
	 OpportunityName=rs1.getString("OpportunityName");
	 
	 try
	 {
	 insertDate=rs1.getString("insertDate");
	 String date123 = new SimpleDateFormat("dd-MMM-yyyy")
		        .format(new SimpleDateFormat("yyyy-MM-dd")
		                .parse(insertDate));
	 
	 System.out.println("insertdate!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!:"+date123);
	 
	 insertDate=date123;
	 
	 }
	 catch(Exception e)
	 {
		 insertDate="-"; 
	 }
	 
	 EntryBy=rs1.getString("EntryBy");
	 alternatenumber=rs1.getString("alternatenumber");
	 Assignto=rs1.getString("Assignto");
	 LeadRefNo=rs1.getString("LeadRefNo");
	 product=rs1.getString("product");
	 potentialValue=rs1.getString("potentialValue");
	 noofunits=rs1.getString("noofunits");

	 
	 String cname1=cname.replace("&", "...");

		if(OpportunityName.equalsIgnoreCase("null")||OpportunityName.equals(""))
		{
			OpportunityName="-";
			
		}
		 System.out.println("OpportunityName is=====:"+OpportunityName);
		 
		 
		 if(MobileNo.equals("null"))
		 {
			 MobileNo="-";
		 }
 
	%>
	
	<tr>
	<td ><%=i %></td>
	<td ><a href="Editopportunity.jsp?custtype=<%=custtype%>&companyname=<%=cname1%>&customercode=<%=customercode%>&category=<%=Category%>&address=<%=Address%>&city=<%=City%>&state=<%=State%>&zip=<%=Zip%>&country1=<%=Country%>
&contactperson=<%=ContactPerson%>&phone=<%=Phone%>&fax=<%=Fax%>&email=<%=Email%>&website=<%=WebSite%>&weeklyoffon=<%=WeeklyOffOn%>&std=<%=STDCode%>&mobile=<%=MobileNo%>&comments=<%=Comments%>&alternateNumber=<%=alternatenumber%>&opportunityname=<%=OpportunityName%>
&assignto=<%=Assignto%>&leadRef=<%=LeadRefNo%>&product=<%=product%>&potentialValue=<%=potentialValue%>&noofunits=<%=noofunits%>&opportunitycount=<%=opportunitycount%>&Opportunitycode=<%=Opportunitycode%>">Edit</a></td>	
	<td class="text-left"><%=rs1.getString("companyname") %></td>
	<td class="text-left" ><%=rs1.getString("ContactPerson") %></td>
	<td class="text-left"><%=OpportunityName %></td>
	<td class="text-left"><%=rs1.getString("Address") %></td>
	<td class="text-left"><%=rs1.getString("Assignto") %></td>
	<td class="text-left"><%=rs1.getString("LeadRefNo") %></td>
	<td class="text-left"><%=rs1.getString("City") %></td>
	<td class="text-center"><%=rs1.getString("ResiNo") %></td>
	<td class="text-left"><%=rs1.getString("Email") %></td>
	<td class="text-left"><%=rs1.getString("WebSite") %></td>	
	<td class="text-center"><%=MobileNo %></td>
	<td class="text-center"><%=rs1.getString("alternatenumber") %></td>
	<td class="text-left"><%=rs1.getString("Comments") %></td>
	<td class="text-right"><%=insertDate %></td> 
	<td class="text-left"><%=rs1.getString("potentialValue") %></td>
	<td class="text-left"><%=rs1.getString("noofunits") %></td>
	
	</tr>
	</tbody>	
	<% 
	i++;
}

%>
<% 
	}%>
		
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
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-7"l><"col-sm-12 col-md-3"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
								title: 'Opportunity Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Opportunity Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Opportunity Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Opportunity Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Opportunity Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
					],
				},
           ], 
       });
   });
</script>

<script type="text/javascript">

function showVisitingCardDetails(companyName,customerCode){
	document.getElementById("companynames").value=companyName;
	
	
	/* alert(customerCode); */
	
	document.getElementById("codecom").value=customerCode;
	document.getElementById("newcom").value=companyName;
		
	document.getElementById("companyList").style.display='none';
}
function hideCompanyName(){
	document.data.companyNames.value='';
}
function getCompanies(type)
{
	document.getElementById("companyList").style.display='block';
	var company=document.getElementById("companynames").value;
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
	var queryString = "?company=" +company+"&type="+type;
	ajaxRequest.open("GET", "GenericAjaxSearch.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}

</script>
<%@ include file="footer.jsp" %>
 </body>
</html>