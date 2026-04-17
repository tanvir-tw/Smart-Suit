<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
	<head>
	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.CreateFile.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["CreateFile"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteRow(id)
{
	    var Flgfnewfile;
	//alert("Control inside deldte function"+id);
	
	var agree=confirm("Do You Want to Create File for this Transaction?");
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
				//alert(">>>    "+reslt);
				  var data=reslt;
				  data=data.replace(/^\s+|\s+$/g,"");
				//  alert("datttt"+data);
				 /////////////////////
				 
				
				//alert("2 nnd time"+id);
				
					if(data=="Yes")
					{					
                        alert("File created  Successfully.");
                        window.location.reload();
				    	//window.location=download.jsp?f=data;
					}
					if(data=="No")
					{					
                       alert("Error in File Creation .");
				    	window.location.reload();
					}
				
	           } 
			}
			var queryString = "?Flgfnewfile="+Flgfnewfile+"&id="+id;
			ajaxRequest.open("GET", "AjaxCreateFile.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	

	    function abc1()
		{
				var agree=confirm("Are you want to transaction continue");
				if(agree)
				{ 
				return true;
				}
				else
				{ 
			 		window.open('Accounts.jsp','_self');
				}
		
		}


function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,k=1,m=1,flag="t",flagType="t";
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
/*
	for(cnt2=0;cnt2<chklength.length;cnt2++)
	{
		if( document.getElementById("chk"+m).checked == true )
		{
			var rectp=document.getElementById("recType"+m).innerHTML;
			flag="success";
		}
	k++;	
	}
	*/
	
	
	//alert("hiiiiiflg"+flag);
	if(flag == "success")
	{
		var i=1,j,cnt=0;
		var id="";
		//var approvalComment="";
		//alert("hiiiii1");
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for"+chklength.length);
			
			if(document.getElementById("chk"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
				//approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
		//alert("check"+approvalComment);
		DeleteRow(id);
	}
	else
	{
		alert("Please Select Transaction for File Creation");
	}
	
}//

function validation() 
{
	//alert("hi");
	//var name=document.form.tranType.value;
	var e = document.getElementById("tranType");
    var name = e.options[e.selectedIndex].value;
	//alert("hi"+name);
	    if(name=="Select")
		{
		alert("Please Select Transaction Type");
		return false;
		}
		
		
		
		
		
		return true;
		
}
</script>


  </head>   
  <body>                            	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;

	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="",transType="";
%>


<%
String ipp="";
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
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (!(null == request.getParameter("tranType"))){
		//toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		transType=request.getParameter("tranType");
	}
 		
try 
{
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	ResultSet rsdata=null;
	String sql1="",sql2="",sql3="",filename="",accountType="",status="",updated="",color="",approvedat="",status1="";
	int Amount=0;
	int i=1;
	
	 
	
%>




	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Net Banking File For Creation</a></div>

<form name="netbankApprove">

<table width="75%" border="0" align="center">
		<tr align="center" style="width:auto;">

			<td align="left"  style="width: 100px;">
			&nbsp;<b>Transaction Type </b> </td><td align="left"  style="width: 100px;">
			  <select name="tranType" id="tranType" value="<%=transType %>">
			  <option value="Select">Select</option>
					
						<% 
	    	        	  String SqlTrType="Select Accno,Description from "+session.getAttribute("CompanyMasterID").toString()+"netbankingaccmaster order by Description";
						 // System.out.println(SqlTrType);
	    	        	  ResultSet rs=st.executeQuery(SqlTrType);
	    	        	  String trType="";
	    	        	  while(rs.next())
	    	        	  {
	    	        		  
	    	        		  rs.getString("Accno");
	    	        		  rs.getString("Description");
	    	        		  trType=rs.getString("Accno")+"-"+rs.getString("Description");
	    	        		  if(transType!=null)
	    					  {
	    					  if(transType.equalsIgnoreCase(trType))
	    					  {
	    						  %>
	    						   <option selected="selected"><%=trType%></option>
	    						  <%
	    					  }
	    					  else
	    					  {
	    						  %>
	    							
	    						<option value="<%=rs.getString("Accno")%>-<%=rs.getString("Description")%>"><%=rs.getString("Accno")%>-<%=rs.getString("Description")%></option>
	    									
	    								<%} 
	    					 
	    					  }
	    	        		  else
	    					  {
	    	        		  
	    	        		 // System.out.println(" Accno "+rs.getString("Accno")+ " Description "+rs.getString("Description"));
	    	        	  %>
					
						 <option value="<%=rs.getString("Accno")%>-<%=rs.getString("Description")%>"><%=rs.getString("Accno")%>-<%=rs.getString("Description")%></option>
						 <%} }%>
						 </select>
					
			
			 </td>

			<td align="left" style="width: 20px;">
			 <b>From</b></td><td align="left"  style="width: 80px;">
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
			 </td>
			 
			 <td align="left" valign="top">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO" onclick="return validation();"></input></td>
				
					

		</tr>
		
		
	</table>
	
</form>
	<div></div>
<%
//if(null!=request.getQueryString())
//{
%>	
<form name="CreateFile" method="post" >
<%
String exportFileName="NetBank_Creation.xls";   // GIVE YOUR REPORT NAME
%>

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div id='purchase'>
<table style="width:100%">
<tr><td><a href="Accounts.jsp">BACK</a></td></tr>
<tr><td><a href="s">download Current created  file</a></td></tr>
<!--<tr><td><a href="download.jsp">download</a></td></tr>-->

<tr><td><input type="button" name="CreateFIle"  value="Create FIle" onclick="getcheckedrow()" /></td><td></td><td>
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</td></tr>
	<tr><td></td><td><table width=100% align="center" border="1" style="border-color: #C6DEFF;" cellpadding="0" cellspacing="0">
                        <tr>
                       <td> <b><font size="2" color="black">Color Code Indication:</font></b></td>
                       
                        <td bgcolor="#FAAFBE"><font size="2" color="black">Pending For Approval </font></td>
                        <td bgcolor="#AEF8B1"><font size="2" color="black">Approved</font></td>
                        <td bgcolor="#FFFF00"><font size="2" color="black">Cancelled </font></td>
                        <td bgcolor="#99CCFF"><font size="2" color="black">Created</font></td>
                       
                       
            
                        </tr>
                </table></td></tr>
</table>
	<table  width="100%" class='sortable' >
	
	
	<tr>
	<th>Sr.No.</th>
	<th>ID</th>
	<th>Select For file Creation</th>
	<th> Name</th>
	<th>Account Number</th>
	<th>IFscc Code</th>
	<th>Amount(In Rs.)</th>
	<th>Approved By</th>
	<th>Approved Date</th>
	<th>Status</th>
	<th>Transaction Type</th>
	<th>Tally Ref No</th>
	</tr>
<%   
//if(null!=request.getQueryString())
//{
try
{
	//sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordStatus='Approved' and  CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  RecordType='"+transType+"' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'" ;
	
}
catch(Exception e)
{
	//sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  RecordStatus='Approved' and CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'" ;
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where RecordType='"+transType+"'  CreationDate  between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'" ;
}
int j=0;
System.out.println(sql1);
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
	approvedat=rsdata.getString("ApprovedDateTime");
	if(approvedat!=null)
	{
		approvedat=new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat(
		"yyyy-MM-dd")
		.parse(approvedat));
	}
	else
	{
		approvedat="000";
	}
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	System.out.println(""+approvedat);
	
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
	
	if(status1.equalsIgnoreCase("Pending for Approval") || status1.equalsIgnoreCase("Cancelled") || status1.equalsIgnoreCase("Canceled") || status.equalsIgnoreCase("Created") )
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



<td  style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("BeneficiaryName") %></div> </td>
<td  style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("BeneficiaryAccountNumber") %> </div></td>
<td  style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("IFCCode") %> </div></td>
<td  style="background-color:<%=color %>"><div align="right"><%=rsdata.getString("Amount") %></div> </td>
<td  style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("ApprovedBy") %></div> </td>
<td  style="background-color:<%=color %>"><div align="right"><%=approvedat %></div> </td>
<td  style="background-color:<%=color %>"><div align="left"><%=rsdata.getString("RecordStatus") %></div> </td>
<td  style="background-color:<%=color %>"><div align="left" id="recType<%=j %>"><%=rsdata.getString("RecordType") %></div> </td>
<td  style="background-color:<%=color %>"><div align="right"><%=rsdata.getString("TallyRefNo") %></div> </td>
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

	
	
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <br><br><br><br><br><br><br><br><br>
	<div id="footer">
	<%@ include file="footer_new.jsp" %>
	</div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>