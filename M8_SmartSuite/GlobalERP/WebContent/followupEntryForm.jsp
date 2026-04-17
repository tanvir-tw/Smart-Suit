<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
<script src="dropdown.js" type="text/javascript"></script>
<script src="ledgerDetails.js" type="text/javascript"></script>
</head>
 <body style="background-color:azure;">
<%!Connection con;%>
<%
Connection con = null;
Statement st1 = null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;

try {
	con = connection.getConnect("db_GlobalERP");        
     st1=con.createStatement();
     stmt1 = con.createStatement();
     stmt2 = con.createStatement();
     stmt3 = con.createStatement();
     stmt4 = con.createStatement();
     stmt5 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 
%>

<%
String customercode1=request.getParameter("customercode");
%>

<%  
String t="",p="",e="",company="",cc="",cm="",comc="",conp="",city="";
t=request.getParameter("type");
p=request.getParameter("phone");
e=request.getParameter("email");
company=request.getParameter("Company");
cc=request.getParameter("companycode");
conp=request.getParameter("companyContactPerson");
city=request.getParameter("companyCity");

%>
<input type="hidden" name="type111" id="type111" value="<%=t%>">
<input type="hidden" name="phone111" id="phone111" value="<%=p%>">
<input type="hidden" name="email111" id="email111" value="<%=e%>">
<input type="hidden" name="company111" id="company111" value="<%=company%>">
<input type="hidden" name="companycode111" id="companycode111" value="<%=cc%>">
<input type="hidden" name="contactperson111" id="contactperson111" value="<%=conp%>">
<input type="hidden" name="city111" id="city111" value="<%=city%>">

<%

	String custCode = "";
    String fromDateCal = "",toDateCal = "";
    Date d = new Date();
	Format df1 = new SimpleDateFormat("yyyy-MM-dd");
	String dtoday = df1.format(d);
	DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1 = new SimpleDateFormat("yyyy-MM-dd");
	Format d2 = new SimpleDateFormat("HH:mm:ss");
	String incdReg = d2.format(d);
	String hrTime = incdReg.substring(0, 2);
	String minTime = incdReg.substring(3, 5);
	System.out.println(">>>>>>>>>>>>dtoday:" + dtoday);
	
	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
	
    String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
    Date tdy = new Date();
	Date tomorrow = new Date();
	Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	cal.setTime(tdy);
	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
	cal.add(Calendar.DAY_OF_MONTH, -1);
	Date YesterdaysDateAsDate = cal.getTime();
	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);
	
	Date today = new Date();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -10);
	Date  datebeforefourdays=cal.getTime();
	String dateFrBack=new SimpleDateFormat("yyyy-MM-dd").format(datebeforefourdays);
	String dateFrBackInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(datebeforefourdays);
	
	
	System.out.println(dateFrBackInMMM+"())))))))))))))))))))))  ");
	
	String msg=request.getParameter("msg");
	System.out.println("msg number is >>>> " +msg);

	if(msg !=null)
	{
	
	}
		%>    
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Follow-up For - <%=company %></h5>
		    		</div>
		             <br>				
<form action="addFollowUp.jsp" name="addFolloUp" method="post" enctype="multipart/form-data" onsubmit="return validate(); ">
          <input type="hidden" name="yesterday" id="yesterday" value="<%=yesterdaysDate%>">
          <input type="hidden" name="threedaysbk" id="threedaysbk" value="<%=dateFrBackInMMM %>">
          <input type="hidden" name="cpdate" id="cpdate" value="<%=fromDateCal%>">
          <input type="hidden" name="spokenPerson" id="spokenPerson" value="">
         
<%  
String company1 = "";
if(request.getParameter("Company") == null || request.getParameter("Company").equals(""))
{
	System.out.println("*******prosp***********---------jjjjjjkkkll*******"+request.getParameter("Prospect"));
	company = request.getParameter("Prospect");
    company=company.replace("...","&");
	
}
else
{
	System.out.println("*******cust******************"+request.getParameter("Company"));
    company = request.getParameter("Company"); 
    company=company.replace("...","&");
}

