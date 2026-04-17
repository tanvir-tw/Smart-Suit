<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    <%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$('#GenPurEnq')
								.DataTable(
										{
											"pagingType" : "full_numbers",

											dom : 'Blfrtip',
											scrollY : 350,
											scrollX : true,
											buttons : [

											{
												extend : 'collection',

												text : 'Export',
												buttons : [
														{
															extend : 'excel',
															title : 'Purchase Quotation',
														},
														{
															extend : 'pdf',
															orientation : 'landscape',
															pageSize : 'LEGAL',
															title : 'Purchase Quotation',
														},
														{
															extend : 'csv',
															title : 'Purchase Quotation',
														},
														{
															extend : 'print',
															title : 'Purchase Quotation',
														},
														{
															extend : 'copy',
															title : 'Purchase Quotation',
														},

												/* 'copy', 'csv', 'excel', 'pdf', 'print' */
												]
											} ],
											lengthMenu : [
													[ -1, 10, 25, 50, 100 ],
													[ "All", 10, 25, 50, 100 ] ],

										});
					});
</script>
<script>
function getCompanies()
{
		  //  console.log("in getCompanies function...");
		    
		    company = document.getElementById("companyNames").value;
		  // alert("company:"+company);
		    
		    if(company!="")
			{
		    	//alert("in company not empty condition:"+company)
				document.getElementById("companyList").style.visibility = "visible";
				company=company.replace(".", "");
				company=company.replace(",", "");
				company=company.replace("$", "");
				company=company.replace("#", "");
				company=company.replace("?", "");
				company=company.replace("-", "");
				company=company.replace("_", "");
				company=company.replace(" ", "");
				company=company.replace("(", "");
				company=company.replace(")", "");

			//alert(company);
			
				var ajaxRequest;  // The variable that makes Ajax possible!
				try{
					// Opera 8.0+, Firefox, Safari
					ajaxRequest = new XMLHttpRequest();
				}  
				catch (e)
				{
					// Internet Explorer Browsers
					try
					{
						ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
					} 
					catch (e)
					{
						try
						{
							ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
						} 
						catch (e)
						{
							// Something went wrong
							alert("Your browser broke!");
							return false;
						}
					}
				}

				ajaxRequest.onreadystatechange = function()
				{
					if(ajaxRequest.readyState == 4)
					{
						var reslt=ajaxRequest.responseText;
					//	alert("result:"+reslt);
						document.getElementById("companyList").innerHTML=reslt;
					} 
				}
				var queryString = "?company=" +company;
				ajaxRequest.open("GET", "AjaxGetSuppliers.jsp" + queryString, true);
				ajaxRequest.send(null);
			
			
			}//end of if 
		
		
}
		

function addRowForSupplier(suppliercode,tableID,suppliername) 
{
	alert("IN addRowForSupplier  "+suppliercode+" "+tableID+" "+suppliername);
	
	document.getElementById("supplier").value = document.getElementById("supplier").value +","+ suppliername;
	document.getElementById("suppliercodes").value = document.getElementById("suppliercodes").value +","+ suppliercode;
	document.getElementById('companyList').style.visibility = 'hidden';

    var table = document.getElementById(tableID);
   // alert("11111  "+table);
    var rowCount = table.rows.length;
   // alert("22222  "+rowCount);
    var row = table.insertRow(rowCount);
   // alert("33333   "+row)
    //var cell1 = row.insertCell(0);
   // var element1 = document.createElement("input");
    //element1.type = "checkbox";
    //cell1.appendChild(element1);
    
    var cell2 = row.insertCell(0);
    cell2.innerHTML = suppliername;
 //   alert("after table   ");
    if(listTable==null)
    {
    	listTable=suppliername;
    }
    else
    {
    	listTable=listTable+","+suppliername;
    	
    }
	
 //   alert(suppliername);
    
}


function generate(){
	//alert("in generate")
	var checkedNumber = document.getElementById("checkedNumber").value;
	//alert("checkedNumber:"+checkedNumber);
	var supplierlist = document.getElementById("supplier").value;
	if(supplierlist==""||supplierlist==null){
		alert("please select atleast 1 supplier")
		return false;
	}
	
	var breakflag=false;
	for(i=0;i<checkedNumber;i++){
	  val =	document.getElementById("purquot"+i).checked;
	 // alert("val:"+val)
		if(val==true){   
			breakflag=true;
			break;
		}
	}
	
	for(j=0;j<checkedNumber;j++){
		  val1 =	document.getElementById("purquot"+j).checked;
		 // alert("val1:"+val1);
			if(val1==true){   
				 num = document.getElementById("apprqty"+j).value;
				 num1 = document.getElementById("reqqty"+j).value;
			//	 alert("num:"+num);
			//	 alert("num1:"+num);
				
				if(num==null || num==""){
					alert("please enter quantity against checked Item");
					return false;
				}
				if(num < 1){
					alert("quantity cant be less than 1");
					return false;
				}
				
				
				
				
			}
		}
	
	if(breakflag==true){
		return true;
	}else{
		alert("please select atleast 1 request for approval");
		return false;
	}
	
} 
</script>

