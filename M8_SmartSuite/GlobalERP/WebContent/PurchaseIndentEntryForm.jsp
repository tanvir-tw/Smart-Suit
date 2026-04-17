<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">
<script>

function formValidation1()
{
	alert("Hi");
}
function formValidation()
{
	//alert("Hi");
	
	var itemdesc=document.getElementById("itemdesc").value;
	//alert("itemdesc :- "+itemdesc);
	
	if(itemdesc=="" ){
		alert("Please Enter Value For Item Specification");
		return false;
	}
	var make=document.getElementById("make").value;
	//alert("make :- "+make);
	
	var invalid=/^[a-zA-Z  .]+$/;
	var oth=make.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(make=="" || oth==""){
		alert("Please Enter Value For Make");
		return false;
	}
	if(!invalid.test(make)){
		alert("Please Enter Character Value For Make");
	     return false;
	 }	
	
	var partno=document.getElementById("partno").value;
	//alert("partno :- "+partno);
	
	//var invalid=/^[a-zA-Z  .]+$/;
	var oth=make.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(partno=="" || oth==""){
		alert("Please Enter Value For PartNo");
		return false;
	}
	/* if(!invalid.test(partno)){
		alert("Please Enter Valid Value For PartNo");
	     return false;
	 } */
	
	
	var quantity=document.getElementById("quantity").value;
	//alert("quantity :- "+quantity);
	
	if(quantity=="" ){
		alert("Please Enter Numeric Value For Quantity");
		return false;
	}
	
	// var invalid=/^[0-9]+$/;
	var invalid = /^[0-9.]+$/;
	
	if(!(quantity ==0))
		{
			 if(isNaN(quantity))
				{
				 alert("Please Enter Numeric Value For Quantity");
					//document.getElementById("noofunits1").style.display="";
					return false;
				}	
			 if(!invalid.test(quantity)){
				 alert("Please Enter Numeric Value Quantity");
			        //document.getElementById("noofunits2").style.display="";
			                return false;
			            }
				
				
		    }
	
	
	var cost=document.getElementById("cost").value;
	//alert("quantity :- "+quantity);
	
	if(cost=="" ){
		alert("Please Enter Numeric Value For Cost");
		return false;
	}
	
	// var invalid=/^[0-9]+$/;
	var invalid = /^[0-9.]+$/;
	
	if(!(cost ==0))
		{
			 if(isNaN(cost))
				{
				 alert("Please Enter Numeric Value For Cost");
					//document.getElementById("noofunits1").style.display="";
					return false;
				}	
			 if(!invalid.test(cost)){
				 alert("Please Enter Numeric Value For Cost");
			        //document.getElementById("noofunits2").style.display="";
			                return false;
			            }
				
				
		    }
	
	var unit=document.getElementById("unit").value;
	//alert("unit :- "+unit);
	
	if(unit=="Select" ){
		alert("Please select value for Unit Of Measure");
		return false;
	}
	
	var instructions=document.getElementById("instructions").value;
	//alert("instructions:- "+instructions);
	
	var dept=document.getElementById("dept").value;
	//alert("dept:- "+dept);
	
	if(dept=="Select" ){
		alert("Please select value for Department");
		return false;
	}
	
	var project=document.getElementById("project").value;
	//alert("project "+project);
	
	if(project=="Select" ){
		alert("Please select value for Project");
		return false;
	}
	
	var costcenter=document.getElementById("costcenter").value;
	//alert("costcenter "+costcenter);
	
	if(costcenter=="Select" ){
		alert("Please select value for CostCenter");
		return false;
	}
	
	
	// var deliverydate=document.getElementById("contractdate").value;
	//alert("deliverydate "+deliverydate);
	
	
		//alert("Hi");
		var chkf="";
		var chkt="";
		var objFromDate = document.getElementById("contractdate").value;
		var fdate=objFromDate.split("-");
		if(fdate[1]=="Jan")
		{
			chkf="01";
		}
		if(fdate[1]=="Feb")
		{
			chkf="02";
		}
		if(fdate[1]=="Mar")
		{
			chkf="03";
		}
		if(fdate[1]=="Apr")
		{
			chkf="04";
		}
		if(fdate[1]=="May")
		{
			chkf="05";
		}
		if(fdate[1]=="Jun")
		{
			chkf="06";
		}
		if(fdate[1]=="Jul")
		{
			chkf="07";
		}
		if(fdate[1]=="Aug")
		{
			chkf="08";
		}
		if(fdate[1]=="Sep")
		{
			chkf="09";
		}
		if(fdate[1]=="Oct")
		{
			chkf="10";
		}
		if(fdate[1]=="Nov")
		{
			chkf="11";
		}
		if(fdate[1]=="Dec")
		{
			chkf="12";
		}
		var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
		
		
	    var objToDate = document.getElementById("today").value;
	   // alert("Today :-"+objToDate);
	    
	    var tdate=objToDate.split("-");
	    
	    if(tdate[1]=="Jan")
		{
	    	chkt="01";
		}
		if(tdate[1]=="Feb")
		{
			chkt="02";
		}
		if(tdate[1]=="Mar")
		{
			chkt="03";
		}
		if(tdate[1]=="Apr")
		{
			chkt="04";
		}
		if(tdate[1]=="May")
		{
			chkt="05";
		}
		if(tdate[1]=="Jun")
		{
			chkt="06";
		}
		if(tdate[1]=="Jul")
		{
			chkt="07";
		}
		if(tdate[1]=="Aug")
		{
			chkt="08";
		}
		if(tdate[1]=="Sep")
		{
			chkt="09";
		}
		if(tdate[1]=="Oct")
		{
			chkt="10";
		}
		if(tdate[1]=="Nov")
		{
			chkt="11";
		}
		if(tdate[1]=="Dec")
		{
			chkt="12";
		}
	    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
	   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
	     
	    var date1 = new Date(objFromDate1);//delivery date
	    var date2 = new Date(objToDate1);//today
	    
	    //alert("from > "+date1+" Todate > "+date2);
	    
	    
	    
	     
	        if(date1 <  date2)
	        {
	        	
	         
	         alert("Delivery Date Should be greater or equals to  TodaysDate");
	            return false; 
	        }	

		
	        
	
	
	
	
	
	
	var vendor=document.getElementById("vendor").value;
	//alert("vendor "+vendor);
	
	if(vendor=="")
		{
		alert("Please Enter Value For Vendor");
		return false;
		
		}
	var invalid=/^[a-zA-Z  .]+$/;
	var oth=vendor.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(vendor=="" || oth==""){
		alert("Please Enter Value For Vendor");
		return false;
	}
	if(!invalid.test(vendor)){
		alert("Please Enter Character Value For Vendor");
	     return false;
	 }	
	
	var vendoraddress=document.getElementById("vendoraddress").value;
	//alert("vendoraddress "+vendoraddress);
	
	
	if(vendoraddress=="" ){
		alert("Please Enter Value For Vendor Address");
		return false;
	}
	
	
	var vendormobile=document.getElementById("vendormobile").value;
	//alert("vendormobile "+vendormobile);
	//alert(vendormobile.trim().length);
	
	if(!(vendormobile ==0))
			{
				if(isNaN(vendormobile))
				{
				alert("Please Enter 10 Digit Numeric Value For Contact "); 
	        	return false;
				}
				if((vendormobile.trim().length < 10)  || (vendormobile.trim().length >15))
						 {
					 
					 alert("Please Enter 10 Digit Numeric Value For Contact "); 
			        return false;
			    }
			}
			else
			{
				vendormobile="";
				alert("Please Enter 10 Digit Numeric Value For Contact ");
			    return false;	
			}
	
	var vendoremail=document.getElementById("vendoremail").value;
	//alert("vendoremail "+vendoremail);
	
	 
	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

	if(vendoremail=="")
		{
		alert("Please Enter Email ");
		//document.getElementById("email3").style.display="";
		return false;
		}

	if(!text.test(vendoremail))
		{
		alert("Please Enter valid Email ");
		//document.getElementById("email2").style.display="";
		return false;
		
		}
	
	
	
        
        
}
		

	      
	
	
	
	
	
	




		