String s1="";
String checkSQL = "select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName ='" + company + "' and SalesCustomerCode != 0 limit 1";
ResultSet rs = stmt1.executeQuery(checkSQL);
System.out.println(checkSQL);
if(rs.next())
{
	System.out.println("IN IFFF  ");
	custCode = rs.getString("CustomerCode");
	System.out.println("*******cust******************"+custCode);
	s1=" ";
}
else
{
	String checkSQL1 = "select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName ='" + company + "' and 	SalesCustomerCode = 0 limit 1";
	ResultSet rs1 = stmt2.executeQuery(checkSQL1);
	if(rs1.next())
	{
		System.out.println("IN ELSE ELSE   ");
		custCode = rs1.getString("CustomerCode");
		System.out.println("*************prosp************"+custCode);
	}
}
String sqldata = "select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode  ='" + custCode + "' and CompanyName= '"+company+"' limit 1";
System.out.println(sqldata);
ResultSet rsdata = stmt1.executeQuery(sqldata);
System.out.println(sqldata);
  if(rsdata.next())
   {  
	   %>
	   	    <input type="hidden" name="Code" id="Code" value="<%=rsdata.getString("CustomerCode")%>">
			<input type="hidden" name="city" id="city" value="<%=rsdata.getString("City")%>">
			<input type="hidden" name="contactperson" id="contactperson" value="<%=rsdata.getString("ContactPerson")%>">
			<input type="hidden" name="Name" id="Name" value="<%=company%>">
	   <%
	   
   }
   else
   {
       if( request.getParameter("Prospect")==null ||  request.getParameter("Prospect").equals("") || request.getParameter("Prospect").equals("null") || request.getParameter("Prospect").contains("null"))
        {
          %>
			<input type="hidden" name="Code" id="Code" value="<%=request.getParameter("companycode")%>">
			<input type="hidden" name="Name" id="Name" value="<%=request.getParameter("company")%>">
			<input type="hidden" name="city" id="city" value="<%=request.getParameter("companyCity")%>">
			<input type="hidden" name="contactperson" id="contactperson" value="<%=request.getParameter("companyContactPerson")%>">
          <%
        }
       else
       {
    	   System.out.println("EEEEEEEEEEEEEEEEELLLLLLLLLLLSSSSSSSSSSSSEEEEEEEee");
    	  %>
			<input type="hidden" name="Code" id="Code" value="<%=request.getParameter("customercode")%>">
			<input type="hidden" name="Name" id="Name" value="<%=request.getParameter("Prospect")%>">
			<input type="hidden" name="city" id="city" value="<%=request.getParameter("customerCity")%>">
			<input type="hidden" name="contactperson" id="contactperson" value="<%=request.getParameter("customerContactPerson")%>">
			<input type="hidden" name="followuptime" value="<%=todaysTime%>"/>	
    	  <%   
       }
   }

      %>   
      
 <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">   
      <div class="row col-12 mt-3">
        <div class="col-4 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="fromdate" name="fromdate" value="<%=fromDateCal%>" placeholder="" required>
                <label for="policy_end" class="floating-label">Follow Up Date/Time</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "fromdate", // ID of the input fieldom
							ifFormat : "%d-%b-%Y %H:%M", // the date format
							button : "fromdate",
							showsTime	: "true" 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
        <div class="col-4 mt-2">
                <div class="input-container">
			    <label class="form-label d-block">Follow Up IN/OUT</label>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="in" name="inorout" value="in">
			        <label class="form-check-label" for="in">IN</label>
			    </div>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="out" name="inorout" value="out" checked>
			        <label class="form-check-label" for="out">OUT</label>
			    </div>
			</div>
        </div>
        <div class="col-4">
           <div class="input-container">
          	<label for="PI_source" class="tcolor">Status</label>
            <select class="form-select" id="followUpStatus" name="followUpStatus" required>
            	<option value="Select">Select</option>
            	<option value='Demo'>Demo</option>
				<option value='Expansion'>Expansion</option>
				<option value='Firm RFQ'>Firm RFQ</option>
				<option value='Final Negotiation'>Final Negotiation</option>
				<option value='Lost Order'>Lost Order</option>
				<option value='Offer'>Offer</option>
				<option value='Prospect'>Prospect</option>
				<option value='Qualified Prospect'>Qualified Prospect</option>
            </select>
          </div>
        </div>
      </div>   
      <div class="row col-12 mt-3">
        <div class="col-4">
          <div class="input-container">
          	<label for="PI_source" class="tcolor">Follow Up Type</label>
            <select class="form-select" id="followUpType" name="followUpType" required>
            			<option value="Select">Select</option>
						<option value="ActionPoints">Action Points</option>
						<option value="E-mail">E-mail</option>
						<option value="Letter">Letter</option>
						<option value="Meeting">Meeting</option>
						<option value="phoneCall">Phone Call</option>
						<option value="Visit">Visit</option>
            </select>
          </div>
        </div>
         <div class="col-4">
           <div class="input-container">
	          	<label for="PI_source" class="tcolor">Collection Staff</label>
	            <select class="form-select" id="refreshthis" name="CollectionStaff" required>
           	 	<option value="Select">Select</option>
				<% String sqlDropdownCS="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where status='Active' order by name asc";
				  ResultSet rsDropdownCS=stmt3.executeQuery(sqlDropdownCS);
				  while(rsDropdownCS.next()){
				  %>
				  <option value="<%=rsDropdownCS.getString(1)%>">
				  <%=rsDropdownCS.getString(1)%></option>
							
					<% 	}%></select>
          </div>
        </div>
        
        <div class="col-4">
           <div class="input-container">
	          	<label for="PI_source" class="tcolor">Confidence Level</label>
	            <select class="form-select" id="confidencelevel" name="confidencelevel" required>
           	 		<option value="Select">Select</option>
					<option value='25%'>25%</option>
				  	<option value='50%'>50%</option>
				  	<option value='75%'>75%</option>
				    <option value='100%'>100%</option>	
				</select>
          </div>
        </div>
      </div>
    <div class="row col-12 mt-3">
        <div class="col-3" id="refreshthis1">
          <div class="input-container">
          	<label for="PI_source" class="tcolor">Spoken To</label>
            <select class="form-select" name="spokento" id="spokento" onclick="re(0)" required>
            			<%
