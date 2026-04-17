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
// Variable Declaration
String bt="",type="",Representative="";
int ck=0;
String compcode="",companymasterid="";
String allocatedto="",query="",query1="",Status="",dt="";
int i=1;
 
String CompanyName="",ContactPerson="",MobileNo="",Email="",Country="",State="",City="",EmpName="";
String BillingGSTN="",ShippingGSTN="",BranchName="";

 // Connection Initialization
Connection conn = null;
Statement st1 = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;

ResultSet rs=null;
ResultSet rs1=null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
type=request.getParameter("Status");
Representative=request.getParameter("Representative");
companymasterid=session.getAttribute("CompanyMasterID").toString();
if(type == null){
	type = "Customer";
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Customer Master</h5>
    </div>
</div>
  <form name="formreport" id="formreport" onsubmit="return validate()" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				
				<div class="col-md-2">
				  <label for="dropdown"><b>Representative</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="Representative" name="Representative" required>
                             <% if(bt == null) { %>
                               <option value="Select" selected>Select</option>
                                 <% }  
                             String empcode="",empname="";
                            String allocate="select distinct(EmpName),EmpCode from db_GlobalERP.UserMaster where companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and EmpCode in (select distinct(Allocatedto) from db_GlobalERP."+companymasterid+"prospectivecustmaster) order by EmpName";
                     		ResultSet rsallocate=st.executeQuery(allocate);
                     		System.out.println("allocate:-"+allocate);
                     		while(rsallocate.next()) { 
                     			empcode=rsallocate.getString("EmpCode"); empname=rsallocate.getString("EmpName");
                     		%>
                     		    <option value='<%=empcode%>' <% if(Representative!=null){ if(Representative.equals(empcode))  { %> selected <%} } %> ><%=empname%></option>
                     		<%
                    		}
                     		%>
                           </select>
                           <script>
                            const mySel = document.getElementById("Representative");
                             const isBtNull = <%= bt == null %>;
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
		                </div>
			</div>
			<div class="col-md-2">
				  <label for="dropdown"><b>Type</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="Status" name="Status" onchange="check()" required>
                             <% if(bt == null) { %>
                               <option value="Select" selected>Select</option>
                                 <% } %>
                              <option value="Prospect" <%if(type.equals("Prospect")){%> selected<%} %> >Prospect</option>
						      <option value="Customer" <%if(type.equals("Customer")){%> selected<%} %> >Customer</option>
                           </select>
                            <script>
                            const mySel = document.getElementById("Status");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>	
		                </div>
			</div>		
				
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			
			<div class="col-md-2"></div>
			
		</div>
</form> 

<form name="indexReport11"  target="_self" method="post"  onsubmit="return getcheckedrow()"  action="ReAllocation.jsp" >

 <div class="row col-12 mt-1">
    <div class="col-md-2" style="width:8%;">
       <input type="submit" class="btn btn-primary" name="Approve" id="button"  value="ReAssign" onclick="" />
    </div>
    <div class="col-md-2">
    </div>
</div>
<br> 
<table id="example" class="display" style="width:100%"> 
 <%
        if(bt!=null)
        {
        
        	if(type!=null){ 
        	
        
        	if(type.equals("Prospect")){
        		%>       
       <thead>
          <tr>
            <th width="4%">SrNo</th>
			<th width="4%">
				<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
				<font color="white">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
				<a href="#" onclick="unCheckAll()"> <font color="white">UnChk</font></a>
			</th>
			<th>Customer</th>	
			<th>Contact</th>
			<th>Mobile</th>
			<th>Email</th>
			<th>EnteredOn</th>
 			<th>AllocatedTo</th>
			<th>Country</th>
			<th>State</th>
			<th>City</th>
			<th>Type</th>
 			<th>Status </th>
	       </tr>
        </thead> 
        <tbody>
        <% 
         
        query="select distinct(CustomerCode),Allocatedto,SalesCustomerCode,AddedOnDate,CompanyName,ContactPerson,MobileNo,EMail,Country,State,City,IsDataValid from db_GlobalERP."+companymasterid+"prospectivecustmaster where Allocatedto='"+Representative+"' and SalesCustomerCode=0 ";
        System.out.println("prospect query:-"+query);
        rs=st1.executeQuery(query);
         while(rs.next()){   //beginning of while
        	 
        	 allocatedto=rs.getString("Allocatedto");
        	 Status=rs.getString("IsDataValid");
        	 
        	 dt=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("AddedOnDate")));
        	 query1="select distinct(EmpName) from db_GlobalERP.UserMaster where EmpCode='"+allocatedto+"' and companymasterid='"+companymasterid+"'";
        		
        		
        		rs1=st2.executeQuery(query1);
        		if(rs1.next())
        		{
        		EmpName=rs1.getString("EmpName");
        		}
        		 
        		 if(Status.equals("0"))
        		 {
        			 Status="DeActive";
        		 }
        		 else
        		 {
        			 Status="Active";
        		 }
        		 
        		 CompanyName = rs.getString("CompanyName");
        		 ContactPerson = rs.getString("ContactPerson");
        		 MobileNo = rs.getString("MobileNo");
        		 Email = rs.getString("Email");
        		 Country = rs.getString("Country");
        		 State = rs.getString("State");
        		 City = rs.getString("City");
        		 
        		 
        %>
        <tr>
        <td class="text-center"><%=i %></td>
        <td width="4%" class="text-center">
        <input type="checkbox"  name="check<%=ck %>"   id="check<%=ck %>"  />
	    <input type="text" style="border:none;background: transparent;"" id="net_id1<%=ck %>" name="net_id1<%=ck%>" value="<%=rs.getString("CustomerCode")%>" readonly/>
	    <td class="text-left"><%=CompanyName%></td>
        <td class="text-left"><%=ContactPerson%></td>
		<td class="text-right"><%=MobileNo%></td>
		<td class="text-left"><%=Email%></td>
		<td class="text-right"><%=dt%></td>
		<td class="text-left"><%=EmpName%></td> 
		<td class="text-left"><%=Country%></td>
		<td class="text-left"><%=State%></td>
		<td class="text-left"><%=City%></td>
		<td class="text-left">Prospect</td>
		<td class="text-left"><%=Status%></td>
	    </tr>
       	<%  
       	i++;
		ck++;  
		}//end of while %>
        </tbody>
        <%} else if(type.equals("Customer") ){  %>
        <thead>
	<tr>
	<th width="4%">SrNo</th>
    <th width="6%">
		<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
		<font color="white">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
		<a href="#" onclick="unCheckAll()"><font color="white">UnChk</font></a>
	</th>
	<th>Customer</th>
	<th>Branch</th>
	<th>BillingGSTIN</th>
	<th>ShippingGSTIN</th>
	<th>Contact</th>
	<th>Mobile</th>
	<th>Email</th>
	<th>EnteredOn</th>
	<th>AllocatedTo</th>
	<th>Country</th>
	<th>State</th>
	<th>City</th>
	<th>Type</th>
	<th>Status </th> 
	</tr>
	</thead>
	<tbody>
	<%
	i=1;
	query="select distinct(SalesCustomerCode),Allocatedto,SalesCustomerCode,AddedOnDate,CompanyName,ContactPerson,MobileNo,EMail,Country,State,City,IsDataValid from db_GlobalERP."+companymasterid+"prospectivecustmaster where Allocatedto='"+Representative+"' and SalesCustomerCode!=0 and customercode!=0 " ;
	System.out.println("customer query:-"+query);
	rs=st3.executeQuery(query);
	while(rs.next())
	 {
		Status=rs.getString("IsDataValid");
		allocatedto=rs.getString("Allocatedto");
		compcode=rs.getString("CompanyName");
		
		 BillingGSTN="";ShippingGSTN="";BranchName="";
		 
		 String GSTIN="select BillingGSTN,ShippingGSTN,BranchName from db_GlobalERP."+companymasterid+"customerdet where customercode='"+rs.getString("SalesCustomerCode")+"'";
		 ResultSet rsGSTIN=st.executeQuery(GSTIN);
		 if(rsGSTIN.next())
		{
			 BillingGSTN=rsGSTIN.getString("BillingGSTN");
			 ShippingGSTN=rsGSTIN.getString("ShippingGSTN");
			 BranchName=rsGSTIN.getString("BranchName");
		}
		else
		{
			BillingGSTN="-";
			ShippingGSTN="-";
			BranchName="-";	 
		}
		 
		dt=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("AddedOnDate")));
		query1="select distinct(EmpName) from db_GlobalERP.UserMaster where EmpCode='"+allocatedto+"'";
		rs1=st4.executeQuery(query1);
		 if(rs1.next())
			{
			EmpName=rs1.getString("EmpName");
			}
		 
		 
		 
		 if(Status.equals("0"))
		 {
			 Status="DeActive";
		 }
		 else
		 {
			 Status="Active";
		 }
		 
		 CompanyName = rs.getString("CompanyName");
		 ContactPerson = rs.getString("ContactPerson");
		 MobileNo = rs.getString("MobileNo");
		 Email = rs.getString("Email");
		 Country = rs.getString("Country");
		 State = rs.getString("State");
		 City = rs.getString("City");
		 %>
		<tr>
		    <td width="4%" class="text-center"><%=i%></td>
		    <td width="4%" class="text-left">
    			<div style="display: flex; align-items: center; gap: 5px;">
        			<input type="checkbox" name="check<%=ck %>" id="check<%=ck %>" />
        			<input type="text" style="border:none; width:80px; background: transparent;" id="net_id1<%=ck %>" name="net_id1<%=ck %>" value="<%=rs.getString("SalesCustomerCode")%>" readonly />
    			</div>
			</td>
	        
		    <td class="text-left"><%=CompanyName%></td>
			<td class="text-left"><%=BranchName%></td>
			<td class="text-left"><%=BillingGSTN%></td>
			<td class="text-left"><%=ShippingGSTN%></td>
			<td class="text-left"><%=ContactPerson%></td>
			<td class="text-right"><%=MobileNo%></td>
			<td class="text-left"><%=Email%></td>
			<td class="text-right"><%=dt %></td>
			<td class="text-left"><%=EmpName%></td>
			<td class="text-left"><%=Country%></td>
			<td class="text-left"><%=State%></td>
			<td class="text-left"><%=City%></td>
			<td class="text-left">Customer</td>
			<td class="text-left"><%=Status%></td>
		</tr>
		
	 <%
	    i++;
		ck++;
	 }
	%>
	</tbody>
        
        
        <% }  //end of type=Customer
       }
     }%>
     
 </table>
 <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
 <input type="hidden" name="Type" id="Type" value="<%=type %>"/>
