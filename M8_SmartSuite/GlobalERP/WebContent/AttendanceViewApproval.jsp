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
String EntryBy=session.getAttribute("EmpName").toString();
String update="",update1="",EntryDate="",entryd1="",ID="",Name="",Date="",CheckIn="",CheckOut="",ActualWorkHrs="",Day="",DutyIn="",DutyOut="",WorkingHours="",Status="",NewStatus="",EntBy="",Comments="";

 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
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
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Attendance Approval Report</h5>
    </div>
</div>

  <form name="formreport" id="formreport" method="post" onsubmit="return validate();">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <%
        String[] months = {"jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"};
        String[] monthsCapitalized = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
        
        String selectedMonth = request.getParameter("month");

        if (selectedMonth == null || selectedMonth.isEmpty()) {
    %>
    <option value="Select">Select</option>
    <%
        }

        for (int i = 0; i < months.length; i++) {
            String monthValue = months[i];  // Lowercase value for the option's value attribute
            String monthName = monthsCapitalized[i];  // Capitalized name to display in the dropdown
            boolean isSelected = monthValue.equals(selectedMonth);
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
        if (selectedYear == null || selectedYear.isEmpty()) {
    %>
    <option value="Select">Select</option>
    <%
        }
        for (int year = 2016; year <= 2050; year++) {
            boolean isSelected = Integer.toString(year).equals(selectedYear);
    %>
    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>><%= year %></option>
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
			<div class="col-md-2"></div>
		</div>
</form> 
<br> 
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>ID</th>
			<th>Name</th>
			<th>Date</th>
			<th>CheckIn</th>
			<th>CheckOut</th>
			<th>ActualWorkHrs</th>
			<th>Day</th>
         	<th>DutyIn</th>
	        <th>DutyOut</th>
	        <th>WorkingHours</th>
	       <th>OldStatus</th>
	        <th>NewStatus</th>
			<th>EntryBy</th>
			<th>Comments</th>
         	<th>UpdatedDate</th>
	        <th>EntryDate</th>
            </tr>
        </thead> 
        <tbody>
        
<%

String mon=request.getParameter("month");
String Year=request.getParameter("year");

String query="select * from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where EntryBy='"+EntryBy+"'and Month='"+mon+"'and Year='"+Year+"' ";
System.out.println(query);
ResultSet rs=st.executeQuery(query);
int i=1;
while(rs.next())
{
     update=rs.getString("UpdatedDate");
	 update1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(update));
	 EntryDate=rs.getString("EntryDate");
	 entryd1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(EntryDate));
	 ID=rs.getString("ID");
	 Name=rs.getString("Name");
	 Date=rs.getString("Date");
	
	 CheckIn       = (rs.getString("CheckIn") == null || rs.getString("CheckIn").trim().isEmpty()) ? "-" : rs.getString("CheckIn");
	 CheckOut      = (rs.getString("CheckOut") == null || rs.getString("CheckOut").trim().isEmpty()) ? "-" : rs.getString("CheckOut");
	 ActualWorkHrs = (rs.getString("ActualWorkHrs") == null || rs.getString("ActualWorkHrs").trim().isEmpty()) ? "-" : rs.getString("ActualWorkHrs");
	 Day           = (rs.getString("Day") == null || rs.getString("Day").trim().isEmpty()) ? "-" : rs.getString("Day");
	 DutyIn        = (rs.getString("DutyIn") == null || rs.getString("DutyIn").trim().isEmpty()) ? "-" : rs.getString("DutyIn");
	 DutyOut       = (rs.getString("DutyOut") == null || rs.getString("DutyOut").trim().isEmpty()) ? "-" : rs.getString("DutyOut");
	 WorkingHours  = (rs.getString("WorkingHours") == null || rs.getString("WorkingHours").trim().isEmpty()) ? "-" : rs.getString("WorkingHours");

	 Status=rs.getString("Status");
	 NewStatus=rs.getString("NewStatus");
	 EntBy=rs.getString("EntryBy");
	 Comments=rs.getString("Comments");
	
%>
<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-center"><%=ID%></td>
	<td class="text-left"><%=Name%></td>
	<td class="text-right"><%=Date%></td>
	<td class="text-center"><%=CheckIn%></td>
	<td class="text-center"><%=CheckOut%></td>
	<td class="text-center"><%=ActualWorkHrs%></td>
	<td class="text-left"><%=Day%></td>
	<td class="text-center"><%=DutyIn%></td>
	<td class="text-center"><%=DutyOut%></td>
	<td class="text-center"><%=WorkingHours%></td>
	<td class="text-left"><%=Status%></td>
	<td class="text-left"><%=NewStatus%></td>
	<td class="text-left"><%=EntBy%></td>
	<td class="text-left"><%=Comments%></td>
	<td class="text-right"><%=update1%></td>
	<td class="text-right"><%=entryd1%></td>

<%} %>
</tr>
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
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
	        //keys: true,  //Keytable
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
		                        title: 'Attendance Approval Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Attendance Approval Report '+$("#month").val()+'-'+$("#year").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A3',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
 	                        title: 'Attendance Approval Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
 	                        title: 'Attendance Approval Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Attendance Approval Report '+$("#month").val()+'-'+$("#year").val(), 
							},
					],
				},
				
           ], 
       
       });

   });
</script>
<script>
function validate(){
        var month = document.getElementById('month').value;
        var year = document.getElementById('year').value;
        
        if (month === 'Select' || month === '' || year === 'Select' || year === '') {
            alert("Please select both Month and Year");
            return false; // Prevent form submission
        }
         return true;
    }
	
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>