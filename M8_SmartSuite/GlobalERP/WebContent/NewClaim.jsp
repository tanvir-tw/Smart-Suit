<%@page import="org.apache.commons.net.ftp.parser.EnterpriseUnixFTPEntryParser"%>
<%@  page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%><%@page import="java.util.Date"%>
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
<script type="text/javascript">
/* we'll only allow DOM browsers to simplify things*/
(document.getElementById ? DOMCapable = true : DOMCapable = false);
function hide(menuName)
{
if (DOMCapable)
{
var theMenu = document.getElementById(menuName+"choices");
theMenu.style.display = 'none';
}
}
function show(menuName)
{
if (DOMCapable)
{
var theMenu = document.getElementById(menuName+"choices");
theMenu.style.display = 'block';
}
}

</script>


<script type="text/javascript">
var counter=1;
function Reload(clmrefno)
{
	//window.location="claimReport.jsp?action=view";
	//alert("Ln NewClaim Page");
	//alert(clmrefno);
	window.location="NewClaim.jsp?id="+clmrefno+"&status=Open&action=update";
}
function popup(webadd,clmrefno)
{ 
	//alert(">popup>>>"+clmrefno);
	var claimtype=document.getElementById("claimtype").options[document.getElementById("claimtype").selectedIndex].value;
	//alert("here");
	var ourcompany=document.getElementById("ourcompany").options[document.getElementById("ourcompany").selectedIndex].value;
    //alert(ourcompany);
    var fromdate1=document.addDetails.fromdate1.value;
    //alert(fromdate1);
    var todate1=document.addDetails.todate1.value;
    //alert(todate1);
    var advanceTaken=document.addDetails.advanceTaken.value;//alert(advanceTaken);
    var purpose=document.addDetails.purpose.value;//alert(purpose);
    var origin=document.addDetails.origin.value;//alert(origin);
    var destination=document.addDetails.destination.value;//alert(destination);
    if(claimtype=="localclaim")
	{
		window.open(webadd+'?claimtype='+claimtype+'&clmrefno='+clmrefno+'&ourcompany='+ourcompany+'&fromdate1='+fromdate1+'&todate1='+todate1+'&advanceTaken='+advanceTaken+'&purpose='+purpose+'&origin='+origin+'&destination='+destination ,'jav','width=600,height=400,top=150,left=260,location=0, menubar=0, scrollbars=yes, status=0, toolbar=0,resizable=0');
	}
	else if(claimtype=="travelclaim")
	{
		window.open(webadd+'?claimtype='+claimtype+'&clmrefno='+clmrefno+'&ourcompany='+ourcompany+'&fromdate1='+fromdate1+'&todate1='+todate1+'&advanceTaken='+advanceTaken+'&purpose='+purpose+'&origin='+origin+'&destination='+destination ,'jav','width=650,height=400,top=150,left=260,resizable=0 ,scrollbars=yes');
	}
  }

function popupNewWindow(webadd,claimtype,id)
{ 
	//var claimtype=document.getElementById("claimtype").options[document.getElementById("claimtype").selectedIndex].value;
  //  alert("popupNewWindow"+id);
	if(claimtype=="localclaim")
	{
		window.open(webadd+'?claimtype='+claimtype+'&clmrefno='+id ,'jav','width=630,height=330,top=150,left=260,location=0, menubar=0, scrollbars=yes, status=0, toolbar=0,resizable=0');
		
	}
	else if(claimtype=="travelclaim")
	{
		window.open(webadd+'?claimtype='+claimtype+'&clmrefno='+id ,'jav','width=650,height=400,top=150,left=260,location=0, menubar=0, scrollbars=yes, status=0, toolbar=0,resizable=0');
		
	}
	
}
function PopUpWindow(webadd,srno,particulars,amount,billno,remarks,billDate,mode,km,purpose,origin,destination,fromdate,todate,city,client,billby)
{ 	
	 //  alert(popupwindow);
	    var action="update";
	    //alert(action);
	    if(particulars=="Expense" || particulars=="Travel")
	    {
	    	var claimtype="localclaim";
			window.open(webadd+'?srno='+srno+'&particulars='+particulars+'&claimtype='+claimtype+'&action='+action+'&amount='+amount+'&billno='+billno+'&remarks='+remarks+'&billDate='+billDate+'&mode='+mode+'&km='+km+'&purpose='+purpose+'&billby='+billby,'jav','width=690,height=300,top=250,left=260,resizable=no,scrollbars=yes');	
	    }
	    else
	    {
	    	var claimtype="travelclaim";
			window.open(webadd+'?srno='+srno+'&particulars='+particulars+'&claimtype='+claimtype+'&action='+action+'&origin='+origin+'&destination='+destination+'&fromdate='+fromdate+'&todate='+todate+'&city='+city+'&amount='+amount+'&billno='+billno+'&remarks='+remarks+'&billDate='+billDate+'&mode='+mode+'&km='+km+'&purpose='+purpose+'&client='+client+'&billby='+billby,'jav','width=590,height=420,top=150,left=260,resizable=no,scrollbars=yes');	
	    
	    }
}


function checkButton()
{
	//alert("in save");
      var button=document.getElementById('button');
      var save=document.getElementById('Save').value;
    	 if(save=="Save" || save.equals("Save"))
      		{	//	alert(save);
      		button.value=0;
      		//return validate();
      		}
      }
function checkButton1()
{ 
	//alert("in submit");
      var button=document.getElementById('button');
 	    var submit=document.getElementById('Submit').value;
      if(submit=="Submit" || submit.equals("Submit"))
      {//alert(submit);
       button.value=1;
      }
}
function isDecimal(str){
	if(isNaN(str) || str.indexOf(".")<0){
	alert("Enter Decimal Number");
	}
	else{
	str=parseFloat(str);
	alert ("Entered number is decimal");
	}
	}



