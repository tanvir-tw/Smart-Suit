<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

<head>
<style>
#PurchaseMenu
{
margin-right: 15px; 
}
</style>
</head>
	<body onLoad="resetAll();">

<script type="text/javascript">
/* function fun(){
	alert("--");
	var v=document.getElementById("search").value;
	alert(v);
	
} */
function showItemDetails(item,searchBy)
{
	alert(item);
	//alert(searchBy);
	//window.location="?item="+item+"&searchBy="+searchBy;
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	   // document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
	   //alert(xmlhttp.responseText);
	   document.getElementById("tempList").innerHTML = xmlhttp.responseText;
	   searchPut();
	   
	   //alert(document.getElementById("groupname").value);
	    }
	  }
	xmlhttp.open("Post","searchitem.jsp?item="+item+"&searchBy="+searchBy,true);
	xmlhttp.send();
}
/* function searchPut(){
	alert(document.getElementById("groupname1").value);
	document.getElementById("group").value=document.getElementById("groupname1").value;
	document.getElementById("makenew").value;
} */


function showSupplier(){
	

	//alert("2");
}

function fun(){
	
	var item=document.getElementById("search1").value;
	//alert(item);
	if(item.length==0){
		
		document.getElementById("itemDescription").innerHTML="";
	}
	else{
		
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
			document.getElementById("itemDescription").innerHTML=reslt;
			//alert(reslt);
		} 
	}
	
	var queryString = "?item=" +item+"&searchBy=item";
	ajaxRequest.open("GET", "AjaxGetItemListWithInfo.jsp" + queryString, true);
	ajaxRequest.send(null); 

	document.getElementById("itemDescription").style.visibility="visible";
	}


}
</script>



	<script language="JavaScript1.2">
	var counter=1;

	function toggleDetails(show)
	{	
	//	alert("**********************   ");
	//	document.getElementById("a1").value=sachin;
		//alert(">>>>    "+document.getElementById("a1").value);
		var popupx = document.getElementById("popupx");
		if (show) {
			popupx.style.visibility = "visible";
			popupx.setfocus();

			/*details(webadd,group)
			{
				window.open(webadd+'?group='+group,'jav','height=550,width=600,scrollable=yes,resizable=yes');
			}*/
			
		} else {
			popupx.style.visibility = "hidden";
		}
	}


	function cancelentryform()
	{
		document.getElementById("popupx").style.visibility="hidden";
	}
	
