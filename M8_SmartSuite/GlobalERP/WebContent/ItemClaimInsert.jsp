<%@  page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="conn.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>

<!-- http://www.codemiles.com/scripting-language/how-to-create-a-mouse-over-drop-down-in-html-t3635.html -->
<style type="text/css">

/* set the menu style */
.menuHead { font-weight: bold; font-size:13px; background-color: #C6DEFF;}
.menuChoices { background-color: #C6DEFF; font-size:13px; width: 100px;}
.menu a {color: #000000; text-decoration: none;}
.menu a:hover 
{
text-decoration: underline;
}
/* position your menus */
#menu1 
{
  position: absolute;width: 100px;
}

</style>
<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
<style>
</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="sorttable.js" type="text/javascript"></script>
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
<script src="dropdown.js" type="text/javascript"></script>
<script type="text/javascript">
var counter=1;
function dateformat(days)
{
       if(days=='Jan')
              return(1);
       else
              if(days=='Feb')
                      return(2);
              else
                      if(days=='Mar')
                              return(3);
                      else
                              if(days=='Apr')
                                      return(4);
                              else
                                      if(days=='May')
                                              return(5);
                                      else
                                              if(days=='Jun')
                                                      return(6);
                                              else
                                                      if(days=='Jul')
                                                              return(7);
                                                      else
                                                              if(days=='Aug')
                                                                      return(8);
                                                              else
                                                                      if(days=='Sep')
                                                                              return(9);
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
function popup(webadd)
{ 
	var claimtype=document.getElementById("claimtype").options[document.getElementById("claimtype").selectedIndex].value;

	if(claimtype=="Select")
	{
      alert("Please Select Claim Type");
	}
	else
	{
		window.open(webadd+'?claimtype='+claimtype ,'jav','width=570,height=350,top=250,left=300,resizable=no,scrollbars=yes');
		
	}
	
}
function showVisitingCardDetails(companyName,id) 
{
        //alert("Value coimin is     "+companyName);
       // alert("ID IS    "+id);
	
    if(id==1)
    { 
    	 document.addDetails.companyNames.value=companyName;
    	document.getElementById("companyList").style.display='none';
    } 
    if(id==2)
    {
        //alert("IN 22   ");
        document.addDetails.companyNames1.value=companyName;
    	document.getElementById("companyList1").style.display='none';
    } 
    if(id==3)
    {
    	 document.addDetails.companyNames2.value=companyName;
    	document.getElementById("companyList2").style.display='none';
    } 
    if(id==4)
    {
    	 document.addDetails.companyNames3.value=companyName;
    	document.getElementById("companyList3").style.display='none';
    } 
    if(id==5)
    {
    	 document.addDetails.companyNames4.value=companyName;
    	document.getElementById("companyList4").style.display='none';
    } 

	


}
function getCompanies(id)
{
	//alert(id);
	
   
    if(id==1)
    {
    	document.getElementById("companyList").style.display='block';
		var company=document.addDetails.companyNames.value;
    }
    if(id==2)
    {
    	document.getElementById("companyList1").style.display='block';
		var company=document.addDetails.companyNames1.value;
    }
    if(id==3)
    {   
    	document.getElementById("companyList2").style.display='block';
		var company=document.addDetails.companyNames2.value;
    }
    if(id==4)
    {
    	document.getElementById("companyList3").style.display='block';
		var company=document.addDetails.companyNames3.value;
    }
    if(id==5)
    {
    	document.getElementById("companyList4").style.display='block';
		var company=document.addDetails.companyNames4.value;
    }
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
				if(id==1)
				{
				document.getElementById("companyList").innerHTML=reslt;
				}
				if(id==2)
				{
					document.getElementById("companyList1").innerHTML=reslt;
				}
				if(id==3)
				{
					document.getElementById("companyList2").innerHTML=reslt;
				}
				if(id==4)
				{
					document.getElementById("companyList3").innerHTML=reslt;
				}
				if(id==5)
				{
					document.getElementById("companyList4").innerHTML=reslt;
				}
			} 
		}
		var queryString = "?company=" +company+"&id="+id;
		ajaxRequest.open("GET", "GetClientForClaim.jsp" + queryString, true);
		ajaxRequest.send(null); 
		//document.getElementById("otherclient").style.visibility="hidden";
}


function validate()
{
       var advance=document.addDetails.advanceTaken.value;
       var numbers =/^[0-9]+(\.[0-9]+)+$/;
    if( advance=='' || advance.match(numbers))
    {
       alert("Advance Amount should be  Numeric & with 2 decimal point");
       return false;
    }
  return true;
}



function chkupload()
{       
	   if(document.getElementById("uploadBill").value=="")
	   		{
				alert("Please Select the file");
				return false;
			}
	   return true;	
 }

function chkupload1()
{       
	if(document.getElementById("uploadBill1").value=="")
	   		{
				alert("Please Select the file");
				return false;
			}
	   return true;	
 }




function addRow(id,mf,action,claimtype,clmrefno)
{		


	//alert("IN FUNCTION>>>> ");
	var filebill=document.getElementById("filebill").value;
	if(filebill==null)
	{filebill=="-";}
	  //  alert(filebill);
	 var SrNo=id;
	 var modiflag = mf;
	 var myaction = action;
	 var dd11,mm1,yy11,mm11;
	 if (modiflag=="N" && action == "POST")
     {
       if(claimtype=="localclaim")
       {
         //  alert(claimtype);
	    var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
	    if(category=="Select")
	    {
		    alert("Please Select Category.");
		    return false;
	    }
	    if(category=="Expense")
	    {
		  // alert("purchase module");
		   var purpose=document.addDetails.localpurpose.value;
		   var billNo=document.addDetails.billno.value;
		   var billDate=document.addDetails.billDate.value;
		   var billAmt=document.addDetails.billamount.value;
		   var remarks=document.addDetails.remarks.value;
		   var billby=document.addDetails.billby.value;
		   //purpose=purpose.replace(/\s/g,"");
		   billNo=billNo.replace(/\s/g,"");
		   billAmt=billAmt.replace(/\s/g,"");
		   //billby=billby.replace(/\s/g,"");
		  
		   //alert("end of purchase");
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   var sChars="'";
		   if(document.getElementById("billDate").value=="")
		      {
		    	  alert("Please Select BillDate ");
		    	  return false;
		      }
		      dd11=billDate.substring(0,2);
		      mm1=billDate.substring(3,6);
		      mm11=dateformat(mm1);///alert(mm11);
		      yy11=billDate.substring(7,11);//alert(yy11);
		      var date=new Date();
		      var month=date.getMonth()+1;
		      var day=date.getDate();
		      var year=date.getFullYear();
		      if(yy11>year)
		      {
		              alert("Selected Bill Date Should Not be Greater Than Todays Date");
		              document.getElementById("billDate").value="";
		              document.getElementById("billDate").focus;
		              return false;
		      }
		      else if(year==yy11)
		      {
		              if(mm11>month)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(mm11==month && year==yy11)
		      {
		              if(dd11>day)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		   if(purpose.length==0)
	       {
		     alert("Please Enter Purpose");
		     return false;
	       }
	        
		    //for (var i = 0; i < purpose.length; i++) 
			//{
		      //  if (iChars.indexOf(purpose.charAt(i)) != -1) 
			   // {
		         //  alert ("Purpose has special characters.These are not allowed.");
		          // return false;
		       // }
		    //}
		  if(billby.length==0)
		       {
			     alert("Please Enter Billby");
			     return false;
		       }
		    for (var i = 0; i < billby.length; i++) 
			{
		        if (iChars.indexOf(billby.charAt(i)) != -1) 
			    {
		           alert ("Billby has special characters.These are not allowed.");
		           return false;
		        }
		    }
		    
		    if(billAmt.length==0)
		       {
			     alert("Please Enter Bill Amount");
			     return false;
		       }
			   billAmt = billAmt.toString();
		       if(isNaN(billAmt))
		       {
			     alert("Please Enter Numeric Value for Bill Amount");
			     return false;
		       }
		       
		    if(billNo.length==0)
		       {
			     alert("Please Enter Bill No.");
			     return false;
		       }
		    for (var i = 0; i < billNo.length; i++) 
			{
		        if (iChars.indexOf(billNo.charAt(i)) != -1) 
			    {
		           alert ("BillNo has special characters.These are not allowed.");
		           return false;
		        }
		    }
		    
	    }
	    else
	    {//alert("11");
		   var purpose=document.addDetails.travelpurpose.value;
		   var mode=document.getElementById("localtravelmode").options[document.getElementById("localtravelmode").selectedIndex].value;
		   var KmTravel=document.addDetails.kmtraveled.value;
		   var billDate=document.addDetails.billDate.value;
		   var billAmt=document.addDetails.claimamt.value;
		   var remarks=document.addDetails.travelremarks.value;
		   var billby=document.addDetails.billbytravel.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   var sChars="'";
		   //purpose=purpose.replace(/\s/g,"");
		   KmTravel=KmTravel.replace(/\s/g,"");
		   billAmt=billAmt.replace(/\s/g,"");
		   //billby=billby.replace(/\s/g,"");
		  
		   
		      if(document.getElementById("billDate").value=="")
		      {
		    	  alert("Please Select BillDate ");
		    	  return false;
		      }
		      dd11=billDate.substring(0,2);
		      mm1=billDate.substring(3,6);
		      mm11=dateformat(mm1);///alert(mm11);
		      yy11=billDate.substring(7,11);//alert(yy11);
		      var date=new Date();
		      var month=date.getMonth()+1;
		      var day=date.getDate();
		      var year=date.getFullYear();
		      if(yy11>year)
		      {
		              alert("Selected Bill Date Should Not be Greater Than Todays Date");
		              document.getElementById("billDate").value="";
		              document.getElementById("billDate").focus;
		              return false;
		      }
		      else if(year==yy11)
		      {
		              if(mm11>month)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(mm11==month && year==yy11)
		      {
		              if(dd11>day)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(purpose.length==0)
		       {
			     alert("Please Enter Purpose");
			     return false;
		       }
		       /*for (var i = 0; i < purpose.length; i++) 
				{
			        if (iChars.indexOf(purpose.charAt(i)) != -1) 
				    {
			           alert ("Purpose has special characters.These are not allowed.");
			           return false;
			        }
			    }*/
		     
			    if(billby.length==0)
			       {
				     alert("Please Enter Billby");
				     return false;
			       }
			       for (var i = 0; i < billby.length; i++) 
					{
				        if (iChars.indexOf(billby.charAt(i)) != -1) 
					    {
				           alert ("Billby has special characters.These are not allowed.");
				           return false;
				        }
				    }
			       if(billAmt.length==0)
			       {
				     alert("Please Enter Claim Amount");
				     return false;
			       }
				   billAmt = billAmt.toString();
			       if(isNaN(billAmt))
			       {
				     alert("Please Enter Numeric Value for Claim Amount");
				     return false;
			       }
			           
			
			       
			  if(KmTravel.length==0)
		       {
			     alert("Please Enter KmTravel");
			     return false;
		       }
		       KmTravel = KmTravel.toString();
		       if(isNaN(KmTravel))
		       {
			     alert("Please Enter Numeric Value for KM Traveled");
			     return false;
		       }
		    
	    }
       }
       else
       {   
	    // alert("travel catagory");
	   var travelcategory=document.getElementById("travelcategory").options[document.getElementById("travelcategory").selectedIndex].value;
	  // alert("travel catagory"+travelcategory);
	   if(travelcategory=="Select")
	   {
		   alert("Please Select Category");
		   return false;
	   }
	   if(travelcategory=="JourneyFare")
	   {
		   var billDate=document.addDetails.billDate.value;
		   var billNo=document.addDetails.billNumber.value;
		   var mode=document.getElementById("travelmode").options[document.getElementById("travelmode").selectedIndex].value;
		   var city=document.addDetails.city.value;
		   var remarks=document.addDetails.billComments.value;
		   var origin=document.addDetails.fromplace.value;
		   var destination=document.addDetails.toplace.value;
		   var fromdate=document.addDetails.fromdate.value;
		   var todate=document.addDetails.todate.value;
		   var hrs=document.addDetails.hrs.value;
		   var hrs1=document.addDetails.hrs1.value;
		   var min=document.addDetails.min.value;
		   var min1=document.addDetails.min1.value;
		   var companyNames=document.addDetails.companyNames.value;
		   var companyNames1=document.addDetails.companyNames1.value;
		   var companyNames2=document.addDetails.companyNames2.value;
		   var companyNames3=document.addDetails.companyNames3.value;
		   var companyNames4=document.addDetails.companyNames4.value;
		   var amount=document.addDetails.amount.value;
		   var billby=document.addDetails.billbyT.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   var sChars="'";
		   billNo=billNo.replace(/\s/g,"");
		   city=city.replace(/\s/g,"");
		   billNo=billNo.replace(/\s/g,"");
		   amount=amount.replace(/\s/g,"");
		   //billby=billby.replace(/\s/g,"");
		   origin=origin.replace(/\s/g,"");
		   destination=destination.replace(/\s/g,"");
		   
	          if(document.getElementById("billDate").value=="")
		      {
		    	  alert("Please Select BillDate ");
		    	  return false;
		      }
		      var dd=billDate.substring(0,2);
		      var mm=billDate.substring(3,6);
		      var mmm=dateformat(mm);//alert(mmm);
		      var yy=billDate.substring(7,11);//alert(yy);
		      var date=new Date();
		      var month=date.getMonth()+1;
		      var day=date.getDate();
		      var year=date.getFullYear();
		      if(yy>year)
		      {
		              alert("Selected Bill Date Should Not be Greater Than Todays Date");
		              document.getElementById("billDate").value="";
		              document.getElementById("billDate").focus;
		              return false;
		      }
		      else if(year==yy)
		      {
		              if(mmm>month)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(mmm==month && year==yy)
		      {
		              if(dd>day)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(city.length==0)
		       {
			     alert("Please Enter City");
			     return false;
		       }
		      if(companyNames.length==0)
		    	  {
		    	  alert("Please Enter Client");
				     return false;
		    	  }
		    for (var i = 0; i < city.length; i++) 
			{
		        if (iChars.indexOf(city.charAt(i)) != -1) 
			    {
		           alert ("City has special characters.These are not allowed.");
		           return false;
		        }
		    }
		    if(billNo.length==0)
		       {
			     alert("Please Enter Bill No.");
			     return false;
		       }
		       billNo = billNo.toString();
		       /*if(isNaN(billNo))
		       {
			     alert("Please Enter Numeric Value for Bill No");
			     return false;
		       }*/
		      
		      if(amount.length==0)
		       {
			     alert("Please Enter Amount");
			     return false;
		       }
			   amount = amount.toString();
		       if(isNaN(amount))
		       {
			     alert("Please Enter Numeric Value For Amount");
			     return false;
		       }
			    
			    if(billby.length==0)
			       {
				     alert("Please Enter Billby");
				     return false;
			       }
			    for (var i = 0; i < billby.length; i++) 
				{
			        if (iChars.indexOf(billby.charAt(i)) != -1) 
				    {
			           alert ("Billby has special characters.These are not allowed.");
			           return false;
			        }
			    }
			    			    
			          var date11=document.getElementById("fromdate").value;
				      var date21=document.getElementById("todate").value;
				      var dm11,dd11,dy11,dm21,dd21,dy21;
				      var dd111,yy111,mm11,mm21,mm111,dd221,yy221,mm221;
				      dd111=date11.substring(0,2);
				      dd221=date21.substring(0,2);
				      mm11=date11.substring(3,6);
				      mm21=date21.substring(3,6);
				      mm111=dateformat(mm11);
				      mm221=dateformat(mm21);
				      yy111=date11.substring(7,11);
				      yy221=date21.substring(7,11);
				      var date1=new Date();
				      var month1=date1.getMonth()+1;
				      var day1=date1.getDate();
				      var year1=date1.getFullYear();
				      if(yy111>year1 || yy221>year1)
				      {
				              alert("Selected Date Should Not be Greater Than Todays Date");
				              document.getElementById("fromdate").value="";
				              document.getElementById("todate").value="";
				              document.getElementById("fromdate").focus;
				              return false;
				      }
				      else if(year1==yy111 && year1==yy221)
				      {
				              if(mm111>month1 || mm221>month1)
				              {
				                      alert("Selected Date Should Not be Greater Than Todays Date");
				                      document.getElementById("fromdate").value="";
				                      document.getElementById("todate").value="";
				                      document.getElementById("fromdate").focus;
				                      return false;
				              }
				      }
				      if(mm111==month1 && mm221==month1)
				      {
				              if(dd111>day1 || dd221>day1)
				              {
				                      alert("Selected Date Should Not be Greater Than Todays Date");
				                      document.getElementById("fromdate").value="";
				                      document.getElementById("todate").value="";
				                      document.getElementById("fromdate").focus;
				                      return false;
				              }
				      }

				      if(yy111 > yy221)
				      {
				              alert("From Date Year Should Not be Greater Than To Date Year");
				              document.getElementById("fromdate").value="";
				              document.getElementById("todate").value="";
				              document.getElementById("fromdate").focus;
				              return false;
				      }
				      else if(year1==yy111 && year1==yy221)
				      {
				               if(mm111>mm221)
				      {
				              alert("From Date Month Should Not be Greater Than To Date Month");
				              document.getElementById("fromdate").value="";
				              document.getElementById("todate").value="";
				              document.getElementById("fromdate").focus;
				              return false;
				      }
				      }
				      if(mm111==month1 && mm221==month1) 
				      {
				              if(yy111==yy221)
				              {
				              if(dd111 > dd221)
				              {
				                      alert("From Date Should Not be Greater Than To Date");
				                      document.getElementById("fromdate").value="";
				                      document.getElementById("todate").value="";
				                      document.getElementById("fromdate").focus;
				                      return false;
				              }
				              }
				      }
				      else
				              if(yy111<yy221)
				              {
				                      return true;
				              }
				      else
				              if(dd111 > dd221)
				      {
				                      if(mm111<mm221)
				                      {
				                              return true;
				                      }
				                      
				              alert("From Date Should Not be Greater Than To Date");
				              document.getElementById("fromdate").value="";
				              document.getElementById("todate").value="";
				              document.getElementById("fromdate").focus;
				              return false;
				      }
				      if(document.getElementById("fromdate").value=="")
				      {
				    	  alert("Please Select FromDate ");
				    	  return false;
				      }
				      if(document.getElementById("todate").value=="")
				      {
				    	  alert("Please Select ToDate ");
				    	  return false;
				      }
				      
				      if(origin.length==0)
				       {
					     alert("Please Enter Origin");
					     return false;
				       }
				    for (var i = 0; i < origin.length; i++) 
					{
				        if (iChars.indexOf(origin.charAt(i)) != -1) 
					    {
				           alert ("Origin has special characters.These are not allowed.");
				           return false;
				        }
				    }
				    if(destination.length==0)
				       {
					     alert("Please Enter Destination");
					     return false;
				       }
				    for (var i = 0; i < destination.length; i++) 
					{
				        if (iChars.indexOf(destination.charAt(i)) != -1) 
					    {
				           alert ("Destination has special characters.These are not allowed.");
				           return false;
				        }
				    }

	   }
	   else
	   {
		   var billDate=document.addDetails.billDate.value;
		   var billNo=document.addDetails.billNumber.value;
		   var city=document.addDetails.city.value;
		   var remarks=document.addDetails.billComments.value;
		   var traveldatetime=document.addDetails.traveldatetime.value;
		   var travelhrs=document.addDetails.travelhrs.value;
		   var travelmin=document.addDetails.travelmin.value;
		   var companyNames=document.addDetails.companyNames.value;
		   var companyNames1=document.addDetails.companyNames1.value;
		   var companyNames2=document.addDetails.companyNames2.value;
		   var companyNames3=document.addDetails.companyNames3.value;
		   var companyNames4=document.addDetails.companyNames4.value;
		   var amount=document.addDetails.amount.value;
		   var billby=document.addDetails.billbyT.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   var sChars="'";
		   
		   city=city.replace(/\s/g,"");
		   billNo=billNo.replace(/\s/g,"");
		   amount=amount.replace(/\s/g,"");
		   //billby=billby.replace(/\s/g,"");
		   
		   
	       if(document.getElementById("billDate").value=="")
		      {
		    	  alert("Please Select BillDate ");
		    	  return false;
		      }
		      var dd=billDate.substring(0,2);
		      var mm=billDate.substring(3,6);
		      var mmm=dateformat(mm);//alert(mmm);
		      var yy=billDate.substring(7,11);//alert(yy);
		      var date=new Date();
		      var month=date.getMonth()+1;
		      var day=date.getDate();
		      var year=date.getFullYear();
		      if(yy>year)
		      {
		              alert("Selected Bill Date Should Not be Greater Than Todays Date");
		              document.getElementById("billDate").value="";
		              document.getElementById("billDate").focus;
		              return false;
		      }
		      else if(year==yy)
		      {
		              if(mmm>month)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      if(mmm==month && year==yy)
		      {
		              if(dd>day)
		              {
		                      alert("Selected Bill Date Should Not be Greater Than Todays Date");
		                      document.getElementById("billDate").value="";
				              document.getElementById("billDate").focus;
		                      return false;
		              }
		      }
		      
		      if(city=='')
		       {
			     alert("Please Enter City");
			     return false;
		       }
		      if(companyNames.length==0)
		    	  {
		    	  alert("Please Enter Company");
				     return false;
		    	  }
		    for (var i = 0; i < city.length; i++) 
			{
		        if (iChars.indexOf(city.charAt(i)) != -1) 
			    {
		           alert ("City has special characters.These are not allowed.");
		           return false;
		        }
		    }
		    
		    if(document.getElementById("traveldatetime").value=="")
		      {
		    	  alert("Please Select Date-Time ");
		    	  return false;
		      }
		      
		      var ddt=traveldatetime.substring(0,2);
		      var mmt=traveldatetime.substring(3,6);
		      var mmmt=dateformat(mmt);//alert(mmm);
		      var yyt=traveldatetime.substring(7,11);//alert(yy);
		      var datet=new Date();
		      var montht=datet.getMonth()+1;
		      var dayt=datet.getDate();
		      var yeart=datet.getFullYear();
		      if(yyt>yeart)
		      {
		              alert("Selected Date-Time Should Not be Greater Than Todays Date");
		              document.getElementById("traveldatetime").value="";
		              document.getElementById("traveldatetime").focus;
		              return false;
		      }
		      else if(yeart==yyt)
		      {
		              if(mmmt>montht)
		              {
		                      alert("Selected Date-Time Should Not be Greater Than Todays Date");
		                      document.getElementById("traveldatetime").value="";
				              document.getElementById("traveldatetime").focus;
		                      return false;
		              }
		      }
		      if(mmmt==montht && yeart==yyt)
		      {
		              if(ddt>dayt)
		              {
		                      alert("Selected Date-Time Should Not be Greater Than Todays Date");
		                      document.getElementById("traveldatetime").value="";
				              document.getElementById("traveldatetime").focus;
		                      return false;
		              }
		      }   

          //************************ Bill date & time should be smaller than claim date****************		      
		      if(yy>yyt)
		      {
		              alert("Bill Date should be Smaller than Claim Date-Time");
		              document.getElementById("traveldatetime").value="";
		              document.getElementById("billDate").value="";
		              document.getElementById("traveldatetime").focus;
		              return false;
		      }
		      else if(yy==yyt)
		      {
		              if(mmm>mmmt)
		              {
		                      alert("Bill Date should be Smaller than Claim Date-Time");
		                      document.getElementById("traveldatetime").value="";
		                      document.getElementById("billDate").value="";
				              document.getElementById("traveldatetime").focus;
		                      return false;
		              }
		      }
		      if(mmm==mmmt && yy==yyt)
		      {
		              if(dd>ddt)
		              {
		                      alert("Bill Date should be Smaller than Claim Date-Time");
		                      document.getElementById("traveldatetime").value="";
		                      document.getElementById("billDate").value="";
				              document.getElementById("traveldatetime").focus;
		                      return false;
		              }
		      }   

		      
               		      
		      
		      if(billNo=='')
		       {
			     alert("Please Enter Bill No.");
			     return false;
		       }
		       billNo = billNo.toString();
		      /* if(isNaN(billNo))
		       {
			     alert("Please Enter Numeric Value for Bill No");
			     return false;
		       }*/
		       
		       if(amount=='')
		       {
			     alert("Please Enter Amount");
			     return false;
		       }
			   amount = amount.toString();
		       if(isNaN(amount))
		       {
			     alert("Please Enter Numeric Value For Amount");
			     return false;
		       }
		    if(billby=='')
		       {
			     alert("Please Enter Billby");
			     return false;
		       }
		    for (var i = 0; i < billby.length; i++) 
			{
		        if (iChars.indexOf(billby.charAt(i)) != -1) 
			    {
		           alert ("Billby has special characters.These are not allowed.");
		           return false;
		        }
		    }
		     			   
	   }
       }

     }
	//	alert("end of if function")
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
			//alert("function is not ready ready");
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{
				//alert("function ready");
				if(ajaxRequest.readyState == 4)
				{
					//alert("ready state is 4");
					var reslt=ajaxRequest.responseText;
					//alert(">>>    "+reslt);
					var data=reslt.split("#");
					//alert("<*****  "+data);
					if(data[1].indexOf('Yes')!=-1)
					{
						//var id1=reslt[0]
						//alert(data[0]);
						if (modiflag=="N" && action == "POST")
	                    {
                            alert("Claim Details Save successfully");
							 //window.opener.location.reload();
							 
							 if(clmrefno=="-")
							 { 
								 //alert(">>>>>>>>clmrefno:"+clmrefno);
								 window.opener.Reload(data[0]);	 
							 }
							 else
							 {
								 window.opener.location.reload();
							 }
							 //window.close();      
							 setTimeout('self.close()',5);              
	                    }
	                    else
		                 {
	                    	//window.opener=self;
	                    	//window.close();
		                 }
						if (modiflag=='D' && action == 'GET')
						{
							//var queryString = "?srno="+SrNo;
							//window.location.reload();
						}
					
					}
                  
                   
                   
      			} 
			}
			if (modiflag=='N' && action == 'POST')
			{ 
				//alert("In fun add");
				 if(clmrefno=="-")
				 { 
				try
				{
				var ourcompany=document.getElementById("ourcompany").value;			  
			    //alert(ourcompany);
			    var fromdate1=document.getElementById("fromdate1").value;
			    //alert(fromdate1);
			    var todate1=document.getElementById("todate1").value;
			   //alert(todate1);
			    var advanceTaken=document.getElementById("advanceTaken").value;//alert(advanceTaken);
			    var purposeheader=document.getElementById("purpose").value;//alert(purposeheader);
			    var origin=document.getElementById("origin").value;//alert(origin);
			    var destination=document.getElementById("destination").value;//alert(destination);
			    var filebill=document.getElementById("filebill").value;
			
				}
				catch(e)
				{
					alert(e);
				}
			   if(claimtype=="localclaim")
			   {
				 if(category=="Expense")
				 {
					var queryString = "?action=add&purpose="+purpose+"&billAmt="+billAmt+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&ourcompany="+ourcompany+"&fromdate1="+fromdate1+"&todate1="+todate1+"&advanceTaken="+advanceTaken+"&purposeheader="+purposeheader+"&origin="+origin+"&destination="+destination+"&filebill="+filebill;
				 }
				 else
				 {
					var queryString = "?action=add&purpose="+purpose+"&billAmt="+billAmt+"&KmTravel="+KmTravel+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&mode="+mode+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&ourcompany="+ourcompany+"&fromdate1="+fromdate1+"&todate1="+todate1+"&advanceTaken="+advanceTaken+"&purposeheader="+purposeheader+"&origin="+origin+"&destination="+destination+"&filebill="+filebill;
				 }
			   }
			   else
			   {
				if(travelcategory=="JourneyFare")
				{
					var queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&mode="+mode+"&city="+city+"&origin="+origin+"&destination="+destination+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&ourcompany="+ourcompany+"&fromdate1="+fromdate1+"&todate1="+todate1+"&advanceTaken="+advanceTaken+"&purposeheader="+purposeheader+"&origin="+origin+"&destination="+destination+"&filebill="+filebill;
				}
				else
				{
					var queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&city="+city+"&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&ourcompany="+ourcompany+"&fromdate1="+fromdate1+"&todate1="+todate1+"&advanceTaken="+advanceTaken+"&purposeheader="+purposeheader+"&origin="+origin+"&destination="+destination+"&filebill="+filebill;
				}
			   }
			 } // end if if(clmrefno=="-")
				 else
				 {
					 if(claimtype=="localclaim")
					   {
						 if(category=="Expense")
						 {
							var queryString = "?action=add&purpose="+purpose+"&billAmt="+billAmt+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&filebill="+filebill;
						 }
						 else
						 {
							var queryString = "?action=add&purpose="+purpose+"&billAmt="+billAmt+"&KmTravel="+KmTravel+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&mode="+mode+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&filebill="+filebill;
						 }
					   }
					   else
					   {
						if(travelcategory=="JourneyFare")
						{
							var queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&mode="+mode+"&city="+city+"&origin="+origin+"&destination="+destination+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&filebill="+filebill;
						}
						else
						{
							var queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&city="+city+"&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&clmrefno="+clmrefno+"&billby="+billby+"&filebill="+filebill;
						}
					   }
				 }
				 
			}
			if (modiflag=="N" && action=="GET")
		    {
				//var queryString = "?action=add&srno="+counter+"&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&Comments="+Comments+"&category="+category+"&mode="+mode+"&city="+city+"&fromplace="+fromplace+"&toplace="+toplace+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;

				   //document.addDetails.city.value='';
				   //document.addDetails.fromplace.value='';
				   //document.addDetails.toplace.value='';
				   //document.addDetails.companyNames.value='';
				   document.addDetails.amount.value='';
				   document.addDetails.billNumber.value='';
				   document.addDetails.billComments.value='';
			}
			if (modiflag=='D' && action == 'GET')
			{
                //alert(">>>>>>in Delete");
				var queryString = "?action=delete&srno="+SrNo;
			}
			//alert("quey string ==>"+queryString);
			ajaxRequest.open("GET", "AjaxClaimEnq.jsp" + queryString, true);
			ajaxRequest.send(null); 
		
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
    	document.addDetails.companyNames.value=""; 
    }
}
function getClient2(id)
{ //alert("in2 get"+id);
	if(id=="+")
    {
	document.getElementById("otherclient1").style.display="";
	document.getElementById("client1").style.display='none';
	document.getElementById("client2").style.display="";
    }
	else
    {
    	document.addDetails.companyNames1.value=""; 
    	document.getElementById("otherclient").style.display='none';
    	document.getElementById("client").style.display="";
    	document.getElementById("client1").style.display='none';
    }
	
}
function getClient3(id)
{ //alert("in3 get"+id);
	if(id=="+")
    {
	document.getElementById("otherclient2").style.display="";
	document.getElementById("client2").style.display='none';
	document.getElementById("client3").style.display="";
    }
	else
    {
    	document.addDetails.companyNames2.value=""; 
    	document.getElementById("otherclient1").style.display='none';
    	document.getElementById("client1").style.display="";
    	document.getElementById("client2").style.display='none';
    }
}
function getClient4(id)
{
	if(id=="+")
    {
	document.getElementById("otherclient3").style.display="";
	document.getElementById("client3").style.display='none';
	document.getElementById("client4").style.display="";
    }
	else
    {
    	document.addDetails.companyNames3.value=""; 
    	document.getElementById("otherclient2").style.display='none';
    	document.getElementById("client2").style.display="";
    	document.getElementById("client3").style.display='none';
    }
}
function getClient5(id)
{
    	document.addDetails.companyNames4.value="";  
    	document.getElementById("otherclient3").style.display='none';
    	document.getElementById("client3").style.display="";
    	document.getElementById("client4").style.display='none';
}
function Changing()
{
	var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
    //alert(category);
    if(category=="Select")
    {
    	document.getElementById("mainTable").style.visibility="hidden";
    }
    if(category=="Expense")
    {
    	document.getElementById("B1").style.display="";
   	    document.getElementById("B2").style.display="";
   	    document.getElementById("B3").style.display="";
   	    document.getElementById("B4").style.display="none";
   	    document.getElementById("B5").style.display="none";
   	    document.getElementById("B6").style.display="none";
           
    	/*var startTag="<TABLE id='mainTable'><TBODY><TR><TD style=\"WIDTH: 120px\">User ID</TD><TD style=\"WIDTH: 120px\">User Name</TD><TD style=\"WIDTH: 120px\">Department</TD></TR>"
    	var endTag="</TBODY></TABLE>"*/

    	//alert("1");
    	/*var htmltable="<TABLE id='mainTable'><TBODY><TR><TD><strong><b>Purpose:&nbsp;&nbsp;</b></strong></TD><TD><input type='text' name='localpurpose' id='localpurpose' style=\"width: 170px; height: 15px; padding: 4px 5px 2px 5px; border-color: activeborder; text-align:left;	background: #FFFFFF;font: normal 11px Arial, Helvetica, sans-serif;color: #000000;\"></TD>";
    	htmltable +="<TD><strong><b>BillNo:&nbsp;&nbsp;</b></strong></TD><TD><input type='text' name='billno' id='billno' style=\"width: 170px; height: 15px; padding: 4px 5px 2px 5px; border-color: activeborder; text-align:right;	background: #FFFFFF;font: normal 11px Arial, Helvetica, sans-serif;color: #000000;\"></TD></TR>";
    	htmltable +="<TR><TD><strong><b>BillBy:&nbsp;&nbsp;</b></strong></TD><TD><input type='text' name='billby' id='billby' style=\"width: 170px; height: 15px; padding: 4px 5px 2px 5px; border-color: activeborder; text-align:left;	background: #FFFFFF;font: normal 11px Arial, Helvetica, sans-serif;color: #000000;\"></TD>";
    	htmltable +="<TD><strong><b>Remarks:&nbsp;&nbsp;</b></strong></TD><TD><input type='text' name='remarks' id='remarks' style=\"width: 170px; height: 15px; padding: 4px 5px 2px 5px; border-color: activeborder; text-align:left;	background: #FFFFFF;font: normal 11px Arial, Helvetica, sans-serif;color: #000000;\"></TD></TR>";
    	htmltable +="<TR><TD><strong><b>BillAmount(*):&nbsp;&nbsp;</b></strong></TD><TD><input type='text' name='billamount' id='billamount' style=\"width: 170px; height: 15px; padding: 4px 5px 2px 5px; border-color: activeborder; text-align:right;	background: #FFFFFF;font: normal 11px Arial, Helvetica, sans-serif;color: #000000;\"></TD></TR>";
    	htmltable +="</TBODY></TABLE>";
    	document.getElementById('xyx').innerHTML=htmltable;*/
    }


       if(category=="Travel")
    {
    	document.getElementById("B4").style.display="";
   	    document.getElementById("B5").style.display="";
   	    document.getElementById("B6").style.display="";
   	    document.getElementById("B1").style.display="none";
   	    document.getElementById("B2").style.display="none";
   	    document.getElementById("B3").style.display="none";
    }
}


function ChangingTravelCategory()
{
    var category=document.getElementById("travelcategory").options[document.getElementById("travelcategory").selectedIndex].value;
    if(category=="JourneyFare")
    {

    	document.getElementById("A1").style.display="";
   	    document.getElementById("A4").style.display="";
   	    document.getElementById("A9").style.display="";
   	    document.getElementById("A16").style.display="none";
   	    document.getElementById("A17").style.display="none";
    	
    }
    else
    {
    	 document.getElementById("A1").style.display="none";
    	 document.getElementById("A4").style.display="none";
    	 document.getElementById("A9").style.display="none";
    	 document.getElementById("A16").style.display="";
    	 document.getElementById("A17").style.display="";
    }
    
}


</script>	 
	
<%
     erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
	
<%
     Connection conn = null;
     Statement st = null, st1 = null,st2=null,st3=null,st4=null;
     String selectedName;
     Format format=new SimpleDateFormat("dd-MMM-yyyy");
     Format parse=new SimpleDateFormat("yyyy-MM-dd");
     String fromDate="",toDate="",fromDateCal="",toDateCal="",fromDateCal1="",toDateCal1="",department="",grade="";
     String companyName="",phone="",contact="",email="",product="",city="",companyName1="",amount="",billNo="";

     String VisitCity="",departureDate="",arrivalDate="",purpose="",origin="",destination="",comments="",advanceTaken="",visitTo="";
     String visitTo1="",visitTo2="",visitTo3="",visitTo4="",DateCal="",action="",Client="",hrs="00",hrs1="00",min="00",min1="00",travelhrs="00",travelmin="00";
     String Orgin="",Destn="",claimtype="";
     
     //**************claintype =local traval *****************
     String travelpurpose="",kmtraveled="",localtravelmode="",claimamt="",travelremarks="",billbytravel="";
%>
<%
if (null == request.getParameter("repName"))
selectedName = "All";
else
selectedName = request.getParameter("repName");

try {
conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();
st4 = conn.createStatement();
String sqlCreateTmpTable="";
if (null == request.getParameter("division"))
selectedName = "All";
else
selectedName = request.getParameter("division");
Date today = new Date();
fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
toDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
DateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String EmpName=session.getAttribute("EmpName").toString();
System.out.println(">>>>>EmpName:"+EmpName);
String counter="1",type="";
String sqlGetHistory="",sqlTmpData="",ClaimNo="",clmrefno="";
ResultSet rsCounter;
clmrefno=request.getParameter("clmrefno");
System.out.println(">>>>>>>clmrefno:"+clmrefno);
//*************************This parameter are come from NewClaim.Jsp page by Vikram Abhang
String ourcompany=request.getParameter("ourcompany");
String fromdate1=request.getParameter("fromdate1");
String todate1=request.getParameter("todate1");
advanceTaken=request.getParameter("advanceTaken");
purpose=request.getParameter("purpose");
origin=request.getParameter("origin");
destination=request.getParameter("destination");

System.out.println(ourcompany+""+fromdate1+""+todate1+""+advanceTaken+""+purpose+""+origin+""+destination);

travelpurpose=request.getParameter("travelpurpose");
kmtraveled=request.getParameter("kmtraveled");
localtravelmode=request.getParameter("localtravelmode");
claimamt=request.getParameter("claimamt");
travelremarks=request.getParameter("travelremarks");
billbytravel=request.getParameter("billbytravel");
claimtype=request.getParameter("claimtype");
System.out.println("*****claim type =local traval **fghfghfghgfh***"+claimtype+"   "+travelpurpose+"  "+kmtraveled+"  "+localtravelmode+" "+claimamt+" "+travelremarks+" "+billbytravel);


String travelcategory="",travelmode="",fromdate="",todate="",fromplace="", toplace="";
String traveldatetime="", billNumber="",billbyT="", billComments="", companyNames="";
String companyNames1="",companyNames2="",companyNames3="", companyNames4="";

travelcategory=request.getParameter("travelcategory");     /*   
travelmode=request.getParameter("travelmode");				travelhrs=request.getParameter("travelhrs");  
travelmin=request.getParameter("travelmin");  
hrs=request.getParameter("hrs");											
min=request.getParameter("min");										
							  
hrs1=request.getParameter("hrs1");										  
min1=request.getParameter("min1");*/	
visitTo=request.getParameter("companyNames");  
visitTo1=request.getParameter("companyNames1");  			billNumber=request.getParameter("billNumber");  
visitTo2=request.getParameter("companyNames2");  			amount=request.getParameter("amount");  
city=request.getParameter("city");									        visitTo3=request.getParameter("companyNames3");  
visitTo4=request.getParameter("companyNames4");  			billbyT=request.getParameter("billbyT");
fromplace=request.getParameter("fromplace");					billComments=request.getParameter("billComments");
toplace=request.getParameter("toplace");								traveldatetime=request.getParameter("traveldatetime");
fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");	
//////////////********************************************** end of NewClaim.jsp parameter
///These parameter are hidden are passed to AjaxClaimEnq.Jsp by Vikram Abhang
//+'&fromdate1='+fromdate1+'&todate1='+todate1+'&advanceTaken='+advanceTaken+'&purpose='+purpose+'&origin='+origin+'&destination='+destination
%>
<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}">
<%
if(request.getParameter("claimtype").toString().contains("localclaim"))
{ 
	type="Local Claim";
}
else
{
	type="Travel Claim";
}
String up =request.getParameter("up") ;
if(up!=null)
{%>
<script type="text/javascript">

alert("Bill Upload");
</script>
<%}

%>
<form name="addDetails" method="post"  action="upload.jsp" enctype="multipart/form-data">

    <input type ="hidden" name="clmrefno" id="clmrefno"  value="<%=request.getParameter("clmrefno") %>"/>
	<input type ="hidden" name="status" id="status" value="Open"/>
	<input type="hidden" name="ourcompany" id="ourcompany" value="<%=ourcompany%>"/>
	<input type="hidden" name="fromdate1" id="fromdate1" value="<%=fromdate1 %>"/>
	<input type="hidden" name="todate1" id="todate1" value="<%=todate1 %>"/>
	<input type="hidden" name="purpose" id="purpose" value="<%=purpose%>"/>
	<input type="hidden" name="origin" id="origin" value="<%=origin %>"/>
	<input type="hidden" name="destination" id="destination" value="<%=destination %>"/>
	<input type="hidden" name="advanceTaken" id="advanceTaken" value="<%=advanceTaken %>"/>
    <input type="hidden" name="claimtype" id=claimtype value="<%=claimtype%>"/>
     <input type ="hidden" name="filebill" id="filebill"  value="<%=request.getParameter("filebill") %>"/>
     <input type ="hidden" name="up" id="up"  value="<%=up%>"/>
     
<%
System.out.println(ourcompany+""+fromdate1+""+todate1+""+advanceTaken+""+purpose+""+origin+""+destination+"" +claimtype);
String category="", localpurpose="", billDate="", remark="", billno="", billamount="" ,billby="",remarks="";
category=request.getParameter("category");
localpurpose=request.getParameter("localpurpose");
billDate=request.getParameter("billDate");
remarks=request.getParameter("remark");
billno=request.getParameter("billno");
billamount=request.getParameter("billamount");
billby=request.getParameter("billby");
remarks=request.getParameter("remarks");

//System.out.println("########### billComments"+billComments);
if(category==null || category.equals("null"))
{      if(claimtype=="localclaim"|| claimtype.equalsIgnoreCase("localClaim"))
		{
			category="Expense";
		}
		
		
}

System.out.println("########### claimtype"+claimtype);

if(localpurpose==null ||localpurpose.equals(null))
{
	localpurpose="";
}
if(category==null || category.equals(null))
{
category="";
}
if(billDate==null || billDate.equals(null))
{
billDate=fromDateCal;
}
if(billComments==null || billComments.equals(null))
{
	billComments="";
}
if(billno==null || billno.equals(null))
{
billno="";
}
if(billby==null || billby.equals(null))
{
billby="";
}
if(remarks==null ||remarks.equals(null))
{
remarks="";
}
if(billamount==null || billamount.equals(null))
{
billamount="";
}
if(travelpurpose==null || travelpurpose.equals(null))
{
travelpurpose="";
}
if(kmtraveled==null || kmtraveled.equals(null))
{
kmtraveled="";
}
if(localtravelmode==null || localtravelmode.equals(null))
{
localtravelmode="";
}
if(claimamt==null || claimamt.equals(null))
{
	claimamt="";
}
if(travelremarks==null || travelremarks.equals(null))
{
	travelremarks="";
}
if(billbytravel==null || billbytravel.equals(null))
{
	billbytravel="";
}
if(city==null || city.equals(null))
{
	city="";
}
if(visitTo==null || visitTo.equals(null))
{
	visitTo="";
}
if(visitTo1==null || visitTo1.equals(null))
{
	visitTo1="";
}
if(visitTo2==null || visitTo2.equals(null))
{
	visitTo2="";
}
if(billbyT==null || billbyT.equals(null))
{
	billbyT="";
}
if(amount==null || amount.equals(null))
{
	amount="";
}
if(fromplace==null || fromplace.equals(null))
{
	fromplace="";
}
if(toplace==null || toplace.equals(null))
{
	toplace="";
}
if(billNumber==null || billNumber.equals(null))
{
	billNumber="";
}
if(fromdate==null || fromdate.equals(null))
{
	fromdate=fromDateCal1;
}
if(todate==null || todate.equals(null))
{
	todate=toDateCal1;
}
if(traveldatetime==null || traveldatetime.equals(null))
{
	traveldatetime=DateCal;
}
%>

<%
System.out.println(">>>>SqlClaimDet:"+clmrefno);
   String SqlClaimDet="Select Particulars,City,CompanyName,BillDate,FromPlace,ToPlace,FromDateTime,ToDateTime from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefno+"' and  Cancel='1'";
   System.out.println(">>>>SqlClaimDet:"+SqlClaimDet);
   ResultSet rsClaim=st3.executeQuery(SqlClaimDet);
   while(rsClaim.next())
   {
	   fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getString("BillDate")));
	   String pp=rsClaim.getString("Particulars");
	   if(pp.contains("JourneyFare"))
	   {
		   fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));
		   toDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("ToDateTime")));
	        
		   hrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));
		   hrs1=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("ToDateTime")));
		   min1=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("ToDateTime")));
		   min=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));
           
		   Orgin=rsClaim.getString("FromPlace");
		   Destn=rsClaim.getString("ToPlace");
		   System.out.println(">>>>>>>>>Orgin:"+Orgin);
		   System.out.println(">>>>>>>>>Destn:"+Destn);
		   VisitCity=rsClaim.getString("City");
		   Client=rsClaim.getString("CompanyName");
		   String delims = "[,]+";
		   String[] tokens = Client.split(delims);

			if(tokens.length==1)
			{
				visitTo=tokens[0];
			}
			if(tokens.length==2)
			{
				visitTo=tokens[0];
				visitTo1=tokens[1];
			}
			if(tokens.length==3)
			{
				visitTo=tokens[0];
				visitTo1=tokens[1];
				visitTo2=tokens[2];
			}
			if(tokens.length==4)
			{
				visitTo=tokens[0];
				visitTo1=tokens[1];
				visitTo2=tokens[2];
				visitTo3=tokens[3];
			}
			if(tokens.length==5)
			{
				visitTo=tokens[0];
				visitTo1=tokens[1];
				visitTo2=tokens[2];
				visitTo3=tokens[3];
				visitTo4=tokens[4];
			}
			System.out.println(">>>>>>>>>"+tokens.length);
	   }
	   else if(pp.contains("HotelExpence")||pp.contains("Conveyance")||pp.contains("Stationary")||pp.contains("Miscellaneous"))
	   {
		    DateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));
			travelhrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));
			travelmin=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("FromDateTime")));

			 VisitCity=rsClaim.getString("City");
			   Client=rsClaim.getString("CompanyName");
			   String delims = "[,]+";
			   String[] tokens = Client.split(delims);

				if(tokens.length==1)
				{
					visitTo=tokens[0];
				}
				if(tokens.length==2)
				{
					visitTo=tokens[0];
					visitTo1=tokens[1];
				}
				if(tokens.length==3)
				{
					visitTo=tokens[0];
					visitTo1=tokens[1];
					visitTo2=tokens[2];
				}
				if(tokens.length==4)
				{
					visitTo=tokens[0];
					visitTo1=tokens[1];
					visitTo2=tokens[2];
					visitTo3=tokens[3];
				}
				if(tokens.length==5)
				{
					visitTo=tokens[0];
					visitTo1=tokens[1];
					visitTo2=tokens[2];
					visitTo3=tokens[3];
					visitTo4=tokens[4];
				}
				System.out.println(">>>>>>>>>"+tokens.length);
	   }
	   ///System.out.println(">>>>VisitCity:"+VisitCity);
	   // System.out.println(">>>>Client:"+Client);
	   
   }
   