function validate()
{
	//alert("validate");
	var action=document.getElementById("action").value;
	//alert(action);
	  if(action=="update")
      {
          var dec=document.addDetails.advanceTaken1.value;
      	  var purpose=document.addDetails.purpose1.value;//alert(purpose);
          var origin=document.addDetails.origin1.value;//alert(origin);
          var destination=document.addDetails.destination1.value;//alert(destination);
          purpose=purpose.replace(/\s/g,"");
          dec=dec.replace(/\s/g,"");
          origin=origin.replace(/\s/g,"");
          destination=destination.replace(/\s/g,"");
	
          if(dec.length==0)
          {
          	alert("Please Enter Advance");
      		return false;
          }
          
      	  if(isNaN(dec))
      	  {
      		alert("Please Enter Numeric Value For AdvanceTaken");
      		return false;
      	  }  
      	 if(purpose.length==0)
 	    {
 	    	alert("Please Enter Purpose");
 			return false;
 	    }
 	   
 	    if(origin.length==0)
 	    {
 	    	alert("Please Enter Origin");
 			return false;
 	    }
 	    if(destination.length==0)
 	    {
 	    	alert("Please Enter Destination");
 			return false;
 	    }
 	   var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	    for (var i = 0; i < purpose.length; i++) 
		{
	        if (iChars.indexOf(purpose.charAt(i)) != -1) 
		    {
	           alert ("Purpose has special characters.These are not allowed.");
	           return false;
	        }
	    }
	    for (var i = 0; i < origin.length; i++) 
		{
	        if (iChars.indexOf(origin.charAt(i)) != -1) 
		    {
	           alert ("Origin has special characters.These are not allowed.");
	           return false;
	        }
	    }
	    for (var i = 0; i < destination.length; i++) 
		{
	        if (iChars.indexOf(destination.charAt(i)) != -1) 
		    {
	           alert ("Destination has special characters.These are not allowed.");
	           return false;
	        }
	    }
	      var date1=document.getElementById("fromdate2").value;
	      var date2=document.getElementById("todate2").value;
	      var dm1,dd1,dy1,dm2,dd2,dy2;
	      var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	      dd11=date1.substring(0,2);
	      dd22=date2.substring(0,2);
	      mm1=date1.substring(3,6);
	      mm2=date2.substring(3,6);
	      mm11=dateformat(mm1);
	      mm22=dateformat(mm2);
	      yy11=date1.substring(7,11);
	      yy22=date2.substring(7,11);
	      var date=new Date();
	      var month=date.getMonth()+1;
	      var day=date.getDate();
	      var year=date.getFullYear();
	      if(yy11>year || yy22>year)
	      {
	              alert("Selected Date Should Not be Greater Than Todays Date");
	              document.getElementById("fromdate2").value="";
	              document.getElementById("todate2").value="";
	              document.getElementById("fromdate2").focus;
	              return false;
	      }
	      else if(year==yy11 && year==yy22)
	      {
	              if(mm11>month || mm22>month)
	              {
	                      alert("Selected Date Should Not be Greater Than Todays Date");
	                      document.getElementById("fromdate2").value="";
	                      document.getElementById("todate2").value="";
	                      document.getElementById("fromdate2").focus;
	                      return false;
	              }
	      }
	      if(mm11==month && mm22==month)
	      {
	              if(dd11>day || dd22>day)
	              {
	                      alert("Selected Date Should Not be Greater Than Todays Date");
	                      document.getElementById("fromdate2").value="";
	                      document.getElementById("todate2").value="";
	                      document.getElementById("fromdate2").focus;
	                      return false;
	              }
	      }

	      if(yy11 > yy22)
	      {
	              alert("From Date Year Should Not be Greater Than To Date Year");
	              document.getElementById("fromdate2").value="";
	              document.getElementById("todate2").value="";
	              document.getElementById("fromdate2").focus;
	              return false;
	      }
	      else if(year==yy11 && year==yy22)
	      {
	               if(mm11>mm22)
	      {
	              alert("From Date Month Should Not be Greater Than To Date Month");
	              document.getElementById("fromdate2").value="";
	              document.getElementById("todate2").value="";
	              document.getElementById("fromdate2").focus;
	              return false;
	      }
	      }
	      if(mm11==month && mm22==month) 
	      {
	              if(yy11==yy22)
	              {
	              if(dd11 > dd22)
	              {
	                      alert("From Date Should Not be Greater Than To Date");
	                      document.getElementById("fromdate2").value="";
	                      document.getElementById("todate2").value="";
	                      document.getElementById("fromdate2").focus;
	                      return false;
	              }
	              }
	      }
	      else
	              if(yy11<yy22)
	              {
	                      return true;
	              }
	      else
	              if(dd11 > dd22)
	      {
	                      if(mm11<mm22)
	                      {
	                              return true;
	                      }
	                      
	              alert("From Date Should Not be Greater Than To Date");
	              document.getElementById("fromdate2").value="";
	              document.getElementById("todate2").value="";
	              document.getElementById("fromdate2").focus;
	              return false;
	      }
	      if(document.getElementById("fromdate2").value=="")
	      {
	    	  alert("Please Select FromDate ");
	    	  return false;
	      }
	      if(document.getElementById("todate2").value=="")
	      {
	    	  alert("Please Select ToDate ");
	    	  return false;
	      }
      	  
      }
	
	  
	if(action=='-')
	{//alert("action1="+action);
	
	var purpose=document.addDetails.purpose.value;//alert("purpose "+purpose);
    var origin=document.addDetails.origin.value;//alert("origin"+origin);
    var destination=document.addDetails.destination.value;//alert("dest"+destination);
    var dec=document.addDetails.advanceTaken.value;//alert("advance" +dec);
    purpose=purpose.replace(/\s/g,"");
    dec=dec.replace(/\s/g,"");
    origin=origin.replace(/\s/g,"");
    destination=destination.replace(/\s/g,"");
	
    if(dec.length==0)
    {
    	alert("Please Enter Advance");
		return false;
    }
    if(isNaN(dec))
	{
		alert("Please Enter Numeric Value For AdvanceTaken");
		return false;
	}  
	    if(purpose.length==0)
	    {
	    	alert("Please Enter Purpose");
			return false;
	    }
	   
	    if(origin.length==0)
	    {
	    	alert("Please Enter Origin");
			return false;
	    }
	    if(destination.length==0)
	    {
	    	alert("Please Enter Destination");
			return false;
	    }
	    var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
	    for (var i = 0; i < purpose.length; i++) 
		{
	        if (iChars.indexOf(purpose.charAt(i)) != -1) 
		    {
	           alert ("Purpose has special characters.These are not allowed.");
	           return false;
	        }
	    }
	    for (var i = 0; i < origin.length; i++) 
		{
	        if (iChars.indexOf(origin.charAt(i)) != -1) 
		    {
	           alert ("Origin has special characters.These are not allowed.");
	           return false;
	        }
	    }
	    for (var i = 0; i < destination.length; i++) 
		{
	        if (iChars.indexOf(destination.charAt(i)) != -1) 
		    {
	           alert ("Destination has special characters.These are not allowed.");
	           return false;
	        }
	    }	 
	    //datevalidate();   
	    var date1=document.getElementById("fromdate1").value;
      var date2=document.getElementById("todate1").value;
      var dm1,dd1,dy1,dm2,dd2,dy2;
      var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
      dd11=date1.substring(0,2);
      dd22=date2.substring(0,2);
      mm1=date1.substring(3,6);
      mm2=date2.substring(3,6);
      mm11=dateformat(mm1);
      mm22=dateformat(mm2);
      yy11=date1.substring(7,11);
      yy22=date2.substring(7,11);
      var date=new Date();
      var month=date.getMonth()+1;
      var day=date.getDate();
      var year=date.getFullYear();
      if(yy11>year || yy22>year)
      {
              alert("Selected Date Should Not be Greater Than Todays Date");
              document.getElementById("fromdate1").value="";
              document.getElementById("todate1").value="";
              document.getElementById("fromdate1").focus;
              return false;
      }
      else if(year==yy11 && year==yy22)
      {
              if(mm11>month || mm22>month)
              {
                      alert("Selected Date Should Not be Greater Than Todays Date");
                      document.getElementById("fromdate1").value="";
                      document.getElementById("todate1").value="";
                      document.getElementById("fromdate1").focus;
                      return false;
              }
      }
      if(mm11==month && mm22==month)
      {
              if(dd11>day || dd22>day)
              {
                      alert("Selected Date Should Not be Greater Than Todays Date");
                      document.getElementById("fromdate1").value="";
                      document.getElementById("todate1").value="";
                      document.getElementById("fromdate1").focus;
                      return false;
              }
      }

      if(yy11 > yy22)
      {
              alert("From Date Year Should Not be Greater Than To Date Year");
              document.getElementById("fromdate1").value="";
              document.getElementById("todate1").value="";
              document.getElementById("fromdate1").focus;
              return false;
      }
      else if(year==yy11 && year==yy22)
      {
               if(mm11>mm22)
      {
              alert("From Date Month Should Not be Greater Than To Date Month");
              document.getElementById("fromdate1").value="";
              document.getElementById("todate1").value="";
              document.getElementById("fromdate1").focus;
              return false;
      }
      }
      if(mm11==month && mm22==month) 
      {
              if(yy11==yy22)
              {
              if(dd11 > dd22)
              {
                      alert("From Date Should Not be Greater Than To Date");
                      document.getElementById("fromdate1").value="";
                      document.getElementById("todate1").value="";
                      document.getElementById("fromdate1").focus;
                      return false;
              }
              }
      }
      else
              if(yy11<yy22)
              {
                      return true;
              }
      else
              if(dd11 > dd22)
      {
                      if(mm11<mm22)
                      {
                              return true;
                      }
                      
              alert("From Date Should Not be Greater Than To Date");
              document.getElementById("fromdate1").value="";
              document.getElementById("todate1").value="";
              document.getElementById("fromdate1").focus;
              return false;
      }
      if(document.getElementById("fromdate1").value=="")
      {
    	  alert("Please Select FromDate ");
    	  return false;
      }
      if(document.getElementById("todate1").value=="")
      {
    	  alert("Please Select ToDate ");
    	  return false;
      }
      
	}   
      return true;
}
function delvalidation()
{
	 var agree=confirm("Do You Want to Continue Delete Item?");
	 if(agree)
	 {
		// alert("yes");
	        return true;
	 }
	 else
	 {
		 return false;
	 }
	 //return true;
}
function DeleteRow(id)
{
	 //alert(id);
	 var SrNo=id;
	 var agree=confirm("Do You Want to Continue Delete Item?");
	 //alert(agree);
	 if(agree)
	 {
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
				var data=reslt.split("#");
				//alert("<*****  "+data);
				if(data[1].indexOf('Yes')!=-1)
				{alert("Deleted successfully.....");					
			    	window.location.reload();
			    	
				}
			
			} 
		}
		
		var queryString = "?action=delete&srno="+SrNo;
		
		
		ajaxRequest.open("GET", "AjaxClaimEnq.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 }
	 else
	 { return false;
	 }
	 
	
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


function claimReport(action)
{ 
	window.open('claimReport.jsp?action='+action,'jav');
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
                
function datevalidate()
{
      
      
      return true;
}

function timer()
{
	
	setTimeout("getCompanies(1)", 2000);
}

function getCompanies(num)
{
	//alert("compani"+num);
	
		document.getElementById("uselist").style.display="";
		
	    
	
		var claimant=document.getElementById("bhalf") .value;

		if(claimant.length=="")
		{
			
			
		}
		else
		{
			document.getElementById("userList").style.visibility="visible";
		
			claimant=claimant.replace(".", "");
			claimant=claimant.replace(",", "");
			claimant=claimant.replace("$", "");
			claimant=claimant.replace("#", "");
			claimant=claimant.replace("?", "");
			claimant=claimant.replace("-", "");
			claimant=claimant.replace("_", "");
			claimant=claimant.replace(" ", "");
			claimant=claimant.replace("(", "");
			claimant=claimant.replace(")", "");
		
		if(num==1)
		{
			counter=20;
		}
		else if(num==2)
		{
			counter=0;
		}
		
		var ajaxRequest;
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
				document.getElementById("userList").innerHTML=reslt;
				var b=document.getElementById("element").value;
				document.addFolloUp.counter.value=b;
				document.addFolloUp.counter.value=b*document.addFolloUp.counter.value;
				counter=document.addFolloUp.counter.value;
				
			} 
		}
		//alert("val==>"+counter);
		/* var queryString = "?company=" +company+"&limitcount="+counter+""; */
		
		//alert("limit count val"+counter);	
		ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp?user="+queryString, true);
		ajaxRequest.send(null); 
		}//end of else
		
}