function resetAll()
{
	document.purchaseDetails.specification.value="";
	document.purchaseDetails.quantity.value="";
	document.purchaseDetails.Description.value="";
	document.purchaseDetails.partNo.value="";
}
function validate()
{
	//alert(document.getElementById("companyList").innerHTML);
	var supp = document.getElementById("companyList").innerHTML;
	var rcnt = document.getElementById("rcnt").value;
	//alert(supp);
	
	/* if(supp.trim()=="" || supp==null) 
	 {  
		 alert("Please select atleast one Supplier!");   return false; 	//Supplier Selection not compulsary Hence remove validations
	 } */
	 
	if(rcnt== "0") 
	 {  
		 alert("Please add atleast one enquiry!");   return false; 	
	 }
	/*var company=document.purchaseDetails.companyName.value;
	 if(company=="") 
	 {  
		 alert("Please Select Company");   return false; 	
	 }*/
	return true;		
}
function insert(rcnt,counter){
	//alert(rcnt+"--"+counter);
	
	var model=document.getElementById("modelnew").value;
	var grpname=document.getElementById("groupname1").value;
    var makenm=document.getElementById("makenew").value;
    //alert("A");
    var makecode1=document.getElementById("makecode1").value;
    var groupcode1=document.getElementById("groupcode1").value;
   // alert("B");	
    
    //alert(person);
    var partn=document.getElementById("part").value;
    var desc=document.getElementById("description").value;
    
    var quantity = prompt("Please enter Quantity For "+desc, "0");
// 	var specification = prompt("Please enter Specification For "+desc, "test");
	
	if(quantity){
		var specification = prompt("Please enter Specification For "+desc, "test");
		if(specification){
			
		}else{
			var rowCount1 = document.getElementById("dataTable").rows.length;
			--rowCount1;
			document.getElementById("dataTable").deleteRow(rowCount1)
			
		}
	} else {
		//alert(rcnt+"--"+counter);
		//cancel('dataTable',rcnt);
		//krn(rcnt);
		var rowCount1 = document.getElementById("dataTable").rows.length;
		//alert(--rowCount1);
		--rowCount1;
		document.getElementById("dataTable").deleteRow(rowCount1)
		//alert("Done");
		
	}
	
	var system = document.getElementById("system").value;
	alert("Project Name:"+system)
    
    //alert("C");
    
    /* Do changes from here */
	document.getElementById("quantity"+rcnt).value=quantity;
	document.getElementById("specification"+rcnt).value=specification;
    //alert(person1);
  //  alert(groupcode1+"----"+makecode1);
   
   // alert("D");
    
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
     //  alert("E");
   
 var table = document.getElementById("dataTable");
 var rowCnt = table.rows.length;

 
 
 
 
 
       //alert("F");
       ajaxRequest.onreadystatechange=function()
       {
       if (ajaxRequest.readyState==4 && ajaxRequest.status==200)
         {
       // alert("Added");
         }
       }
       //alert("G");//system
       //var queryString = "?make="+makecode1+"&group="+groupcode1+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown=false&specification="+specification;
      	var queryString = "?make="+makecode1+"&group="+groupcode1+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown=false&specification="+specification+"&system="+system;
       ajaxRequest.open("GET", "AjaxPurEnq.jsp" + queryString, true);
      	ajaxRequest.send();
      	//alert("H");
}
function krn(rcnt){
	document.getElementById("dataTable").deleteRow(rcnt)
		
	rcnt--;
	
}
function searchPut()
{	
	// alert("hehe");
	 //alert(document.getElementById("groupname1").value);
	 
	 			
	 								var rcnt = parseInt(document.getElementById("rcnt").value);
	 								//alert(rcnt);
		  							rcnt = rcnt + 1;
		  							//alert(rcnt);
		  							document.getElementById("rcnt").value = rcnt;
		  							//alert(rcnt);
			                        var table = document.getElementById("dataTable");
		//	                        alert("hehe 1");	
			                        var rowCount = table.rows.length;
			                        var row = table.insertRow(rowCount);

					                        
			                        var cell1 = row.insertCell(0);
			                	   var element1=document.createElement("input") ;
			                        element1.type = "checkbox";
			                       element1.name = "chk";
			                       cell1.appendChild(element1);
			                      //  cell1.innerHTML = "<div align='left'><a href=#><img src=images/delete.JPG  width=20px height=18px style=border-style: none  onclick=deleteRow('dataTable')></img></a></div>";

									var model=document.getElementById("modelnew").value;
									if (typeof(model) == "undefined") {
											model="";
										}
									
			                        var cell2 = row.insertCell(1);
			                        cell2.innerHTML = counter++ ;

			                        var cell3 = row.insertCell(2);
			                        cell3.innerHTML = "<div align='left'>"+document.getElementById("groupname1").value+"</a></div>";

			                        var cell4 = row.insertCell(3);
			                        cell4.innerHTML = "<div align='left'>"+document.getElementById("makenew").value+"</a></div>";
			                        
			                        var cell5 = row.insertCell(4);
			                        cell5.innerHTML = "<div align='left'>"+model+"</a></div>";
		
			                        var cell6 = row.insertCell(5);
			                        cell6.innerHTML =  "<div align='left'>"+document.getElementById("part").value+"</a></div>";
                       
			                        var cell7 = row.insertCell(6);
			                        cell7.innerHTML = "<div align='left'>"+document.getElementById("description").value+"</a></div>";
			                       // cell7.innerHTML = "<div align='left'><a href=#  onclick='toggleDetails("+desc+",true)'  title='Click To See the Details'>"+desc+"</a></div>";
           
			                        var cell8 = row.insertCell(7);
			                        cell8.innerHTML =  "<input type='text' name='quantity' id='quantity"+rcnt+"' size='3' readonly>";
		
			                        var cell9 = row.insertCell(8);
			                        cell9.innerHTML =  "<input type='text' name='specification' id='specification"+rcnt+"'  readonly> ";
	                        
			                       // alert("haha");
			    					insert(rcnt,counter);
	            									            
	         
			                        
}



	
function addRow(tableID)
{
	//alert("IN FUB");
	try{
		  if(document.getElementById("group").options[document.getElementById("group").selectedIndex].value=='Select')
		  {
			  alert("Please select group!");
			  return(false);
		  }
		  /*
		  if(document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value== '0::1::a::0')
		  {
			  alert("Please select make!");
			  return(false);
		  }

		  if(document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value==null)
		  {
			  alert("Please select model!");
			  return(false);
		  }
		  if(document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value==null)
		  {
			  alert("Please select part No!");
			  return(false);
		  }*/
		  if(document.purchaseDetails.quantity.value=='')
		  {
			  alert("Please enter Quantity");
			  return(false);
		  }
	}catch(e)
	{
		alert(e);
	}	  

		  var rcnt = parseInt(document.getElementById("rcnt").value);
		  rcnt = rcnt + 1;
		  //alert(rcnt);	
		  document.getElementById("rcnt").value = rcnt;
		  //alert(document.getElementById("rcnt").value);
		  
	    var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
	    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];

        document.purchaseDetails.a1.value=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
		//alert(document.purchaseDetails.a1.value);

	    
	    var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
	    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
		var model=document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value.split("::")[0];
		//alert("?????????  /  "+model);
		var partNo=document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value.split("::")[0];        
		//alert(partNo);
		var desc=document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value.split("::")[0];
	    var specification=document.getElementById("specification").value;
		var quantity=document.purchaseDetails.quantity.value;
		var modelNotKnown="false";
		if(document.purchaseDetails.modelNotKnown.checked)
			modelNotKnown="true";
	                                                                                                           	
	    var system = document.getElementById("system").value;
		
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
            var tab = document.getElementById(tableID);
            var rowCnt = tab.rows.length;
			
	        //var queryString = "?make="+makeCode+"&group="+groupCode+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown="+modelNotKnown+"&specification="+specification;
	       	var queryString = "?make="+makeCode+"&group="+groupCode+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown="+modelNotKnown+"&specification="+specification+"&system="+system;
	        /* alert(queryString); */
	        ajaxRequest.open("GET", "AjaxPurEnq.jsp" + queryString, true);
	       	ajaxRequest.send(null); 
	       	ajaxRequest.onreadystatechange = function()
	         {
	                if(ajaxRequest.readyState == 4)
	                {
	                        var reslt=ajaxRequest.responseText;
	                        var data=reslt.split("#");
	                        if(data[1].indexOf('Yes')!=-1)
	                        {
			                        var table = document.getElementById(tableID);
		
			                        var rowCount = table.rows.length;
			                        var row = table.insertRow(rowCount);

					                        
			                        var cell1 = row.insertCell(0);
			                	   var element1=document.createElement("input") ;
			                        element1.type = "checkbox";
			                       element1.name = "chk";
			                       cell1.appendChild(element1);
			                      //  cell1.innerHTML = "<div align='left'><a href=#><img src=images/delete.JPG  width=20px height=18px style=border-style: none  onclick=deleteRow('dataTable')></img></a></div>";


			                        var cell2 = row.insertCell(1);
			                        cell2.innerHTML = counter++ ;

			                        var cell3 = row.insertCell(2);
			                        cell3.innerHTML = "<div align='left'>"+groupName+"</a></div>";

			                        var cell4 = row.insertCell(3);
			                        cell4.innerHTML = "<div align='left'>"+makeName+"</a></div>";
			                        
			                        var cell5 = row.insertCell(4);
			                        cell5.innerHTML = "<div align='left'>"+model+"</a></div>";
		
			                        var cell6 = row.insertCell(5);
			                        cell6.innerHTML =  "<div align='left'>"+partNo+"</a></div>";
                       
			                        var cell7 = row.insertCell(6);
			                        cell7.innerHTML = "<div align='left'>"+desc+"</a></div>";
			                       // cell7.innerHTML = "<div align='left'><a href=#  onclick='toggleDetails("+desc+",true)'  title='Click To See the Details'>"+desc+"</a></div>";
           
			                        var cell8 = row.insertCell(7);
			                        cell8.innerHTML =  "<div align='right'>"+quantity+"</div>";
		
			                        var cell9 = row.insertCell(8);
			                        cell9.innerHTML =  "<div align='left'>"+specification+"</div>";
	                        }
	                        else
		                        alert("!!! ERROR while adding data to GRID due to Server Side problem. Please try again.");
	                        

	                        
	                }
	         
	         }
	    	
	       	document.getElementById("purchaseEntry").style.visibility="hidden"; 
	
}
      
