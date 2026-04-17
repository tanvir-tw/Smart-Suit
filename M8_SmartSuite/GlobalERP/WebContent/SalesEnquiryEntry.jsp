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
</head>
<body style="background-color:azure;">


<%
Connection con = null;
Statement st1 = null,st2=null;

try {
		con = connection.getConnect("db_GlobalERP");       

	    st1=con.createStatement();
	    st2=con.createStatement();

} catch (Exception e) {
	e.printStackTrace();
} 
 %>

<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Enquiry Entry</h5>
		    		</div>
		             <br>

<form name='ledgerDetails' action="" onsubmit="return validate();" method="post">
				<input type="hidden" name="Type" id="search-text"/>
				<input type="hidden" name="Service" id="search-text"/>
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
      <div class="row col-12 mt-3"> 
             <div class="col-4">
        		<div class="input-container">    
        		<label class="tcolor">Group</label>
            	<select class="form-select" id="group" name="group"  onchange="OnChangeGetDetails(this,'group');" required>
            	<option value='Select' selected="selected" >Select</option>
			 	<%
	 		  	String sqlGroup="SELECT distinct(TheGroupName),TheGroupCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where Status='Active'";
			 	  System.out.println("sqlGroup :- "+sqlGroup);
			 	ResultSet rsGroup=st1.executeQuery(sqlGroup);
			 	

	 			while(rsGroup.next())
	 			{
				 	System.out.println("Get String2  :- "+rsGroup.getString(2));
				 	System.out.println("Get String1  :- "+rsGroup.getString(1));
	 			%>
	 			<option value="<%=rsGroup.getString(2)+"::"+rsGroup.getString(1) %>"><%=rsGroup.getString(1) %></option>
	 			<%
	 			}
	 			%>
            	</select>
        </div>
      </div>
      
      <!-- <input type="checkbox" name="modelNotKnown" />Model Not Known -->
      <%
			String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=st2.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
		
      	<div class="col-4">
      		<div class="input-container" id="make">    
        		<label class="tcolor"><%=rslbl.getString("Make") %></label>
            	<select class="form-select" id="make1" name="make1"  required>
				</select>
      		</div>
      	</div>
      	      	<div class="col-4 mt-4">
      		<div class="input-container" id="make">    
      		<input type="checkbox" name="modelNotKnown" />
        		<label class="tcolor">Model Not Known</label>
            
      		</div>
      	</div>
      	</div>
      	 <div class="row col-12 mt-3"> 
      	<div class="col-4">
      		<div class="input-container" id="model">    
        		<label class="tcolor"><%=rslbl.getString("Model") %></label>
            	<select class="form-select" id="model1" name="model1"  required>
				</select>
      		</div>
 		</div>
     	<div class="col-4">
      		<div class="input-container" id="partNo">    
        		<label class="tcolor"><%=rslbl.getString("PartNO") %></label>
            	<select class="form-select" id="partNo1" name="partNo1"  required>
				</select>
      		</div>
 		</div>
 		<div class="col-4">
      		<div class="input-container" id="Description">    
        		<label class="tcolor"><%=rslbl.getString("Description") %></label>
            	<select class="form-select" id="Description1" name="Description1"  required>
				</select>
      		</div>
 		</div>
 		 <%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
		  <a href="#" style="font-weight: bold; text-decoration: none; margin-top: 4px" onclick="popup('InsertSalesItem.jsp');" >Add New Item</a>
		  <%} %>
 		</div>
 		
 		<% }%>
     	 <div class="row col-12 mt-3"> 
     	 <div class="col-4">
      		<div class="input-container">
      			<input class="form-control floating-input" type="text" id="specification" name="specification" placeholder="" required>
          		<label for="FullName" class="floating-label">Specification</label>    
      		</div>
 		</div>
 		<div class="col-4">
      		<div class="input-container"> 
      			<input class="form-control floating-input" type="text" id="quantity" name="quantity" placeholder="" required>
          		<label for="FullName" class="floating-label">Quantity</label>    
      		</div>
 		</div>
 		
 		</div>
 		
 		    <div class="row mt-4">
      <div class="col text-center">
       	 	<button type="submit" class="btn btn-primary px-4" onclick="addRow()">Add Entry</button>
      </div>
    </div>
</div>
</div>

</form>
</div>
</div>
</div>
</section>
 </div>
</div>

