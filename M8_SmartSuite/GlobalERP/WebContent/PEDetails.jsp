<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	
	<script  type="text/javascript" src="js/sorttable.js"></script>
	
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>
	
	
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>
	<script type="text/javascript">
	var counter=1;
	
	function validatenum(){
		var quantity=document.getElementById("quantity").value;
		if(isNaN(quantity) || quantity==""){
			document.getElementById("err").style.display="";
			document.getElementById("quantity").value="";
			document.getElementById("err1").style.display="";
			return false;
		}else{
			//alert("else");
			document.getElementById("err").style.display="none";
			document.getElementById("err1").style.display="none";
			return true;
		}
	}
// 	function submitfun(){
// 		validatenum();
// 		addRow('dataTable')
// 	}
	function closeEnq()
	{
		//alert("Do YOU want to close This Enquiry??");
		var agree=confirm("Pls Enter Reason For Closing This  Enquiry");
		if (agree)
		{
		document.getElementById("header").style.visibility="visible";
		document.getElementById("cancellingreason").style.visibility="visible";
		document.getElementById("submitbutton").style.visibility="visible";
		return true ;
		}
		else
		return false ;
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
				         	       	ajaxRequest.open("GET", "AjaxSalesEnq_1.jsp" + queryString, true);
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
				         	                        	document.reviceenq.status=data[1];
				         	                        }
				         	                        else
				         		                        alert("!!! ERROR while removing data from GRID due to Server Side problem. Please try again.");
				         	                }
				         	      }
	if(document.reviceenq.status!="")
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
	
	
	function redirect(webadd,purenqrefno,twrefno)
	{
	
		//window.open(webadd+'?purenqrefno='+purenqrefno);
		window.open(webadd+'?purenqrefno='+purenqrefno+'&twrefno='+twrefno);
	}

	function pdfconversion(webadd,purenqrefno,twrefno)
	{
		//alert("++++     %%%%%   s");
		//window.open(webadd+'?purenqrefno='+purenqrefno);
	
		window.open(webadd+'?purenqrefno='+purenqrefno+'&twqrefno='+twrefno);
	}
	function popup()
	{
		document.getElementById("purchaseEntry").style.display='';
	}

	function cancelentryform()
	{
		document.getElementById("purchaseEntry").style.display='none';
		var tmp=document.getElementById("dataTable");
		sorttable.makeSortable(tmp);
		//alert("---");
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
				                        cell2.innerHTML = "<div align='right'>"+counter+++"</a></div>" ;

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
		var c=document.getElementById("intcount").value;
		//alert(c);
		counter=parseInt(++c);
		document.getElementById("intcount").value=c;
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
			  if(document.getElementById("quantity").value=="")
			  {
				  alert("Please enter Quantity");
				  return(false);
			  }
		}catch(e)
		{
			alert("1"+e);
		}	  

			  var rcnt = parseInt(document.getElementById("rcnt").value);
			  rcnt = rcnt + 1;
			  //alert(rcnt);	
			  document.getElementById("rcnt").value = rcnt;
			  //alert(document.getElementById("rcnt").value);
			  
		    var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
		    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];

	        document.reviceenq.a1.value=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
			//alert(document.purchaseDetails.a1.value);

		    
		    var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
		    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
			var model=document.getElementById("modelList").options[document.getElementById("modelList").selectedIndex].value.split("::")[0];
			//alert("?????????  /  "+model);
			var partNo=document.getElementById("partNoList").options[document.getElementById("partNoList").selectedIndex].value.split("::")[0];        
			//alert(partNo);
			var desc=document.getElementById("DescriptionList").options[document.getElementById("DescriptionList").selectedIndex].value.split("::")[0];
		    var specification=document.getElementById("specification").value;
			var quantity=document.reviceenq.quantity.value;
			var modelNotKnown="false";
			if(document.reviceenq.modelNotKnown.checked)
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
	            var tab = document.getElementById(tableID);
	            var rowCnt = tab.rows.length;
				//alert("Counter "+counter);
		        var queryString = "?part="+partNo+"&make="+makeCode+"&group="+groupCode+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown="+modelNotKnown+"&specification="+specification;
		       	 //alert(queryString); 
		        ajaxRequest.open("GET", "AjaxSalesEnq_1.jsp" + queryString, true);
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
				                        cell2.innerHTML = "<div align='right'>"+counter+++"</a></div>";

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
		    	
		       	document.getElementById("purchaseEntry").style.display='none'; 
		
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
	    //alert("-G-"+partn);
	    
	    var quantity = prompt("Please enter Quantity For "+desc, "0");
