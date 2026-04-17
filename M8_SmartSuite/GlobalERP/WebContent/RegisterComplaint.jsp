<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*"
	import="moreservlets.listeners.*" errorPage=""%>
<%@ include file="headernew.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />

</head>
<body style="background-color: azure;">

<%
String ReportName="",Description="",Entby="",Name="",Email1="",FileName="",Category="";
String Priority="",ClosingComments="",ClosedBy="",Status="";
Date ComplaintDateTime,UpadteDateTime;
String ContactNumber="";

Connection con = null;
Statement st1 = null,st2=null,st3=null;

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();
	    st2=con.createStatement();
	    st3=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

%>
<%

String PageName1=this.getClass().getName();
 
PageName1=PageName1.substring(PageName1.lastIndexOf(".")+1,PageName1.length());
System.out.println(PageName1);
PageName1=PageName1.replace("_",".");
PageName1=PageName1.replace(".005f","_");
PageName1 = PageName1.replace(".0020"," ");
System.out.println("PageName   "+PageName1);
 sqlreport = "select ReportNo from t_reportnumber where PageName = '"+PageName1+"'";
 ResultSet rs = strno.executeQuery(sqlreport);
if(rs.next())
{
	reportno = rs.getString("ReportNo");
}
System.out.println("test--"+reportno);
/* if(request.getParameter("PageName").equalsIgnoreCase("RegisterComplaint.jsp")) */
	if("RegisterComplaint.jsp".equalsIgnoreCase(request.getParameter("PageName")))

