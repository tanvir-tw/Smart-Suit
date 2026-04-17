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
	Connection conn;
	ResultSet rs1 = null;
	Statement stmt = null;
	
	int PRNNo = 0;
	String sql = "";
	String PRNRefNo = "", Name = "", ItemName = "", group = "", make = "", model = "",
			partNo = "", ItemCode = "", Quantity = "", remark = "",
			status = "", UpdatedDateTime="" , Purchase_RefNo="", PO_No="" , ProjectName="";

	String comid = session.getAttribute("CompanyMasterID").toString();
	String sessiondept = session.getAttribute("department").toString();
	String RefNo = request.getParameter("RefNo");
	
	try {
		conn = connection.getConnect("db_GlobalERP");    
		stmt=conn.createStatement();
		
	} catch (Exception e) {
	    e.printStackTrace();
	} 
%>
<%

%>

<input type="hidden" id="sesname" name="sesname" />
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Purchase PRN Report-<%=RefNo%></h5>
    </div>
</div>

<form action="PRNItemAction.jsp" onsubmit="return Check()">

<% if(sessiondept.equals("Purchase")){ %>
<div align="center">
    <input type="submit" name="submit" id="sub" value="Approve">
	<input type="submit" name="submit" id="sub"  value="Reject">
	
	<a href="GeneratePurchasePRNEnquiry.jsp?RefNo=<%=RefNo%>"><button type="button">Generate Purchase Enquiry</button></a>
</div>
<%} %> 
<br>

	<table id="example" class="display" style="width: 100%">

		<thead>

			<tr>
				<th class="col-width-4">SrNo.</th>
				<th>PRNNo</th>
				<th>Group</th>
				<th>Make</th>
				<th>Model</th>
				<th>Part No</th>
				<th>Item Name (Description)</th>
				<th>Quantity</th>
				<th>Project Name</th>
				<th>Updated Time</th>
				<th>Status</th>
				<th>Pur Enq Ref No</th>
			<% if(sessiondept.equals("Purchase")){ %>	
				<th>Chk/Unchk</th> 
			<%} %>
			</tr>
		</thead>
		<tbody>
			

				<%
					int i = 1 ;
				    int ck = 0;

					sql = "select * from db_GlobalERP."+comid+"PRNItemMaster a INNER JOIN db_GlobalERP."+comid+"tbl_groupmaster b ON (a.TheGroup = b.TheGroupCode)  where PRN_RefNo='"+RefNo+"'";
					System.out.println("Sql Query == " + sql);
					rs1 = stmt.executeQuery(sql);
					while (rs1.next()) {
						PRNNo = rs1.getInt("PRNNo"); 
						PRNRefNo = rs1.getString("PRN_RefNo");
						Name = rs1.getString("EntryBy");
						group = rs1.getString("TheGroupName");
						make=rs1.getString("Make");
						model=rs1.getString("Model");
						partNo=rs1.getString("PartNo");
						ItemCode=rs1.getString("ItemCode"); 
						Quantity = rs1.getString("Quantity");
						ItemName = rs1.getString("ItemDescription");
						UpdatedDateTime = rs1.getString("UpdatedDateTime");
						status = rs1.getString("Status");
						Purchase_RefNo = rs1.getString("Purchase_RefNo");
						ProjectName = rs1.getString("System_name");
						if (remark == null) {
							remark = "-";
						}
						if (model == null) {
							model = "-";
						}
						if (partNo == null) {
							partNo = "-";
						}
						
						if(UpdatedDateTime !=null){
							UpdatedDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(UpdatedDateTime));
						}
						
						if(Purchase_RefNo==null){
							Purchase_RefNo="-";
						}
				%>
			
			
			
			<tr>
				<td class="text-center"><%=i%></td>
					<td class="text-center"><%=PRNNo%>
						<input type="hidden" name="prndet<%=ck%>" id="prndet<%=ck%>" value="<%=PRNNo%>">
					</td>
					<td class="text-left"><%=group%></td>
				
				<td class="text-center"><%=make%></td>
				<td class="text-left"><%=model%></td>
				<td class="text-center"><%=partNo%></td>
				<td class="text-left"><%=ItemName%></td>
				<td class="text-center"><%=Quantity%></td>
				<td class="text-left"><%=ProjectName%></td> 
				<td class="text-right"><%=UpdatedDateTime%></td>
				<td class="text-right"> <%=status%></td>
					<% if(!Purchase_RefNo.equals("-")) { %>
				<td class="text-right">
					<a href="PurchasePRNEnquiryReport.jsp?RefNo=<%=Purchase_RefNo%>&PRNNo=<%=PRNNo%>&PRN_RefNo=<%=RefNo%>"><%=Purchase_RefNo%></a></td>
					
					<%}else{  %>
					<td class="text-right">-</td>
					<%}%>
				
				<% if(sessiondept.equals("Purchase")){ %>
					<td class="text-center">
			         <%	if(status.equals("Pending")) { %>	
				         <input type="checkbox" id="check<%=ck%>" name="check<%=ck%>" />	
				      <%}else{ 
				    	  out.println("-"); 
				      } %>
				     </td> 
				 <%  }  %>				
				</tr>
				<%
				  i++;
				  ck++;
					}%>
			
		</tbody>
	</table>
	<input type="hidden" name="remark" id="remark" value="">
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck%>"> 
	<input type="hidden" name="PRNRefNo" id="PRNRefNo" value="<%=PRNRefNo%>">
</form>
</div>

      <script>
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title : 'Purchase PRN Detail Report',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title : 'Purchase PRN Detail Report',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title : 'Purchase PRN Detail Report',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title : 'Purchase PRN Detail Report',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title : 'Purchase PRN Detail Report',
							},
 
					],
				},
           ], 
       
       });

   });
</script>
<script>
  function Check(){
    	var checkedNumber = document.getElementById("checkedNumber").value;
    	var breakflag=false;
    	for(i=0;i<checkedNumber;i++){
    	  val =	document.getElementById("check"+i).checked;
    		if(val==true){   
    			breakflag=true;
    			break;
    		}
    	}
    	
    	if(breakflag==true){
    		
           let remark = prompt("Please Enter Remark:", "");
    		
    		if(remark==null || remark ==""){
    			remark ="-"
    		}
    		document.getElementById("remark").value = remark;
    		return true;
    	}else{
    		alert("please select atleast 1 item for approval/rejection");
    		return false;
    	}
    }
    </script>
 <%@ include file="footer.jsp" %>
</body>
</html>