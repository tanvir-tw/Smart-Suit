 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*" import="java.util.Date"%>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>

<link href="cssnew/report.css" rel="stylesheet">

<!--  Fonts and icons -->
<link rel="stylesheet" href="fontawesome/css/all.min.css" >
      
<style>
   .btn.btn-danger.btn2 a {
    text-decoration: none; /* Remove underline */
    color: white; /* Set text color to white */
  }
  
  .btn.btn-danger.btn2 {
border:none;
    background-color:deepskyblue;
  }
  
    .container {
            margin-top: 1%;
              margin-bottom: 1%;
  
        }
        
.card {
            border:none;
        }
        
        h1 {
            text-align: center;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-family: 'Arial';
        }

   
        .btn {
    line-height: 1;
    Background-color:#1582AB;
    color:white;
        }
                /* General Styles for Input Fields */
.form-control {
    border: none;
    border-bottom: 2px solid #ccc;
    outline: none;
/*     padding: 10px 5px;
 */    margin-bottom: 10px;
    background-color: transparent;
    position: relative;
    font-size:12px;
}
 .form-control,.form-select{
                    font-size:12px;
        
        } 
/* Floating Label Styles */
.input-container {
    position: relative;
/*     margin-bottom: 20px;
 */}

.floating-label {
    position: absolute;
    top: 10px;
    left: 5px;
    font-size: 14px;
    color: #888;
    transition: all 0.3s ease;
}

.floating-input:focus + .floating-label,
.floating-input:not(:placeholder-shown) + .floating-label {
    top: -15px;
    left: 5px;
    font-size: 12px;
    color: #007bff;
}

/* Label Styles for Error Messages */
label[for] {
    display: block;
    font-size: 12px;
}

label[for] font {
    font-family: Arial;
    font-size: 12px;
    color: red;
}

.floating-input:focus {
    border-bottom: 2px solid #007bff; /* Blue border when focused */
}

.floating-input:invalid {
    border-bottom: 2px solid red; /* Red border for invalid inputs */
}

/* Focus Effects */
.floating-input:focus {
    outline: none;
    box-shadow: none;
}
        label{
        font-weight: bolder;
        font-size:12px;
        color:#007bff;
        }
        
        
        .input-group {
            position: relative;
        }
        .input-group-text {
            background-color: transparent;
            border: none;
            position: absolute;
            left: 1px;
            top: 39%;
            transform: translateY(-50%);
            z-index: 10;
        }
        .input-group .form-control {
            padding-left: 60px;
            padding-right: 35px;
        }
        .eye-icon {
            position: absolute;
            right: 10px;
            top: 39%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 10;
        }
    </style>

</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
 String mUsernameCP=session.getAttribute("user").toString();