String sql1="";
String custtype = request.getParameter("type");
	if( custtype.equals("Customer"))
{
   sql1="SELECT DISTINCT(contactperson) from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode="+request.getParameter("customercode")+" AND mobileno <> 'null'  order by firstname,middlename,lastname";				
}
else
{
	sql1="SELECT DISTINCT(contactperson) from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode="+request.getParameter("customercode")+" AND mobileno <> 'null' order by firstname,middlename,lastname";				
}
ResultSet rs_st=stmt5.executeQuery(sql1);
while(rs_st.next()){
	%>
	<option value="<%=rs_st.getString("contactperson") %>"><%=rs_st.getString("contactperson") %></option>
	<%
}
%>
	</select>
            
          </div>
          <span id="wait" style="display: none;"><font color="red">Please Wait...</font> </span>
        </div>
         <div class="col-2 mt-4">
        	  <div class="input-container">
        <a href="#" onclick="addCon(1)" style="text-decoration: none;"> Add Contact</a>
        </div>
        </div>
        
        <div class="col-3 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input" id="comments" name="comments" rows="1"></textarea>
           <label for="comments" class="floating-label">Comments</label>
        	</div>
      </div>
        
          <div class="col-4 mt-2">
        	  <div class="input-container">
           		<label for="PI_source" class="tcolor">Opportunity Name</label>
            		<select class="form-select" name="opponame" id="opponame">
            		<% String sqlDropdownCS1="SELECT OpportunityName  FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where origcustorsalescode="+customercode1+" ";
				  ResultSet rsDropdownCS1=stmt4.executeQuery(sqlDropdownCS1);
				  while(rsDropdownCS1.next()){
				  %>
				  <option value="<%=rsDropdownCS1.getString(1)%>">
				  <%=rsDropdownCS1.getString(1)%></option>
							
					<% 	}%></select>
          </div>
      </div>
     </div>
      