//	 	var specification = prompt("Please enter Specification For "+desc, "test");
		
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
	      
	       var queryString = "?make="+makecode1+"&part="+partn+"&group="+groupcode1+"&srno="+counter+"&description="+desc+"&quantity="+quantity+"&model="+model+"&modelNotKnown=false&specification="+specification;
	      	ajaxRequest.open("GET", "AjaxSalesEnq_1.jsp" + queryString, true);
	      	ajaxRequest.send();
	      	//alert("H");
	}
	function krn(rcnt){
		document.getElementById("dataTable").deleteRow(rcnt)
			
		rcnt--;
		
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
//		alert("ABABAB   "+ ab);
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
	                              document.getElementById("Description").innerHTML=reslt;
	                               
	                           }
	                           
	                     else if(type=='description')
	                           {
	                         // alert("IN PART No");
	                             document.getElementById("partNo").innerHTML=reslt;
	                           }
	                           
	              			   
	                           
	                   }
	       }
//		}
		
	}catch(e){alert("1"+e)}
	}
	function popupForNewItems(webadd)
	{

		var groupCode=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[0];
	    var groupName=document.getElementById("group").options[document.getElementById("group").selectedIndex].value.split("::")[1];
//		alert(groupCode);
//		alert(groupName);
	     var makeCode=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[3];
	    var makeName=document.getElementById("makeList").options[document.getElementById("makeList").selectedIndex].value.split("::")[0];
	  //  alert(groupCode+"  "+groupName+"   "+makeCode+"    "+makeName);
		window.open(webadd+'?groupCode='+groupCode+'&groupName='+groupName+'&makeCode='+makeCode+'&makeName='+makeName,'item','width=300,height=150,top=300,left=600,resizable=no');

	}
	</script>
	</head>
	<body onload="cancelentryform()">
    <script>document.getElementById("purchaseEntry").style.display='none';</script>
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
	
	int i=0;
		    Connection conn = null;
			Statement st = null,st1=null,st2=null,st3=null,st4=null;
			boolean isInvoiceSelected = false;
			int count=0;
			int d=0;
			Date today = new Date();
			String enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
			String date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enqDate));
			double stpercent=0;
			Date mothafter=new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH,+30);
			Date MonthAsDate=cal.getTime();
			String monthafter=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(MonthAsDate);
			String monthafterInMMM=new SimpleDateFormat("dd-MMM-yyyy hh:mm;ss").format(MonthAsDate);
			System.out.println(monthafterInMMM+"())))))))))))))))))))))  ");
			String discount="";
			Date today1 = new Date();
			String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today1);
			
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
			
			String TWRefNo=request.getParameter("twref");
			String type=request.getParameter("condition");
			System.out.println("TYPE IS    "+type);
			
			String PurEnqRefNumber = request.getParameter("transactionId");
			System.out.println(PurEnqRefNumber);
			
			String supplier=request.getParameter("supplier");
			System.out.println(">>>>>>>>>     "+supplier);
			
			String sqlcd="Select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName='"+supplier+"'";
			ResultSet rscd=st3.executeQuery(sqlcd);
			String scod="";
			String conpersn="";
			String phn="";
			String fx="";
			String add="";
			String cty="";
			String zi="";
			String stat="";
			String cntry="";
			if(rscd.next()){
				
			
			scod=rscd.getString("SupplierCode");
			 conpersn=rscd.getString("ContactPerson");
			 phn=rscd.getString("Phone");
			 fx=rscd.getString("Fax");
			 add=rscd.getString("Address");
			 cty=rscd.getString("City") ;
			 zi=rscd.getString("Zip") ;
			 stat=rscd.getString("State");
			 cntry=rscd.getString("Country");
			}
			
			
			
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",PurQuoNumber="",status="",statusTD="",fromdate="";
			
			
			
	%>
    
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
	
	
	<div align="center" id=" " style="font-size: 1.5em;"><b>Purchase Enquiry : <a><%=request.getParameter("transactionId")%></a></b>
 </a></div>
	
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.6em; height: 3px; background-color: #339CCB">
	</div>
		
		
