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
function Cancel()
{
	window.opener.location.reload();
	 //window.close();      
	 setTimeout('self.close()',5); 
}
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
		window.open(webadd+'?claimtype='+claimtype ,'jav','width=570,height=350,top=250,left=300,resizable=no');
		
	}
	
}
function showVisitingCardDetails(companyName,id) 
{
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


/*function validate()
{
       var advance=document.addDetails.advanceTaken.value;
       var numbers =/^[0-9]+(\.[0-9]+)+$/;
    if( advance=='' || advance.match(numbers))
    {
       alert("Advance Amount should be  Numeric & with 2 decimal point");
       return false;
    }
  return true;
}*/
function addRow(id,mf,action,claimtype,category)
{
	//alert("in update row function");
	
	 var SrNo=id;//alert(SrNo);
	 var modiflag = mf;
	 var myaction = action;
	 var dd11,mm1,yy11,mm11;
	 if (modiflag=="C" && action == "POST")
     {
       if(claimtype=="localclaim")
       {
           //alert(claimtype);
        //var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
	    if(category=="Expense")
	    {
		  // alert("purchase module");
		   var purpose=document.addDetails.localpurpose.value;
		   var billNo=document.addDetails.billno.value;
		   var billDate=document.addDetails.billDate.value;
		   var billAmt=document.addDetails.billamount.value;//alert(billAmt);
		   var remarks=document.addDetails.remarks.value;
		   var billby=document.addDetails.billby.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   if(billAmt=='')
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
	       if(purpose=='')
	       {
		     alert("Please Enter Purpose");
		     return false;
	       }
	        
		    for (var i = 0; i < purpose.length; i++) 
			{
		        if (iChars.indexOf(purpose.charAt(i)) != -1) 
			    {
		           alert ("Purpose has special characters.These are not allowed.");
		           return false;
		        }
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
		     if(document.getElementById("billDate").value=="")
		      {
		    	  alert("Please Select BillDate ");
		    	  return false;
		      }
		      dd11=billDate.substring(0,2);//alert(dd11);
		      mm1=billDate.substring(3,6);
		      mm11=dateformat(mm1);//alert(mm11);
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
		  
	    }
	    else
	    {
		   // alert("in Travel");
		   var purpose=document.addDetails.travelpurpose.value;
		   var mode=document.getElementById("localtravelmode").options[document.getElementById("localtravelmode").selectedIndex].value;
		   var KmTravel=document.addDetails.kmtraveled.value;
		   var billDate=document.addDetails.billDate.value;
		   var billAmt=document.addDetails.claimamt.value;
		   var remarks=document.addDetails.travelremarks.value;
		   var billby=document.addDetails.billbytravel.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		   if(billAmt=='')
	       {
		     alert("Please Enter  Bill Amount");
		     return false;
	       }
		   billAmt = billAmt.toString();
	       if(isNaN(billAmt))
	       {
		     alert("Please Enter Numeric Value for Claim Amount");
		     return false;
	       }
	       if(KmTravel=='')
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
	       if(purpose=='')
	       {
		     alert("Please Enter Purpose");
		     return false;
	       }
	       for (var i = 0; i < purpose.length; i++) 
			{
		        if (iChars.indexOf(purpose.charAt(i)) != -1) 
			    {
		           alert ("Purpose has special characters.These are not allowed.");
		           return false;
		        }
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
		   
	    }
       }
       else
       {   
	     //alert("travel catagory");
	   var travelcategory=document.getElementById("travelcategory").options[document.getElementById("travelcategory").selectedIndex].value;
	   //alert("travel catagory"+travelcategory);
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
			    if(origin=='')
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
			    if(destination=='')
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
			    if(city=='')
			       {
				     alert("Please Enter City");
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
		   var billby=document.addDetails.billbyT.value;
		   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
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
		       if(city=='')
		       {
			     alert("Please Enter City");
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
			   
	   }
       }
}
		//alert("end of if function")
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
						if (modiflag=="C" && action == "POST")
	                    {
                            alert("Item Updated Successfully");
							window.opener.location.reload();
							 //window.close();      
							 setTimeout('self.close()',5);              
	                    }
	                    else
		                 {
	                    	//window.opener=self;
	                    	//window.close();
		                 }
						
					
					}
                  
                   
                   
      			} 
			}
			if (modiflag=='C' && action == 'POST')
			{ 
			   if(claimtype=="localclaim")
			   {
				 
				 if(category=="Expense")
				 {
					 //alert(category);
					var queryString = "?action=update&purpose="+purpose+"&billAmt="+billAmt+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&claimtype="+claimtype+"&srno="+SrNo+"&billby="+billby;
				 }
				 else
				 {
					 //alert(category); 
					 var queryString = "?action=update&purpose="+purpose+"&billAmt="+billAmt+"&KmTravel="+KmTravel+"&billDate="+billDate+"&remarks="+remarks+"&category="+category+"&claimtype="+claimtype+"&srno="+SrNo+"&mode="+mode+"&billby="+billby;					 
					//alert(queryString);
				 }
			   }
			   else
			   {
				if(travelcategory=="JourneyFare")
				{
					var queryString = "?action=update&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&mode="+mode+"&city="+city+"&origin="+origin+"&destination="+destination+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&srno="+SrNo+"&billby="+billby;
				}
				else
				{
					var queryString = "?action=update&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&city="+city+"&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+"&claimtype="+claimtype+"&srno="+SrNo+"&billby="+billby;
				}
			   }
			}
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
    //alert("in get");
    if(id=="+")
    {
	 document.getElementById("otherclient").style.visibility="visible";
	 document.getElementById("client").style.visibility="hidden";
	 document.getElementById("client1").style.visibility="visible";
    }
    else
    {
    	document.addDetails.companyNames.value=""; 
    }
}
function getClient2(id)
{
	if(id=="+")
    {
	document.getElementById("otherclient1").style.visibility="visible";
	document.getElementById("client1").style.visibility="hidden";
	document.getElementById("client2").style.visibility="visible";
    }
	else
    {
    	document.addDetails.companyNames1.value=""; 
    }
	
}
function getClient3(id)
{
	if(id=="+")
    {
	document.getElementById("otherclient2").style.visibility="visible";
	document.getElementById("client2").style.visibility="hidden";
	document.getElementById("client3").style.visibility="visible";
    }
	else
    {
    	document.addDetails.companyNames2.value=""; 
    }
}
function getClient4(id)
{
	if(id=="+")
    {
	document.getElementById("otherclient3").style.visibility="visible";
	document.getElementById("client3").style.visibility="hidden";
	document.getElementById("client4").style.visibility="visible";
	
    }
	else
    {
    	document.addDetails.companyNames3.value=""; 
    	document.addDetails.companyNames4.value=""; 
    }
}
function getClient5(id)
{
    	document.addDetails.companyNames4.value="";   
}
function Changing()
{
	//alert(">>>>>>>In Changing +Purchase");
	var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;

	if(category=="Select")
    {
    	document.getElementById("purchaseDiv").style.visibility="hidden";
    	document.getElementById("travelDiv").style.visibility="hidden";
    }
    if(category=="Expense")
    {
    	document.getElementById("purchaseDiv").style.visibility="visible";
    	document.getElementById("travelDiv").style.visibility="hidden";
    }
    if(category=="Travel")
    {
    	document.getElementById("travelDiv").style.visibility="visible";
    	document.getElementById("purchaseDiv").style.visibility="hidden";
    }
}
function ChangingClaimType()
{
	//alert(">>>In ChangingClaimType()");
}
function ChangingTravelCategory()
{
    var category=document.getElementById("travelcategory").options[document.getElementById("travelcategory").selectedIndex].value;
    if(category=="JourneyFare")
    {
    	document.getElementById("JourneyDiv").style.visibility="visible";
    	document.getElementById("TravelDate").style.visibility="hidden";
    }
    else
    {
    	document.getElementById("JourneyDiv").style.visibility="hidden";
    	document.getElementById("TravelDate").style.visibility="visible";
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
     String category="",billDate="",localpurpose="",billno="",billamount="",remarks="",mode="",km="",fromdate="",todate="";
     String VisitCity="",departureDate="",arrivalDate="",purpose="",origin="",destination="",comments="",advanceTaken="",visitTo="";
     String visitTo1="",visitTo2="",visitTo3="",visitTo4="",DateCal="",action="",hrs="",min="",hrs1="",min1="",billby="";
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
String sqlGetHistory="",sqlTmpData="",ClaimNo="",client="",travelhrs="",travelmin="";
ResultSet rsCounter;
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
%>


<form name="addDetails" method="get"  onSubmit="return validate();" >

<table border="0" align="center" style="background-color: #C6DEFF" width="100%">
<%

String particulars=request.getParameter("particulars");
String srno=request.getParameter("srno");
String claimtype=request.getParameter("claimtype");
String Amount=request.getParameter("amount");
billno=request.getParameter("billno");
remarks=request.getParameter("remarks");
System.out.println(">>>>>>>remarks:"+remarks);
//billDate=request.getParameter("billDate");

mode=request.getParameter("mode");
km=request.getParameter("km");
purpose=request.getParameter("purpose");
origin=request.getParameter("origin");
destination=request.getParameter("destination");
city=request.getParameter("city");
billby=request.getParameter("billby");
if(claimtype.contains("travelclaim"))
{
	client=request.getParameter("client");
	System.out.println(">>>>>>>client:"+client);
	String delims = "[,]+";
	String[] tokens = client.split(delims);

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

    
//billDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd ").parse(request.getParameter("billDate")));
%>
</table>

<%
if(claimtype.contains("localclaim"))
{
	billDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("billDate")));

%>

<table  border="0" align="center" style="width:600px; height:150px; background-color: #C6DEFF;font-family: arial;font-size:8;">
<tr>
<td align="center" style="background-color:white;" colspan="4"><font size="4" color="#C6DEFF"><a><%=type %></a></font></td>
<tr>
<td><b>Category:</b></td>
<td><%=particulars %></td>
<td><strong><b>Bill Date:&nbsp;&nbsp;&nbsp;</b></strong></td>
<td><input type="text" id="billDate" onmousedown="unCheckAll()" name="billDate" value="<%=billDate %>" size="15"
readonly="readonly" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;border-color: activeborder;" />
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

<% if(particulars.contains("Expense")){ %>
<tr>
<td><strong><b>Purpose:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="localpurpose" id="search-text" value="<%=purpose%>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
<td><strong><b>BillNo:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="billno" id="search-text" value="<%=billno %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>	
</tr>
<tr>
<td><strong><b>BillAmount(*):&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="billamount" id="search-text" value="<%=Amount %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
<td><strong><b>BillBy:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="billby" id="search-text" value="<%=billby %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<tr>
<td><strong><b>Remarks:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="remarks" id="search-text" value="<%=remarks %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<%} if(particulars.contains("Travel")){ %>
<tr>
<td><strong><b>Purpose:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="travelpurpose" id="search-text" value="<%=purpose%>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
<td><strong><b>Km Traveled:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="kmtraveled" id="search-text" value="<%=km %>"style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<tr>
<td><b>Mode:</b></td>
<td><select name="localtravelmode" id="localtravelmode" style="width: 100px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; " onchange="Changing();">
<%
     
      if(mode.contains("Bike"))
      {
	    %>
	     <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Bus'>Bus</option>
         <option value='Train'>Train</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
         <option value='Auto'>Auto</option>
         
	   <%
      }
     if(mode.contains("Bus"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Train'>Train</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
         <option value='Auto'>Auto</option>
          <option value='Bike'>Bike</option>
    	 <%
     }
     else if(mode.contains("Train"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Bus'>Bus</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
         <option value='Auto'>Auto</option>
         <option value='Bike'>Bike</option>
    	 <%
     }
     else if(mode.contains("Car"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
          <option value='Bus'>Bus</option>
          <option value='Train'>Train</option>
         <option value='Taxi'>Taxi</option>
         <option value='Auto'>Auto</option>
         <option value='Bike'>Bike</option>
    	 <%
     }
     else if(mode.contains("Taxi"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
          <option value='Bus'>Bus</option>
          <option value='Train'>Train</option>
         <option value='Car'>Car</option>
         <option value='Auto'>Auto</option>
         <option value='Bike'>Bike</option>
    	 <%
     }
     else if(mode.contains("Auto"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
          <option value='Bus'>Bus</option>
          <option value='Train'>Train</option>
         <option value='Car'>Car</option>
         <option value='Auto'>Auto</option>
         <option value='Bike'>Bike</option>
    	 <%
     }
%>
</select></td>
<td><strong><b>Claim Amount(*):&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="claimamt" id="search-text" value="<%=Amount %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<tr>
<td><strong><b>Remark:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="travelremarks" id="search-text" value="<%=remarks %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
<td><strong><b>BillBy:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="billbytravel" id="search-text" value="<%=billby %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>


<%} %>
<tr align="center">
<td colspan="4"><input type="button" name="update" value="Update Item" Style="border: outset;" onclick="addRow('<%=srno %>','C','POST','<%=claimtype %>','<%=particulars %>')" />
<input type="button" name="cancel" value="Cancel" Style="border: outset;" onclick="Cancel();" /></td>
</tr>
</table>

<%	
}
%>
<%
if(claimtype.contains("travelclaim"))
{
	billDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("billDate")));
   if(particulars.contains("JourneyFare"))
   {
		fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("todate")));
		fromDateCal1=fromdate;
		toDateCal1=todate;
		hrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		min=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		hrs1=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("todate")));
		min1=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("todate")));
		
   }
   else
   {
		fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		DateCal=fromdate;
		travelhrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		travelmin=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
		
   }