</script>	 
	
<%
     erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
	
<%
     Connection conn = null;
     Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null;
     String selectedName;
     Format format=new SimpleDateFormat("dd-MMM-yyyy");
     Format parse=new SimpleDateFormat("yyyy-MM-dd");
     String fromDate="",toDate="",fromDateCal="",toDateCal="",fromDateCal1="",toDateCal1="",department="",grade="";
     String companyName="",phone="",contact="",email="",product="",city="",companyName1="",amount="",billNo="";
      String  status="";
     String VisitCity="",departureDate="",arrivalDate="",purpose="",origin="",destination="",comments="",advanceTaken="0.00",visitTo="";
     String visitTo1="",visitTo2="",visitTo3="",visitTo4="",DateCal="",claimtype="",costcenter="",cost="";
     String entredby="",behalf="";
     NumberFormat nf=NumberFormat.getInstance();
   //  nf.getMaximumIntegerDigits();
     //nf.getMinimumIntegerDigits();
%>
<%
try {
conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();
st4 = conn.createStatement();
st5 = conn.createStatement();
String sqlCreateTmpTable="";

Date today = new Date();
fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
toDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
DateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String EmpName=session.getAttribute("EmpName").toString();
System.out.println(">>>>>EmpName:"+EmpName);
String counter="1";
String sqlGetHistory="",sqlTmpData="",ClaimNo="",Type1="";
ResultSet rsCounter;
String id=request.getParameter("id").trim();
System.out.println(">>>>>id:"+id);
status=request.getParameter("status"); 
System.out.println("TTTTTTTTTTTTTTTTTTTTTTTT"+status);
String action=request.getParameter("action");
System.out.println(">>>>>action:"+action);
String msg=request.getParameter("msg");
System.out.println(">>>>>msg:"+msg);
purpose=request.getParameter("porpose");
origin=request.getParameter("orign");
destination=request.getParameter("dest");
advanceTaken=request.getParameter("advanceTaken");
if(purpose == null)
{purpose="";}
if(origin==null)
 origin="";
if(destination==null)
 destination="";
if(advanceTaken==null)
	advanceTaken="0.0";

String save=request.getParameter("Save");
String submit=request.getParameter("Submit");
String fn="";

if(save==null || submit==null){
System.out.println("in if ............");
		if(action.contains("update")||action.contains("-"))
		 {
				 if(status.equals("Open") || status.equals("-")|| status.equals("Pending")){
						fn="hi";
					 
				 }
		}else{
			
			fn="hiii";

		}
		

}
else if(save!=null){
	System.out.println("in next  if ............");
	fn="hiiii";

}

//
/*

if(purpose.contains("null") || purpose== null)
{purpose="";}

*/
%>
 <body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" onload="counter=<%=counter %>;<%=fn %>();" >
<%
%>
<form name="addDetails" id="addDetails"  method="post" action="insertClaim.jsp"  enctype="multipart/form-data" onSubmit="return validate();">
<table border="0" style="width:100%;">
<tr>
	<td style="width:10%;"><a href="claimReport.jsp?action=view" style="font-weight: bold; ">View Your Claims</a></td>
	<td align="center">
       <div 
		style="font-size: 1.7em; text-align: center; margin-top: 0.1em; margin-bottom: 0.1em;">
		<a>Claim Module</a></div>
	</td>
</tr>
</table>
<table border="0" align="center" style="background-color: #C6DEFF;font-family: arial;font-size:8;" width="100%">
<input type="hidden" name="id" id="id" value="<%= id%>"/><input type="hidden" name="action" id="action" value="<%= action%>"/>
<input type="hidden" name="status" id="status" value="<%=status%>"/><input type="hidden" name="msg" id="msg" value="<%=msg%>"/>
<% 
if(msg!=null)
{ 	
%>        
	 <script type="text/javascript">
	 var msg=document.getElementById("msg").value;
	 alert(msg);
	</script>
	
<%}


String CLMRefNumber="-";
java.text.DecimalFormat df = new java.text.DecimalFormat("000");
try
{
	String EMPName=session.getAttribute("EmpName").toString();
	System.out.println(">>>>>>>>>>>EMPName:"+EMPName);  
	Date d1 = new Date();
	//CLMRefNumber="CLM";
	String date =  new SimpleDateFormat("ddMMyy").format(new Date());
	
    String SqlEmpDetails="select Dept,TALevel from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EMPName+"'";
	ResultSet rsEmpDetails=st4.executeQuery(SqlEmpDetails);
	System.out.println("\n>>>>>>>>>>SqlEmpDetails:"+SqlEmpDetails);
	if(rsEmpDetails.next())
	{
		department=rsEmpDetails.getString("Dept");
		
		if(rsEmpDetails.getString("TALevel")==null ||rsEmpDetails.getString("TALevel")=="")
		{
			grade="-";
		}
		else
		{
			grade=rsEmpDetails.getString("TALevel");	
		}
		System.out.println(">>>>department:"+department);
		System.out.println(">>>>grade:"+grade);
	}
    
}
catch(Exception e)
{
    e.printStackTrace();		
}


//*************If condition for new claim enter ********************
if(id.contains("-"))
{ %>
<tr>
<td Style="width:10%;"><div align="left"><b>Claim Ref ID :</b></div></td>
<td><input type="hidden" name="clmrefid" id="clmrefid" value="<%= CLMRefNumber%>"/><%= CLMRefNumber%></td>
<td><b>Claimant Name:</b></td>
<td><%=session.getAttribute("EmpName").toString() %></td>
<td><b>Department:</b></td>
<td><%=department %></td>
</tr>

<tr>
<td><b>TA Level:</b></td>
<td><%=grade %></td>
<td><b>CompanyName:</b></td>
<td><select name="ourcompany" id="ourcompany" style="width:250px; height: 25px;" class="select">
<%
  //String SqlComany="Select OurCompanyName from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet";
 String SqlComany="Select Companyname from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
  ResultSet rsCompany=st1.executeQuery(SqlComany);
  System.out.println(">>>>>>>>SqlComany:"+SqlComany);
  while(rsCompany.next())
  {
	  %>
	 <option value="<%=rsCompany.getString("Companyname") %>"><%=rsCompany.getString("Companyname") %></option>
	  <%
  }
%>
</select>
</td>
<td><b>Claim Type:</b></td>
<td><select name="claimtype" id="claimtype" style="width: 100px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; " onchange="ChangingClaimType();">
<option value="localclaim">Local Claim</option>
<option value="travelclaim">Travel Claim</option>
</select>

</td>
</tr>
<tr>
<td align="left"><strong><b>From Date :</b></strong></td>
<td><input type="text" id="fromdate1" onmousedown="unCheckAll()" name="fromdate1" value="<%=fromDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:  	#C0C0C0" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate1",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate1"       // ID of the button
}
);
</script>
</td>

