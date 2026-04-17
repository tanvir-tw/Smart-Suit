<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@ include file="headernew.jsp"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
</head>
<body style="background-color: azure;">
<%
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,stlbl=null;
	
	
	try {
		conn = connection.getConnect("db_GlobalERP");
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		stlbl = conn.createStatement();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	boolean isInvoiceSelected=false;
			
	double sumAmount=0; 
	int groupCode=0,makeCode=0;
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ";
	String sellingPrice="" ,priceAccepted="",quantity="";
	String company=request.getParameter("companyName");
	String salesrefno=request.getParameter("SalesEnqRefNo");
	String salesenqno=request.getParameter("SalesEnqNo");	
	
	%>
	<div class="container-fluid mt-2" id="main">
		<div class="content-header-col-md-7-mt-10 col-12">
			<div class="row breadcrumbs-top">
				<h5 class="content-header-title text-center mb-0"
					style="color: #060637">Domestic Enquiry Of : <a><%=request.getParameter("SalesEnqRefNo")%> </a>&nbsp;&nbsp; For: <a><%=request.getParameter("companyName")%> </a> </h5>
			</div>
			<br>
		</div>
	<form name="generateQuo" method="get" action="quotation.jsp" onsubmit="return chk()" >
	<%
	String sqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo='"+salesenqno+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	while(rsDet.next()){
	
	%>
		<div class="container-fluid">
				<div class="card p-3 shadow-sm" id="visitingCard" style="max-width: 1200px; margin: auto;">
					<div class="row">
						<!-- Company -->
						<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>SE Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDet.getString("SalesEnqDate")))%>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
						</div>
						<div class="col-md-3 mb-1 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>SE Time:</b></label>
							<input type="text" name="companyPerson" id="search-text"
								value="<%=rsDet.getString("SalesEnqTime") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
						</div>
						<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:70px"><b>Cust Ref No:</b></label>
							<input type="text" name="companyPerson" id="search-text"
								value="<%=rsDet.getString("CustRefNo") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
						</div>
						
						<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width: 60px;"><b>Due date:</b></label> 
						<%String duedate ="NA";try{duedate=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat( 
					"yyyy-MM-dd")
					.parse(rsDet.getString("SalesEnqDueDate"))); }
					catch(Exception e){}%> 
							<input type="text" name="companyPhone" id="search-text"  value="<%=duedate%>"
							readonly class="form-control-sm bg-light border-0 shadow-none">
								<input type="hidden" name="duedate" value=""/>
						</div>
					<div class="col-md-3 mb-1 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Remarks:</b></label>
							<input type="text" name="companyPerson" id="search-text"
								value="<%=rsDet.getString("CustRemarks") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
								<input type="hidden" name="remarks" id="remarks" value="<%=rsDet.getString("CustRemarks") %>"/>
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Group:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="-" readonly
								class="form-control-sm bg-light border-0 shadow-none">
								<input type="hidden" name="addresscode" value="<%= rsDet.getString("AddressCode") %>"/>
					</div>
					<div class="col-md-3 mb-1 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:70px"><b>Cust name:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=rsDet.getString("CompanyName") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Contact Person:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=rsDet.getString("ContactPerson") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Address:</b></label>
							<textarea name="groupTop" rows="1" id="search-text" readonly class="form-control-sm bg-light border-0 shadow-none"><%=rsDet.getString("Address") %></textarea>
					</div>
					<div class="col-md-3 mb-1 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>City:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=rsDet.getString("city") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:70px"><b>State:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=rsDet.getString("State") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Country:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=rsDet.getString("country") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Phone:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=((rsDet.getString("Phone")!=null) ? rsDet.getString("Phone") : "-") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:60px"><b>Fax:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=((rsDet.getString("Fax")!=null) ? rsDet.getString("Fax") : "-") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
					<div class="col-md-3 d-flex align-items-start">
							<label class="me-3 mt-2" style="width:70px"><b>Zip code:</b></label>
							<input type="text" name="groupTop" id="search-text"
								value="<%=((rsDet.getString("Zip")!=null) ? rsDet.getString("Zip") : "-") %>" readonly
								class="form-control-sm bg-light border-0 shadow-none">
					</div>
</div>		
</div>
</div>		
	<%}%>        		
	  <br> 
<table id="example" class="display" style="width:100%;">        
       <thead>
			<tr>
			<th style="width: 70px;"><a href="#" onclick="checkAll()">
			<input type="hidden" name="check" id="check" value="">
			<font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a> 
			<a href="#" onclick="unCheckAll()"> <font color="white">UnChk all</font></a></th>
			<th>Option No</th>
			<th>Insert Or</th>
	<%
			String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
		<th><%=rslbl.getString("Make") %></th>
		<th><%=rslbl.getString("Model") %></th>
		<th><%=rslbl.getString("PartNO") %></th>
		<th><%=rslbl.getString("Description") %></th>
		<%} %>
		<th>Quantity</th>
		<th>Selling prize</th>
		<th>Prize Date</th>
		<th>OEM Prize</th>
		</tr>