</script>
<%@ include file="header.jsp"%>
<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		%>
		
		<%



Statement stdynamicdrop = null;
String datenew1="",datenew2="",datenew3="",datenew4="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
datenew4=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
<input type="hidden" name="today" id="today" value="<%=datenew4 %>"  />
<%
//centnon1.getConnection();
// con1=centconn.ReturnConnection();
//stdynamicdrop=con1.createStatement();

Statement st = null, st1 = null, st3 = null, st4 = null,st2 = null;

String selectedName;
String FollowUpType = "";String company="";
st = con1.createStatement();
st1 = con1.createStatement();
st2 = con1.createStatement();
st3 = con1.createStatement();
st4 = con1.createStatement();


%>
 
 <form name="addCustomer" action="indentinsert.jsp" method="post" "> 



<%




 
%>
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3px" color="black"><b>Purchase Indent Entry </b></font> </label></td></tr></tbody></table></div>
<%%>

<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td></td>


</tr>
<tr></tr>
<tr>
 
 <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Item Specification :</b> </label><textarea id="itemdesc" name="itemdesc" style='width: 200px; height:50px' class="element textarea medium"/></textarea><br><br><!--11,2--></td>
 

<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Make :</b> </label><input id="make" name="make"  class="element text medium" type="text"  value=""  onblur="return contactpersonfun();"/></input>


</td>

</tr>

<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Part No :</b> </label><input id="partno" name="partno"  class="element text medium" type="text"  value=""/></textarea><br><br><!--4,1--></td>


<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Quantity :</b> </label><input id="quantity" name="quantity"  class="element text medium" type="text"  value=""/></textarea><br><br><!--4,1--></td>
<td><!--4,2--></td>

</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Cost :</b> </label><input id="cost" name="cost"  class="element text medium" type="text"  value=""/></textarea><br><br><!--4,1--></td>
</tr>
<tr>

