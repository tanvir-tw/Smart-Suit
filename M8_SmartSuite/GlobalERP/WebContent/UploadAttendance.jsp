 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">
<%
 // Connection Initialization
Connection conn = null;
Statement st1=null;

try {

	conn = connection.getConnect("dotproject");    
	st1 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>
<%
try{
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Upload Attendance</h5>
    </div>
</div>
<div class="container my-5 d-flex justify-content-center">
  <div class="card shadow-sm" style="max-width: 600px; width: 100%;">
    <div class="card-body">
      <form name="uploadTask" method="post" enctype="multipart/form-data" onsubmit="return confirmSubmit()" action="UploadAttendancetInsert.jsp">


      <div class="row mb-3 align-items-center">
  <label for="file" class="col-sm-4 col-form-label fw-bold small text-end">
    Browse CSV File:
  </label>
  <div class="col-sm-6">
    <input class="form-control form-control-sm" type="file" name="file" id="file">
  </div>
</div>

          <div class="text-center mt-4">
                <button type="submit" name="uploadexl" id="uploadexl" class="btn btn-primary btn-sm px-4" style="background-color:#1582AB;">Submit</button>
         </div>
      </form>
    </div>
    <div class="card-footer">
      <%
        String msg = request.getParameter("msg");
        System.out.println("The msg is :" + msg);
        if (msg != null) {
      %>
        <div class="alert alert-success text-center mb-0 py-1" role="alert">
          File Uploaded Successfully
        </div>
      <% } else { %>
        <div class="alert alert-warning text-center mb-0 py-1" role="alert">
          Please Upload Only <strong>.csv</strong> Format Files.
        </div>
      <% } %>
    </div>
  </div>
</div>
</div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
<script>
function confirmSubmit()
{

	
	var fup = uploadTask.file.value;
	var ext = fup.substring(fup.lastIndexOf('.') + 1);

//alert(">>"+fup+">>>>"+ext);
    if(ext =="csv")
    {
      // return true;
    }
    else
    {
        alert("Upload csv file only");
        return false;
    }
	
var agree=confirm("Are you sure you wish submit this Attendance List?");
if (agree)
	return true ;
else
	return false ;
}
</script>
<%@ include file="footer.jsp" %>
</body>
</html>