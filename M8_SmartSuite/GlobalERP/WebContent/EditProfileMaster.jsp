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
 
</head>
<body onkeypress="hideList(event);" onclick="hideOnClick();" style="background-color:azure;">


<%
Connection conn = null;
Statement st1 = null,st2=null,st4=null,st3=null,st5=null;

try {
	conn = connection.getConnect("db_GlobalERP");       
  
	    st1=conn.createStatement();
	    st2=conn.createStatement();
	    st3=conn.createStatement();
	    st4=conn.createStatement();
	    st5=conn.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

String Id=request.getParameter("Id");
String ContractorName=request.getParameter("Name");	
String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

String  ContractorId="";             
String  Department="";               
String  ContractorOfficialNumber=""; 
String  ContractorOfficialEmail="";  
String  ContractStartDate="";        
String  ContractEndDate="";          
String  ContractorWeekOff="";        
String  EntryBy="";                  
String  EntryDate="";
String  Designation="";
String ContractorWeekOffName="";


		String Check="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+Id+"'";

		            ResultSet rsCheck=st4.executeQuery(Check);
		            if(rsCheck.next())
		            {
		            	Department=rsCheck.getString("Department"); 
		            	Designation=rsCheck.getString("Designation");
		            	ContractorOfficialNumber=rsCheck.getString("ContractorOfficialNumber");
		            	ContractorOfficialEmail=rsCheck.getString("ContractorOfficialEmail");
		            	ContractStartDate=rsCheck.getString("ContractStartDate");
		            	ContractEndDate=rsCheck.getString("ContractEndDate");
		            	ContractorWeekOff=rsCheck.getString("ContractorWeekOff");
		            	
		            }
		            if(ContractorWeekOff.equals("1"))
		            {
		            	ContractorWeekOffName="Monday";
		            }
		            if(ContractorWeekOff.equals("2"))
		            {
		            	ContractorWeekOffName="Tuesday";
		            }
		            if(ContractorWeekOff.equals("3"))
		            {
		            	ContractorWeekOffName="Wednesday";
		            }
		            if(ContractorWeekOff.equals("4"))
		            {
		            	ContractorWeekOffName="Thrusday";
		            }
		            if(ContractorWeekOff.equals("5"))
		            {
		            	ContractorWeekOffName="Friday";
		            }
		            if(ContractorWeekOff.equals("6"))
		            {
		            	ContractorWeekOffName="Saturday";
		            }
		            if(ContractorWeekOff.equals("7"))
		            {
		            	ContractorWeekOffName="Sunday";
		            }
		            System.out.println("Weekoff: "+ContractorWeekOffName);
		            
		            
		            String dt1 = new SimpleDateFormat("dd-MMM-yyyy")
			        .format(new SimpleDateFormat("yyyy-MM-dd")
			                .parse(ContractStartDate));
		            
		            String dt2 = new SimpleDateFormat("dd-MMM-yyyy")
			        .format(new SimpleDateFormat("yyyy-MM-dd")
			                .parse(ContractEndDate));
		            
%>		
<%

String addedOn1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
System.out.println("EntryDate :- "+addedOn1);
String Today=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
System.out.println("ToDays Date :- "+Today);

%>
<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Contract Profile Master - <%=ContractorName %></h5>
		    		</div>
		             <br>

<form id="form_27236" class="appnitro"  method="post" action="UpdateProfileForm.jsp">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <h6 class="heading-small text-muted" style="font-weight: bold;">Contractor ID : <%=Id %></h6>	
      <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">    
        <label class="tcolor">Department</label>
            <select class="form-select" id="dept" name="dept" required>            
			<option value="Account" <%if(Department.equalsIgnoreCase("Account")){%>Selected<%}%>>Account</option>
			<option value="Driver" <%if(Department.equalsIgnoreCase("Driver")){%>Selected<%}%>>Driver</option>
			<option value="HR" <%if(Department.equalsIgnoreCase("HR")){%>Selected<%}%>>HR</option>
			<option value="Marketing" <%if(Department.equalsIgnoreCase("Marketing")){%>Selected<%}%>>Marketing</option>
			<option value="Networking" <%if(Department.equalsIgnoreCase("Networking")){%>Selected<%}%>>NetWorking</option>
			<option value="Operation" <%if(Department.equalsIgnoreCase("Operation")){%>Selected<%}%>>Operation</option>
			<option value="Purchase" <%if(Department.equalsIgnoreCase("Purchase")){%>Selected<%}%>>Purchase</option>
			<option value="R&D" <%if(Department.equalsIgnoreCase("R&D")){%>Selected<%}%>>R&D</option>
			<option value="Sales" <%if(Department.equalsIgnoreCase("Sales")){%>Selected<%}%>>Sales</option>
			<option value="Software" <%if(Department.equalsIgnoreCase("Software")){%>Selected<%}%>>Software</option>
			<option value="Technician" <%if(Department.equalsIgnoreCase("Technician")){%>Selected<%}%>>Technician</option>
           
           </select>
        </div>
      </div>

      <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="designation" name="designation"  onblur="return checkdes()" value="<%=Designation%>" placeholder="" required>
          <label for="designation" class="floating-label">Designation</label>
        </div>
      </div>

      <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="official_no" name="official_no" class="element text" onblur="return checkphno()" value="<%=ContractorOfficialNumber%>" placeholder="" required>
          <label for="cont_id" class="floating-label">Official Number</label>
        </div>
      </div>

      <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="email" id="official_email" name="official_email" 
                 onblur="return checkEmail()" 
                 value="<%=ContractorOfficialEmail%>" placeholder="" required>
          <label for="personal_email" class="floating-label">Official Email </label>
        </div>
      </div>
  </div>
 </div>
      <div class="row">
      <div class="row col-12 mt-4"> 
       <div class="col-4 mt-4">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="cont_startdate" name="cont_startdate"  value="<%=dt1%>" placeholder="" required>
            <label for="dob" class="floating-label">Contract Start Date</label>
            </div>
        </div>
        <script type="text/javascript">
						Calendar.setup( {
							inputField : "cont_startdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "cont_startdate" // ID of the button
						});
					</script>
					
		<div class="col-4 mt-4">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="cont_end" name="cont_end"  value="<%=dt2%>" placeholder="" required>
            <label for="dob" class="floating-label">Contract End Date</label>
            </div>
        </div>
        <script type="text/javascript">
						Calendar.setup( {
							inputField : "cont_end", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "cont_end" // ID of the button
						});
		</script>
		
		
		<div class="col-4">
		<div class="input-container">    
        <label class="tcolor">Contractor WeekOff</label>
            <select class="form-select" id="education" name="education" required>
				<option value="1" <%if(ContractorWeekOff.equalsIgnoreCase("1")){%>Selected<%}%>>Monday</option>
				<option value="2" <%if(ContractorWeekOff.equalsIgnoreCase("2")){%>Selected<%}%>>Tuesday</option>
				<option value="3" <%if(ContractorWeekOff.equalsIgnoreCase("3")){%>Selected<%}%>>Wednesday</option>
				<option value="4" <%if(ContractorWeekOff.equalsIgnoreCase("4")){%>Selected<%}%>>Thursday</option>
				<option value="5" <%if(ContractorWeekOff.equalsIgnoreCase("5")){%>Selected<%}%>>Friday</option>
				<option value="6" <%if(ContractorWeekOff.equalsIgnoreCase("6")){%>Selected<%}%>>Saturday</option>
				<option value="7" <%if(ContractorWeekOff.equalsIgnoreCase("7")){%>Selected<%}%>>Sunday</option>

            </select>
            </div>
        </div>
		
</div>

 <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="saveForm" type="submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">Submit</button>
    </div>
    </div>
    
  </div>
 
</div>

                                                                                                                                                                                                                                                                                                                                                                  
			    <input type="hidden" name="form_id" value="27236" />
			    <input type="hidden" value="<%=Id %>" id="cont_id" name="cont_id"/>
			    <input type="hidden" value="<%=ContractorName %>" id="Name" name="Name"/>	


    </form>
    </div>
          
            </div>
                <!-- End of card body -->
            </div>
        </div>
        
        
        </section>

</div>
</div>	

<script type="text/javascript">
function checkdes(){
	
	var company=document.getElementById("designation").value;

	
	var re=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z]+$/;
	if(company==""){
		
		alert("Enter the Designation");
		return false;
	}
	else{
	if(!re.test(company))
	{
	alert("Enter Designation Properly");
	return false;
	}
	}
}
</script>
<script type="text/javascript">
     
     function checkphno(){
    	 var phn=document.getElementById("official_no").value;
    	 //var rs=/^\d{3}\d{3}\d{4}$/;
    	 var rs=/^[+]{0,1}[0-9]{10,15}$/;

    	 if(phn==""){
    		 alert("Enter the Official Phone Number");
    		 return false;
    	 }
         if(!rs.test(phn)){
        	 
        	 alert("Please Enter 10 Digit number");
        	 return false;
         }
     
     }
</script>
<script type="text/javascript">
function checkEmail(){  
	 
	 var txtEmail=document.getElementById("official_email").value;
	 
	if(txtEmail==""){
		alert("Please Enter the Email Id");
		return false;
	} 
	if(!txtEmail.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/))
	{
	alert("Enter Valid  Email Id");
	return false;
	}
	} 
</script>
<%@ include file="footer.jsp" %>
</body>
</html>