<%@  page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>


<script language="JavaScript1.2">

function open1()
{
//alert("hi");
	window.open('RepeatEntry.jsp');
}

function popup1(no)
{
	window.open('editrepeatentry.jsp?id='+no,'mywindow3','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
}

function popup2(no)
{
	   var agree=confirm("Do You Want To Change Status Of This Payment Entry ?");
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
			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					if(reslt="Yes")
					{
				alert("Payment Entry Status Updated.");
					}
					else
					{
						alert("Payment Entry Status Not Updated.Pls Try Again !! ");
								
					}
							reload();
				} 
			}
			var queryString = "?srno="+no;
			try
			{
				ajaxRequest.open("GET", "statuschange.jsp" + queryString, true);
				ajaxRequest.send(null);
			} 
			catch (e) 
			{
				alert(e);
			}
	   }
	   else
	   {
		   return false;
	   }
}
function reload()
{
	window.location.reload();
}






function update()
{




	 var accno="",cat="",frm="",add="",sub="",billno="",billamt="",billdate="",billddate="";
	 var accno1="";
	var cntr=document.repayment.cntr.value;
   var subcat1;
   var inp1;
	var lt=document.getElementsByName("cb").length;
	
//alert(lt);
	
	cntr=cntr-1;
   var catf,catf1;

   
	if(document.repayment.maincb.checked==true)
	{

		for(var i=1;i<=lt;i++)
		{	
           
      
          try{
			if(document.getElementById("cb"+i).checked==true)
			{
			

  			if(accno.length==0)
       	{
       		
     

  				accno=document.getElementById("acc"+i).innerHTML;

       		
       	}else{

       		accno=accno+","+ document.getElementById("acc"+i).innerHTML;
       		//alert("hi" +accno);
       	}

  			if(cat.length==0)
			{
				
				

				cat=document.getElementById("cat"+i).innerHTML;
				//alert("cat" +cat);
				
			}else{

				cat=cat+","+document.getElementById("cat"+i).innerHTML;

			}




		   
		   if(frm.length==0)
			{
				
				

			   frm=document.getElementById("frm"+i).innerHTML;
			   //alert("frm" +frm);
				
			}else{

				frm=frm+","+document.getElementById("frm"+i).innerHTML;

			}




			
		   if(add.length==0)
			{
				
				

			   add=document.getElementById("add"+i).innerHTML;

				
			}else{

				add=add+","+document.getElementById("add"+i).innerHTML;

			}



			
		   if(sub.length==0)
			{
				
				

			   sub=document.getElementById("sub"+i).innerHTML;

				
			}else{

				sub=sub+","+document.getElementById("sub"+i).innerHTML;

			}
		        
			 			 
				 if(billno.length==0)
					{
						
						

					 billno=document.getElementById("billno"+i).innerHTML;

						
					}else{

						billno=billno+","+document.getElementById("billno"+i).innerHTML;

					}

					
						
			 if(billamt.length==0)
				{
					
					

				 billamt=document.getElementById("billamt"+i).innerHTML;

					
				}else{

					billamt=billamt+","+document.getElementById("billamt"+i).innerHTML;

				}

			 if(billdate.length==0)
				{
					
					

				 billdate=document.getElementById("billdate"+i).innerHTML;

					
				}else{

					billdate=billdate+","+document.getElementById("billdate"+i).innerHTML;

				}



			 if(billddate.length==0)
				{
					
					

				 billddate=document.getElementById("billduedate"+i).innerHTML;

					
				}else{

					billddate=billddate+","+document.getElementById("billduedate"+i).innerHTML;

				}	
  	       	
   
			 
			}			

           }catch(e){
		}
			}

		}

	else
	{
		for(var i=1;i<=lt;i++)
		{	
           
          
			if(document.getElementById("cb"+i).checked==true)
			{
			
			//alert(document.getElementById("cb"+i).value);
           	try{
           	
           	
				if(accno.length==0)
		       	{
		       		
		     
					//alert(accno);
					//alert("i is"+i);

					
					//alert(document.getElementById("acc"+i).innerHTML);

					
				
		  			accno=document.getElementById("acc"+i).innerHTML;
					
		  				//alert("below" +accno);
		       	}else{

		       		accno=accno+","+ document.getElementById("acc"+i).innerHTML;
		       		//alert("hi" +accno);
		       	}
           	
           	

           	
           	if(cat.length==0)
			{
				
				

				cat=document.getElementById("cat"+i).innerHTML;
				//alert("cat" +cat);
				
			}else{

				cat=cat+","+document.getElementById("cat"+i).innerHTML;

			}

           	}catch(e)
           	{
               	alert(e);
           	}


		   
		   if(frm.length==0)
			{
				
				

			   frm=document.getElementById("frm"+i).innerHTML;
			   //alert("frm" +frm);
				
			}else{

				frm=frm+","+document.getElementById("frm"+i).innerHTML;
				 //alert("hi" +frm);
			}




			
		   if(add.length==0)
			{
				
				

			   add=document.getElementById("add"+i).innerHTML;

				
			}else{

				add=add+","+document.getElementById("add"+i).innerHTML;

			}



			
		   if(sub.length==0)
			{
				
				

			   sub=document.getElementById("sub"+i).innerHTML;

				
			}else{

				sub=sub+","+document.getElementById("sub"+i).innerHTML;

			}
		        
			 			 
				 if(billno.length==0)
					{
						
						

					 billno=document.getElementById("billno"+i).innerHTML;

						
					}else{

						billno=billno+","+document.getElementById("billno"+i).innerHTML;

					}

					
						
			 if(billamt.length==0)
				{
					
					

				 billamt=document.getElementById("billamt"+i).innerHTML;

					
				}else{

					billamt=billamt+","+document.getElementById("billamt"+i).innerHTML;

				}

			 if(billdate.length==0)
				{
					
					

				 billdate=document.getElementById("billdate"+i).innerHTML;

					
				}else{

					billdate=billdate+","+document.getElementById("billdate"+i).innerHTML;

				}



			 if(billddate.length==0)
				{
					
					

				 billddate=document.getElementById("billduedate"+i).innerHTML;

					
				}else{

					billddate=billddate+","+document.getElementById("billduedate"+i).innerHTML;

				}		   
			


			 
			}			

          
           
			}



		}
	


//alert("category is " +cat);
//alert("Address  is " +add);




//window.location="Standarddelete.jsp?category="+cat1+"&sub="+subcat+" &input="+inp+" &enter="+entr+" &update="+updat+"";
			

	
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
			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					reslt=reslt.replace(/^\s+|\s+$/g,'');
					
//alert(reslt);


					 if(reslt=="Yes")
					{
						alert("Data Updated Successfully");
					}
					else
					{
						alert("Please select option ");
								
					}
							//reload();
				} 
			}
			var queryString="?name=sachin&account="+accno+"&category="+cat+"&from="+frm+"&address="+add+"&subject="+sub+"&billno="+billno+"&billamt="+billamt+"&billdate="+billdate+"&billddate="+billddate ;
			try
			{
				ajaxRequest.open("GET", "paymentToinward.jsp" + queryString, true);
				ajaxRequest.send(null);
			} 
			catch (e) 
			{
				alert(e);
			}
	   


}
function selectAll()
{

    //alert(">>>>>");

	var cntr=document.repayment.cntr.value;

	//alert(">>>val>>>>"+cntr)
	cntr=cntr-1;

	
	if(document.repayment.maincb.checked==true)
	{

      //  alert("inside")
		for(var i=0;i<=cntr;i++)
		{	

           //alert("111")
           try{
			document.getElementById("cb"+i).checked=true;
			

            }catch(e){//alert(e)}
		}
			}
	}
	else
	{
		
		for(var i=0;i<=cntr;i++)
		{	

          try{
			document.getElementById("cb"+i).checked=false;
          }catch(e){//alert(e)}
		}

			}
	}
}