{
%>	 
<%
}else{
	%>
	<div class="content-header-col-md-7-mt-10 col-12"> <!-- Added text-center class -->
	<%
}
try
{
  PageName="";
 String Msg=request.getParameter("Msg");
 System.out.println("******** " +Msg);
 String desc="";
 String EmailID="";
 String Number="";
 String category="";
 String priority="";
	if(Msg!=null && Msg.equalsIgnoreCase("1"))
	{
		  System.out.println("Msg "+Msg);
		     desc=request.getParameter("desc");
		     PageName=request.getParameter("PageName1");
		      EmailID=request.getParameter("email");
		      Number=request.getParameter("Number");
		      category=request.getParameter("Category");
		      priority=request.getParameter("Priority");
		   if(EmailID.equalsIgnoreCase("-"))
		   {
			   EmailID="";
		   }
		   System.out.println("Number "+Number);
		     System.out.println("desc "+desc);
		     System.out.println("PageName "+PageName);
		     System.out.println("EmailID "+EmailID);
		     
	     %>
	     <script type="text/javascript">
	     try{
	      alert("Error was occured while inserting the complaint. Please reattach your attachments and resubmit  your complaint.....");
	     }catch(e)
	     {
		     alert(e);
	     }
	     </script>
	     <%
	}
	else
	{
 PageName=request.getParameter("PageName");
 desc="";
 EmailID="";
	}
  ReportName="-";
 String fname=(String)session.getAttribute("EmpName");
 String email=(String)session.getAttribute("EmpEmail");
 
	String sql2="select * from db_GlobalERP.t_reportnumber where PageName='"+PageName+"'";
	ResultSet rs3=st2.executeQuery(sql2);
	if(rs3.next())
	{
		ReportName = rs3.getString("ReportName");
	}
	
    int counter=0;

	%>
<div class="container-fluid mt-2" id="main">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Complaint Registration Form</h5>
		    		</div>
		             <br>	
                    <form name="incident" id="incident" method="post" onsubmit="return validateform1();" action="ComplaintInsert.jsp" enctype="multipart/form-data">
                      <div class="card shadow-lg mb-4 rounded-3">
						  <div class="card-body">
						   <div class="row">
						   <div class="row col-12">
						   <div class="col-6">
                        	<div style="font-weight: bold;">
   						 		<%= fname %> </div></div>
   						 		
   						 		<div class="col-6">
   						 		<div style="text-align: right; font-weight: bold;">
  								<%= email %>
  								</div>
							</div>
</div>
	 					</div>
						 <div class="row">
      					<div class="row col-12 mt-3"> 
					
					<!--     <div class="col-4 mt-4">
					  <div class="form-floating">
					    <textarea class="form-control" placeholder="" id="description" name="description" style="height: 30px" required></textarea>
					    <label for="description">Description</label>
					  </div>
					</div> -->
		<div class="col-4 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input"  id="description" name="description" rows="1"required></textarea>
           <label for="description" class="floating-label">Description</label>
        	</div>
      </div>
				
                      
                        <div class="col-4 mt-4">
					        <div class="input-container">
					         <input class="form-control floating-input" type="text" id="uname" name="uname"value="<%=ReportName%>" placeholder="" required>
					          <label for="designation" class="floating-label">Report Name</label>
					       
					       		<input type="hidden" name="PageName" id="PageName" value="<%=PageName %>"/>
                                <input type="hidden" name="ReportName" id="ReportName" value="<%=ReportName %>"/>
					        </div>
					      </div>

                           <div class="col-4">
						        <div class="input-container">    
						        <label class="tcolor">Category</label>
						            <select class="form-select" id="Category" name="Category" required>
                                    <option value="Select">Select</option>
                                    <%
                                        try {
                                            String sqlcomplaint = "select * from db_gps.t_complaintcategory";
                                            ResultSet rsc = st3.executeQuery(sqlcomplaint);
                                            while(rsc.next()) {
                                    %>
                                                <option><%=rsc.getString("category") %></option>
                                    <% 
                                            }
                                        } catch(Exception e) {
                                            e.printStackTrace();
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
</div>
             
             </div>
             
       <div class="row">
      <div class="row col-12 mt-4">       
            <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Priority</label>
            <select class="form-select" id="Priority" name="Priority" required> 
                                    <option value="Select">Select</option>
                                    <option value="Low">Low</option>
                                    <option value="High">High</option>
                                </select>
                            </div>
		</div>
		<div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmailID" name="EmailID" 
                 placeholder="" required>
          <label for="EmailID" class="floating-label">Add Email Recipients</label>
          <font size="1.2" >Please enter comma separated email ids.</font>
        </div>
      </div>
<div class="col-md-4">
    <label class="form-label fw-bold d-block">Call me back</label>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="browser" id="browser" value="1" onclick="getradio();">
        <label class="form-check-label" for="browser">
            Yes
        </label>
    </div>
</div>
</div>
</div>
<div class="row">
      <div class="row col-12 mt-4">   

      <div class="col-4 mt-4" id="tr3" style="display: none;">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Number" name="Number" 
                 placeholder="" >
          <label for="EmailID" class="floating-label">Mobile Number</label>
           
        </div>
      </div>  
      
      
                     

                                <input type="hidden" name="counter" id="counter" value="<%=counter%>">
                                <input type="hidden" name="flagvalue" id="flagvalue" value="<%=counter%>">
                                <input type="hidden" id="Category1" value="<%=category %>">
                                <input type="hidden" id="priority1" value="<%=priority %>">
<div class="col-md-8">
						  <div class="col-md-3">
						     <label for="dropdown"><b>Attach File</b></label>
						     </div>
							<div class="col-md-12">			
							    <div id="fileInputs">						
        <div class="mb-2 d-flex align-items-center">
            <input type="file" name="files" class="form-control" >
            <button type="button" class="btn btn-danger btn-sm ms-2" onclick="clearFileInput(this)">Remove</button>
               <button type="button" class="btn btn-success btn-sm col-md-2 ms-2" onclick="addFileInput()" id="addFile">Add</button>
        </div>
    </div>

  <font size="1.2">You can attach a screenshot of the error page or a file related to this complaint.</font>
				</div>
						</div>
</div>

						</div>
                        <div class="text-center mt-4">
                            <button type="submit" id="button" name="button" class="btn btn-primary px-4">Submit</button>
                        </div>
                            </div>
                        </div>

                        <% if(Msg!=null && Msg.equalsIgnoreCase("1")) {
                            if(!(Number.equalsIgnoreCase("")) && !(Number.equalsIgnoreCase("-"))) { %>
                                <script>
                                    try {
                                        var elems = document.getElementsByName("browser");
                                        for(var i=0; i<elems.length; i++) {
                                            elems[i].checked = true;
                                        }
                                        document.getElementById("tr3").style.display = "";
                                        document.getElementById("Number").value = document.getElementById("Number2").value;
                                    } catch(e) {
                                        alert(e);
                                    }
                                </script>
                        <% } %>
                                <script>
                                    document.getElementById("Category").value = document.getElementById("Category1").value;
                                    document.getElementById("Priority").value = document.getElementById("priority1").value;
                                </script>
                        <% } %>

                    </form>
                    </div>
                    </div>
                    </div>
                    </div>
                    </section>
                    </div>
                    </div>
                    
              

<script>
    function addFileInput() {
        let fileInputs = document.querySelectorAll('#fileInputs .mb-2');
        if (fileInputs.length < 4) {
            let div = document.createElement('div');
            div.className = "mb-2 d-flex align-items-center";
            div.innerHTML = '<input type="file" name="files" class="form-control" >' +
                            '<button type="button" class="btn btn-danger btn-sm ms-2" onclick="clearFileInput(this)">Remove</button>';
            document.getElementById('fileInputs').appendChild(div);
        } else {
            alert('You can upload a maximum of 4 files.');
        }
    }

    function clearFileInput(button) {

        let input = button.parentElement.querySelector('input[type="file"]');
        input.value = ""; // clear selected file
        button.parentElement.remove();
    }
</script>

<%

}
catch(Exception e)
{
	e.printStackTrace();
}
 %>
 
 <script>
function validateEmail(email) {
    var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function validateform1() {
    try {
        var emailid = document.incident.EmailID.value.trim();
        var category = document.incident.Category.value.trim();
        var Priority = document.incident.Priority.value.trim();
     
 var desc = document.getElementById("description").value.trim();
    var number = "";
 var numField = document.getElementById("Number");
 if (numField) {
     number = numField.value.trim();
 }    
        if (!desc) {
            alert("Please enter the Description!");
            return false;
        }

        if(category == null || category== "Select"){
	alert("Please select Category");
	return false;
        }
        
        if(Priority == null || Priority== "Select"){
        	alert("Please select Priority");
        	return false;
                }
        
        if(emailid == null || emailid == ""){
        	alert("Please Enter Email id");
        	return false;
        }
        
        // Email validation
        if (emailid !== "") {
            let temp = emailid.split(",");
            for (let i = 0; i < temp.length; i++) {
                if (!validateEmail(temp[i].trim())) {
                    alert("Please enter valid Email Id(s).");
                    return false;
                }
            }
        }

        // If "Call me back" is checked, validate number
        var elems = document.getElementsByName("browser");
        for (var i = 0; i < elems.length; i++) {
            if (elems[i].checked === true) {
                if (number === "") {
                    alert("Please enter Number");
                    return false;
                }

                if (isNaN(number)) {
                    alert("Please enter Numeric Value");
                    return false;
                }

                if (number.length < 4 || number.length > 15) {
                    alert("Please enter valid Mobile Number");
                    return false;
                }
            }
        }

        return true;
    } catch (e) {
        console.error("Validation error:", e);
        return false;
    }
}



function getradio()
{
	var elems = document.getElementsByName("browser");
	for(var i=0;i<elems.length;i++)
	{
		if(elems[i].checked==true)
		{
			document.incident.Number.value="";
		       document.getElementById("tr3").style.display="";   
		}
		else
			if(elems[i].checked==false)
		{
				document.incident.Number.value="";
			       document.getElementById("tr3").style.display="none"; 
		}
	}
	
}


</script>
<script type="text/javascript">
function openpopup(PageName)
{
	try
	{
		testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"Register Complaint","width=700,height=400,scrollbars=yes");
	 	testwindow.moveTo(200,200);
	}
	catch(e)
	{
		alert(e);
	}
}
</script>
 <%@ include file="footer.jsp" %>	
 </body>
	</html>