String mPassword="",mcode="";

 // Connection Initialization
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<% if (request.getQueryString()!=null)
	{
		try
	    {
	        String sql="";
	        String sql1="";
	    	sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where username='"+mUsernameCP+"' limit 1";
	    	sql1="select * from UserMaster where username='"+mUsernameCP+"'";
	    	System.out.println(sql);
	    	ResultSet rs=st1.executeQuery(sql);
	        while (rs.next())
	        {
	        	mPassword=rs.getString("password");
	        	mcode=rs.getString("EmpCode");
	        }
	        System.out.println(" mUsernameCP >>"+mUsernameCP + " mPassword >>"+mPassword+" mcode>>"+mcode);
	        	
	    }
	    catch (Exception e)
	    {
	    e.printStackTrace();
	    }

	    String mOldpassword=request.getParameter("oldpassword").trim();
		String mNewpassword=request.getParameter("newpassword").trim();
		String mConfirmpassword=request.getParameter("confirmpassword").trim();
		
		System.out.println(".......old password+ "+mOldpassword+"... new password ..."+mNewpassword+" confirm password "+mConfirmpassword);
		System.out.println(".......old password... not matching ..."+mOldpassword+"-"+mPassword);
		if (!(mOldpassword.equals(mPassword.trim())))
		{
	    	System.out.println("old password... not matching ..."+mOldpassword+"-"+mPassword);
	    %>
	    	<script>
	    	alert("old password... not matching ...");
	    	location = "ChangePassword.jsp";
	    	//window.location.reload();
	    	</script>
	    	
	    <%
	    //response.sendRedirect("home.jsp");
		}
		else
		{
		%>
	    			<%
			System.out.println("new password... not matching with confirm password......"+mNewpassword+"-"+mConfirmpassword);
			if (!(mNewpassword.equals(mConfirmpassword)))
			{
				System.out.println("new password... not matching with confirm password......"+mNewpassword+"-"+mConfirmpassword);
				%>
		    	<script>alert("new password... not matching with confirm password......");
		    	location = "ChangePassword.jsp";
		    	</script>
		    	<%
		  //      response.sendRedirect("home.jsp");
			}
			else
			{
				if (mNewpassword==null || mConfirmpassword==null  || mNewpassword=="" || mConfirmpassword=="")
				{
					System.out.println("password should not be blank....");
					%>
			    	<script>alert("Password should not be blank...");
			    	location = "ChangePassword.jsp";
			    	//window.location.reload();
			    	</script>
			    	<%
			//    	response.sendRedirect("home.jsp");
				}
			    else
			    {
	    			try
            		{

            			String sql="";
            			String sql1="";
	            		sql="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"security set password='"+mNewpassword+"' where username='"+mUsernameCP+"' limit 1";
	            		sql1="UPDATE UserMaster set password='"+mNewpassword+"' where username='"+mUsernameCP+"' limit 1";
    	        		System.out.println(sql);
        	        	st2.executeUpdate(sql);
        	        	st3.executeUpdate(sql1);
        	        	System.out.println("password change sucessfully");
        	        	System.out.println(session.getAttribute("EmpCode"));
        	        	
        	        	if(session.getAttribute("department").equals("Marketing"))
        	        	{
        	        		System.out.println("IN IFFF   ");
        	        		String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster SET Password = '"+mNewpassword+"' WHERE MarketingRepCode ='"+mcode+"'	  LIMIT 1 ;";
        	        		System.out.println(sqlUpdate);
        	        		st4.executeUpdate(sqlUpdate);
        	        	}	
        	        	%>
    		    		<script>
    		    		alert("Password changed sucessfully.....");
    		    		location = "ChangePassword.jsp";
    		    		</script>
    		    		<%
    		           // response.sendRedirect("home.jsp");
            		}
            		catch (Exception e)
            		{
		            	e.printStackTrace();
		            //	 response.sendRedirect("home.jsp");
    	        	}
    			}
			}	
		}
	}

	if (request.getQueryString()==null)
	{
%>

<section class="container-fluid" id="main">
 <div class="row justify-content-center mt-3">
            <div class="card" style="max-width:400px;">
                <div class="card-body">
                <h5 class="content-header-title mb-0 text-center" style="color: #060637;">Change Password</h5>
           
                    <br>
                    <!-- Start card body -->
          <form>
          <div class="text-center mb-5">
            <img src="imagesnew/fingerprint.png" alt="Fingerprint icon" class="img-fluid" style="max-width: 100px;">
        </div>
        <div class="row justify-content-center mt-3">
        <div class="col-md-10">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user text-muted"></i></span>
                    <input type="text" id="username" name="username" class="form-control" value="<%=mUsernameCP%>" readonly>
                </div>
            </div>
            </div>
            </div>
           <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                    <input type="password" id="oldpassword" name="oldpassword" class="form-control" placeholder="Old Password" onclick="validate()">
                    <span class="eye-icon" onclick="togglePasswordVisibility('oldpassword')"><i class="fas fa-eye text-muted"></i></span>
                </div>
            </div>
            </div>
            </div>
           <div class="row justify-content-center mt-3">
        <div class="col-md-10">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                    <input type="password" id="newpassword" name="newpassword" class="form-control" placeholder="New Password">
                    <span class="eye-icon" onclick="togglePasswordVisibility('newpassword')"><i class="fas fa-eye text-muted"></i></span>
                </div>
            </div>
            </div>
            </div>
        <div class="row justify-content-center mt-3">
        <div class="col-md-10">
            <div class="form-group mb-4">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                    <input type="password" id="confirmpassword" name="confirmpassword" class="form-control" placeholder="Confirm New Password">
                    <span class="eye-icon" onclick="togglePasswordVisibility('confirmpassword')"><i class="fas fa-eye text-muted"></i></span>
                </div>
            </div>
            </div>
            </div>
                  <div class="d-grid gap-2 col-4 mx-auto mt-2">
        <button class="btn" id="submit" name="Submit" type="submit">Submit</button>
                 </div>        
              </form>
  <%
  }
  %>
                </div>
                <!-- End of card body -->
            </div>
    </div>
</section>

 <%@ include file="footer.jsp" %>
<script>
        function togglePasswordVisibility(id) {
            const input = document.getElementById(id);
            const icon = input.parentElement.querySelector('.eye-icon i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>