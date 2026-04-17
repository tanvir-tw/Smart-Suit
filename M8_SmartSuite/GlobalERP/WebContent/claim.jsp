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
.menu a:hover {text-decoration: underline;}
/* position your menus */
#menu1 {position: absolute;width: 100px;}

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

function showVisitingCardDetails(companyName,id) 
{
    if(id==1)
    { 
    	document.getElementById("companyList").style.display='none';
    } 
    if(id==2)
    {
    	document.getElementById("companyList1").style.display='none';
    } 
    if(id==3)
    {
    	document.getElementById("companyList2").style.display='none';
    } 
    if(id==4)
    {
    	document.getElementById("companyList3").style.display='none';
    } 
    if(id==5)
    {
    	document.getElementById("companyList4").style.display='none';
    } 

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

			var data=reslt.split("#");
			if(id==1)
			{
			 document.addDetails.companyNames.value=data[1];
			}
			if(id==2)
			{
			 document.addDetails.companyNames1.value=data[1];
			}
			if(id==3)
			{
			 document.addDetails.companyNames2.value=data[1];
			}
			if(id==4)
			{
			 document.addDetails.companyNames3.value=data[1];
			}
			if(id==5)
			{
			 document.addDetails.companyNames4.value=data[1];
			}
		}
	}
	var queryString = "?companyName=" +companyName;
	ajaxRequest.open("GET", "AjaxShowVisitingCard.jsp" + queryString, true);
	ajaxRequest.send(null); 


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
      
    if( advance=='')
    {
       alert("Advance Amount should be  Numeric");
       return false;
    }
  return true;
}

function addRow(tableID,id,mf,action)
{
	 var SrNo=id;
	 var modiflag = mf;
	 var myaction = action;
	 if (modiflag=="N" && action == "POST")
     {
	   var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
	   var amount=document.addDetails.amount.value;
	   var billNo=document.addDetails.billNumber.value;
	   var billDate=document.addDetails.billDate.value;
	   var Comments=document.addDetails.billComments.value;
	   var mode=document.addDetails.mode.value;
	   //alert(mode);
	   var city=document.addDetails.city.value;
	   var fromplace=document.addDetails.fromplace.value;
	   var toplace=document.addDetails.toplace.value;
	   var fromdate=document.addDetails.fromdate1.value;
	   var todate=document.addDetails.todate1.value;
	   var hrs=document.addDetails.hrs.value;
	   var hrs1=document.addDetails.hrs1.value;
	   var min=document.addDetails.min.value;
	   var min1=document.addDetails.min1.value;
	   var sec=00;
	   var sec1=00;
	   var companyNames=document.addDetails.companyNames.value;
	   var companyNames1=document.addDetails.companyNames1.value;
	   var companyNames2=document.addDetails.companyNames2.value;
	   var companyNames3=document.addDetails.companyNames3.value;
	   var companyNames4=document.addDetails.companyNames4.value;
	   if(amount=='')
	   { 
		   alert("Please enter amount"); return false; 
	   }


     }
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
					{
						if (modiflag=="N" && action == "POST")
	                    {
							document.addDetails.amount.value='';
							document.addDetails.billNumber.value='';
							document.addDetails.billComments.value='';
							document.getElementById("otherclient").style.visibility="hidden";
							document.getElementById("otherclient1").style.visibility="hidden";
							document.getElementById("otherclient2").style.visibility="hidden";
							document.getElementById("otherclient3").style.visibility="hidden";
							document.getElementById("client1").style.visibility="hidden";
							document.getElementById("client2").style.visibility="hidden";
							document.getElementById("client3").style.visibility="hidden";
							document.getElementById("entryform").style.visibility="hidden";
							
							window.location.reload();                         
	                    }
						if (modiflag=='D' && action == 'GET')
						{
							//var queryString = "?srno="+SrNo;
							window.location.reload();
						}
					
					}
                  
                   
                   
      			} 
			}
			if (modiflag=='N' && action == 'POST')
			{ 
				var queryString = "?action=add&srno="+counter+"&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&Comments="+Comments+"&category="+category+"&mode="+mode+"&city="+city+"&fromplace="+fromplace+"&toplace="+toplace+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;
				
			}
			if (modiflag=="N" && action=="GET")
		    {
				//var queryString = "?action=add&srno="+counter+"&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&Comments="+Comments+"&category="+category+"&mode="+mode+"&city="+city+"&fromplace="+fromplace+"&toplace="+toplace+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;

				   document.addDetails.city.value='';
				   document.addDetails.fromplace.value='';
				   document.addDetails.toplace.value='';
				   document.addDetails.companyNames.value='';
				   document.addDetails.amount.value='';
				   document.addDetails.billNumber.value='';
				   document.addDetails.billComments.value='';
			}
			if (modiflag=='D' && action == 'GET')
			{
                //alert(">>>>>>in Delete");
				var queryString = "?action=delete&srno="+SrNo;
			}
			
			ajaxRequest.open("GET", "AjaxClaimEnq.jsp" + queryString, true);
			ajaxRequest.send(null); 
		}