</div>      
</div>                   

 <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row" >
    	  <div class="row col-12 mt-3">
        	<div class="col-4 mt-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="todate" name="todate"  value="<%=fromDateCal%>" placeholder="" onchange="getvalid();" required>
                <label for="Temporary_addr1" class="floating-label">Next Follow Up &nbsp;&nbsp;Date/Time</label>
                <script type="text/javascript">
					Calendar.setup( {
							inputField : "todate", // ID of the input field
							ifFormat : "%d-%b-%Y %H:%M", // the date format
							button : "todate",
							showsTime	: "true" 
									});
				</script>					
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
           			<label for="PI_source" class="tcolor">Next Follow Up Type</label>
            		<select class="form-select" name="nextfollowUpType" id="nextfollowUpType" required>
            			<option value="Select">Select</option>
						<option value="ActionPoints">Action Points</option>
						<option value="E-mail">E-mail</option>
						<option value="Letter">Letter</option>
						<option value="Meeting">Meeting</option>
						<option value="phoneCall">Phone Call</option>
						<option value="Visit">Visit</option>
            		</select>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
           			<label for="PI_source" class="tcolor">Collection Staff</label>
            		<select class="form-select" name="NxtCollectionStaff" id="NxtCollectionStaff" required>
            		<option value="Select">Select</option>
					<% String nxtsqlDropdownCS="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where status='Active' order by name asc";
					  ResultSet nxtrsDropdownCS=stmt3.executeQuery(nxtsqlDropdownCS);
					  while(nxtrsDropdownCS.next()){
					  %>
					  <option value="<%=nxtrsDropdownCS.getString(1)%>">
					  <%=nxtrsDropdownCS.getString(1)%></option>
							
					<% 	}%></select>
            </div>
        </div>     
    </div>
    
     <div class="row col-12 mt-3">
        	<div class="col-4">
            <div class="input-container">
            <label for="assignedwith" class="tcolor">Assigned To</label>
            <select class="form-select" name="assignedwith" id="assignedwith" required>
            	<option value="Select">Select</option>
            	 <% String sqlrep="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepCode in (select EmpCode from "+session.getAttribute("CompanyMasterID").toString()+"security where ActiveStatus='Yes') AND  username<>'' AND password<>'' group by MarketingRepName";
					ResultSet rsRep=stmt1.executeQuery(sqlrep);
						while(rsRep.next())
						{%>
						<option value="<%=rsRep.getString(1) %>"><%=rsRep.getString("MarketingRepName") %></option>
						<%}%>
            	</select>
            </div>
            </div>
            
            <div class="col-md-2">
		    <label class="form-label fw-bold d-block">Payment Follow Up</label>
		    <div class="form-check">
		        <input class="form-check-input" type="checkbox" name="paymentFollowUp" id="paymentFollowUp" onclick="showrow();">
    		</div>
			</div>
			
			<div class="col-md-2">
		    <label class="form-label fw-bold d-block">Reply</label>
		    <div class="form-check">
		        <input class="form-check-input" type="checkbox" name="reply" id="reply">
    		</div>
			</div>
			<div class="col-4 mt-4">
	          <div class="input-container">
	          <textarea class="form-control floating-input" id="preparation" name="preparation" rows="1"></textarea>
	           <label for="reason" class="floating-label">Preparation for next Follow Up</label>
        	</div>
        	</div>
      </div>
      
     <div class="row col-12 mt-3" style="display: none;" id="showpay">
        	<div class="col-4">
	          <div class="input-container">
	          <textarea class="form-control floating-input" id="expectedamnt" name="expectedamnt" rows="1"></textarea>
	           <label for="reason" class="floating-label">Amnt Expctd</label>
        	</div>
        	</div>
            <div class="col-4 mt-4">
        	<div class="input-container">
       		<input class="form-control floating-input" type="text" id="expectedon" name="expectedon" placeholder="" readonly>
          	<label for="fromdate" class="floating-label">Amnt Expectd On</label>
          <script type="text/javascript">
						Calendar.setup( {
							inputField : "expectedon", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "expectedon" // ID of the button
						});
		      </script>
        </div>
    </div>
    </div>
    
    <div class="row col-12 mt-4">
        	
    		<div class="col-4">
	          <div class="input-container">
	          <textarea class="form-control floating-input" id="remarks" name="remarks" rows="1"></textarea>
	           <label for="reason" class="floating-label">Remarks</label>
        	</div>
        	</div>
        	<div class="col-md-6 text-center">

   <!--  <h6 class="fw-bold">Upload Document</h6> -->

    <a href="#" class="fw-bold" onclick="showFileUpload()">Attach File</a>

    <div class="small text-muted">
        (You can attach files with type selection.)
    </div>
</div>
    </div>


<div class="row col-12 mt-3">
    <div id="fileUploadBox" style="display:none; margin-top:12px;">
        <div id="fileInputs">

            <!-- FIRST ROW -->
            <div class="row mb-2 align-items-center" id="fileGroup0">

                <!-- TYPE SELECT -->
                <div class="col-5">
                    <select class="form-select" name="documentType0">
                        <option value="">Select Type</option>
                        <option value="contactcard">Contact Card</option>
                        <option value="commercial">Commercial</option>
                        <option value="legal">Legal</option>
                        <option value="meeting">Meeting</option>
                        <option value="notes">Notes</option>
                    </select>
                </div>

                <!-- FILE -->
                <div class="col-5">
                    <input type="file" class="form-control" name="Filename1" onchange="handleUpload(0)">
                </div>

                <!-- BUTTONS -->
                <div class="col-2 d-flex">
                    <button type="button" class="btn btn-danger btn-sm me-1" onclick="removeFileInput(0)">−</button>
                    <button type="button" class="btn btn-success btn-sm" onclick="addFileInput()">+</button>
                </div>

            </div>

        </div>
    </div>

