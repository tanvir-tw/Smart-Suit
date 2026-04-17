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
String dt1="",Name="",oldPiindex="",newPiindex="",oldKraindex="",newKraIndex="",oldPaiddays="",newPaiddays="",EntryBy="",EntryDate="",Revision="",ContractorId="",Month="",Year="",IncentiveOld="",IncentiveNew="",PreviousOld="",PreviousNew="",OtherOld="",Othernew="";
DecimalFormat df = new DecimalFormat("0.00");
int ck=0,cnt = 1;

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
	String mname="",yname="";
	String query="SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH), '%b') AS MonthName, YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS Year";

	ResultSet rsdata=st.executeQuery(query);
	if(rsdata.next())
	{
		mname=rsdata.getString("MonthName").toUpperCase();
		yname=rsdata.getString("Year");
	}
	
	System.out.println("Yname:-------------------->"+yname);
	System.out.println("Mname--------------------->:"+mname);
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Revise Pay Pending Approval Report</h5>
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
<form name="indexReport11" id="indexReport11" method="get" onsubmit="return handleApprove()" action="ActionApprovePay.jsp">
 <div class="row col-12 mt-4 mb-2">
    <div class="col-md-3" style="width:10%;">
         <button type="submit" 
                 class="btn btn-primary" 
                 id="Approve" 
                 name="Approve" 
                 value="Approve" 
                 style="line-height: 1; font-size: 15px; background-color:#1582AB;">
             Approve
         </button>
    </div>

    <div class="col-md-2">
        <button type="button" 
                 class="btn btn-primary" 
                 id="button" 
                 name="button" 
                 onclick="getcheckedrow1()">
            Reject
        </button>
    </div>
</div>


<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>
				<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
				<font color="white" style="font-size:12px;">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
				<a href="#" onclick="unCheckAll()"> <font color="white" style="font-size:12px;">UnChk</font></a>
			</th>
			<th>User Id</th>
	        <th>Name</th>
            <th>PI</th>
            <th>New PI</th>
            <th>KRA</th>
            <th>New KRA</th>
            <th>Paid Days</th>
            <th>New Paid Days</th>
            <th>Incentive</th>
            <th>New Incentive </th>
            <th>Arriers</th>
            <th>New Arriers</th>
            <th>Other</th>
            <th>New Other</th>
            <th>Revise Date</th>
						
		</tr>
        </thead> 
        <tbody>
        <%
        String sql_total="select Name,oldPiindex,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where Month='"+month1+"' and Year='"+year1+"' and Status='Pending'";
		System.out.println("The query is ==>>"+sql_total);

		ResultSet rs = st1.executeQuery(sql_total);
		while(rs.next()){
			
			Name=rs.getString("Name");
			oldPiindex=rs.getString("oldPiindex");
			newPiindex=rs.getString("newPiindex");
			oldKraindex=rs.getString("oldKraindex");
			newKraIndex=rs.getString("newKraIndex");
			oldPaiddays=rs.getString("oldPaiddays");
			newPaiddays=rs.getString("newPaiddays");
			EntryBy=rs.getString("EntryBy");
			EntryDate=rs.getString("EntryDate");

			 dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(EntryDate));
			
			ContractorId=rs.getString("ContractorId");
			Month=rs.getString("Month");
			Year=rs.getString("Year");
			IncentiveOld=rs.getString("IncentiveOld");
			IncentiveNew=rs.getString("IncentiveNew");
			PreviousOld=rs.getString("PreviousOld");
			PreviousNew=rs.getString("PreviousNew");
			OtherOld=rs.getString("OtherOld");
			Othernew=rs.getString("Othernew");
			
		%>
 <tr>
		<td class="text-center"><%= cnt %></td>
		<td class="text-center"><input type="checkbox"  name="check<%=ck %>"   id="check<%=ck %>" class="chkbx" /></td>
	    <%-- <td><div align="right" name="net_id1<%=ck %>" id="net_id1<%=ck %>" ><%=ContractorId %></div></td> --%>
	    
	    <td class="text-center"><div class="text-center"><input type="text" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border:none; text-align:right;font: normal 11px Arial, Helvetica, sans-serif;" value="<%=ContractorId%>" readonly/></div></td>
			
	    <td class="text-left"><%=Name%></td>
	    <td class="text-center"><%= oldPiindex %></td>
	    
	    <td class="text-right"><div><input type="text" id="newPiindex<%=ck %>" name="newPiindex<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=newPiindex%>" /></div></td>

