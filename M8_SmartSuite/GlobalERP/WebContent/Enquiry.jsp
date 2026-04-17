<%@ page language="java"%>
<%@ page import="java.sql.*;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Personal Details</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all" />

<script type="text/javascript">

function validateForm() 
{	
	var com_name = document.enquiry_form.com_name.value;
	//var invalid=/[^A-Za-z\s\-]/;
	if(com_name.trim()=="") {
		alert("Enter Company Name!");    
		return false;
		}
/*	if(invalid.test(com_name)){
		alert("Enter valid Company name!");
		return false;
	}*/

	var address = document.enquiry_form.address.value;
	if(address.trim()=="") {
		alert("Enter Address!");
		return false;
	}

	//validation for email id
	var email1=document.enquiry_form.email.value;
	if(email1.trim()==""){
		alert("Enter Email ID!");
		return false;
	}
		var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
    var email=emailfilter.test(document.enquiry_form.email.value);
    if(email==false)
    {
    	alert("Enter valid E-Mail ID");
    return false;
    }
    
	if(document.getElementById("state").style.display=="block") {
	var state= document.getElementById("state").options[document.getElementById("state").selectedIndex].value;
	var add_state = document.getElementById("add_state");
	if(state=="select") {
			alert("Enter state!");
		return false;
	}
}
	if(document.getElementById("add_state").style.display=="block") {
		var add_state = document.enquiry_form.add_state.value;
		var invalid=/[^A-Za-z\s]/;
		if(add_state.trim()=="") {
		alert("Enter state name!!");
		return false;
		}
		if(invalid.test(add_state)) {
			alert("Enter valid state name!!");
			return false;
		}
					
	}
		
	if(document.getElementById("city").style.display=="block") {
	var city= document.getElementById("city").options[document.getElementById("city").selectedIndex].value;
	var add_city = document.getElementById("add_city");
	if(city=="select") {
			
			alert("Enter city!");
		return false;
		}
	}
	
	if(document.getElementById("add_city").style.display=="block") {
		var add_city = document.enquiry_form.add_city.value;
		var invalid=/[^A-Za-z\s]/;
		if(add_city.trim()=="") {
		alert("Enter city name!!");
		return false;
		}
		if(invalid.test(add_city)) {
			alert("Enter valid city name!!");
			return false;
		}
		
	}
	
	var pin=document.enquiry_form.pin.value;
	var invalid=/[^0-9]/; //digits only allowed
	if(pin.trim()==""){
	alert("Enter Pin code!");
	return false;
	}
	if(invalid.test(pin))
	{
		alert("Invalid Pincode!");
		return false;
	}
	if(pin.length<6 || pin.length>6){
		alert("Pincode must contain 6 digits!");
		return false;
	}

	var contact_preson = document.enquiry_form.contact_person.value;
	var invalid=/[^A-Za-z\s]/;
	if(contact_preson.trim()=="") {
		alert("Enter Contact Person Name!");    
		return false;
		}
	if(invalid.test(contact_preson)){
		alert("Enter valid Contact Person name!");
		return false;
	}

	var phone_num = document.enquiry_form.phone_num.value;
	var invalid=/[^0-9]/; //only numbers are  permitted
	if(phone_num.trim()==""){
		alert("Enter Phone Number!");
		return false;
	}
	if(invalid.test(phone_num)){pin.length<6
		alert("Invalid Phone Number!");
		return false;
	} 
	if(phone_num.length<6){
		alert("Invalid Phone Number!");
		return false;
	}

	var mno = document.enquiry_form.mob_num.value;
	var invalid=/[^0-9]/; //only numbers are  permitted
	if(mno.trim()==""){
		alert("EnterMobile Number!");
		return false;
	}
	if(invalid.test(mno)){
		alert("Invalid Mobile Number!");
		return false;
	}
	if(mno.length<10){ //contact number must be 10 digits length
		alert("Mobile Number must be 10 numbers length!");
		return false;
	} 

	var msg = document.enquiry_form.msg.value;
	if(msg.trim()=="") {
		alert("Enter Message!");
		return false;
	}
	   
return true;
}

function demoDisplay()
{
document.getElementById("add_state").style.display="block";
document.getElementById("state").style.display="none";
document.getElementById("add").style.display="none";
document.getElementById("img1").style.display="";
}
function demoDisplay1()
{
document.getElementById("add_city").style.display="block";
document.getElementById("city").style.display="none";
document.getElementById("ad").style.display="none";
document.getElementById("img2").style.display="";
}
function removestate()
{
	document.getElementById("state").style.display="block";
	document.getElementById("add_state").style.display="none";
	document.getElementById("add").style.display="";
	document.getElementById("img1").style.display="none";
}
function removecity()
{
	document.getElementById("city").style.display="block";
	document.getElementById("add_city").style.display="none";
	document.getElementById("ad").style.display="";
	document.getElementById("img2").style.display="none";
}
</script>

