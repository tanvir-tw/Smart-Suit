<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
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
String fromDateCal="",companyName="",phone="",contact="",email="",product="",city="";
int itr=1;
Connection conn = null;
	Statement st1=null;
	
	try {
	
		conn = connection.getConnect("db_GlobalERP");    
		st1 = conn.createStatement();
	   
	} catch (Exception e) {
	    e.printStackTrace();
	} 

%>
<%
		Date today = new Date();
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
 		
 		String sqlCreateTmpTable="" +
    			"	CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") + " ( " +
				" srno INT(10) NOT NULL, " +
				" TheGroup VARCHAR(50) NULL, " +
				" make VARCHAR(50) NULL, " +
				" model VARCHAR(50) NULL, " +
				" partno VARCHAR(50) NULL, " +
				" description VARCHAR(255)	NULL, " +
				" quantity VARCHAR(50) NULL,  " +
				" modelNotKnown boolean NULL  " +
				");";
				st.executeUpdate(sqlCreateTmpTable);
				System.out.println(sqlCreateTmpTable);
%>

<div class="container-fluid mt-2" id="main">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
     
            <div class="card" style="background-color: transparent;">
              
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Sales Enquiry Form</h5>
		          		<div style="text-align: right">
<a href="AllSalesModule.jsp" style="font-weight: bold;text-decoration: none;">GO TO SALES MENU</a>
</div>
		    		</div>
		             <br>


<form name="ledgerDetails" action="insertSalesEnq.jsp" onsubmit="return validate();" method="post" autocomplete="off">
 <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
      <div class="row col-12 mt-4"> 
      <div class="col-4 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="companyNames" name="companyNames" onkeyup="getCompanies()" placeholder="">
          	<label for="companyNames" class="floating-label">Customer Name</label>
          	<input type="hidden" name='comp1' id='comp1'/>
          	<input type="hidden" name="status" id="status" value="" />
        </div>

      </div>
       <div class="col-4 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="customerRefNumber" name="customerRefNumber" value="-"  placeholder="">
          	<label for="companyNames" class="floating-label">Cust Ref No</label>
        </div>
      </div>
        <div class="col-4 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="fromdate" name="fromdate" value="<%=fromDateCal %>"  placeholder="" readonly>
          	<label for="fromdate" class="floating-label">Due Date</label>
          	<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
    		  );
	  		 </script>
        </div>
        
      </div>
  		 <div id='companyList' style="background: white;">
				<div style="width: 150px; overflow: auto;">
							<table style="display: none; background: black;">
							</table>
				</div>
		</div>
      
    </div>
     <div class="row col-12 mt-4"> 
		<div class="col-3 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input" id="remarks" name="remarks" rows="1"></textarea>
           <label for="reason" class="floating-label">Remarks</label>
        	</div>
      </div>		
<div class="col-2 mt-4">
  	<div class="d-flex align-items-center">
    <a href="#" onclick="popup('SalesEnquiryEntry.jsp');" class="me-2" style="font-weight: bold; color: blue; text-decoration: none;">(+)</a>
    <label for="newentry" class="mb-0 fw-bold text-primary">New Entry</label>
  </div>
</div>
<div class="col-4 mt-4">
  <div class="d-flex align-items-center">
   <a href="#"  onmousemove ="viewvisitingcard()" onmouseout="disablevisitingcard()" style="color: blue; text-decoration: none;">View Contact Details</a>
  </div>
