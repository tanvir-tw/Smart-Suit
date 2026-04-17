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
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
if((element_3_1.value==0))
	{
	displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
	displaycount+='1,';
	}
if((element_3_3.value==0))
{
    displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
    displaycount+='3,';
}else{
	count3+='3,';
}
if((element_3_8.value==0))
{
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='8,';
}
// Mandatorytransworld
// alphatransworld
if(!(element_3_1.value==0))
{ 
var letters = /^[A-Za-z . /]+$/;
if(element_3_1.value.match(letters))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='1,';
}
}if(!(element_3_2.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_2.value.match(letters))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='2,';
}
}if(!(element_3_4.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_4.value.match(letters))
{
count3+='4,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='4,';
}
}if(!(element_3_5.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_5.value.match(letters))
{
count3+='5,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='5,';
}
}if(!(element_3_6.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_6.value.match(letters))
{
count3+='6,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='6,';
}
}// charactertransworld
if(!(element_3_7.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_7.value.match(numbers))
{
count3+='7,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='7,';
}
}if(!(element_3_9.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_9.value.match(numbers))
{
count3+='9,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='9,';
}
}if(!(element_3_10.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_10.value.match(numbers))
{
count3+='10,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='10,';
}
}


if(!(element_3_14.value==0))
{
var numbers1 = /^[0-9]+$/;
if(element_3_14.value.match(numbers1))
{
count3+='14,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='14,';
}
}

if(!(element_3_15.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_15.value.match(numbers))
{
count3+='15,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='15,';
}
}


if(!(element_3_11.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_11.value.match(numbers))
{
count3+='11,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='11,';
}
}// numbertransworld
if(!(element_3_8.value==0))
{ 
var mailformat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_8.value.match(mailformat))
{
count3+='8,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='8,';
}
}// emailtransworld

if(!(element_3_12.value==0))
{ 
var mailformat1 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_12.value.match(mailformat1))
{
count3+='12,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='12,';
}
}// emailtransworld


if(!(element_3_13.value==0))
{ 
var mailformat2 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_13.value.match(mailformat2))
{
count3+='13,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='13,';
}
}// emailtransworld

if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
}


</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null,st=null,st1=null,st2=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
%>
<%@ include file="header.jsp"%> 
<form name="userform" action="editcontactinsert.jsp" method="post" onsubmit="return formValidation();">
<%
String sql1="";
String type=request.getParameter("Type");
String isclose=request.getParameter("isclose");
String Comid=session.getAttribute("CompanyMasterID").toString();
String Type=request.getParameter("Type");
String SalesCustomerCode=request.getParameter("customercode");
String CustomerCode=request.getParameter("customercode");
String CompanyName1=request.getParameter("companyname");
String contact_id=request.getParameter("contact_id");
System.out.println("contact_id    -------------- query---->>"+contact_id);

String nm="",nm1="",nm2="",nm3="",nm4="",nm5="",nm6="",nm7="",nm8="",nm9="",nm10="",nm11="",nm12="",nm13="",nm14="";
System.out.println("Details---------"+Comid+"----------Type:--"+Type+"---------Slaes"+SalesCustomerCode+"Custcode"+CustomerCode+"contact_id"+contact_id);

        if(Type.equals("Customer") )
        {
			String code="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where companyname='"+request.getParameter("companyname")+"'";
			ResultSet rs5=st2.executeQuery(code);
			rs5.next();
			
        	sql1="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode="+rs5.getString("salescustomercode")+" order by contactperson";				
            System.out.println("customer query---->>"+sql1);
            %>
            
            <input type="hidden" name="customercode" value="<%=rs5.getString("salescustomercode") %>" />
            <%
        }
        else
        {
        	 sql1="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode="+request.getParameter("customercode")+" order by contactperson";				
            System.out.println("customer query---->>"+sql1);
            
            %>
            
            <input type="hidden" name="customercode" value="<%=request.getParameter("customercode") %>" />
            <%
        }
        ResultSet rs1= st.executeQuery(sql1);
        while(rs1.next())
        {
        	nm=rs1.getString("contactperson");
        	nm1=rs1.getString("designation");
        	nm2=rs1.getString("Address");
        	nm3=rs1.getString("country");
        	nm4=rs1.getString("state");
        	nm5=rs1.getString("city");
        	nm6=rs1.getString("zipcode");
        	nm7=rs1.getString("email");
        	nm8=rs1.getString("phone");
        	nm9=rs1.getString("Email1");
        	nm10=rs1.getString("Email2");
        	nm11=rs1.getString("mobileno");
        	nm12=rs1.getString("fax");
        	nm13=rs1.getString("mobileno1");
        	nm14=rs1.getString("mobileno2");
        	
        }
        System.out.println("customer query---->>nmnmnmm"+nm);
        System.out.println("designation query---->>nmnmnmm"+nm1);
        System.out.println("Address query---->>nmnmnmm"+nm2);
        System.out.println("country query---->>nmnmnmm"+nm3);
        System.out.println("state query---->>nmnmnmm"+nm4);
        System.out.println("city query---->>nmnmnmm"+nm5);
        System.out.println("zipcode query---->>nmnmnmm"+nm6);
        System.out.println("email query---->>nmnmnmm"+nm7);
        System.out.println("phone query---->>nmnmnmm"+nm8);
        System.out.println("Email1 query---->>nmnmnmm"+nm9);
        System.out.println("Email2 query---->>nmnmnmm"+nm10);
        System.out.println("mobileno query---->>nmnmnmm"+nm11);
        System.out.println("fax query---->>nmnmnmm"+nm12);
        System.out.println("mobileno1 query---->>nmnmnmm"+nm13);
        System.out.println("mob 2   query---->>nmnmnmm"+nm14);
        
        
        String company=request.getParameter("companyname");
        company=company.replace("...","&");
        %>

