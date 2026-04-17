<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">


 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        scrollY: 350,
	        scrollX: true,
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'ERP Vehicle Summary Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'ERP Vehicle Summary Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'ERP Vehicle Summary Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'ERP Vehicle Summary Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'ERP Vehicle Summary Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     	
	    } );
	} );

</script>

</head>
<body>


<%
		Connection conn = null;
 
        Class.forName(DB_Driver);
        conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
  
		Statement st = null,st1 = null;
		st = conn.createStatement();
		st1 = conn.createStatement();
		
		String companyName="",customerType="",customerCode="",vehlist="",billYear="",billMonth="";

 		
 		companyName=request.getParameter("Company");
 		System.out.println("companyName :-"+companyName);
 		
 		customerType=request.getParameter("Type");
 		System.out.println("customerType :-"+customerType);
 		
 		customerCode=request.getParameter("Code");
 		System.out.println("customerCode :-"+customerCode);
 		
 		vehlist=request.getParameter("Vehlist");
 		System.out.println("vehlist :-"+vehlist);
 		
 		billYear=request.getParameter("billYear");
 		System.out.println("billYear :-"+billYear);
 		
 		billMonth=request.getParameter("billMonth");
 		System.out.println("billMonth :-"+billMonth);
 
 		
%>

 <div style="font-size: 1.5em; text-align: center; margin-top: 3.5em; margin-bottom: 0.4em;"><b>ERP Vehicle Summary</b></div>

 <div style="font-size: 1.5em; text-align: center; margin-top: 1.5em; margin-bottom: 0.4em;"><b><%=companyName%>_<%=customerCode%></b></div>

<form name="ledgerDetails" action="ReAllocationNewAction.jsp"  method="post">
<br>
<input type="submit" name="Assign" id="Assign" value="Assign" style="margin-left:1%;margin-bottom:2%;width:10%;"/>		
<br>
		
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 
<thead>
<tr>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">SrNo</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Vehicle Id</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Vehicle No.</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Transporter</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">ERP Code</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">ERP Customer Name</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Group Code</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Group Name</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">Invoice Ref No.</th>
</tr>
</thead>
		
<tbody>
<% 
String VehicleId="";
String VehicleNo="";
String Transporter ="";
String ERPCode ="";
String ERPCustName ="";
String GroupCode ="";
String GroupName ="";
String InvoiceRefNo ="";
int i=1;

String Svehlist2= "('0";
String data="";
if(vehlist!=null){
	Svehlist2=vehlist;
	data=Svehlist2;
	
	 String data1=data.replaceAll(",","','");
     
	 String data2="'"+data1+"'";
     
     System.out.println("Data1:- "+data1);
     System.out.println("Data2:- "+data2);


String sql="select Vehid,VehRegno,Transporter,ERPCode,ERPCustName,GroupCode,GroupName,InvoiceRefNo from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+billYear+"_"+billMonth+" where vehid in ("+data2+") order by ERPCode,ERPCustName";
        System.out.println(sql);
        ResultSet rs=st.executeQuery(sql);

		      while(rs.next()){
		    	  		
		    	  VehicleId=rs.getString("Vehid");
		    	  //System.out.println("VehicleId is : "+VehicleId);		    	  
		    	  VehicleNo=rs.getString("VehRegno");		    	  
		    	  Transporter=rs.getString("Transporter");
		    	  ERPCode=rs.getString("ERPCode");
		    	  ERPCustName=rs.getString("ERPCustName");
		    	  GroupCode=rs.getString("GroupCode");
		    	  GroupName=rs.getString("GroupName");
		    	  InvoiceRefNo=rs.getString("InvoiceRefNo");
		    	         
		    /* 	  System.out.println("----------------> Svehlist.."+Svehlist2);
		  
		    		data1=Svehlist2.replace("0,", ""); */
		      
       %>
<tr align="center" >
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=VehicleId%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=VehicleNo%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Transporter%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ERPCode%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=ERPCustName%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=GroupCode%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=GroupName%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=InvoiceRefNo%></td>

 </tr>
<%
     i++;
         }
}
%>
</tbody>	
</table>
	        <input type="hidden" name="Company" id="Company" value="<%=companyName%>">			
	        <input type="hidden" name="Type" id="Type" value="<%=customerType%>">			
	        <input type="hidden" name="Code" id="Code" value="<%=customerCode%>">			
	        <input type="hidden" name="vehlst" id="vehlst" value="<%=vehlist%>">			
			<input type="hidden" name="billYear" id="billYear" value="<%=billYear%>">
			<input type="hidden" name="billMonth" id="billMonth" value="<%=billMonth%>">
			
</form>
</body>
</html>