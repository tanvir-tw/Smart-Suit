<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<html>
<style type="text/css">

.inputbox {
vertical-align: left;
}


</style>
<body onload="resetAll();" style="font-family:arial;">


<script type="text/javascript">
var counter=1;
function popup(webadd)
{
	var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
    var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
    //alert(groupCode+""+groupName+""+makeCode+""+makeName);
	window.open(webadd+'?groupCode='+groupCode+'&groupName='+groupName+'&makeCode='+makeCode+'&makeName='+makeName,'item','width=300,height=200,top=300,left=600,resizable=no');
}
function addRow()
{
	 
	var quantity=document.ledgerDetails.quantity.value;
    var g=document.getElementById("group").value;
    //var mke=document.getElementById("make1").value;
    //var mod=document.getElementById("model1").value;
    //var prt=document.getElementById("partNo1").value;
    //var d=document.getElementById("Description1").value;
	 var oth=quantity.replace(/^\s\s*/, '').replace(/\s\s*$/, '');



	    if(g=="" || g=="Select")
	    {
		    alert("Please select group");
		    return false;
	    }


	    
/*
	    if(mke=="" || mke=="Select")
	    {
		    alert("Please select make");
		    return false;
	    }
	    if(mod=="" || mod=="Select")
	    {
		    alert("Please select model");
		    return false;
	    }
	    if(prt=="" || prt=="Select")
	    {
		    alert("Please select part no");
		    return false;
	    }

	    if(d=="" || d=="Select")
	    {
		    alert("Please select description");
		    return false;
	    }
		}catch(e)
		{
			alert(e);
		}
*/

var desc=document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value.split("::")[0];

if(desc=="-")
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

//alert("Before is " +document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value);


	       
	    


//alert(desc);



		

		
		//alert(quantity);
		var modelNotKnown="false";
		if(document.ledgerDetails.modelNotKnown.checked)
			modelNotKnown="true";
	      //alert(modelNotKnown);                                                                                                     	
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
            //var tab = document.getElementById(tableID);
            //var rowCnt = tab.rows.length;
			desc=desc.replace("+","^^");
			//alert(desc);
	        var queryString = "?make="+makeCode+"&group="+groupCode+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown="+modelNotKnown;
            //alert(queryString);
            counter++;
	       	ajaxRequest.open("GET", "AjaxSalesEnq.jsp" + queryString, true);
	       	ajaxRequest.send(null); 
	       	ajaxRequest.onreadystatechange = function()
	         {
	                if(ajaxRequest.readyState == 4)
	                {
	                        var reslt=ajaxRequest.responseText;
	                        //alert(reslt);
	                        var data=reslt.split("#");
	                        if(data[1].indexOf('Yes')!=-1)
	                        {
		                        alert("Item Saved Successfully.....");
		                        window.opener.location.reload();
		                        setTimeout('self.close()',5);              
			                        
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
    alert("dropdown is"+dropdown);
	alert("type is"+type);
try{
	var vv1=dropdown.selectedIndex;
	alert("selected index is   "+vv1);
	var SelValue1 = dropdown.options[vv1].value;
	alert("selected value is  "+SelValue1);
	globalmodel=SelValue1;
	var ab="partNo";
	alert("ABABAB   "+ ab);
	alert("GLOBAL MODEL   "+globalmodel);
	if(SelValue1=="Select")
	{
		alert("in  if(SelValue1==Select)");
		if(type=='group')
		{
		
		
			 document.getElementById("partNo").innerHTML=
			 document.getElementById("make").innerHTML=
			 document.getElementById("Description").innerHTML=
			 document.getElementById("model").innerHTML
						 ="<select  style='width: 150px; height:20px;  "+
      		 	 " border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif;   "+
    			 " color: #000000;'></select>";
		}
           else if(type=='make')
        {			
        		//alert("Q");
   				 document.getElementById("partNo").innerHTML=
   				 document.getElementById("Description").innerHTML=
   				 document.getElementById("model").innerHTML
   							 ="<select  style='width: 150px; height:20px;  "+
   	      		 	 " border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif;   "+
   	    			 " color: #000000;'></select>";
        }
            
           else if(type=='model')
        {			
        	  	// globalmodel=document.getElementById("model").value;
        	
             	 document.getElementById("partNo").innerHTML=
   				 document.getElementById("model").innerHTML	 
   							 ="<select  style='width: 150px; height:20px;  "+
   	      		 	 " border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif;   "+
   	    			 " color: #000000;'></select>";
        }

        
        
	}

	   else if(type.length==ab.length)
       {	
             alert("in if(type.length==ab.length)"); 
            //  alert(")))))))))))))))))))   ");		
          	  	// globalmodel=document.getElementById("model").value;
          	
            aa1=document.ledgerDetails.modelList.value;
				//alert("MODEL LISTT      "+aa1);
	  }

	   else if(type=="description")
       {	
           alert("in type=description");       	
		   bb1=document.getElementById("DescriptionList").value;
		   /* SelValue1=bb1.replaceAll("+","^^"); - replaceAll() is not a function in javascript */
		   SelValue1 = bb1.replace(/\+/g,"^^");
		   /*SelValue1 = bb1.replace('+','^^');*/
		   alert("description is"+SelValue1);//changed          
				//alert("DESC   LISTT      "+bb1);
	   }
    
     
	
	//    else 
//{
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

         			//window.open(Address+'?companyName='+companyName+'&SalesEnqNo='+SalesEnqNo+'&SalesEnqRefNo='+SalesEnqRefNo);
				  alert("qs"+type+"="+SelValue1+"global="+aa1+"newglobal="+bb1);
				  var queryString = "?"+type+"=" +SelValue1+"&global="+aa1+"&newglobal="+bb1;
				  
			     //  alert(type.length  +  "========="  +aa1);
			      // alert(type.length  +  "========="  +bb1);
          	ajaxRequest.open("GET", "getDropdownItems.jsp" + queryString, true);
          	ajaxRequest.send(null); 
          	ajaxRequest.onreadystatechange = function()
            {
                   if(ajaxRequest.readyState == 4)
                   {
                           var reslt=ajaxRequest.responseText;
                         //  alert(reslt);
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

                          else if(type=='partNo')
                           {
                              document.getElementById("Description").innerHTML=reslt;
                               
                           }
                           
                     else if(type=='description')
                           {
                         // alert("IN PART No");
                             document.getElementById("partNo").innerHTML=reslt;
                           }
                           
              			   
                           
                   }
       }
//	}
	
}catch(e){alert(e)}
} 

</script>
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
		Connection conn = null;
		Statement st = null;
		Format format=new SimpleDateFormat("dd-MMM-yyyy");
		Format parse=new SimpleDateFormat("yyyy-MM-dd");
		String fromDate="",toDate="",fromDateCal="",toDateCal="";
		String companyName="",phone="",contact="",email="",product="",city="";
		Date today = new Date();
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
 		try 
 		{
				conn = erp.ReturnConnection();
				st = conn.createStatement();
		} 
 		catch (Exception e) 
 		{
		
 		}
%>
<form name='ledgerDetails' action="" onsubmit="return validate();" method="post">

<div style="font-family: arial;font-size:16px;margin-left: 30%;" >Enquiry Entry</div>  
<div style="margin-left: 40%;"><font face="Arial" size="2" color="black" >(<font color="red"> *</font> indicates mandatory fields)</font></div>  

 
<div id="dataentry" style="position:absolute;margin-top:2%;margin-left:5%;margin-right:5%;background-color:#94ECF6;border:solid thin black;">
    <table style="width:100%;font-family:arial;font-size:12px;" align="center" border="0" > 
 	<tr>   
         <td align="left" style="font-family: arial;font-size: 8;">Group :<font color="red"> *</font></td>
         
         <td style="font-family: arial;font-size: 12px;">
         <select name="group" id="group" style="width: 150px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; 
		 color: #000000; " onchange="OnChangeGetDetails(this,'group');">
		 
		 <option value='Select' selected="selected" >Select</option>
		 	
		 	<%
 		  	String sqlGroup="SELECT distinct(TheGroupName),TheGroupCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster ";
 			ResultSet rsGroup=st.executeQuery(sqlGroup);
 			while(rsGroup.next())
 			{
 			%>
 			<option value="<%=rsGroup.getString(2)+"::"+rsGroup.getString(1) %>"><%=rsGroup.getString(1) %></option>
 			<%
 			}
 			%>
 			</select>
 			
 			
 			
 			
 			
 			<input type="checkbox" name="modelNotKnown" value="modelNotKnown"  /> &nbsp; 
	    	 Model Not Known
	 </td>
	 </tr>
	 <tr>
          <td align="left" style="font-family: arial;font-size: 8;">Make :
          </td>
          <td style="font-family: arial;font-size: 8;">  
          <div id="make">
	            <select name="make1" id="make1" style="width: 150px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; color: #000000; ">
		        </select>
         </div>
         <div id=""><!-- <b>Type:</b> --><input type="hidden" name="Type" id="search-text"/></div></td>
     </tr>
     <tr>
          <td align="left" style="font-family: arial;font-size: 8;">Model :
          </td>
          <td style="font-family: arial;font-size: 8;">
	      <div id="model">
	               <select name="model1" id="model1" style="width: 150px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; color: #000000; " >
   		           </select>
   		           
		  </div>
		  <div id=""><!--  <b>Service:</b>--> 
				<input type="hidden" name="Service" id="search-text"/>
		 </div><a href="#" style="font-weight: bold;" onclick="popup('InsertSalesItem.jsp');" >Add New Item</a>
		  </td>
     </tr>
     <tr>
           <td valign="top" style="font-family: arial;font-size: 8;">PartNo :</td>  
             <td style="font-family: arial;font-size: 8;">
             <div id="partNo">
	             <select name="partNo1" id="partNo1" style="width: 200px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; ">
			 </select>
		 </div>
		 </td>
	 </tr>
 	 <tr> 
        <td style="font-family: arial;font-size: 8;">Description :<font color="red"> *</font></td> 
        <td align="left" style="font-family: arial;font-size: 8;">
        <div id="Description">
        <select name="Description1" id="Description1" style="word-wrap: break-word;width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
         color: #000000; ">
	    </select>
	    </div>
	    </td>
	 </tr>
	 <tr>
	     <td valign="top" style="font-family: arial;font-size: 8;">Specification :
	     </td>
	     
	     <td>
	     <textarea name="specification"  rows="2" cols="30" style="text-align: left;" ></textarea>
		 	      
         </td>
         
     </tr>
     <tr>
           <td align="left" valign="middle" style="font-family: arial;font-size: 8;">
						 Quantity :<font color="red"> *</font> &nbsp;
			</td>
			<td>
			<input type="text" name="quantity" id="search-text" style="width: 188px;" />
			</td>
	 </tr>
     </table>
     <table style="width:100%;font-family: arial;font-size: 8;" align="center">
	  	<tr>
			<td style="width:100px;font-family: arial;font-size: 8;">
			</td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 <input type="button" name="add" value="Add Entry"  onclick="addRow()"  style="width:80px; "/>
			</td>
			<td>
			</td>
		</tr>
	</table>
 </div>
</form>
</body>
</html>
</jsp:useBean>