</div>
</div>					
<input type="hidden" name="SelectedEmpMail"	id="SelectedEmpMail" value="" />
<div class="row col-12">
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="EmpNames" name="EmpNames"  placeholder="" onkeyup="if (event.keyCode == 27){document.getElementById('EmpList').style.display = 'none';} else { getEmp(<%=1 %>); }">
          		<label for="companyNames" class="floating-label">Special Email To</label>
        </div>
        
        	<div style="position: absolute;"><table> <tr> <td></td> </tr> <tr> <td> <div id='EmpList'></div> </td> </tr> </table> </div>
	</div>

					<div class="col-1 mt-4" id="A30">
						<div id="client">
						<a href="#/" style="font-weight: bold; color: blue; " onclick="getClient1('+')">
						<font size="3" >(+)</font>
						</a>
						
						<a href="#/" style="font-weight: bold; color: blue; " onclick="getClient1('-')"><font size="3" ></font>
						</a> 
						
						</div>
						</div>
			
			 <div class="col-3 mt-4" id="otherclient" style="display: none">
			 <div class="input-container">
					<input class="form-control floating-input" type="text" name="EmpNames1" id="EmpNames1" class="input"  onkeyup="if (event.keyCode == 27){document.getElementById('EmpList1').style.display = 'none';} else { getEmp('<%=2 %>'); }"> 
					<input type="hidden" name="SelectedEmpMail1" id="SelectedEmpMail1" value="" /> 
					</div>
		<div style="position: absolute;">
 			<table><tr><td><div id='EmpList1'></div></td></tr></table></div>
 		</div>			
						
		<div class="col-1 mt-4" id="A31">

<div id="client1" style="display: none">

<a href="#/" style="font-weight: bold; color: blue; " onclick="getClient2('+')"><font size="3" >(+)</font></a>

<a href="#/" style="font-weight: bold; color: blue; " onclick="getClient2('-')"><font size="3" >(-)</font></a></div>

</div>

<div class="col-3 mt-4" id="A27">
		<div id="otherclient1" style="display: none">
		<input class="form-control floating-input" type="text" name="EmpNames2" id="EmpNames2"  onkeyup="if (event.keyCode == 27){document.getElementById('EmpList2').style.display = 'none';} else { getEmp('<%=3 %>'); }" > 
		<input type="hidden" name="SelectedEmpMail2" id="SelectedEmpMail2" value="" />
		</div>
		<div> 
<div style="position: absolute;">
<table><tr><td><div id='EmpList2'></div></td></tr></table></div>
</div>
	</div>
	
<div class="col-1 mt-4" id="A50">
<div id="client2" style="display: none"><a href="#/" style="font-weight: bold; color: blue; " onclick="getClient3('-')"><font size="3" >(-)</font></a></div>
</div>
</div>
<div class="row col-12">


  <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="OEmail" name="OEmail" placeholder="" >
          		<label for="companyNames" class="floating-label">Other Email To</label>
        	</div>  
      </div>

<div class="col-md-4 mt-4" >
   
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="MeetingReq" id="MeetingReq" >
         <label class="form-label fw-bold d-block">Send Meeting Request </label>
    </div>
    </div>		
</div>
        


 <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit" id="search-submit" name="submitFollowUp">Submit</button>
    </div>
</div>
</div>
</form>
</div>
</div>
</div>
</div>
</section>
</div>
</div>


<script type="text/javascript">
window.onload = function()
{
        getSpokenTo();
};
function getSpokenTo()
{
		//var company=document.getElementById("Name").value;
		var company=document.addFolloUp.Name.value;
		//alert(company);
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
				
				document.addFolloUp.spokento.value=reslt.trim();
			//	document.getElementById("spokento").innerHTML=aa;
			} 
		}
		    //alert(company);
			queryString = "?company=" +company+"";
			ajaxRequest.open("GET", "getSpokenTo.jsp" + queryString, true);
			ajaxRequest.send(null); 
}	



function getClient1(id)
{
   //alert("in get"+id);
    if(id=="+")
    {//alert("123")
	  document.getElementById("otherclient").style.display="";
	  document.getElementById("client").style.display='none';
	 document.getElementById("client1").style.display="";
    }
    else
    {
    	document.getElementById("EmpNames").value=""; 
    }
}
function getClient2(id)
{// alert("in2 get"+id);
	if(id=="+")
    {
	document.getElementById("otherclient1").style.display="";
	document.getElementById("client1").style.display='none';
	document.getElementById("client2").style.display="";
	document.getElementById("A50").style.display="";
	
    }
	else
    {
		document.getElementById("EmpNames1").value=""; 
    	document.getElementById("otherclient").style.display='none';
    	document.getElementById("client").style.display="";
    	document.getElementById("client1").style.display='none';
    	document.getElementById("A50").style.display='none';
    	
    }
	
}