<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Edit Contact For <%=company %></b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>

<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Contact Person :</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text" value="<%=request.getParameter("contactperson") %>" /><br><label id="element_error_1"></label><br><br><br><!--1,1-->

</td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Designation :</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value="<%=request.getParameter("designation") %>"/><br><label id="element_error_2"></label><br><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Address :</b> </label><textarea id="element_3_3" name="element_3_3"  class="element textarea medium"/><%=request.getParameter("Address") %></textarea><br><label id="element_error_3"></label><br></td>
<td><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Country :</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=request.getParameter("country") %>" /><br><label id="element_error_4"></label><br><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>State :</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=request.getParameter("state") %>"/><br><label id="element_error_5"></label><br><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>City :</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value="<%=request.getParameter("city") %>"  /><br><label id="element_error_6"></label><br><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Zip Code :</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value="<%=request.getParameter("zipcode") %>" /><br><label id="element_error_7"></label><br><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Email1 :</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value="<%=request.getParameter("email") %>" /><br><label id="element_error_8"></label><br><br><br><!--5,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Phone Number :</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text"  value="<%=nm8%>"/><br><label id="element_error_9"></label><br><br><br><!--5,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red"></font>Email2 :</b> </label><input id="element_3_12" name="element_3_12"  class="element text medium" type="text"  value="<%=request.getParameter("Email1") %>" /><br><label id="element_error_12"></label><br><br><br><!--5,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red"></font>Email3 :</b> </label><input id="element_3_13" name="element_3_13"  class="element text medium" type="text"  value="<%=request.getParameter("Email2") %>" /><br><label id="element_error_13"></label><br><br><br><!--5,1--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Mobile Number1 :</b> </label><input id="element_3_10" name="element_3_10"  class="element text medium" type="text"  value="<%=request.getParameter("mobileno") %>" /><br><label id="element_error_10"></label><br><br><br><!--6,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Fax Number :</b> </label><input id="element_3_11" name="element_3_11"  class="element text medium" type="text"  value="<%=request.getParameter("fax") %>" /><br><label id="element_error_11"></label><br><br><br><!--6,2-->
<input type="hidden" name="entryflag" value="ADD" />
				
				<input type="hidden" name="companyname" value="<%=request.getParameter("companyname") %>" />
				<input type="hidden" name="contact_id" value="<%=request.getParameter("contact_id")%>" />
				<input type="hidden" name="currentrow" value="0" />
				<input type="hidden" name="CustOfType" value="<%=request.getParameter("Type")%>" />
				<input type="hidden" value="<%=isclose%>" name="isclose" />
</td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Mobile Number2 :</b> </label><input id="element_3_14" name="element_3_14"  class="element text medium" type="text"  value="<%=request.getParameter("mobileno1") %>" /><br><label id="element_error_14"></label><br><br><br><!--6,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Mobile Number3 :</b> </label><input id="element_3_15" name="element_3_15"  class="element text medium" type="text"  value="<%=request.getParameter("mobileno2") %>" /><br><label id="element_error_15"></label><br><br><br><!--6,1--></td>
</tr>

</table>
<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /><br></div>
</form>
</jsp:useBean>
<%@ include file="footer_new.jsp" %>