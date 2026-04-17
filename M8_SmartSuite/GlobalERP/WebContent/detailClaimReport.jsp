<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%> --%>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style>

.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden;
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
	<title>Transworld Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
		<link href="css/footer.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	//var  myArray = new Array();
	//var cnt=0;

		function checkAll()
	{
			  var field=document.getElementsByName('chk');
				var i;
				try
				{
			     for (i = 0; i < field.length; i++)
			  		 field[i].checked = true ;
				}
				catch(e)
				{
					alert(e);
				}
	}
	function unCheckAll()
	{
			  var field=document.getElementsByName('chk');
				var i;
				try
				{
			       for (i = 0; i < field.length; i++)
			  	    field[i].checked = false ;
				}
				catch(e)
				{
					alert(e);
				}
	}


	 
	</script>
	<script type="text/javascript">
    function validate()
    {
    	var comment=document.getElementById("comment").value;
    	comment=comment.replace(/\s/g,"");
    	if(comment.length==0||comment.length.equal("0"))
    	{alert("Please Enter Comments For Rejection.");
    		return false;
    	}
    	return true;
    	
    }
    
	function dateValidate(dt,today)
	{//alert("date validate");
		var d=new Date().getMonth();
		//alert(today);
		dy1=dt.substring(7,11);
		dy2=today.substring(0,4);
		//alert(todate);
		dm1=d;
		//alert(dm1);
		dm2=today.substring(5,7);
		//alert(dm2);
		
		dd1=dt.substring(0,2);
		dd2=today.substring(8,10);

		//alert(dy1+"=="+dy2+"=="+dm1+"=="+dm2+"=="+dd1+"=="+dd2);

		if((dm1>dm2) ||  (dy1>dy2) )
		{
			alert("Please Select Valid Date Year");
			return false;
		}
		
		return true;
	}
	
		function addDisallowedAmount(a,Charges,srno)
		{

			//alert(srno);
			//alert(document.getElementById("disallow"+a).value);
			var flag=false;
			var billId=document.getElementById("billId"+a).value;
			var action=document.addDetails.action.value;
			
			var comments=document.getElementById("comments"+a).value;
			//alert(comments);
			var claimrefno=document.getElementById("claimrefno").value;
			//alert(claimId);
			   var allowedAmount=document.getElementById("disallow"+a).value;
			   allowedAmount = allowedAmount.toString();
		       if(isNaN(allowedAmount))
		       {
			     alert("Please Enter Numeric Value For Amount");
			     return false;
		       }
		       if(comments=="")
		       {
		    	     alert("Please Enter Comments");
				     return false;
		       }
			//alert(">>>>>>>>Charges:"+Charges);
			//alert(">>>>>>>>allowedAmount:"+allowedAmount);
			if(Charges!=0 && Charges < allowedAmount)
			{
				alert("Amount entered exceeds your limit of "+Charges);
			}
 			var ajaxRequest;  // The variable that makes Ajax possible!
 			var agree=confirm("Do You Want to Continue?");
 		    if(agree)
 		    {
 		       flag=true;
 		    }
 		    if(flag==true)
 		    {
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
			 }

			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					document.getElementById("companyList").innerHTML=reslt;
				} 
			}
			 
			 var queryString = "?action="+action+"&allowedAmount="+allowedAmount+"&claimrefno=" +claimrefno+"&billId="+billId+"&comments="+comments+"&srno="+srno;
            // alert(queryString)
			 ajaxRequest.open("GET", "AjaxUpdateClaim.jsp" + queryString, true);
			 ajaxRequest.send(null); 
            
			
			document.getElementById("display"+a).innerHTML='<b>'+document.getElementById("disallow"+a).value+'</b> Rs. Sanctioned  : '+document.getElementById("comments"+a).value;
			document.getElementById("popup"+a).style.visibility = "hidden";
}
function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) 
	{
		popup.style.visibility = "visible";
		popup.setfocus();
	} else 
	{
		popup.style.visibility = "hidden";
	}
}

function claimAfterSubmit(action)
{ 
	window.open('claimAfterSubmit.jsp?action='+action,'jav');
}