%>
<%  

 purpose=request.getParameter("purpose");
if(claimtype.contains("localclaim"))
{
	try
	{
%>
<!-- <div id="entryform" style="width:100%; border:thin solid; border-color: blue;position:absolute; border-radius: 12px 12px 12px 12px;"> -->

<table  border="0" align="center" style="width:600px; height:300px; background-color: #C6DEFF;font-family: arial;font-size:8;">
<tr>
<td align="center" style="background-color:white;" colspan="4"><font size="4" color="#C6DEFF"><a><%=type %></a></font></td>
<tr >
<td style="width:100px;"><b>&nbsp;Category:&nbsp;</b><font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td style="width:100px;"><select name="category" id="category" style="width:150px;" class="select"  onchange="Changing()">
	<option value='Expense'>Expense</option>
	<option value='Travel'>Travel</option>
</select>
</td>
<td style="width:70px" align="left"><strong><b>&nbsp;Bill Date:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td style="width:100px" align="left"><input type="text" id="billDate" onmousedown="unCheckAll()" name="billDate" value="<%=billDate%>" size="15"
readonly="readonly" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background-color:#C0C0C0; font: normal 11px Arial, Helvetica, sans-serif;color: #000000 backgroundc: #C6DEFF;border-color: activeborder;" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "billDate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "billDate"       // ID of the button
}
);
</script>
</td>
</tr>