function checkAll()
{
		   
			  var field=document.getElementsByName('chk');
				var i;
				try{
			  for (i = 0; i < field.length; i++)
			  		 field[i].checked = true ;
				}catch(e){alert(e);}
}
	  
function unCheckAll()
{
		   
			  var field=document.getElementsByName('chk');
				var i;
				try{
			  for (i = 0; i < field.length; i++)
			  		 field[i].checked = false ;
				}catch(e){alert(e);}
}
function deleteRow(tableID) 
{
	//alert("IN  ");
		try {

			var rcnt = parseInt(document.getElementById("rcnt").value);
			  rcnt = rcnt - 1;
			 // alert(rcnt);	
			  document.getElementById("rcnt").value = rcnt;
			 // alert(document.getElementById("rcnt").value);
			 
        	 
          var table = document.getElementById(tableID);
        //  var rowcntfirst=
          //alert("BEFORE    "+rowcntfirst);
          var rowCount= table.rows.length;
          for(var i=0; i<rowCount; i++) {
              var row = table.rows[i];
              var chkbox = row.cells[0].childNodes[0];
              if(null != chkbox && true == chkbox.checked) {
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
			                     
			         	        var queryString = "?delete=yes&srno="+i;
			         	      //  alert("QUERY STRING     "+queryString);
			         	       	ajaxRequest.open("GET", "AjaxPurEnq.jsp" + queryString, true);
			         	       	ajaxRequest.send(null); 
			         	       	ajaxRequest.onreadystatechange = function()
			         	         {
			         	                if(ajaxRequest.readyState == 4)
			         	                {
			         	                        var reslt=ajaxRequest.responseText;
			         	                       // alert(reslt);
			         	                        var data=reslt.split("#");
			         	                        if(data[1].indexOf('Yes')!=-1)
			         	                        {
			         	                        	document.purchaseDetails.status=data[1];
			         	                        }
			         	                        else
			         		                        alert("!!! ERROR while removing data from GRID due to Server Side problem. Please try again.");
			         	                }
			         	      }
if(document.purchaseDetails.status!="")
{
	table.deleteRow(i);

}
rowCount--;
 i--;
             			 }
         	 		}
          }catch(e) {
              alert(e);
          }
      }