</div>

  <div class="row col-12" id="visitingCard" style="height: 10px;"> 
        <div class="col-2 mt-4">
        <div class="input-container" id="companyName">
       		<input class="form-control floating-input" type="text" id="companyName" name="companyName" value="<%=companyName %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">Company</label>
        </div>
      </div>
       <div class="col-2 mt-4">
        <div class="input-container" id="companyPerson">
       		<input class="form-control floating-input" type="text" id="companyPerson" name="companyPerson" value="<%=contact %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">Contact</label>
        </div>
      </div>
       <div class="col-2 mt-4">
        <div class="input-container" id="Phone">
       		<input class="form-control floating-input" type="text" id="companyPhone" name="companyPhone" value="<%=phone %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">Phone</label>
        </div>
      </div> 
       <div class="col-2 mt-4">
        <div class="input-container" id="companyEmail">
       		<input class="form-control floating-input" type="text" id="companyEmail" name="companyEmail" value="<%=email %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">E-Mail</label>
        </div>
      </div>
       <div class="col-2 mt-4">
        <div class="input-container" id="companyProduct">
       		<input class="form-control floating-input" type="text" id="companyProduct" name="companyProduct" value="<%=product %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">Product</label>
        </div>
      </div>   
      <div class="col-2 mt-4">
        <div class="input-container" id="companyCity">
       		<input class="form-control floating-input" type="text" id="companyCity" name="companyCity" value="<%=city %>"  placeholder="" readonly> 
          	<label for="companyNames" class="floating-label">City</label>
        </div>
      </div>   
               
  </div>
    
   </div>
   
    <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="submit" type="submit">Save Enquiry</button>
  </div>
   </div>
 </div>  
  	<input type="hidden" id='text' value='<%=itr%>'></input>
   <input type="hidden" name="CustCode" id="CustCode" value="" />
   
           				<div id="companyList">
							<div style="height: 10px; width: 150px; overflow: auto;">
							<table style="display: none;">
							</table>
							</div>
						</div>
</form>



<script>document.getElementById("visitingCard").style.visibility="hidden";</script>
<script>document.getElementById("companyList").style.visibility="hidden";</script>
</div>
</section>

<div class="container" style="width:80%">
		<table id="example" class="display" style="width:100%">	
		<%
			String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=st1.executeQuery(sqllbl);
			System.out.println(">>>>>>>>SqlTmp:"+sqllbl);
		%>
		<thead>
		<tr>
		<th style="width: 125px;">   <a href="#" onclick="checkAll()"> <font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a>
		     <a href="#" onclick="unCheckAll()"> <font color="white">UnChk all</font></a>
		</th>
		<th class="col-width-4"> Sr no </th>
		<th>Group</th>
		<%while(rslbl.next())
			
		{ %>
		<th><%=rslbl.getString("Make") %></th>
		<th><%=rslbl.getString("Model") %></th>
		<th><%=rslbl.getString("PartNo") %></th>
		<th><%=rslbl.getString("Description") %></th>
		<%} %>
		<th>Quantity</th>
		</tr> 
		</thead>
		<tbody>
<%

   String SqlTmp="Select * from "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","")+"";
   System.out.println(">>>>>>>>SqlTmp:"+SqlTmp);
   ResultSet rs=st.executeQuery(SqlTmp);
   while(rs.next())
   { 
	   
	%>  
   <tr>
	   <td class="text-center"><a href="#" style="font-weight: bold; color: black; " onclick="deleteRow('<%= rs.getInt("srno")%>');"><img src="images/delete.JPG" width="20px" height="18px" style="border-style: none"></img></a></td>
	   <td class="text-center"><%=rs.getInt("srno") %></td>
	   <td class="text-leftr"><%=rs.getString("TheGroup") %></td>
	   <td class="text-left"><%=rs.getString("make") %></td>
	   <td class="text-left"><%=rs.getString("model") %></td>
	   <td class="text-center"><%=rs.getString("partno") %></td>
	   <td class="text-left"><%=rs.getString("description") %></td>
	   <td class="text-center"><%=rs.getString("quantity") %></td>
   </tr>

   <%
		itr++;   
   }
%>		
</tbody>
</table>
</div>
</div>