<tr id="B1">
<td  width="5%" align="left" ><strong><b>&nbsp;Purpose:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td  width="5%" align="left" ><input type="text" name="localpurpose" id="localpurpose" class="input"></td>
<td ><strong><b>&nbsp;Bill By:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td ><input type="text" name="billby" id="billby" value="<%=billby%>" class="input"></td>
</tr>
<tr id="B2" >
<td ><strong><b>&nbsp;Bill Amount:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td ><input type="text" name="billamount" id="billamount" value="<%=billamount%>" class="input">
</td>
<td><strong><b>&nbsp;Remarks:&nbsp;&nbsp;</b></strong></td>
<td ><input type="text" name="remarks" id="remarks"  value="<%=remarks%>"class="input"></td>
</tr>
<tr id="B3">
<td  width="5%" align="left"><strong><b>&nbsp;&nbsp;Bill No:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td width="5%" align="left" colspan="3"><input type="text" name="billno" id="billno" value="<%=billno%>" class="input"></td>		
</tr>

<%//***************** fields for category  Traval *************************%>
<tr id="B4">
<td style="width:100px;"><strong><b>&nbsp;Purpose:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td ><input type="text" name="travelpurpose" id="travelpurpose" value="<%=travelpurpose%>" class="input"></td>
<td ><strong><b>&nbsp;Bill By:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td ><input type="text" name="billbytravel" id="billbytravel" value="<%=billbytravel%>" class="input"></td>
</tr>

