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
 
// Connection Initialization
Connection con = null;
Statement st1 = null;

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();


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
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New User Role</h5>
		    		</div>
		             <br>
<form name="AddNewUser" method="post" action="InsertAccessControl.jsp" onsubmit="return validate();">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
 <div class="row col-12 mt-3">
        <div class="col-4">
            <label class="tcolor"><h5><b>New Role :</b></h5></label>
            <input class="form-control" type="text" id="user_role" name="user_role" required>
        </div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="SuperAdmin" value="Yes"> Super Admin Module</div>
        <div class="col-4"><input type="checkbox" name="Admin" value="Yes"> Admin</div>
        <div class="col-4"><input type="checkbox" name="Sales" value="Yes"> Sales Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="Purchase" value="Yes"> Purchase Module</div>
        <div class="col-4"><input type="checkbox" name="Claim" value="Yes"> Claim Module</div>
        <div class="col-4"><input type="checkbox" name="Account" value="Yes"> Account Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="Collection" value="Yes"> Collection Module</div>
        <div class="col-4"><input type="checkbox" name="SalesAdmin" value="Yes"> Sales Admin Module</div>
        <div class="col-4"><input type="checkbox" name="PurchaseAdmin" value="Yes"> Purchase Admin Module</div>
    </div>
    
    <div class="row col-12 mt-3">
        <div class="col-4"><input type="checkbox" name="ClaimAdmin" value="Yes"> Claim Admin Module</div>
        <div class="col-4"><input type="checkbox" name="AccountAdmin" value="Yes"> Account Admin Module</div>
        <div class="col-4"><input type="checkbox" name="CollectionAdmin" value="Yes"> Collection Admin Module</div>
        
    </div>

    
    <div class="d-grid gap-2 col-4 mx-auto mt-5">
        <button class="btn btn-primary" type="submit">Submit</button>
    </div>
</div>
</div>
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