function OnChangeGetDetails(dropdown,type)
{
	var aa1;
	var bb1;
    //	alert(dropdown);
	//alert(type);
try{
	var vv1=dropdown.selectedIndex;
	//alert("11   "+vv1);
	var SelValue1 = dropdown.options[vv1].value;
	//alert("22  "+SelValue1);
	globalmodel=SelValue1;
	var ab="partNo";
//	alert("ABABAB   "+ ab);
	//alert("GLOBAL MODEL   "+globalmodel);
	if(SelValue1=="Select")
	{
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
              
            //  alert(")))))))))))))))))))   ");		
          	  	// globalmodel=document.getElementById("model").value;
          	
            //aa1=document.ledgerDetails.modelList.value;
            aa1=document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value;
				//alert("MODEL LISTT      "+aa1);
	  }

	   else if(type=="description")
       {	
                   	
		   bb1=document.getElementById("DescriptionList").value;
		   SelValue1=bb1.replace("+","^^");
		             
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
                              document.getElementById("partNo").innerHTML=reslt;
                               
                           }
                           
                     else if(type=='description')
                           {
                         // alert("IN PART No");
                             document.getElementById("Description").innerHTML=reslt;
                           }
                           
              			   
                           
                   }
       }
//	}
	
}catch(e){alert(e)}
} 

function getCompanies()
{
		//alert("TYYYYYYY");
		
document.getElementById('companyList').style.visibility = 'visible';
			var company=document.purchaseDetails.companyNames.value;

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
				
			}
			else
			{
				document.getElementById('companyList').style.visibility = 'visible';
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
			var queryString = "?company=" +company;
			ajaxRequest.open("GET", "AjaxGetSuppliers.jsp" + queryString, true);
			ajaxRequest.send(null);

			}//end of else 
		
}
		