<tr id="B5">
<td><strong><b>&nbsp;Claim Amount:</b><font color="red">*</font></strong></td>
<td ><input type="text" name="claimamt" id="claimamt" value="<%=claimamt%>" class="input"></td>
<td  ><strong><b>&nbsp;Remark:&nbsp;&nbsp;</b></strong></td>
<td ><input type="text" name="travelremarks" id="travelremarks" value="<%=travelremarks%>" class="input"></td>
</tr>

<tr id="B6">
<td ><b>&nbsp;Mode:</b><font color="red">*</font></td>
<td ><select name="localtravelmode" id="localtravelmode" value="<%=localtravelmode%>" style="width:150px;" class="select" onchange="Changing();">
<option value='Bus'>Bus</option>
<option value='Train'>Train</option>
<option value='Taxi'>Taxi</option>
<option value='Car'>Car</option>
<option value='Auto'>Auto</option>
<option value='Bike'>Bike</option>
</select>
</td>
<td ><strong><b>&nbsp;Km Traveled:&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td ><input type="text" name="kmtraveled" id="kmtraveled" value="<%=kmtraveled%>" class="input"></td>
</tr>

  <tr >
 <% System.out.println(ourcompany+""+fromdate1+""+todate1+""+advanceTaken+""+purpose+""+origin+""+destination);%>
	<td ><strong><b>&nbsp;Upload Bill&nbsp;&nbsp;</b></strong></td>
	<td colspan="3"><input  type ="file" name="uploadBill" id="uploadBill"  />
	<input type ="submit" name="upload" id="upload" value="Upload" onclick="return chkupload();" /></td>
	</tr>
