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
String companyname1=" ",followupdate1=" ",status1=" ",followuptype1=" ",followupsubjects1=" ",comments1=" ",contactperson1=" ",spokento1=" ",collectionstaffname1=" ",remarks1=" ",nextfollowupdate1=" ",nextfollowuptype1=" ",marketingrepname1=" ", opportunityname1=" ";

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dropdownVal="";

// Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null;

try {
	conn = connection.getConnect("db_GlobalERP");   
	st1=conn.createStatement();
    st2 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
String name=request.getParameter("companyNames");
int i=1;
if(name=="" || name==" " || name==null)
{
	name="All";
}

name=name.replace("...","&");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;

	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}
 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));

%>
 
 
 <div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Follow-up Summary Report</h5>
    </div>
</div>
<br>
<form name="data" action="" >
   <div class="row col-12">
	<div class="col-md-2"></div>	      
   
   <div class="col-md-3">
                <label for="input"><b>Company Name</b></label>
                  <input class="form-control form-control-sm" type="text"  name="companyNames" id="companyNames" value="<%=name %>" autocomplete="off" value="" placeholder="Enter Input" onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies('quotation'); }">
			  
			   <div id="companyList"></div>

		</div>
		
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
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value),getfollowup();">
			</div>
  
  			  
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

<div id='tempList' align="center" style="display: none;">						
</div>

<table id="example"  class="display">
        <thead>
					<tr>
						<th>SrNo</th>
						<th>Company Name</th>
						<th>FollowUpDate</th>
						<th>Status</th>
						<th>FollowUpType</th>
						<th>FollowUpSubject</th>
						<th>Comments</th>
						<th>ContactPerson</th>
						<th>SpokenTo</th>
						<th>CollectionStaffName</th>
						<th>Remarks</th>
						<th>NextFollowUpDate</th>
						<th>NextFollowUpType</th>
						<th>MarketingRepName</th>
						<th>OpportunityName</th>

					</tr>

				</thead>
        <tbody>
	<%
      	String companyname2 = request.getParameter("companyNames");

      	System.out.println("-------------------------------->" + companyname2);
      	if (companyname2 == null) {
      		companyname2 = "All";
      	}
      	%>
    
    <script>
    document.getElementById("companyNames").value='<%out.print(companyname2); %>'; 
    </script>
    <%
    if(companyname2.equals("All"))
	 {
    	companyname2="%%";
	 }
	
	String data="";

	 if(dt==null)
     { 
   	   data = "select a.opportunityname,a.ProspCustName,date_format(a.FollowUpDate,'%d-%b-%Y') as FollowUpDate, a.Status, a.FollowUpType, a.FollowUpSubject, a.Comments, a.ContactPerson, a.SpokenTo, a.ColloectionStaffName, a.Remarks,date_format(a.NextFollowUpDate,'%d-%b-%Y') as NextFollowUpDate, a.NextFollowUpType, b.MarketingRepName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup as a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster as b on b.MarketingRepCode=a.MarketingRepcode where a.FollowUpDate between '"+dt+"' and '"+dt1+"'  and a.ProspCustName like '"+companyname2+"'";

   	  }
	 else
   	  {
      	   data = "select a.opportunityname,a.ProspCustName,date_format(a.FollowUpDate,'%d-%b-%Y') as FollowUpDate, a.Status, a.FollowUpType, a.FollowUpSubject, a.Comments, a.ContactPerson, a.SpokenTo, a.ColloectionStaffName, a.Remarks,date_format(a.NextFollowUpDate,'%d-%b-%Y') as NextFollowUpDate, a.NextFollowUpType, b.MarketingRepName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup as a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster as b on b.MarketingRepCode=a.MarketingRepcode where a.FollowUpDate between '"+dt+"' and '"+dt1+"'  and a.ProspCustName like '"+companyname2+"'";
   		  }

	System.out.println("check-------->"+data);
	
	ResultSet rs21=st1.executeQuery(data);
	while(rs21.next())
	{
	try{
		
		companyname1=rs21.getString("a.ProspCustName");
		followupdate1=rs21.getString("FollowUpDate");
		status1=rs21.getString("a.Status");
		followuptype1=rs21.getString("a.FollowUpType");
		followupsubjects1=rs21.getString("a.FollowUpSubject");
		comments1=rs21.getString("a.Comments");
		contactperson1=rs21.getString("a.ContactPerson");
		spokento1=rs21.getString("a.SpokenTo");
		collectionstaffname1=rs21.getString("a.ColloectionStaffName");
		remarks1=rs21.getString("a.Remarks");
		nextfollowupdate1=rs21.getString("NextFollowUpDate");
		nextfollowuptype1=rs21.getString("a.NextFollowUpType");
		marketingrepname1=rs21.getString("b.MarketingRepName");
		opportunityname1=rs21.getString("a.opportunityname");

		System.out.println("followupdate is =======>" + followupdate1);
	%>
	
	<tr>		          
	 <td class="text-center"><%=i%></td>
	<td class="text-left"><%=companyname1%></td>
	<td class="text-right"><%=followupdate1%></td>
	<td class="text-left"><%=status1%></td>
	<td class="text-left"><%=followuptype1%></td>
	<td class="text-left"><%=followupsubjects1%></td>
	<td class="text-left"><%=comments1%></td>
	<td class="text-left"><%=contactperson1%></td>
	<td class="text-left"><%=spokento1%></td>
	<td class="text-left"><%=collectionstaffname1%></td>
	<td class="text-left"><%=remarks1%></td>
	<td class="text-left"><%=nextfollowupdate1%></td>
    <td class="text-left"><%=nextfollowuptype1%></td>
    <td class="text-left"><%=marketingrepname1%></td>
    <td class="text-left"><%=opportunityname1%></td>
             
            </tr>
            
   <%
i++;

	
%>  
    
   <%
	}catch (Exception e) {
	e.printStackTrace();
} 
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
			document.getElementById("companyinfoid").style.height = '80px';
			
			
			
		} 
	}
	var queryString = "?company=" +company+"&type="+type+"&limitcount=20";
	ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
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
	document.getElementById("companyList").style.height='0px';
	document.getElementById("companyinfoid").style.height = ' ';
	
	
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
			document.getElementById("companyList").style.height=' ';
			document.getElementById("companyinfoid").style.height = ' ';
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
	}
		document.getElementById("footer").style.display="none";
return true;
	
	}

else
	{
		return false;
	}

}
 
</script>
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
								title: 'Follow Up Master Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Follow Up Master Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item', 
								title: 'Follow Up Master Report '+$("#data").val()+  'to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Follow Up Master Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Follow Up Master Report'+$("#data").val()+ ' to ' +$("#data1").val(),
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