/*function addRow(tableID) 
{
   var category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
   //if(category="Select")
   //{
	//   alert("Please Select Category");
   //}
   var amount=document.addDetails.amount.value;
   var billNo=document.addDetails.billNumber.value;
   var billDate=document.addDetails.billDate.value;
   var Comments=document.addDetails.billComments.value;
   var mode=document.addDetails.mode.value;
   //alert(mode);
   var city=document.addDetails.city.value;
   var fromplace=document.addDetails.fromplace.value;
   var toplace=document.addDetails.toplace.value;
   var fromdate=document.addDetails.fromdate1.value;
   var todate=document.addDetails.todate1.value;
   var hrs=document.addDetails.hrs.value;
   var hrs1=document.addDetails.hrs1.value;
   var min=document.addDetails.min.value;
   var min1=document.addDetails.min1.value;
   var sec=00;
   var sec1=00;
   var companyNames=document.addDetails.companyNames.value;
   var companyNames1=document.addDetails.companyNames1.value;
   var companyNames2=document.addDetails.companyNames2.value;
   var companyNames3=document.addDetails.companyNames3.value;
   var companyNames4=document.addDetails.companyNames4.value;
   if(amount=='')
   { 
	   alert("Please enter amount"); return false; 
   }

   var numericExpression = /^[0-9]+$/;
   if(!(amount.match(numericExpression)))
   {
     alert("Amount should be  Numeric");
     return false;
   }

   var ajaxRequest;
   try
   {
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

var queryString = "?action=add&srno="+counter+"&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&Comments="+Comments+"&category="+category+"&mode="+mode+"&city="+city+"&fromplace="+fromplace+"&toplace="+toplace+"&fromdate="+fromdate+"&todate="+todate+"&hrs="+hrs+"&hrs1="+hrs1+"&min="+min+"&min1="+min1+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;
      
ajaxRequest.open("GET", "AjaxClaimEnq.jsp" + queryString, true);
ajaxRequest.send(null); 
ajaxRequest.onreadystatechange = function()
{
	if(ajaxRequest.readyState == 4)
	{
		var reslt=ajaxRequest.responseText;
		//alert(">>>    "+reslt);
		var data=reslt.split("#");
		//alert("<*****  "+data);
		if(data[1].indexOf('Yes')!=-1)
		{
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);
			var cell1 = row.insertCell(0);
			//var element1 = document.createElement("input");
			//element1.type = "checkbox";
			//element1.name = "chk";
			cell1.innerHTML="<img src='images/delete.JPG' width='20px' height='18px' style='border-style: none'>";
			                  		
			var cell2 = row.insertCell(1);
			cell2.innerHTML = counter++ ;
			                  		
			var cell3 = row.insertCell(2);
			cell3.innerHTML = "<div align='left'>"+category+"</div>";
			var cell4 = row.insertCell(3);
			cell4.innerHTML = "<div align='left'>"+mode+"</div>";                  		
			var cell5 = row.insertCell(4);
			cell5.innerHTML = "<div align='right'>"+amount+"</div>";
			                  		
			var cell6 = row.insertCell(5);
			cell6.innerHTML = "<div align='right'>"+billNo+"</div>";
			
			var cell7 = row.insertCell(6);
			cell7.innerHTML = "<div align='right'>"+billDate+"</div>";
			                  		
			var cell8 = row.insertCell(7);
			cell8.innerHTML = "<div align='left'>"+Comments+"</div>";
		
		}
		else
		alert("!!! ERROR while adding data to GRID due to Server Side problem. Please try again.");
	}
}
document.addDetails.amount.value='';
document.addDetails.billNumber.value='';
document.addDetails.billComments.value='';
document.getElementById("otherclient").style.visibility="hidden";
document.getElementById("otherclient1").style.visibility="hidden";
document.getElementById("otherclient2").style.visibility="hidden";
document.getElementById("otherclient3").style.visibility="hidden";
document.getElementById("client1").style.visibility="hidden";
document.getElementById("client2").style.visibility="hidden";
document.getElementById("client3").style.visibility="hidden";
document.getElementById("entryform").style.visibility="hidden";
//document.getElementById("mode").style.visibility="hidden";
//document.getElementById("mode1").style.visibility="hidden";
//document.getElementById("mode2").style.visibility="hidden";	
/*document.getElementById("from").style.visibility="hidden";
document.getElementById("from1").style.visibility="hidden";
document.getElementById("to").style.visibility="hidden";
document.getElementById("to1").style.visibility="hidden";
document.getElementById("from3").style.visibility="hidden";
document.getElementById("from4").style.visibility="hidden";
document.getElementById("to3").style.visibility="hidden";
document.getElementById("to4").style.visibility="hidden";*/
//window.location.reload();
//}

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

