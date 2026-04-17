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
String bt="";
String ComID=session.getAttribute("CompanyMasterID").toString();
String ActiveStatus="",Status1="",sql2="",data="";
int i=1;

 // Connection Initialization
Connection conn = null;
Statement st = null,st1=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");


%>
	<input type="hidden" id="ComID" name="ComID" value=<%=ComID %>>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">User Master Report</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-5"></div>
				<div class="col-md-2">
				  <label for="dropdown"><b>Active Status:</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="ActiveStatus" name="ActiveStatus">
                             <% if(bt == null) { %>

<option value="All">All</option>
	
	<%

	 sql2 = "select distinct ActiveStatus from db_GlobalERP.UserMaster where ActiveStatus IS NOT NULL and ActiveStatus!='null' order by ActiveStatus";
System.out.println("*******"+sql2);
ResultSet rs1 = st.executeQuery(sql2);
while(rs1.next())
{
	 
	ActiveStatus=rs1.getString("ActiveStatus");
	%>
	<option value="<%=ActiveStatus%>"><%=ActiveStatus%> </option>
		
                                 <% }}else{
                            
			Status1=request.getParameter("ActiveStatus");
%> 
         <option value="<%=Status1%>"><%=Status1 %></option>
         <option value="All">All</option>
            
            
    <%
    if(Status1.equals("All"))
    {
    	 sql2 = "select distinct ActiveStatus from db_GlobalERP.UserMaster where ActiveStatus IS NOT NULL and ActiveStatus!='null' order by ActiveStatus";

    }
    else
    {
	 sql2 = "select distinct ActiveStatus from db_GlobalERP.UserMaster where ActiveStatus IS NOT NULL and ActiveStatus!='"+Status1+"'order by ActiveStatus";

		}
    System.out.println("*******"+sql2);

ResultSet rs1 = st1.executeQuery(sql2);
while(rs1.next())
{
	 
	ActiveStatus=rs1.getString("ActiveStatus");
	
	%>
	<option value="<%=ActiveStatus%>"><%=ActiveStatus%> </option>
     <%
}
    } %>
                           </select>
                            <script>
                            const mySel = document.getElementById("ActiveStatus");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
		                </div>
			</div>				
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			<div class="col-md-3"></div>
		</div>
</form> 
<a href="AddNewUser.jsp" style="text-decoration:none;"><b>Add New</b></a>
<br> 
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>UserName</th>
            <th>UserType</th>
            <th>UserLevel</th>
            <th>Dept</th>
            <th>EmpCode</th>
            <th>EmpName</th>
            <th>TALevel</th>
            <th>Mobile No</th>
            <th>Email</th>
            <th>ActiveStatus</th>
             <th>HodReport</th>
            </tr>
        </thead> 
        <tbody>
        <%
        if(bt==null || bt==" " || bt=="" )
        {
         data="select * from db_GlobalERP.UserTypeMaster a inner join db_GlobalERP.UserMaster b on (a.UserTypeCode=b.UserTypeCode) where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus like '%%'"; 
        }else
        {
        	String activestat=request.getParameter("ActiveStatus");
        	System.out.println("activestat-------->"+activestat);
        	
        	if(activestat.equals("Yes"))
        	{
        		 data="select * from db_GlobalERP.UserTypeMaster a inner join db_GlobalERP.UserMaster b on (a.UserTypeCode=b.UserTypeCode) where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus like '%Yes%'"; 
        	}else{
        		 data="select * from db_GlobalERP.UserTypeMaster a inner join db_GlobalERP.UserMaster b on (a.UserTypeCode=b.UserTypeCode) where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus like '%No%'"; 

        	}
        }
        
        System.out.println("check-------->"+data);
		ResultSet rs21=st.executeQuery(data);
		while(rs21.next())
		{

		String UserName=rs21.getString("UserName");
		System.out.println("UserName-------->"+UserName);
		String UserLevel=rs21.getString("UserLevel");
		String UserType=rs21.getString("UserType");
		String Dept=rs21.getString("Dept");

		String EmpCode=rs21.getString("EmpCode");
		String EmpName=rs21.getString("EmpName");
		String TALevel=rs21.getString("TALevel");
		String mobileno=rs21.getString("mobileno");
		String email=rs21.getString("email");
		String ActiveStatus1=rs21.getString("ActiveStatus");
		String HodReport=rs21.getString("HodReport");

        %>
<tr>
	<td class="text-center"><%=i%></td>
	<% if(bt==null || bt==" " || bt=="" )
        { %>
        	<td class="text-left"><a href="editNewUser.jsp?UserName=<%=UserName%>"><%=UserName%></a></td>
        <%}else{ %>
			<td class="text-left"><%=UserName%></td>
			<%} %>
			<td class="text-left"><%=UserType%></td>
			<td class="text-left"><%=UserLevel%></td>
			<td class="text-left"><%=Dept%></td>
				<td class="text-center"><%=EmpCode%></td>
				<td class="text-left"><%=EmpName%></td>
				<td class="text-left"><%=TALevel%></td>
				<td class="text-center"><%=mobileno%></td>
				<td class="text-left"><%=email%></td>
				<td class="text-left"><%=ActiveStatus1%></td>
				<td class="text-left"><%=HodReport%></td>
</tr>
<%i++;} %>
        </tbody>
 </table>
 </div> 
 
<%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        /*  fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
	        keys: true,  //Keytable
	        stateSave: true,

	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'User Master Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'User Master Report', 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
 	                        title: 'User Master Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
 	                        title: 'User Master Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'User Master Report', 
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