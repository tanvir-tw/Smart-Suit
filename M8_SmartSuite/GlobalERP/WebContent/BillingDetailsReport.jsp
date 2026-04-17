 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="icon" type="image/png" href="images/favicon.png">
    <title>GlobalERP</title>

</head>
<body style="background-color:azure;">
<%
// Variable Declaration
 String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String query12=""; 

ResultSet rs=null,rs1=null;
Statement stmt=null,stmt1=null,stmt2=null;

String month="",month1="",year1="",transporter="",vehicleCode="";
int i=0,ck=0;
int k=2000;

 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement(); 
    stmt=conn.createStatement();
    stmt1=conn.createStatement();
    stmt2=conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%

try{
bt=request.getParameter("button");
	
	

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">ERP Vehicle Summary</h5>
    </div>
</div>

<form name="billingdetails"  method="get" onsubmit="return validate();"> 
		    <div class="row col-12" id="ext_row">
		    <div class="col-md-3"></div>
		 
		 <div class="col-md-2">
				  <label for="dropdown"><b>Month :</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" id="month" name="month">
						<option value="Select">Select</option>
								<%
								String[][] months = {
								        {"01","JAN"}, {"02","FEB"}, {"03","MAR"},
								        {"04","APR"}, {"05","MAY"}, {"06","JUN"},
								        {"07","JUL"}, {"08","AUG"}, {"09","SEP"},
								        {"10","OCT"}, {"11","NOV"}, {"12","DEC"}
								    };
								String selectedMonth = request.getParameter("month"); // e.g. "03"
								
								for(String[] m : months){
								    String value = m[0];
								    String label = m[1];
								    String selectedmon = (value.equals(selectedMonth)) ? "selected" : "";
								%>
								<option value="<%=value%>" <%=selectedmon%>><%=label%></option>
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
				  <label for="dropdown"><b>Year :</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="year" name="year">
							    <%
							        String selectedYear = request.getParameter("year");
							        if (selectedYear == null || selectedYear.isEmpty()) {
							    %>
							    <option value="Select">Select</option>
							    <%
							        }
							        for (int year = 2018; year <= 2050; year++) {
							            boolean isSelected = Integer.toString(year).equals(selectedYear);
							    %>
							    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>><%= year %></option>
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
			
		
			<div class="col-md-1">
             <div class="form-check">
             <label for="dropdown"></label>
             <div class="input-group input-group-merge">
					<input type="radio" name="dataFilter" value="tp"  id="tp" onClick="ShowHide(0);">            
				 <label class="form-check-label" for="flexRadioDefault2">Transporter</label>
				 </div>
             </div>
             </div>
             <div class="col-md-1">
             <div class="form-check">
             <label for="dropdown"></label>
             <div class="input-group input-group-merge">
				<input type="radio" name="dataFilter" value="vn" id="vn" onClick="ShowHide(1);"  >             
			    <label class="form-check-label" for="flexRadioDefault2">Vehicle No.</label>
			    </div>
             </div>
			</div>					
			
			<div class="col-md-2" id="transtext" style="display:none;" >
				  <label for="dropdown"><b>Transporter </b></label>
						<div class="input-group input-group-merge" id="tpr" style="display:none;">
			                <input type="text" name="transporter" id="transporter" class="form-control" style="font-size: 0.6rem" onkeyup="getTransporter(1)" autocomplete="off" />              
                        </div>
			</div>
           	
           	<div class="col-md-2" id="vehtext" style="display:none;">
				  <label for="dropdown"><b>Vehicle Registration No.</b></label>
						<div class="input-group input-group-merge" id="vno" style="display:none;">
								   <textarea class="form-control" name="vehCode" id="vehCode" style="font-size: 0.8rem;"></textarea>
						
							<p class="text-center" style="color: maroon; margin-top: 2px;font-size: 10px;">
							    <b>Note:</b> Multiple entries must be separated by a comma only.
							</p>
                        </div>
			</div>	
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
						
		</div>
		 <div class="row col-12" id="listrow" style="display:none;">
		    <div class="col-md-8"></div>
		<div class="col-md-3" id="transporterlist" style="overflow:auto;opacity:1;margin-left: 65%;">
		</div>
		 <div class="col-md-1"></div>
		</div>
		
		
 <input type="hidden" name="counter" id="counter" value="10"/>
</form>
<%
String selectedusertype="",sqlveh="",VehicleCode="",vehCode="",Svehlist="";
int gpcnt=0,j=1;
String transName=request.getParameter("transporter");

if(transName==null || (transName.equalsIgnoreCase(" ")) || (transName.equalsIgnoreCase("")) || (transName.equalsIgnoreCase("null")))
{
	System.out.println("in if 1234");

}else{
String usertypestaus="select count(*) as cnt from db_gps.t_group where GPName='"+transName+"' and SepReport='Yes' and Active='Yes'";
ResultSet rsusertype=stmt1.executeQuery(usertypestaus);
if(rsusertype.next())
{
	gpcnt=rsusertype.getInt("cnt");
		if(gpcnt > 0)
		{
		selectedusertype="Group";
	}else{
		selectedusertype="Transporter";	
	}
}
session.setAttribute("selectedusertype",selectedusertype); 
if(selectedusertype.equals("Group")|| selectedusertype=="Group" || ("Group").equals(selectedusertype))
{
	 sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where vehiclecode in (select distinct(vehcode) from db_gps.t_group where GPname='"+transName+"' and Active='Yes')";
}
else
{
	 sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where OwnerName='"+transName+"'";
}
System.out.println("----------------> sqlveh.."+sqlveh);
rs1=stmt1.executeQuery(sqlveh);
Svehlist = "(0";
while (rs1.next()){
            VehicleCode= rs1.getString("vehcode1");
            Svehlist=Svehlist+",'"+VehicleCode+"'"; //adding each vehicle code to string list
        }
        Svehlist += ")";
}
String Svehlist1="";
String Svehlist2= "('0";
Svehlist1=request.getParameter("vehCode");

if(Svehlist1==null || (Svehlist1.equalsIgnoreCase(" ")) || (Svehlist1.equalsIgnoreCase(""))){
}else{
	Svehlist1=Svehlist1.replaceAll(" ", "");
	 Svehlist2=Svehlist2+","+Svehlist1;
}
Svehlist2 += "')";
String data="";
if(Svehlist1==null || (Svehlist1.equalsIgnoreCase(" ")) || (Svehlist1.equalsIgnoreCase(""))){
}
else{
	Svehlist=Svehlist2;
	data=Svehlist;
	data1=data.replaceAll(",","','");

	sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where replace(vehicleregnumber,' ','') in "+data1+"";
	rs1=stmt2.executeQuery(sqlveh);
	Svehlist = "(0";
	while (rs1.next()){
		        vehCode=rs1.getString("vehcode1");
	           vehicleCode= rs1.getString("vehcode1");
	           Svehlist=Svehlist+",'"+vehicleCode+"'"; //adding each vehicle code to string list
	       }
	       Svehlist += ")";
	Svehlist2=Svehlist;
	Svehlist2=Svehlist2.replace("0,", "");
	Svehlist=Svehlist2;
}
%>

 <br>
 <form name="data" action="ActionVehicleMap.jsp" method="post" autocomplete="off">

 	<div class="row col-12 mt-4 mb-2">
    <div class="col-md-2" style="width:15%;">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="location.href='bilingReport.jsp'">Bill Day Status</button>
    </div>
    <div class="col-md-2">
            <input type="submit" id="button" name="Assign" value="Vehicle Mapping" class="btn btn-primary" />
    </div>
</div>
 
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>
        <input type="hidden" name="check" id="check" value="">
		<font color="white">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
    	<font color="white">UnChk</font></a>
            </th>
            <th>Vehicle Id</th>
			<th style="display: none;">Vehicle Id</th>
			<th>Vehicle No.</th>
			<th>Transporter</th>
			<th>ERP Code</th>
			<th>ERP Customer Name</th>
			<th>Group Code</th>
         	<th>Group Name</th>
	        <th>Invoice Ref No.</th>
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


  if(bt==null || bt=="null" || bt.equals("null"))
	{
	  
	}else{
		year1=request.getParameter("year");
		 month=request.getParameter("month");
		 transporter=request.getParameter("transporter");
		 System.out.println("month"+month);
			System.out.println("year1"+year1); 

String sql="select Vehid,VehRegno,Transporter,ERPCode,ERPCustName,GroupCode,GroupName,InvoiceRefNo from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+" where vehid in "+Svehlist+" order by ERPCode,ERPCustName";
        System.out.println(sql);
       rs=stmt.executeQuery(sql);

		      while(rs.next()){
		    	  ++i;
				  ck++;
				  
		    	  VehicleId=rs.getString("Vehid");
		    	  VehicleNo=rs.getString("VehRegno");		    	  
		    	  Transporter=rs.getString("Transporter");
		    	  ERPCode=rs.getString("ERPCode");
		    	  ERPCustName=rs.getString("ERPCustName");
		    	  GroupCode=rs.getString("GroupCode");
		    	  GroupName=rs.getString("GroupName");
		    	  InvoiceRefNo=rs.getString("InvoiceRefNo");
		          	         
       %>
         <tr>
			<td class="text-center"><%=i%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="center">
			    <input type="checkbox" name="check<%=ck %>"   id="check<%=ck %>"  />
			        <div class="text-center">
			        	<input type="text" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px; border:none; text-align:right;font: normal 11px Arial, Helvetica, sans-serif; " value="<%=ck %>" readonly/>                  
					</div> </td>
			<td class="text-right">
                   <div align="right">
                   <input type="text" id="veh_id<%=ck %>" name="veh_id<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px; border:none; text-align:right;font: normal 11px Arial, Helvetica, sans-serif; " value="<%=VehicleId%>" readonly/>                  
					</div>
			</td>
			<td style="display: none;"><%=VehicleId%> </td>
			<td class="text-center"><%=VehicleNo%></td>
			<td class="text-left"><%=Transporter%></td>
			<td class="text-center"><%=ERPCode%></td>
			<td class="text-left"><%=ERPCustName%></td>
			<td class="text-center"><%=GroupCode%></td>
			<td class="text-left"><%=GroupName%></td>
			<td class="text-center"><%=InvoiceRefNo%></td>

	 </tr>
	 <%
			      }
		}
	%>
				
        </tbody>
 </table>
 <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
<input type="hidden" name="billYear" id="billYear" value="<%=year1%>"/>
<input type="hidden" name="billMonth" id="billMonth" value="<%=month%>"/>
<%

month = request.getParameter("month");
System.out.println("month "+month);
System.out.println("year1 "+year1);
%>
 
 </form>
 </div> 
 <br>
 <%
 }catch(Exception e){
	e.printStackTrace();
	 System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 500,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
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
	                         title: 'Billing Detail from ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'ERP Vehicle Summary Report of ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'ERP Vehicle Summary Report of',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'ERP Vehicle Summary Report of ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'ERP Vehicle Summary Report of',
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
					
<script>

function getTransporterDetails(transporter)   
{
	document.getElementById("transporter").value=transporter;
	document.getElementById("listrow").style.display="none";

}

function getTransporter(num)
{
	try{
	console.log("In Method getTransporter");
	var b=0;
	var transporter = document.getElementById("transporter").value;
    if(transporter.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	console.log("in length check....trans:"+transporter);
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		ajaxRequest = new XMLHttpRequest();
	    }  
	catch (e)
	{
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
	    	document.getElementById("listrow").style.display="";

			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			document.billingdetails.counter.value=b;
			document.billingdetails.counter.value=b*document.billingdetails.counter.value;
			counter=document.billingdetails.counter.value;
		} 
	};
	var queryString = "?transporter="+transporter+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "GetTransNames.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("listrow").style.display="none";
    }
	}catch(e)
	{
	}
}

 </script>
<script type="text/javascript">
function validate()
{
var month1=document.getElementById("month").value;
var year=document.getElementById("year").value;
if(month1=="Select")
{
	alert("Please Select Month");
	return false;
}

if(year=="Select")
{
	alert("Please Select Year ");
	return false;
}
}
function ShowHide(id)
{
if(id==0)
	{
		document.getElementById("tpr").style.display="";	
		document.getElementById("transtext").style.display="";	
		document.getElementById("vehtext").style.display="none";	
		document.getElementById("vno").style.display="none";
		document.getElementById("ext_row").style.marginLeft = "-10%";
	}	

	else{
		
		document.getElementById("vno").style.display="";
		document.getElementById("vehtext").style.display="";	
		document.getElementById("transtext").style.display="none";	
		document.getElementById("tpr").style.display="none";
		document.getElementById("ext_row").style.marginLeft = "-10%";
	}
		
}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>