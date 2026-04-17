<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>
	<script type="text/javascript">

	function clearFields()
	{
		

		var category= document.getElementById("category").value;
		//alert("catt==>"+category);
		
		 
		 category=category.split(",");
		 for (var k = 0; k < category.length; k++) {

	        var a=category[k];
	        var b=category[k];
		 }
	      
		 
		// alert("1st>"+a);
		// alert("2nd>"+b);
		 document.getElementById("ctypeSelected").value=b;
		
	}
		

	
	function getNames()
	{
	//	alert("IN FUINCTIOn");
		document.getElementById("supplierList").style.visibility="visible";
		var company=document.paymententry1.supplier.value;
	//	alert(company);
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
			//alert(reslt);
			//var mySplitResult = reslt.split("#");
			//alert(mySplitResult[15]);
			document.getElementById("supplierList").innerHTML=reslt;
			

		} 
	}

	 var queryString ="?company="+company;
	 ajaxRequest.open("GET", "AjaxTest.jsp" + queryString, true);
	 ajaxRequest.send(null); 
			

	}
	function getAccountsDetails(i)
	{
		//alert("IN ON CLICK   ");
		document.paymententry1.supplier.value=document.getElementById("name"+i).value;
		document.paymententry1.accountno.value=document.getElementById("accountno"+i).value;
		document.paymententry1.ifccode.value=document.getElementById("ifc"+i).value;
		document.paymententry1.bankname.value=document.getElementById("bankname"+i).value;
		document.paymententry1.branchname.value=document.getElementById("branchname"+i).value;
		document.paymententry1.email.value=document.getElementById("emailid"+i).value;
		document.getElementById("supplierList").style.visibility='hidden'; 
	
	}	
	
	function validate()
	{
		var numericExpression = /^[0-9]+$/;

		var name=document.paymententry1.supplier.value;
		if(name=="")
		{
			alert("Please Enter Beneficiary Name");
			return false;
		}

		var accountno=document.paymententry1.accountno.value;
		if(accountno=="" || accountno==null)
		{
			alert("Please Enter Account No");
			return false;
		}
	/*	
		if(!(accountno.match(numericExpression)))
		{
			alert("Account No Should Be Numeric Value");
			return false;
		}
		*/

		var ifccode=document.paymententry1.ifccode.value;
		if(ifccode=="" )
		{
			alert("Please Enter IFC Code");
			return false;
		}

		
		var bankname=document.paymententry1.bankname.value;
		if(bankname=="" )
		{
			alert("Please Enter Bank Name ");
			return false;
		}

		
		var branchname=document.paymententry1.branchname.value;
		if(branchname=="")
		{
			alert("Please Enter Branch Name");
			return false;
		}

		var email=document.paymententry1.email.value;
		if(email=="" || email==null)
		{
			alert("Please Enter Email Address");
			return false;
		}
		var limit=document.paymententry1.limit.value;
		if(limit=="" || limit==null)
		{
			alert("Please Enter Level 1 Limit ");
			return false;
		}

		var at="@";
   		var dot=".";
   		var lat=email.indexOf(at);
   		var lstr=email.length;
   		var ldot=email.indexOf(dot);
   		if (email.indexOf(at)==-1 && email!=""){
   		   alert("Invalid E-mail ID");
			return false;
   		}
	//alert("name->"+name);
		var agree=confirm("Beneficiary Name: "+name+"\n Account No : "+accountno+"\n  IFC Code: "+ifccode+"\n Beneficiary BankName: "+bankname+"\n  Beneficiary BranchName: "+branchname+"\n Beneficiary EmailID: "+email+"\n Level 1 Limit: "+limit+"\n\nAre you sure you want to continue with these values?");
		   if (agree)
			   return true ;
			   else
			   return false ;
		
	}



	function testlimit(limitvalue)
	{




		var category= document.getElementById("category").value;
		//alert("catt==>"+category);
		
		 
		 category=category.split(",");
		 for (var k = 0; k < category.length; k++) {

	        var a=category[k];
	        var b=category[k];
		 }
	      
		 
		 //alert("1st>"+a);
		 //alert("2nd>"+b);
		 //document.getElementById("ctypeSelected").value=b;
		//var name=document.paymententry.type.value;

		var categoryLimit=b;//document.getElementById("ctypeSelected").value;
		//alert("limit val==>"+limitvalue+"type limit==>"+categoryLimit);
		limitvalue++;
		limitvalue--;
		categoryLimit++;
		categoryLimit--;
		if(limitvalue>categoryLimit)
		{
			alert("User Limit1 value can not be greater than category limit");
			//document.paymententry.limit.value="";
		}
		
	}


	function limitpermission()
	{
		alert("You Dont have permission to change Level1Limit");
	}