<td align="left"><strong><b>To Date: </b></strong></td>
<td><input type="text" id="todate1" onmousedown="unCheckAll()" name="todate1" value="<%=toDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:#C0C0C0" />

<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate1",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate1"       // ID of the button
}
);
</script>
</td>
<td><strong><b>Advance Taken : </b></strong> </td>
<td><input type="text" name="advanceTaken" id="advanceTaken" value="<%=advanceTaken %>" class="input"/></td>
</tr>
<tr>
<td style="width: 250px;"><b>Purpose:</b><font size="2" color="red">*</font></td>
<td><input type="text" name="purpose" value="<%=purpose%>" id="purpose" class="input" /></td>

<td><b>Origin :</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><input type="text" name="origin" value="<%=origin%>" id="origin" class="input"/>
</td>
<td><b>Destination:</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><input type="text" name="destination" value="<%=destination %>" id="destination" class="input"/>
</td>
</tr>
<tr >
	<td>
	<label ><b>Upload Bill</b> </label>&nbsp;&nbsp;
	<td colspan="1" align="left"><input type="file"  name="uploadBill" id="uploadBill" class="input" />
	</td>
	<td>
	<label><b> On Behalf Of</b> </label>&nbsp;&nbsp;</td>
<td><select name="bhalf" id="bhalf" style="width:250px; height: 25px;" class="select">
  	<option value="<%=session.getAttribute("EmpName").toString() %>"><%=session.getAttribute("EmpName").toString() %></option> 
	<%
	try{
	String sqlbhalf="select EmpName,Dept from "+session.getAttribute("CompanyMasterID").toString()+"security order by EmpName ASC";
	ResultSet rsbhalf=st5.executeQuery(sqlbhalf);
	
	System.out.println("%%%%%%%%%%%%%"+sqlbhalf);
	while(rsbhalf.next())
	{
	%>
	<option value='<%=rsbhalf.getString("EmpName")%>'><%=rsbhalf.getString("EmpName")%> </option>	
		
	<% } System.out.println();
	}catch(Exception e){e.printStackTrace();}
	%>
	
	</select>
	</td> 
