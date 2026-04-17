<DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

 
<script language="JavaScript1.2">

	
   function validation() 
   {

	var amount=document.repeatentry.billamount.value;
	var category=document.repeatentry.category.value;
	var subject=document.repeatentry.subject.value;
	var from=document.repeatentry.from.value;
	var billno=document.repeatentry.billno.value;
	var address=document.repeatentry.address.value;
	var billdate=document.repeatentry.date.value;
	var billduedate=document.repeatentry.date1.value;
	var accountno=document.repeatentry.accno.value;
		if(amount=="")
		{
		alert("Please Enter Bill Amount ");
		return false;
		}
		if(isNaN(amount))
	       {
		     alert("Please Enter Numeric Value for Bill Amount");
		     return false;
	       }

		if(category=="")
		{
		alert("Please Enter Category");
		return false;
		}
		if(subject=="")
		{
		alert("Please Enter Subject");
		return false;
		}


		if(billno=="")
		{
		alert("Please Enter Bill No");
		return false;
		}

		if(address=="")
		{
		alert("Please Enter Address");
		return false;
		}

		if(from=="")
		{
		alert("Please Enter From Field");
		return false;
		}

		if(accountno=="")
		{
		alert("Please Enter Account No ");
		return false;
		}
		
		var agree=confirm("New Repeated  Entery With Following Details \n Amount:"+amount+"\n Account No:"+accountno+"  \n  Category:"+category+" \n Subject: "+subject+" \n From:"+from+" \n Bill No: "+billno+" \n Bill Date:"+billdate+" \n Bill Due Date:"+billduedate+" Are you want to continue");
		if (agree)
			return true ;
		else
			return false ;
		
		
		
		
		return true;
		
}

</script>


<%
     erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	 
	 Connection conn = null;
     Statement st = null,st1=null,st2=null;
     String SqlTrType="",sql="";
     String name="",category="";
     String date="";
     int limit=0;
%>

<%
try {
conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();

String no=request.getParameter("id");
date=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

String sql1="select *  from "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment where SrNo='"+no+"'";
ResultSet rssql1=st1.executeQuery(sql1);
System.out.println(sql1);
if(rssql1.next())
{
%>
<body>
<form name="repeatentry" id="" method="post" action="insertRepeatedEntry.jsp?var=new" onsubmit="return validation();">
<div>
<div style="font-size: 1.8em; text-align: center; margin-top: 0.0em; margin-bottom: 0.2em;">

				  <a>Repeated Entry</a></div> 
</div>  

 <table  border="0" height="52%" width="100%" >

	    <tr>
	    	<td> 
	    		  <table  align="center" valign="top" height="90%" width="70%" style=" border: 3px solid #C6DEFF; ">
	    	      <!--  <div id="entryform" align="center" style="width:70%;height:55%; border:thin solid; border-color: blue; position:absolute; border-radius: 12px 12px 12px 12px;">
	              -->
	    	       <tr>
	    	        
	    	             <td>&nbsp;&nbsp;&nbsp;Category</td>
	    	        <td>
	    	       	<input type="text" name="category" id="category" size="15" value="<%=rssql1.getString("Category") %>" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; "/ >
     				</td>
	    	        
						<td width="21%"> &nbsp;&nbsp;&nbsp;Bill Date</td>
						<td><input type="text" id="date" size="15" name="date" value="<%=date%>"  size="15" 
							style="width: 100px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:#C0C0C0" />
							
							<script type="text/javascript">
							Calendar.setup(
							{
							inputField  : "date",         // ID of the input field
							ifFormat    : "%d-%b-%Y",    // the date format
							button      : "date"       // ID of the button
							}
							);
							</script>
							</td>
						
	    	        </tr>
	    	        
	    	        <tr>
	    	        <td>&nbsp;&nbsp;&nbsp;From</td>
	    	        <td>
	    	       	<input type="text" name="from" id="from"   value="<%=rssql1.getString("FromDetails") %>" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; "/ >
					</td>
	    	 			<td width="21%"> &nbsp;&nbsp;&nbsp;Bill Due Date</td>
						<td><input type="text" id="date1" size="15" name="date1" value="<%=date%>"  size="15" 
							style="width: 100px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:#C0C0C0" />
							
							<script type="text/javascript">
							Calendar.setup(
							{
							inputField  : "date1",         // ID of the input field
							ifFormat    : "%d-%b-%Y",    // the date format
							button      : "date1"       // ID of the button
							}
							);
							</script>
							</td>
	    	        </tr>
	    	        
	    	         <tr>
	    	        <td>&nbsp;&nbsp;&nbsp;Address</td>
	    	        <td>
	    	        <input type="text" name="address" id="address"  size="15"  value="<%=rssql1.getString("Address") %>" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
					</td>
	    	        <td>&nbsp;&nbsp;&nbsp;Subject</td>
	    	        <td><input type="text" id="subject" name="subject"  size="15"   value="<%=rssql1.getString("Subject") %>" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; background: #FFFFFF;border-color: activeborder; " >
	    	        </td>
	    	        </tr>
	    	        
	    	        <tr>
	    	        <td>&nbsp;&nbsp;&nbsp;Bill No</td>
	    	        <td><input type="text" id="billno" name="billno" size="15"   value="<%=rssql1.getString("BillNo") %>"
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background: # #000000" />
					</td>
	    	        <td>&nbsp;&nbsp;&nbsp;Bill Amount</td>
	    	        <td><input type="text" id="billamount" name="billamount" size="15"  value="<%=rssql1.getString("BillAmount") %>" onclick="fillpayamount();"
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:# #000000" />
					</td>
	    	        </tr>
	    	        
   					<tr>
	    	        <td>&nbsp;&nbsp;&nbsp;Account No</td>
	    	        <td><input type="text" id="accno" name="accno" size="15"   value="<%=rssql1.getString("AccountNo") %>"
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background: # #000000" />
					</td>
	    
	    	        </tr>
	    	      </table>
	    	     
	    	 <input type="hidden" name="srno" id="srno" value="<%=no %>"/>
	    	</td>
	    </tr>
	  				<tr>
	<td align="center">
	<input type="submit" value="Submit">
	</td>
	</tr>
	</table>
	</form>
	


<%	
}

else 
{
	
}
 }
catch(Exception e)
{System.out.println(" connection error "+e); 
}
%>	
	<div id="footer">
	<p><a href="http://www.192.168.2.133"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
<!-- end #footer -->
	

</body>
</jsp:useBean>