function showSelectedSuppliers(companyCode,companyName)
{
	//alert("IN FUNCTIOn");
	//document.getElementById('showList').style.visibility='visible';
	
	document.purchaseDetails.supplierName.value=companyName;
	document.getElementById('companyList').style.height = '10px'; 
	document.getElementById('companyList').style.visibility = 'hidden';
	
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
		//	var data=reslt.split("#");
			document.purchaseDetails.companyName.value=data[1];
			document.purchaseDetails.companyName.value=data[2];
		}
	}
	var queryString = "?companyName=" +companyName;
	ajaxRequest.open("GET", "AjaxShowVisitingCard.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}	


function addRowForSupplier(suppliercode,tableID,suppliername) 
{
//	alert("IN TABLE  ");
	
	document.purchaseDetails.supplier.value=document.purchaseDetails.supplier.value+","+suppliername;
	document.getElementById('companyList').style.visibility = 'hidden';

    var table = document.getElementById(tableID);
   // alert("11111  ");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    
    //var cell1 = row.insertCell(0);
   // var element1 = document.createElement("input");
    //element1.type = "checkbox";
    //cell1.appendChild(element1);
    
    var cell2 = row.insertCell(0);
    cell2.innerHTML = suppliername;
 //   alert("after table   ");
    if(listTable==null)
    {
    	listTable=suppliername;
    }
    else
    {
    	listTable=listTable+","+suppliername;
    	
    }
	
    /* alert(suppliername); */
    
}

function deleteRowForSupplier(tableID) 
{
    try {
	 
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;

    for(var i=0; i<rowCount; i++) 
    {
        var row = table.rows[i];
        var chkbox = row.cells[0].childNodes[0];
		
        if(null != chkbox && true == chkbox.checked) 
        {
        	table.deleteRow(i);
        	//===get Employee name for selected row=====
    		var cell = row.cells[1];
    		var content = cell.childNodes[0].nodeValue;
    		if(delEmployee==null)
    		{
    			delEmployee=content;
    		}
    		else
    		{
    			delEmployee=delEmployee+","+content;
    		}
    		modifyEmployee(employeeList,delEmployee);
            //==========================================
            rowCount--;
            i--;
        }
    }
    }catch(e) {
        alert(e);
    }
}

function popup()
{
	document.getElementById("purchaseEntry").style.visibility="visible";
}

function cancelentryform()
{
	document.getElementById("purchaseEntry").style.visibility="hidden";
}

function popup1()
{
	window.open('AllPurchaseModule.jsp');
}

function popupForNewItems(webadd)
{

	var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
//	alert(groupCode);
//	alert(groupName);
     var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
  //  alert(groupCode+"  "+groupName+"   "+makeCode+"    "+makeName);
	window.open(webadd+'?groupCode='+groupCode+'&groupName='+groupName+'&makeCode='+makeCode+'&makeName='+makeName,'item','width=300,height=150,top=300,left=600,resizable=no');

}
//if (document.all || document.getElementById)
//		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>
<script>
function other(){
	var sys = document.getElementById("system").value;
	if(sys=="Other" || sys=="other"){
		document.getElementById("othersys").style.visibility="visible";
		document.getElementById("otherlabel").style.visibility="visible";
	}else{
		document.getElementById("othersys").style.visibility="hidden";
		document.getElementById("otherlabel").style.visibility="hidden";
	}
}
</script>


 	<!-- end #header --> <!-- end #page --></div>
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
         // erp.getConnection(DB_Driver, "jdbc:mysql://167.86.78.93/db_GlobalERP?autoReconnect=true&useSSL=false", "fleetview", "1@flv");
%>
<%
		String com=(String)session.getAttribute("CompanyMasterID");
       Connection conn = null;
	   conn = erp.ReturnConnection();
	   Statement st = null;
	   Statement st1 = null;
	   Statement stSystem = null;
	   st1=conn.createStatement();
	   ResultSet rs=null;
	   ResultSet rs1=null;
	   Format format=new SimpleDateFormat("dd-MMM-yyyy");
	   Format parse=new SimpleDateFormat("yyyy-MM-dd");
	   String fromDate="",toDate="",fromDateCal="",toDateCal="";
	   String companyName="",phone="",contact="",email="",product="",city="";
	   String supplier[]={};
	   
	   
	   String aaa=request.getParameter("a1");
	   System.out.println("AAAAAAAAAAAAAAA      AA "+aaa);
%>
<!-- this is for search items -->
<%-- <%
if(request.getParameter("item")!=null && request.getParameter("supplier")==null) {
	 String item=request.getParameter("item");
		String  searchBy=request.getParameter("searchBy");
	System.out.println(item+"----------------"+searchBy);	
String sql="";
	
item=item.replace("`","\"").replace("~","&");  
if(searchBy.equalsIgnoreCase("Item"))	   
	sql="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  t_search WHERE Description='"+item+"' ORDER BY Description";
System.out.println("sql------"+sql);
rs1=st1.executeQuery(sql);
int i=1;
String make="",model="",itemSelected="",part="";
while(rs1.next())
{
	make=rs1.getString("makecode");
	itemSelected=rs1.getString("ItemCode");
	model=rs1.getString("Model") ;
	part=rs1.getString("PartNo");
	%><table>
 		  <tr>
   				<td><div align='left'><%=i %></div></td>
			   <td align='left'><div align='left'>
			    <%
			    item=item.replaceAll("\"","`").replaceAll("~","&");
			    //System.out.println("|||||||| "+make+" "+rs.getString("groupcode")+" "+itemSelected+" "+item+" "+rs.getString("makename")+" "+part+" "+rs.getString("Description")); %>
			    <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs1.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs1.getString("makename") %>','<%=part %>');">  <%=rs1.getString("groupcode")%></a>
			     
			    </td>
			   <td align='left'> <div align='left'> <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs1.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs1.getString("makename") %>','<%=part %>');"> <%=rs1.getString("makename")	%></a></div></td>
			   <td align='right'><div align='right'><a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs1.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs1.getString("makename") %>','<%=part %>');"> <%=model %></a></div></td>
			   <td align='right'><div align='right'><a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs1.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs1.getString("makename") %>','<%=part %>');"> <%=part	%></a></div></td>
			   <td align='left'> <div align='left'> <a href="#" style="color: black; "  onclick="frmSubmit('<%=make %>','<%=rs1.getString("groupcode") %>','<%=itemSelected %>','<%=item %>','<%=rs1.getString("makename") %>','<%=part %>');"> <%=rs1.getString("Description")	%></a></div></td>
			   <td align='left'> <input type="text" id="quantity" name="quantity"/></td>
				
			 </tr></table>
			 <%
   i++;
}
if(i==1){
	%>
	<tr><td colspan="8">.</td><td colspan="8"><b>--- NO DATA ---</b></td></tr>
	<%} %>

		 </table>
	 <%}
		%>
 --%>


<%
	
	   Date today = new Date();
	   fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
  	
	     try{ 
		   	 	conn = erp.ReturnConnection();
			 	st = conn.createStatement();
			 	stSystem = conn.createStatement();
			} catch (Exception e) {
			}
 
			String sqlCreateTmpTable="" +
			//"	CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") + " ( " +
			"	CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") + "_PRN( " +
			" srno INT(10) NOT NULL, " +
			" TheGroup VARCHAR(50) NULL, " +
			" make VARCHAR(50) NULL, " +
			" model VARCHAR(50) NULL, " +
			" partno VARCHAR(50) NULL, " +			
			" description VARCHAR(255)	NULL, " +
			" Specifications VARCHAR(255)	NULL,"+
			" System_name VARCHAR(255)	NULL,"+
			" quantity VARCHAR(50) NULL,  " +
			" modelNotKnown boolean NULL  " +
			")";
			
		/*
		try
			{
				st.executeUpdate("DROP table tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".",""));
			}catch(Exception e)
			{
				System.out.println(e);
			}*/
			
			st.executeUpdate(sqlCreateTmpTable);
			System.out.println(sqlCreateTmpTable);
	%>