<%
if(type.contains("null"))
{
%>			

<%
	String PurEnqNumber="",SupplierName="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurchaseEnqNo = '"+ PurEnqRefNumber + "' and a.TWRefNo='"+TWRefNo+"' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DueDate")));
				} catch (Exception e) {
				}
				PurEnqNumber=rsTransaction.getString("PurchaseEnqNo");
				
				TWRefNo=rsTransaction.getString("TWRefNo");
%>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase TWRef No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("TWRefNo")%></label>
			</td>
			<td><b>Purchase Enq Date:</b></td>
			<td><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PurEnqDate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<!-- <td><label><%=rsTransaction.getString("SupplierName")%></label> -->
			<td><label><%=supplier%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><label><%=conpersn%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><label><%=phn%></label></td>
			<td><b> Fax:</b></td>
			<td><label><%=fx%></label></td>
		</tr>
		<tr>
			
			<td><b>Address:</b></td>
			<td><label><%=add%> <%=cty %> <%=zi %>   <%=stat %> <%=cntry %></label>
			</td>
			<td><b>Entered By:</b></td>
			<td><label><%=rsTransaction.getString("SentBy")%></label></td>
			 <td><b> Due Date:</b></td>
			<td><input type="hidden" name="duedate" value="<%=rsTransaction.getString("DueDate")%>"/><label><%=dueDate%></label></td> 
		</tr>
		<tr>
			
		</tr>
					
		<tr>
			<td><b>Status:</b></td>
			<td><label><%=(rsTransaction.getInt("PurEnqClosed") == 0 ? "Open"
											: "Closed")%></label>
			</td>
			
			<td><b>Remarks:</b></td>
			<td><label><%=rsTransaction.getString("Remarks")%></label></td>

		</tr>
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
		  
   
	<table class="sortable">
		<tr>
		<th>Sr. No</th>
			<th>Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<!-- <th>Selling Price</th>
			<th>Price Entered On</th> -->
 
		</tr>
	<%
	i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ PurEnqNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
	
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						while(rsSql.next())
						{
							//System.out.println("karan--"+groupCode); 
						 
						
						
	%>
						<tr>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="right"><%=rsPurDet.getString("Quantity")%></div></td>
							<%-- <td><div align="right"><%=rsSql.getString("SellingPrice")%></div></td>
							<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsSql.getString("EnteredonDate")))%></div></td> --%>
				 	</tr>
<%
						}
					}
		}
	%>

</table>

<br>

 <div align="center" id="printbutton" style="margin-top: 3em;">
	<input type="submit" name="printEnquiry" value="Print" onclick="redirect('printPurchaseEnquiry.jsp','<%=PurEnqRefNumber %>','<%=TWRefNo %>');"  style="border: outset; background-color: #C6DEFF"  />
</div>
<%

String sqlchk = "select * from db_GlobalERP.t_allpendingmailtableERP where subjectline='Request For Quotation-"+TWRefNo+"'";
System.out.println("checkreqsend--->"+sqlchk);
ResultSet rschk = st4.executeQuery(sqlchk);
if(rschk.next()){
	
	//dont give an option to send email
	
}else{
%>
 <div align="center" id="emailbutton" style="margin-top: 3em;">
	<input type="submit" name="emailEnquiry" value="Email" onclick="redirect('emailPurchaseEnquiry.jsp','<%=PurEnqRefNumber %>','<%=TWRefNo %>');"  style="border: outset; background-color: #C6DEFF"  />
</div>
<% } %>


 <div align="center" id="pdfbutton" style="margin-top: 3em;">
	<input type="submit" name="pdfEnquiry" value="PDF" onclick="pdfconversion('pdf_purchaseEnq.jsp','<%=PurEnqRefNumber %>','<%=TWRefNo %>');"  style="border: outset; background-color: #C6DEFF"  />