/*function deleteRow(tableID,SrNo) 
{
	//alert("IN FUNC  ");
	try 
	{
	var table = document.getElementById(tableID);
	
	//alert(table);
	var a=	document.addDetails.srno.value;
	var srno=	document.addDetails.srno.value;
	var rowCount = table.rows.length;
	//alert(">>>>    "+a);
	
	for(a=0; a<rowCount; a++) 
	{
	 var row = table.rows[a];
	
//	var chkbox = row.cells[0].childNodes[0];
//	if(null != chkbox && true == chkbox.checked) {
	
	var ajaxRequest;
	try
	{
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
	var queryString = "?action=remove&srno="+SrNo;
	ajaxRequest.open("GET", "AjaxClaimEnq.jsp" + queryString, true);
	ajaxRequest.send(null); 
	ajaxRequest.onreadystatechange = function()
	{
	if(ajaxRequest.readyState == 4)
	{
	var reslt=ajaxRequest.responseText;
	//alert(reslt);
	var data=reslt.split("#");
	//alert(data);
	if(data[1].indexOf('Yes')!=-1)
	{
	document.addDetails.status=data[1]; 
	}
	else
	{
	alert("!!! ERROR while removing data from GRID due to Server Side problem. Please try again.");
	}
	}
	//againreload();
	}
	if(document.addDetails.status!="")
	{
	table.deleteRow(a);

	}
	rowCount--;
	a--;
	//alert("I AFTET ___     "+a);
	}
	//}
	}
	catch(e) 
	{
	alert(e);
	}
	//location.reload(document.getElementById(tableID));
	//againreload();
}
/*function againreload()
{
   window.location.reload();	
}*/

function claimReport(action)
{ 
	window.open('claimReport.jsp?action='+action,'jav');
}
function showentryform()
{
	document.getElementById("entryform").style.visibility="visible";
	addRow('tableID','0','N','GET');
}

function cancelentryform()
{
	document.getElementById("otherclient").style.visibility="hidden";
	document.getElementById("entryform").style.visibility="hidden";
	document.getElementById("otherclient").style.visibility="hidden";
	document.getElementById("otherclient1").style.visibility="hidden";
	document.getElementById("otherclient2").style.visibility="hidden";
	document.getElementById("otherclient3").style.visibility="hidden";
	document.getElementById("client1").style.visibility="hidden";
	document.getElementById("client2").style.visibility="hidden";
	document.getElementById("client3").style.visibility="hidden";
}
function getClient1()
{
    //alert("in get");
	document.getElementById("otherclient").style.visibility="visible";
	document.getElementById("client").style.visibility="hidden";
	document.getElementById("client1").style.visibility="visible";
}
function getClient2()
{
    //alert("in get");
	document.getElementById("otherclient1").style.visibility="visible";
	document.getElementById("client1").style.visibility="hidden";
	document.getElementById("client2").style.visibility="visible";
	
}
function getClient3()
{
    //alert("in get");
	document.getElementById("otherclient2").style.visibility="visible";
	document.getElementById("client2").style.visibility="hidden";
	document.getElementById("client3").style.visibility="visible";
}
function getClient4()
{
    //alert("in get");
	document.getElementById("otherclient3").style.visibility="visible";
	document.getElementById("client3").style.visibility="hidden";
}
function getID(id)
{
        //alert(" IN getID......");
        return document.getElementById(id);
}
// Global object to hold drag information.
var dragObj = new Object();
function dragStart(event, id)
{
       //alert("IN dragStart.....");
  var x, y;
  dragObj.elNode = getID(id);
  // Get cursor position with respect to the page.
  try {
    x = window.event.clientX + document.documentElement.scrollLeft
      + document.body.scrollLeft;
    y = window.event.clientY + document.documentElement.scrollTop
      + document.body.scrollTop;
  }
  catch (e) {
    x = event.clientX + window.scrollX;
    y = event.clientY + window.scrollY;
  }
// Save starting positions of cursor and element.
 dragObj.cursorStartX = x;
  dragObj.cursorStartY = y;
  dragObj.elStartLeft  = parseInt(dragObj.elNode.style.left, 10);
  dragObj.elStartTop   = parseInt(dragObj.elNode.style.top,  10);
  if (isNaN(dragObj.elStartLeft)) dragObj.elStartLeft = 0;
  if (isNaN(dragObj.elStartTop))  dragObj.elStartTop  = 0;
  // Capture mousemove and mouseup events on the page.
  try {
    document.attachEvent("onmousemove", dragGo);
    document.attachEvent("onmouseup",   dragStop);
    window.event.cancelBubble = true;
    window.event.returnValue = false;
  }
  catch (e) {
    document.addEventListener("mousemove", dragGo,   true);
    document.addEventListener("mouseup",   dragStop, true);
    event.preventDefault();
  }
}
function dragGo(event) 
{
 var x, y;
// Get cursor position with respect to the page.
  try  
  {
    x = window.event.clientX + document.documentElement.scrollLeft
      + document.body.scrollLeft;
    y = window.event.clientY + document.documentElement.scrollTop
      + document.body.scrollTop;
  }
  catch (e) 
  {
    x = event.clientX + window.scrollX;
    y = event.clientY + window.scrollY;
  }
  // Move drag element by the same amount the cursor has moved.
  var drLeft = (dragObj.elStartLeft + x - dragObj.cursorStartX);
  var drTop = (dragObj.elStartTop  + y - dragObj.cursorStartY);
  if (drLeft > 0)
  {
     dragObj.elNode.style.left = drLeft  + "px";
  }
  else
  {
        dragObj.elNode.style.left = "1px";
  }
  if (drTop > 0)
  {
     dragObj.elNode.style.top  = drTop + "px";
  }
  else
  {
        dragObj.elNode.style.top  = "1px";
  }
  try {
    window.event.cancelBubble = true;
    window.event.returnValue = false;
  }
  catch(e){
    event.preventDefault();
  }
}
function dragStop(event) {
        //alert("IN DRAG STOP.....");
  // Stop capturing mousemove and mouseup events.
  try {
    document.detachEvent("onmousemove", dragGo);
    document.detachEvent("onmouseup",   dragStop);
  }
  catch (e) {
    document.removeEventListener("mousemove", dragGo,   true);
    document.removeEventListener("mouseup",   dragStop, true);
  }
}

