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
Statement st1=null,st2=null,st3=null;

try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>

<%
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String monthFirstDate = session.getAttribute("onemonthback").toString();  
String todaysDate = session.getAttribute("today").toString(); 

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

String statusname="all";
if(request.getParameter("rd")!=null)
{
	statusname=request.getParameter("rd");
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Document Tracking Report</h5>
    </div>
</div>
 <form name="customdetail" id="customdetail" method="get">
	<div class="row col-12">
		<div class="col-md-1"></div>
             <div class="col-md-2">
				<label for="dropdown"><b>Tracking</b></label>
					<div class="input-group input-group-merge">
						<select class="form-select" id="rd" name="rd">
						<option value="all" <% if(statusname.equals("all")){ %> Selected
							<% } %>>All</option>
						<option value="bill" <% if(statusname.equals("bill")){ %> Selected
							<% } %>>Bill Number</option>
						<option value="doc" <% if(statusname.equals("doc")){ %> Selected
							<% } %>>Document Number</option>
						<option value="sub" <% if(statusname.equals("sub")){ %> Selected
							<% } %>>Subject</option>
						<option value="party" <% if(statusname.equals("party")){ %>
							Selected <% } %>>Party Name</option>
						<option value="manRef" <% if(statusname.equals("manRef")){ %>
							Selected <% } %>>Manual Reference</option>
						</select>
						<script>
                            const mySel = document.getElementById("rd");
                            // On page load
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
			<div class="col-md-1" style="width: 30px;">
    <label class="form-label fw-bold d-block">All</label>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="1" onclick="allSelected(this.value);">
    </div>
    </div>
 		
			<div class="col-md-2" id="frmDT" style="display: ''">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="toDT" style="display: ''">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			
	 		<div class="col-md-2 mt-4">
                <!-- <label for="input"><b>Search Here</b></label> -->
                <input class="form-control form-control-sm" type="text" id="searchTxt" name="searchTxt">
			 </div>
			 
			 <div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate()">
			</div>
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
	<% 
		try 
		{
			String radio=request.getParameter("rd");
			String chbxAll=request.getParameter("extAll");
			%>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
	            <th class="col-width-4">SrNo.</th>
	            <th>Date</th>
	            <th>Inward No.</th>
	            <th>Manual Reference</th>
			   	<th>Category</th>
			    <th>From</th>
			    <th>Address</th>
			    <th>Subject</th>
			    
			    <th>BillNo</th>
	            <th>BillAmt</th>
	            <th>BillDate</th>
			   	<th>BillDueDate</th>
			    <th>UpdatedDateTime</th>
			    <th>Inwared By</th>
			    <th>To</th>	
			    <th>Files</th>
			    <th>Status</th>			
			</tr>
		</thead>
		 <tbody>
		<%
			int i=0;
			String searchKey=request.getParameter("searchTxt");
			String sqlData="";
			try{
			if(chbxAll!=null && chbxAll!="")
			{
				if(radio.equals("all") )
				{
					System.out.println("\n\n in all.....");
					sqlData="(select * from t_inwarddetails where BillNo='"+searchKey+"') union"
					        +"(select * from t_inwarddetails where InwardRefNo='"+searchKey+"') union"
					        +"(select * from t_inwarddetails where Subject like '%"+searchKey+"%') union"
					        +"(select * from t_inwarddetails where ManualRef like '%"+searchKey+"%') union"
					        +"(select * from t_inwarddetails where FromParty like '%"+searchKey+"%')  order by InwardDate asc";
					
					System.out.println("\n\n isqlData--->>"+sqlData);
					
				}else if(radio.equals("bill"))
				{
					sqlData="select * from t_inwarddetails where BillNo='"+searchKey+"' order by InwardDate asc";
				}
				else if(radio.equals("doc"))
				{
					sqlData="select * from t_inwarddetails where InwardRefNo='"+searchKey+"' order by InwardDate asc";
				}
				else if(radio.equals("sub"))
				{
					sqlData="select * from t_inwarddetails where Subject like '%"+searchKey+"%' order by InwardDate asc";
				}
				else if(radio.equals("manRef"))
				{
					sqlData="select * from t_inwarddetails where ManualRef like '%"+searchKey+"%' order by InwardDate asc";
				}
				else
				{
					sqlData="select * from t_inwarddetails where FromParty like '%"+searchKey+"%' order by InwardDate asc";
				}
			}
			else
			{
				System.out.println("In Else  ");
				if(radio.equals("all") )
				{
					sqlData="(select * from t_inwarddetails where InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') union"
					        +"(select * from t_inwarddetails where InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') union"
					        +"(select * from t_inwarddetails where  InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') union"
					        +"(select * from t_inwarddetails where  InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') union"
					        +"(select * from t_inwarddetails where  InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' )  order by InwardDate asc";
					
					System.out.println("\n\n isqlData--->>"+sqlData);
					
				}else if(radio.equals("bill"))
				{
					sqlData="select * from t_inwarddetails where BillNo='"+searchKey+"' AND  InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
				}
				else if(radio.equals("doc"))
				{
					sqlData="select * from t_inwarddetails where InwardRefNo='"+searchKey+"' AND InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
				}
				else if(radio.equals("sub"))
				{
					sqlData="select * from t_inwarddetails where Subject like '%"+searchKey+"%' AND InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
				}
				else if(radio.equals("manRef"))
				{
					sqlData="select * from t_inwarddetails where ManualRef like '%"+searchKey+"%' AND InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
				}
				else
				{
					sqlData="select * from t_inwarddetails where InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
				}
			}
			}catch(Exception e)
			{
				System.out.println("IN CATCH   ");
				sqlData="select * from t_inwarddetails where InwardDate>='"+dt+"' and InwardDate<='"+dt1+"' order by InwardDate asc";
			}
			System.out.println(sqlData);
		ResultSet rst=st2.executeQuery(sqlData);
			while(rst.next())
			{
				i++;
				String bno="-", bamt="-", bdate="-", bduedate="-";
				String adr=rst.getString("Address");
				String manRef=rst.getString("ManualRef");
				try
				{	
					if( manRef=="" || manRef==null)
					{
						manRef="-";
					}
				
					if(adr=="" || adr==null)
					{
						adr="-";
					}
				}
				catch(Exception e)
				{
					System.out.println(e);
				}
				
				if(rst.getString("Category").equals("Bills"))
				{
					bno=rst.getString("BillNo");
					bamt=rst.getString("BillAmt");
					bdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("BillDate")));
					bduedate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("BillDueDate")));
				}
				%>
							<tr>
								<td class="text-center"><%=i%></td>
								<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm")
									.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.parse( rst.getString("InwardDate")+" "+rst.getString("InwardTime")))%></td>
								<td class="text-center"><%=rst.getString("InwardRefNo")%></td>
								<td class="text-center"><%=manRef%></td>
								<td class="text-center"><%=rst.getString("Category")%></td>
								<td class="text-center"><%=rst.getString("FromParty")%></td>
								<td class="text-center"><%=adr%></td>
								
								<td class="text-center"><%=rst.getString("Subject")%></td>
								<td class="text-center"><%=bno%></td>
								<td class="text-center"><%=bamt%></td>
								<td class="text-right"><%=bdate%></td>
								<td class="text-right"><%=bduedate%></td>
								<%
				String delims12= "[,]";
				String[] tok = rst.getString("FileName").split(delims12);
				 System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>File:"+tok[0]);
				String Checkfile="Select * from t_uploadedFiles where FileName='"+tok[0]+"'";
				System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>Checkfile:"+Checkfile);
				ResultSet rscheck=st3.executeQuery(Checkfile);
				%>
								<%
				if(rscheck.next())
				{
					%>
					<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rscheck.getString("UpdatedDateTime"))) %></td>
					<%
				}
				else
				{
					try
					{
					%>
					<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("UpdatedDateTime"))) %></td>

								<% }catch(Exception e){
					System.out.println(">>>>>>>>>>>>>>Exception:"+e);
					%>
								<%}} %>
								<td class="text-left"><%= rst.getString("Enteredby")%></td>
								<td class="text-left"><%= rst.getString("ToEmploy")%></td>
								<td class="text-left"> <% 
				
				
				for (String t1 : tok)
				{
					%> <a href='#'
											onclick="getFTPImage('<%=t1%>','<%=rst.getString("InwardRefNo")%>','<%=rst.getString("ToEmploy")%>');"><%=t1%></a><br></br>

											<%	
					
				}
				%>
										</td>
								<td class="text-left"><%= rst.getString("CheckStatus")%></td>
							</tr>
							<%  
			}
			%>
			</tbody>
</table>
	<%
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Exception=======>>"+e);
		} 
%>
</div>
<script type="text/javascript">
function allSelected(allVal)
{
	if(document.customdetail.extAll.checked) 
	{
		document.getElementById("frmDT").style.display='none';
    	document.getElementById("toDT").style.display='none';
    }
	else 
	{
		document.getElementById("frmDT").style.display="";
    	document.getElementById("toDT").style.display="";
	}
}

function validate()
{
	var s1=document.getElementById("searchTxt").value;
	if(s1=="")
	{
		alert("Please Enter Search Element");
		return false;
	}

	return true;
}

function getFTPImage(t1,refNo,empname1)
{
	try
	{
		window.open('inwardLinkTrack.jsp?filename='+t1+'&iwno='+refNo+'&empName='+empname1+'','mywindow','width=700, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
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
		                        title: 'Bill Tracking Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Bill Tracking Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Bill Tracking Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Bill Tracking Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Bill Tracking Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
</body>
<%@include file="footer.jsp" %>
</html>
