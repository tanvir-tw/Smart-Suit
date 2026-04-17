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
    <link rel="stylesheet" href="cssnew/newentryform.css" />
</head>
 <body style="background-color:azure;">

<%
Connection conn=null;
 	String save=request.getParameter("msg");
 	System.out.println(" msg is "+save);
%>
<% 
try {
	conn = connection.getConnect("db_GlobalERP");    
      	
} catch (Exception e) {
    e.printStackTrace();
} 
%>	 
 <% 	 
 		if(save!=null)
{
	%>
	<script type="text/javascript">
	alert("Prospect Merged Successfully");
	window.location="Mergeprocpect.jsp";
	
	</script>
	<%
} 
 		 %> 
	<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;border: none; box-shadow: none;" >
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Merge Prospect</h5>
		    		</div>
		             <br>

      <form id="mergeprocpect" action="AjaxMergeProspect.jsp" method="get" onsubmit="return mychkbx();">

<div class="card shadow-lg mb-4 rounded-3">
<div class="card-body">

<!-- SEARCH PROSPECT -->
<div class="row mt-3">
<div class="col-md-6">

<div class="input-container">
    <input type="text" class="form-control floating-input" name="companyNames"
           id="companyNames"
           autocomplete="off" onkeyup="timer()" placeholder=""/>
    <label for="companyNames" class="floating-label">Search Prospect</label>
</div>

<div id="comlist" style="display:none; margin-top:5px;">
    <div id="companyList" style="
        background-color: #fff;
        max-height: 150px; overflow-y: auto;border: 1px solid #ccc; width: 100%;"></div>

    <input type="hidden" name="counter" id="counter" value="10"/>
</div>

</div>

<div class="col-md-6">

<div class="input-container">
    <input type="text"
           class="form-control floating-input"
           name="mergename"
           id="mergename"
           autocomplete="off"
           onkeyup="timer1()"
           placeholder=""/>
    <label for="mergename" class="floating-label">Merge To</label>
</div>

<div id="comlist1" style="display:none; margin-top:5px;">
    <div id="companyList1" style="
        background-color: #fff;
        max-height: 150px;
        overflow-y: auto;
        border: 1px solid #ccc;
        width: 100%;
    "></div>

    <input type="hidden" name="counter1" id="counter1" value="10"/>
</div>

</div>
</div>

 <!-- REASON + BUTTON (FIXED ALIGNMENT) -->
<div class="row mt-3 mb-3">
  <div class="col-md-12">

    <label class="tcolor mb-1">Reason for Merging</label>

    <div class="d-flex align-items-center">

        <!-- DROPDOWN -->
        <select name="comment"
                id="comment"
                class="form-select"
                onChange="showother();"
                style="max-width:240px;">

            <option value="Select">--Select--</option>

            <%
                String sqlR = "select Reason from db_GlobalERP."
                            + session.getAttribute("CompanyMasterID").toString()
                            + "ReasonForMerge where Category='Prospect'";
                ResultSet rs = st.executeQuery(sqlR);
                while (rs.next()) {
            %>
                <option value="<%=rs.getString("Reason")%>">
                    <%=rs.getString("Reason")%>
                </option>
            <% } %>

            <option value="Other">Other</option>
        </select>

        <!-- OTHER INPUT (INLINE) -->
        <div class="input-container ms-3 mt-2"
             id="other"
             style="display:none; width:230px;">

            <input type="text"
                   name="other"
                   class="form-control floating-input"
                   autocomplete="off"/>

            <label class="floating-label"></label>
        </div>

        <!-- BUTTON (INLINE WITH SAFE SPACING) -->
    </div>
  </div>
  
  <div class="d-grid gap-2 col-3 mx-auto mt-3">
     <button type="submit"  class="btn btn-primary ms-5" style="width:120px;"> Merge</button>
    </div>
</div>
<input type="hidden" id="save" name="save" value="" />
<input type="hidden" id="companyCode" name="companyCode" value="" />

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

