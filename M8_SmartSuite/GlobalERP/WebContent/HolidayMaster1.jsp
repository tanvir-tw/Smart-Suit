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
<style>
    #delete {
    text-decoration: none;
    font-size: inherit;
    font-weight: bold;
    }
</style>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dt1time="",date21="",dtf="";
int i=1;
String HoildayName="",SrNo="",Day="",EntryBy="";

// Connection Initialization
Connection conn = null;
Statement st1 = null;

try {
	conn = connection.getConnect("db_GlobalERP"); 
	st1 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Holiday Master</h5>
    </div>
</div>
  <form name="HolidayMasterReport" id="HolidayMasterReport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-2"></div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
 <%
if(role.equals("Hr"))
	{
 
	%> 
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a data-bs-toggle="modal" data-bs-target="#AddHolidayModal" style="color:blue;">Add Holiday</a>
	    </div>
		<div class="col-2">
		   <a data-bs-toggle="modal" data-bs-target="#AddWeekoffModal" style="color:green;">Add WeekOff</a>
		</div>
		<div class="col-8"></div>
	</div>
	 <%} %> 
 <br>
 <div class="container" style="width:70%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
           <%
if(role.equals("Hr"))
{
%>
<th>Delete</th>

<%} %>
<th class="col-width-4">SrNo</th>
<th>HolidayName</th>
<th>Day</th>
<th>Date</th>
<th>Entry By</th>
            </tr>
        </thead> 
        <tbody>

<% 
String query="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster where Date  >='"+dt+"' and  Date<='"+dt1time+"' and Status='Yes'";
System.out.println("Quey is:"+query);
 ResultSet rs1=st1.executeQuery(query);
	 
	while(rs1.next())
	{
	 date21=rs1.getString("Date");
	 dtf= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date21));
	 HoildayName=rs1.getString("HoildayName"); 
	 SrNo=rs1.getString("SrNo"); 
	 Day=rs1.getString("Day");
	 EntryBy=rs1.getString("EntryBy");
	%>
	<tr>
	
	<%
	if(role.equals("Hr"))
	{
	%>
	<td class="text-center">	
	<button id="delete" type="button" class="btn btn-link text-dark p-0" onclick="return senddata(<%=SrNo%>)">Delete</button>
	</td>
	<%} %>
	
	<td class="text-center"><%=i%></td>
	<td class="text-left"><%=HoildayName%></td>
	<td class="text-left"><%=Day%></td>
	<td class="text-right"><%=dtf%></td>
	<td class="text-left"><%=EntryBy%></td>

</tr>	
<% 	
	  i++;
	}
%>
        </tbody>
 </table>
 </div>
 </div>

<!-- Add Holiday Modal -->
<div class="modal fade" id="AddHolidayModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Add Holiday</b></h4>
      <div class="row">
      <div class="col-md-3">				  
      <label for="dropdown"><b>SelectDate : </b></label>
      </div>
        <div class="col-md-6">
		   <input type="date" id="hdate" name="hdate" value="" style="height:90%; color: black;"  required="required">					
		</div>		
			<div class="col-md-3"></div>		
      </div>
      <div class="row mt-3">
 <div class="col-md-3">				  
   <label for="dropdown"><b>HolidayName : </b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="mycomments" name="mycomments"></textarea>
</div>
      			<div class="col-md-3"></div>		
      
      </div>
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return approve();">Submit</button>
      </div>
    </div>
  </div>
</div>

<!--Add Weekoff Modal -->
<div class="modal fade" id="AddWeekoffModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Add Week Off</b></h4>
   
      <div class="row">
      <div class="col-md-3">				  
      <label for="dropdown"><b>Year : </b></label>
      </div>
   <div class="col-md-6">
   <div class="input-group input-group-merge">
