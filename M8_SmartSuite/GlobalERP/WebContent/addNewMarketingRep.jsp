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
//Connection Initialization
Connection con = null;
Statement st1 = null,st2=null;

try {
	con = connection.getConnect("db_GlobalERP");       
	    st1=con.createStatement();
	    st2=con.createStatement();

} catch (Exception e) {
e.printStackTrace();
} 
			
	//		String selectedName;
			String FollowUpType = "";
			String daprt1="Marketing";
	%>

<%
String type=request.getParameter("type");
if(type=="new" || type.equalsIgnoreCase("new"))
{
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New Marketing Representative</h5>
		    		</div>
		             <br>
<form name="addNewMarketingRep" method="post" action="addMarktRep.jsp"	onsubmit="return validate();">
 <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">
      <div class="row col-12 mt-4">
         <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Marketing Rep. Name</label>
                 <select class="form-select" id="repName" name ="repName" onchange="Changing();" required>
                 <option selected="selected" value="select">Select</option> 
                 <%
try
{
String repName="select distinct(EmpName) from "+session.getAttribute("CompanyMasterID").toString()+"security where ActiveStatus='Yes' and Dept in ('Marketing','Sales') order by EmpName";
ResultSet rsrepName=st.executeQuery(repName);
System.out.println("--------select user"+repName);
while(rsrepName.next())
{	
%>
	 <option selected="selected" value="<%=rsrepName.getString("EmpName") %>"><%=rsrepName.getString("EmpName") %></option>
	<% 
}
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
}
%>
                   
                 </select>
            </div>
        </div>
	
	      <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Company Name</label>
                 <select class="form-select" id="company" name ="company" required>
                 <option value="select">Select</option> 
				<option value='1,2,3'>All</option>
				<option value='1'>Transworld Technologies Ltd.</option>
				<option value='2'>Theta Trading</option>
				<option value='3'>Natasha Consultants Pvt. Ltd.</option>
				</select>
			</div>
            </div>
            
           <div class="col-3 mt-4"  id='repName'>
            <div class="input-container">
             
            <input class="form-control floating-input" type="text" id="repusername" name="repuname"  placeholder="" readonly>
            <label class="floating-label">Marketing Rep. User Name</label>
            <input type="hidden" name="userpsd" id="pwd" onclick="dodisable()" onkeyup="getProspectes()" />
               
           </div>
			</div>   
         <div class="col-3 mt-4">
         <div id="email" style="visibility: visible;">
            <div class="input-container" id="email">
            	<input class="form-control floating-input" type="text" id="Email" name="email"  placeholder="">
                <label class="floating-label">E-mail id</label>
              </div>
              </div>
       </div> 
                 
      </div>           
      <div class="row col-12 mt-4">

        <div class="col-3">
            <div class="input-container" id="address">
          <textarea class="form-control floating-input" id="address" name="address" rows="1"></textarea>
           <label for="reason" class="floating-label">Address</label>
        	</div>
        	
       </div>
       <div class="col-3">
            <div class="input-container" id="city">
            	<input class="form-control floating-input" type="text" id="city" name="city"  placeholder="">
                <label class="floating-label">City</label>
              </div>
       </div>
       
              <div class="col-3">
            <div class="input-container">
            	<input class="form-control floating-input" type="text" id="department" name="department" value="<%=daprt1%>" placeholder="" readonly>
                <label class="floating-label">Department</label>
              </div>
       </div>
       <div class="col-3">
            <div class="input-container">
            	<input class="form-control floating-input" type="text" id="state" name="state"  placeholder="">
                <label class="floating-label">State</label>
              </div>
       </div>
    </div>                        
 <div class="row col-12 mt-4">
        
        <div class="col-3">
            <div class="input-container">
            	<input class="form-control floating-input" type="text" id="country" name="country"  placeholder="">
                <label class="floating-label">Country</label>
              </div>
       </div>  
       <div class="col-3">
            <div class="input-container" id="phone">
            	<input class="form-control floating-input" type="text" id="Mobno" name="phone"  placeholder="" >
                <label class="floating-label">Mobile No</label>
              </div>
       </div>   
       <div class="col-3">
            <div class="input-container"  id="userlevel">
            	<input class="form-control floating-input" type="text" id="ULevel" name="userlevel"  placeholder="" >
                <label class="floating-label">User Level</label>
              </div>
       </div> 
               <div class="col-3">
            <div class="input-container" id="visittarget">
            	<input class="form-control floating-input" type="text" id="VisitTarget" name="visittarget"  placeholder="">
                <label class="floating-label">Visit Targets</label>
              </div>
       </div>
                 
   </div>             
             

 <div class="row col-12 mt-4">
  <div class="col-3">
            <div class="input-container" id="calltarget">
            	<input class="form-control floating-input" type="text" id="CallTarget" name="calltarget"  placeholder="">
                <label class="floating-label">Call Targets</label>
              </div>
       </div> 
        <div class="col-3">
            <div class="input-container" id="lettarget">
            	<input class="form-control floating-input" type="text" id="LetterTarget" name="lettarget"  placeholder="">
                <label class="floating-label">Letters Targets</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="squotarget">
            	<input class="form-control floating-input" type="text" id="SqoTarget" name="squotarget"  placeholder="">
                <label class="floating-label">Sales Quotation Targets</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="nprostarget">
            	<input class="form-control floating-input" type="text" id="NewProspectTarget" name="nprostarget"  placeholder="">
                <label class="floating-label">New Prospects Targets</label>
              </div>
       </div>
         																									
</div>                 
 <div class="row col-12 mt-4">
        <div class="col-3 mt-4">
            <div class="input-container" id="talevel">
            	<input class="form-control floating-input" type="text" id="TALevel" name="talevel"  placeholder="">
                <label class="floating-label">TA Level</label>
              </div>
       </div>
       <div class="col-md-2" id="compressor">
	    <label class="form-label fw-bold d-block">Compressor</label>
	    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="compressor" id="compressor" value="True">
    </div>
    </div>
        <div class="col-2">
            <div class="input-container" id="digiequp">
                <label class="tcolor">DigitalEquipments</label>
                    <div class="form-check">
        				<input class="form-check-input" type="checkbox" name="digiequp" id="digiequp" value="True">
    				</div>
              </div>
       </div> 
       <div class="col-1">
            <div class="input-container" id="dgset">
                <label class="tcolor">DGSet</label>
                    <div class="form-check">
        				<input class="form-check-input" type="checkbox" name="dgset" id="dgset" value="True">
    				</div>
              </div>
       </div>  
 		<div class="col-2">
            <div class="input-container" id="endoscope">
                <label class="tcolor">Endoscope</label>
                    <div class="form-check">
        				<input class="form-check-input" type="checkbox" name="endoscope" id="endoscope" value="True">
    				</div>
              </div>
       </div>
        <div class="col-2">
            <div class="input-container" id="othergroup">
                <label class="tcolor">OtherGroups</label>
                    <div class="form-check">
        				<input class="form-check-input" type="checkbox" name="othergroup" id="othergroup" value="True">
    				</div>
              </div>
       </div>
              
       
</div>			

	<div class="row mt-4">
        <div class="col text-center">
        <button class="btn" id="submit" name="submitFollowUp" type="submit">Submit</button>
        </div>
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
<%
} else if(type.equalsIgnoreCase("edit"))
{
	System.out.println("IN ELSE PART  ");

	String repname=request.getParameter("repname");
	System.out.println(repname);
	
	String emailid="",add="",cty="",daprt="",stat1="",country1="",mobl="",usrlevel="",comp="",dgequp="",dgst="",endosp="",othergrp="",visittrg="",calltrg="",lettertarg="",salesquotarg="",newprosptrg="";
%>

<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Marketing Representative Details</h5>
		    		</div>
		             <br>
<form name="update" method="post" action="updatemarketingdata.jsp" onsubmit="return validate();">
 <div class="card shadow-lg mb-3 rounded-3">
 <%
String repName="select * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repname+"'";
ResultSet rsrepName=st2.executeQuery(repName);
System.out.println("--------select user"+repName);
if(rsrepName.next())
{
	emailid=rsrepName.getString("MarketingRepEMail");
	add=rsrepName.getString("MarketingRepAddress");
	cty=rsrepName.getString("MarketingRepCity");
	daprt="Marketing";
	stat1=rsrepName.getString("MarketingRepState");
	country1=rsrepName.getString("MarketingRepCountry");
	mobl=rsrepName.getString("MarketingRepPhNo");
	usrlevel=rsrepName.getString("UserLevel");
	comp=rsrepName.getString("Compressor");
	dgequp=rsrepName.getString("DigitalEquipment");
	dgst=rsrepName.getString("DGSet");
	endosp=rsrepName.getString("Endoscope");
	othergrp=rsrepName.getString("OtherGroups");
	visittrg=rsrepName.getString("VisitsTarget");
	calltrg=rsrepName.getString("CallsTarget");
	lettertarg=rsrepName.getString("LettersTarget");
	salesquotarg=rsrepName.getString("SQTarget");
	newprosptrg=rsrepName.getString("NewProspectTarget");
}

%>
 <div class="row">
    <div class="card-body">
      <div class="row col-12 mt-4">
         <div class="col-3">
            <div class="input-container">	
	 		       		<input class="form-control floating-input" type="text" id="repName1" name="repName1" value="<%=repname %>"  placeholder="">
          	<label for="repName1" class="floating-label">Marketing Rep. Name</label>
          	</div>
          	
          </div>
         <div class="col-3">
            <div class="input-container">	
	 		       		<input class="form-control floating-input" type="text" id="company" name="company" value="Transworld Compressor Technologies Ltd"  placeholder="">
          				<label for="companyNames" class="floating-label">Company Name</label>
          	</div>
          </div>
           <div class="col-3">
            <div class="input-container" id="companyName">	
	 		       		<input class="form-control floating-input" type="text" id="comName" name="comName"   placeholder="">
          				<label for="companyNames" class="floating-label">Company</label>
          	</div>
          	
          </div>
           <div class="col-3">
            <div class="input-container" id="email">	
	 		       		<input class="form-control floating-input" type="text" id="Email" name="Email" value="<%=emailid %>"  placeholder="">
          				<label for="companyNames" class="floating-label">E-mail id</label>
          	</div>
          	
          </div>          
     </div>
       <div class="row col-12 mt-4">
         <div class="col-3">
            <div class="input-container" id="address">	
             <textarea class="form-control floating-input" id="remarks" name="remarks" rows="1"><%=add %></textarea>
          	<label for="repName1" class="floating-label">Address</label>
          	</div>
          </div>
            <div class="col-3">
            <div class="input-container" id="city">	
	 		       	<input class="form-control floating-input" type="text" id="city" value="<%=cty %>" name="address"  placeholder="">
          				<label for="companyNames" class="floating-label">City</label>
          	</div>
          </div>
              <div class="col-3">
            <div class="input-container" id="city">
            	<input class="form-control floating-input" type="text" id="dept" name="department" value="MARKETING" placeholder="" readonly>
                <label class="floating-label">Department</label>
              </div>
       </div>
                  <div class="col-3">
            <div class="input-container" id="state">
            	<input class="form-control floating-input" type="text" id="state" name="state" value="<%=stat1 %>"  placeholder="">
                <label class="floating-label">State</label>
              </div>
       </div>
    </div>
       <div class="row col-12 mt-4">

        <div class="col-3">
            <div class="input-container" id="country">
            	<input class="form-control floating-input" type="text" id="country" name="country" value="<%=country1 %>" placeholder="">
                <label class="floating-label">Country</label>
              </div>
       </div>  
       <div class="col-3">
            <div class="input-container" id="phone">
            	<input class="form-control floating-input" type="text" id="Mobno" name="phone"  value="<%=mobl %>"  placeholder="" >
                <label class="floating-label">Mobile No</label>
              </div>
       </div>   
       <div class="col-3">
            <div class="input-container"  id="userlevel">
            	<input class="form-control floating-input" type="text" id="userlevel" name="userlevel" value="<%=usrlevel %>" placeholder="" >
                <label class="floating-label">User Level</label>
              </div>
       </div>           
   </div>    
    <div class="row col-12 mt-4">
        <div class="col-3">
            <div class="input-container" id="visittarget">
            	<input class="form-control floating-input" type="text" id="VisitTarget" name="visittarget" value="<%=visittrg %>"  placeholder="">
                <label class="floating-label">Visit Targets</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="calltarget">
            	<input class="form-control floating-input" type="text" id="CallTarget" name="calltarget" value="<%=calltrg %>" placeholder="">
                <label class="floating-label">Call Targets</label>
              </div>
       </div>  
        <div class="col-3">
            <div class="input-container" id="lettarget">
            	<input class="form-control floating-input" type="text" id="LetterTarget" name="lettarget" value="<%=lettertarg %>"  placeholder="">
                <label class="floating-label">Letters Targets</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="squotarget">
            	<input class="form-control floating-input" type="text" id="SqoTarget" name="squotarget" value="<%=salesquotarg %>" placeholder="">
                <label class="floating-label">Sales Quotation Targets</label>
              </div>
       </div>
       
</div> 
   <div class="row col-12 mt-4">
        <div class="col-3">
            <div class="input-container" id="nprostarget">
            	<input class="form-control floating-input" type="text" id="NewProspectTarget" name="nprostarget" value="<%=newprosptrg %>" placeholder="">
                <label class="floating-label">New Prospects Targets</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="talevel">
            
            	<input class="form-control floating-input" type="text" id="TALevel" name="talevel" value="Level1"  placeholder="">
                <label class="floating-label">TA Level</label>
              </div>
       </div>  
       <div class="col-md-3">
        <div class="input-container" id="compressor">
       <input class="form-control floating-input" type="text" id="compressor" name="compressor" value="<%=comp %>" placeholder="">
    	<label class="floating-label">Compressor</label> 
    	</div>  
    </div>
        <div class="col-3">
            <div class="input-container" id="digiequp">
             <input class="form-control floating-input" type="text" id="digiequp" name="digiequp" value="<%=dgequp %>" placeholder="">
                <label class="floating-label">DigitalEquipments</label>
                  
              </div>
       </div> 
        

</div>	
<div class="row col-12 mt-4">
 <div class="col-3">
            <div class="input-container" id="dgset">
            <input class="form-control floating-input" type="text" id="dgset" name="dgset" value="<%=dgst %>" placeholder="">
                <label class="floating-label">DGSet</label>
                  
              </div>
       </div>
 		<div class="col-3">
            <div class="input-container" id="endoscope">
              <input class="form-control floating-input" type="text"name="endoscope" id="endoscope" value="<%=endosp %>" placeholder="">
                <label class="floating-label">Endoscope</label>
              </div>
       </div>
        <div class="col-3">
            <div class="input-container" id="othergroup">
            <input class="form-control floating-input" type="text" name="othergroup" id="othergroup"  value="<%=othergrp %>" placeholder="">
                <label class="floating-label">OtherGroups</label>
                  
              </div>
       </div>
</div>			

	<div class="row mt-4">
        <div class="col text-center">
        <button class="btn" id="search-submit" name="submitFollowUp" type="submit">Submit</button>
        </div>
      </div>      
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
<%} %>


	<script type="text/javascript">


	function dodisable()
	{
	document.addNewMarketingRep.repuname.readOnly="true";
	document.addNewMarketingRep.email.readOnly="true";
	document.addNewMarketingRep.phone.readOnly="true";	
	document.addNewMarketingRep.userpsd.readOnly="true";
	document.addNewMarketingRep.userlevel.readOnly="true"; 
	document.addNewMarketingRep.talevel.readOnly="true";
	}




	function validate()
	{
		var username=document.addNewMarketingRep.repuname.value;
		if(username=="")
		{
		alert("Please Enter the User Name");
	     return false;
		}


        var Email=document.addNewMarketingRep.email.value;
        if(Email=="")
        {
          alert("Please Enter the Email-Id");
          return false;
         }



       var addr=document.addNewMarketingRep.address.value;
       if(addr=="")
       {
          alert("Please Enter the Address..");
          return false;

           } 

        var City= /^[A-Za-z ]+$/;  
    	var City=City.test(document.addNewMarketingRep.city.value);
        if(City==false)
         {     
             alert('City Name must have characters only');  
             return false;  
         }  


       var State=/^[A-Za-z ]+$/;
       var State=State.test(document.addNewMarketingRep.state.value);
       if(State==false)
       {
          alert("State Name Must have characters only..");
          return false;
       }  



       var Country=/^[A-Za-z ]+$/;
       var Country=Country.test(document.addNewMarketingRep.country.value);
       if(Country==false)
       {
          alert("Country Name Must have Characters only..");
          return false;

        }

        

        var vistar=document.addNewMarketingRep.visittarget.value;//alert(vistar);
        var calltargets=document.addNewMarketingRep.calltarget.value;//alert(calltargets);
		 var letargets=document.addNewMarketingRep.lettarget.value;//alert(letargets);
		 var sqtargets=document.addNewMarketingRep.squotarget.value;//alert(sqtargets);
		 var nprstargets=document.addNewMarketingRep.nprostarget.value;//alert(nprstargets);
		 
	      var numericExpression = /^[0-9]+$/;

	      if(!(vistar.match(numericExpression)))
			{
					    alert("Visit target should be Numeric");
					    return false;
			}	
	      

	    if(!(calltargets.match(numericExpression)))
		    {
			    alert("call target should be Numeric");
			    return false;
			}	

		if(!(letargets.match(numericExpression)) )
			{
				    alert("Letter target should be Numeric");
				    return false;
			}

	      
		if(!(sqtargets.match(numericExpression)) )
			{
				    alert("SalesQuotation target should be Numeric");
				    return false;
			}

	      	
		if(!(nprstargets.match(numericExpression)) )
			    {
				    alert("NewProspect target should be Numeric");
				    return false;
				}
	    		

   }


	