</tr>

<%//*************End If condition for new claim enter ********************
}

////************* condition For Exiting claim  ********************
else 
{
	    String SqlClaimMaster="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"claim_master where CLMRefNumber='"+id+"' ";
	    System.out.println("\n#########################SqlClaimMaster:################"+SqlClaimMaster);	
	    ResultSet rsClaimMaster=st4.executeQuery(SqlClaimMaster);
	    if(rsClaimMaster.next())
	    {
	    	claimtype=rsClaimMaster.getString("ClaimType");System.out.println("\n###########################claimtype:############"+SqlClaimMaster);	
	    	companyName=rsClaimMaster.getString("CostCenter");System.out.println("\n###########################companyName:############"+companyName);
	    	purpose=rsClaimMaster.getString("Purpose");System.out.println("\n###########################purpose:############"+purpose);
	    	advanceTaken=rsClaimMaster.getString("AdvanceTaken");System.out.println("\n###########################advanceTaken:############"+advanceTaken);
	    	origin=rsClaimMaster.getString("Origin");System.out.println("\n###########################origin:############"+origin);
	    	destination=rsClaimMaster.getString("Destination");System.out.println("\n###########################destination:############"+destination);
	  	    fromDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimMaster.getString("DepartureDateTime"))); 
	  	    toDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimMaster.getString("ArrivalDateTime"))); 
	  	    System.out.println("\n###########################fromDate:############"+fromDate);
	  	    System.out.println("\n###########################toDate:############"+toDate);
	  	    costcenter=rsClaimMaster.getString("CostCenter");
			behalf=rsClaimMaster.getString("Behalf");
	    }
	%>

<%if(action.contains("update"))
{
	System.out.println("\n>>>>>>>>In if>>>>>>>>>");	
%>
<tr>
<td Style="width:10%;"><div align="left"><b>Claim Ref ID :</b></div></td>
<td><input type="hidden" name="clmrefid" id="clmrefid" value="<%=id%>"/><%=id%></td>
<td><b>Claimant Name:</b></td>
<td><%=session.getAttribute("EmpName").toString() %></td>
<td><b>Department:</b></td>
<td><%=department %></td>
</tr>

<tr>
<td><b>TA Level:</b></td>
<td><%=grade %></td>
<td><b>CompanyName:</b></td>
<td><select name="ourcompany1" id="ourcompany1" style="width:250px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
<%
  String SqlComany="Select OurCompanyName from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet";
  ResultSet rsCompany=st1.executeQuery(SqlComany);
  System.out.println(">>>>>>>>SqlComany:"+SqlComany);
  while(rsCompany.next())
  {
	  cost=rsCompany.getString("OurCompanyName");
	 
	  
	  if(costcenter.contains(cost))
	  {
	  %>
	 <option value='<%=costcenter %>' selected><%=costcenter %></option>
	  <%
	  }
	  else
	  {
		 %>
		<option value='<%=cost %>'><%=cost %></option>
		<% 
	  }
  }
  
%>
</select>
</td>
<td><b>Claim Type:</b></td>
<td><select name="claimtype1" id="claimtype1" style="width: 100px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; " onchange="ChangingClaimType();">
<%
   if(claimtype.contains("localclaim"))
   {
	    
%>
<option value='<%=claimtype%>' selected>Local Claim</option>
<option value="travelclaim">Travel Claim</option>
<%}
else
{
	  
	%>
	<option value='<%=claimtype%>' selected>Travel Claim</option>
	<option value="localclaim">Local Claim</option>
	<%	
}%>
</select>

</td>
</tr>
<tr>
<td align="left"><strong><b>From Date :</b></strong></td>
<td><input type="text" id="fromdate2" onmousedown="unCheckAll()" name="fromdate2" value="<%=fromDate %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background:#C0C0C0" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate2",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate2"       // ID of the button
}
);
</script>
</td>

