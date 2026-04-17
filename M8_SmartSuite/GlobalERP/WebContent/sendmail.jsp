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
      max-width: 700px;
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
String Id=request.getParameter("Id");
String ContractorName=request.getParameter("ContractorName");
String entby=session.getAttribute("EmpEmail").toString();
String dropdown=request.getParameter("dropdown");
int a=0;
int i=0;

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
	%>
<div class="layout">
    <div id="EmailSidebar">
        <%@ include file="Emaildetails.jsp" %>
    </div>

    <!-- Main Content -->
    <div id="mainContent">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Send Mail</h5>
    </div>
   
 <div class="container">
    <div class="mail-box">
      <div class="mail-body">
        <p class="note" style="color:#830B2C;">
          Please ignore # from mail body , Please use # for new line in mail body , 
          Please use \\ for (apostrophe) in mail body ,
        </p>

        <form name="sendmail" method="post">
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">Template:</label>
            <div class="col-sm-10">
              <select class="form-select" name="dropdown" id="dropdown" onchange="formsubmitt();">
				 <%String tempvalue=request.getParameter("dropdown"); 
				   if(tempvalue ==null)
	               {
					   tempvalue="Select";
	                }%>
				<option value="Select" <%if(tempvalue.equalsIgnoreCase("Select")){%>Selected<%} %>>Select</option>
               <%

 String str="SELECT distinct(`Template`) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"EmailTemplate where Active='Yes'";
						ResultSet rst=st.executeQuery(str);
						while(rst.next())
						{
%>
		 <option value="<%=rst.getString("Template") %>" <%if(tempvalue.equalsIgnoreCase(rst.getString("Template"))){%>Selected<%} %>><%=rst.getString("Template") %></option>
<%
					} 	
%>
              </select>
            </div>
          </div>
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">To:</label>
            <div class="col-sm-10">
    <div class="border rounded p-2 bg-white" style="max-height: 200px; overflow-y: auto;">
            <% 	
String data="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+Id+"'"; 
ResultSet rs21=st2.executeQuery(data);
System.out.println("check-------->"+data);

while(rs21.next())
{
	Id=rs21.getString("ContractorId");
	String RecieverName=rs21.getString("ContractorName");

String sql1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+Id+"'";

//String  sql1="select * from t_recieverinfo where Transporter='"+transp+"' and ActiveStatus='Yes' ";
	ResultSet rst2=st1.executeQuery(sql1);

	if(rst2.next())
	{
		String Email=rst2.getString("ContractorOfficialEmail");
		//String RecieverName=rst2.getString("RecieverName");
		String PlaceName="Pune";
		String designation=rst2.getString("designation");
		%>
	 <div class="form-check mb-1">
          <input class="form-check-input" type="checkbox" name="cb<%=a%>" id="cb<%=a%>" value="cb<%=a%>" checked>
          <label class="form-check-label" for="cb<%=a%>">
            <%=Email%> (<%=RecieverName %>) 
            &nbsp;&nbsp; <span class="text-muted">(Location: <%=PlaceName%>)</span> 
            &nbsp;&nbsp; <span class="text-muted">(Designation: <%=designation%>)</span>
          </label>
          <input type="hidden" name="email<%=a%>" id="email<%=a%>" value="<%=Email%>">
          <input type="hidden" name="email1" id="email1" value="<%=Email%>">
        </div>
		 <%
		i++;a++;}}
	 %>
	 </div>
            </div>
          </div>
 <%
  int token=0;
  /* String sqlmaxno="select max(srno) as token from db_CustomerComplaints.t_emailmaster";
  ResultSet rsmaxno=stmt2.executeQuery(sqlmaxno);
  if(rsmaxno.next()){
  	token=rsmaxno.getInt("token");
  	token=token+1;
  } */
  String str1="SELECT Subject,Body,entby FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"EmailTemplate where Template='"+dropdown+"' order by UpdatedDateTime desc";
  System.out.println("str1"+str1);
  ResultSet rst1=st2.executeQuery(str1);
	
  if(rst1.next()){
	  System.out.println("str1 is------>>>>>>>>>" + str1);
	  System.out.println("Body is----->>>>>>>>>>>"+rst1.getString("Body"));
  
%>
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">Subject:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="description" id="description" type="text" cols="90" rows="1"><%=rst1.getString("Subject")%></textarea>
            </div>
          </div>

          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">From:</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="entby" id="entby" value="<%=entby%>" readonly>
            </div>
          </div>

          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">CC:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="CC" id="CC" cols="90" rows="1"></textarea>
            </div>
          </div>

          <div class="row mb-2">
            <label class="col-sm-2 col-form-label" id="label">Description:</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="body" id="body" cols="90" rows="10"><%=rst1.getString("Body")%></textarea>
            </div>
          </div>
  <%
  }
  %>
          <div class="text-center">
            <button type="submit" class="btn-send" onclick="redirect();">Send Mail</button>
          </div>
          
           <input name="cntr" id="cntr" type="hidden" value="<%=i %>">
           <input type="hidden" name="Id" id="Id" value="<%=Id%>" />	
            <input type="hidden" name="ContractorName" id="ContractorName" value="<%=ContractorName%>" />	
            <input type="hidden" name="template" id="template" value="<%=dropdown%>" />
        </form>
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