<script type="text/javascript">
function timer()
{
	setTimeout("getCompanies()", 2000);
}
function timer1()
{
	setTimeout("getCompanies1()", 2000);
}
function getCompanies(prospect)
{
	try{
		document.getElementById("comlist").style.display="";
	    document.getElementById("companyList").style.visibility="visible";
		var company=document.getElementById("companyNames").value;
		 var counter=document.getElementById("counter").value;
	}catch(e)
	{
		alert(e);
	}
		if(counter>100)
		{
			counter=0;
		}
		var ajaxRequest;  // The variable that makes Ajax possible!
		try
		{
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					alert("Your browser broke!");
					return false;
				}
			}
		}
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				document.getElementById("companyList").innerHTML=reslt;
				var b=document.getElementById("element").value;
				document.mergeprocpect.counter.value=b;
				document.mergeprocpect.counter.value=b*document.mergeprocpect.counter.value;
				counter=document.mergeprocpect.counter.value;
			} 
		}
		var queryString = "?company=" +company+"&limitcount="+counter+"";
		ajaxRequest.open("GET", "Ajaxmerge.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
}
function getCompanies1(prospect)
{
	try{
		document.getElementById("comlist1").style.display="";
	    document.getElementById("companyList1").style.visibility="visible";
		var company=document.getElementById("mergename").value;
		 var counter=document.getElementById("counter1").value;
	}catch(e)
	{
		alert(e);
	}
		if(counter>100)
		{
			counter=0;
		}
		var ajaxRequest;  // The variable that makes Ajax possible!
		try
		{
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					alert("Your browser broke!");
					return false;
				}
			}
		}
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				document.getElementById("companyList1").innerHTML=reslt;
				var b=document.getElementById("element").value;
				document.mergeprocpect.counter1.value=b;
				document.mergeprocpect.counter1.value=b*document.mergeprocpect.counter1.value;
				counter=document.mergeprocpect.counter1.value;
			} 
		}
		var queryString = "?company=" +company+"&limitcount="+counter+"";
		ajaxRequest.open("GET", "Ajaxmerge1.jsp" + queryString, true);
		ajaxRequest.send(null); 		
}
function getCustomerDetails1(i) 
{   
	document.getElementById("companyList1").style.visibility="hidden";
	document.getElementById("comlist1").style.display="none";
    document.getElementById("mergename").value=document.getElementById("PName"+i).value;
	document.getElementById("companyCode").value=document.getElementById("PCode"+i).value;

}
function mychkbx()
{
	var mainname=document.getElementById("mergename").value;
	var maincode=document.getElementById("companyCode").value;
	var othmergeto=mainname.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	var comment=document.getElementById("comment").value;
	var other=document.getElementById("other").value;
	var oth=other.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
var a="";
try{
if(mainname=="" || othmergeto=="")
	
{
	alert("Select proper merging prospect name");
	return false;
}

else{ 
	var k1= document.getElementById("item1").value;
  for ( var i = 1; i < k1; i++ ) 
		  {	
		 
		  if ( document.getElementById("ab"+i).checked==true)
	 		{

			if(i==1)
			{
				a=document.getElementById("ab"+i).value;
			}else{
         	a=a+"/"+document.getElementById("ab"+i).value;
			}	

			  
		  }
		  }
}
}catch(e)
{
	//alert(e);
}
if(a=="")
{
	alert("Please select prospect for merging");
	return false;
}
else if(comment=="Select")
{
	   alert("Please Select Reason");
		return false;		   
}
else if(comment=="Other" && (other=="" || oth==""))
{
    alert("Please Enter Other Reason");
	  	return false;   
}
else{	 
	document.getElementById("save").value=a;
}    
}  
function showother()
{
	var SelValue1=document.getElementById("comment").value;
        if(SelValue1=="Other")
        {
        	document.getElementById("other").style.display="";          
        }
        else 
       {
        	document.getElementById("other").style.display='none';         
       }
}
</script>
<%@ include file="footer.jsp" %>
 </body>
</html>