function hideList(e){
    if(e.which == 0){
    	document.getElementById("ProspectList").style.visibility='hidden';
    }
}
    function hideOnClick(){
        //	document.getElementById("ProspectList").style.visibility='hidden';
}
	function getProspectes() {
		
		document.getElementById("ProspectList").style.visibility='visible';
		var prospect=document.addCustomer.companyName.value;
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
				//alert(reslt);
				//var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				//alert(reslt);
				document.getElementById("ProspectList").innerHTML=reslt;


			} 
		}
		var queryString = "?prospect=" +prospect+'&displayList=true';
		ajaxRequest.open("GET", "AjaxGetProspectInfo.jsp" + queryString, true);
		ajaxRequest.send(null); 

		
	}



	function Changing()
	 {
		 //alert("in fun");
		
		var name=document.getElementById("repName").options[document.getElementById("repName").selectedIndex].value;
		//alert(name);	 
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {
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
					//alert(">>>    "+reslt);
					var data=reslt.split("ZZ");
				    //alert("<*****  "+data);
					//alert(data[0]);
					 
			if(data[0].indexOf("Yes")!=-1)
					{					
				    	///window.location.reload();
				    	//alert("data fetch successfully");
				    	document.getElementById("repusername").value=data[1];
						document.getElementById("Email").value=data[2];
						document.getElementById("Mobno").value=data[3];
						document.getElementById("pwd").value=data[4];
						document.getElementById("ULevel").value=data[5];
						document.getElementById("TALevel").value=data[6];
						document.getElementById("VisitTarget").value="";
						document.getElementById("CallTarget").value="";
						document.getElementById("LetterTarget").value="";
						document.getElementById("SqoTarget").value="";
						document.getElementById("NewProspectTarget").value="";
						
					}else if(data[0].indexOf("No")!=-1)
					{					
				    	///window.location.reload();
				    	
				    	//alert("data fetch in no  successfully"+data[11]);
				    	
				    	document.getElementById("repusername").value=data[1];
						document.getElementById("Email").value=data[2];
						document.getElementById("Mobno").value=data[3];
						document.getElementById("pwd").value=data[4];
						document.getElementById("ULevel").value=data[5];
						document.getElementById("TALevel").value=data[6];
						document.getElementById("VisitTarget").value=data[7];
						document.getElementById("CallTarget").value=data[8];
						document.getElementById("LetterTarget").value=data[9];
						document.getElementById("SqoTarget").value=data[10];
						document.getElementById("NewProspectTarget").value=data[11];
						
						
						
						
						
					}
					else
					{
				    	alert("data not fetch successfully");
						
					}
					
	         } 

		}
			
			var queryString = "?name="+name;
			//alert(queryString);
			
			ajaxRequest.open("GET", "AjaxNewMarkRep.jsp" + queryString, true);
			ajaxRequest.send(null); 
	 }


	function Changingedit()
	{

		var name=document.getElementById("repName").options[document.getElementById("repName").selectedIndex].value;
		//alert(name);	 
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {
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
					//alert(">>>    "+reslt);
					var data=reslt.split("ZZ");
				    //alert("<*****  "+data);
					alert(data[0]);
					if(data[0].indexOf("Yes")!=-1)
					{					
				    	///window.location.reload();
				    	//alert("data fetch successfully");
				    	document.getElementById("repusername").value=data[1];
						document.getElementById("Email").value=data[2];
						document.getElementById("Mobno").value=data[3];
						document.getElementById("pwd").value=data[4];
						document.getElementById("ULevel").value=data[5];
						document.getElementById("TALevel").value=data[6];
						
					}
					else if(data[0].indexOf("YesYes")!=-1)
					{					
				    	///window.location.reload();
				    	//alert("data fetch successfully");
				    	document.getElementById("repusername").value=data[1];
						document.getElementById("Email").value=data[2];
						document.getElementById("Mobno").value=data[3];
						document.getElementById("pwd").value=data[4];
						document.getElementById("ULevel").value=data[5];
						document.getElementById("TALevel").value=data[6];
						document.getElementById("VisitTarget").value=data[7];
						document.getElementById("CallTarget").value=data[8];
						document.getElementById("LetterTarget").value=data[9];
						document.getElementById("SqoTarget").value=data[10];
						document.getElementById("NewProspectTarget").value=data[11];
						
						
						
						
					}else
					{
				    	alert("data not fetch successfully");
						
					}
					
	         } 

		}
			
			var queryString = "?name="+name;
			//alert(queryString);
			
			ajaxRequest.open("GET", "AjaxEditMarkrep.jsp" + queryString, true);
			ajaxRequest.send(null); 
	}
	 		
	 // var agree=confirm(" CompanyName: "+company+"\n Rep. Person : \n Email: "+email+"\n Mobile: "+mobile+"\n\nAre you sure you want to continue with these values?");
	 //if (agree)
	 //return true ;
	 //else
	 //return false ;

	 //if (document.all || document.getElementById)
		//document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>
 
<%@ include file="footer.jsp" %>
</body>
</html>