<select class="form-select" id="year" name="year">
    <%
        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        String selectedYear = request.getParameter("year");
        if (selectedYear == null || selectedYear.isEmpty()) {
            selectedYear = String.valueOf(currentYear); // Set to current year by default
    %>
    <%
        }
        for (int year1 = 2019; year1 <= 2030; year1++) {
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
			<div class="col-md-3"></div>		
      </div>
      <div class="row mt-2">
      <div class="col-md-3">				  
      <label for="dropdown"><b>Month : </b></label>
      </div>
   <div class="col-md-6">
		<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <%
        String[] months = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
        String[] monthsCapitalized = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
        
        String selectedMonth = request.getParameter("month");
        int currentMonthIndex = java.util.Calendar.getInstance().get(java.util.Calendar.MONTH);
        
        if (selectedMonth == null || selectedMonth.isEmpty()) {
            selectedMonth = months[currentMonthIndex]; // Set to current month
        }
    %>
    <%
        // Loop through the months array and create the options
        for (int j = 0; j < months.length; j++) {
            String monthValue = months[j];  // "MM" value for the option's value attribute
            String monthName = monthsCapitalized[j];  // Capitalized month name to display in the dropdown
            boolean isSelected = monthValue.equals(selectedMonth);  // Check if the month is selected
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
			<div class="col-md-3"></div>		
      </div>
      <div class="row mt-2">
      <div class="col-md-3">				  
      <label for="dropdown"><b>WeeklyOff : </b></label>
      </div>
   <div class="col-md-6">
  <div class="input-group input-group-merge">
<select class="form-select" id="day" name="day" onchange="chkall()">
    <%
        String selectedDay = request.getParameter("day");
        if (selectedDay == null || selectedDay.isEmpty()) {
            selectedDay = "1";  // Set default value as "1" for Sunday
        }
        String[] daysAbbreviated = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
        
        for (int j = 0; j < daysAbbreviated.length; j++) {
            String dayAbbr = daysAbbreviated[j];  // Abbreviated name to display (e.g., SUN)
            String dayValue = String.valueOf(j + 1);  // Numeric value for the option (1 for Sunday, 2 for Monday, etc.)
            boolean isSelected = dayValue.equals(selectedDay);  // Check if the current day is selected
    %>
    <option value="<%= dayValue %>" <%= isSelected ? "selected" : "" %>><%= dayAbbr %></option>
    <%
        }
    %>
</select>

		                  <script>
                            const mySel = document.getElementById("weekOff");

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
			<div class="col-md-3"></div>		
      </div>
      <div class="row mt-2">
       <div class="col-md-3">				  
      </div>
     <div class="col-md-7">
     <div id="checkboxlist" >
    1<sup>st</sup>&nbsp;<input type="checkbox" value="1" class="chk">&nbsp;
    2<sup>nd</sup>&nbsp;<input type="checkbox" value="2" class="chk">&nbsp;
    3<sup>rd</sup>&nbsp;<input type="checkbox" value="3" class="chk">&nbsp;
   	4<sup>th</sup>&nbsp;<input type="checkbox" value="4" class="chk">&nbsp;
    5<sup>th</sup>&nbsp;<input type="checkbox" value="5" class="chk">&nbsp;
    <div>
    	 
    </div>
</div>
      </div>
      </div>
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return getData();">Submit</button>
      </div>
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
	      /*    fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
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
		                        title: 'HolidayMaster '+$("#data").val()+ 'to' +$("#data1").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'HolidayMaster '+$("#data").val()+ 'to' +$("#data1").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'HolidayMaster '+$("#data").val()+ 'to' +$("#data1").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'HolidayMaster '+$("#data").val()+ 'to' +$("#data1").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'HolidayMaster '+$("#data").val()+ 'to' +$("#data1").val(), 
							},
					],
				},
           ], 

       });
   });
</script>
<script>
function senddata(srno)
{
	 var txt="Are You sure";
	 
	    if (confirm(txt)) {
	    	
	    	location.assign("insertHoliday1.jsp?action=remove&SrNo="+srno+""); 
	    }        
	 else {
	       
	        return false;
	    }

}
</script>
 <script type="text/javascript">
 window.onload = function() {
	    var currentDate = new Date();
	    var currentYear = currentDate.getFullYear();
	    var currentMonth = currentDate.getMonth(); 

	    var minDate = new Date(currentYear, currentMonth - 1, 1);
	    var minDateString = minDate.toISOString().split('T')[0];
	    document.getElementById('hdate').setAttribute('min', minDateString);
	};
	
function approve()
{
	
	var date=document.getElementById('hdate').value;
	if(date=="")
		{
		alert("Please Select Date");
		return false;
		}
		
    var currentDate = new Date();
    var currentMonth = currentDate.getMonth(); // 0-based index, 0 = January, 11 = December
    var currentYear = currentDate.getFullYear();

    var selectedDate = new Date(date);
    var selectedMonth = selectedDate.getMonth();
    var selectedYear = selectedDate.getFullYear();

    if (selectedYear < currentYear || (selectedYear == currentYear && selectedMonth < currentMonth - 1)) {
        alert("You cannot select a date before last month.");
        return false;
    }
    
	var com=document.getElementById("mycomments").value;
	if(com=='')
		{
		alert("Please Enter Holiday Name");
		return false;
		
		}
	
	var action='holiday';
	
	 location.assign("insertHoliday1.jsp?action="+action+"&date="+date+"&mycomments="+com+""); 	
}

</script>
<script type="text/javascript">
function chkall()
{
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	
	document.custreport.month.value=document.getElementById("month").value;
	
	document.custreport.year.value=document.getElementById("year").value;
	
	document.custreport.day.value=document.getElementById("day").value;

}

function getData()
{

	var year=document.getElementById('year').value;
	
	var month=document.getElementById('month').value;
	
	var day=document.getElementById('day').value;
	
	var weekoff='weekoff';
	
	var chkArray = [];
	
	/* look for all checkboes that have a parent id called 'checkboxlist' attached to it and check if it was checked */
	$("#checkboxlist input:checked").each(function() {
		chkArray.push($(this).val());
	});
	
	/* we join the array separated by the comma */
	var selected;
	selected = chkArray.join(',') ;
	
	/* check if there is selected checkboxes, by default the length is 1 as it contains one single comma */
	if(selected.length > 0){
		alert("You have selected " + selected);	
	}else{
		alert("Please check at least one of the checkbox");	
		return false;
	}
	
	 location.assign("insertHoliday1.jsp?action="+weekoff+"&year="+year+"&month="+month+"&day="+day+"&selected="+selected+""); 
	
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>