</script>
<script type="text/javascript">
var LastMouse = new Array(0, 0);
var isIE = document.all ? true : false;

  function MouseCatch(e) 
  {
	if (isIE) {
	  LastMouse = [event.clientX, event.clientY];
	} else {
	  LastMouse = [e.pageX, e.pageY];
	};
  };

  function MoveDiv() 
  {
	if (d = document.getElementById("entryform")) 
	{
	  d.style.left = LastMouse[0] + "px";
	  d.style.top = LastMouse[1] + "px";
	};
  };

  document.onmousemove = MouseCatch;
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
     String visitTo1="",visitTo2="",visitTo3="",visitTo4="";
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
String EmpName=session.getAttribute("EmpName").toString();
System.out.println(">>>>>EmpName:"+EmpName);
String counter="1";
String sqlGetHistory="",sqlTmpData="";
ResultSet rsCounter;
if(EmpName.contains("K.K.Manoj"))
{
	EmpName="K K Manoj";
}
if(EmpName.contains("K K Manoj"))
{
	System.out.println(">>>>>>>In If Loop");
   sqlCreateTmpTable="" +
			"	CREATE  TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+EmpName.replaceAll(" ","_")+"" + 
			"	( 	srno 			INT(10) NOT NULL, " +
			"		Category     VARCHAR(100) NULL, " +
			"		Mode			VARCHAR(50) NULL, " +
			"		Amount			VARCHAR(50) NULL default 0, " +
			"		BillNo			VARCHAR(50)	NULL, " +
			"		BillDate			VARCHAR(50)	NULL, " +
			"		Remarks		VARCHAR(255) NULL,  " +
			"     VisitCity  varchar(50) default '-', "+
			"     FromPlace  varchar(255) character set latin1 collate latin1_general_ci default '-', "+
			"     ToPlace  varchar(255) character set latin1 collate latin1_general_ci default '-', " +
			"   FromDateTime  datetime default '0000-00-00 00:00:00', " +
			"    ToDateTime  datetime default '0000-00-00 00:00:00',  " +
			" CompanyName  text  " +
			"	);";
}
else
{
	System.out.println(">>>>>>>In Else Loop");
	 sqlCreateTmpTable="" +
	"	CREATE  TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+session.getAttribute("EmpName").toString().replaceAll(" ","_")+"" + 
	"	( 	srno 			INT(10) NOT NULL, " +
	"		Category     VARCHAR(100) NULL, " +
	"		Mode			VARCHAR(50) NULL, " +
	"		Amount			VARCHAR(50) NULL default 0, " +
	"		BillNo			VARCHAR(50)	NULL, " +
	"		BillDate			VARCHAR(50)	NULL, " +
	"		Remarks		VARCHAR(255) NULL,  " +
	"     VisitCity  varchar(50) default '-', "+
	"     FromPlace  varchar(255) character set latin1 collate latin1_general_ci default '-', "+
	"     ToPlace  varchar(255) character set latin1 collate latin1_general_ci default '-', " +
	"   FromDateTime  datetime default '0000-00-00 00:00:00', " +
	"    ToDateTime  datetime default '0000-00-00 00:00:00',  " +
	" CompanyName  text  " +
	"	);";
}
System.out.println("sqlCreateTmpTable:"+sqlCreateTmpTable);
try
{
st.executeUpdate(sqlCreateTmpTable);
}catch(Exception e){
}