</script>
	</head>
	<body>


	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		    Connection conn = null;
			Connection connPay = null;
	        Statement st = null, st1 = null, st2 = null,st4=null,st5=null;
			boolean isInvoiceSelected = false;
			int i = 1,k=1;
			String claimrefno="",EmpName="",dueDate="",InwardTime="",InwardNo="",InwardRefNo="",InwardDate="",sqlInsert="";
			String claimSubmittedDate="";
			String comments = "",City="",CityType="",ClaimantName="",department="",grade="";
			String Train="",Bus="",Car="",Taxy="",mode="",JourneyFare="";
			int Local=0,MetroCities=0,NonMetro=0;
			int days=0,Charges=0;
			double amount=0,ClaimAmt=0;
			String SqlCity="",SqlEmpDetails="",SqlConveyance="";
            try 
            {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st5 = conn.createStatement();
				st4 = conn.createStatement();
	%>
    
    
    
    <%
    /*connection for db_leaveapplication database of inwarddetails table
    Class.forName(DB_Driver);
    connPay=DriverManager.getConnection(DB_NAMEPAY,DB_USERNAME,DB_PASSWORD);
    st6=connPay.createStatement();
    System.out.println("@@@@@@@@@@@@@@@@@@@ connection "+connPay);
    */%>
	

	<form name="addDetails" method="post" action="claimAfterSubmit.jsp">
	<% 
	String heading=null;//claimSubmittedDate=rsClaim.getDate("ClaimSubmittedOn");
	String claimIdentity=request.getParameter("claimrefno");
	%>
	<input type="hidden" name="claimIdentity" id="claimIdentity" value="<%=claimIdentity%>" />
		
	<% 
	if(request.getParameter("action").equals("approve"))
	{ heading="Approved By A/C Dep";
	  System.out.println("@@@@@@@@@@@@@@@@"+heading+"@@@@@@@@@@@@@@@@@@");
	}
	else if(request.getParameter("action").equals("sanction"))
	{ heading="Sanction By A/C Dep";
	}
	else
		heading="Authorized by HOD";
	%>
	<div style="font-size: 1.6em; text-align: center; margin-top: 0.3em; margin-bottom: 0.1em;">
	<a>Claim <%=heading%> -Claim Id :  <%=request.getParameter("claimrefno")%> </a></div>
	
 
	<div><input type="hidden" name="action"
		value="<%=request.getParameter("action")%>" /></div><br>
	<table align="center"  border="0" cellpadding="1" cellspacing="1" style="width:800px; background-color: #C6DEFF;font-size:8;font-family: arial;">

		<%
			String sql = "SELECT  distinct ClaimantName,Origin,Destination ,Company, DepartureDateTime,"+
						 "ArrivalDateTime,Purpose,ClaimSubmittedOn,CommentsApprovedBy,CommentsByHOD,"+
						 "CommentsByEmp,DateDIFF( ArrivalDateTime, DepartureDateTime ) +1 AS intrval  FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE CLMRefNumber='"
						+ request.getParameter("claimrefno") + "' and Cancel='1' ";
		
				ResultSet rsClaim = st.executeQuery(sql);
				System.out.println(">>>>>>>>>sql:"+sql);
				if (rsClaim.next()) 
				{
					days=rsClaim.getInt("intrval");
					System.out.println("No. Of Days:"+days);
					ClaimantName=rsClaim.getString("ClaimantName");
					System.out.println("\n>>>ClaimantName:"+ClaimantName);
		%>
		<tr>

			<td >Claimant Name :</td>
			<td ><b><%=rsClaim.getString("ClaimantName")%></b></td>
			<td >Origin :</td>
			<td ><b><%=rsClaim.getString("Origin")%></b></td>
			<td >Destination :</td>
			<td ><b><%=rsClaim.getString("Destination")%></b>
			 <input type="hidden"
				name="claimIdentity" value="<%=request.getParameter("claimrefno")%>" />
			<input type="hidden" name="comments"
				value="<%=request.getParameter("comments")%>" /></td>
		</tr>
		<tr>
			<td >Departure Date :</td>
			<td ><b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getDate("DepartureDateTime").toString()))%></b></td>
			<td >Arrival Date :</td>
			<td ><b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getDate("ArrivalDateTime").toString()))%></b></td>
			<td >Purpose :</td>
			<td ><b><%=rsClaim.getString("Purpose")%></b>
		</tr>
		<tr>
			<td >Submitted On:</b></td>
			<td ><b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getDate("ClaimSubmittedOn").toString()))%></b></td>
			<td >Comments by EMP:</td>
			<td ><b><%=rsClaim.getString("CommentsByEmp") %></b></td>
			<%if(request.getParameter("action").equals("check") || request.getParameter("action").equals("approve")){ %>
			<td >Comments by HOD:</b></td>
			<td ><b><%=rsClaim.getString("CommentsByHOD") %></b></td>
			<%} %>
		</tr>
					<%if(request.getParameter("action").equals("approve")){ %>
			<tr><td valign="top" >Comments By Auditor:</td>
			<td valign="top" style="width: 95px;"><b><%=rsClaim.getString("CommentsApprovedBy") %></b></td>
	
			
		</tr>
			<%} %>
	</table>
	
	<div align="center" style="font-size: 1.5em; margin-top: 0.3em; margin-bottom: 0.1em; height: 2px; background-color: #339CCB">
 </div> 
	<%
		}
	%>
	<br>
	<table id="" class="sortable" align="center" style="width:800px;">
		<tr>
		
			<!--  <th style="width: 140px;"><a href="#" onclick="checkAll()">
			<font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a> <a href="#"
				onclick="unCheckAll()"> <font color="white">UnChk all</font></a> <input
				type="hidden" id="claimId" style="width: 90px;"
				value="<%=request.getParameter("claimrefno")%>" /></th>-->
			<th>Bill ID</th>
			<th>Particulars</th>
			<th>Mode</th>
			<th>Client</th>
			
			<th>Bill Date</th>
			<th>No.Of Days:</th>
			<th>Amount</th>
			<%
				if (request.getParameter("action").equals("approve") || request.getParameter("action").equals("check") ||request.getParameter("action").equals("sanction")) 
				{
			%>
			<th>Denied Amount</th>
			<th>Net Amount</th>
			<%
				}
			%>
			<th>Approved Amount</th>
			<th>Comments By Emp</th>
			<%
				if(request.getParameter("action").equals("check")) {
			%>
			<th>Comments By HOD</th>
			<%
				} else if(request.getParameter("action").equals("approve")||request.getParameter("action").equals("sanction")) {
			%>
			<th>Comments By HOD</th>
			<th>Comments By Auditor</th>
			<th>Uploaded Bill</th>
			
			<%
				}
			%>
		</tr>
		<%
			//String sqlDet="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_det  WHERE ClaimID='"+ClaimID+"'";
		            SqlEmpDetails="select Dept,TALevel from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+ClaimantName+"'";
		            ResultSet rsEmpDetails=st4.executeQuery(SqlEmpDetails);
		            System.out.println("\n>>>>>>>>>>SqlEmpDetails:"+SqlEmpDetails);
		            if(rsEmpDetails.next())
		            {
		            	department=rsEmpDetails.getString("Dept");
		    			grade=rsEmpDetails.getString("TALevel");
		            }
		            SqlConveyance="SELECT MetroCities,NonMetro FROM "+session.getAttribute("CompanyMasterID").toString()+"modeandstaycharges where TALevel='"+grade+"' ";
					ResultSet rsConveyance=st5.executeQuery(SqlConveyance);
					System.out.println("\n>>>>>>>>SqlConveyance:"+SqlConveyance);
					if(rsConveyance.next())
					{
						MetroCities=rsConveyance.getInt("MetroCities");
						NonMetro=rsConveyance.getInt("NonMetro");
					}
		
		          String sqlDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_det  WHERE CLMRefNumber='"+request.getParameter("claimrefno")+ "' and Cancel='1' ";
				  ResultSet rsDet = st.executeQuery(sqlDet);
				  System.out.println(">>>>>>sqlDet:"+sqlDet);
				  while(rsDet.next()) 
				  {
					City=rsDet.getString("City");
					System.out.println(">City:"+City);
					if(rsDet.getString("Particulars").contains("JourneyFare"))
					{
						JourneyFare=rsDet.getString("Particulars");
						System.out.println(">>>>>>>>>>>JourneyFare:"+JourneyFare);
						amount=rsDet.getDouble("Amount");
						SqlCity="Select CityName from "+session.getAttribute("CompanyMasterID").toString()+"metrocities where CityName='"+City+"'";
						System.out.println(">>>>SqlCity:"+SqlCity);
						ResultSet rsCity=st5.executeQuery(SqlCity);
						if(rsCity.next())
						{	
							Charges=days*MetroCities;
						}
						else
						{
							Charges=days*NonMetro;
					  	}
						System.out.println(">>>>>>>>>>Charges:"+Charges);	
					}				
		%>
		
		<tr>
			<!--<td><input type="checkbox" name="chk" /></td>-->
			<td>
			<input
				type="hidden" id="claimrefno" style="width: 90px;"
				value="<%=request.getParameter("claimrefno")%>" />
				
			<div align="right"><%=rsDet.getString("BillID")%></div>
			</td>
			
			<td>
			<div align="left"><%=rsDet.getString("Particulars")%></div>
			</td>
			<td>
			<div align="left"><%=rsDet.getString("ModeOfParticulars")%></div>
			</td>
			<td>
			<div align="left"><%=rsDet.getString("CompanyName")%></div>
			</td>
			<td>
			<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDet .getString("BillDate")))   %></div>
			</td>
			<td>
			<div align="right"><%=days%></div>
			</td>
			<td>
			<div align="right"><%=rsDet.getString("Amount")%></div>
			</td>
			<%
				if (request.getParameter("action").equals("approve")
								|| request.getParameter("action").equals("check") ||request.getParameter("action").equals("sanction")) {
			%>
			<td>
			<div align="right"><%=rsDet.getString("DisallowedAmount")%></div>
			</td>

			<td>
			<div align="right"><%=rsDet.getInt("Amount")-rsDet.getInt("DisallowedAmount")%></div>
			</td>
			<%
				}
			%>
			<td>
			<div align="left"><a
				href="javascript:toggleDetails(<%=i%>,true);"
				title="Click To See the Reports"><font size="2"><b>Enter--></b></font></a></div>
 
			<div class="popup" id="popup<%=i%>">
			<table border="0">
				<tr>
					<td align="left">Enter Amount <br>to be Sanctioned <br>from <b><u><%=rsDet.getInt("Amount")-rsDet.getInt("DisallowedAmount")%></u></b> :</td>
					<td align="left"><input type="text" id="disallow<%=i%>"
						style="width: 90px;" /> <input type="hidden" id="billId<%=i%>"
						style="width: 90px;" value="<%=rsDet.getString("BillID")%>" /></td>
				</tr>
				<tr>
					<td>Enter Comments:</td>
					<td><textarea id="comments<%=i%>" rows="2"	style="width: 150px;"> </textarea></td>
				</tr>
				<tr>
					<td colspan="2"><a href="#"	onclick="addDisallowedAmount(<%=i%>,<%=Charges %>,<%=rsDet.getInt("SrNo") %>);"> Add </a></td>
				</tr>
				<tr>
					<td colspan="2"><a
						href="javascript:toggleDetails(<%=i%>,false);"><b>Close</b> </a></td>
				</tr>
			</table>
			</div>
			</td>


			<td>
			<div align="left"><%=rsDet.getString("CommentsByEmp")%></div>
			</td>

			<%
				if ( request.getParameter("action").equals("check")) {
			%>
			<td>
			<div align="left"><%=rsDet.getString("CommentsByHOD")%></div>
			</td>
			<%
				} else if (request.getParameter("action").equals("approve")||request.getParameter("action").equals("sanction")) {
			%>
			<td>
				<div align="left"><%=rsDet.getString("CommentsByHOD")%></div>
			</td>
			<td>
				<div align="left"><%=rsDet.getString("CommentsAtApproving")%></div>
			</td>
			<td>
				 <% if(rsDet.getString("Uploadbill").equalsIgnoreCase("-"))
      					{			%>
        					 <div align="left"  style="font-size: 1.1em;"><%=rsDet.getString("Uploadbill") %></div>
         			<%}
      	else{%>
      					<a href="DownloadBillImg.jsp?filename=<%=rsDet.getString("UploadBill")%>" target="/" onclick="window.open(this.href,'jav','width=600,height=600,top=150,left=260,location=0, menubar=0, scrollbars=yes, status=0, toolbar=0,resizable=0');return false;">
      				    <font size=2><div align="left"><%=rsDet.getString("UploadBill") %></div></font>
      					</a>
      	<%} %>
			</td>
			<%
			}
			%>
		</tr>
		<%
			i++;
				}
				  %>
	</table>
	
	<%
	
	
	/*	ClaimAm=rsDet.getDouble("Amount");

	claimrefno = request.getParameter("claimrefno");
	System.out.println("@@@@@@@@"+ClaimantName+"  "+claimrefno+  "    Amount "+amount );
	InwardDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	InwardTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	claimSubmittedDate=dueDate=InwardDate; 
	InwardRefNo="IW270920121279";                  //Format  IW200620121279
	//dueDate=request.getAttribute("dueDate").toString();
	System.out.println("@@@@@@@@ "+InwardTime+"       "+InwardDate);
	String sql1="SELECT InwardNo FROM "+session.getAttribute("CompanyMasterID").toString()+"inwarddetails ORDER BY InwardNo DESC LIMIT 1 ";
	System.out.println("@@@@@@@@ sql query @@@@@@@@@"+sql1);
	
   	ResultSet rs=st6.executeQuery(sql1);
   	if(rs.next())
   	{
   	InwardNo=rs.getString("InwardNo");
   	}
	System.out.println("@@@@@@@@ Inward No@@@@@@@@@"+InwardNo);
	InwardNo=rs.getString("InwardNo");
	System.out.println("###########"+request.getParameter("Submit"));
*/	%>
	
	
<%
		Date today = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DAY_OF_MONTH, +15);
		Date today15 = cal.getTime();
		String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today15);
		String a=request.getParameter("action");
		
	%>
	