function getClient3(id)
{
	    document.getElementById("EmpNames2").value=""; 
    	document.getElementById("otherclient1").style.display='none';
    	document.getElementById("otherclient").style.display='';
    	document.getElementById("client1").style.display="";
    	
    	document.getElementById("client2").style.display="none";
    	document.getElementById("client3").style.display='none';
}




function showrow()
{
	try{
	//alert(document.getElementById("inorout").value);
	var show1=document.getElementById("paymentFollowUp");
	
	if(show1.checked==true ){
		document.getElementById("showpay").style.display = "";
		}
		
	else{
		document.getElementById("showpay").style.display = "none";
	}
}catch (e) {
	alert(e);
}
	}

function getEmp(id)
	{	
	 if(id==1)
    {
		document.getElementById("EmpList").style.display='block';
		var emp=document.getElementById("EmpNames").value;
    }
	 if(id==2)
	    {
		 document.getElementById("EmpList1").style.display='block';
			var emp=document.getElementById("EmpNames1").value;

	    }

	 if(id==3)
	    {
		 	document.getElementById("EmpList2").style.display='block';
			var emp=document.getElementById("EmpNames2").value;
	    }


	 if(emp=="")
	 {
		 document.getElementById("EmpList").style.display='none';
		 document.getElementById("EmpList1").style.display='none';
		 document.getElementById("EmpList2").style.display='none';
	 }
	 else
	 {
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
//alert("Result is "+reslt);
				if(id==1)
				{
				document.getElementById("EmpList").innerHTML=reslt;
				
				}

				if(id==2)
				{
				document.getElementById("EmpList1").innerHTML=reslt;
				}
				if(id==3)
				{
				document.getElementById("EmpList2").innerHTML=reslt;
				}
			} 
		}
		var queryString = "?emp="+emp+"&id="+id;
		//alert(""+queryString);
		ajaxRequest.open("GET", "GenericAjaxSearchME.jsp" + queryString, true);
		ajaxRequest.send(null); 
	 }//end of else
	}



function showVisitingCardDetails(eName,empMail,id)
{
	//alert("eName"+eName);
	//alert("empMail"+empMail);
	//alert("id jnjk"+id);
	
	if(id==1)
	{
	document.getElementById("EmpNames").value=empMail;
	document.getElementById("SelectedEmpMail").value=empMail;
	document.getElementById("EmpList").style.display='none';
	}
	if(id==2)
	{
	document.getElementById("EmpNames1").value=empMail;
	document.getElementById("SelectedEmpMail1").value=empMail;
	document.getElementById("EmpList1").style.display='none';
	}
	if(id==3)
	{
	document.getElementById("EmpNames2").value=empMail;
	document.getElementById("SelectedEmpMail2").value=empMail;
	document.getElementById("EmpList2").style.display='none';
	}
}

function getvalid()
{
//alert("hi");

	var fromdate=document.addFolloUp.fromdate.value;
	var threedaysbk = document.addFolloUp.threedaysbk.value;
	var fdate=document.addFolloUp.cpdate.value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;



	
	dd11=fromdate.substring(0,2);
	dd22=threedaysbk.substring(0,2);
	
	
	mm1=fromdate.substring(3,6);
	mm2=threedaysbk.substring(3,6);
	
	
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	
	

	yy11=fromdate.substring(7,11);
	yy22=threedaysbk.substring(7,11);

	

	if(yy11 < yy22)
	{
		alert("Follow-Up is not allowed for this date");
		
		document.addFolloUp.fromdate.value=fdate;
		return false;
	}
	
	else if(yy11==yy22)
	{
		
			
		if(mm11<mm22)
		{
			alert("Follow-Up is not allowed for this date");
			
			document.addFolloUp.fromdate.value=fdate;			
			return false;
		}
			else if(mm11==mm22)

			{
				
				//alert("hi");
				if(dd11<dd22)
				{
					alert("Follow-Up is not allowed for this date");
					
					document.addFolloUp.fromdate.value=fdate;
										
					return false;
				}
				
			}
	}	
}