if(EmpName.contains("K K Manoj"))
{
sqlCreateTmpTable="" +
"	CREATE  TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+EmpName.replaceAll(" ","_")+"_Master" + 
"		(FromDate VARCHAR(50) NULL, " +
"		ToDate		VARCHAR(50)  NULL , " +
"		Purpose     	TEXT  NULL, " +
"		Origin			VARCHAR(50)  NULL , " +
"		Destination		VARCHAR(50)	NULL, " +
"		AdvanceTaken	VARCHAR(50)  NULL , " +
"		VisitCity		VARCHAR(50)  NULL,  " +
"       CompanyName  text " +
");";
}
else
{
	sqlCreateTmpTable="" +
	"	CREATE  TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+session.getAttribute("EmpName").toString().replaceAll(" ","_")+"_Master" + 
	"		(FromDate VARCHAR(50) NULL, " +
	"		ToDate		VARCHAR(50)  NULL , " +
	"		Purpose     	TEXT  NULL, " +
	"		Origin			VARCHAR(50)  NULL , " +
	"		Destination		VARCHAR(50)	NULL, " +
	"		AdvanceTaken	VARCHAR(50)  NULL , " +
	"		VisitCity		VARCHAR(50)  NULL,  " +
	"       CompanyName  text  " +
	");";
}
System.out.println("sqlCreateTmpTable:"+sqlCreateTmpTable);
try
{
st.executeUpdate(sqlCreateTmpTable);
}
catch(Exception e)
{
	
}
if(EmpName.contains("K K Manoj"))
{
	sqlGetHistory="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+EmpName.replaceAll(" ","_")+"_Master ";
}
else
{
    sqlGetHistory="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+session.getAttribute("EmpName").toString().replaceAll(" ","_")+"_Master ";
}
  System.out.println("sqlGetHistory:"+sqlGetHistory);
try
{
	ResultSet rsGetHistory=st.executeQuery(sqlGetHistory);
	if(rsGetHistory.next())
	{
		departureDate=rsGetHistory.getString("FromDate");
			fromDateCal=departureDate;
		arrivalDate=rsGetHistory.getString("ToDate");
			toDateCal=arrivalDate;
			
		purpose=rsGetHistory.getString("Purpose");
		origin=rsGetHistory.getString("Origin");
		destination=rsGetHistory.getString("Destination");
		advanceTaken=rsGetHistory.getString("AdvanceTaken");
		VisitCity=rsGetHistory.getString("VisitCity");
	}
	
}
catch(Exception e)
{
	System.out.println("TMP  **  "+e);
	e.printStackTrace();
}
if(EmpName.contains("K K Manoj"))
{
	 rsCounter=st.executeQuery("select max(srno) from "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+EmpName.replaceAll(" ","_")+" ");
}
else
{
	 rsCounter=st.executeQuery("select max(srno) from "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+session.getAttribute("EmpName").toString().replaceAll(" ","_")+"");
}
 
rsCounter.next();
counter=(rsCounter.getInt(1)+1)+""; 
%>
<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" onload="counter=<%=counter %>;" >
<div
style="font-size: 1.7em; text-align: center; margin-top: 0.2em; margin-bottom: 0.2em;">
<a>Claim Module</a></div>