<td align="left"><strong><b>To Date: </b></strong></td>
<td><input type="text" id="todate2" onmousedown="unCheckAll()" name="todate2" value="<%=toDate %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background:#C0C0C0" />

<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate2",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate2"       // ID of the button
}
);
</script>
</td>
<td><strong><b>Advance Taken : </b></strong> </td>
<td><input type="text" name="advanceTaken1" id="advanceTaken1" value="<%=advanceTaken %>" class="input" /></td>
</tr>
<tr>
<td style="width: 250px;"><b>Purpose:</b><font size="2" color="red">*</font></td>
<td><input type="text" name="purpose1" value="<%=purpose%>" id="purpose1" class="input"/></td>

<td><b>Origin :</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><input type="text" name="origin1" value="<%=origin%>" id="origin1" class="input"/>
</td>
<td><b>Destination:</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><input type="text" name="destination1" value="<%=destination %>" id="destination1" class="input"/>
</td>
</tr>
<tr>
	<td>
	<label ><b>Upload Bill</b> </label>&nbsp;&nbsp;
	<td colspan="1" align="left"><input type="file"  name="uploadBill" id="uploadBill" class="input" />
	</td>
	<td>
	<label><b>On Behalf Of</b> </label>&nbsp;&nbsp;</td>
	<td><select name="bhalf1" id="bhalf1" style="width:250px; height: 25px;" class="select">
 	<option value='<%=behalf%>'><%=behalf%></option>
	<%
	String sqlbhalf="select * from UserMaster order by EmpName ASC";
	ResultSet rsbhalf=st5.executeQuery(sqlbhalf);
	
	System.out.println("%%%%%%%%%%%%%"+sqlbhalf);
	while(rsbhalf.next())
	{
	%>
		<option value="<%=rsbhalf.getString("EmpName")%>"><%=rsbhalf.getString("EmpName")%> </option>		
	<% }
	%>
	
	</select>
	</td>
	
</tr>

<%	

}
else
{
%>
<tr>
<td><b>Claim Ref ID :</b></td>
<td><input type="hidden" name="clmrefid" id="clmrefid" value="<%= id%>"/><%= id%></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>Claimant Name:</b></td>
<td><%=session.getAttribute("EmpName").toString() %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>Department:</b></td>
<td><%=department %></td>
</tr>

<tr>
<td><b>TA Level:</b></td>
<td><%=grade %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>CompanyName:</b></td>
<td><%=companyName %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>Claim Type:</b></td>

<%
   if(claimtype.contains("localclaim"))
   {
	   Type1="Local Claim";
   }
   else
   {   Type1="Travel Claim";
   }
%>
<td><%=Type1 %></td>
</tr>
<tr>
<td><strong><b>From Date :</b></strong></td>
<td><%=fromDate %> </td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><strong><b>To Date: </b></strong></td>
<td><%=toDate %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><strong><b>Advance Taken : </b></strong> </td>
<td><%=advanceTaken %></td>
</tr>
<tr>
<td><b>Purpose:</b><font size="2" color="red">*</font></td>
<td><%=purpose %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>Origin :</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><%=origin %></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><b>Destination:</b><font size="2" color="red">*</font></td>
<td style="width: 250px;"><%=destination %></td>
<%} %>
</tr>

	<%

	  
}
////*************End Else Condition For Exiting claim  ********************
%>
</table>

<table border="0" align="center" style="width:100%;font-family: arial" >
<tr>
<td><b>Note: * Marked fields are Mandatory.</b></td>

<%  //IF Status is open and - then save & submit show

 if(action.contains("update")||action.contains("-"))
 {
		 if(status.equals("Open") || status.equals("-")|| status.equals("Pending")){
			%>
 			<input type ="hidden" id="button" name="button"/>
			<td align="right">&nbsp;&nbsp;&nbsp;<input type="submit" id="Save" name="Save" value="Save"  onclick="checkButton()" style="border: outset; background-color: #C6DEFF" />	 	
			    &nbsp;&nbsp;&nbsp;<input type="submit" id="Submit" name="Submit" value="Submit"  onclick="checkButton1()"style="border: outset; background-color: #C6DEFF" /></td>
			<%}
 } %>
		
</tr>
</table>


