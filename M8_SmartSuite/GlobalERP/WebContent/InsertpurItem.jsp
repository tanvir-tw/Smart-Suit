<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function insertin(groupCode,groupName,makeCode,makeName)
{
	var model=document.ledgerDetails.model1.value; //alert(model);
    var partno=document.ledgerDetails.partno.value; //alert(partno);
    var description=document.ledgerDetails.description.value; //alert(description);
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
        var queryString = "?action=check&groupCode="+groupCode+"&groupName="+groupName+"&makeCode="+makeCode+"&makeName="+makeName+"&model="+model+"&partno="+partno+"&description="+description;
    	ajaxRequest.open("GET", "GetModel.jsp" + queryString, true);
    	ajaxRequest.send(null); 
    	alert("Model,Partno,Description Saved Successfully..");
    	//window.opener.location.reload();
        setTimeout('self.close()',5);
		//document.getElementById("itementry").style.visibility="hidden"; 
    	       	
}
function addnewitems(groupCode,groupName,makeCode,makeName)
{
 	 var model=document.ledgerDetails.model1.value; //alert(model);
     var partno=document.ledgerDetails.partno.value; //alert(partno);
     var description=document.ledgerDetails.description.value; //alert(description);
     var flag=false;
     
     if(model!="")
     {
        //alert("Please Enter Model");
        //return false;
         flag=true;
     }
     else if(partno!="")
     {
         flag=true;
         
     }
     if(flag==false)
     {
         alert("Please Enter Either Model Or PartNo");
         return false;
     }
     if(description=="")
     {
         alert("Please Enter Description");
         return false;
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
         var queryString = "?action=add&groupCode="+groupCode+"&groupName="+groupName+"&makeCode="+makeCode+"&makeName="+makeName+"&model="+model+"&partno="+partno+"&description="+description;
         //alert(queryString);
     	ajaxRequest.open("GET", "GetModel.jsp" + queryString, true);
     	//System.out.println(ajaxRequest.open("GET", "GetDropMake.jsp" + queryString, true));
     	ajaxRequest.send(null); 
     	ajaxRequest.onreadystatechange = function()
       {
              if(ajaxRequest.readyState == 4)
              {
                    var reslt=ajaxRequest.responseText;
                    //alert(reslt);
                   	var data=reslt.split("#");
    				//alert("<*****  "+data);
    				if(data[1].indexOf('Yes')!=-1)
    				{
        				alert("Model,Part,Description Already Exist!");
        				//document.getElementById("itementry").style.visibility="hidden"; 
    				}
    				else
    				{
        				var agree= confirm("Model,Part,Description Not Exists, Do You want to Save?");
        				if(agree)
        				{
                           insertin(groupCode,groupName,makeCode,makeName);
            		    }
        				else
        				{
        					setTimeout('self.close()',5); 
        				}
    				}
                      
              }
       }
 }

</script>
</body>
<%
   int groupCode=Integer.parseInt(request.getParameter("groupCode"));
   int makeCode=Integer.parseInt(request.getParameter("makeCode"));
   String makeName=request.getParameter("makeName");
   String groupName=request.getParameter("groupName");
%>
<form name='ledgerDetails' action="" method="post" >
<table style="font-family: arial;font-size:8;"align="center"><tr><td align="center">Item Entry</td></tr>
 </table>
<div id="itementry" style="position:absolute;margin-top:2%;margin-left:3%;margin-right:3%;background-color:#94ECF6;border:solid thin black;font-family: arial;font-size:8;">
    <table style="width:100%;font-family: arial;font-size:12px;"> 
 	<tr>
			<td>The Model:</td>
			<td><input type="text" name="model1" id="model1" 
				value="" size="16" /></td>
			<td></td>
		</tr> 
        <tr>
			<td>The PartNo:</td>
			<td><input type="text" name="partno" id="partno"
				value="" size="16" /></td>
			<td></td>
		</tr>
		<tr>
			<td >Description:</td>
			<td><input type="text" name="description" id="description"
				value="" size="16" /></td>
			<td></td>
		</tr>
		
        
        <tr></tr>
        <tr></tr>
		<tr>
			<td></td>
			<td>
			<table>
			<tr>
			<td colspan="3" align="left">
			<input type="button" name="Ok" id="ok" value="Ok" style="width: 80;" onclick="addnewitems('<%=groupCode %>','<%=groupName %>','<%=makeCode %>','<%=makeName %>');"/>
			</td>
			</tr>
			</table>
			</td>
		</tr>
	</table>
 </div>
 </form>
</html>