<script type="text/javascript">
var counter=1;
function popup(webadd)
{
	var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
    var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
 //   alert("+++++++++++"+makeCode);
	window.open(webadd+'?groupCode='+groupCode+'&groupName='+groupName+'&makeCode='+makeCode+'&makeName='+makeName,'item','width=300,height=200,top=300,left=600,resizable=no');
}
function addRow()
{
 	var quantity=document.ledgerDetails.quantity.value;
    var g=document.getElementById("group").value;
    if(g=="" || g=="Select")
    {
	    alert("Please select group");
	    return false;
    }
    
    var mke=document.getElementById("makeList").value;
	 var oth=quantity.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

	 	    if(mke=="" || mke=="Select")
	    {
		    alert("Please select make");
		    return false;
	    }
	 	    
	 	   var mod=document.getElementById("modelList").value;
	    if(mod=="" || mod=="Select")
	    {
		    alert("Please select model");
		    return false;
	    }
	    
	    var prt=document.getElementById("partNoList").value;
	    if(prt=="" || prt=="Select")
	    {
		    alert("Please select part no");
		    return false;
	    }
	    

var desc=document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value.split("::")[0];
if(desc=="-" || desc=="0" || desc=="Select")
{
	alert("Please select description");
	return false;
}

if(quantity=="" || oth=="")
{
	  alert("Please enter Quantity");
	  return(false);
}
if(isNaN(quantity))
	{
		alert("Please enter numeric value for quantity");
		return false;
	}

     var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
     var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
     var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
     var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
 	 var model=document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value.split("::")[0];
	 var partNo=document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value.split("::")[0];  

		var modelNotKnown="false";
		if(document.ledgerDetails.modelNotKnown.checked)
			modelNotKnown="true";
	    var ajaxRequest;
	     try{
				ajaxRequest = new XMLHttpRequest();
	        }  
            catch (e)
            {
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
			desc=desc.replace(/\+/g,"^^");;
	        var queryString = "?make="+makeCode+"&group="+groupCode+"&description="+desc+"&quantity="+quantity+"&model="+model+"&part="+partNo+"&modelNotKnown="+modelNotKnown;
          counter++;
	       	ajaxRequest.open("GET", "AjaxSalesEnq.jsp" + queryString, true);
	       	ajaxRequest.send(null); 
	       	ajaxRequest.onreadystatechange = function()
	         {
	                if(ajaxRequest.readyState == 4)
	                {
	                        var reslt=ajaxRequest.responseText;
	                        var data=reslt.split("#");
	                        if(data[1].indexOf('Yes')!=-1)
	                        {
		                        alert("Item Saved Successfully.....");
		                       window.close();
		                       window.opener.location.reload();
							}
	                        else
		                        alert("!!! ERROR while adding data to GRID due to Server Side problem. Please try again.");
	                }
	         }
}
function OnChangeGetDetails(dropdown,type)
{
	var aa1;
	var bb1;
try{
	var vv1=dropdown.selectedIndex;
	var SelValue1 = dropdown.options[vv1].value;
	globalmodel=SelValue1;
	var ab="partNo";
	if (SelValue1 == "Select") {
	    if (type == 'group') {
	        document.getElementById("partNo").innerHTML =
	        document.getElementById("make").innerHTML =
	        document.getElementById("Description").innerHTML =
	        document.getElementById("model").innerHTML =
	        	  "<div class='input-container'>" +
	        	    "<label class='tcolor'>Model</label>" +
	        	    "<select class='form-select mt-4' id='model1' name='model1' required>" +
	        	    "<option value='Select'>Select</option>" +
	        	    "</select>" +
	        	    "</div>";
	    }

	    else if (type == 'make') {
	        document.getElementById("partNo").innerHTML =
	        document.getElementById("Description").innerHTML =
	        	document.getElementById("model").innerHTML =
	        	    "<select class='form-select mt-4' id='model1' name='model1' required>" +
	        	    "<option value='Select'>Select</option>" +
	        	    "</select>";

	    }

	    else if (type == 'model') {
	        document.getElementById("partNo").innerHTML =
	        	document.getElementById("model").innerHTML =
	        	    "<div class='input-container'>" +
	        	    "<label class='tcolor'>Model</label>" +
	        	    "<select class='form-select mt-4' id='model1' name='model1' required>" +
	        	    "<option value='Select'>Select</option>" +
	        	    "</select>" +
	        	    "</div>";

	    }
	}

	   else if(type.length==ab.length)
       {	
            aa1=document.ledgerDetails.modelList.value;
	  }

	   else if(type=="description")
       {	
		   bb1=document.getElementById("DescriptionList").value;
		   SelValue1 = bb1.replace(/\+/g,"^^");
	   }
		 var ajaxRequest;
	     try{
				ajaxRequest = new XMLHttpRequest();
	        }  
         catch (e)
            {
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

				  var queryString = "?"+type+"=" +SelValue1+"&global="+aa1+"&newglobal="+bb1;
          	ajaxRequest.open("GET", "getDropdownItems.jsp" + queryString, true);
          	ajaxRequest.send(null); 
          	ajaxRequest.onreadystatechange = function()
            {
                   if(ajaxRequest.readyState == 4)
                   {
                           var reslt=ajaxRequest.responseText;
                           if(type=='group')
                           document.getElementById("make").innerHTML=reslt;

                           else if(type=='make')
                               document.getElementById("model").innerHTML=reslt;
                           
                           else if(type=='model')
                           {
                        	   var mySplitResult = reslt.split("##");
                              document.getElementById("Description").innerHTML=mySplitResult[0];
                               document.getElementById("partNo").innerHTML=mySplitResult[1];
                           }
                   }
       }
}catch(e){alert(e)}
} 
</script>