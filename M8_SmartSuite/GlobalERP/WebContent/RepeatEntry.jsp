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
	 var invalid=/[^A-Za-z\s]/;
	var othC=category.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var othfrm=from.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othadd=address.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othbilno=billno.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othaccno=accountno.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othsub=subject.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var othamt=amount.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var billdate=document.repeatentry.date.value;
	var duedate=document.repeatentry.date1.value;
	var d1,m1,y1,d2,m2,y2,mm1,mm2;


	
d1=billdate.substring(0,2);
	
m1=billdate.substring(3,6);

y1=billdate.substring(7,11);

d2=duedate.substring(0,2);

m2=duedate.substring(3,6);

y2=duedate.substring(7,11);


mm1=dateformat(m1);
mm2=dateformat(m2);
	

		if(category=="" || othC==""){
			alert("Please Enter Category");
    		return false;
    	}
    	
		if(invalid.test(category)){
   	     alert('Please enter characters value for Category..');  
   	     return false;
   	 }
	
		if(from=="" || othfrm=="")
		{
		alert("Please Enter From Field");
		return false;
		}
		
		if(invalid.test(from)){
	   	     alert('Please enter characters value for From..');  
	   	     return false;
	   	 }


		if(y2<y1)
		{
			alert("Bill Due date cannot be less than Bill Date (year)");
			return false;
		}
		
		if(y2==y1)
		{
			  if(mm2<mm1)
			  {
				alert("Bill Due date cannot be less than Bill Date (month)");
				return false;
	                  }
		}

		if(y2==y1 && mm2==mm1)
		{
			if(d2<d1)
			{
				alert("Bill Due date cannot be less than Bill Date (Day)");
				return false;
			}
		}


		
		if(address=="" || othadd=="")
		{
		alert("Please Enter Address");
		return false;
		}

		if(billno=="" || othbilno=="")
		{
		alert("Please Enter Bill No");
		return false;
		}


		if(accountno=="" || othaccno=="")
		{
		alert("Please Enter Account No ");
		return false;
		}
		if(subject=="" || othsub=="")
		{
		alert("Please Enter Subject");
		return false;
		}


		if(invalid.test(subject)){
	   	     alert('Please enter characters value for Subject..');  
	   	     return false;
	   	 }
		if(amount=="" || othamt=="")
		{
		alert("Please Enter Bill Amount ");
		return false;
		}
		if(isNaN(amount))
	       {
		     alert("Please Enter Numeric Value for Bill Amount");
		     return false;
	       }
	       	
		

		var agree=confirm("New Repeated  Entery With Following Details \n Amount:"+amount+"\n Account No:"+accountno+"  \n  Category:"+category+" \n Subject: "+subject+" \n From:"+from+" \n Bill No: "+billno+" \n Bill Date:"+billdate+" \n Bill Due Date:"+billduedate+" Are you want to continue");
		if (agree)
			return true ;
		else
			return false ;
		
		
		
		
		return true;
		
}



function go()
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
	var invalid=/[^A-Za-z\s]/;
	var othC=category.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var othfrm=from.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othadd=address.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othbilno=billno.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othaccno=accountno.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var othsub=subject.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var othamt=amount.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var billdate=document.repeatentry.date.value;
	var duedate=document.repeatentry.date1.value;
	var d1,m1,y1,d2,m2,y2,mm1,mm2;


	
d1=billdate.substring(0,2);
	
m1=billdate.substring(3,6);

y1=billdate.substring(7,11);

d2=duedate.substring(0,2);

m2=duedate.substring(3,6);

y2=duedate.substring(7,11);