<tr  align="center">

<td colspan ="4" align="center"><input type="button" name="add" value="Submit" Style="border: outset;" onclick="addRow('0','N','POST','<%=claimtype %>','<%=clmrefno %>')"/></td>
</tr>
<tr><td style="background-color: white" colspan="4"><b>Note: 1- All * Fields are Mandatory.</b>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>2- First  upload the bill  for the corresponding claim.</b>
</td>
</tr>
</table>
<%	

if(category.equalsIgnoreCase("Expense"))
{	%>
	<script>
	document.getElementById("category").selectedIndex=0;
	   document.getElementById("B1").style.display="";
	    document.getElementById("B2").style.display="";
	    document.getElementById("B3").style.display="";
	    document.getElementById("B4").style.display="none";
	    document.getElementById("B5").style.display="none";
	    document.getElementById("B6").style.display="none";
	</script>
	<%
}
else
	if(category.equalsIgnoreCase("Travel"))
	{
		//System.out.println("5555555555555555555555");
		%>
		<script>
		
		try
		{document.getElementById("category").selectedIndex=1;
		document.getElementById("B4").style.display="";
   	    document.getElementById("B5").style.display="";
   	    document.getElementById("B6").style.display="";
   	    document.getElementById("B1").style.display="none";
   	    document.getElementById("B2").style.display="none";
   	    document.getElementById("B3").style.display="none";
		}
		catch(e)
		{
			alert(e);
		}
   	    </script>
   	    <%
	}
	}
	catch(Exception e)
	{
		System.out.println("^^^^^^^^^^^^     "+e);
	}
}
//String filebill =request.getParameter("filebill");
//System.out.println("@@@@@@@@ File name @@@@@@@@@"+filebill); %>

