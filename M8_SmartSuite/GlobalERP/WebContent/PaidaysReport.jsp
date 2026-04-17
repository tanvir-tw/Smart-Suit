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
String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();
String sessionname=session.getAttribute("EmpName").toString();

String selected1="",Bt="",action="",emp_id1="",month12="",year12="";
int cnt=0,i=1;
String sql_active=null,user_id1 = "";
String query="",Present="",Late="",HalfDay="",Absent="",ApprovedLeave="",OffLeave="",OffHalfDay="",Holiday="",WeekOff="",Sandwich="",paidleave="",Paiddays="";
 
// Connection Initialization
Connection conn = null;
Statement st_user_id = null,st=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st_user_id = conn.createStatement();
	st = conn.createStatement();
	
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
	 selected1=request.getParameter("dept");
	 action=request.getParameter("action");
	 emp_id1=request.getParameter("empId");
	 month12=request.getParameter("month12");
	 year12=request.getParameter("year12");
	 
	 System.out.println("month12"+month12);
	 System.out.println("year12"+year12);

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Paid Days Status Report</h5>
    </div>
</div>

  <form name="formreport" id="formreport" method="post" onsubmit="return validate()">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
<%
    String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
    
    String selectedMonth = request.getParameter("month");

    // If no month selected, set default to previous month
    if (selectedMonth == null || selectedMonth.isEmpty() || selectedMonth.equals("Select")) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int currentMonthIndex = cal.get(java.util.Calendar.MONTH); // 0 = Jan
        
        int previousMonthIndex = currentMonthIndex - 1;
        if (previousMonthIndex < 0) {
            previousMonthIndex = 11; // December
        }

        selectedMonth = months[previousMonthIndex];
    }
%>

<option value="Select">Select</option>

<%
    for (String month : months) {
        boolean isSelected = month.equals(selectedMonth);
%>
    <option value="<%= month %>" <%= isSelected ? "selected" : "" %>>
        <%= month %>
    </option>
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
                              localSorage.settItem("selValue", this.value); // 
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

    // If no year selected, set current year
    if (selectedYear == null || selectedYear.isEmpty() || selectedYear.equals("Select")) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int currentYear = cal.get(java.util.Calendar.YEAR);
        selectedYear = Integer.toString(currentYear);
    }
%>

<option value="Select">Select</option>