<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Unit Of Measure :</b> </label><input id="unit" name="unit"  class="element text medium" type="text"  value=""/></textarea><br><br>4,1</td> -->
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Unit Of Measure :</b> </label><select id="unit" name="unit"  class="element select medium" >
	
								<option value="Select">Select</option>
								<option value="Bag">Bag</option>
								<option value="Bottle">Bottle</option>
								<option value="Box">Box</option>
								<option value="Can">Can</option>
								<option value="Carton">Carton</option>
								<option value="Centimeter">Centimeter</option>
								<option value="Dozen">Dozen</option>
								<option value="Each">Each</option>
								<option value="Feet">Feet</option>
								<option value="Inch">Inch</option>
								<option value="Kilogram">Kilogram</option>
								<option value="Kit">Kit</option>
								<option value="Liter">Liter</option>
								<option value="Ream">Ream</option>
								<option value="Roll">Roll</option>
								<option value="Sheet">Sheet</option>
								<option value="SquareFeet">Square Feet</option>
								
								
								
								
								
								
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
			</td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2"></font><b>Special Instructions :</b> </label><textarea id="instructions" name="instructions" style='width: 200px; height:50px' class="element textarea medium"/></textarea><br><br><!--11,2--></td>
		



</tr>

<tr>					

<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Department :</b> </label><input id="website" name="website"  class="element text medium" type="text"  value=""/></textarea><br><br>4,1</td> -->
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Department :</b> </label><select id="dept" name="dept"  class="element select medium" >
	<%
							String sql = "select distinct(Dept) as Dept from db_GlobalERP.UserMaster where companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' order by Dept";
								ResultSet rs = st.executeQuery(sql);
								%>
								<option value="Select">Select</option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString("Dept")%>">
							<%=rs.getString("Dept")%></option>
						<%
							}
						%>
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
			</td> 
<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Project :</b> </label><input id="website" name="website"  class="element text medium" type="text"  value=""/></textarea><br><br>4,1</td> -->
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Project :</b> </label><select id="project" name="project"  class="element select medium" >
	
								<option value="Select">Select</option>
								<option value="DragonFly">DragonFly</option>
								<option value="HummingBird">Humming Bird</option>
								<option value="SmartGrid">SmartGrid</option>
								
								
								
								
								
								
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
			</td>


</tr>

<tr>					

<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Cost Center :</b> </label><input id="website" name="website"  class="element text medium" type="text"  value=""/></textarea><br><br>4,1</td> -->
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Cost Center :</b> </label><select id="costcenter" name="costcenter"  class="element select medium" >
	
								<option value="Select">Select</option>
								<option value="FixedAsset">Fixed Asset</option>
								<option value="Office">Office</option>
								<option value="Production">Production</option>
								<option value="Purchase">Purchase</option>
								<option value="R&D">R&D</option>
								<option value="Repair">Repair</option>
								<option value="Stationary">Stationary</option>
								
								
								
								
								
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
			</td>
<!-- <td>Delivery Date :</b> </label><input id="website" name="website"  class="element text medium" type="text"  value=""/></textarea><br><br>4,1</td> -->

<!-- <td id="contDate" align="left" >
<font color="red" size="2">*</font><b>Delivery Date : </b> </td> -->

			<td align="left">
			<font color="red" size="2">*</font><b>Delivery Date : </b> 
					<input type="text" id="contractdate" name="contractdate" size="12" value="<%=datenew1%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "contractdate",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "contractdate"       // ID of the button
					    }
					  );
				</script>
			
			</td>


</tr>
<tr>					

<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Suggested Vendor :</b> </label><input id="vendor" name="vendor"  class="element text medium" type="text"  value=""/></textarea><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Suggested Vendor Address :</b> </label><textarea id="vendoraddress" name="vendoraddress" style='width: 200px; height:50px' class="element textarea medium"/></textarea><br><br><!--11,2--></td>


</tr>

<tr>

</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Suggested Vendor Contact :</b> </label><input id="vendormobile" name="vendormobile"  class="element text medium" type="text"  value=""  onblur="return funmob1();"/></textarea>
 <div>
	<label id="mob1"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
				<label id="mob12" style="display: none;"><font face="Arial" size="2" color="red">Number Should Be 10-15 Digits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
		        <label id="mob123"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Mobile Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
		         </div>
		        </td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Suggested Vendor E-mail :</b> </label><input id="vendoremail" name="vendoremail"  class="element text medium" type="text"  value=""  onblur="return validateEmail();"/></textarea>
<div>
<label  id="email3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter EmailID</font></label> 
<label  id="email1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter valid EmailID</font></label> 
<label   id="email2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter valid EmailID</font></label> 
</div>
</td>


</tr>




<tr>

</tr>

<tr>

</tr>

<tr>

</tr>



</table>

<div align="center">

<label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label>
<div></div>
<div></div>
<input id="submit" name="submit"  class="button_text" type="submit"  value="Submit"  onclick="return formValidation();" />
<br><br>
<br><br>
<br><br>
</div>
</form>

</jsp:useBean>

<%-- <%@include file="footer_new.jsp"%> --%>

<%@ include file="footer_new.jsp"%>