</form>
 </div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 
 }
%>
  <script type="text/javascript">
  var repName = $("#Representative option:selected").text();
  var type = $("#Status option:selected").text();
  $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
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
	                         title: 'Customer Master Report - '+repName+" - "+type,
							},
							{
							 extend: 'pdfHtml5',
                            text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Customer Master Report - '+repName+" - "+type,
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                            text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                            className: 'dropdown-item',
                            title: 'Customer Master Report - '+repName+" - "+type,
							},
							{
                            extend: 'print',
                            text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                            className: 'dropdown-item',
                            title: 'Customer Master Report - '+repName+" - "+type,
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Customer Master Report - '+repName+" - "+type,
							},

					],
				},
          ], 
      
      });

  });
  
</script>
								


<script type="text/javascript">
function check()
{
var v=document.getElemetbyId("Status").value;
alert(v);
}



function getcheckedrow(){

    var field = document.getElementById("checkedNumber").value;
    var checkedflag = false;

    for (var i = 0; i < field; i++) {
        var chk = document.getElementById("check" + i);
        if (chk && chk.checked) {
            checkedflag = true;
            break;
        }
    }

    if (!checkedflag) {
        alert("Please select at least one customer for reassign.");
        return false;
    }

    return true;
}

function checkAll()
{
	var field = document.getElementById("checkedNumber").value;
	var i, chk=0;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById("check"+chk).checked == false)
		 {
			// alert("inn");
			 document.getElementById("check"+chk).checked = true;
		 }

		 chk++;
		
	}
}catch(e){
	alert(e);
	}
}

function unCheckAll()
{

var field = document.getElementById("checkedNumber").value;
var kj=0,i;
try{

for (i = 0; i < field; i++)
{
	
	 if(document.getElementById("check"+kj).checked == true )
	 {
		 document.getElementById("check"+kj).checked = false;
	 }
	 kj++;
}
}catch(e){
	alert(e);
	}
}

function validate(){
	var rep = document.getElementById("Representative").value;
	var type = document.getElementById("Status").value;
	
	if(rep==""||rep=="Select"){
		alert("select Representative");
		return false;
	}
   if(type==""|| type=="Select"){
	   alert("select Type");
		return false;
	}
	return true;
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>