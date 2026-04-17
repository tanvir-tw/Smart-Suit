 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@ page import="java.util.Date"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
<style>
/* Outer popup size */
#showdocuments {
    width: 350px;       /* popup width */
    max-width: 350px;
    z-index: 1000;
}
.doc-scroll {
    max-height: 200px;   /* vertical scroll */
    max-width: 330px;    /* horizontal scroll */
    overflow-y: auto;
    overflow-x: auto;
    border: 1px solid #999;
}
.sotable {
    border-collapse: collapse;
    width: 100%;
}
.sotable th,
.sotable td {
    border: 1px solid black;   /* THIS is missing */
    padding: 4px;
    white-space: nowrap;
    font-size: 12px;
}

#showdocuments table,
#showdocuments td,
#showdocuments th {
    background-color: transparent !important;
}
.doc-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 8px;
    background-color: #C6DEFF;
    border-bottom: 1px solid #000;
}

.close-btn {
    cursor: pointer;
    color: red;
    font-weight: bold;
}
.visiting-input {
    width: 220px;   /* adjust as needed: 180 / 200 / 220 */
    flex: none;
}
</style>

 <body style="background-color:azure;">
	<%
Connection conn = null;
Connection conn1 = null;
Statement st = null, st1 = null, st3 = null, st4 = null, stconn1 = null,st5 = null,st6 = null;
Statement st2 = null;
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String selectedName;
String FollowUpType="";
String companyName="",phone="",contact="",email="",product="",city="";
String serverid="",usernm="",passwd="";
String monthFirstDate = session.getAttribute("onemonthback").toString(); 
String todaysDate = session.getAttribute("today").toString(); 
String sqlDetails="",companyCode="",openingBalance=null;
double sumDebit=0,sumCredit=0;
%>

<%
try {
	conn = connection.getConnect("db_GlobalERP");    
	conn1 = connection.getConnect("db_CustomerComplaints");  
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
     stconn1 = conn1.createStatement();
	System.out.println("=====62 connection created===");
	if (null == request.getParameter("repName"))
		selectedName = "All";
	else
		selectedName = request.getParameter("repName");
} catch (Exception e) {
    e.printStackTrace();
}


%>
<%
	bt=request.getParameter("button");
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}	
	 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
	 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	 if (!(null == request.getParameter("companyName"))) 
	 {
	 	companyName=request.getParameter("companyName");
	 	phone=request.getParameter("companyPhone");
	 	email=request.getParameter("companyEmail");
	 	contact=request.getParameter("companyPerson");
	 	city=request.getParameter("companyCity");
	 	product=request.getParameter("companyProduct");
	 }	
	 %>	