<%   // TABLE FOR TRAVAL CLAIM 

if(claimtype.contains("travelclaim"))
{//System.out.println("category========="+travelcategory);
%>
<table  border="0" align="center" style="width:600px; height:300px; background-color: #C6DEFF;font-family: arial;font-size:8;">
<tr>
<td align="center" style="background-color:white;" colspan="5"><font size="4" color="#C6DEFF"><a><%=type %></a></font></td>
</tr>
<tr>           
<td style="width:80px;"><b>&nbsp;Category:</b><font color="red">*</font></td>
<td><select name="travelcategory" id="travelcategory" style="width: 120px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; " onchange="ChangingTravelCategory();">
<%
if(travelcategory==null || travelcategory.equalsIgnoreCase(null))
{%>
<option  value='JourneyFare' selected="selected">Journey Fare</option>
<option  value='HotelExpence'>Hotel Expence</option>
<option  value='Conveyance'>Conveyance</option>
<option  value='Stationary'>Stationary</option>
<option  value='Miscellaneous'>Miscellaneous</option>
<%}
else{
if(travelcategory.equalsIgnoreCase("JourneyFare"))
{System.out.println("category========="+travelcategory.equalsIgnoreCase("JourneyFare"));
%>
<option  value='JourneyFare' selected="selected">Journey Fare</option>
<%
}
else
{
	%>
	<option  value='JourneyFare' selected="selected">Journey Fare</option>
	<%
}

if(travelcategory=="HotelExpence" || travelcategory.equalsIgnoreCase("HotelExpence"))
{
	System.out.println("category========="+travelcategory.equalsIgnoreCase("HotelExpence"));
	//System.out.println(travelcategory=="HotelExpence"); 
	
	%>
	<option  value='HotelExpence' selected="selected">Hotel Expence</option>
	<%
	}
	else
	{
		%>
		<option  value='HotelExpence'>Hotel Expence</option>
		<%
	}
if(travelcategory=="Conveyance" || travelcategory.equalsIgnoreCase("Conveyance"))
{
	%>
	<option  value='Conveyance' selected="selected">Conveyance</option>
	<%
	}
	else
	{
		%>
		<option  value='Conveyance'>Conveyance</option>
		<%
	}
if(travelcategory=="Stationary" || travelcategory.equalsIgnoreCase("Stationary"))
{
	%>
	<option  value='Stationary' selected="selected">Stationary</option>
	<%
	}
	else
	{
		%>
		<option  value='Stationary'>Stationary</option>
		<%
	}
if(travelcategory=="Miscellaneous" || travelcategory.equalsIgnoreCase("Miscellaneous"))
{
	%>
	<option  value='Miscellaneous' selected="selected">Miscellaneous</option>
	<%
	}
	else
	{
		%>
		<option  value='Miscellaneous'>Miscellaneous</option>
		<%
	}
}//end else 
%>

</select>
</td>
<td style="width:80px;"><strong><b>Bill Date:</b><font color="red">*</font></strong></td>
<td><input type="text" id="billDate" onmousedown="unCheckAll()" name="billDate" value="<%=fromDateCal %>" size="15"
readonly="readonly" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;font: normal 11px Arial, Helvetica, sans-serif; background: #DEDEDE;border-color: activeborder;" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "billDate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "billDate"       // ID of the button
}
);
</script>
</td>

