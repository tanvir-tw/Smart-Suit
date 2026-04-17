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
String bt="",mname="",yname="";
int i=1,cnt = 0;
String Status="",Name="",oldPiindex="",newPiindex="",oldKraindex="",newKraIndex="",oldPaiddays="",newPaiddays="",EntryBy="",EntryDate="",Revision="",ContractorId="",Month="",Year="",IncentiveOld="",IncentiveNew="",PreviousOld="",PreviousNew="",OtherOld="",Othernew="";
String colour="",dtt="";

// Connection Initialization
Connection conn = null;
Statement st=null,st1=null;

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
	if (bt== null || bt.equals("null")) {		

	String query="SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH), '%b') AS MonthName, YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS Year";

	ResultSet rsdata=st.executeQuery(query);
	if(rsdata.next())
	{
		mname=rsdata.getString("MonthName").toUpperCase();
		yname=rsdata.getString("Year");
	}
	
	System.out.println("Yname:-------------------->"+yname);
	System.out.println("Mname--------------------->:"+mname);
	}
	else{
		mname=request.getParameter("month");
		yname=request.getParameter("year");
		
	}
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Revision History for <%=mname %> <%=yname %> Payroll</h5>
    </div>
</div>

  <form name="formreport" id="formreport" method="post" onsubmit="return validateMonthYear(document.getElementById('month'), document.getElementById('year'))">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <option value="Select">Select</option>

    <%
        String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};

    %>
    <%
    String selectedMonth = request.getParameter("month");

        for (String month : months) {
            boolean isSelected = month.equals(selectedMonth);  // Check if the current month is selected
    %>
    <option value="<%= month %>" <%= isSelected ? "selected" : "" %>><%= month %></option>
    <%
        }
    %>
</select>
			
		                  <script>
		                  window.addEventListener("DOMContentLoaded", function () {

	                            const mySel = document.getElementById("month");
	                            if (mySel.value === "Select" || mySel.value === "") {
	                                let d = new Date();
	                                d.setMonth(d.getMonth() - 1); // go back one month
	                                const prevMonth = d.toLocaleString("en-US", { month: "short" }).toUpperCase();
	                                mySel.value = prevMonth;
	                              }
	                            
	                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localSorage.settItem("selValue", this.value); // 
                              });
		                  });
                             </script>			
		  		       </div>              
			</div>	
			<div class="col-md-2">
				  <label for="year"><b>Year</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="year" name="year">
            <option value="Select">Select</option>
    <%
        String selectedYear = request.getParameter("year");

        for (int year = 2018; year <= 2050; year++) {
            boolean isSelected = Integer.toString(year).equals(selectedYear);
    %>
    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>><%= year %></option>
    <%
        }
    %>
</select>
		                  <script>
		                  window.addEventListener("DOMContentLoaded", function () {
		                      const yearSel = document.getElementById("year");

		                      // If no value is selected, set PREVIOUS month’s year
		                      if (yearSel.value === "Select" || yearSel.value === "") {
		                        let d = new Date();
		                        d.setMonth(d.getMonth() - 1); // move to previous month
		                        const prevYear = d.getFullYear(); // get correct year for that month
		                        yearSel.value = prevYear;
		                      }
		                      
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                            	 yearSel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                            	 yearSel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              yearSel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
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

<%
String year1=request.getParameter("year");
System.out.println("year1"+year1);

if(year1==null)
{
	year1=yname;
	
}
else 
{
	 year1=request.getParameter("year");
}
String month1=request.getParameter("month");
System.out.println("month1"+month1);

if(month1==null)
	
{
	month1=mname;
	
}
else
{
	month1=request.getParameter("month");
}

%>

<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>User Id</th>
            <th>Name</th>
            <th>Status</th>
            <th>PI</th>
            <th>New PI</th>
            <th>KRA</th>
            <th>New KRA</th>
            <th>Paid Days</th>
            <th>New Paid Days</th>
            <th>Incentive</th>
            <th>New Incentive</th>
            <th>Previous</th>
            <th>New Previous</th>
            <th>Other</th>
            <th>New Other</th>
            <th>Revise Date</th>			
		</tr>
        </thead> 
        <tbody>
        <%
        String empdetails="select Name,oldPiindex,newPiindex,Status,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where Month='"+month1+"' and Year='"+year1+"' ";
		ResultSet rs = st.executeQuery(empdetails);
		System.out.println("The query is ==>>"+empdetails);


while(rs.next())
{
	++cnt;
	Name=rs.getString("Name");
	oldPiindex=rs.getString("oldPiindex");
	newPiindex=rs.getString("newPiindex");
	oldKraindex=rs.getString("oldKraindex");
	newKraIndex=rs.getString("newKraIndex");
	oldPaiddays=rs.getString("oldPaiddays");
    newPaiddays=rs.getString("newPaiddays");
	EntryBy=rs.getString("EntryBy");

	ContractorId=rs.getString("ContractorId");
	Month=rs.getString("Month");
	Year=rs.getString("Year");
	IncentiveOld=rs.getString("IncentiveOld");

	EntryDate=rs.getString("EntryDate");
	
	dtt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
			.format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
			        .parse(EntryDate));
	
	IncentiveNew=rs.getString("IncentiveNew");
	PreviousOld=rs.getString("PreviousOld");
	PreviousNew=rs.getString("PreviousNew");
	OtherOld=rs.getString("OtherOld");
	Othernew=rs.getString("Othernew");
	Status=rs.getString("Status");


if(Status.equals("Approved"))
{
	colour="Green";
}
else if(Status.equals("Pending"))
{
	colour="Blue";
}
else if(Status.equals("Rejected"))
{
	colour="Red";
}
else if(Status.equals("Duplicate"))
{
	colour="Black";
}


%>

<tr>
		<td class="text-center"><%= cnt %></td>
	    <td class="text-center"><%=ContractorId %></td>
	    <td class="text-center"><%= Name  %></td>
	    <td class="text-center" style="color:<%=colour %>"><%= Status  %></td>
	    <td class="text-center"><%= oldPiindex %></td>
		<td class="text-center"><%= newPiindex %></td>
		<td class="text-center"><%= oldKraindex %></td>
		<td class="text-center"><%= newKraIndex  %></td>
		<td class="text-center"><%= oldPaiddays %></td>
		<td class="text-center"><%= newPaiddays  %></td>
		<td class="text-center"><%= IncentiveOld %></td>
		<td class="text-center"><%= IncentiveNew  %></td>
		<td class="text-center"><%= PreviousOld %></td>
		<td class="text-center"><%= PreviousNew  %></td>
		<td class="text-center"><%= OtherOld %></td>
		<td class="text-center"><%= Othernew  %></td>
		<td class="text-center"><%= dtt  %></td>
		
		</tr> 
		<%} %>
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
	            left: 3      //To freeze two columns
	        }, 
	       // keys: true,  //Keytable
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
	  	                        title: 'Revise Pay Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	  	                        title: 'Revise Pay Report '+$("#month").val()+'-'+$("#year").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	  	                        title: 'Revise Pay Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	  	                        title: 'Revise Pay Report '+$("#month").val()+'-'+$("#year").val(), 
	  	                      orientation: 'landscape',
	                            pageSize: 'A0'
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	  	                        title: 'Revise Pay Report '+$("#month").val()+'-'+$("#year").val(), 
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