<script>
var globalmodel;
var counter=1;
function popup(webadd)
{ 
	window.open(webadd,'jav','width=565,height=350,top=200,left=400,resizable=no');
}
function validate()
{
		var company=document.ledgerDetails.companyName.value;
		
		 if(company=="") 
		 {
			   alert("Please Select Company");   return false; 	
		 }
		return true;		
}
      
	  function checkAll()
	  {
		   
			  var field=document.getElementsByName('chk');
				var i;
				try{
			  for (i = 0; i < field.length; i++)
			  		 field[i].checked = true ;
				}catch(e){alert(e);}
	  }
	  
	  function unCheckAll()
	  {
		   
			  var field=document.getElementsByName('chk');
				var i;
				try{
			  for (i = 0; i < field.length; i++)
			  		 field[i].checked = false ;
				}catch(e){alert(e);}
	  }

      function deleteRow(srno) 
      {
          
	    var ajaxRequest;
	    try{
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
			         	        var queryString = "?delete=yes&srno="+srno;
			         	       	ajaxRequest.open("GET", "AjaxSalesEnq.jsp" + queryString, true);
			         	       	ajaxRequest.send(null); 
			         	       	ajaxRequest.onreadystatechange = function()
			         	         {
			         	                if(ajaxRequest.readyState == 4)
			         	                {
			         	                        var reslt=ajaxRequest.responseText;
			         	                        var data=reslt.split("#");
			         	                        if(data[1].indexOf('Yes')!=-1)
			         	                        {
			         	                        	alert("Item Deleted Successfully");
			         	                        	window.location.reload();
			         	                        }
			         	                        else
			         		                        alert("!!! ERROR while removing data from GRID due to Server Side problem. Please try again.");
			         	                }
			         	         }
      }
 
	function getCompanies(prospect)
	{
			document.getElementById('companyList').style.visibility = 'visible';
			document.getElementById("companyList").style.height="100px";
			var company=document.ledgerDetails.companyNames.value;

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
			}
			else
			{
				company=company.replace(".", "");
				company=company.replace(",", "");
				company=company.replace("$", "");
				company=company.replace("#", "");
				company=company.replace("?", "");
				company=company.replace("-", "");
				company=company.replace("_", "");
				company=company.replace(" ", "");
				company=company.replace("(", "");
				company=company.replace(")", "");
			var ajaxRequest;  // The variable that makes Ajax possible!
			try{
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

				} 
			}
			var queryString = "?company=" +company;
			ajaxRequest.open("GET", "GetCustomerNames.jsp" + queryString, true);
			ajaxRequest.send(null);
			} 
		
	}

	function viewvisitingcard()
	{
		document.getElementById("visitingCard").style.visibility="visible";
		document.getElementById("visitingCard").style.height="100px";
		
	}

	function disablevisitingcard()
	{
		document.getElementById("visitingCard").style.visibility="hidden";
		document.getElementById("visitingCard").style.height="0px";
	}
   
    function popup1()
    {
    	window.open('AllSalesModule.jsp');
    }
	
	function showVisitingCardDetails(companyName)
	{
		document.ledgerDetails.companyNames.value='';
		document.getElementById('companyList').style.visibility = 'hidden';
		document.getElementById("companyList").style.height="0px";


		try{
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

				var data=reslt.split("#");
				
				document.ledgerDetails.companyName.value=data[1];
				document.ledgerDetails.companyNames.value=data[1];
				document.ledgerDetails.companyPerson.value=data[2];
				document.ledgerDetails.companyEmail.value=data[3];
				document.ledgerDetails.companyCity.value=data[4];
				document.ledgerDetails.companyProduct.value=data[5];
				document.ledgerDetails.companyPhone.value=data[6];
				document.ledgerDetails.CustCode.value=data[7];
				document.getElementById("comp").value=data[1];				
			}
		}
		var queryString = "?companyName=" +companyName;
		ajaxRequest.open("GET", "AjaxShowVisitingCard.jsp" + queryString, true);
		ajaxRequest.send(null);  
  }
	function compname() {
		var cmpname=document.getElementById("comp").value;
	/* alert("cmpname"+cmpname);  */
		document.getElementById("comp1").value=document.getElementById("comp").value;
		document.ledgerDetails.companyName.value=document.getElementById("comp").value;
		document.getElementById("companyNames").value=document.getElementById("comp").value;
	}
	window.onload=compname;

	</script>
	  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Sales Enquiry Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Sales Enquiry Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Sales Enquiry Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Sales Enquiry Report ',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Sales Enquiry Report ',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<%@ include file="footer.jsp" %>
 </body>
</html>