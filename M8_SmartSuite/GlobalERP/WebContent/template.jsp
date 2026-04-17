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
    .mail-header {
      background: #F5F5F5; /* primary blue */
      color: maroon;
      padding: 10px 15px;
      font-weight: bold;
      border-top-left-radius: 6px;
      border-top-right-radius: 6px;
      border-bottom: 1px solid gainsboro;
    }

      #label{
    font-weight:600;
    color:rgb(128, 0, 0);
    } 
       #cancel{
      height: 29px;
    text-align: center;
    padding: 0px 10px;
}
  </style>
</head>
 <body>
<%
// Variable Declaration
String result="",que1="",Template="",Subject="",Body="",Srno="";
int j=1;

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
    
    <%
	result=request.getParameter("result");
if(result==null)
{%>

<%}
else
{%>
<h5 class="text-center" style="color:darkgreen;"><%=result %> Successfully...........</h5>
<%} %>
 <div class="container">
    <div class="mail-box">
      <div class="mail-header text-center">Create Template</div>
      <div class="mail-body">
      
<form name="servprovider" method="get" action="addTemplate.jsp" onsubmit="return validate();">
          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">Template Name:</label>
            <div class="col-sm-10">
              <textarea class="form-control" rows="1" name="name" id="name"></textarea>
            </div>
          </div>

          <div class="row mb-1">
            <label class="col-sm-2 col-form-label" id="label">Subject:</label>
            <div class="col-sm-10">
               <textarea class="form-control" rows="2" name="subject" id="subject"></textarea>
            </div>
          </div>

          <div class="row mb-2">
            <label class="col-sm-2 col-form-label" id="label">Body:</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="6" name="body" id="body"></textarea>
            </div>
          </div>

          <div class="text-center">
            <input type="submit" class="btn btn-primary" id="button" name="button" value="Save">
            <button class="btn btn-secondary" id="cancel" name="cancel" onclick="cancel();">Cancel</button>
          </div>
      
        </form>
      </div>
      </div>
    </div>
    
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Available Templates</h5>
    </div>
     <br>
     <table id="example" class="display">        
       <thead>
            <tr>
            <th><input type="checkbox" name="mainunit" id="mainunit"  onClick="CheckUncheckAll1();"></input></th>
            <th class="col-width-4">SrNo.</th>
            <th>Name</th>
			<th>Subject</th>
            <th><div style="width:500px;">Body</div></th> 
			<th>Edit</th>
            </tr>
        </thead> 
        <tbody>
       <%
que1="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"EmailTemplate where Active='Yes'";
ResultSet rst1=st.executeQuery(que1);
while(rst1.next())
{
	
	Template=rst1.getString("Template");
	Subject=rst1.getString("Subject");
	Body=rst1.getString("Body");
	Srno=rst1.getString("Srno");
	%>
        	<tr>
        	            <input type="hidden" name="rid<%=j%>" id="rid<%=j%>" value="<%=rst1.getString("Srno")%>" ></input>
							<td><input type="checkbox" name="chk<%=j %>" id="chk<%=j%>"></input></td>
							<td><%=j%></td>
							<td><%=Template%></td>
							<td>
								<div id="subject<%=j %>"><%=Subject%></div>
								<textarea rows="5" cols="50" name="subjectid<%=j %>" id="subjectid<%=j%>" style="display:none"><%=Subject%></textarea>
								<input type="text" name="subjectid<%=j %>" id="subjectid<%=j%>" value="<%=Subject%>" style="display:none" size="35">
							</td>
							<td>
								<div style="width:500px;white-space:normal; word-wrap:break-word; overflow-wrap:break-word;" id="mail<%=j %>"><%=Body%></div>
								<textarea rows="15" cols="60" name="mailid<%=j %>" id="mailid<%=j%>" style="display:none"><%=Body%></textarea>
								<input type="text" name="mailid<%=j %>" id="mailid<%=j%>" value="<%=Body%>" style="display:none" size="35">
							</td>
							<td>
								<input type="button" class="btn btn-secondary" name="edit<%=j %>" id="edit<%=j %>" value="Edit" onclick="activate('<%=j %>');"  ></input>
								<input type="submit" name="btnsubmit<%=j %>" id="btnsubmit<%=j %>" value="Submit" onclick="return onSubmit('<%=Srno%>','<%=j%>')" style="display:none" ></input>
							</td>
							
        	    </tr>	 	

        		<%
        		j++;
        		}
        %>

        </tbody>        
 </table>
         <input type="hidden" name="cntr" id="cntr" value="<%=j %>"></input>
 
      <div class="d-flex justify-content-center mb-3">
              <button class="btn btn-secondary" id="cancel" name="vehdelete" onclick="onDelete('Unit')">Delete</button>
     </div>
  </div>
 </div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
 <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
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
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Available Template Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Available Template Report', 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Available Template Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Available Template Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Available Template Report', 
							},
					],
				},
           ], 
       });
   });
