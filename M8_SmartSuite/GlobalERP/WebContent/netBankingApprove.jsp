<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.netbank_approve.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["netbank_approve"].submit();       // CHANGE FORM NAME HERE

} 

function CancelRow(id,coments)
{
	    
	//alert("Control inside deldte function"+id);
	//alert("Control inside commmmments function"+coments);
	
	var agree=confirm("Do You Want to Cancel this Transaction?");
	    //alert(agree);
	    if(agree)
	    {
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {	// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	// Internet Explorer Browsers
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{	// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{	//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4 )
				{	var reslt=ajaxRequest.responseText;
			//	alert(">>>    "+reslt);
				  var data=reslt;
				  data=data.replace(/^\s+|\s+$/g,"");
				//  alert("datttt"+data);
				  var z=data.split("#");
				 


					if(data=="Yes")
					{					
                        alert("Transaction Canceled  Successfully.");
				    	window.location.reload();
					}
					if(data=="No")
					{					
                       alert("Error in Cancelation .");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=cancel&id="+id+"&coments="+coments;
			ajaxRequest.open("GET", "AjaxCancelTransaction.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	




function DeleteRow(id,coments)
{
	    
	//alert("Control inside deldte function"+id);
	//alert("Control inside commmmments function"+coments);
	
	var agree=confirm("Do You Want To Approve This Transaction?");
	    //alert(agree);
	    if(agree)
	    {
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {	// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	// Internet Explorer Browsers
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{	// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{	//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4 )
				{	var reslt=ajaxRequest.responseText;
			//	alert(">>>    "+reslt);
				  var data=reslt;
				  data=data.replace(/^\s+|\s+$/g,"");
				//  alert("datttt"+data);
				  var z=data.split("#");
				 


					if(data=="Yes")
					{					
                        alert("Transaction Approved  Successfully.");
				    	window.location.reload();
					}
					if(data=="No")
					{					
                       alert("Error In Deactivating .");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=approve&id="+id+"&coments="+coments;
			ajaxRequest.open("GET", "AjaxApproveTransaction.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	




function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
			//alert("flag"+flag);
		}
	k++;	
	}

/*	for(cnt2=0;cnt2<chklength.length;cnt2++)
	{
		alert("2nd for loop");
		//flag="t";
		//flag1="t";
		if( document.getElementById("chk"+l).checked == true )
		{
			//flag="success";
			alert("flagqqqqq"+flag);
			//flag1="t";
			if(document.getElementById("approvalcomment"+l).value != "" )
			{
					flag1="success";
					alert("flag1"+flag1);
					//break;
			}
			l++;	
		}
				
		//k++;	
	}
*/
	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		var id="";
		var approvalComment="";
		//alert("hiiiii1");
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for"+chklength.length);
			
			if(document.getElementById("chk"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
				approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
		//alert("check"+approvalComment);
		DeleteRow(id,approvalComment);
	}
	else
	{
		alert("Please Select Transaction For Approval");
	}
	
}


function getcheckedrow1()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
			//alert("flag"+flag);
		}
	k++;	
	}

/*	for(cnt2=0;cnt2<chklength.length;cnt2++)
	{
		alert("2nd for loop");
		//flag="t";
		//flag1="t";
		if( document.getElementById("chk"+l).checked == true )
		{
			//flag="success";
			alert("flagqqqqq"+flag);
			//flag1="t";
			if(document.getElementById("approvalcomment"+l).value != "" )
			{
					flag1="success";
					alert("flag1"+flag1);
					//break;
			}
			l++;	
		}
				
		//k++;	
	}
*/
	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		var id="";
		var approvalComment="";
		//alert("hiiiii1");
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for"+chklength.length);
			
			if(document.getElementById("chk"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
				approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
		//alert("check"+approvalComment);
		CancelRow(id,approvalComment);
	}
	else
	{
		alert("Please Select Transaction For Cancelation");
	}
	
}
</script>


                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;

	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="", accountstate ="-",fileStatus="";
%>


<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		//fromDateCal=request.getParameter("fromdate");
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate));
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		//toDateCal=request.getParameter("todate");
		toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate));;
	}else
	{
		fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate));
		toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate));;
		//fromDateCal=fromDate;
		//toDateCal=toDate;
			//new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	}
	
	if((null == request.getParameter("accountstate"))){
		accountstate="-";
	
	}
	if((null == request.getParameter("fileStatus")))
	{
		fileStatus="All1";
	
	}
	else
	{
		fileStatus=request.getParameter("fileStatus");
	}
	System.out.println("**********fileStatus*********"+fileStatus);
	
 		
try 
{
	System.out.println("from_date==>"+fromDateCal+"to_date"+toDateCal);
	System.out.println("**********fileStatus*********111"+fileStatus);
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	ResultSet rsdata=null;
	String sql1="",sql2="",sql3="",filename="",accountType="",status="",updated="",color="",status2="",status1="",creationDate="";
	int Amount=0;
	int i=1;
	
%>




	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Net Banking File For Approval</a></div>

<form>

<table width="45%" border="0" align="center">
		<tr align="center">


			<td align="right"><b>Status</b>
			<select name="fileStatus" value="<%=fileStatus%>">
				<%
																						if (fileStatus != null) {

																							if (fileStatus.equalsIgnoreCase("All1"))

																							{
																					%>	
								<option value="All1" selected="selected" >All</option>	
								<option value="Pending1">Pending</option>
								<option value="Approved1">Approved</option>
								<option value="created1">created</option>
								<option value="Canceled1">Canceled</option>				
																					<%
																	} else if (fileStatus.equalsIgnoreCase("Approved1")) {
																%>
								<option value="All1" >All</option>	
								<option value="Pending1">Pending</option>
								<option value="Approved1" selected="selected">Approved</option>
								<option value="created1">created</option>
								<option value="Canceled1">Canceled</option>				
																					<%
																	} else if (fileStatus.equalsIgnoreCase("created1")) {
																%>
								<option value="All1" >All</option>	
								<option value="Pending1">Pending</option>
								<option value="Approved1">Approved</option>
								<option value="created1" selected="selected">created</option>
								<option value="Canceled1">Canceled</option>				
																					<%
																	} else if (fileStatus.equalsIgnoreCase("Canceled1")) {
																%>
																
								<option value="All1" >All</option>	
								<option value="Pending1">Pending</option>
								<option value="Approved1">Approved</option>
								<option value="created1">created</option>
								<option value="Canceled1" selected="selected">Canceled</option>
								<%
																	} else if (fileStatus.equalsIgnoreCase("Pending1")) {
																%>
																
								<option value="All1" >All</option>	
								<option value="Pending1" selected="selected">Pending</option>
								<option value="Approved1">Approved</option>
								<option value="created1">created</option>
								<option value="Canceled1">Canceled</option>
								
								
								
								<%
																	} else  {
																%>
																
								<option value="All1" >All</option>	
								<option value="Pending1">Pending</option>
								<option value="Approved1">Approved</option>
								<option value="created1">created</option>
								<option value="Canceled1">Canceled</option>
								<%}} %>
							</select>
			</td>

			<td align="left">
			 &nbsp;<b>From</b>
			<input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script>
 </td><td align="left"  style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left"  style="width: 80px;">
			 <input type="text" id="todate"
						name="todate" value="<%=toDateCal %>" size="15" readonly
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
			 </td><td align="left" valign="top">&nbsp;&nbsp;
			 <input type="hidden" name="accountstate" id="accountstate" value=<%=accountstate %>  />
				 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
				
					

		</tr>
		
	</table>
</form>
	<div></div>
<%
//if(null!=request.getQueryString())
//{
%>	
<form name="netbank_approve" method="post" autocomplete="off" >
<%
String exportFileName="NetBank_Approve.xls";   // GIVE YOUR REPORT NAME
%>
<table style="width:100%">
<tr><td><a href="Accounts.jsp">BACK</a></td></tr>
<tr><td><input type="button" name="Approve"  value="Approve" onclick="getcheckedrow()" /> <input type="button" name="Cancel"  value="Cancel" onclick="getcheckedrow1()" /></td> <td></td><td><td></td>
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</td></tr>
</table>
<table width=55% align="center" border="1" style="border-color: #C6DEFF;" cellpadding="0" cellspacing="0">
                        <tr>
                       <td> <b><font size="2" color="black">Color Code Indication:</font></b></td>
                       <td><font size="2" ><a href="netbankapproveLink.jsp?st=all" style="color:blue">ALL  </a></font></td>
                        <td bgcolor="#FAAFBE"><font size="2" color="black"><a href="netbankapproveLink.jsp?st=pending1" style="color:blue">Pending For Approval</a> </font></td>
                        <td bgcolor="#AEF8B1"><font size="2" color="black"><a href="netbankapproveLink.jsp?st=approved1" style="color:blue">Approved</a></font></td>
                        <td bgcolor="#FFFF00"><font size="2" color="black"><a href="netbankapproveLink.jsp?st=canceled1" style="color:blue">Cancelled</a> </font></td>
                        <td bgcolor="#99CCFF"><font size="2" color="black"><a href="netbankapproveLink.jsp?st=created1" style="color:blue">Created</a></font></td>
                       
                        <%
                      	
                        try
                        {
                        	if(null!=request.getQueryString())
                        		{
                        accountstate = request.getParameter("accountstate");
                        		}
                        System.out.println("status of activation*****"+accountstate);
                        }catch(Exception e)
                        {
                        System.out.println(" accnt states"+e.toString());	
                        }
                      %>
            
                        </tr>
                </table>

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div id='purchase'>

	<table  width="100%" border="1" class='sortable' >
	
	
	<tr>
	<th>Sr.No.</th>
	<th>ID</th>
	<th>Select For Approval</th>
	<th> Name</th>
	<th>Account Number</th>
	<th>Amount(In Rs.)</th>
	<th>Created By</th>
	<th>Date</th>
	<th>Status</th>
	<th>Record Type</th>
		<th>Payment Mode</th>
	
	<th>Comments</th>
	<th>Add Comments</th>
	</tr>
<%   
//if(null!=request.getQueryString())
//{
try
{
	if(accountstate.equalsIgnoreCase("-"))
	{
		if(fileStatus.equalsIgnoreCase("All1")  )
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		}else if(fileStatus.equalsIgnoreCase("Pending1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Pending for Approval' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		}else if(fileStatus.equalsIgnoreCase("Approved1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Approved' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
			
		}else if(fileStatus.equalsIgnoreCase("created1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Created' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		}else if(fileStatus.equalsIgnoreCase("Canceled1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Cancelled' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		}
		
	}else
	{
		 if(accountstate.equalsIgnoreCase("pending1"))
		{
			
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Pending for Approval'";
		}
		else if(accountstate.equalsIgnoreCase("approved1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Approved' ";
		}
		else if(accountstate.equalsIgnoreCase("canceled1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Cancelled' ";
		}else if(accountstate.equalsIgnoreCase("created1"))
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Created' ";
		}
		else
		{
			sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords";
			// where  CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
		}
		
	}// end of else
		
	
	


	
	
	
	
	
	
	
	
	
}
catch(Exception e)
{
	System.out.println("Inside Exception===>"+e.toString());
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  RecordStatus='Pending for Approval' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'" ;
}
int j=0;
System.out.println("query for execution==###=>"+sql1);
rsdata=st.executeQuery(sql1);
while(rsdata.next())
{
	j++;
	/*filename=rsdata.getString("FileName1") ;
	sql2="Select sum(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where FileName1='"+filename+"'";
	ResultSet rs2=st1.executeQuery(sql2);
	System.out.println(sql2);
	if(rs2.next())
	{
		Amount=rs2.getInt(1);
		
	}
	else 
	{
		Amount=0;
	}
	*/
	
	
	try
	{
	creationDate=rsdata.getString("CreationDate");
	System.out.println("creationDate======>1111"+creationDate);
	if(creationDate!=null)
	{
		creationDate=new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat(
		"yyyy-MM-dd")
		.parse(creationDate));
		System.out.println("creationDate======>"+creationDate);
	}
	else
	{
		creationDate="000";
	}
	}catch(Exception e)
	{
		creationDate="000";
		System.out.println("date==22=>"+e.toString());
	}
	status=rsdata.getString("RecordStatus");
	
	if(status.equalsIgnoreCase("approved"))
	{
	      color="#AEF8B1";
	}else if(status.equalsIgnoreCase("Cancelled") || status.equalsIgnoreCase("Canceled") )
	{
		color="#FFFF00";
	}
	else if(status.equalsIgnoreCase("Created"))
	{
		color="#99CCFF";
	}
	else 
	{
		color="#FAAFBE";
	}
	System.out.println(color);
%>

<tr>
<td  style="background-color:<%=color %>"><div align="right"><%=i++ %></div> </td>
<td  style="background-color:<%=color %>" width="2%" align="right" id="net_id<%=j %>"><div align="right" id="net_id1<%=j %>"><%=rsdata.getString("id")%></div></td>
<%status1=rsdata.getString("RecordStatus");
	
	if(status1.equalsIgnoreCase("approved") || status1.equalsIgnoreCase("Cancelled") || status1.equalsIgnoreCase("Canceled") || status.equalsIgnoreCase("Created") )
	{
		%>
		<td  style="background-color:<%=color %>" width="1%" align="right"><div  style="visibility:hidden"><input type="checkbox" name="chkbx" disabled="disabled" id="chk<%=j%>" /></div></td>
		<%
	}else 
	{
		%>
		<td  style="background-color:<%=color %>" width="1%" align="right"><div><input type="checkbox" name="chkbx" enabled="enabled" id="chk<%=j%>" /></div></td>
		<%
	}
	
	%>

<td style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("BeneficiaryName") %></div> </td>
<td style="background-color:<%=color %>"><div align="right"><%=rsdata.getString("BeneficiaryAccountNumber") %> </div></td>
<td style="background-color:<%=color %>"><div align="right"><%=rsdata.getString("Amount") %></div> </td>
<td style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("Createdby") %></div> </td>
<td style="background-color:<%=color %>"><div align="right"><%=creationDate %></div> </td>
<td style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("RecordStatus") %></div> </td>
<td style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("RecordType") %></div> </td>
<td style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("PaymentMode") %></div> </td>

 <% 
 String comments=rsdata.getString("ApprovalComments");
 String commentsval="-";
 if(comments.equalsIgnoreCase("-"))
 {
	 commentsval="-";
 }
 else
 {
	 commentsval=comments;
 }
 
 %>
<td style="background-color:<%=color %>"><div align="left"><%=commentsval%></div> </td>
<%status2=rsdata.getString("RecordStatus");
	
	if(status2.equalsIgnoreCase("approved") || status2.equalsIgnoreCase("Cancelled") || status2.equalsIgnoreCase("Canceled") || status2.equalsIgnoreCase("Created") )
	{
		%>
		<td style="background-color:<%=color %>"><div align="left" style="visibility:hidden"><input type="text" name="approvalcomment" id="approvalcomment<%=j%>" value="-" readonly="readonly"></input></div> </td>
		<%
	}else 
	{
		%>
		<td style="background-color:<%=color %>"><div align="left"><input type="text" name="approvalcomment" id="approvalcomment<%=j%>" value="-"></input></div> </td>
		<%
	}
	
	%>


</tr>

<%

}   // end of while  

if(i==1){
	%>
<tr><td colspan="12">
NO DATA AVAILABLE
</td></tr>	
<%}
%>


</table>
</div>
</form>

<%	
//}
//}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>  		

	</form>
	
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <br><br><br><br><br><br><br><br><br>
	<div id="footer">
	<%@ include file="footer_new.jsp" %>
	</div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>