</head>
<body id="main_body" >
<%
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");
Connection conn=null;
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/TWSQL_TWALLDATA","erp","1@erp");
conn=DriverManager.getConnection("jdbc:mysql://"+host+"/db_GlobalERP",user,pass);
}
catch(Exception e)
{
	System.out.println("Exception=========>>"+e);
}
Statement st=conn.createStatement();
Statement st1=conn.createStatement();
%>

<%
if(request.getParameter("msg")==null) {
%>
<img id="top" src="newimages/top.png" alt="" />
	
	<div id="form_container">
	
		<h1 align="center">
		<table width="100%" border=0>
	<tr>
		<td style="width: 25%;">
			<a href="http://www.mobile-eye.in" target="_blank"><img src="images/mobile123.jpg" style="height: 80px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
		</td>
		<td style="vertical-align: bottom;text-align: center;width: 33%;">
			<div style="text-align: center;"><a>Enquiry Form</a></div>
		</td>
		<td style="vertical-align: middle;text-align: right;" style="width: 33%;" ><div width="30%" align="left" style="margin-left: 1.6em;">
			<font style="font-size: 0.4em;color: red">TRANSWORLD COMPRESSOR TECHNOLOGIES LIMITED</font><br/>
			<font style="font-size: 0.4em;">C-3/8 Rakshalekha, Koregaon Park, Pune 411001 INDIA</font><br/>
			<font style="font-size: 0.4em;">Tel: +91-20-26131676, Fax +91-20-26139599</font><br/>
			<font style="font-size: 0.4em;">Email : marketing@myfleetview.com</font><br/></div>
		</td>
	</tr>
		</table></h1>
		<br />
		<form id="enquiry_form"  name="enquiry_form" class="appnitro" enctype="multipart/form-data" method="post" action="Enquiry1.jsp" onsubmit = "return validateForm();">
					<div class="form_container1">
				</div>						
			<ul >
			<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
			<table border="0" width="100%" align="center">
			
		<tr>
	  		<td align="left" colspan="4" style="width: 30%;">	
	 		<div  style="width: 800px;margin-left: 0.9em">
					<label class="description" for="element_4" style="width: 150px;"><font size="3" face="arial">Company Name *</font></label>
				<div>
					<input id="com_name" name="com_name" class="element text medium" type="text" maxlength="255" value="" style="width: 600px; height: 20px;" /> 
				</div> 
			</div>
		
		</td>
		</tr>	
		<tr>
			<td align="left" colspan="4" style="width: 30%;">	
	 		<div id="li_4" style="width: 800px;margin-left: 0.9em">
				<label class="description" for="element_8" style="width: 170px;"><font size="3" face="arial">Address * </font></label>
			<div>
				<textarea name ="address" id = "address"  class="element textarea small" style="width: 600px;"></textarea>
			</div> 
		</div>
		</td>
	</tr>
		
		<tr>
			<td colspan="1"  style="width: 30%;">
				<div  style="width: 10em;margin-left: 0.9em">
					<label class="description" for="element_8" style="width: 170px;"><font size="3" face="arial">Email ID * </font></label>
				<div>
					<input id="email" name="email" class="element text medium" type="text" maxlength="255" value="" style="width: 600px; height: 20px;"></input> 
				</div> 
			</div>
			</td>
	 </tr>
		
		<tr>
			<td colspan="1" style="width: 5em;">
				<div style="width: 10%;margin-left: 0.9em">
					<label class="description" for="element_11" style="width: 170px;height: 20px;"><font size="3" face="arial">State * </font></label>
				<div>
					<select class="element select medium" id="state" name="state" style="width: 150px; height: 20px;" > 
						<option value="select" >select</option>
						<%
			            String query1 = "select distinct(State) from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo  where State <>'-'  order by State";
			             ResultSet rs1 = st1.executeQuery(query1);
			             while(rs1.next())
			              {
							%>
						<option value="<%=rs1.getString("State") %>" ><%=rs1.getString("State")%></option>
						<%} %>
			
					</select>
				<input type = "text" id = "add_state" name = "add_state" value = "" class="element text medium" maxlength="200" style="width: 150px; height: 20px;"></input>
				<a href="javascript: showbox1(1);" onclick = "demoDisplay()" id = "add">Add_State</a>
				<a href="javascript: showbox1(1);" onclick = "removestate();" id = "img1" style="display: none">Remove</a>
				</div> 
			</div>	
		</td>
		<td colspan="1" style="width: 10%;">
			<div style="width: 15em;">
				<label class="description" for="element_12" style="width: 150px;height: 20px;"><font size="3" face="arial">City *</font></label>
				<div>
					<select class="element select medium" id="city" name="city" style="width: 150px; height: 20px;"> 	
					<option value="select" >select</option>
					<%
		            String query = "select distinct(City) from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where City<>'-' order by City";
		             ResultSet rs = st.executeQuery(query);
		             while(rs.next())
		              {
						%>
					<option value="<%=rs.getString("City") %>" ><%=rs.getString("City")%></option>
					<%} %>
				</select>
				<input type = "text" id = "add_city" name = "add_city" value = "" class="element text medium" maxlength="200" style="width: 150px; height: 20px;"></input>
				<a href="javascript: showbox1(2);" onclick="demoDisplay1()" id = "ad">Add City</a>
				<a href="javascript: showbox1(2);" onclick="removecity();" id = "img2" style="display: none">Remove</a>
			</div> 
			</div>	
		</td>
		
		<td style="width: 15em;">
		<div style="width: 15%;margin-left: 1em"  id="li_12">
		
		<label class="description" for="element_13" style="width: 150px;"><font size="3" face="arial">PinCode *</font></label>
		<div>
			<input id="pin" name="pin" class="element text medium" type="text" maxlength="255" value="" style="width: 155px; height: 20px;text-align: right"></input> 
		</div>
	
		</div>
		</td>
		</tr>
		
		<tr>
			<td colspan="1" style="width: 5em;">
				<div style="width: 15%;margin-left: 0.9em">
					<label class="description" for="element_11" style="width: 170px;"><font size="3" face="arial">Contact Person * </font></label>
				<div>
					<input type = "text" id = "contact_person" name = "contact_person" value = "" class="element text medium" maxlength="200" style="width: 200px; height: 20px;"></input>
				</div> 
			</div>	
		</td>
		<td colspan="1" style="width: 5em;">
				<div style="width: 15%;margin-left: 0.9em">
					<label class="description" for="element_11" style="width: 170px;"><font size="3" face="arial">Phone No * </font></label>
				<div>
					<input type = "text" id = "phone_num" name = "phone_num" value = "" class="element text medium" maxlength="200" style="width: 150px; height: 20px;text-align: right"></input>
				</div> 
			</div>	
		</td>
		
		<td colspan="1" style="width: 5em;">
				<div style="width: 15%;margin-left: 0.9em">
					<label class="description" for="element_11" style="width: 170px;"><font size="3" face="arial">Mobile No * </font></label>
				<div>
					<input type = "text" id = "mob_num" name = "mob_num" value = "" class="element text medium" maxlength="200" style="width: 155px; height: 20px;text-align: right"></input>
				</div> 
			</div>	
		</td>
		</tr>
		
		<tr>
			<td align="left" colspan="4" style="width: 30%;">	
	 		<div id="li_4" style="width: 800px;margin-left: 0.9em">
				<label class="description" for="element_8" style="width: 170px;"><font size="3" face="arial">Requirement * </font></label>
			<div>
				<textarea name ="msg" id = "msg"  class="element textarea small" style="width: 600px;"></textarea>
			</div> 
		</div>
		</td>
	</tr>
		
</table>
<br/>
</div>		
</ul>
<br/><br />
		
	<div align = "center">
			<input type = "submit" id="sub" name="submit" value = "Submit" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff"/> 
	</div>
</form>
</div>
<%}else { %>
<img id="top" src="newimages/top.png" alt="" />
<div id="form_container">
	
		<h1 align="center">
		<table width="100%">
		<tr>
		<td>
		<a href="http://www.mobile-eye.in" target="_blank"><img src="images/mobile.jpg" style="height: 80px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
		</td><td style="vertical-align: bottom;text-align: center;margin-left: 2em;"><div style="text-align: center;"><a>Enquiry Form</a></div></td>
		<td style="vertical-align: bottom;text-align: right;"><font style="font-size: 0.5em;"><a href="http://www.mobile-eye.in" target="_blank">www.mobile-eye.in</a></font></td></tr>
		</table></h1>
		<br />
		<form id=""  name="" class="appnitro" enctype="multipart/form-data" method="post" action="" onsubmit = "">
					<div class="form_container1">
				</div>						
			<ul >
			<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
			<table border="0" width="100%" align="center">
			
		<tr>
	  		<td align="left" colspan="4" style="width: 30%;">	
	 		<div  style="width: 800px;margin-left: 0.9em">
				<div>
					<b>Thank you for enquiry.<br/> One sales person will contact you on <%=request.getParameter("mno") %> or <%= request.getParameter("email")%> soon.</b>
				</div> 
			</div>
		
		</td>
		</tr>	
</table>
<br/>
</div>		
</ul>
</form>
</div>
<%} %>
<script>document.getElementById("state").style.display="block";
document.getElementById("city").style.display="block";

document.getElementById("add_state").style.display="none";
document.getElementById("add_city").style.display="none";

</script>
</body></html>