%>
<table  border="0" align="center" style="width:600px; height:150px; background-color: #C6DEFF;font-family: arial;font-size:8;">
<tr>
<td align="center" style="background-color:white;" colspan="5"><font size="4" color="#C6DEFF"><a><%=type %></a></font></td>
<tr>           
<td><b>Category:&nbsp;</b></td>
<td><select name="travelcategory" id="travelcategory" style="width: 120px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; " onchange="ChangingTravelCategory();">
<%
    if(particulars.contains("JourneyFare"))
    {
    	%>
    	<option value='<%=particulars %>' selected><%=particulars %></option>
    	<option value='HotelExpence'>Hotel Expences</option>
        <option value='Conveyance'>Conveyance</option>
        <option value='Stationary'>Stationary</option>
        <option value='Miscellaneous'>Miscellaneous</option>
    	<%
    }
    else if(particulars.contains("HotelExpence"))
    {
	%>
	<option value='<%=particulars %>' selected><%=particulars %></option>
	<option value='JourneyFare'>Journey Fare</option>
    <option value='Conveyance'>Conveyance</option>
    <option value='Stationary'>Stationary</option>
    <option value='Miscellaneous'>Miscellaneous</option>
	<%
    }
    else if(particulars.contains("Conveyance"))
    {
	%>
	<option value='<%=particulars %>' selected><%=particulars %></option>
	<option value='JourneyFare'>Journey Fare</option>
    <option value='HotelExpence'>Hotel Expences</option>
    <option value='Stationary'>Stationary</option>
    <option value='Miscellaneous'>Miscellaneous</option>
	<%
    }
    else if(particulars.contains("Stationary"))
    {
	%>
	<option value='<%=particulars %>' selected><%=particulars %></option>
	<option value='JourneyFare'>Journey Fare</option>
    <option value='HotelExpence'>Hotel Expences</option>
    <option value='Conveyance'>Conveyance</option>
    <option value='Miscellaneous'>Miscellaneous</option>
	<%
    }
    else if(particulars.contains("Miscellaneous"))
    {
	%>
	<option value='<%=particulars %>' selected><%=particulars %></option>
	<option value='JourneyFare'>Journey Fare</option>
    <option value='HotelExpence'>Hotel Expences</option>
    <option value='Conveyance'>Conveyance</option>
    <option value='Stationary'>Stationary</option>
	<%
    }