</div>
<%} %>

	
<%
if(type.contains("close"))
{
	System.out.println("IN CLOSE     ****   ");
	System.out.println("CONATCT    "+conpersn);
	
%>	

<%
	String PurEnqNumber="",SupplierName="",twrefno="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurchaseEnqNo = '"+ PurEnqRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DueDate")));

				} catch (Exception e) {
				}
				PurEnqNumber=rsTransaction.getString("PurchaseEnqNo");
				twrefno=rsTransaction.getString("TWRefNo");
%>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase TWRef No:</b></td>
			<td style="width: 200px;"><label><%=rsTransaction.getString("TWRefNo")%></label>
			</td>
			<td><b>Purchase Enq Date:</b></td>
			<td><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PurEnqDate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<td><label><%=supplier%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><label><%=conpersn%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><label><%=phn%></label></td>
			<td><b> Fax:</b></td>
			<td><label><%=fx%></label></td>
		</tr>
		<tr>
			
			<td><b>Address:</b></td>
			<td><label><%=add %> <%=cty%> <%=zi%> <%=stat %> <%= cntry%>
						</label>
			</td>
			<td><b>Entered By:</b></td>
			<td><label><%=rsTransaction.getString("SentBy")%></label></td>
			 <td><b> Due Date:</b></td>
			<td><input type="hidden" name="duedate" value="<%=rsTransaction.getString("DueDate")%>"/><label><%=dueDate%></label></td>
		</tr>
		<tr>
			
		</tr>
					
		<tr>
			<td><b>Status:</b></td>
			<td><label><%=(rsTransaction.getInt("PurEnqClosed") == 0 ? "Open"
											: "Closed")%></label>
			</td>
			
			<td><b>Remarks:</b></td>
			<td><label><%=rsTransaction.getString("Remarks")%></label></td>

		</tr>
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
		  
   
	<table class="sortable">
		<tr>
		<th>Sr. No</th>
			<th>Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<!-- <th>Selling Price</th>
			<th>Price Entered On</th> -->
		
 
		</tr>
	<%
	i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ PurEnqNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
	
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						while(rsSql.next())
						{
						  
						 
						
						
	%>
						<tr>
							
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="right"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="left"><%=rsPurDet.getString("Quantity")%></div></td>
							<%-- <td><div align="right"><%=rsSql.getString("SellingPrice")%></div></td>
							<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsSql.getString("EnteredonDate")))%></div></td> --%>
				 	</tr>
<%
						}
					}
		}
	%>

</table>
<div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeEnquiry" value="close Enquiry" onclick="closeEnq();"  style="border: outset; background-color: #C6DEFF"  />
</div>

<form name="form2" method="get"  action="closePurEnq.jsp" >

<div align="left"  id="header" style="position:absolute;   font-size: 1.1em"><b> &nbsp;Reason For Cancelling :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>
<div align="left"  id="cancellingreason" name="cancellingreason" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="reasonforcancel"
	id="search-text" style='width: 430px; height: 160px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>

<input type="hidden" name="reasonforcancel" value="reasonforcancel"/>
<input type="hidden" name="purenqno" value="<%=PurEnqNumber %>"/>

<div align="center" id="submitbutton" style="margin-top: 3em;">
	<input type="submit" name="Submit TT" value="Submit Reason" style="border: outset; background-color: #C6DEFF"  />
	<script>document.getElementById("submitbutton").style.visibility="hidden";</script>
</div>
</form>
<%} %>
<%
if(type.contains("revise"))
{
	System.out.println("IN Revise     ****   ");
%>	

<%
    String Terms="";
	String PurEnqNumber="",SupplierName="",twrefno="";
	String sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq  as a RIGHT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) WHERE a.PurchaseEnqNo = '"+ PurEnqRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DueDate")));
				} catch (Exception e) {
				}
				System.out.println("****************dueDate:"+dueDate);
				PurEnqNumber=rsTransaction.getString("PurchaseEnqNo");
				twrefno=rsTransaction.getString("TWRefNo");