<%-- 		<td class="text-left"><%= newPiindex %></td>
 --%>		
		<td class="text-center"><%= oldKraindex %></td>
		
		  <td class="text-right"><div><input type="text" id="newKraIndex<%=ck %>" name="newKraIndex<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=newKraIndex%>" /></div></td>
<%-- 		<td class="text-right"><%= newKraIndex  %></td>
 --%>		
		<td class="text-center"><%= oldPaiddays %></td>
		
		
		<td class="text-right"><div><input type="text" id="newPaiddays<%=ck %>" name="newPaiddays<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=newPaiddays%>" /></div></td>
			
<%-- 		<td class="text-right"><%= newPaiddays  %></td>
 --%>		
		<td class="text-center"><%= IncentiveOld %></td>
		
		<td style="width: 85px;" class="text-right"><div><input type="text" id="IncentiveNew<%=ck %>" name="IncentiveNew<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=IncentiveNew%>" /></div></td>
			
<%-- 		<td class="text-right"><%= IncentiveNew  %></td>
 --%>		
		<td class="text-center"><%= PreviousOld %></td>
		
		<td class="text-right"><div><input type="text" id="PreviousNew<%=ck %>" name="PreviousNew<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=PreviousNew%>" /></div></td>
			
<%-- 		<td class="text-right"><%= PreviousNew  %></td>
 --%>		
		<td class="text-center"><%= OtherOld %></td>
		
		<td class="text-right"><div><input type="text" id="Othernew<%=ck %>" name="Othernew<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=Othernew%>" /></div></td>
			
<%-- 		<td class="text-right"><%= Othernew  %></td>
 --%>		
 		<td class="text-right" ><%=dt1 %></td>

		<%-- <td class="text-right"><%= df.format(Task_dur1)%></td> --%>

		</tr> 

	<% 
	cnt++;
	ck++;}

%>
</tbody>
 </table>
 
 <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
    <input type="hidden" name="Month" id="Month" value="<%=month1 %>">
     <input type="hidden" name="id" id="id" value=<%=ContractorId %>> 	
    
    <input type="hidden" name="Year" id="Year" value="<%=year1 %>">
 
 </form>
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
<script>
function handleApprove() {
    // 1. Get the total count of rows
    var ck = document.getElementById("checkedNumber").value;
    var isAnyChecked = false;

    // 2. Check if at least one checkbox is ticked
    // We loop from 0 to ck-1 to match your 'check0', 'check1' IDs
    for (var i = 0; i < ck; i++) {
        var checkbox = document.getElementById("check" + i);
        if (checkbox && checkbox.checked) {
            isAnyChecked = true;
            break; 
        }
    }
    if (!isAnyChecked) {
        alert("Please select at least one row to Approve.");
        return false; 
    }
    var confirmed = confirm("Are you sure you want to approve the selected records?");
    if (!confirmed) {
        return false; // Stops if user clicks 'Cancel'
    }

    // 5. Run your existing data gathering logic if you have it
    if (typeof getcheckedrow === "function") {
        getcheckedrow();
    }

    return true; // Proceed to ActionApprovePay.jsp
}


function getcheckedrow1() {
    // 1. Get the total row count
    var ck = document.getElementById("checkedNumber").value;
    var isAnyChecked = false;

    // 2. Loop to see if at least one checkbox is selected
    for (var i = 0; i < ck; i++) {
        var checkbox = document.getElementById("check" + i);
        if (checkbox && checkbox.checked) {
            isAnyChecked = true;
            break; 
        }
    }

    // 3. If NO checkbox is selected, show the Reject-specific alert
    if (!isAnyChecked) {
        alert("Please select at least one row to Reject.");
        return false; // Stop right here
    }

    // 4. If selected, ask for confirmation
    if (confirm("Are you sure you want to Reject the selected records?")) {
        // 5. If confirmed, manually submit the form to the Action page
        // We add a URL parameter so the Action page knows it's a Rejection
        document.indexReport11.action = "ActionApprovePay.jsp?Approve=Reject";
        document.indexReport11.submit();
    }
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
			 document.getElementById("check"+chk).checked = true;
		 }

		 chk++;
		
	}
}catch(e){alert(e);}
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
}catch(e){alert(e);}
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>