<div align="center" style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.5em; height: 4px; background-color: #339CCB"></div>
<div id="insertitem">
<table id="tableID"  class='sortable' align="center" style="width:100%;font-size:8;font-family: arial" border="1px">
<tr>
<%if(action.contains("update")||action.contains("-")){ %>
<th style="width: 10px">Delete</th>
<th style="width: 10px">Edit</th>
<%} %>
<th style="width: 10px">Srno</th>
<th style="width: 50px">Category</th>
<th style="width: 50px">Mode</th>
<th style="width: 80px">Origin</th>
<th style="width: 80px">Destination</th>
<th style="width: 50px">Amount</th>
<th style="width: 100px">From</th>
<th style="width: 100px">To</th>
<th style="width: 150px">Purpose</th>
<th style="width: 20px">KmTraveled</th>
<th style="width: 80px">City</th>
<th style="width: 80px">BillBy</th>
<th style="width: 80px">BillNo</th>
<th>Remarks</th>
<th>Claim Bills</th>
</tr>
<% int i=0,j=1;
   String Date1="-",SqlClaimDet="",SqlClaimAmount="";
  
	  
   if(id.contains("-"))
   {   
   SqlClaimDet="Select * from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+CLMRefNumber.trim()+"' and Cancel=1 ";
    SqlClaimAmount="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+CLMRefNumber+"' and Cancel=1";
   }
   else
   {	  
	   SqlClaimDet="Select * from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id.trim()+"' and Cancel=1";
	   SqlClaimAmount="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel=1";
   }
   System.out.println(">>>>>SqlClaimDet:"+SqlClaimDet);
   ResultSet rsClaimDet=st1.executeQuery(SqlClaimDet);
   
   System.out.println("//////"+status);
   
   while(rsClaimDet.next())
   {
	  
	  %>
	  <tr>
	 <% 
	 if(action.contains("update")||action.contains("-"))
	 {  if(status.equals("Open") || status.equals("-")|| status.equals("Pending"))
	   { %>
	  
	  <td style="width: 10px"><a href="#" style="font-weight: bold; color: black; " onclick="DeleteRow('<%= rsClaimDet.getInt("SrNo")%>');"><img src="images/delete.jpeg" width="20px" height="18px" style="border-style: none"></img></a>
	  </td>
		<%	 if(rsClaimDet.getString("Particulars").toString().contains("Expense")){
         %>
         <td><a href="#" style="font-weight: bold; color: black; " onclick="PopUpWindow('UpdateClaimItems.jsp','<%= rsClaimDet.getInt("SrNo")%>','<%=rsClaimDet.getString("Particulars") %>','<%=rsClaimDet.getString("Amount") %>','<%=rsClaimDet.getString("BillNo") %>','<%=rsClaimDet.getString("CommentsByEmp") %>','<%=rsClaimDet.getString("BillDate") %>','0','0','<%=rsClaimDet.getString("Purpose") %>','0','0','0','0','0','0','<%=rsClaimDet.getString("BillBy") %>');">
         <img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img>
         </a></td>
        <%}
	     if(rsClaimDet.getString("Particulars").toString().contains("Travel")){
	        %>
	         <td><a href="#" style="font-weight: bold; color: black; " onclick="PopUpWindow('UpdateClaimItems.jsp','<%= rsClaimDet.getInt("SrNo")%>','<%=rsClaimDet.getString("Particulars") %>','<%=rsClaimDet.getString("Amount") %>','0','<%=rsClaimDet.getString("CommentsByEmp") %>','<%=rsClaimDet.getString("BillDate") %>','<%=rsClaimDet.getString("ModeOfParticulars") %>','<%=rsClaimDet.getString("KmTraveled") %>','<%=rsClaimDet.getString("Purpose") %>','0','0','0','0','0','0','<%=rsClaimDet.getString("BillBy") %>');">
	         <img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img>
	         </a></td>
	       <%}
	     if(rsClaimDet.getString("Particulars").toString().contains("JourneyFare")){
		        %>
		         <td><a href="#" style="font-weight: bold; color: black; " onclick="PopUpWindow('UpdateClaimItems.jsp','<%= rsClaimDet.getInt("SrNo")%>','<%=rsClaimDet.getString("Particulars") %>','<%=rsClaimDet.getString("Amount") %>','<%=rsClaimDet.getString("BillNo") %>','<%=rsClaimDet.getString("CommentsByEmp") %>','<%=rsClaimDet.getString("BillDate") %>','<%=rsClaimDet.getString("ModeOfParticulars") %>','0','<%=rsClaimDet.getString("Purpose") %>','<%=rsClaimDet.getString("FromPlace") %>','<%=rsClaimDet.getString("ToPlace") %>','<%=rsClaimDet.getString("FromDateTime") %>','<%=rsClaimDet.getString("ToDateTime") %>','<%=rsClaimDet.getString("City") %>','<%=rsClaimDet.getString("CompanyName") %>','<%=rsClaimDet.getString("BillBy") %>');">
		         <img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img>
		         </a></td>
		       <%}
	     if(rsClaimDet.getString("Particulars").toString().contains("HotelExpence") ||rsClaimDet.getString("Particulars").toString().contains("HotelExpence") ||rsClaimDet.getString("Particulars").toString().contains("Conveyance") ||rsClaimDet.getString("Particulars").toString().contains("Stationary")||rsClaimDet.getString("Particulars").toString().contains("Miscellaneous")){
		        %>
		        <td><a href="#" style="font-weight: bold; color: black; " onclick="PopUpWindow('UpdateClaimItems.jsp','<%= rsClaimDet.getInt("SrNo")%>','<%=rsClaimDet.getString("Particulars") %>','<%=rsClaimDet.getString("Amount") %>','<%=rsClaimDet.getString("BillNo") %>','<%=rsClaimDet.getString("CommentsByEmp") %>','<%=rsClaimDet.getString("BillDate") %>','<%=rsClaimDet.getString("ModeOfParticulars") %>','0','<%=rsClaimDet.getString("Purpose") %>','0','0','<%=rsClaimDet.getString("FromDateTime") %>','0','<%=rsClaimDet.getString("City") %>','<%=rsClaimDet.getString("CompanyName") %>','<%=rsClaimDet.getString("BillBy") %>');">
		         <img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img>
		         </a></td>
		       <%}
	     if(rsClaimDet.getString("Particulars").toString().contains("Select")){
	    	 %>
		        <td><a href="#" style="font-weight: bold; color: black; " onclick="PopUpWindow('UpdateClaimItems.jsp','<%= rsClaimDet.getInt("SrNo")%>','<%=rsClaimDet.getString("Particulars") %>','<%=rsClaimDet.getString("Amount") %>','<%=rsClaimDet.getString("BillNo") %>','<%=rsClaimDet.getString("CommentsByEmp") %>','<%=rsClaimDet.getString("BillDate") %>','<%=rsClaimDet.getString("ModeOfParticulars") %>','0','<%=rsClaimDet.getString("Purpose") %>','0','0','<%=rsClaimDet.getString("FromDateTime") %>','0','<%=rsClaimDet.getString("City") %>','<%=rsClaimDet.getString("CompanyName") %>','<%=rsClaimDet.getString("BillBy") %>');">
		         <img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img>
		         </a></td>
		       <%}
	   }}%>
      <td><div align="right"><font size=2 color="black"><%=++i%></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("Particulars") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("ModeOfParticulars") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("FromPlace") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("ToPlace") %></font></div></td>
      <td><div align="right"><font size=2 color="black"><%=rsClaimDet.getString("Amount") %></font></div></td>
      <%
           if(rsClaimDet.getString("Particulars").toString().contains("Expense") ||   rsClaimDet.getString("Particulars").toString().contains("Travel")) 
           {
        	   %>
        	  <td><div align="right"><font size=2 color="black"><%= Date1%></font></div></td> 
        	  <td><div align="right"><font size=2 color="black"><%= Date1%></font></div></td> 
        	   <%
           }
           else
           {
        	   if(rsClaimDet.getString("Particulars").toString().contains("JourneyFare")) 
               {
        	   %>
        	   <td><div align="right"><font size=2 color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime")))%></font></div></td>
        	   <td><div align="right"><font size=2 color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("ToDateTime"))) %></font></div></td>
        	   <%
               }
        	   else
        	   {
        	   %>
        		 <td><div align="right"><font size=2 color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime"))) %></font></div></td> 
        		 <td><div align="right"><font size=2 color="black"><%= Date1%></font></div></td> 
        	   <%
        	    }
        	   
           }
      %>
      
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("Purpose") %></font></div></td>
      <td><div align="right"><font size=2 color="black"><%=rsClaimDet.getString("KmTraveled") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("City") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("BillBy") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("BillNo") %></font></div></td>
      <td><div align="left"><font size=2 color="black"><%=rsClaimDet.getString("CommentsByEmp") %></font></div></td>
      <td>
      <% if(rsClaimDet.getString("Uploadbill").equalsIgnoreCase("-"))
      	{
         %>
        				 <div align="left"  style="font-size: 1.1em;"><%=rsClaimDet.getString("Uploadbill") %></div>
         <%}
      	else{ %>
       <div align="left"><font size=2 ><a href="DownloadClaim.jsp?documentName=<%=rsClaimDet.getString("Uploadbill")%>"><%=rsClaimDet.getString("Uploadbill") %></a></font></div>
      					<%-- <a href="DocumentsAttached.jsp?documentName=<%=rsClaimDet.getString("Uploadbill")%>" target="/" onclick="window.open(this.href,'jav','width=700,height=600,top=150,left=260,location=0, menubar=0, scrollbars=yes, status=0, toolbar=0,resizable=0');return false;">
      				    <div align="left"><font size=2 ><%=rsClaimDet.getString("Uploadbill") %></font></div></a> --%>
      					
      	<%} %>							
      	</td>
      
	  </tr>
	  <%  
   }
   %>
   <%
     double ClaimAmount=0.00,advance=0.00;
      ResultSet rsAmount=st2.executeQuery(SqlClaimAmount);
      System.out.println(">>>>>>>>>SqlClaimAmount:"+SqlClaimAmount);
      if(rsAmount.next())
      {
    	  ClaimAmount=rsAmount.getDouble(1);
    	  System.out.println(">>>>>>>>>ClaimAmount:"+ClaimAmount);
    	  System.out.println(">>>>>>>>>advanceTaken:"+advanceTaken);
      }
     
       %>
      <tr>
  <%
 
  if(action.contains("update")||action.contains("-")){ 
  
  if(i==0)
     {%><td colspan="17" align="center"><b>No Data Found</b></div></td><%
     }else{%> 
   <td colspan="16" ><div align="right"><b>Claim Amount:</b></div></td>
   <td><div align="right"><font size=2 color="black"><%=nf.format(ClaimAmount) %>.00</font></div></td>
   </tr>
   <tr>
    <td colspan="16" align="right"><div align="right"><b>Payable Amount:</b></br>(Claim Amount-AdvanceTaken)</div></td>
   <td ><div align="right"><font size=2 color="black"><%= nf.format(ClaimAmount-Double.parseDouble(advanceTaken))%>.00</font></div></td>
   </tr>
   <%}}else
   { if(i==0)
     {%><td colspan="15" align="center"><b>No Data Found</b></div></td><%
     }else{%>
	 <td colspan="14" ><div align="right"><b>Claim Amount:</b></div></td>
   <td><div align="right"><font size=2 color="black"><%=nf.format(ClaimAmount) %>.00</font></div></td>
   </tr>
   <tr>
    <td colspan="14" align="right"><div align="right"><b>Payable Amount:</b></br>(Claim Amount-AdvanceTaken)</div></td>
   <td ><div align="right"><font size=2 color="black"><%= nf.format(ClaimAmount-Double.parseDouble(advanceTaken))%>.00</font></div></td>
   </tr>  
   <%} } %>
       <input type="hidden" name="advance" id="advance" value=" <%=advanceTaken%>"/>
   