%>

  <form name="reviceenq" method="post" action="RevisePurEnq.jsp">
  			
  <input type="hidden" name="a1" id="a1" value=""/>
  
	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Purchase TWRef No:</b></td>
			<td style="width: 200px;"><input type="hidden" name="twref" id="twref" value="<%=rsTransaction.getString("TWRefNo")%>"/><label><%=rsTransaction.getString("TWRefNo")%></label>
			</td>
			<td><b>Purchase Enq Date:</b></td>
			<td><input type="hidden" name="enqdate" id="enqdate" value="<%=rsTransaction.getString("PurEnqDate")%>"/><label><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PurEnqDate")))%></label>
			</td>
			<td><b>Supplier:</b></td>
			<td><label><%=supplier%></label>
			</td>
		</tr>

		<tr>
			<td><b>Contact:</b></td>
			<td><label><%=conpersn%></label>
			</td>
			<td><b>Phone:</b></td>
			<td><label><%=phn%></label></td>
			<td><b> Fax:</b></td>
			<td><label><%=fx%></label></td>
		</tr>
		<tr>
			
			<td><b>Address:</b></td>
			<td><label><%=add%>  <%=cty %> <%=zi %> <%= stat %> <%=cntry %></label>
			</td>
			<td><b>Entered By:</b></td>
			<td><label><%=rsTransaction.getString("SentBy")%></label></td>
			<td><b>Due Date:</b></td>
			<td><input type="hidden" name="duedate" id="duedate" value="<%=rsTransaction.getString("DueDate")%>"/><label><%=dueDate%></label></td>
		</tr>
		<tr>
			
		</tr>
					
		<tr>
			<td><b>Status:</b></td>
			<td><label><%=(rsTransaction.getInt("PurEnqClosed") == 0 ? "Open"
											: "Closed")%></label>
			</td>
			
			<td><b>Remarks:</b></td>
			<td><label><%=rsTransaction.getString("Remarks")%></label></td>

		</tr>
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; margin-bottom: 0.4em; height: 3px; background-color: #339CCB">
	</div>
	<div id="newentry" style="width: 20%;margin-bottom: 6px;" >
     			<input type="button" name="delete" value="Delete" style="border: outset;background-color: #C6DEFF;" onclick="deleteRow('dataTable')" />
     			<a href="#" style="font-weight: bold; color: blue; " onclick="popup();">
     		(+)
     		</a> 
      		<b><font color="blue">NEW ENTRY </font></b><input type="hidden" name="status" id="status" value="" />
      		</div>	  
   
	<table class="sortable" id="dataTable">
		<tr>