function gotoExcel (elemId, frmFldId)  
{  
	//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  
//alert(oFld.value);
//alert(obj.innerHTML);
          document.repayment.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["repayment"].submit();       // CHANGE FORM NAME HERE

} 





</script>
                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2= null;
    String selectedName;
	String FollowUpType="",status="";
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
	int j=1;int i=1;
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
	DecimalFormat nf = new DecimalFormat("0.00");
	
	try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2= conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
	
%>
<body>
<form name="repayment" id="repayment" method="post" onsubmit="return validate();">

<div  id="table">
		<div style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Repeated Payment Entry Report</a></div>
	
	<div align="right">
	<a href="#" onclick="open1();">Add New Repeated Payment Entry</a>
	</div>
	
	<div align="right">
	<a href="#" onclick="update();">Update To Inward</a>
	</div>
	<div align="right">
		<table align="right"><tr>	
				<td align="right">
								
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 <font size="2">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></font>
			 
				</td>
		</tr></table></div>
	<br>
	
	<%
String exportFileName="Enquiry_det.xls";   // GIVE YOUR REPORT NAME
%>	

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
	<table border="1px" class="sortable">
	<tr>
    <th><div align="center"> <input type="checkbox" name="maincb"  id="maincb"  value="maincb" onClick="selectAll();"/></div> </th>
	
	<th>Sr No</th>
	<th>Account No</th>
	<th>Category</th>
	<th>From</th>
	<th>Address</th>
	<th>Subject</th>
	<th>Bill No</th>
	<th>Bill Amount</th>
	<th>Bill Date</th>
	<th>Bill Due Date</th>	
	<th></th>	
	</tr>
	<%
	String sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment where ActiveStatus='Yes'";
	ResultSet rs=st.executeQuery(sql);
	System.out.println(sql);
	while(rs.next())
	{
	%>
	
	<tr>
	<td> 
	<div align="center"> <input type="checkbox" name="cb" id="cb<%=i%>"  value="cb<%=i%>" > </input> </div> 
	</td>
	<td><div align="right"><%=i %></div></td>
	
	<td ><div id="acc<%=i%>" align="right">   <%=rs.getString("AccountNo") %>  </div>
	
	
	
	
	</td>
	
	
	<td><div id="cat<%=i%>" align="left"><%=rs.getString("Category") %></div></td>
	<td><div id="frm<%=i%>" align="left"><%=rs.getString("FromDetails") %></div></td>
	<td><div id="add<%=i%>" align="left"><%=rs.getString("Address") %></div></td>
	<td><div id="sub<%=i%>" align="left"><%=rs.getString("Subject") %></div></td>
	<td><div id="billno<%=i%>" align="left"><%=rs.getString("BillNo") %></div></td>
	<td><div id="billamt<%=i%>" align="right"><%=rs.getString("BillAmount") %></div></td>
	<td><div id="billdate<%=i%>" align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("Billdate"))) %></div></td>
	<td><div id="billduedate<%=i%>" align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("BillDueDate"))) %></div></td>
	<td><a href="#" onclick="popup1('<%= rs.getInt("SrNo")%>');">Edit </a> /<a href="#" onclick="popup2('<%= rs.getInt("SrNo")%>');"> Deactivate</a></td>
	
	</tr>
	<%
	i++;
	}
	%>
					<input type="hidden" name="cntr" id="cntr"  value="<%=i%>" />	
		
	</table>

	
<%
	}catch(Exception e)
	{e.printStackTrace();}
%>

<br>
	<br>
	
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	</div>
</form>
</body>
</html>
</jsp:useBean>