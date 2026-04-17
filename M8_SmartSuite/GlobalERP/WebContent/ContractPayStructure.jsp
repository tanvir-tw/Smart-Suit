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
 <body style="background-color:azure;">
 
 <%
// Connection Initialization
Connection con = null;
Statement st1 = null,st2=null,st4=null;

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();
	    st2=con.createStatement();
	    st4=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

try{
String EmpNm=session.getAttribute("EmpName").toString().trim();
String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String Id=request.getParameter("Id");
String ContractorName=request.getParameter("Name");

System.out.println("EntryDate :- "+addedOn);

String Today=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

System.out.println("ToDays Date :- "+Today);


%>
<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Pay Structure Details  -  <%=ContractorName %></h5>
		    		</div>
		             <br>
		             <form id="form_27236" method="post" action="addPayStructure.jsp" onsubmit="return chkAmt()">

  <div class="card shadow-lg mb-3 rounded-3" >
    <div class="card-body" style="margin: 20px;">
      
      <!-- Contractor ID (read-only text) -->
      <div class="row col-12 mt-3">
        <div class="col-4">
          <div class="input-container">
            <input type="text" class="form-control floating-input" id="cont_id_display" placeholder="" value="<%=Id %>" readonly>
            <label for="cont_id_display" class="floating-label">Contractor ID</label>
          </div>
        </div>
         <div class="col-4">
          <div class="input-container">
            <input id="fee_monthly" name="fee_monthly" class="form-control floating-input" type="text" value="0" onblur="checkAmount()" placeholder="" required>
            <label for="fee_monthly" class="floating-label">Contract Fee (Monthly)</label>
          </div>
        </div>
        <div class="col-4">
          <div class="input-container">
            <input id="fee_annually" name="fee_annually" class="form-control floating-input" placeholder="" type="text" value="0" readonly onblur="checkAmount1()" required>
            <label for="fee_annually" class="floating-label">Contract Fee (Annually)</label>
          </div>
        </div>
      </div>

      <!-- Contract Fee Monthly / Annually -->
   <!-- PI / KRA -->
      <div class="row col-12 mt-3">
        <div class="col-4">
          <div class="input-container">
            <input id="PI" name="PI" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount2()" required>
            <label for="PI" class="floating-label">PI</label>
          </div>
        </div>
        <div class="col-4">
          <div class="input-container">
            <input id="KRA" name="KRA" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount3()" required>
            <label for="KRA" class="floating-label">KRA</label>
          </div>
        </div>
        <div class="col-4">
          <div class="input-container">
            <input id="fixed" name="fixed" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount4()" required>
            <label for="fixed" class="floating-label">Fixed</label>
          </div>
        </div>
      </div>
 		<h6 class="heading-small text-muted" style="font-weight: bold;">Allowances:</h6>	
      <div class="row col-12 mt-3">
     
        <div class="col-4">
          <div class="input-container">
            <input id="vehicle" name="vehicle" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount5()" required>
            <label for="vehicle" class="floating-label">Vehicle</label>
          </div>
        </div>
        <div class="col-4">
          <div class="input-container">
            <input id="mobile" name="mobile" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount6()" required>
            <label for="mobile" class="floating-label">Mobile</label>
          </div>
        </div>
          <div class="col-4">
          <div class="input-container">
            <input id="laptop" name="laptop" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount7()" required>
            <label for="laptop" class="floating-label">Laptop</label>
          </div>
        </div>
      </div>

 
      <div class="row col-12 mt-3">
        <div class="col-4">
          <div class="input-container">
            <input id="proximity" name="proximity" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount8()" required>
            <label for="proximity" class="floating-label">Proximity</label>
          </div>
        </div>

        <div class="col-4">
          <div class="input-container">
            <input id="others" name="others" class="form-control floating-input" placeholder="" type="text" value="0" onblur="checkAmount9()" required>
            <label for="others" class="floating-label">Others</label>
          </div>
        </div>

        <div class="col-4">
          <div class="input-container">
            <input id="tds" name="tds" class="form-control floating-input" placeholder="" type="text" value="1" onblur="checkAmount10()" required>
            <label for="tds" class="floating-label">TDS %</label>
          </div>
        </div>
        </div>
        
    <div class="row col-12 mt-3">     
        <div class="col-4 mt-4">
          <div class="input-container">
            <input id="PI1" name="PI1" class="form-control floating-input" placeholder="" type="text" value="" onblur="checkAmount11()" required>
            <label for="PI1" class="floating-label">PI Index</label>
          </div>
        </div>
  
        <div class="col-4">
          <div class="input-container">
           <label for="PI_source" class="tcolor">PI Index Source</label>
            <select class="form-select" id="PI_source" name="PI_source" required>
	              <option value="Select">Select</option>
	              <option value="Diary System">Diary System</option>
	              <option value="Dot Project">Dot Project</option>
	              <option value="GlobalERP">GlobalERP</option>
	              <option value="NA">NA</option>
            </select>
          </div>
        </div>
        <div class="col-4 mt-4">
          <div class="input-container">
            <input id="KRA1" name="KRA1" class="form-control floating-input" placeholder="" type="text" value="" onblur="checkAmount12()" required>
            <label for="KRA1" class="floating-label">KRA Index</label>
          </div>
        </div>
      </div>

      <!-- KRA Index Source -->
      <div class="row col-12 mt-3">
        <div class="col-4">
          <div class="input-container">
            <label for="KRA_Source" class="tcolor">KRA Index Source</label>
            <select class="form-select" id="KRA_Source" name="KRA_Source" required>
              <option value="Select" selected>Select</option>
              <option value="Diary System">Diary System</option>
              <option value="Dot Project">Dot Project</option>
              <option value="GlobalERP">GlobalERP</option>
              <option value="NA">NA</option>
            </select>
          </div>
        </div>
      <!-- Pay Level / Sequence -->
        <div class="col-4">
          <div class="input-container">
           <label for="level" class="tcolor">Pay Level</label>
            <select class="form-select" id="level" name="level" required>
              <option value="Select" selected>Select</option>
              <option value="1">Level 1</option>
              <option value="2">Level 2</option>
              <option value="3">Level 3</option>
              <option value="7">Level 4</option>
              <option value="4">Level 5</option>
            </select>
           
          </div>
        </div>
        <div class="col-4">
          <div class="input-container">
          <label for="sequence" class="tcolor">Sequence</label>
            <select class="form-select" id="sequence" name="sequence" required>
              <option value="Select" selected>Select</option>
              <option value="1">Sequence 1</option>
              <option value="2">Sequence 2</option>
              <option value="3">Sequence 3</option>
              <option value="4">Sequence 4</option>
              <option value="5">Sequence 5</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Hidden Fields -->
      <input type="hidden" name="form_id" value="27236" />
      <input type="hidden" value="<%=Id %>" id="cont_id" name="cont_id"/>
      <input type="hidden" value="<%=ContractorName %>" id="Name" name="Name"/>

      <!-- Submit -->
      <div class="row mt-4">
        <div class="col text-center">
          <button type="submit" class="btn btn-primary px-4">Submit</button>
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
 <%}catch(Exception e){
	 e.printStackTrace();
 } %>   