<%
 try
 {
 %>
 <div class="container-fluid mt-2" id="main">
<form name='ledgerDetails' action="" method="get" >
<br>
<div class="container-fluid">
  <div class="card p-3 shadow-sm" id="visitingCard" style="max-width:900px; margin:auto;">
    <div class="row">
      <!-- Company -->
      <div class="col-md-4 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>Company:</b></label>
        <input type="text" 
               name="companyName"
               id="search-text"
               value="<%=companyName %>"
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
        <input type="hidden" name="customercode" id="customercode" value=""/>
      </div>
      <!-- Contact + SMS -->
      <div class="col-md-4 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>Contact:</b></label>
        <input type="text" 
               name="companyPerson" 
               id="search-text"
               value="<%=contact %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>
     <!-- Phone -->
      <div class="col-md-3 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>Phone:</b></label>
        <input type="text" 
               name="companyPhone"
               id="search-text"
               value="<%=phone %>"
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>
       <div class="col-md-1 d-flex align-items-center mb-2">
        <a href="javascript:void(0)" onclick="newSMSwindow('smsvc.jsp');">
        <img src="images/sms.png" width="28" height="24">
        </a>
       </div>
      <div class="col-md-4 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>E-Mail:</b></label>
        <textarea name="companyEmail"
                  rows="1"
                  id="search-text"
                  readonly
                  class="form-control form-control-sm bg-light border-0 p-0 shadow-none"><%=email %></textarea>
      </div>      
      <!-- Product -->
      <div class="col-md-4 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>Product:</b></label>
        <input type="text" 
               name="companyProduct"
               id="search-text"
               value="<%=product %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>
      <!-- City -->
      <div class="col-md-3 d-flex align-items-start mb-2">
        <label class="me-2" style="width:130px;"><b>City:</b></label>
        <input type="text" 
               name="companyCity"
               id="search-text"
               value="<%=city %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>
      <div class="col-md-1 d-flex align-items-start mb-2">
        <div class="mb-3">
          <a href="javascript:void(0)" onclick="newwindow('emailFollowup.jsp');">
            <img src="images/email.png" width="28" height="24">
          </a>
        </div>      
      </div>
    </div>
  </div>
</div>

<br>
 <div class="row col-12">
		    <div class="col-md-2"></div>
             <div class="col-md-3">
                <label for="input"><b>Company Name</b></label>
                	<div class="input-group input-group-merge" >
                <input class="form-control" type="text" id="companyNames" name="companyNames" onkeyup="getCompanies()" placeholder="Enter Input">
               
			    <div id="companyList"></div>
			 </div>
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


			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
 
 <%
String sqlftp="select * from "+session.getAttribute("CompanyMasterID").toString()+"ftpconnection";
ResultSet rsftp=st.executeQuery(sqlftp);
rsftp.next();
serverid=rsftp.getString("ServerID");
usernm=rsftp.getString("Username");
passwd=rsftp.getString("Password");

int a=0;
					Set<String> tempset = new LinkedHashSet<String>(  );
					
					String sqlCount="select Distinct DocumentName from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+request.getParameter("companyName")+"' and DocumentStatus='Upload'";
					System.out.println(sqlCount);
					ResultSet rscount=st2.executeQuery(sqlCount);
					while(rscount.next())
					{
					
				String delims12= "[,]";
				if(rscount.getString("DocumentName").equalsIgnoreCase("-"))
				{
					
				}
				else
				{
				String[] tok = rscount.getString("DocumentName").split(delims12);
					%>				
					<%
					for (int ij=1;ij<tok.length;ij++)
					{
					System.out.println("=========valll2222==============>>"+tok[ij]);
					tempset.add(tok[ij]);
					%>
					<%	
				     }
					%>
					
					<%
				}
				%>					
					<%}
					Iterator iterconut = tempset.iterator();
					while (iterconut.hasNext()) {
					  String val11=iterconut.next().toString();
					  a++;
					
					%>							
						<%} 

System.out.println("file count=================>"+a);


%>
<div id="count" style=" text-align:left;">
<font size="2"> </font>Uploaded Documents :<a href="#" onclick="popUp()"><%=a%></a>
</div>
<br>

 <div id="showdocuments"
     style="
        position:absolute;
        left:210px;
        top:249px;
        width:350px;
        z-index:1000;
        background-color:rgb(255,255,255);
        border:1px solid #000;
        visibility:hidden;
     ">
    <div class="doc-header">
        <span><b>Uploaded Documents</b></span>
        <span class="close-btn" onclick="cancelentryform()">X</span>
    </div>
    <div class="doc-scroll" style="max-height:200px; overflow-y:auto; overflow-x:auto; padding:5px;">
        <table class="display" style="width:100%; border-collapse:collapse;" border="1">
            <tr>
                <th>Sn.</th>
                <th>FileName</th>
            </tr>
            <%
                int cnt=1;
                Set<String> temp = new LinkedHashSet<String>();
                String comany=request.getParameter("companyName");
                comany=comany.replace("...","&");

                String data="select Distinct DocumentName from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+comany+"' and DocumentStatus='Upload'";
                ResultSet rsdt=st1.executeQuery(data);
                while(rsdt.next()){
                    if(!rsdt.getString("DocumentName").equalsIgnoreCase("-")){
                        String[] tok = rsdt.getString("DocumentName").split("[,]");
                        for(int ij=1; ij<tok.length; ij++){
                            temp.add(tok[ij]);
                        }
                    }
                }

                Iterator iter = temp.iterator();
                while(iter.hasNext()){
                    String val = iter.next().toString();
            %>
            <tr>
                <td><%=cnt++%></td>
                <td>
                    <a href="DocumentsAttached.jsp?documentName=<%=val%>" onclick="window.open(this.href);return false;">
                        <%=val%>
                    </a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

<script>document.getElementById("showdocuments").style.visibility="hidden";</script>
 
 <form id="custwisefollowupreport" name="custwisefollowupreport" method="post" >
<div class="row breadcrumbs-top">		          		                    
		   <h5 class="content-header-title text-center mb-0" style="color: #060637"> FollowUp Report for <%=comany %></h5>
</div>
 <table id="example"  class="display" style="width:100%;">
 
 <thead>
<tr>
	<th class="col-width-4">Sr.No</th>
	<th >Sign</th> 
	<th >Contact Person</th> 
	<th >Follow-Up Date</th>
	<th >Status</th>
	<th >Comments</th>
	<th >Follow-Up Type</th>
	<th >Next Follow Up Date</th>
	<th >Preparation For Next FollowUp</th>
	<th >Payment Follow-Up</th>
	<th >Expected Amount</th>
	<th >Spoken To</th>
	<th>Reply</th>
	<th >Remarks</th>
	<th >File Attached</th>
	</tr>
</thead>
<tbody>
<% 
 					System.out.println("The company name is >>>>>>>>>>>>>>>>>>>>>>:"+comany);
					int i = 1;
					sqlDetails = " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup AS a LEFT OUTER JOIN   "+session.getAttribute("CompanyMasterID").toString()+"security "+
					"  AS b ON ( a.MarketingRepCode = b.EmpCode )			"+
					"where a.ProspCustName='"+comany+"'  and followupdate between '"+dt+"' and "+
					" '"+dt1+"'  and b.ActiveStatus='Yes' ORDER BY  a.followupdate DESC ";
					System.out.println("First Query --------->"+sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) {
						%>
	                     <tr>
						<td class="text-center"> <%=i++ %>  </td>
						<td class="text-left"> <%=rsDetails.getString("b.EmpName") %>  </td>
						<td class="text-left"> <%=rsDetails.getString("ContactPerson") %>  </td>
						
						<td class="text-right"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
									(rsDetails.getString("FollowUpDate")))%>  </td>
						<td class="text-left"> <%=rsDetails.getString("Status") %>  </td>
						<td class="text-left"> <%=rsDetails.getString("Comments") %>  </td>
						<td class="text-left"> <%=rsDetails.getString("FollowUpType") %>  </td>
						<td class="text-right"> <%=new SimpleDateFormat(
																"dd-MMM-yyyy")
																.format(new SimpleDateFormat(
																		"yyyy-MM-dd")
																		.parse(rsDetails
																				.getString("NextFollowUpDate")))%>  </td>
						<td class="text-left"> <%=((rsDetails.getString("Preparation")!=null ) && (rsDetails.getString("Preparation")!="" ) ? rsDetails.getString("Preparation") : "-") %>  </td>
						<td class="text-left"> <%=rsDetails.getString("PaymentFollowup") %>  </td>
						<td class="text-center"> <%=((rsDetails.getString("AmountExpected")!=null ) && (rsDetails.getString("AmountExpected")!="" ) ? rsDetails.getString("AmountExpected") : "-") %>  </td>
						<td class="text-left"> <%=((rsDetails.getString("SpokenTo")!=null ) && (rsDetails.getString("SpokenTo")!="" ) ? rsDetails.getString("SpokenTo") : "-") %>  </td>
						<td  class="text-left"> <%=rsDetails.getString("Reply") %>  </td>
						<td class="text-left"> <%=((rsDetails.getString("Remarks")!=null ) && (rsDetails.getString("Remarks")!="" ) ? rsDetails.getString("Remarks") : "-") %></td>
						<% 
				System.out.println("=======================>>"+rsDetails.getString("DocumentName"));
				String delims12= "[,]";
				if(rsDetails.getString("DocumentName").equalsIgnoreCase("-"))
				{
					%>
					<td class="text-left"><a href="#" ><font size="2"><%=rsDetails.getString("DocumentName")%></font><br></br></a></td>
					<%
				}
				else
				{
				String[] tok = rsDetails.getString("DocumentName").split(delims12);
					%>
					<td class="text-left">
					<%
					for (int ij=1;ij<tok.length;ij++)
					{
					System.out.println("=======================>>"+tok[ij]);
					%>
						<a href="DocumentsAttached.jsp?documentName=<%=tok[ij]%>" onclick="window.open(this.href);return false;"><font size="2"><%=tok[ij]%></font><br></br></a>
					<%						
				     }
					%>
					</td>
					<%
				}
				%>						
	</tr>
						<%
					}
					
%>
</tbody>
</table>
<br>
<br>
 <table id="example1"  style="width:100%;">
 <thead>
 <tr>
 <th class="col-width-4">Sr.No</th>
<th>The Date & Time</th> 
<th>Reciever</th>
<th>Caller</th>
<th>Call Info</th>
<th>Transporter</th>
<th>Call Type</th>
<th>Caller Type</th>
<th>Reason Of Call</th>
<th>Vehicle Tracking</th>
<th>FleetView</th>
<th>Sales Followup</th>
 </tr>
 </thead>
 <tbody>
 
 <% 
		//get the transporter here 
		String trans = "";
		String sqltrans = "select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation where ERPCustName = '"+comany+"'";
		ResultSet rs5 = st5.executeQuery(sqltrans);
		if(rs5.next())
		{
			trans = rs5.getString("Transporter");
		}
	
				int j = 0;
				String sqlDetails1 = " SELECT * FROM db_CustomerComplaints.t_callinformation where Transporter = '"+trans+"' and TheDate between '"+datex1+"' and '"+datex2+"' order by TheDate desc ";
				System.out.println(sqlDetails1);
				ResultSet rsDetails1 = stconn1.executeQuery(sqlDetails1);
				while (rsDetails1.next()) {
					%>
<tr>
					<td class="text-center"><%=++j %></td>
					<td class="text-right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsDetails1.getString("TheDate").trim()+ " "+ rsDetails1.getString("TheTime").trim()))  %></td>
					<td class="text-left"> <%=rsDetails1.getString("Reciever") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("Caller") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("Callinfo") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("Transporter") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("CallType")%> </td>
					<td class="text-left"> <%=rsDetails1.getString("CallerType") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("reasonOfCall") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("vehicleTracking") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("FleetView") %> </td>
					<td class="text-left"> <%=rsDetails1.getString("salesFollowup")%> </td>
					
</tr>
					<%
				}
	
		
%></tbody>
 </table>
 </form>
 
</div>	
 <%
}catch (Exception e) {
	e.printStackTrace();
	System.out.println(e);
	}
	
