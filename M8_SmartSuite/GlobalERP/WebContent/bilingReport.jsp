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
 	Statement st = null,st1=null,st2=null;
 	ResultSet rs1=null,rs2=null;
 	
 	String month="",month1="",year="",transporter="",monDate="",Svehlist = "";;
 	int i=1, k=2000,gpcnt=0,j=1;;
 	
 	String selectedusertype="",sqlveh="",vehicleCode="",vehCode="";
 	String transName=request.getParameter("transporter");
 	vehCode=request.getParameter("vehCode");
 	System.out.println("----------------> transName.."+transName);
 	
 %>
 <%
 try{
	 conn = connection.getConnect("db_GlobalERP");    
 
 	st=conn.createStatement();
 	st2=conn.createStatement();
 	st1=conn.createStatement();
 	 
 }catch(Exception e){
	 e.printStackTrace();
 }
	 
%>
 
<%
if(null==request.getQueryString())
{
}
else{
	
 transporter=request.getParameter("transporter");
 month=request.getParameter("month");
year=request.getParameter("year");

System.out.println("month"+month);
System.out.println("year"+year);
monDate= year+"-"+month+"-"+01;
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
<%
String Bt=request.getParameter("button");

  if(Bt==null || Bt=="null" || Bt.equals("null"))
	{
	  %>
	  <h5 class="content-header-title text-center mb-0" style="color: #060637">Bill Day Status </h5>
	  <% 
	}else{
	  %>
<h5 class="content-header-title text-center mb-0" style="color: #060637">Bill Day Status for <%=month1%>_<%=year%> </h5>
<%}%>
    </div>
</div>
<form name="data1"  method="get" onsubmit="return validate1();"> 
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

    <!-- Select Year -->
    <div class="col-md-2">
        <label for="year"><b>Year:</b></label>
        <div class="input-group input-group-merge">
        <select name="year" id="year" class="form-select">
            <option value="Select">Select</option>
         
             <%
							        String selectedYear = request.getParameter("year");
							        if (selectedYear == null || selectedYear.isEmpty()) {
							    %>
							    <option value="Select">Select</option>
							    <%
							        }
							        for (int year1 = 2018; year1 <= 2050; year1++) {
							            boolean isSelected = Integer.toString(year1).equals(selectedYear);
							    %>
							    <option value="<%= year1 %>" <%= isSelected ? "selected" : "" %>><%= year1 %></option>
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

    <!-- Radio Buttons -->
    	<div class="col-md-1">
             <div class="form-check">
             <label for="dropdown"></label>
             <div class="input-group input-group-merge">
					<input type="radio" name="dataFilter" value="tp"  id="tp" onClick="ShowHide(0);">            
				 <label class="form-check-label" for="tp">Transporter</label>
				 </div>
             </div>
       </div>
       <div class="col-md-1">
             <div class="form-check">
             <label for="dropdown"></label>
             <div class="input-group input-group-merge">
				<input type="radio" name="dataFilter" value="vn" id="vn" onClick="ShowHide(1);"  >             
			    <label class="form-check-label" for="vn">Vehicle No.</label>
			    </div>
             </div>
		</div>	
    
    <!-- Transporter Input -->  
			<div class="col-md-2" id="transtext" style="display:none;" >
				  <label for="dropdown"><b>Transporter </b></label>
						<div class="input-group input-group-merge" id="tpr" style="display:none;">
							<input type="text" name="transporter" id="transporter" class="form-control" style="font-size: 0.6rem" onkeyup="getTransporter(1)" autocomplete="off" />              
                        </div>
			</div>    
    <!-- Vehicle Registration Input -->
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
	<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
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
<br>
<!----Header End-->
<%
if(transName==null || (transName.equalsIgnoreCase(" ")) || (transName.equalsIgnoreCase("")) || (transName.equalsIgnoreCase("null")))
{
	System.out.println("in if 1234");

}else{
String usertypestaus="select count(*) as cnt from db_gps.t_group where GPName='"+transName+"' and SepReport='Yes' and Active='Yes'";
ResultSet rsusertype=st2.executeQuery(usertypestaus);
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
System.out.println("----------------> selectedusertype.."+selectedusertype);
if(selectedusertype.equals("Group")|| selectedusertype=="Group" || ("Group").equals(selectedusertype))
{
	 sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where vehiclecode in (select distinct(vehcode) from db_gps.t_group where GPname='"+transName+"' and Active='Yes') ";
}
else
{
	 sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where OwnerName='"+transName+"'";
}
System.out.println("----------------> sqlveh.."+sqlveh);
rs1=st2.executeQuery(sqlveh);

 Svehlist = "(0";

while (rs1.next()){
	        vehCode=rs1.getString("vehcode1");
            vehicleCode= rs1.getString("vehcode1");
            System.out.println("----------------> vehicleCode.."+vehicleCode);

            Svehlist=Svehlist+",'"+vehicleCode+"'"; //adding each vehicle code to string list
            //VehList.add(veh_code);
        }
        Svehlist += ")";

System.out.println("----------------> Svehlist.."+Svehlist);

}
String Svehlist1="";
String Svehlist2= "('0";

Svehlist1=request.getParameter("vehCode");

if(Svehlist1==null || (Svehlist1.equalsIgnoreCase(" ")) || (Svehlist1.equalsIgnoreCase(""))){
	
	System.out.println("----------------> session");

}else{
	Svehlist1=Svehlist1.replaceAll(" ", "");
	 Svehlist2=Svehlist2+","+Svehlist1;
}
Svehlist2 += "')";
String data="";
if(Svehlist1==null || (Svehlist1.equalsIgnoreCase(" ")) || (Svehlist1.equalsIgnoreCase(""))){
	System.out.println("----------------> session2");
}
else{
	Svehlist=Svehlist2;
	data=Svehlist;
	 String data1=data.replaceAll(",","','");
      System.out.println("Data  :- "+data1);
	sqlveh="select distinct(vehiclecode) as vehcode1 from db_gps.t_vehicledetails where replace(vehicleregnumber,' ','') in "+data1+"";
	System.out.println("----------------> sqlveh.."+sqlveh);
	rs1=st2.executeQuery(sqlveh);
	Svehlist = "(0";
	while (rs1.next()){
		        vehCode=rs1.getString("vehcode1");
	           vehicleCode= rs1.getString("vehcode1");
	           Svehlist=Svehlist+",'"+vehicleCode+"'"; //adding each vehicle code to string list
	           //VehList.add(veh_code);
	       }
	       Svehlist += ")";
	System.out.println("----------------> Svehlist.."+Svehlist);
	Svehlist2=Svehlist;
	Svehlist2=Svehlist2.replace("0,", "");
	Svehlist=Svehlist2;
}

System.out.println("----------------> Svehlist..111111"+Svehlist2);
%>
<table id="example" class="display" style="width:100%">     
<thead>

		<tr>
			<th class="col-width-4">Sr No</th>
			<th>Month1</th>
			<th>VehID</th>
			<th>VehRegno</th>
			<th>Transporter</th>
			<th>VehAddedThisMonth</th>
			<th>vehRemovedThisMonth</th>
			<th>CapturedDays</th>
		
		</tr>

</thead>
<tbody>
<% 
String Month1="",CapturedDays="";
String VehID="";
String VehRegno ="";
String Transporter ="";
String sqlBillRept="";
String vehRemovedThisMonth="";
String VehAddedThisMonth="";

if(Bt==null || Bt=="null" || Bt.equals("null"))
	{
    System.out.println("in if");
	}
else{
      System.out.println("in else");
sqlBillRept="select distinct(VehID) as VehID,Month1,VehRegno,Transporter,VehAddedThisMonth,vehRemovedThisMonth,TotalYes from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" where Month1='"+monDate+"' and VehID in "+Svehlist+" order by Transporter";
System.out.println("Query :- "+sqlBillRept);
rs2= st1.executeQuery(sqlBillRept);


while(rs2.next()){

	Month1=rs2.getString("Month1");
	VehID=rs2.getString("VehID");
	VehRegno=rs2.getString("VehRegno");
	Transporter=rs2.getString("Transporter");
	VehAddedThisMonth=rs2.getString("VehAddedThisMonth");
	vehRemovedThisMonth=rs2.getString("vehRemovedThisMonth");
	CapturedDays=rs2.getString("TotalYes");
	
%>
		<tr>
			<td class="text-center"><%= i%></td>
			<td class="text-right"><%=Month1%></td>
			<td class="text-center"><%=VehID %></td>
			<td class="text-center"><%=VehRegno%></td>
			<td class="text-left"><%=Transporter %></td>
			<td class="text-right"><%=VehAddedThisMonth%></td>
			<td class="text-right"><%=vehRemovedThisMonth %></td>
			<td class="text-center"><%=CapturedDays%></td>
			
			
			<% 
			i++; 
			}
				}
			%>
		</tr>
</tbody>
</table>
 </div>
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
	                         title: 'Bill Day Status Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Bill Day Status Report', 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Bill Day Status Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Bill Day Status Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Bill Day Status Report', 
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script type="text/javascript">
function validate1()
{
//alert("fun ");
var month1=document.getElementById("month").value;
var year=document.getElementById("year").value;

//alert(month1);
//alert(year);


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

</script>
<script>

function getTransporterDetails(transporter)   
{
	//alert("in getTransporterDetails");
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("transporter").value=transporter;
	document.getElementById("listrow").style.display="none";
}



function getTransporter(num)
{
	//alert("in function");
	try{
	//alert("in try");
	console.log("In Method getTransporter");
	var b=0;
	var transporter = document.getElementById("transporter").value;
	//alert("transporter"+transporter);

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
			document.getElementById("listrow").style.display="";
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			document.data1.counter.value=b;
			document.data1.counter.value=b*document.data1.counter.value;
			counter=document.data1.counter.value;
		} 
	};
	var queryString = "?transporter="+transporter+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "GetTransNames.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    	document.getElementById("listrow").style.display="none";
    }
	}catch(e)
	{
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