<script type="text/javascript">
function chkAmt(){
	var invalid=/^[0-9]+$/;
	var monthly=0.00;
	monthly=document.getElementById("fee_monthly").value;

	  if(monthly.length<1)
	      {
	      alert("Monthly Fee should not be Empty");
	      return false;
	      }

	  if(!invalid.test(monthly))
	     {
	     alert("Monthly Fee Value should be digits");
	     return false;
	     }
	  
	  if(monthly==0)
  	{
		  alert("Monthly Fee Value should be Non Zero");
	         return false;
  	}
	  
	  var invalid=/^[0-9]+$/;

	  var ann=document.getElementById("fee_annually").value;
	   if(ann.length<1)
	       {
	       alert("Annually Fee should not be Empty");
	       return false;
	       }

	   if(!invalid.test(ann))
	      {
	      alert("Annually Fee Value should be in digits");
	      return false;
	      }
	 
	   if(ann==0)
	  	{
	  	     alert("Annually Fee Value should be Non Zero");
		         return false;
	  	}
	   
	   var invalid=/^[0-9]+$/;
	
	   var pi=0.00;
	   
	   pi=document.getElementById("PI").value;

	    if(pi.length<1)
	        {
	        alert("PI should not be Empty");
	        return false;
	        }

	    if(!invalid.test(pi))
	       {
	       alert("PI Value should be digits");
	       return false;
	       }	    
	    var invalid=/^[0-9]+$/;

	    var kra=0.00;
	    
	    kra=document.getElementById("KRA").value;

	     if(kra.length<1)
	         {
	         alert("KRA should not be Empty");
	         return false;
	         }

	     if(!invalid.test(kra))
	        {
	        alert("KRA Value should be digits");
	        return false;
	        }
	     
	     var invalid=/^[0-9]+$/;
	
	     var fi=0.00;
	     fi=document.getElementById("fixed").value;

	      if(fi.length<1)
	          {
	          alert("Fixed Amount should not be Empty");
	          return false;
	          }

	      if(!invalid.test(fi))
	         {
	         alert("Fixed Amount Value should be digits");
	         return false;
	         }
	      
	      if(pi==0 && kra==0 && fi==0)
	    	{
	    	     alert("Atleast Any One Of PI,KRA,Fixed Is Non Zero");
		         return false;
	    	}
	      
	      
	      var invalid=/^[0-9]+$/;

	      var chcle=0.00;
	      vhcle=document.getElementById("vehicle").value;

	       if(vhcle.length<1)
	           {
	           alert("Vehicle Allowance should not be Empty");
	           return false;
	           }

	       if(!invalid.test(vhcle))
	          {
	          alert("Vehicle Allowance Value should be digits");
	          return false;
	          }
	       var invalid=/^[0-9]+$/;

	       var mb=0.00;
	       mb=document.getElementById("mobile").value;

	        if(mb.length<1)
	            {
	            alert("Mobile Allowance should not be Empty");
	            return false;
	            }

	        if(!invalid.test(mb))
	           {
	           alert("Mobile Allowance Value should be digits");
	           return false;
	           }
	        var invalid=/^[0-9]+$/;

	        var lp=0.00;
	        lp=document.getElementById("laptop").value;

	         if(lp.length<1)
	             {
	             alert("Laptop Allowance not be Empty");
	             return false;
	             }

	         if(!invalid.test(lp))
	            {
	            alert("Laptop Allowance Value should be digits");
	            return false;
	            }
	         
	         var invalid=/^[0-9]+$/;

	         var pm=0.00;
	         pm=document.getElementById("proximity").value;

	          if(pm.length<1)
	              {
	              alert("Proximity should not be Empty");
	              return false;
	              }

	          if(!invalid.test(pm))
	             {
	             alert("Proximity Value should be digits");
	             return false;
	             }
	          var invalid=/^[0-9]+$/;

	          var othrs=0.00;
	          othrs=document.getElementById("others").value;

	           if(othrs.length<1)
	               {
	               alert("Other Allowance Field should not be Empty");
	               return false;
	               }

	           if(!invalid.test(othrs))
	              {
	              alert("Other Allowance Value should be digits");
	              return false;
	              }
	           
	           var totalamount=0.00;
	           totalamount=parseFloat(pi)+parseFloat(kra)+parseFloat(fi)+parseFloat(vhcle)+parseFloat(mb)+parseFloat(lp)+parseFloat(pm)+parseFloat(othrs);
	           
	           if(parseFloat(monthly)!=parseFloat(totalamount))
	        	   {
	        	   		alert("Monthly Contract Amount Not Matched With Break Up Amount");
	        	   		return false;
	        	   }
	           
	           	var invalid=/^[0-9]+$/;
	      	 	var TDS=document.getElementById("tds").value;

	      	  if(TDS.length < 1)
	      	      {
	      	      alert("TDS should not be Empty");
	      	      return false;
	      	      }

	      	  if(!invalid.test(TDS))
	      	     {
	      	     alert("TDS Value should be digits");
	      	     return false;
	      	     }	
	   	           
	           var invalid=/^[0-9]+$/;

	      	 var othrs=document.getElementById("PI1").value;
	      	  
	      	  if(othrs.length<1)
	            {
	            alert("PI Index should not be Empty");
	            return false;
	            }

	        if(!invalid.test(othrs))
	           {
	           alert("PI Index Value should be digits");
	           return false;
	           }
	           
	        var invalid=/^[0-9]+$/;
	   	 	var othrs=document.getElementById("KRA1").value;
	   	  
	   	  if(othrs.length<1)
	         {
	         alert("KRA Index should not be Empty");
	         return false;
	         }

	     if(!invalid.test(othrs))
	        {
	        alert("KRA Index Value should be digits");
	        return false;
	        }
	    
	     var selection1=document.getElementById("PI_source").value;
	     
	 	if(selection1=="Select")
	 		{
	 		alert("Please Select PI Index Source");
	 		return false;
	 		}
	 	
	 	var selection=document.getElementById("KRA_Source").value;
	 	if(selection=="Select")
	 	{
	 		alert("Please Select KRA Index Source");
	 		return false;
	 		
	 	}
	     var paylevel=document.getElementById("level").value;
	     
	     if(paylevel=="Select")
	    	 {
	    	 alert("Please Select Pay Level");
	    	 return false;
	    	 }
	     
	     var sequence=document.getElementById("sequence").value;
	     if(sequence=="Select")
	    	 {
	    	 alert("Please Select Sequence Level");
	    	 return false;
	    	 }
	     
		return true;
}
</script>