function validate()
{
	//alert("Hi***");
	var tt=document.addFolloUp.inorout.value;
	var cmt=document.addFolloUp.comments.value;
	
	var oth=cmt.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var contactPerson=document.addFolloUp.spokento.value;
	var amt=document.addFolloUp.expectedamnt.value;
	//alert(tt);
	 var invalid=/[^A-Za-z.,\s]/;
	var followtype=document.addFolloUp.followUpType.value;
	var spoken=document.addFolloUp.spokento.value;
	var followstats=document.addFolloUp.followUpStatus.value;
	var collectstaff=document.addFolloUp.CollectionStaff.value;
	var othspoken=spoken.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var assigneval=document.addFolloUp.assignedwith.value;
	var nxtcllectstaff=document.addFolloUp.NxtCollectionStaff.value;
	var nextfollowtype=document.addFolloUp.nextfollowUpType.value;
	
	if(followstats=="Select")
	{
		alert("Please Select follow up Status" );
		return false;		
	}
	
	if(followtype=="Select")
	{
		alert("Please select follow up type" );
		return false;
	}
		
	 if(collectstaff=="Select")
	{
		alert("Please Select Collection Staff" );
		return false;
	} 
	
	if(spoken=="" || othspoken=="")
	{
		alert("Please enter spoken to" );
		return false;
	}
	
	if(document.addFolloUp.comments.value=='' || oth=="")
	{
		alert("Please Enter Comments" );
		return false;
	}
	
	
	if(invalid.test(contactPerson)){
	    alert('Please enter characters value for spokan to..');  
	    return false;
	}
	
	if(nextfollowtype=="Select")
	{
	alert("Please Select Next Follow Up Type" );
	return false;
	
	}
	
	if(nxtcllectstaff=="Select")
	{
		alert("Please Select Collection Staff For Next Follow Up" );
		return false;
	} 
	
	if(assigneval=="Select")
	{
		alert("Please Select Assign To" );
		return false;
	}
	
var fromdate=document.addFolloUp.fromdate.value;
var todate=document.addFolloUp.todate.value;
var dm1,dd1,dy1,dm2,dd2,dy2;
var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

dd11=todate.substring(0,2);
dd22=fromdate.substring(0,2);


mm1=todate.substring(3,6);
mm2=fromdate.substring(3,6);


mm11=dateformat(mm1);
mm22=dateformat(mm2);

yy11=todate.substring(7,11);
yy22=fromdate.substring(7,11);

var	h1=fromdate.substring(12,14);
var	m1=fromdate.substring(15,17);

var	hrs=todate.substring(12,14);
var	mins=todate.substring(15,17);



if(yy11 < yy22)
{
	alert("Selected Next Follow Up Date should be greater than Follow Up Date");
	
	return false;
}

else if(yy11==yy22)
{
	
		
	if(mm11<mm22)
	{
		alert("Selected Next Follow Up Date should be greater than Follow Up Date");
		
		return false;
	}
		else if(mm11==mm22)

		{
			
			
			if(dd11<dd22)
			{
				alert("Selected Next Follow Up Date should be greater than Follow Up Date");
				
				return false;
			}
			else if(dd11==dd22)
			{
				
				 if(hrs<h1)
				{
						alert("Selected Next Follow Up Time should be greater than Follow Up Time");
					return false;
					}	

				else if(hrs==h1)
				{
					
					 if(mins<=m1)
					{
							alert("Selected Next Follow Up Time should be greater than Follow Up Time");
						
						return false;
					}					 
				}
				}
		}
}
	if(isNaN(amt))
	{
		alert("Please enter numeric value for excepted ammount");
		return false;
	}
	 var docType = document.getElementById("documentType").options[document.getElementById("documentType").selectedIndex].innerHTML;
	 var file = document.getElementById("up").value.trim();

	 var docType1 = document.getElementById("documentType1").options[document.getElementById("documentType1").selectedIndex].innerHTML;
	 var file1 = document.getElementById("up1").value.trim();

	 var docType2 = document.getElementById("documentType2").options[document.getElementById("documentType2").selectedIndex].innerHTML;
	 var file2 = document.getElementById("up2").value.trim();

	 var docType3 = document.getElementById("documentType3").options[document.getElementById("documentType3").selectedIndex].innerHTML;
	 var file3 = document.getElementById("up3").value.trim();

	 var docType4 = document.getElementById("documentType4").options[document.getElementById("documentType4").selectedIndex].innerHTML;
	 var file4 = document.getElementById("up4").value.trim();

 if(document.getElementById("tr1").style.display != "none")
	 {
	 	if(docType == "Select" && !(file == ""))
	 	{
	 		alert("Pls select document type!");	
	 		return false;
	 	}

	 }

	 if(document.getElementById("tr5").style.display != "none")
	 {
	 	if(docType1 == "Select" && !(file1 == ""))
	 	{
	 		alert("Pls select document type!");	
	 		return false;
	 	}

	 }

	 if(document.getElementById("tr7").style.display != "none")
	 {
	 	if(docType2 == "Select" && !(file2 == ""))
	 	{
	 		alert("Pls select document type!");	
	 		return false;
	 	}

	 }

	 if(document.getElementById("tr9").style.display != "none")
	 {
	 	if(docType3 == "Select" && !(file3 == ""))
	 	{
	 		alert("Pls select document type!");	
	 		return false;
	 	}

	 }

	 if(document.getElementById("tr11").style.display != "none")
	 {
	 	if(docType4 == "Select" && !(file4 == ""))
	 	{
	 		alert("Pls select document type!");	
	 		return false;
	 	}

	 }

		document.getElementById("search-submit").style.visibility='hidden';
	 return true;
}