</thead>
<tbody>
<%
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items WHERE SalesEnqNo='"+salesenqno+"'";
	System.out.println("+++++++++++++++++"+sqlEnq);
	int i=0;
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
while(rsEnq.next())
{
	
	groupName="";makeName="";refMakeNameTable="";
	double amount=0.00,discount=0;
	groupCode=rsEnq.getInt("TheGroup");
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     	     
	String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5)
	{
		refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
		String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		ResultSet rsMakeName=st3.executeQuery(sqlMakename);
		if(rsMakeName.next())
		makeName=rsMakeName.getString(1);
		else
		makeName="-";
				      
		sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else
	{
		sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
		makeName="-"  ;
	}
	%>
	<script type="text/javascript">
	document.getElementById('groupTop').value='<%=groupName%>';
	</script>
	<%  
	ResultSet rsDetails1=st.executeQuery(sqlDisplayDesc);
	if(rsDetails1.next())
	{
		String Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";
		ResultSet rsSql=st2.executeQuery(Sql);
		System.out.println("AAAAAAAAAAAAAAA"+Sql);
		if(rsSql.next())
		{
			System.out.println("selling price................ "+rsSql.getString("SellingPrice") );
			%>
			<tr>
			<td><input type="checkbox" checked="checked" name="check<%=i %>"   id="check<%=i %>" value="check<%=i %>" /></td>
			<td class="text-center"><%=rsEnq.getString("TheOptionNo") %></td>
			<td class="text-center"><%=rsEnq.getString("InsertOR") %></td>
			<td class="text-left"><%=makeName %></td>
			<td class="text-center"><%=rsSql.getString("Model") %></td>
			<td class="text-center"><%=rsSql.getString("Partno") %></td>
			<td class="text-center">
			<input type="hidden" id="description<%=i %>" name="description<%=i %>" value="<%=rsSql.getString("Description") %>"/><%=rsSql.getString("Description") %></td>
			<td class="text-center">
			<input type="text" id="quantity<%=i %>" name="quantity<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
				color: #000000; " value="<%=rsEnq.getString("Quantity") %>" /></td>
			<td style="width: 85px;">
			<input type="number" step="0.01" class="no-spinner" id="sellingPrice<%=i %>" name="sellingPrice<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsSql.getString("SellingPrice") %>" /></td>
			
			<%String pricedate ="NA";try{pricedate=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
						"yyyy-MM-dd")
						.parse(rsDet.getString("PriceDate"))); }
						catch(Exception e){}%>
			
			<td class="text-center"><%=((pricedate!=null) ? pricedate : "-") %></td>
			<td class="text-center"><%=rsSql.getString("OEMPrices") %></td>
			
			</tr>
		<%
		i++;
			}
	}
	
}
%>
</tbody>
	 </table>
		<div align="center" style="margin-top: 3em;">
		<input type="hidden" name="group" value="<%= request.getParameter("TheGroup")%>" />
	    <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i %>"/>
	    <input type="hidden" name="company" id="company" value="<%=company %>"/>
	    <input type="hidden" name="salesenqno" value="<%=salesenqno %>" />
		<!-- <input type="submit" value="submit" style="border: outset; background-color: #C6DEFF"  /> -->
	</div>
	
	<div class="d-grid gap-2 col-2 mx-auto ">
        <button  id="button" name="button" class="btn btn-primary" type="submit">Submit</button>
  	</div>
	      
	</form>
	
<script language="JavaScript1.2">
	function generateQuo(Address,salesenqno,check)
	{ 
	alert(salesenqno+'  '+Address+'   '+check);
	window.open(Address+'&salesenqno='+salesenqno+'&check='+check,'jav');

	}

	function checkAll()
	{
		var field=document.getElementsByName('check');
		var i;
		try{
		for (i = 0; i < field.length; i++)
		field[i].checked = true ;
	}catch(e){alert(e);}
	}

	function unCheckAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = false ;
	}catch(e){alert(e);}
	}

	</script>
    <script>
    function chk(){
    	var checkedNumber = document.getElementById("checkedNumber").value;
        var breakflag=false;
        for(i=0;i<checkedNumber;i++){
         var val = document.getElementById("check"+i).checked;
            if(val==true){
                breakflag=true;
                break;
            }
        }

        for(j=0;j<checkedNumber;j++){
             var val1 = document.getElementById("check"+j).checked;
                if(val1==true){
                     num = document.getElementById("quantity"+j).value;

                    if(num==null || num==""){
                        alert("please enter quantity against checked Item");
                        return false;
                    }
               
                }
            }
        
        for(j=0;j<checkedNumber;j++){
            var val1 = document.getElementById("check"+j).checked;
               if(val1==true){
                    num = document.getElementById("sellingPrice"+j).value;
            	var price = parseFloat(num);

                   if(num==null || num==""){
                       alert("please enter sellingPrice against checked Item");
                       return false;
                   }

                   if (isNaN(price) || price <= 0) {
                       alert('Please enter a selling price greater than 0.00.');
                       return false;
                   }

               }
           }

        if(breakflag==true){
            return true;
        }else{
            alert('Please select at least one checkbox.');
            return false;
        }
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
 <%@ include file="footer.jsp"%>
</body>
</html>
