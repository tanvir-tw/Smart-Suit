 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="icon" type="image/png" href="images/favicon.png">
    <title>GlobalERP</title>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
int srNo = 1,billable=0,billed = 0,missed = 0;
String ownerName ="",customer="",Year = "",month = "",Ownername="",btn="";

 // Connection Initialization
Connection conn = null;
Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();

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
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Monthly Billing Status Report</h5>
    </div>
</div>

  <form name="formreport" id="formreport" method="post" onsubmit="return validate()">
		    <div class="row col-12">
		    <div class="col-md-2"></div>
				<div class="col-md-3">
				  <label for="month"><b>Customer</b></label>
						<div class="input-group input-group-merge">
<% if(request.getParameter("companyName1") == null || request.getParameter("companyName1").equalsIgnoreCase("null")){
%>           <select class="form-select" name="companyName1" id="companyName1" style="font-size: 12px;">

           <option value="Select">Select</option>

            <%
       	String sql1 = "SELECT Distinct(OwnerName) as OwnerName FROM db_gps.t_vehicledetails  where status='-' and OwnerName != '' order by OwnerName";
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			 customer=rsregno.getString("OwnerName");
			
			%>
			<option value="<%=customer%>"><%=customer%></option>
	         <%
      }
           
		%>
           </select>
           <%}else{
        	   %>
<select class="form-select" name="companyName1" id="companyName1" style="font-size: 12px;">
<option value="<%=request.getParameter("companyName1")%>"><%=request.getParameter("companyName1")%></option>           

            <%
       	String sql1 = "SELECT Distinct(OwnerName) as OwnerName FROM db_gps.t_vehicledetails  where status='-' order by OwnerName";
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			 customer=rsregno.getString("OwnerName");
			
			%>
			<option value="<%=customer%>"><%=customer%></option>
	         <%
      }
           
		%>
           </select>
                            <%} %>
                           
		  		       </div>              
			</div>					
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <%
        String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
        String[] monthValues = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};

        String requestMonth = request.getParameter("month");
    %>
    <option value="Select" <%= (requestMonth == null || requestMonth.isEmpty()) ? "selected" : "" %>>Select</option>
    <%
        for (int j = 0; j < months.length; j++) {
            String monthName = months[j];  
            String monthValue = monthValues[j];  
            boolean isSelected = monthValue.equals(requestMonth);  
    %>
    <option value="<%= monthValue %>" <%= isSelected ? "selected" : "" %>><%= monthName %></option>
    <%
        }
    %>
</select>
		                  <script>
                            const mySel = document.getElementById("month");

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
			<div class="col-md-2">
				  <label for="year"><b>Year</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="year" name="year">
   <%
        String selectedYear = request.getParameter("year");
    %>
    <option value="Select" <%= (selectedYear == null || selectedYear.isEmpty()) ? "selected" : "" %>>Select</option>
    <%
    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

        for (int year1 = currentYear; year1 >= 1990 ; year1--) {
            boolean isSelected = Integer.toString(year1).equals(selectedYear);
    %>
    <option value="<%= year1 %>" <%= isSelected ? "selected" : "" %>><%= year1 %></option>
    <%
        }
    %>
</select>
		                  <script>
                            const mySel = document.getElementById("year");

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
<br> 
 <div class="container" style="width:70%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
					<tr>
						<th class="col-width-4">SrNo.</th>
             			<th>Owner Name</th>	
			            <th>Billable</th>
			            <th>Billed</th>
			            <th>Missed</th>
					</tr>
				</thead> 
        <tbody>
        <%

 Year = request.getParameter("year");
 month = request.getParameter("month");
 Ownername=request.getParameter("companyName1");
        
 btn = request.getParameter("button");

if(btn==null || btn.equalsIgnoreCase("null"))
{
	
	
}else{

String sql = "SELECT OwnerName, COUNT(*) as Billable, " +
               "(SELECT COUNT(*) FROM db_gps.t_vehicledetails b " +
               " WHERE VehicleCode IN (SELECT vehid FROM db_GlobalERP.100000fv_erp_relation"+Year+"_"+month+")"+
               " AND a.OwnerName=b.ownername AND a.OwnerName='"+Ownername+"' GROUP BY OwnerName) as Billed, " +
               "(SELECT COUNT(*) FROM db_gps.t_vehicledetails b " +
               " WHERE VehicleCode NOT IN (SELECT vehid FROM db_GlobalERP.100000fv_erp_relation" +Year +"_"+month+") " +
               " AND a.OwnerName=b.ownername AND a.OwnerName='"+Ownername+"' GROUP BY OwnerName) as Missed " +
               " FROM db_gps.t_vehicledetails a WHERE a.OwnerName='"+Ownername+"' GROUP BY OwnerName ORDER BY Billable DESC";

System.out.println("Sql :- "+ sql);
ResultSet rs = st.executeQuery(sql);


while (rs.next()) {
     ownerName = rs.getString("OwnerName");
     billable = rs.getInt("Billable");
     billed = rs.getInt("Billed");
     missed = rs.getInt("Missed");
    
 
%>
    <tr>
        <td class="text-center"><%= srNo %></td>
        <td class="text-left"><%= ownerName %></td>
        <td class="text-center"><a href = "ViewMonthlyBillSummary.jsp?status=Billable&ownername=<%=ownerName %>&year=<%=Year%>&month=<%=month %>"><%= billable %></a></td>
        <td class="text-center"><a href = "ViewMonthlyBillSummary.jsp?status=Billed&ownername=<%=ownerName %>&year=<%=Year%>&month=<%=month %>"><%= billed %></a></td>
        <td class="text-center"><a href = "ViewMonthlyBillSummary.jsp?status=Missed&ownername=<%=ownerName %>&year=<%=Year%>&month=<%=month %>"><%= missed %></a></td>
						
    </tr>
<%
    srNo++;
}
}

%>

   </tbody>
 </table>
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
	  	                        title: 'Monthly Billing Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	  	                        title: 'Monthly Billing Status Report '+$("#month").val()+'-'+$("#year").val(), 
	                            orientation: 'Portrait',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	  	                        title: 'Monthly Billing Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	  	                        title: 'Monthly Billing Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	  	                        title: 'Monthly Billing Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
 
					],
				},
				
           ], 
       
       });

   });
   
</script>
<script>
function validate() {
    var current_date = new Date();
    var current_year = current_date.getFullYear();
    var current_month = current_date.getMonth() + 1; // getMonth() is zero-based, so add 1

    var monthNames = [
        "January", "February", "March", "April", "May", "June", 
        "July", "August", "September", "October", "November", "December"
    ];
    var current_month_name = monthNames[current_month - 1]; 

    var Customer = document.getElementById("companyName1").value;
    Customer = Customer.replace(/&/g, '%26');

    if (Customer == "Select" || Customer == "") {
        alert("Please Select Customer");
        return false;
    }

    var month = document.getElementById("month").value; 
    var Year = document.getElementById("year").value;
	if(month == "Select")
	{
		alert("Please Select Month ");
		return false;
		
	}
	
	if(Year=="Select")
	{
		alert("Please Select Year");
		return false;
		
	}
    
    if (isNaN(month) || month < 1 || month > 12) {
        alert("Please Select a Valid Month");
        return false;
    }

    if (isNaN(Year) || Year < 2012 || Year > current_year) {
        alert("Year should be in range 2012 to current year");
        return false;
    }

    if (Year == current_year && month >= current_month) {
        alert("Please Select a Month Before " + current_month_name);
        return false;
    }

    return true;
}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>