</head>
<body>

<%

Connection con;

Statement stmt = null;
String PRNNo="" , ItemCode="", ItemName="", Specifications="", Quantity="", Name = "", Group = "", Make = "", Model = "", PartNo = "";
String Specs="";


Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME, DB_USERNAME, DB_PASSWORD);

stmt = con.createStatement();


String PRNRefNo = request.getParameter("RefNo");
String comid = session.getAttribute("CompanyMasterID").toString();

String sql = "select * from db_GlobalERP."+comid+"PRNItemMaster where PRN_RefNo='"+PRNRefNo+"' and Status='Accepted'";
System.out.println("sql--->"+sql);
ResultSet rs1 = stmt.executeQuery(sql);

%>
<br><br>
<div align="center">
<h3> Purchase Enquiry PRN No -<%=PRNRefNo %></h3>
</div>
<br><br>
<form action="GeneratePurchasePRNEnquiryInsrt.jsp" onsubmit="return generate()">
<input type="hidden" name="export" value="No">
<table  style="border:none;" align="center">
<tr>
				<td><b>Select multiple Supplier :<font color="red">*</font></b></td>
				<td><input type="text" name="companyNames" id="companyNames"  onkeyup="getCompanies()" /></td> 
				<td><table id="listTable" border='0' valign="top" align="left" style="background-color: #94ECF6;border: 1em;">
                      <tr><td><b><font size="3" color="blue">List Of Suppliers : </font></b></td></tr>
		            </table>
                 </td>
                 <td><input type="submit" value="Save Enquiry" name="button"></td>	
</tr>
<tr>
                <td colspan="2">
                <div id="companyList" style="width: 350px;position: absolute; visibility:hidden" ></div></td>
        <td>
          <input type="hidden" name="supplier" id="supplier" value="" style="font-color: red;"/>
          <input type="hidden" name="suppliercodes" id="suppliercodes" value="" style="font-color: red;"/>
		</td>
		<td></td>
</tr>
</table>
<br><br><br><br>
<table id="GenPurEnq" class="display"  style="width: 100%;border:none">
<thead>
<tr>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Sr No</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Chk/Unchk</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Ref No</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Item Code</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Description</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Specification</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Requested Quantity</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Approved Quantity</th>

</tr>
</thead>
<tbody>
<% 
int ck=0;
int i=1;
while(rs1.next()){
	
	PRNNo = rs1.getString("PRNNo");
	ItemCode=rs1.getString("ItemCode"); 
	ItemName=rs1.getString("ItemDescription");
	Quantity = rs1.getString("Quantity");
	Name = rs1.getString("EntryBy");
	Group = rs1.getString("TheGroup");
	Make=rs1.getString("Make");
	Model=rs1.getString("Model");
	PartNo=rs1.getString("PartNo");
	Specs= rs1.getString("Specifications");
	
%>
<tr>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%>
<input type="hidden" id="prnentryby<%=ck%>" name="prnentryby<%=ck%>" value="<%=PRNNo%>">
<input type="hidden" id="group<%=ck%>" name="group<%=ck%>" value="<%=Group%>">
<input type="hidden" id="make<%=ck%>" name="make<%=ck%>" value="<%=Make%>">
<input type="hidden" id="model<%=ck%>" name="model<%=ck%>" value="<%=Model%>">
<input type="hidden" id="partno<%=ck%>" name="partno<%=ck%>" value="<%=PartNo%>">
</td>
<td style="font-size: 11px; face:san-serif; color:black" align="center"><input type="checkbox" id="purquot<%=ck%>" name="purquot<%=ck%>" checked readonly></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PRNNo%><input type="hidden" id="prnno<%=ck%>" name="prnno<%=ck%>" value="<%=PRNNo%>"></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ItemCode%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ItemName%><input type="hidden" id="itemname<%=ck%>" name="itemname<%=ck%>" value="<%=ItemName%>"></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><input type="text" id="itemspec<%=ck%>" name="itemspec<%=ck%>" value="<%=Specs%>"></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><input type="hidden" id="reqqty<%=ck%>" name="reqqty<%=ck%>" value="<%=Quantity%>"><%=Quantity%></td>
<td style="font-size: 11px; face:san-serif; color:black" align="right"><input type="number" id="apprqty<%=ck%>" name="apprqty<%=ck%>"></td>
</tr>
<%  
    ck++;
	i++; 
	
} %>
</tbody>

</table>
<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck%>">
<input type="hidden" name="prnrefno" id="prnrefno" value="<%=PRNRefNo%>"> 



</form>

</body>
</html>