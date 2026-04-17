<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
 
</head>
 <body style="background-color:azure;">
 
 <%
 String Ust=request.getParameter("UserTypeCode");
 String Ast=request.getParameter("AccessCode");

// Connection Initialization
Connection con = null;
Statement st1 = null,st2=null;

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();
	    st2=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

try{
%>
<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body" style="margin: 20px;">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit User Role</h5>
		    		</div>
		             <br>
<form name="AddNewUser" method="post" action="InsertAccessControl.jsp" onsubmit="return validate();">
<%
String sql="select * from db_GlobalERP.UserTypeMaster where UserTypeCode="+Ust+" and AccessCode="+Ast;
System.out.println("Sql->"+sql); 
ResultSet rs1 = st1.executeQuery(sql);
while(rs1.next())
{  
	String sql1="select * from db_GlobalERP.AccesControlList where AccessCode="+Ast;
	System.out.println("Sql->"+sql1); 
	ResultSet rs2 = st2.executeQuery(sql1);
	while(rs2.next())
	{  
%>
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
 <div class="row col-12 mt-3">
        <div class="col-4">
            <label class="tcolor"><h5><b>User Role :</b></h5></label>
            <input type="hidden" name="UserTypeCode"  id="UserTypeCode"  value="<%=Ust%>" />
            <input type="hidden" name="AccessCode"  id="AccessCode"  value="<%=Ast%>" />
            <input type="text" name="UACName"  id="UACName"  value=" <%=rs1.getString("UserType")%>" readonly="readonly"/>
            
        </div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="SuperAdmin" value="Yes" <%if(rs2.getString("SuperAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Super Admin Module</div>
        <div class="col-4"><input type="checkbox" name="Admin" value="Yes" <%if(rs2.getString("Admin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Admin</div>
        <div class="col-4"><input type="checkbox" name="Sales" value="Yes" <%if(rs2.getString("Sales").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Sales Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="Purchase" value="Yes" <%if(rs2.getString("Purchase").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Purchase Module</div>
        <div class="col-4"><input type="checkbox" name="Claim" value="Yes" <%if(rs2.getString("Claim").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Claim Module</div>
        <div class="col-4"><input type="checkbox" name="Account" value="Yes" <%if(rs2.getString("Account").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Account Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="Collection" value="Yes" <%if(rs2.getString("Collection").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Collection Module</div>
        <div class="col-4"><input type="checkbox" name="SalesAdmin" value="Yes" <%if(rs2.getString("SalesAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Sales Admin Module</div>
        <div class="col-4"><input type="checkbox" name="PurchaseAdmin" value="Yes" <%if(rs2.getString("PurchaseAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Purchase Admin Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="ClaimAdmin" value="Yes" <%if(rs2.getString("ClaimAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Claim Admin Module</div>
        <div class="col-4"><input type="checkbox" name="AccountAdmin" value="Yes" <%if(rs2.getString("AccountAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Account Admin Module</div>
        <div class="col-4"><input type="checkbox" name="CollectionAdmin" value="Yes" <%if(rs2.getString("CollectionAdmin").equalsIgnoreCase("Yes")){%>checked="checked"<%} %>> Collection Admin Module</div>
        
    </div>

    
    <div class="d-grid gap-2 col-4 mx-auto mt-5">
        <button class="btn btn-primary" type="submit">Submit</button>
    </div>
</div>
</div>
<%}
} %>
</form>     

</div>
</div>
</div>
</div>
</section>
</div>
</div>
 <%}catch(Exception e){
	 e.printStackTrace();
	 
 } %>   
<script>
function validate()
{
	
	var username=document.AddNewUser.UACName.value;
	if(username=="")
	{
	alert("Please Enter the Role");
     return false;
	}

	
}
</script>
<%@ include file="footer.jsp" %>
</body>
</html>