<form name="addDetails" method="get" action="insertClaim.jsp" onSubmit="return validate();" >
<table border="0" align="center" style="background-color: #C6DEFF" width="100%">
<%
String CLMRefNumber="";
java.text.DecimalFormat df = new java.text.DecimalFormat("000");
try
{
	Date d1 = new Date();
	CLMRefNumber="CLM";
	String EMPName=session.getAttribute("EmpName").toString();
	System.out.println(">>>>>>>>>>>EMPName:"+EMPName);    
	String date =  new SimpleDateFormat("ddMMyy").format(new Date());
	String sql3="SELECT CLMRefNumber  from "+session.getAttribute("CompanyMasterID").toString()+"claim_master  where CLMRefNumber like ('"+CLMRefNumber+""+date+"%') ORDER BY CLMRefNumber DESC LIMIT 1";
    ResultSet rs=st2.executeQuery(sql3);
    System.out.println(">>>>sql3:"+sql3); 
  if(rs.next())
  {
	  String a=rs.getString(1);
	  System.out.println(">>>>>>>>  "+a);
	  System.out.println("IN IF  ");
	  CLMRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
	  System.out.println("NO IS:  "+CLMRefNumber);
	
  }
  else
  {
	  CLMRefNumber+=date+"001";	
  }
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
%>
<tr>
<td><div align="left"><b>Claim Ref ID :</b></div></td>
<td><input type="hidden" name="clmrefid" id="clmrefid" value="<%= CLMRefNumber%>"/><%= CLMRefNumber%></td>

<td><b>Department:</b></td>
<td><%=department %></td>
<td><b>TA Level:</b></td>
<td><%=grade %></td>
</tr>
<tr><td></td></tr>
<tr>
<td align="left"><strong><b>From Date :</b></strong></td>
<td><input type="text" id="fromdate1" onmousedown="unCheckAll()" name="fromdate1" value="<%=fromDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
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
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />

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
<td><input type="text" name="advanceTaken" id="advanceTaken" value="<%=advanceTaken %>" style="width:130px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"" /></td>
</tr>
<tr>
<td style="width: 250px;"><b>Purpose:</b></td>
<td><textarea name="purpose" rows="2" id="purpose" style='width: 230px; height: 30px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' ><%=purpose %></textarea></td>
&nbsp;&nbsp;&nbsp;
<td><b>Origin :</b></td>
<td style="width: 250px;"><textarea name="origin" rows="1" id="origin" style='width: 220px; height: 20px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'><%=origin %></textarea>
</td>
<td><b>Destination:</b></td>
<td style="width: 250px;"><textarea name="destination" rows="1" id="destination" style='width: 220px; height: 20px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'><%=destination %></textarea>
</td>

<!-- <td>&nbsp;&nbsp;&nbsp;</td>
 
 
  <td valign="top" align="left" > 

<div id="menu1" dir="rtl" class="menu" onmouseover="show('menu1');" onmouseout="hide('menu1');">
<div class="menuHead">Menu &nbsp;<blink><img src="images/down.gif"></blink></div>
<div id="menu1choices" class="menuChoices" style="display: none;">
<a href="#" onclick="claimReport('sanction');">Sanction</a><br />
<a href="#" onclick="claimReport('check');">Check (Audit)</a><br />
<a href="#" onclick="claimReport('approve');">Approve</a><br />
<a href="#" onclick="claimReport('sanction');">Pay</a><br />
 <a href="#" onclick="window.open('claimAbstract.jsp');">Reports</a><br /> 

</div>
</div>  
<!-- <script type="text/javascript">
<!--
/* Don't hide menus for JS off and older browsers */
if (DOMCapable)
{
hide("menu1");
}
//
</script>  -->
	
</td>
<%//} %>	
<!-- ADD REPORTS HERE  --> 
<td>
<input type="hidden" id="nameofEmp" name="nameofEmp" value="<%=session.getAttribute("EmpName").toString() %>" />
<input type="hidden" id="companyName" name="companyName" value="<%=companyName %>"/>
<!--
<input type="hidden" id="grade" name="grade" value="M1" />
<input type="hidden" id="department" name="department" value="Marketing" /> -->
</td>
</tr>

</table>
<br>
<div id="entryform" style="margin-left:18%; margin-top:2%; height:250;width:65%; border:thin solid; border-color: blue;position:absolute; background-color: #E1F3F3; border-radius: 12px 12px 12px 12px;">
<div style="background-color:#2678B7;height:27;width:100%; color:white; font-size:small;border:thin solid; border-color: blue; border-radius: 12px 12px 0px 0px;"> 
<table style="color: white; align:center;width:100%">
      <tr style="color: white; text-align:center;">
      <td width="80%"><strong>NEW ENTRY</strong></td>
      <td align="right"><input type="button" name="cancel" id="cancel" value="X"  onclick="cancelentryform()" style="width:20; color:red;" /></td>
      </tr>
      </table>
       </div>
<table style="font-size:small;width:100%">
<tr>
<td><b>Category:</b></td>
<td>
<select name="category" id="category" style="width: 150px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<option value='Select'>Select</option>
<option value='JourneyFare'>Journey Fare</option>
<option value='HotelExp'>Hotel Expences</option>
<option value='Conveyance'>Conveyance</option>
<option value='Stationary'>Stationary</option>
<option value='Miscellaneous'>Miscellaneous</option>
</select></td>

<td><strong>Mode:&nbsp;&nbsp;&nbsp;&nbsp;</strong> </td>
<td>
<!--  <div id="mode"></div> <div id="mode1"></div><div id="mode2"></div>-->
<select name="mode" id="mode" style="width: 150px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<option value='-'>Select</option>
<option value='Bus'>Bus</option>
<option value='Train'>Train</option>
<option value='Air'>Air</option>
<option value='Lodging'>Lodging</option>
<option value='D.A'>D.A</option>
<option value='Entertainment'>Entertainment</option>
</select>
</td>
</tr>

<tr>
<td align="left"><div id="from"><strong><b>From:</b></strong></div></td>
<td><div id="from1"><input type="text" id="fromdate" onmousedown="unCheckAll()" name="fromdate" value="<%=fromDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate"       // ID of the button
}
);
</script>