mm1=dateformat(m1);
mm2=dateformat(m2);




		if(category=="" || othC==""){
			alert("Please Enter Category");
    		return false;
    	}
    	
		if(invalid.test(category)){
   	     alert('Please enter characters value for Category..');  
   	     return false;
   	 }
	
		if(from=="" || othfrm=="")
		{
		alert("Please Enter From Field");
		return false;
		}
		


		if(y2<y1)
		{
			alert("Bill Due date cannot be less than Bill Date (year)");
			return false;
		}
		
		if(y2==y1)
		{
			  if(mm2<mm1)
			  {
				alert("Bill Due date cannot be less than Bill Date (month)");
				return false;
	                  }
		}

		if(y2==y1 && mm2==mm1)
		{
			if(d2<d1)
			{
				alert("Bill Due date cannot be less than Bill Date (Day)");
				return false;
			}
		}


			
		if(address=="" || othadd=="")
		{
		alert("Please Enter Address");
		return false;
		}

		if(billno=="" || othbilno=="")
		{
		alert("Please Enter Bill No");
		return false;
		}


		if(accountno=="" || othaccno=="")
		{
		alert("Please Enter Account No ");
		return false;
		}
		if(subject=="" || othsub=="")
		{
		alert("Please Enter Subject");
		return false;
		}


		if(invalid.test(subject)){
	   	     alert('Please enter characters value for Subject..');  
	   	     return false;
	   	 }
		if(amount=="" || othamt=="")
		{
		alert("Please Enter Bill Amount ");
		return false;
		}
		if(isNaN(amount))
	       {
		     alert("Please Enter Numeric Value for Bill Amount");
		     return false;
	       }
	       	

	var agree=confirm("New Inward  Entry With Following Details \n Amount:"+amount+"\n Account No:"+accountno+"  \n  Category:"+category+" \n Subject: "+subject+" \n From:"+from+" \n Bill No: "+billno+" \n Bill Date:"+billdate+" \n Bill Due Date:"+billduedate+" Are you want to continue");
	if (agree)
	{
		

		window.location="addtoinward.jsp?amount="+amount+"&category="+category+"&subject="+subject+"&from="+from+"&billno="+billno+"&address="+address+"&billdate="+billdate+"&billduedate="+billduedate+"&accountno="+accountno;
		return true ;
		
	}
	else{
		return false ;}
	return true ;
	
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


date=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());




%>



<body>
<form name="repeatentry" id="" method="post" action="insertRepeatedEntry.jsp" onsubmit="return validation();">
<div>
<div style="font-size: 1.8em; text-align: center; margin-top: 0.0em; margin-bottom: 0.2em;">

				  <font face="Arial" size="3" color="black" ><b>Add New Repeated Payment Entry</b></font>
				  </div>
				 <div style="margin-left: 60%"> <font face="Arial" size="2" color="black" >(<font color="red"> *</font> indicates mandatory fields)</font></div>
				  
				  
				  </div> 
  

 <table  border="0" height="52%" width="100%" >
	    <tr>
	    	<td> 
	    		  <table  align="center" valign="top" height="90%" width="70%" style=" border: 3px solid #C6DEFF; ">
	    	      <!--  <div id="entryform" align="center" style="width:70%;height:55%; border:thin solid; border-color: blue; position:absolute; border-radius: 12px 12px 12px 12px;">
	              -->
	    	       <tr>
	    	        
	    	             <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Category :</b></font></td>
	    	        <td>
	    	       	<input type="text" name="category" id="category" size="15" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif;border-color: activeborder; " value="Bills" readonly="readonly"/ >
     				</td>
	    	        
						<td width="21%"> &nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Bill Date :</b></font><font color="red"> *</font></td>
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
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>From :</b></font><font color="red"> *</font></td>
	    	        <td>
	    	       	<input type="text" name="from" id="from"  style="width: 250px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; "/ >
					</td>
	    	 			<td width="21%"> &nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Bill Due Date :</b></font><font color="red"> *</font></td>
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
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Address :</b></font><font color="red"> *</font></td>
	    	        <td>
	    	        <input type="text" name="address" id="address"  size="15" style="width: 250px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; ">
					</td>
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Subject :</b></font><font color="red"> *</font></td>
	    	        <td><input type="text" id="subject" name="subject"  size="15" style="width: 200px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; background: #FFFFFF;border-color: activeborder; " >
	    	        </td>
	    	        </tr>
	    	        
	    	        <tr>
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Bill No :</b></font><font color="red"> *</font></td>
	    	        <td><input type="text" id="billno" name="billno" size="15" 
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background: # #000000" />
					</td>
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Bill Amount :</b></font><font color="red"> *</font></td>
	    	        <td><input type="text" id="billamount" name="billamount" size="15" onclick="fillpayamount();"
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background:# #000000" />
					</td>
	    	        </tr>
	    	        
   					<tr>
	    	        <td>&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="black" ><b>Account No :</b></font><font color="red"> *</font></td>
	    	        <td><input type="text" id="accno" name="accno" size="15" 
						style="width: 200px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE;  font: normal 11px Arial, Helvetica, sans-serif; background: # #000000" />
					</td>
	    
	    	        </tr>
	    	      </table>
	    	     
	    	
	    	</td>
	    </tr>
	  				<tr>
	<td align="center">
	<input type="button" name="onetime" value="One Time Payment Entry" onclick="go();" />
	<input type="submit" value="Add To Repeated List">
	</td>
	</tr>
	</table>
	</form>
	


<%	

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