%>
</select>
</td>
<td><strong><b>Bill Date:</b></strong></td>
<td><input type="text" id="billDate" onmousedown="unCheckAll()" name="billDate" value="<%=billDate %>" size="15"
readonly="readonly" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;border-color: activeborder;" />
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
<%
    if(particulars.contains("JourneyFare"))
    {
    	%>     
<tr>
<td><strong>Mode:&nbsp;&nbsp;&nbsp;&nbsp;</strong> </td>
<td>
<select name="travelmode" id="travelmode" style="width: 100px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
<%
     if(mode.contains("Bus"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Train'>Train</option>
         <option value='Air'>Air</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
    	 <%
     }
     else if(mode.contains("Train"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Bus'>Bus</option>
         <option value='Air'>Air</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
    	 <%
     }
     else if(mode.contains("Air"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Train'>Train</option>
         <option value='Bus'>Bus</option>
         <option value='Taxi'>Taxi</option>
         <option value='Car'>Car</option>
    	 <%
     }
     else if(mode.contains("Taxi"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Train'>Train</option>
         <option value='Bus'>Bus</option>
         <option value='Air'>Air</option>
         <option value='Car'>Car</option>
    	 <%
     }
     else if(mode.contains("Car"))
     {
    	 %>
    	 <option value='<%=mode %>' selected><%=mode %></option>
         <option value='Train'>Train</option>
         <option value='Bus'>Bus</option>
         <option value='Air'>Air</option>
         <option value='Taxi'>Taxi</option>
        
    	 <%
     }
%>
</select>
</td>

</tr>
<tr>
<td align="left"><strong><b>From:</b></strong></td>
<td><input type="text" id="fromdate" onmousedown="unCheckAll()" name="fromdate" value="<%=fromDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;border-color: activeborder;" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate"       // ID of the button
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
{ for(int i=0;i<24;i++)
  {
	if(i<10)
	{
		if(i==Integer.parseInt(hrs))
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
<select name="min" id="min" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
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
<td align="left"><strong><b>To: </b></strong></td>
<td><input type="text" id="todate" onmousedown="unCheckAll()" name="todate" value="<%=toDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;border-color: activeborder;" />
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
<tr>
<td><strong><b>Origin:</b> </strong></td>
<td><input type="text" name="fromplace" id="fromplace" value="<%=origin %>" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>
<td><strong><b>Destination:</b></strong> </td>
<td><input type="text" name="toplace" id="toplace" value="<%=destination %>" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>
</tr>
<%} %>
<%if(! particulars.contains("JourneyFare"))
{%>
<tr>
<td align="left"><strong><b>Date-Time:</b></strong></td>
<td><input type="text" id="traveldatetime" onmousedown="unCheckAll()" name="traveldatetime" value="<%=DateCal %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;border-color: activeborder;" />
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
<%} %>
<tr>
<td><strong><b>City :</b></strong></td><td><input type="text" name="city" id="city" value="<%=city %>" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>
<td><strong><b>Amount(*):</b></strong></td> 
<td><input type="text" name="amount" id="search-text" value="<%=Amount %>"
style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<tr>
<td><strong><b>BillNo:</b></strong></td>
<td><input type="text" name="billNumber" id="billNumber" value="<%=billno %>" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>
<td><strong><b>BillBy:</b></strong></td><td><input type="text" name="billbyT" id="billbyT" value="<%=billby %>" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>

</tr>
<tr><td><strong><b>Remarks:
<br>&nbsp;&nbsp;(On Bill)</b></strong></td>
<td><textarea name="billComments" id="billComments"  style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'  ><%=remarks %></textarea></td>	</tr>
<tr>
<td><strong><b>Client :</b></strong></td>
<td>
<input type="text" name="companyNames" id="companyNames"  style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' value="<%=visitTo %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies('<%=1 %>'); }"> &nbsp;&nbsp;&nbsp;<br>
<div style="position: absolute;">
  <table>
  <tr><td></td></tr>
  <tr><td>
  <div id='companyList'>
  </div>
  </td></tr>
  </table>
</div>
</td>
<td><div id="client"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient1('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient1('-')"><font size="3" >(-)</font></a> </div></td>
<td>
<div id="otherclient">
<input type="text" name="companyNames1" id="companyNames1" style='width: 165px height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' value="<%=visitTo1 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList1').style.display = 'none';} else { getCompanies('<%=2 %>'); }"> &nbsp;&nbsp;&nbsp;<br>
<div style="position: absolute;">
  <table>
  <tr><td></td></tr>
  <tr><td>
  <div id='companyList1'>
  </div>
  </td></tr>
  </table>
</div>
</div>
</td>
<td><div id="client1"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient2('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient2('-')"><font size="3" >(-)</font></a></div></td>


</tr>

<tr>
<td></td>
<td>
<div id="otherclient1">
<input type="text" name="companyNames2" id="companyNames2" style='width: 165px height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' value="<%=visitTo2 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList2').style.display = 'none';} else { getCompanies('<%=3 %>'); }"> &nbsp;&nbsp;&nbsp;<br>
<div style="position: absolute;">
  <table>
  <tr><td></td></tr>
  <tr><td>
  <div id='companyList2'>
  </div>
  </td></tr>
  </table>
</div>

</div>
</td>
<td><div id="client2"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient3('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient3('-')"><font size="3" >(-)</font></a></div></td>
<td>
<div id="otherclient2">
<input type="text" name="companyNames3" id="companyNames3" style='width: 165px height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' value="<%=visitTo3 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList3').style.display = 'none';} else { getCompanies('<%=4 %>'); }"> &nbsp;&nbsp;&nbsp;<br>
<div style="position: absolute;">
  <table>
  <tr><td></td></tr>
  <tr><td>
  <div id='companyList3'>
  </div>
  </td></tr>
  </table>
</div>
</div>
</td>
<td><div id="client3"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient4('+')"><font size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue; " onclick="getClient4('-')"><font size="3" >(-)</font></a></div></td>

</tr>
<tr>
<td></td>
<td>
<div id="otherclient3">
<input type="text" name="companyNames4" id="companyNames4" style='width: 165px; height: 15px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' value="<%=visitTo4 %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList4').style.display = 'none';} else { getCompanies('<%=5 %>'); }"> &nbsp;&nbsp;&nbsp;<br>
<div style="position: absolute;">
  <table>
  <tr><td></td></tr>
  <tr><td>
  <div id='companyList4'>
  </div>
  </td></tr>
  </table>
</div>
</div>
</td>
<td><div id="client4"><a href="#" style="font-weight: bold; color: blue; " onclick="getClient5('-')"><font size="3" >(-)</font></a></div></td>

</tr>
<tr align="center">
<td colspan="5"><input type="button" name="Update" value="Update Item" Style="border: outset;" onclick="addRow('<%=srno %>','C','POST','<%=claimtype %>','<%=particulars %>')" />
<input type="button" name="cancel" value="Cancel" Style="border: outset;" onclick="Cancel();" /></td>
</tr>

</table>

<%
}
	%>

<%
} 
catch (Exception e) 
{
	out.print("!!!Connection Lost!!!");
}
finally
{
	conn.close();
}
%>
<script>document.getElementById("otherclient").style.visibility="hidden";</script>
<script>document.getElementById("otherclient1").style.visibility="hidden";</script>
<script>document.getElementById("otherclient2").style.visibility="hidden";</script>
<script>document.getElementById("otherclient3").style.visibility="hidden";</script>
<script>document.getElementById("client").style.visibility="visible";</script>
<script>document.getElementById("client1").style.visibility="hidden";</script>
<script>document.getElementById("client2").style.visibility="hidden";</script>
<script>document.getElementById("client3").style.visibility="hidden";</script>
<script>document.getElementById("client4").style.visibility="hidden";</script>
</form>
</body>
</html>
</jsp:useBean>