</script>
<script>
function echeck(str) {

	var at="@";
	var dot=".";
	var lat=str.indexOf(at);
	var lstr=str.length;
	var ldot=str.indexOf(dot);
	if (str.indexOf(at)==-1){
	   alert("Invalid E-mail ID");
	   return false;
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   alert("Invalid E-mail ID");
	   return false;
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    alert("Invalid E-mail ID");
	    return false;
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    alert("Invalid E-mail ID");
	    return false;
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    alert("Invalid E-mail ID");
	    return false;
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    alert("Invalid E-mail ID");
	    return false;
	 }
	
	 if (str.indexOf(" ")!=-1){
	    alert("Invalid E-mail ID");
	    return false;
	 }

		 return true;					
}

function validate()
{
 var servprov=document.servprovider.serv_prov.value;
 var mail=document.servprovider.mail; 

  /*if(isNaN(mobno))
   {
     alert("Enter valid Mobile No");
     return false;
   } 
 /* else if(mobno.length<10 || mobno.length>10)
   {
     alert("Please enter Ten Digit Mobile No");
     return false;
   }*/
   if(servprov=="Select")
   {
	 alert("Please Select Service Provider");
	 return false;
   }
   else if(mail.value=="" || mail.value==null)
   {
	   alert("Please Enter E-mail ID");
	   mail.focus();
		 return false;
   }
   if (echeck(mail.value)==false){
	   mail.value="";
		   mail.focus();
	   		return false;
	   	}

	  var ans=confirm("Do you want to submit");
	  if(ans==true)
		 return true;
	  else
		 return false;

 
}

function cancel()
{
document.servprovider.reset();


}
function activate(index)
{
	//alert("hello");
	//alert(document.getElementById("btnsubmit"+index).value);
	document.getElementById("btnsubmit"+index).style.display="block";
	document.getElementById("mail"+index).style.display="none";
	document.getElementById("mailid"+index).style.display="block";
	document.getElementById("subject"+index).style.display="none";
	document.getElementById("subjectid"+index).style.display="block";
	document.getElementById("edit"+index).style.display="none";
	
}

function onDelete(type)
{
	//alert(type);
	var rid="";
	var flag=false;
			var cntr=document.getElementById("cntr").value;
		//alert(cntr);
		var i=1;
	
			for(i=1;i<cntr;i++)
			{
				//alert(document.getElementById("chktech"+i).checked);
				if(document.getElementById("chk"+i).checked)
				{
					//alert("inside if true");
					flag=true;
					//alert(document.getElementById("techrid"+i).value);
					rid=rid+document.getElementById("rid"+i).value+",";
				}
				
			}

			if(flag==false)
			{ alert("Please Select atleast one Checkbox");
				return false;
			}
			//alert(rid);
			var msg=confirm("Do you want to Delete the records");
			if(msg==true)
			{
			var url="addTemplate.jsp";
			document.servprovider1.action=url+"?&totrid="+rid+"&type=delete";
			document.servprovider1.submit();
			}
			else
			{
				return false;
			}
			//alert(flag);
			
	}

function onSubmit(rid,index)
{
	//alert(rid+type);
	 var mail=document.getElementById("mailid"+index); 
	 var subject=document.getElementById("subjectid"+index); 
	 if(subject.value=="" || subject.value==null)
	   {
		   alert("Do you really want empty subject in template??");
		   subject.focus();
			 return false;
	   }
	  if(mail.value=="" || mail.value==null)
	   {
		   alert("Do you really want empty body in template??");
		   mail.focus();
			 return false;
	   }
	  else{
	var msg=confirm("Do you want to submit");
	if(msg==true)
	{
	var url="addTemplate.jsp";
	document.servprovider1.action=url+"?rid="+rid+"&type=update&index="+index;
	document.servprovider1.submit();
	}
	else
	{
		return false;
	}
   }
}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>