<script type="text/javascript">
function checkAmount()

{
 var invalid=/^[0-9]+$/;
 var yearamount=0.00;
 var monthly=document.getElementById("fee_monthly").value;

  if(monthly.length<1)
      {
      alert("Monthly Fee should not be Empty");
      return false;
      }
  else if(!invalid.test(monthly))
     {
     alert("Value should be digits");
     return false;
     }else if(monthly==0)
         {
  
	      alert("Monthly Fee should be Non Zero");
	      document.getElementById("others").focus();
	     return false;
	     }
     else{
    	 yearamount=monthly*12;
    	 document.getElementById("fee_annually").value=yearamount;
     }
 }
</script>
<script type="text/javascript">
function checkAmount1()
{
 var invalid=/^[0-9]+$/;
 var ann=document.getElementById("fee_annually").value;

  if(ann.length<1)
      {
      alert("Annually Fee should not be Empty");
      return false;
      }

  if(!invalid.test(ann))
     {
     alert("Annual Fee Value should be digits");
     return false;
     }
  if(ann==0)
  {
  
	     alert("Annual Fee Should be Non Zero");
	      document.getElementById("others").focus();
	     return false;
	     }
 }
</script>

<script type="text/javascript">
function checkAmount2()
{
 var invalid=/^[0-9]+$/;

 var pi=document.getElementById("PI").value;
  if(pi.length<1)
      {
      alert("PI should not be Empty");
      return false;
      }

  if(!invalid.test(pi))
     {
     alert("PI Value should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount3()
{
 var invalid=/^[0-9]+$/;

 var kra=document.getElementById("KRA").value;

  if(kra.length<1)
      {
      alert("KRA should not be Empty");
      return false;
      }

  if(!invalid.test(kra))
     {
      alert("KRA Value should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount4()
{
 var invalid=/^[0-9]+$/;

 var fi=document.getElementById("fixed").value;

  if(fi.length<1)
      {
      alert("Fixed Amount should not be Emptry");
      return false;
      }

  if(!invalid.test(fi))
     {
     alert("Fixed Amount Should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount5()
{
 var invalid=/^[0-9]+$/;
 var vhcle=document.getElementById("vehicle").value;

  if(vhcle.length<1)
      {
      alert("Vehicle Allowance should not be Empty");
      return false;
      }

  if(!invalid.test(vhcle))
     {
     alert("Vehicle Allowance Value should be digits");
     return false;
     }
 }
</script>
<script type="text/javascript">
function checkAmount6()
{
 var invalid=/^[0-9]+$/;
 var mb=document.getElementById("mobile").value;

  if(mb.length<1)
      {
      alert("Mobile Allowance should not be Empty");
      return false;
      }

  if(!invalid.test(mb))
     {
     alert("Mobile Allowance Value should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount7()
{
 var invalid=/^[0-9]+$/;

 var lp=document.getElementById("laptop").value;

  if(lp.length<1)
      {
      alert("Laptop Allowance should not be Empty");
      return false;
      }

  if(!invalid.test(lp))
     {
     alert("Laptop Allowance Value should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount8()
{
 var invalid=/^[0-9]+$/;
 var pm=document.getElementById("proximity").value;

  if(monthly.length<1)
      {
      alert("Proximity Value Should not be Empty");
      return false;
      }

  if(!invalid.test(monthly))
     {
     alert("Proximity Value  should be digits");
     return false;
     }

 }
</script>
<script type="text/javascript">
function checkAmount9()
{
 var invalid=/^[0-9]+$/;
 var othrs=document.getElementById("others").value;
  if(othrs.length<1)
      {
      alert("Others should not be Empty");
      return false;
      }
  else if(!invalid.test(othrs))
     {
     alert("Others Value should be digits");
     return false;
     }
 }
</script>

<script>
function checkAmount10()
{
	var invalid=/^[0-9]+$/;
	var othrs=document.getElementById("tds").value;

	  if(othrs.length<1)
	      {
	      alert("TDS should not be Empty");
	      return false;
	      }

	  if(!invalid.test(othrs))
	     {
	     alert("TDS Value should be digits");
	     return false;
	     }	
}
</script>

<script>
function checkAmount11()
{
	var invalid=/^[0-9]+$/;
	var othrs=document.getElementById("PI1").value;
	  
	  if(othrs.length<1)
      {
      alert("PI Index should not be Empty");
      return false;
      }

  if(!invalid.test(othrs))
     {
     alert("PI Index Value should be digits");
     return false;
     }
	 return true;
}
</script>

<script>
function checkAmount12()
{
	var invalid=/^[0-9]+$/;
	var othrs=document.getElementById("KRA1").value;
	  
	  if(othrs.length<1)
      {
      alert("KRA Index should not be Empty");
      return false;
      }

  if(!invalid.test(othrs))
     {
     alert("KRA Index Value should be digits");
     return false;
     }
  return true;
}
</script>

<%@ include file="footer.jsp" %>
</body>
</html>