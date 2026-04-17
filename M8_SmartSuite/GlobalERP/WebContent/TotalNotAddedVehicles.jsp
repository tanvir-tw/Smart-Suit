<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@page import="java.util.Date"%>
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
Statement  sterp1 = null,stmt=null;
	Statement sterp2 = null,  stqr = null;
	String selectedName, fpreviousmonth="", fppreviousmonth="";
	String FollowUpType = "",Group="";
	String customerName="";
	int totalVehicles=0;
	
Connection conn = null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    	st = conn.createStatement();
    	sterp1 = conn.createStatement();
		sterp2 = conn.createStatement();
		stqr = conn.createStatement();
		stmt=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

try
{

	 	String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
	 	String todaysTime = new SimpleDateFormat(" HH:mm:ss")
	 				.format(new java.util.Date());
		int i=0,srno=1;
		int vehid=0;
		int k=2000;
		String vehiclecode = "";
	 	Date tdy = new Date();
	 	Date tomorrow = new Date();
	 	Calendar cal = Calendar.getInstance();
	 	Calendar now = Calendar.getInstance();
	 	cal.setTime(tdy);
	 	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(tdy);
	 	System.out.println("Todays date is"+todaysDate1);
	 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
	 				.format(tdy);
	 	cal.add(Calendar.DAY_OF_MONTH, -1);
	 	Date YesterdaysDateAsDate = cal.getTime();
	 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
	 				.format(YesterdaysDateAsDate);

	 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
	 				.format(new java.util.Date());
	 	
	 	
		int currentmonthcount=0,currentyearcount=0, ppreviousmonth=0, ppreviousyear=0;
 		int previousmonth=0;
 		int previousyear=0;
 		String finalmonth="";
		String currentyear="";
		String currentmonth="select MONTH('"+todaysDate1+"')";
		System.out.println(currentmonth);
		ResultSet rsMonth=sterp1.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		System.out.println("current month "+currentmonthcount);
		
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
		{
			finalmonth="0"+Integer.toString(currentmonthcount);
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
			System.out.println("final month is  "+finalmonth);
			previousmonth=Integer.parseInt(finalmonth)-1;
			System.out.println("previous month is  "+previousmonth);
		}
		if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
			{
				fpreviousmonth="0"+Integer.toString(previousmonth);
			}
			else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
			{
				fpreviousmonth=Integer.toString(previousmonth);
			}
		/**********************************************************************************/
		
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
	
	%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Unbilled Vehicles </h5>
    </div>
</div>	

<%
String exportFileName="Vehicle_det.xls";   // GIVE YOUR REPORT NAME

System.out.println("Relative Previous year:"+previousyear);
System.out.println("Final previous month"+fpreviousmonth);
Calendar cldr = Calendar.getInstance();
cldr.set(previousyear, previousmonth, 0);
Date date = cldr.getTime();
SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
String lastdate = format1.format(date);
int lastdayofmonth = cldr.getActualMaximum(Calendar.DAY_OF_MONTH);
sql1="select * from db_gps.t_vehicledetails where OwnerName='Trinity Enterprises' and VehicleCode not in (select distinct vehid from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+") and   (( status = '-' and installeddate <= '"+previousyear+"-"+fpreviousmonth+"-"+lastdayofmonth+"') OR (status <> '-' and lastreplacementdate >= '"+previousyear+"-"+fpreviousmonth+"-01 00:00:00'))";
String TableName=session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth;
String Installdate=previousyear+"-"+fpreviousmonth+"-"+lastdayofmonth;
String LastRepDate=previousyear+"-"+fpreviousmonth+"-01 00:00:00";
%>	
<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<br>
<div class="container" style="width:60%">
<table id="example" class="display" style="width:100%">
		<thead>
	   		<tr>
					<th  width="4%">SrNo.</th>
					<th>Customer Name</th>
					<th>Total Vehicles</th>

			</tr>
		</thead>
			<tbody>
			<%
			         String sql="select OwnerName , count(*) as TotalVehicle from db_gps.t_vehicledetails where VehicleCode not in (select distinct vehid from db_GlobalERP."+TableName+") and (( status = '-' and installeddate <= '"+Installdate+"')  OR (status <> '-' and lastreplacementdate >='"+LastRepDate+"')) group by OwnerName order by TotalVehicle desc";
			         System.out.println("Main sql Query== "+sql);
			         
			         ResultSet rs=stmt.executeQuery(sql);
			         System.out.println("Result set== "+rs);
			         while(rs.next())
			         {
			        	 customerName=rs.getString("OwnerName");
			     	 	 totalVehicles=rs.getInt("TotalVehicle");
                %>    
                <tr>
                   <td class="text-center"><%=srno%></td>
                   <td class="text-center"><%=customerName%></td>
                   <td class="text-center"><a href="VehicleAddition.jsp?customerName=<%=customerName%>" target="_blank"><%=totalVehicles%></a> </td>
                </tr>               
			    <%    	 
			           i++;
					   srno++;
			         }
			%>
							
			</tbody>
		</table>
		</div>
</div>

<%      }
		catch(Exception e)
		{
			System.out.println("Exception is -"+e);
		}
%>

  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-3"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-4 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title : 'Unbilled Vehicle Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	                         title : 'Unbilled Vehicle Report', 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	                         title : 'Unbilled Vehicle Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	                         title : 'Unbilled Vehicle Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title : 'Unbilled Vehicle Report', 
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>	
</body>
</html>