function dateformat(days)
{
if(days=='Jan')
return(01);
else
if(days=='Feb')
	return(02);
else
	if(days=='Mar')
		return(03);
	else
		if(days=='Apr')
			return(04);
		else
			if(days=='May')
				return(05);
			else
				if(days=='Jun')
					return(06);
				else
					if(days=='Jul')
						return(07);
					else
						if(days=='Aug')
							return(08);
						else
							if(days=='Sep')
								return(09);
							else
								if(days=='Oct')
									return(10);
								else
									if(days=='Nov')
										return(11);
									else
										if(days=='Dec')
											return(12);
}

function addCon(){
		//Prospect="+document.addFolloUp.customerName.value+"&Company="+document.addFolloUp.companyNames.value;
		var customername = "";
		var customercode = "";
		//alert("1");
  	   customername=document.getElementById("company111").value;
  	   customercode=document.getElementById("companycode111").value;
     		var type=document.getElementById("type111").value;
     		var ph=document.getElementById("phone111").value;
     		var email=document.getElementById("email111").value;
     		var contactperson=document.getElementById("contactperson111").value;
     		var city=document.getElementById("city111").value;

  	 
     		//alert("6"+city);
     		
     		var url="addcontact.jsp?companyname="+customername+"&customercode="+customercode+"&Type="+type+"&phone="+ph+"&email="+email+"&contactperson="+contactperson+"&city="+city+"&isclose=true";
     		var win = window.open(url,'_blank');
                  	  	win.focus();
     		
     		
	   	
	   	//alert("6");
	   	
	   	
	   	
	   	re(1);
	
}
//$('#r').load(document.URL +  ' #thisdiv');
var v=0;
function re(count){
	
	//alert(v+"---refreshing--"+count);
	
	if(count==1)
	{
		//alert("1");
		v=1;
		//alert("2");
	}
	
	if(count==0)
	{
		//alert("3");
		if(v==1){
			//alert("4");
			document.getElementById("wait").style.display="";
			$("#refreshthis1").load(document.URL +   " #refreshthis1");
			//alert("5");
			v=0;
			//alert("6  "+v);
		}		
	}	
	
	//alert("refreshing1");
	//$("#refreshthis1").load(document.URL +   " #refreshthis1");
}

function load(){
	re(0);
	setTimeout(re, 3000);	
}
</script>

<script>
    let fileInputCount = 1;
    const maxFiles = 5;

    function showFileUpload() {
        document.getElementById("fileUploadBox").style.display = "block";
    }

    function addFileInput() {
        if (fileInputCount >= maxFiles) {
            alert("You can upload a maximum of 5 files.");
            return;
        }

        const container = document.getElementById('fileInputs');
        const index = fileInputCount;

        const row = document.createElement('div');
        row.className = "row mb-2 align-items-center";
        row.id = `fileGroup${index}`;

        row.innerHTML = `
            <div class="col-5">
                <select class="form-select" name="documentType${index}" required>
                    <option value="">Select Type</option>
                    <option value="contactcard">Contact Card</option>
                    <option value="commercial">Commercial</option>
                    <option value="legal">Legal</option>
                    <option value="meeting">Meeting</option>
                    <option value="notes">Notes</option>
                </select>
            </div>

            <div class="col-5">
                <input type="file" class="form-control"
                       name="Filename${index + 1}"
                       onchange="handleUpload(${index})">
            </div>

            <div class="col-2 d-flex">
                <button type="button" class="btn btn-danger btn-sm me-1"
                        onclick="removeFileInput(${index})">−</button>
            </div>
        `;

        container.appendChild(row);

        fileInputCount++;
    }

    function removeFileInput(index) {
        const fileGroup = document.getElementById(`fileGroup${index}`);

        if (fileGroup) {
            fileGroup.remove();
            fileInputCount--;
        }

        // Count only fileGroup rows
        const remainingRows = document.querySelectorAll('#fileInputs [id^="fileGroup"]').length;

        if (remainingRows === 0) {
            document.getElementById("fileUploadBox").style.display = "none";
            fileInputCount = 1; // reset for next time
        }
    }


    function handleUpload(index) {
        console.log("File selected at row:", index);
    }
</script>


<%@ include file="footer.jsp" %>
</body>
</html> 