<select name="hrs" id="hrs" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<%
for(int i=0;i<24;i++)
{
	if(i<10)
	{
     
%>
<option value='0<%=i %>'><%=0%><%=i%></option>
<% }
	else
	{
		%>
		<option value='<%=i %>'><%=i%></option>
		<% 	
		
	}
}
	%>
</select>
<select name="min" id="min" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<%
for(int j=0;j<60;j++)
{
	if(j<10)
    {
    
	%>
	<option value='<%=0%><%=j %>'><%=0%><%=j%></option>
	<% }
		else
		{
			%>
			<option value='<%=j %>'><%=j%></option>
			<% 	
			
		}
} %>
</select>

</div>
</td>

<td align="left"><div id="to"><strong><b>To: </b></strong></div></td>
<td><div id="to1"><input type="text" id="todate" onmousedown="unCheckAll()" name="todate" value="<%=toDateCal1 %>" size="15" readonly="readonly"
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />

<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate"       // ID of the button
}
);
</script>
<select name="hrs1" id="hrs1" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<%
for(int i=0;i<24;i++)
{
	if(i<10)
	{
     
%>
<option value='<%=0%><%=i %>'><%=0%><%=i%></option>
<% }
	else
	{
		%>
		<option value='<%=i %>'><%=i%></option>
		<% 	
		
	}
}
	%>
</select>
<select name="min1" id="min1" style="width: 40px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000; ">
<%
for(int j=0;j<60;j++)
{
	if(j<10)
    {
	%>
	<option value='<%=0%><%=j %>'><%=0%><%=j%></option>
	<% 
	}
	else
	{
	%>
	<option value='<%=j %>'><%=j%></option>
	<% 			
	}
} 
%>
</select>


</div>
</td>
</tr>
<tr>
<td><div id="from3"><strong><b>From Place:&nbsp;&nbsp;</b> </strong></div></td>
<td><div id="from4"><input type="text" name="fromplace" id="fromplace" value="" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></div></td>
<td><div id="to3"><strong><b>To Place :&nbsp;&nbsp;</b></strong></div> </td>
<td><div id="to4"><input type="text" name="toplace" id="toplace" value="" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></div></td>
</tr>
<tr>
<td><strong><b>City :&nbsp;&nbsp;&nbsp;&nbsp;</b></strong></td><td><input type="text" name="city" id="city" value="" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>
<td><strong><b>Amount:&nbsp;&nbsp;</b></strong></td> 
<td><input type="text" name="amount" id="search-text" 
style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'></td>
</tr>
<tr>
<td><strong><b>Bill No:&nbsp;&nbsp;</b></strong></td>
<td><input type="text" name="billNumber" id="billNumber" value="<%=billNo %>" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"' /></td>

<td><strong><b>Bill Date:&nbsp;&nbsp;&nbsp;</b></strong></td>
<td><input type="text" id="billDate" onmousedown="unCheckAll()" name="billDate" value="<%=fromDateCal %>" size="15"
readonly="readonly" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
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
<tr>
<td><strong><b>Remarks:&nbsp;&nbsp;&nbsp;&nbsp;
<br>&nbsp;&nbsp;&nbsp;(On this Bill)</b></strong></td>
<td><textarea name="billComments" id="billComments" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"'  ></textarea></td>	
</tr>

<tr>
<td><strong><b>Client :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></strong></td>
<td>
<input type="text" name="companyNames" id="companyNames"  style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
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
<td><div id="client"><input type="button" name="getClient" id="getClient" value="Add Client" onclick="getClient1()"/></div></td>
</tr>


<tr>
<td></td>
<td>
<div id="otherclient">
<input type="text" name="companyNames1" id="companyNames1" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
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
<td><div id="client1"><input type="button" name="getClient" id="getClient" value="Add Client" onclick="getClient2()"/></div></td>


</tr>

<tr>
<td></td>
<td>
<div id="otherclient1">
<input type="text" name="companyNames2" id="companyNames2" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
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
<td><div id="client2"><input type="button" name="getClient" id="getClient" value="Add Client" onclick="getClient3()"/></div></td>
</tr>

<tr>
<td></td>
<td>
<div id="otherclient2">
<input type="text" name="companyNames3" id="companyNames3" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
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
<td><div id="client3"><input type="button" name="getClient" id="getClient" value="Add Client" onclick="getClient4()"/></div></td>