<tr id="A14">
<td id="A15"><strong><b>&nbsp;City :</b><font color="red">*</font></strong></td><td><input type="text" name="city" id="city" value="<%=city %>" class="input"/></td>
<td id="A16" style="display:none;"><strong><b>Date-Time:&nbsp;&nbsp;&nbsp;</b><font color="red">*</font></strong></td>
<td id="A17" style="display:none;"><input type="text" id="traveldatetime" onmousedown="unCheckAll()" name="traveldatetime" value="<%=traveldatetime %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; font: normal 11px Arial, Helvetica, sans-serif; background: #DEDEDE;border-color: activeborder;" />

<script type="text/javascript">
Calendar.setup(
{
inputField  : "traveldatetime",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "traveldatetime"       // ID of the button
}
);
</script>
<select name="travelhrs" id="travelhrs" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(travelhrs.contains("00")|| travelhrs=="00")
  {
  for(int i=0;i<60;i++)
  {if(i<10){    
%>
<option value='0<%=i %>'><%=0%><%=i%></option>
<% }else{%>
<option value='<%=i %>'><%=i%></option>
<% }}}
else
{ for(int i=0;i<60;i++)
  {
	if(i<10)
	{
		if(i==Integer.parseInt(travelhrs))
		{
	%>
	<option value='0<%=i %>' selected><%=0%><%=i%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=i %>'><%=0%><%=i%></option>
	<% }
		
	}
	else
	{
		if(i==Integer.parseInt(travelhrs))
        {
%>
        <option value="<%=i%>" selected><%=i%></option>
<%
        }else
        {
                %>
                <option value="<%=i%>"><%=i%></option>
                <%
        }
	}
%>
	
<%}}%>
</select>
<select name="travelmin" id="travelmin" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(travelmin.contains("00")|| travelmin=="00")
  {
	for(int j=0;j<60;j++)
  {if(j<10){    
%>
<option value='0<%=j %>'><%=0%><%=j%></option>
<% }else{%>
<option value='<%=j %>'><%=j%></option>
<% }}}
else
{ for(int j=0;j<60;j++)
  {
	if(j<10)
	{
		if(j==Integer.parseInt(travelmin))
		{
	%>
	<option value='0<%=j %>' selected><%=0%><%=j%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=j %>'><%=0%><%=j%></option>
	<% }
		
	}
	else
	{
		if(j==Integer.parseInt(travelmin))
        {
%>
        <option value="<%=j%>" selected><%=j%></option>
<%
        }else
        {
                %>
                <option value="<%=j%>"><%=j%></option>
                <%
        }
	}
%>
	
<%}}%>
</select>
</td>

</tr>
<tr id="A18">
<td id="A19"><strong><b>&nbsp;Bill No:</b><font color="red">*</font></strong></td>
<td id="A20"><input type="text" name="billNumber" id="billNumber" value="<%=billNumber%>"class="input"/></td>
<td id="A21"><strong><b>Amount:</b><font color="red">*</font></strong></td> 
<td id="A22"><input type="text" name="amount" id="amount" value="<%=amount %>" class="input"/></td>

</tr>
<tr id="A23">
<td id="A24"><strong><b>&nbsp;Bill By:</b><font color="red">*</font></strong></td><td><input type="text" name="billbyT" id="billbyT" value="<%=billbyT %>" class="input"/></td>
<td id="A25"><strong><b>Remarks:
<br>(On Bill)</b></strong></td>
<td><input type="text" name="billComments" id="billComments" value="<%=billComments %>" class="input"/></td>	
</tr>

<tr id="A26">
<td><strong><b>&nbsp;Client :<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;</b></strong></td>
<td>
<input type="text" name="companyNames" id="companyNames" class="input"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies('<%=1%>'); }"> &nbsp;&nbsp;&nbsp;
<div style="position: absolute;">
  <table><tr><td><div id='companyList'></div></td></tr></table></div>