<%
    for (int year = 2018; year <= 2050; year++) {
        boolean isSelected = Integer.toString(year).equals(selectedYear);
%>
    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>>
        <%= year %>
    </option>
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
<%
 action=request.getParameter("action");
 emp_id1=request.getParameter("empId");
 month12=request.getParameter("month12");
 year12=request.getParameter("year12");
 Bt=request.getParameter("button");

if(action==null)
{
	action="-";
}
if(emp_id1==null)
{
	emp_id1="-";
}
if(month12==null)
{
	month12="-";
}
if(year12==null)
{
	year12="-";
}


if (Sesrole1.equals("HOD"))
{
	dept="%%";
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept like  '"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}else if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("Hr") )
{
	dept="%%";
	
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
}else{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}

System.out.println("The EmpCode Id query is ==>>"+sql_active);

ResultSet rs_active = st_user_id.executeQuery(sql_active);

while(rs_active.next()){
++cnt;
if(cnt == 1)
{
	user_id1 = rs_active.getString("user_id");
	user_id1="\'"+user_id1+"\'";
}else
{
	user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
}

}

String year1=request.getParameter("year");

if(year1==null)
{
	year1="1999";
	
}
else 
{
	 year1=request.getParameter("year");
}
String month1=request.getParameter("month");
if(month1==null)
	
{
	month1="13";
	
}
else
{
	month1=request.getParameter("month");
}

DecimalFormat df = new DecimalFormat("0.00");
%>

<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
						<th>Name</th>
						<th>ID</th>
						<th>D1</th>
						<th>D2</th>
						<th>D3</th>
						<th>D4</th>
						<th>D5</th>
						<th>D6</th>
						<th>D7</th>
						<th>D8</th>
						<th>D9</th>
						<th>D10</th>
						<th>D11</th>
						<th>D12</th>
						<th>D13</th>
						<th>D14</th>
						<th>D15</th>
						<th>D16</th>
						<th>D17</th>
						<th>D18</th>
						<th>D19</th>
						<th>D20</th>
						<th>D21</th>
						<th>D22</th>
						<th>D23</th>
						<th>D24</th>
						<th>D25</th>
						<th>D26</th>
						<th>D27</th>
						<th>D28</th>
						<th>D29</th>
						<th>D30</th>
						<th>D31</th>
						<th>Present</th>
						<th>Late</th>
						<th>HalfDay</th>
						<th>Absent</th>
						<th>ApprovedLeave</th>
						<th>OffLeave</th>
						<th>OffHalfDay</th>
						<th>Holiday</th>
						<th>WeekOff</th>
						<th>Sandwich</th>
						<th>PaidLeave</th>
						<th>PaidDays</th>
					</tr>
        </thead> 
        <tbody>
        <%
	
	if(action.equals("payroll")&& (Bt==null))
	{
	//query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where  Month='"+month12+"' and Year='"+year12+"' and ID='"+emp_id1+"'";	
	query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where  Month='"+month12+"' and Year='"+year12+"' and ID='"+emp_id1+"'";
	
	}
	else if(action.equals("payroll")&& (Bt!=null))
	{
		//query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where  Month='"+month1+"' and Year='"+year1+"' and ID='"+emp_id1+"'";
		query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where  Month='"+month1+"' and Year='"+year1+"' and ID='"+emp_id1+"'";
	}
	else
	{
		//query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+user_id1+")";
		query="select ID,Name,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Present,Late,HalfDay,Absent,ApprovedLeave,OffLeave,OffHalfDay,Holiday,WeekOff,Sandwich,paidleave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+user_id1+")";
	}
	
System.out.println("Query :- "+query);
ResultSet rs13=st.executeQuery(query);
while(rs13.next())
{
	
	Present=rs13.getString("Present");
	Late=rs13.getString("Late");
	HalfDay=rs13.getString("HalfDay");
	Absent=rs13.getString("Absent");
	ApprovedLeave=rs13.getString("ApprovedLeave");
	OffLeave=rs13.getString("OffLeave");
	OffHalfDay=rs13.getString("OffHalfDay");
	Holiday=rs13.getString("Holiday");
	WeekOff=rs13.getString("WeekOff");
	Sandwich=rs13.getString("Sandwich");
	paidleave=rs13.getString("paidleave");
	Paiddays=rs13.getString("Paiddays");
	%>
	<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-left"><%=rs13.getString("Name")%></td>
	<td class="text-center"><%=rs13.getString("ID")%></td>
	<td class="text-left"><%=rs13.getString("D1")%></td>
	<td class="text-left"><%=rs13.getString("D2")%></td>
	<td class="text-left"><%=rs13.getString("D3")%></td>
	<td class="text-left"><%=rs13.getString("D4")%></td>
	<td class="text-left"><%=rs13.getString("D5")%></td>
	<td class="text-left"><%=rs13.getString("D6")%></td>
	<td class="text-left"><%=rs13.getString("D7")%></td>
	<td class="text-left"><%=rs13.getString("D8")%></td>
	<td class="text-left"><%=rs13.getString("D9")%></td>
	<td class="text-left"><%=rs13.getString("D10")%></td>
	<td class="text-left"><%=rs13.getString("D11")%></td>
	<td class="text-left"><%=rs13.getString("D12")%></td>
	<td class="text-left"><%=rs13.getString("D13")%></td>
	<td class="text-left"><%=rs13.getString("D14")%></td>
	<td class="text-left"><%=rs13.getString("D15")%></td>
	<td class="text-left"><%=rs13.getString("D16")%></td>
	<td class="text-left"><%=rs13.getString("D17")%></td>
	<td class="text-left"><%=rs13.getString("D18")%></td>
	<td class="text-left"><%=rs13.getString("D19")%></td>
	<td class="text-left"><%=rs13.getString("D20")%></td>
	<td class="text-left"><%=rs13.getString("D21")%></td>
	<td class="text-left"><%=rs13.getString("D22")%></td>
	<td class="text-left"><%=rs13.getString("D23")%></td>
	<td class="text-left"><%=rs13.getString("D24")%></td>
	<td class="text-left"><%=rs13.getString("D25")%></td>
	<td class="text-left"><%=rs13.getString("D26")%></td>
	<td class="text-left"><%=rs13.getString("D27")%></td>
	<td class="text-left"><%=rs13.getString("D28")%></td>
	<td class="text-left"><%=rs13.getString("D29")%></td>
	<td class="text-left"><%=rs13.getString("D30")%></td>
	<td class="text-left"><%=rs13.getString("D31")%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("Present"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("Late"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("HalfDay"))%></td>
	<td class="text-center"><%=rs13.getString("Absent")%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("ApprovedLeave"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("OffLeave"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("OffHalfDay"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("Holiday"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("WeekOff"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("Sandwich"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("paidleave"))%></td>
	<td class="text-center"><%=df.format(rs13.getDouble("Paiddays"))%></td>

	</tr>
	<% 
	i++;
}

%>
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
	        keys: true,  //Keytable
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
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A0',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
	  	                      orientation: 'landscape',
	                            pageSize: 'A0'
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
							},
 
					],
				},
				
           ], 
       
       });

   });
   
</script>
<script>
function validate() {
		
		var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
		if(month=="Select")
			{
			alert("Please select Month");
			return false;
			}
		
		var year=document.getElementById("year").options[document.getElementById("year").selectedIndex].value;
		if(year=="Select")
		{
		alert("Please select Year");
		return false;
		}
				
	}
	
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>