<!-- 		<th>Chk</th> -->
<!-- 			<th>Sr.No.</th> -->
<!-- 			<th>Desc</th> -->
<!-- 			<th>Part No </th> -->
<!-- 			<th>Make</th> -->
<!-- 			<th>Model</th> -->
<!-- 			<th>Quantity</th> -->
<!-- 			<th>Specification</th> -->
<!-- 			<th></th> -->
			
			<th>Chk</th>
			<th>Sr.No.</th>
			<th>Group</th>
			<th>Make </th>
			<th>Model</th>
			<th>Part No</th>
			<th>Description</th>
			<th>Quantity</th>
			<th>Spectification</th>
			 
		</tr>
	<%
	i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ PurEnqNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						quantity = rsPurDet.getString("Quantity");
	
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						int karan=0;
						int karan1=0;
						while(rsSql.next())
						{
						  System.out.println("karan----"+groupCode);
							System.out.println(++karan+"********>>>>RecommendedSupp:            "+rsPurDet.getString("RecommendedSupp"));
						
						
	%>
						<tr>
<!-- 			<th>Chk</th> -->
<!-- 			<th>Sr.No.</th> -->
<!-- 			<th>Group</th> -->
<!-- 			<th>Make </th> -->
<!-- 			<th>Model</th> -->
<!-- 			<th>Part No</th> -->
<!-- 			<th>Description</th> -->
<!-- 			<th>Quantity</th> -->
<!-- 			<th>Spectification</th> -->
						
				<%System.out.println("1"); %>
							<td></td>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=groupName %></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="right"><input type="text"  id="quantity<%=d %>" name="quantity<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=rsPurDet.getString("Quantity") +d%>"/></div></td>    
							<td><div align="right"><%=rsSql.getString("EnteredonDate")%></div></td>
				 	</tr>
			<input type="hidden" name="groupcode<%=d %>" id="groupcode<%=d %>" value="<%=groupCode%>"/>
			<input type="hidden" name="makecode<%=d %>" id="makecode<%=d %>" value="<%=makeCode%>"/>
			<input type="hidden" name="itemcode<%=d %>" id="itemcode<%=d %>" value="<%=itemCode%>"/>
			
			<input type="hidden" name="quantity<%=d %>" id=quantity<%=d %>" value="<%=rsPurDet.getString("Quantity") %> "/>
			<input type="hidden" name="landed<%=d %>" id="landed<%=d %>"  value="<%=rsSql.getString("LandedPrice") %> "/>
			<input type="hidden" name="recommended<%=d %>" id="recommended<%=d %>"  value="<%=rsPurDet.getString("RecommendedSupp") %> "/>
			<input type="hidden" name="groupname" id="groupname" value="<%=groupName %>"/>
<%
               d++;
System.out.println("2--"+d); 
						}
								}
				System.out.println("3--"+count);
				count=i-1;
				System.out.println("4--"+count);
	%>
</table>
<%
}
 %><input type="hidden"  id="intcount" value="<%=--i%>"/>


<!-- 			<div id="newentry" style="width: 10%;margin-top: -370px;margin-left: 90%;position:fixed;" > -->
<!--      		<a href="#" style="font-weight: bold; color: blue; " onclick="popup();"> -->
<!--      		(+) -->
<!--      		</a>  -->
<!--       		<b><font color="blue">NEW ENTRY </font></b><input type="hidden" name="status" id="status" value="" /> -->
<!--       		</div> -->
      		     <div id="purchaseEntry" style="position:absolute;margin-left:360px;background-color:#94ECF6;border:solid thin black;">
	           <table align="left" valign="top" border="0" width="100%;"> 
 			   <tr>   
                 <td align="left"><b>Group <font color="red">*</font></b></td>
                   <td><select name="group" id="group" style="width: 150px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; 
		 color: #000000; " onchange="OnChangeGetDetails(this,'group');">
		 <option value='Select' >Select</option>
 <%
 int rcnt = 0;
 String com=session.getAttribute("CompanyMasterID").toString();
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
		       <textarea name="specification" rows="4" id="specification"  style="width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; "></textarea>	      
		      </td>
 
	     </tr>
	
	     <tr>
          <td align="left"><b> Quantity <font color="red">*</font></b><br>
          <p id="err1"  style="display:none;"> &nbsp;</p>
          </td>
			<td align="left"><input type="text" name="quantity"  id="quantity" style="width: 300px; height:20px; border: 1px solid black; font: normal 10px Arial, Helvetica, sans-serif; 
			      color: #000000; " onblur="validatenum()" />
			      <br>
			       <p id="err"  style="display:none;color:red;">* Please enter digit for Quantity</p>
			      </td>
			     
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
      		
	<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
	<input type="hidden" name="count"  id="count" value="<%=count %>"/>
	<input type="hidden" name="PurEnqNumber" id="PurEnqNumber" value="<%=request.getParameter("transactionId") %>"/>
	<br>	
	<div align="center">
	<input type="submit" style="border: outset; background-color: #C6DEFF;width: 165px;margin-top: 22%;"  name="ReviseEnquiry" value="Revise Enquiry" />
	</div>
    </br>

<%}%>
</form>																															
	
<!-- 	<br> </br> </br> <br></br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<br> <br> <br> <br><br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>