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
Connection conn = null;
Statement st1=null,st2=null;

try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Payroll Report</h5>
    </div>
</div>
<form name="registrationform" enctype="multipart/form-data" action="payrollUpload.jsp" method="post">
<div class="row align-items-end">
    
    <div class="col-md-1"></div>

    <div class="col-md-3">
        <label><b>Upload Payroll Excel</b></label>
        <input class="form-control form-control-sm" type="file" id="Filename" name="Filename">
    </div>

    <div class="col-md-2">
        <button type="button" class="btn btn-primary" id="button" onclick="document.registrationform.submit();"> Upload </button>
    </div>

    <input type="hidden" name="uploadedby" value="<%=session.getAttribute("leaveempname")%>" />

</div>
</form>
<br>
 <form name="payablereport" id="payablereport" method="post">
<%int yyyy = Calendar.getInstance().get(Calendar.YEAR); %>
<%
String m1="";
			int year=0;
			try{
				m1=request.getParameter("month");System.out.println(",,,,,,,,,,,,,,"+m1);
			    year=Integer.parseInt(request.getParameter("year"));%>
					<%
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					String bt = request.getParameter("button");
					%>
<div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Month</b></label>
				<div class="input-group input-group-merge">
				    <select class="form-select" id="month" name="month">
				        <%
				            String[] months = {
				                "January","February","March","April","May","June",
				                "July","August","September","October","November","December"
				            };
				
				            for(int i = 0; i < months.length; i++) {
				                String value = String.valueOf(i + 1);
				        %>
				            <option value="<%=value%>" 
				                <%= (m1 != null && m1.equals(value)) ? "selected" : "" %>>
				                <%=months[i]%>
				            </option>
				        <%
				            }
				        %>
				    </select>
				     <script>
                            const mySel1 = document.getElementById("month");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel1.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel1.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel1.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
				</div>
			</div>
			<div class="col-md-2">
				  <label for="dropdown"><b>year</b></label>
				<div class="input-group input-group-merge">
				    <select class="form-select" id="year" name="year">
				       <%for(int i=yyyy;i>2000;i--){ %>
						<%if(i==year){ %><option value="<%=i%>" selected="selected"><%=i%></option>
						<%}else{ %><option value="<%=i%>"><%=i%></option>
						<%}} %>
				    </select>
				     <script>
                            const mySel1 = document.getElementById("year");

                            // Check if btn (bt) is null
                             const isBtNull = <%= bt == null %>;

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel1.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel1.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel1.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
				</div>
			</div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			<div class="col-md-1">
			</div>			
</div>
</form>
<br>
	
			<% 
 String qry = "select count(*) from t_payable where Status='Active'";
 System.out.println(qry);
 ResultSet rs = st1.executeQuery(qry); 
 int cnt=0;
 if(rs.next())
 {
	 cnt=rs.getInt(1);
 }%>
 
 <table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th>Edit</th>
						<th>PDF</th>
						<th>Pay OrderNO</th>
						<th>Contractor Id</th>
						<th>Contractor Name</th>
						<th>Month</th>
						<th>Year</th>
						<th>Date</th>
						<th>Payable Days</th>
						<th>Basic</th>
						<th>Per Index %</th>
						<th>Allowance</th>
						<th>Allowance1</th>
						<th>Allowance2</th>
						<th>Allowance3</th>
						<th>Allowance4</th>
						<th>Deduction</th>
						<th>Deduction1</th>
						<th>Deduction2</th>
						<th>Deduction3</th>
						<th>Deduction4</th>
						<th>Previous Pay</th>
						<th>TDS</th>
						<th>Gross Pay</th>
						<th>Net Pay</th>
						<th>Status</th>
					</tr>
			</thead>
			<tbody>
<%   
 String date ="";
 
 qry = "select * from t_payable where Status='Active' and month='"+m1+"' and year='"+year+"'";
 System.out.println(qry);
 rs = st2.executeQuery(qry);

 int i=0;
  
  while(rs.next())
  { ++i;
	  int month=rs.getInt("month");
	  String month1="";
	  switch(month)
	  {
	  case 1:month1="Jan";
	          break;
	  case 2:month1="Feb";
      break;
	  case 3:month1="Mar";
      break;
	  case 4:month1="Apr";
      break;
	  case 5:month1="May";
      break;
	  case 6:month1="June";
      break;
	  case 7:month1="July";
      break;
	  case 8:month1="Aug";
      break;
	  case 9:month1="Sep";
      break;
	  case 10:month1="Oct";
      break;
	  case 11:month1="Nov";
      break; 
	  case 12:month1="Dec";
      break;
      
     // default : month1="Invalid month";
       
	    }
	  
	  try
	  {
    date = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("updatedate")));  
	  }
	  
    catch(Exception e) {System.out.println("Date Format Exception"+e);}
    %>
					<tr>
						<td class="text-right"><a href="payableEdit.jsp?payno=<%=rs.getString("PayNo")%>">
						<img src="images/edit1.jpeg" width="18px" height="18px"></img></a></td>
						<td class="text-center"><input type="checkbox" id=check <%=i%> /></td>
						<td class="text-center" id=<%=i%> ><%=rs.getString("PayNo") %></td>
						<td class="text-center"><%=rs.getString("EmpId") %></td>
						<td class="text-right"><%=rs.getString("contractorName") %></td>
						<td class="text-right"><%=month1 %></td>
						<td class="text-right"><%=rs.getString("year") %></td>
						<td class="text-right"><%=date %></td>
						<td class="text-right"><%=rs.getString("payableDays") %></td>
						<td class="text-right"><%=rs.getString("basic") %></td>
						<td class="text-right"><%=rs.getString("perIndex") %></td>
						<td ><%=rs.getString("allowance") %></td>
						<td class="text-right"><%=rs.getString("allowance1") %></td>
						<td class="text-right"><%=rs.getString("allowance2") %></td>
						<td class="text-right"><%=rs.getString("allowance3") %></td>
						<td class="text-right"><%=rs.getString("allowance4") %></td>
						<td class="text-right"><%=rs.getString("deduction") %></td>
						<td class="text-right"><%=rs.getString("deduction1") %></td>
						<td class="text-right"><%=rs.getString("deduction2") %></td>
						<td class="text-right"><%=rs.getString("deduction3") %></td>
						<td class="text-right"><%=rs.getString("deduction4") %></td>
						<td class="text-right"><%=rs.getString("PreviousPay") %></td>
						<td class="text-right"><%=rs.getString("tds") %></td>
						<td class="text-right"><%=rs.getString("grosspay") %></td>
						<td class="text-right"><%=rs.getString("Netpay") %></td>
						<td class="text-right"><%=rs.getString("Status") %></td>
					</tr>

					<% }
  %>
				</table>
				
			<div>
				<input type="submit" class="btn btn-primary" id="button" name="AllPdfCreate" value="Generate payslip" onclick="Pdfredirect('pdf_payable.jsp','<%=i%>');">
			</div>
					