<div style="font-size: 1.6em; text-align: center;"> 
		 Purchase Requisition  
 </div>
 <div align="right" id="PurchaseMenu"><a href="#" onclick="popup1();"><font color="blue";><u>GO TO PURCHASE MENU</u></font></a>
</div> 


<form name='purchaseDetails' action="insertPurchasePRNEnquiry.jsp?export=No" onsubmit="return validate();" method="post" >
<input type="hidden" name="a1" id="a1" value=""/>
<input type="hidden" name="supplier" id="supplier" value="" style="font-color: red;"/>


  <table align="center" width="80%" border="0" style="background-color: #C6DEFF;" cellpadding="0" cellspacing="0">
  
  <tr>
  <td align="left" rowspan="0" style="width: 60px;">
         
               <table  valign="top" border="0" cellpadding="0" cellspacing="0">
        		<tr> 
 
						<td align="left"><b><font color="blue">Cust Ref No:</font></b></td><td align="left">
						<div id="customerRefNumber">
						<input type="text" name="customerRefNumber" id="search-text"  
								  value='-'  style="width: 125px;" />
						</div>
						</td>
  				
 							
 					 <td align="left"><!-- <b><font color="blue">Due Date:</font></b> --></td><td>
					 <div id="seRefNo">
					 <%-- <input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputFieldPRN Enquiry  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script> --%></div></td>
 				</tr>   
 		 				<tr>

			<td align="left" ><b><font color="blue">Remarks:</font></b></td><td rowspan="3" colspan="2" valign="top">
					 <div id="remarks">
					 <textarea name="remarks" id="search-text" rows="2" 
								     style=" width: 255px; height: 40px;" ></textarea>
					  </div></td>
					  
					  
					  
					 </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
					 <tr> 
					<td style="color:blue;font-weight:bold">Search Items:</td>
					<td><input type="text" id="search1" name="search1" onkeyup="fun()" style="width: 100%;border: 1px solid;"/></td></tr><tr>
	    			<td style="color:blue;font-weight:bold"> Project Name:</td>
	    			<td>
	    			<select name="system" id="system" onclick="other()">
	    			 <%
							  String sqlSystem="select SystemName from db_GlobalERP.100000SystemMaster";
							   ResultSet rsSystem=stSystem.executeQuery(sqlSystem);
							   while(rsSystem.next())
							   {
							%>
					           <option value="<%=rsSystem.getString("SystemName")%>"><%=rsSystem.getString("SystemName")%></option>
							 <%
							   }
							 %>
	    			
	    			</select></td><td style="color:blue;font-weight:bold;visibility:hidden" id="otherlabel">Other System:</td><td><input type="text" style="visibility:hidden" name="othersys" id="othersys" /></td>
 				</tr>   
 		<tr><td>&nbsp;<input type="hidden" name="status" id="status" value="" /></td></tr>

       </table>
  	</td>
  
  	<td  valign="top" >
  	 							<div id="companyNames" ><b>Select multiple Supplier :<!-- <font color="red">*</font> --></b> 
								<input type="text" name="companyNames" id="search-text"  style="width: 150px;" 
									onkeyup="getCompanies()" /></div>
	
	
							<div id='companyList' style="width: 350px;position: absolute;" >
							</div>
							