<%
			//====Get Syst Crnt Time==================================
					Date d=new Date();
					
				Format df1= new SimpleDateFormat("yyyy-MM-dd");
				String dtoday=df1.format(d);
				
				DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
				DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
				
				Format d2= new SimpleDateFormat("HH:mm:ss");
				String incdReg=d2.format(d);
				String hrTime=incdReg.substring(0,2);
				String minTime=incdReg.substring(3,5);
				System.out.println(">>>>>>>>>>>>dtoday:"+dtoday);
				//========================================================
%>
	
	<div align="center">
	 <table border="0" style="width:500px; height:90px">
		 <tr >
	 		<td align="center">Comments :</b>
	 		<input type="text" class="input" name="comment" id="comment" style='width: 200px; height: 15px;'/></td>
	 	 
      	 <%if(request.getParameter("action").equals("approve"))
      	 { %>
      	 
	 		<br><td >Due Date:</b></td>
	 		<td><input type="text" id="dueDate" name="dueDate" onchange="dateValidate(this.value,'<%=dtoday %>');" value="<%=fromDateCal %>" size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 		<script type="text/javascript">
	 		try
	 		{
             Calendar.setup(
               {
				inputField  : "dueDate",         // ID of the input field
				ifFormat    : "%d-%b-%Y",     // the date format
				button      : "dueDate"       // ID of the button
				}
			);
	 		}
	 		catch(e)
	 		{
		 		alert(e);
	 		}
			</script>	 		
	 		</td>

	 	 <%} %>
      	  </tr><tr>  <td colspan="4" align="center">
      	  				<input type="submit" name="Submit" value="Approve" style="border: outset;"/> 
		    &nbsp;&nbsp;<input type="submit" name="Reject" value="Reject" onclick="return validate();" style="border: outset;"/> 
		    </td>
<!-- 		    <input type="hidden" name="Submit" value="Submit"/> -->
		 </tr>
	</table>
    </div>
<%
	
	
} 
catch (Exception e) 
{
	System.out.println(e);
	out.print("!!!Connection Lost!!!*");
}
finally
{
	conn.close();
}
%>	
	</form>
<!-- 	<br> -->
<!-- 	<br> -->
<!-- 	<br><br><br><br><br> -->
<!-- 	<br><br><br><br><br> -->
<!--     <br><br><br><br><br>  -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp" %>

