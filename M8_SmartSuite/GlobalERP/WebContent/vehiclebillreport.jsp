 <%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>GlobalERP</title>
<style type="text/css">
.popup{

    background-color: white;
    z-index: 9999;   /* bring popup above datatable */
    border: 1px solid #ccc;
    padding: 5px;
    white-space: nowrap; /* keep text in one line */

}
</style>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String bt="";

	Statement sterp = null, sterp1 = null;
	Statement sterp2 = null;
	Statement stchk=null;
	String selectedName,fpreviousmonth="";
	String FollowUpType = "",Group="", strcustomer = "", strgroupname = "";
 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
   	 	st = conn.createStatement();
    	sterp = conn.createStatement();
		sterp1 = conn.createStatement();
		sterp2 = conn.createStatement();
		stchk = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
DecimalFormat twoDForm = new DecimalFormat("#.##");
	String toDateCal = "", sql1 = "",sql2="",sql3="";
	String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
int i=1;
int vehid=0;
int k=2000;
	Date tdy = new Date();
	Date tomorrow = new Date();
	Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	cal.setTime(tdy);
	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
	cal.add(Calendar.DAY_OF_MONTH, -1);

%>  
<%
try{
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Vehicle Bill Summary </h5>
    </div>
</div>
<form name="data1"  method="get" onsubmit="return validate();"> 
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				
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
							        for (int year = 1990; year <= 2050; year++) {
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
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			
			<div class="col-md-2"></div>
			
		</div>
</form> 
<br> 
<%
if(null!=request.getQueryString())
{
	String year=request.getParameter("year");
	String month=request.getParameter("month");
	System.out.println(year+"  "+month);
	int monthdays=0;

 int smonth = Integer.parseInt(month);
 System.out.println("Selected month in int is "+smonth);
 int syear = Integer.parseInt(year);
 System.out.println("Selected year in int is "+syear);
 int spreviousyear, spreviousmonth;
 if(smonth==1)
 {
  System.out.println("Selected month is 1"); 	 
  spreviousyear=syear-1;
  spreviousmonth=12;
  System.out.println("Selected previous year "+spreviousyear+"Selected previous month"+spreviousmonth);
 }
 else 
 {
	 spreviousyear=syear;
     System.out.println("selected month  is "+smonth);
     spreviousmonth = smonth-1;
     System.out.println("Selected previous year is "+spreviousyear+"selected previous month is "+spreviousmonth);
 }

int currentmonthcount=0,currentyearcount=0;
int previousmonth=0, ppreviousmonth=0;
int previousyear=0, ppreviousyear=0;
String finalmonth="";
String currentyear="", fppreviousmonth = "";

String currentmonth="select MONTH('"+todaysDate1+"')";
System.out.println(currentmonth);
ResultSet rsMonth=sterp1.executeQuery(currentmonth);
rsMonth.next();
currentmonthcount=rsMonth.getInt(1);
System.out.println("current month "+currentmonthcount);

if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
{
finalmonth="0"+currentmonthcount;
}
else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
{
finalmonth=Integer.toString(currentmonthcount);
}		

System.out.println("a    a "+finalmonth);

currentyear="select YEAR('"+todaysDate1+"')";
System.out.println(currentyear);
ResultSet rsYear=sterp2.executeQuery(currentyear);
rsYear.next();
currentyearcount=rsYear.getInt(1);

System.out.println(currentyearcount);  

if(currentmonthcount==1)
{
previousyear=currentyearcount-1;
previousmonth=12;

}
else 
{
previousyear=currentyearcount;
System.out.println("abcd  "+finalmonth);
previousmonth=Integer.parseInt(finalmonth)-1;
System.out.println("abcd  "+previousmonth);
}
if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
	{
		fpreviousmonth="0"+Integer.toString(previousmonth);
	}
	else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
	{
		fpreviousmonth=Integer.toString(previousmonth);
	}
/************************************************************************/
if(previousmonth==1)
{
	ppreviousyear=previousyear-1;
	ppreviousmonth=12;
}
else 
{
	ppreviousyear=previousyear;
	System.out.println("final previous month is  "+fpreviousmonth);
	ppreviousmonth=Integer.parseInt(fpreviousmonth)-1;
	System.out.println("pprevious month is  "+ppreviousmonth);
}
if(ppreviousmonth==1 || ppreviousmonth==2 || ppreviousmonth==3 || ppreviousmonth==4 || ppreviousmonth==5 || ppreviousmonth==6 || ppreviousmonth==7 || ppreviousmonth==8 || ppreviousmonth==9 )
	{
		fppreviousmonth="0"+Integer.toString(ppreviousmonth);
	}
	else if(ppreviousmonth==10 || ppreviousmonth==11 || ppreviousmonth==12)
	{
		fppreviousmonth=Integer.toString(ppreviousmonth);
	}
/************************************************************************/


String checktb = "show tables like '"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+"'";
System.out.println("Query is"+checktb);
ResultSet rschk=stchk.executeQuery(checktb);
System.out.println("After rschk");
if(rschk.next())
{
	
       
       String sqldata="Select ERPCustName as Customer,ERPCode as CustomerCode,SLAPer,Rate,Rate/"+monthdays+" as ChargeperDay,"+
			   "count("+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehID) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,"+
			   "sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,"+
			   "sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays ,"+
			   "GroupName,BillType,sum(jrm) as jrmvehcount from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" ,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" "+
			   "where month1='"+year+"-"+month+"-01' and  "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehID = "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".VehID  and "+
			   ""+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' group by   "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCustName,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".groupcode";
               System.out.println(sqldata);
               ResultSet rsData=sterp.executeQuery(sqldata);
               
               
%>

<table id="example" class="display" style="width:100%;">          
       <thead>
           <tr>
	           <th>Customer</th>											
	           <th>CustomerCode</th>
	           <th>SLA</th>
	           <th>Rate</th>
	           <th>Changes per Day </th>
	           <th>No of Vehicles</th>
	           <th>Vehicle Added</th>
	           <th>Vehicle Removed</th>
	           <th>Captured Days</th>
	           <th>Disconnected Days</th>
	           <th>NotCaptured</th>
	           <th>Total Days</th>
	           <th>Total BilledDays</th>
	           <th>GroupName</th>
	           <th>BillType</th>
	           <th>jrm veh count</th>
           </tr>
        </thead> 
        <tbody>
        <%
   while(rsData.next())
   {	

	   strcustomer = rsData.getString("Customer");
	   System.out.println("Customer before conversion is"+strcustomer);
	   /*trptr = trptr.replace("&","^");*/
	   strcustomer = strcustomer.replace("&","^");
	   System.out.println("Customer after conversion is"+strcustomer);
	   strgroupname = rsData.getString("GroupName");
	   System.out.println("groupname before conversion is"+strgroupname);
	   strgroupname = strgroupname.replace("&","^");
	   System.out.println("groupname after conversion is"+strgroupname);
	   
	   String jrmcount = rsData.getString("jrmvehcount");
	   int jrmvehcount = 0;
	   try{
		   jrmvehcount = Integer.parseInt(jrmcount);
	   }catch(Exception e){
		   jrmvehcount = (int)Double.parseDouble(jrmcount);
	   }
	   
%>
        
     <tr>
     
<td style="position: relative;">
    <a href="javascript:toggleDetails('<%=rsData.getString("Customer") %>', 'true', '<%=i%>')">
        <%=rsData.getString("Customer") %>
    </a>

    <div class="popup" id="popup<%=i %>" 
         style="display:none; position:relative; top:20px; left:0; 
                background:#fff; border:1px solid #000; 
                padding:5px;min-width:100px;opacity:1" >
         
        <table style="width:100%; border:1; cellpadding:5; cellspacing:0">
            <tr>
                <td align="center">
                    <a href="createAnnexture.jsp?cust=<%=rsData.getString("CustomerCode") %>&name=<%=strcustomer %>&year=<%=year %>&month=<%=month %>&group=<%=strgroupname %>&vehiclenos=<%=rsData.getString("NoofVehicles") %>&rateperveh=<%=rsData.getString("Rate") %>&jrmcount=<%=jrmvehcount %>&billtype=<%=rsData.getString("BillType") %>&slacount=<%=rsData.getString("SLAPer") %>&billdays=<%=rsData.getString("TotalBilledDays") %>">
                        Create Annexture
                    </a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="javascript:toggleDetails('<%=rsData.getString("Customer")%>', 'false', '<%=i%>')">Close</a>
                </td>
            </tr>
        </table>
    </div>
</td>

<td class="text-center"><%=rsData.getString("CustomerCode") %></td>
<td class="text-center"><%=rsData.getString("SLAPer") %></td>
<td class="text-center"><%=rsData.getString("Rate") %></td>
<td class="text-center"><%=twoDForm.format(rsData.getDouble("ChargeperDay"))  %></td>
<td class="text-center"><%=rsData.getString("NoofVehicles") %></td>
<td class="text-center"><%=rsData.getString("VehcileAdded") %></td>
<td class="text-center"><%=rsData.getString("VehcileRemoved") %></td>
<td class="text-center"><%=rsData.getString("CapturedDays") %></td>
<td class="text-center"><%=rsData.getString("DisconnectedDays") %></td>
<td class="text-center"><%=rsData.getString("NotCaptured") %></td>
<td class="text-center"><%=rsData.getString("TotalDays") %></td>
<td class="text-center"><%=rsData.getString("TotalBilledDays") %></td>
<td class="text-left"><%=rsData.getString("GroupName") %></td>
<td class="text-left"><%=rsData.getString("BillType") %></td>
<td class="text-center"><%=rsData.getString("jrmvehcount") %></td>
</tr>
				 <%
     i++;
    }//while
        %>
        </tbody>
       
        <%   	
    	
    	
   } else
   {
		  
	     System.out.println("In else");
	     %>
	     
	     <script>
	     	window.location="alertGoTo.jsp?msg=There are no records to display.&goto=vehiclebillreport.jsp";
	     </script>
	     
	     <%
	   
	  }
}
%>
        </table>
 </div>

 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>

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

function toggleDetails(refno, show, row) {
    var popupx = document.getElementById("popup" + row);
    if (show === "true") {
        popupx.style.display = "block"; // Show the popup
    } else {
        popupx.style.display = "none"; // Hide the popup
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
	        fixedColumns: { 
	            left: 2      //To freeze two columns
	        }, 
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Vehicle Bill Report' 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Vehicle Bill Report' ,
							 orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							 
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Vehicle Bill Report' 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Vehicle Bill Report' 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Vehicle Bill Report' 
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>