<!--							 <div style="border-style:none; width: 220px; overflow: auto;position: absolute; autocomplete="off"">-->
<!--							  </div>-->
	</td>
	
    <td  valign="top">
    
          <table id="listTable" border='0' valign="top" align="left" style="background-color: #94ECF6;border: 1em;">
          <div><b><font size="3" color="blue">List Of Suppliers : </font></b></div>
		 <tr>
		 </tr>
		 </table>
         
   
    </td>
 
  </tr>
   </table>
 
 
 
 <div id='itemDescription' style="margin-left: 14%;background-color: aliceblue;width: 76%;"></div> 
     <div id="purchaseEntry" style="position:absolute;margin-left:330px ;margin-top:40px;background-color:#94ECF6;border:solid thin black;">

       
           <table align="left" valign="top" border="0" width="100%;"> 
 		   <tr>   
                 <td align="left"><b>Group <font color="red">*</font></b></td>
                   <td><select name="group" id="group" style="width: 150px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; 
		 color: #000000; " onchange="OnChangeGetDetails(this,'group');">
		 <option value='Select' >Select</option>
 <%
 int rcnt = 0;
 String sqlGroup="SELECT distinct(TheGroupName),TheGroupCode FROM  "+com+"tbl_groupmaster where Status='Active' order by TheGroupName asc ";
 ResultSet rsGroup=st.executeQuery(sqlGroup);
 while(rsGroup.next())
 {
 %>
 
 <option value="<%=rsGroup.getString(2)+"::"+rsGroup.getString(1) %>"><%=rsGroup.getString(1) %></option>
 <%
 }
 %>
 </select></td>