</tr>
<tr>
<td></td>
<td>
<div id="otherclient3">
<input type="text" name="companyNames4" id="companyNames4" style='width: 170px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
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
</tr>
</table>
<table align="center" style="font-size:small">
<tr>
<td><input type="button" name="add" value="Add Claim To Grid" Style="border: outset;" onclick="addRow('tableID','0','N','POST')" /></td>
<td><input type="button" name="cancel" value="Cancel" Style="border: outset;" onclick="cancelentryform()" /></td>
</tr>
</table>
</div>
<script>document.getElementById("entryform").style.visibility="hidden";</script>
<script>document.getElementById("otherclient").style.visibility="hidden";</script>
<script>document.getElementById("otherclient1").style.visibility="hidden";</script>
<script>document.getElementById("otherclient2").style.visibility="hidden";</script>
<script>document.getElementById("otherclient3").style.visibility="hidden";</script>
<script>document.getElementById("client1").style.visibility="hidden";</script>
<script>document.getElementById("client2").style.visibility="hidden";</script>
<script>document.getElementById("client3").style.visibility="hidden";</script>
<div align="center" style="font-size: 1.5em; margin-bottom: 0.2em; height: 4px;"></div>

<div align="center">
<table border="0">
<tr>
<td>
<a href="#" style="font-weight: bold; color: blue; " onclick="showentryform()"><font size="3" >ADD</font>
     	<!-- 	<img src="images/new.JPG" width="25px" height="22px" style="border-style: none"></img> -->
     		</a> 
      		
</td>
			 
<!-- <td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" style="font-weight: bold; color: blue; " onclick="deleteRow('tableID')"><font size="3" >DELETE</font></a></td>

 -->
<td>&nbsp;&nbsp;&nbsp;<input type="submit" name="saveClaim"
value="Save Data " style="border: outset; background-color: #C6DEFF"
/></td>
			
<td>&nbsp;&nbsp;&nbsp;<input type="submit" name="submit"
value="Submit" style="border: outset; background-color: #C6DEFF"
/></td>
</tr>
</table>
</div>

<div align="center"
style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.5em; height: 4px; background-color: #339CCB"></div>

<table id="tableID" border='1px' class='sortable' >
<tr>

<th style="width: 10px">Delete</th>
<th style="width: 10px">Srno</th>
<th style="width: 70px">Category</th>
<th style="width: 70px">Mode</th>
<th style="width: 30px">Amount</th>
<th style="width: 20px"> Bill-No </th>
<th style="width: 25px"> Bill-Date </th>
<th> Remarks</th>
</tr>
<%

	sqlTmpData="select * from "+session.getAttribute("CompanyMasterID").toString()+"tmp_Claim_"+session.getAttribute("EmpName").toString().replaceAll(" ","_")+" order by srno asc ";

ResultSet rsTmpData=st1.executeQuery(sqlTmpData);
while(rsTmpData.next())
{
%> 	 	 	 	
<tr>

<td style="width: 10px"><a href="#" style="font-weight: bold; color: black; " onclick="addRow('tableID','<%=rsTmpData.getString("srno")%>','D','GET')">
            <img src="images/delete.JPG" width="20px" height="18px" style="border-style: none"></img>
            </a></td>
<td style="width: 10px"><div align="right"><input type="hidden" name="srno" id="srno" value="<%=rsTmpData.getString("srno") %>"/><%=rsTmpData.getString("srno")%></div></td>
<td style="width: 70px"><div align="left"><%=rsTmpData.getString("Category")%></div></td>
<td style="width: 70px"><div align="left"><%=rsTmpData.getString("Mode")%></div></td>
<td style="width: 30px"><div align="right"><%=rsTmpData.getString("Amount")%></div></td>
<td style="width: 20px"><div align="right"><%=rsTmpData.getString("BillNo")%></div></td>
<td style="width: 25px"><div align="right"><%=rsTmpData.getString("BillDate")%></div></td>
<td><div align="left"><%=rsTmpData.getString("Remarks")%></div></td>
</tr>
<tr></tr>
<%}
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
<script type="text/javascript">

//document.addDetails.purpose.value='';
//document.addDetails.advanceTaken.value='';
//document.addDetails.origin.value='';
//document.addDetails.destination.value='';
document.addDetails.companyNames.value='';
document.addDetails.companyNames1.value='';
document.addDetails.companyNames2.value='';
document.addDetails.companyNames3.value='';
document.addDetails.companyNames4.value='';
</script>
<table align="right" border="0"><tr><td>
</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td>
</td>
</tr>
</table>
</form>
<br><br> 
<br><br> 
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<div id="footer">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
</div>
</body>
</html>
</jsp:useBean>