</td>
<td id="A30" ><div id="client"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient1('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient1('-')"><font size="3" ></font></a> </div></td>

<td id="otherclient">

<div >
<input type="text" name="companyNames1" id="companyNames1" class="input"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList1').style.display = 'none';} else { getCompanies('<%=2 %>'); }"> &nbsp;&nbsp;&nbsp;
<div style="position: absolute;">
  <table><tr><td><div id='companyList1'></div></td></tr></table></div>
 </div>
</td>
<td id="A31"><div id="client1"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient2('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient2('-')"><font size="3" >(-)</font></a></div></td>


</tr>

<tr id="A27">
<td ></td>
<td >
<div id="otherclient1">
<input type="text" name="companyNames2" id="companyNames2" class="input"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList2').style.display = 'none';} else { getCompanies('<%=3 %>'); }"> &nbsp;&nbsp;&nbsp;
<div style="position: absolute;">
  <table><tr><td><div id='companyList2'></div></td></tr></table></div>
 </div>
</td>
<td id="A32"> <div id="client2"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient3('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient3('-')"><font size="3" >(-)</font></a></div></td>
<td >
<div id="otherclient2" >
<input type="text" name="companyNames3" id="companyNames3" class="input" value="<%=visitTo3 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList3').style.display = 'none';} else { getCompanies('<%=4 %>'); }"> &nbsp;&nbsp;&nbsp;
<div style="position: absolute;">
  <table><tr><td><div id='companyList3'></div></td></tr></table></div>
</div>
</td>
<td id="A33"><div id="client3"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient4('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient4('-')"><font size="3" >(-)</font></a></div></td>

</tr>
<tr id="A28"">
<td></td>
<td>
<div id="otherclient3">
<input type="text" name="companyNames4" id="companyNames4" class="input" value="<%=visitTo4 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList4').style.display = 'none';} else { getCompanies('<%=5 %>'); }"> &nbsp;&nbsp;&nbsp;
<div style="position: absolute;">
  <table><tr><td><div id='companyList4'></div></td></tr></table></div>
</div>
</td>
<td id="A34""><div id="client4"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient5('-')"><font size="3" >(-)</font></a></div></td>
</tr>

<tr id="A1">
<td id="A2"><strong>&nbsp;Mode:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;</strong> </td>
<td id="A3">
<select name="travelmode" id="travelmode" style="width: 150px;" class="select">
<option value='Bus'>Bus</option>
<option value='Train'>Train</option>
<option value='Air'>Air</option>
<option value='Taxi'>Taxi</option>
<option value='Car'>Car</option>
</select>
</td>

</tr>
<tr id="A4">
<td align="left" id="A5"><strong><b>&nbsp;From:</b><font color="red">*</font></strong></td>
<td id="A6"><input type="text" id="fromdate" onmousedown="unCheckAll()" name="fromdate" value="<%=fromdate %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;background-color: #DEDEDE; font: normal 11px Arial, Helvetica, sans-serif;border-color: activeborder;" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate",         
ifFormat    : "%d-%b-%Y",     
button      : "fromdate"      
}
);
</script>

<select name="hrs" id="hrs" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(hrs.contains("00")|| hrs=="00")
  {
  for(int i=0;i<24;i++)
  {if(i<10){    
%>
<option value='0<%=i %>'><%=0%><%=i%></option>
<% }else{%>
<option value='<%=i %>'><%=i%></option>
<% }}}
else
{ for(int i=0;i<24;i++){
  if(i<10){
  if(i==Integer.parseInt(hrs)){
	%>
	<option value='0<%=i %>' selected><%=0%><%=i%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=i %>'><%=0%><%=i%></option>
	<% }
		
	}
	else
	{
		if(i==Integer.parseInt(hrs))
        {
%>
        <option value="<%=i%>" selected><%=i%></option>
<%
        }else
        {
                %>
                <option value="<%=i%>"><%=i%></option>
                <%
        }
	}
%>	
<%}}%>
</select>
<select name="min" id="min" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(min.contains("00")|| min=="00")
  {
	for(int j=0;j<60;j++)
  {if(j<10){    
%>
<option value='0<%=j %>'><%=0%><%=j%></option>
<% }else{%>
<option value='<%=j %>'><%=j%></option>
<% }}}
else
{ for(int j=0;j<60;j++)
  {
	if(j<10)
	{
		if(j==Integer.parseInt(min))
		{
	%>
	<option value='0<%=j %>' selected><%=0%><%=j%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=j %>'><%=0%><%=j%></option>
	<% }
		
	}
	else
	{
		if(j==Integer.parseInt(min))
        {
%>
        <option value="<%=j%>" selected><%=j%></option>
<%
        }else
        {
                %>
                <option value="<%=j%>"><%=j%></option>
                <%
        }
	}
%>
	
<%}}%>
</select>
</td>
<td id="A7"><strong><b>To: </b><font color="red">*</font></strong></td>
<td id="A8"><input type="text" id="todate" onmousedown="unCheckAll()" name="todate" value="<%=todate%>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; font: normal 11px Arial, Helvetica, sans-serif; background: #DEDEDE;border-color: activeborder;" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate"       // ID of the button
}
);
</script>
<select name="hrs1" id="hrs1" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(hrs1.contains("00")|| hrs1=="00")
  {
  for(int i=0;i<24;i++)
  {if(i<10){    
%>
<option value='0<%=i %>'><%=0%><%=i%></option>
<% }else{%>
<option value='<%=i %>'><%=i%></option>
<% }}}
else
{ for(int i=0;i<24;i++)
  {
	if(i<10)
	{
		if(i==Integer.parseInt(hrs1))
		{
	%>
	<option value='0<%=i %>' selected><%=0%><%=i%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=i %>'><%=0%><%=i%></option>
	<% }
		
	}
	else
	{
		if(i==Integer.parseInt(hrs1))
        {
%>
        <option value="<%=i%>" selected><%=i%></option>
<%
        }else
        {
                %>
                <option value="<%=i%>"><%=i%></option>
                <%
        }
	}
%>
	
<%}}%>
</select>
<select name="min1" id="min1" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%if(min1.contains("00")|| min1=="00")
  {
	for(int j=0;j<60;j++)
  {if(j<10){    
%>
<option value='0<%=j %>'><%=0%><%=j%></option>
<% }else{%>
<option value='<%=j %>'><%=j%></option>
<% }}}
else
{ for(int j=0;j<60;j++)
  {
	if(j<10)
	{
		if(j==Integer.parseInt(min1))
		{
	%>
	<option value='0<%=j %>' selected><%=0%><%=j%></option>
	<% }
	   else
	   {
	   %>
	     <option value='0<%=j %>'><%=0%><%=j%></option>
	<% }
		
	}
	else
	{
		if(j==Integer.parseInt(min1))
        {
%>
        <option value="<%=j%>" selected><%=j%></option>
<%
        }else
        {
                %>
                <option value="<%=j%>"><%=j%></option>
                <%
        }
	}
%>
	
<%}}%>
</select>
</td>
</tr>
<tr id="A9">
<td id="A10"><strong><b>&nbsp;Origin:</b> <font color="red">*</font></strong></td>
<td id="A11"><input type="text" name="fromplace" id="fromplace" value="<%=fromplace %>" class="input"/></td>
<td id="A12"><strong><b>Destination:</b><font color="red">*</font></strong> </td>
<td id="A13"><input type="text" name="toplace" id="toplace" value="<%=toplace %>" class="input"/></td>
</tr>
<%// UPLOAD BILL   %>
<tr>
			<td colspan="4" >
				  		<label ><b>&nbsp;Upload Bill</b> </label>&nbsp;&nbsp;&nbsp;
			            <input id="uploadBill1" name="uploadBill1"  type="file" />
			<input type ="submit" name="upload" id="upload" value="Upload" onclick="return chkupload1();" /></td>
	
</tr>

<tr >
<td colspan="5" align ="center"><input type="button" name="add" value="Submit" Style="border: outset;" onclick="addRow('0','N','POST','<%=claimtype %>','<%=clmrefno %>')" />
</td>
</tr>
<tr style="background-color:white ;"> 
<td colspan="5"><b>Note: 1- All * fields are Mandatory. </b>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>2- First upload the bill for the corresponding claim.</b>
</td>
</tr>
</table>    

</div>
<%


if(travelcategory.equalsIgnoreCase("JourneyFare"))
{
	System.out.println("11111111111111111111"+travelcategory);
	%>
	<script>
		document.getElementById("travelcategory").selectedIndex=0;
		document.getElementById("A1").style.display="";
	    document.getElementById("A4").style.display="";
	    document.getElementById("A9").style.display="";
	    document.getElementById("A16").style.display="none";
	    document.getElementById("A17").style.display="none";
	</script>
	<%
}
else
	{    
		System.out.println("222222222222222222"+travelcategory);
		%>
		<script>
		//alert("**********");
		try
		{ document.getElementById("A1").style.display="none";
    	 document.getElementById("A4").style.display="none";
    	 document.getElementById("A9").style.display="none";
    	 document.getElementById("A16").style.display="";
    	 document.getElementById("A17").style.display="";
		}
		catch(e)
		{
			alert(e);
		}
   	    </script>
   	    <%
	}


}
}
catch (Exception e) 
{
	//out.print("!!!Connection Lost!!!");
}
finally
{
	conn.close();
}
%>
<script>document.getElementById("TravelDate").style.visibility="hidden";</script>
<script>document.getElementById("travelDiv").style.visibility="hidden";</script>
<script>document.getElementById("otherclient").style.display="none";</script>
<script>document.getElementById("otherclient1").style.display="none";</script>
<script>document.getElementById("otherclient2").style.display="none";</script>
<script>document.getElementById("otherclient3").style.display="none";</script>
<script>document.getElementById("client").style.display="";</script>
<script>document.getElementById("client1").style.display="none"</script>
<script>document.getElementById("client2").style.display="none"</script>
<script>document.getElementById("client3").style.display="none"</script>
<script>document.getElementById("client4").style.display="none"</script>
<!-- <script>document.getElementById("A16").style.display="none";</script>
<script>document.getElementById("A17").style.display="none";</script>-->
<!--<script>document.getElementById("B4").style.display="none";</script>-->
<!--<script>document.getElementById("B5").style.display="none";</script>-->
<!--<script>document.getElementById("B6").style.display="none";</script>-->

</form>
</body>
</html>
</jsp:useBean>