<td colspan="4"><input type="button" name="cancel" id="cancel" value="X"  onclick="cancelentryform()" style="width:20; color:red;" />

  		      </tr>
  		         
             <tr>   
                <td align="left"><b>Make <font color="red">*</font></b></td>
                <td>
                <div id="make">
	                <select name="make" id="make" style="width: 150px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			        color: #000000; ">
			        
			        </select>
		        </div>
		        </td>
		        <td align="left" style="display: none;"><div id=""><b>Type:</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="text" name="Type" id="search-text"/></div></td>
        	</tr>
        	<tr>
               <td align="left"><b>Model <font color="red">*</font></b></td>
               
              <td>
	                <div id="model">
	                <select name="model" id="model" style="width: 150px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			         color: #000000; " >
			         </select>
			         </div>
		      </td>
		      <td align="left" style="display: none;"><div id=""><b>Service:</b> &nbsp;
							<input type="text" name="Service" id="search-text"/></div></td>
		    </tr>
		    <tr>  
		        <td align="left" style="width: 150px;"><input type="checkbox" name="modelNotKnown" value="modelNotKnown"  /> &nbsp; 
		        <b> Model Not Known</b> </td> 
		        <td>
		        <div id=""><!--  <b>Service:</b>--> 
				<input type="hidden" name="Service" id="search-text"/>
		 </div><a href="#" style="font-weight: bold;" onclick="popupForNewItems('InsertSalesItem.jsp');" >Add New Item</a>
	
		        </td>
 			</tr> 
 			<tr>
           <td valign="top"><b>PartNo <font color="red">*</font></b></td>
             <td>
             <div id="partNo">
	             <select name="partNo" id="partNo" style="width: 200px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; ">
			 </select>
		 </div>
		 </td>
	     </tr>
 			
		<tr>
	
             <td><b>Description</b></td>
             <td align="left">
             <div id="Description">
	             <select name="Description" id="Description" style="width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; ">
			     </select>
		     </div>
		    </td>
		 </tr>
		 <tr> 
		      <td><b> Specification:</b></td>
		   <td>
		   <div id="specification">
		       <textarea name="specification" rows="4" id="specification"  style="width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; "></textarea>	      
		      </div>
		      </td>
 
	     </tr>
	
	     <tr>
          <td align="left"><b> Quantity <font color="red">*</font></b></td>
			<td align="left"><input type="text" name="quantity"  id="search-text" style="width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; " /></td>
	     </tr>
	      
 		 <tr>
 		 <td align="left">
			<input type="hidden" name="rcnt" id = "rcnt"   value ='<%=rcnt %>'  />
			</td>
 			 <td align="left">			
			<input type="button" name="add" value="Add" style="border: outset;background-color:#C6DEFF;" onclick="addRow('dataTable')"  />
			</td>
 		</tr>
 </table>  
		
     
    </div>
     <script>document.getElementById("purchaseEntry").style.visibility="hidden";</script>
    
  <table align="center"> 
 <tr>
	<td  align="left">
 			<div id="newentry" style="width:100%;" align="left">
     		<a href="#" style="font-weight: bold; color: blue; " onclick="popup();">
     		(+)
     		</a> 
      		<b><font color="blue">NEW ENTRY </font></b><input type="hidden" name="status" id="status" value="" />
      		</div>
      		</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><div>&nbsp;</div></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td align="right">
		<!--	<input type="button" name="delete" value="Delete" style="border: outset;background-color: #C6DEFF;" onclick="deleteRow('dataTable')" /> -->
			</td> 
		<td align="right">
		<input type="submit" name="submit" value="Save PRN Enquiry" class="formElement" style="border: outset;background-color: #C6DEFF;"/>
			</td></tr>
 </table>
 
		<%
		String paymentVoucher="-";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");

			paymentVoucher="SE";

		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
		com=(String)session.getAttribute("CompanyMasterID");
		
		String sql="SELECT PaymentVoucherNo from "+com+"custpymtagainstinv  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
		  rs=st.executeQuery(sql);
		  if(rs.next())
			  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
		  else
			  paymentVoucher+=date+"001";
		
		%>
		<div align="right">
		<table>
		</table>
		</div>
		
		
		   <div align="right" class=popup id="popupx" style="height:100px;width:300px;position: absolute;margin-left: 65px;margin-top: 0px;">

			    <table width="50%" align="right" border=1 bgcolor="#C6DEFF" cellpadding="0" cellspacing="0" style="position: absolute;">
				
			    <tr><td><div align="center"><a href="#" onclick="details('detailsOfPurEnq.jsp','<%=aaa %>')">Suppliers </a></div></td></tr>
			    <tr><td><div align="center"><a href="#" onclick="details()">POrd</a></div></td></tr>
			    <tr><td><div align="center"><a href="#" onclick="details()">PQuo</a></div></td></tr>
			    <tr><td><div align="center"><a href="#" onclick="details()">PEnq</a></div></td></tr>
			    <tr><td><div align="center"><a href="#" > close </a></div></td></tr>
				</table>
		</div>
<script>document.getElementById("popupx").style.visibility="hidden";</script>
</form>

  
 	<div align="center" style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.5em; height:4px; background-color: #339CCB"></div>

		<table id="dataTable"  border='1px'  class='sortable' >	
		<tr>
		<th style="width: 40px;"><a href="#" onclick="checkAll()"> <font color="white">Chk All</font></a>
		
		</th>
		<th  style="width: 40px;"> Sr no </th>
		<th>Group</th>
		
		<th>Make</th>
		<th>Model</th>
		<th>Part No</th>
		<th>Description</th>
		<th style="width: 40px;"> Quant</th>
		<th >Specifications</th>
		</tr> 
	
	
	
		</table>
		 


<%
try{
	conn.close();
	}catch(Exception e){}
 
%>
<div id='tempList' align="center" style="display: none;"></div>
<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 		<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>