</table>

<table width="100%">
<tr align="left">

<%
if(action.contains("update")||action.contains("-"))
{
	if(status.equals("Open") || status.equals("-")|| status.equals("Pending"))
	{ 
		if(id.contains("-"))
			         { %>
					  <td>
					  <a href="#" style="font-weight: bold; color: blue; " onclick="popup('ItemClaimInsert.jsp','<%=CLMRefNumber %>');">&nbsp;&nbsp;<font size="3" ><img src="images/add5.jpeg" width="25px" height="25px" title="Open Claim Detail Form" /></font></a>[click here for claim details]
					  </td>       		
				   <%}
		else{%>	<td>
						<a href="#" style="font-weight: bold; color: blue; " onclick="popupNewWindow('ItemClaimInsert.jsp','<%=claimtype %>','<%=id %>');">&nbsp;&nbsp;<font size="3" ><img src="images/add5.jpeg" width="25px" height="25px" title="Open Claim Detail Form" /></font></a>[click here for claim details]
						</td>       		
			<%}
}	
%></tr>


<%}//}
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
</table>

<table align="right" border="0"><tr><td>
</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td>
</td>
</tr>
</table>
</div>
</form>
<!-- <br><br>  -->
<!-- <br><br>  -->
<!-- <br><br> -->
<!-- <br><br> -->
<!-- <br><br> -->
<!-- <br><br> -->
<!-- <br><br> -->
<!-- <div id="footer"> -->
<!-- <p><a href="http://www.192.168.2.133"> Copyright &copy; 2009 by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- </div> -->
<script>
function hi(){
	//alert("hi");
 	document.getElementById("Save").style.visibility="hidden";

	 	document.getElementById("Submit").style.visibility="";
		document.getElementById("insertitem").style.visibility=""; 
	}
function hiii(){
		//alert("hiii");
		 	document.getElementById("Submit").style.visibility="hidden";
			document.getElementById("insertitem").style.visibility="hidden"; 
		}
function hiiii(){
	//alert("hiiii");
	  document.getElementById("Save").style.visibility="hidden";

	 	document.getElementById("Submit").style.visibility="";
		document.getElementById("insertitem").style.visibility=""; 
	}
		
</script>
</body>
</html>
</jsp:useBean>
<%@include file="footer_new.jsp" %>