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
    
    <link href="cssnew/emailsidebar.css" rel="stylesheet"/>
    
     <style>
    .mail-box {
      background: #fff;
      border: 1px solid #ccc;
      margin: 20px auto;
      padding: 0;
      max-width: 800px;
      border-radius: 6px;
      box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
    }
    .mail-body {
      padding: 15px 15px 15px 25px;
      background: #F5F5F5; /* light gray inside */
    }
    .note {
      font-size: 0.7rem;
      color: #6c757d;
      margin-bottom: 15px;
    }
    form, .form-control{
    font-size:0.8rem;
    }
    .form-label {
      font-weight: 500;
      color: #333;
    }
    .form-select{
        font-size:0.8rem;
    
    }
    textarea {
      resize: vertical;
      min-height: 150px;
    }
    .btn-send {
      background: #1582AB; /* primary blue */
      color: #fff;
      font-weight: 500;
      padding: 8px 25px;
      border-radius: 4px;
      border: none;
    }
    .btn-send:hover {
      background: #126c8c;
    }
        #label{
        border: 1px solid #ccc;
    background-color: white;
    border-radius: 10px;
    text-align:center;
    font-weight:600;
    height:fit-content;
    }
  </style>
</head>
 <body>
<%
// Variable Declaration
String Id="",ContractorName="",tid="",fromid="",toid="",subject="",insertdatetimed="";
String mydate="",mytime="",finaldate="",insertdatetime="",body="",ccid="";

 // Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
	 Id=request.getParameter("Id");
	 ContractorName=request.getParameter("ContractorName");
	 tid=request.getParameter("tid"); 
	 fromid=request.getParameter("fromid");
	 toid=request.getParameter("toid");
	 subject=request.getParameter("subject");

	 insertdatetimed = request.getParameter("insertdatetime");
    String xydate[]= insertdatetimed.split("\\s+");
   mydate = xydate[0];
    mytime = xydate[1];
	 finaldate = new SimpleDateFormat( "yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(mydate));
    insertdatetime = finaldate+" "+mytime;

	String sqle ="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where fromid='"+fromid+"' and toid='"+toid+"' and subject='"+subject+"' and entrydatetime='"+insertdatetime+"' ";
    System.out.println("Query NOW IS--->>"+ sqle);
	ResultSet rsProfileDetails=st.executeQuery(sqle);

	while (rsProfileDetails.next())
	{
	body =rsProfileDetails.getString("body");
	ccid = rsProfileDetails.getString("Tocc");
	}
	%>

<div class="layout">

    <!-- Main Content -->
    <div id="mainContent">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Mail Description</h5>
    </div>
   
 <div class="container">
    <div class="mail-box">
      <div class="mail-body">
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">From:</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="entby" id="entby" value="<%=fromid%>" readonly style="background-color:white;">
            </div>
          </div>

          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">Subject:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="description" id="description" cols="90" rows="1" readonly style="background-color:white;"><%=subject%></textarea>
            </div>
          </div>

          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">To:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="To" id="To" cols="90" rows="1" readonly style="background-color:white;"><%=toid%></textarea>
            </div>
          </div>
          
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">CC:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="CC" id="CC" cols="90" rows="1" readonly style="background-color:white;"><%=ccid%></textarea>
            </div>
          </div>
          
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">DateTime:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="CC" id="CC" cols="90" rows="1" readonly style="background-color:white;"><%=insertdatetimed%></textarea>
            </div>
          </div>

          <div class="row mb-2">
            <label class="col-sm-2 col-form-label" id="label">Description:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="body" id="body" cols="90" rows="10" readonly style="background-color:white;"><%=body%></textarea>
            </div>
          </div>

      </div>
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
function formsubmitt()
{
//alert("in formsubmit");	
	var dropdown=document.sendmail.dropdown.value;
	
	if(!(dropdown=="Select"))
	{	
		document.sendmail.submit();
	}

}
function redirect()
{
	var template= document.getElementById("dropdown").value.trim();
	if(template=="Select"){
		alert("Please select Template!!");
		return false;
	}
	
	var templatefinal=document.getElementById("description").value.trim();
	if(templatefinal=="" || templatefinal==null){
		alert("Please enter Subject!!");
		return false;
	}
	
	var docbody=document.getElementById("body").value.trim();
	if(docbody=="" || docbody==null){
		alert("Please enter text in body !!");
		return false;
	}
	
	var body=document.sendmail.body.value;
	var index=body.indexOf("__");
	if(index>=0){
			alert("Please insert details instead of __");
			return false;
		}
//	document.sendmail.action="insertSendMail.jsp";
//	document.sendmail.submit();
	var transporter=document.sendmail.ContractorName.value;
	var cntr=document.sendmail.cntr.value;

	cntr=cntr-1;
//var url="insertSendMail.jsp?ContractorName="+document.getElementById("ContractorName").value+"&Id="+document.getElementById("Id").value+"&email="+document.getElementById("email1").value+"&body="+document.getElementById("body").value;
	//var url="insertSendMail.jsp?ContractorName="+document.getElementById("ContractorName").value+"&Id="+document.getElementById("Id").value;
var url="insertSendMail.jsp?ContractorName="+document.getElementById("ContractorName").value+"&Id="+document.getElementById("Id").value+"&email="+document.getElementById("email1").value;
//url=url+"&description="+document.getElementById("description").value+"&body="+document.getElementById("body").value;
var i=0;
var flag="false";
   	for(var j=0;j<=cntr;j++)
    	{	
    		//alert(document.getElementById("cb"+j).checked);
    		if(document.getElementById("cb"+j).checked==true)
    		{
    			//alert("unitid"+document.getElementById("unitid").value);
            	 url=url+"&emailid"+i+"="+document.getElementById("email"+j).value;
				 i++;
				flag="true";
    		}		
    	}
        if(flag=="false"){
			alert("Please select TO mail ids");
			return false;
        }//write function to check no of check boxes get value //
        document.sendmail.action=url+"&cntr="+i;
       // alert(document.sendmail.action);
        document.sendmail.submit();
	
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>