</script>
</head>
<body>
 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
			String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			String id=request.getParameter("ID");
			System.out.println("ID--->"+id);
			String role=session.getAttribute("role").toString();
			String dept=session.getAttribute("department").toString();
	%>
	<%
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				
				String qry="select * from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where ID='"+id+"'";
				ResultSet rs=st.executeQuery(qry);
				System.out.println("Queryyyyy-->"+qry);
			
	while(rs.next())
{
  %>
	
	<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a>Edit Net Banking Details</a> </div>
	<div align="center" style="margin-left: 20%;">
	
	<form name="paymententry1" method="post" action="updatenetbankdata.jsp?ID=<%=id%>" onsubmit="return validate();">
	<div style="width: 50%;" align="center"><div style="float: left;"><a href="accountReport.jsp">BACK</a></div><div><b><font color="red">All Fields are Compulsory.</font></b></div></div>
	<div style="margin-right:25%; border:3px solid #2aa1cc ;width:50%;height:50%;" align="center">
	<div>
<table>
<tr>

</tr>
</table>
	
	
	<table border="0" cellpadding="3" width="80%" align="center" style="background: white;">
	<tr>
	<td align="right"><b>Name : </b></td>
	<td align="left"><input type="text" name="supplier" id="supplier" value="<%=rs.getString("BeneficiaryName") %>" style='height: 15px;'  /></td>
	</tr>
	<tr>
					<td align="right"><b>Account No: ( Only Alphanumeric )</b></td>
					<td  align="left"><input type="text" name="accountno" id="search-text" value="<%=rs.getString("BeneficiaryAccountNumber") %>" style='height: 15px;' />
					</td>
	</tr>
	<tr>
		<td align="right"><b>IFCCode : </b></td>
		<td  align="left"><input type="text" name="ifccode" id="search-text" value="<%=rs.getString("IFCCode") %>" style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right"><b>Bank Name : </b></td>
		<td  align="left"><input type="text" name="bankname" id="search-text" value="<%=rs.getString("BeneBankName") %>" style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right"><b>Branch Name : </b></td>
		<td  align="left"><input type="text" name="branchname" id="search-text" value="<%=rs.getString("BeneBankBranchName") %>" style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right"><b>Beneficiary Email ID : </b></td>
		<td  align="left"><input type="text" name="email" id="search-text" value="<%=rs.getString("Beneficiaryemailid") %>" style='height: 15px;' />
		</td>
	</tr>
	
	<tr>
		<td align="right"><b>Category: </b></td>
		<td  align="left"><select  name="category" id="category" onchange="clearFields();">
		<% 
						try
						{
							String category=rs.getString("category");
							System.out.println("   Existing category===>"+category);
							
							String sqlCat="Select Category,limit1 from "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory where status='-' order by Category ";
						    ResultSet rsCat=st1.executeQuery(sqlCat);
						    System.out.println("qry=======>"+sqlCat);
						    while(rsCat.next())
						    { 
						    	 if(category.equalsIgnoreCase(rsCat.getString(1)))
								  {
									  %>
									   <option selected="selected" value="<%=rsCat.getString("Category")+","+rsCat.getString("limit1") %>"><%=rsCat.getString("Category")%></option>
									  <%
								  }
								  else
								  {
									  %>
										
									  <option value="<%=rsCat.getString("Category")+","+rsCat.getString("limit1") %>"> <%=rsCat.getString("Category") %> </option>
												
								<%} 
						    	   
						    }
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
		<%
		 
		%>
		
		</select>
		<input type="hidden" name="ctypeSelected" id="ctypeSelected" >
		</td>
	</tr>
	<%if(role.equals("HOD") && dept.equals("Accounts")){ %>
	<tr>
		<td align="right" valign="top"><b>Level 1 Limit : </b></td>
		<td  align="left" ><input type="text" name="limit" id="limit" onblur="testlimit(this.value);"  value="<%=rs.getString("Level1Limit") %>" style='height: 15px;' />
		</td>
	</tr>
	<%}else{ %>
	<tr>
		<td align="right" valign="top"><b>Level 1 Limit : </b></td>
		<td  align="left" ><input type="text" name="limit" id="limit" onkeyup="limitpermission();" readonly="readonly" value="<%=rs.getString("Level1Limit") %>" style='height: 15px;' />
		</td>
	</tr>
	<%} %>
	
	
	
	
	

	<tr>
		<td align="right"><b>Status : </b></td>
		<td  align="left"><select name="status" id="status">
		<%
		String stat=rs.getString("Status");
		String statusval="";
		if(stat.equalsIgnoreCase("Deactivate"))
		{
			statusval="Deactive";
		}
		else
		{
			statusval="Active";
		}
		%>
		
		<option value="<%=rs.getString("Status")%>"><%=statusval %></option>
		<option value="-">Active</option>
		<option value="Deactivate">Deactive</option>
		</select>
		</td>
	</tr>
		
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" class="formElement"/></div>
			</td>
	</tr>
		
	</table>
	</div>

</div>
	</form>
	</div>

	
	
			<br><br><br><br><br><%} %>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	
	
	<%
			} catch (Exception e) {
			}
		conn.close();
	%>
	</body>
	</html>
</jsp:useBean>