%>
 <script language="JavaScript1.2">

	function getCompanies()
	{
		document.getElementById('companyList').style.visibility = 'visible';
			var company=document.ledgerDetails.companyNames.value;
			var ajaxRequest;  // The variable that makes Ajax possible!

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
				document.ledgerDetails.companyName.value="";
				document.ledgerDetails.companyEmail.value="";
				document.ledgerDetails.companyPerson.value="";
				document.ledgerDetails.companyCity.value="";
				document.ledgerDetails.companyProduct.value="";
				document.ledgerDetails.companyPhone.value="";
			}
			else
			{
				company=company.replace(".", "");
				company=company.replace(",", "");
				company=company.replace("$", "");
				company=company.replace("#", "");
				company=company.replace("?", "");
				company=company.replace("-", "");
				company=company.replace("_", "");
				company=company.replace(" ", "");
				company=company.replace("(", "");
				company=company.replace(")", "");
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
			var queryString = "?company=" +company;
			ajaxRequest.open("GET", "AjaxGetLedgerCompaniesCustomer.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
		
	}
function sendSMS(){

	var ajaxRequest;  // The variable that makes Ajax possible!
	var company=document.ledgerDetails.companyName.value;
	var contact=document.ledgerDetails.companyPerson.value;
	var phone=document.ledgerDetails.companyPhone.value;
	var email=document.ledgerDetails.companyEmail.value;
	var product=document.ledgerDetails.companyProduct.value;
	var city=document.ledgerDetails.companyCity.value;
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
			alert(reslt);
		}
	}
	var queryString = "?company=" +company+"&contact="+contact+"&phone="+phone+"&email="+email+"&city="+city+"&product="+product;
	ajaxRequest.open("GET", "AjaxSendSMS.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
	
function showVisitingCardDetails(i,j,k,l,m,n)
{
		document.getElementById('visitingCard').style.visibility='visible';
		document.ledgerDetails.companyNames.value='';
		document.getElementById('companyList').style.height = '10px'; 
		document.getElementById('companyList').style.visibility = 'hidden';
		document.ledgerDetails.companyName.value=i;
		document.ledgerDetails.companyEmail.value=j;
		document.ledgerDetails.companyPerson.value=k;
		document.ledgerDetails.companyCity.value=l;
		document.ledgerDetails.companyProduct.value=m;
		document.ledgerDetails.companyPhone.value=n;
		document.getElementById('tabS').style.visibility='hidden';
 
}

function newwindow(webadd)
{ 
    if(document.ledgerDetails.companyName.value=="" || document.ledgerDetails.companyName.value==null) {
        alert("Please select a company ");
    } else {
        window.open(
            webadd
            + '?email=' + document.ledgerDetails.companyEmail.value
            + '&fromDate=' + document.getElementById('data').value
            + '&toDate=' + document.getElementById('data1').value
            + '&company=' + document.ledgerDetails.companyName.value,
            'jav',
            'width=470,height=500,top=250,left=600,resizable=no'
        );
    }
}

function newSMSwindow(weba)
	{ 
		if(document.ledgerDetails.companyName.value=='' || document.ledgerDetails.companyName.value==null)
			alert("Please select a company ");
		else
		window.open(weba+'?companyName='+document.ledgerDetails.companyName.value+'&email='+document.ledgerDetails.companyEmail.value+'&contactPerson='+document.ledgerDetails.companyPerson.value+'&companyPhone='+document.ledgerDetails.companyPhone.value+'&companyProduct='+document.ledgerDetails.companyProduct.value+'&companyCity='+document.ledgerDetails.companyCity.value,'jav','width=470,height=350,top=250,left=600,resizable=no');
	}

	function popUp()
	{
		//alert("IN popup");
		document.getElementById("showdocuments").style.visibility="visible";
	}

	function cancelentryform()
	{
		document.getElementById("showdocuments").style.visibility="hidden";
	}
	

	function getimage(image)
	{
		//alert(image);
		try{
		window.open('getimage.jsp?image='+image+'','mywindow','width=1000,height=750,resizable=no,scrollbars=yes');
		}catch(e)
		{}
	}
	 
	if (document.all || document.getElementById)
		document.body.style.background = " white top no-repeat ";
</script>
<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.custwisefollowupreport.action ="excel.jsp";
          document.forms["custwisefollowupreport"].submit();
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
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script type="text/javascript">
   $(document).ready(function () {
	  $('#example1').DataTable({
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
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'CustomerWise Follow Up Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

 <%@ include file="footer.jsp"%>
</body>
</html>