</div>	
<script type="text/javascript">
	function allcheck(count)
	{ //alert("call"+count); 
		if(document.getElementById("checkAll").checked==true)
	   {	for(var i=1;i<=count;i++)
			{document.getElementById("check"+i).checked=true;
		    }
	   }
	   else
	   {
		   for(var i=1;i<=count;i++)
			{document.getElementById("check"+i).checked=false;
		    }
	   }
	}
	
	function Pdfredirect(webadd,count)
	{
	 var payno="";
	 
	 	 for(var i=1;i<=count;i++)
		 {if(document.getElementById("check"+i).checked==true)
		   { 
			payno=payno+" "+document.getElementById(i).innerHTML;
		   }
		  }
	 	 payno.trim();
	 	 if(payno=="")
	 	 {alert("Please Select the CheckBox.");
		 return false;}
	 	 //alert(payno);
		window.open(webadd+'?Payno='+payno);
	}
</script>	
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
		                        title: 'payable Report '+$("#month").val()+' - ' +$("#year").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'payable Report '+$("#month").val()+' - ' +$("#year").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'payable Report '+$("#month").val()+' - ' +$("#year").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'payable Report '+$("#month").val()+' - ' +$("#year").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'payable Report '+$("#month").val()+' - ' +$("#year").val(),
							},
 
					],
				},
           ], 
       
       });
   });
</script>
<%@include file="footer.jsp"%>
</body>
</html>