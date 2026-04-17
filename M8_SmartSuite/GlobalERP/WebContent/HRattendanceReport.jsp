 <%@page import="java.util.Date"%>
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
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null, st13=null;
try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
    st11 = conn.createStatement();
    st12 = conn.createStatement();
    st13 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    
<%Date curdate=new Date();
String date1=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(curdate);
int yyyy = Calendar.getInstance().get(Calendar.YEAR); 
String m1="";
String mmm="";
String heading="",heading1="";
int year=0;
try{ m1=request.getParameter("month");
	System.out.println(",,,,,,,,,,,,,,"+m1);
    year=Integer.parseInt(request.getParameter("year"));
    
    switch(Integer.parseInt(m1))
    {
    case 1:
    	mmm="January";
           break;  
    case 2:
    	mmm="February";
           break;  
    case 3:
    	mmm="March";
           break;  
    case 4:
    	mmm="April";
           break;  
    case 5:
    	mmm="May";
           break;  
    case 6:
    	mmm="June";
           break;  
    case 7:
    	mmm="July";
           break;  
    case 8:
    	mmm="August";
           break;  
    case 9:
    	mmm="September";
           break;  
    case 10:
    	mmm="October";
           break;  
    case 11:
    	mmm="November";
           break;  
    case 12:
    	mmm="December";
           break;  

           
    }
    System.out.print(m1==null);
    

}catch(Exception e){
	System.out.println(",,,,,,,,,,,,,,"+e);
	}

%>
<%
if(m1==null)
{
	heading="Attendance Summary Report";
	}
else{
		heading="Attendance Summary Report For "+mmm+" "+year+""; heading1="AttendanceReportFor_"+mmm+"-"+year+"";
     }
%>
<div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=heading %></h5>
    </div>
</div>
 <form name="AttendanceReportforhr" id="AttendanceReportforhr" method="post">
<div class="row col-12">
		    <div class="col-md-4"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Month</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="month" name="month">
						<%if(m1==null)
 		        	{ %>
						<option value="01">January</option>
						<option value="02">February</option>
						<option value="03">March</option>
						<option value="04">April</option>
						<option value="05">May</option>
						<option value="06">June</option>
						<option value="07">July</option>
						<option value="08">August</option>
						<option value="09">September</option>
						<option value="10">October</option>
						<option value="11">November</option>
						<option value="12">December</option>
						<%
					}
 		          else{%>
						<%if(m1.equals("01")){ %><option value="01" selected="selected">January</option>
						<%}else{%><option value="01">January</option>
						<%} 
 		         
 		         if(m1.equals("02")){ %><option value="02"
							selected="selected">February</option>
						<%}else{%><option value="02">February</option>
						<%} 
 		         
			     if(m1.equals("03")){ %><option value="03" selected="selected">March</option>
						<%}else{%><option value="03">March</option>
						<%} 
 		         
			     if(m1.equals("04")){ %><option value="04" selected="selected">April</option>
						<%}else{%><option value="04">April</option>
						<%}
 		         
			     if(m1.equals("05")){ %><option value="05" selected="selected">May</option>
						<%}else{%><option value="05">May</option>
						<%} 
			     
			     if(m1.equals("06")){ %><option value="06" selected="selected">June</option>
						<%}else{%>
						<option value="06">June</option>
						<%}
 		         
			     if(m1.equals("07")){ %><option value="07" selected="selected">July</option>
						<%}else{%><option value="07">July</option>
						<%} 
 		         
			     if(m1.equals("08")){ %><option value="08" selected="selected">August</option>
						<%}else{%><option value="08">August</option>
						<%}
 		         
			   if(m1.equals("09")){ %><option value="09" selected="selected">September</option>
						<%}else{%><option value="09">September</option>
						<%} 
			     
			      if(m1.equals("10")){ %><option value="10" selected="selected">October</option>
						<%}else{%><option value="10">October</option>
						<%} 
 		         
			    if(m1.equals("11")){ %><option value="11" selected="selected">November</option>
						<%}else{%><option value="11">November</option>
						<%} 
			     
			    if(m1.equals("12")){ %><option value="12" selected="selected">December</option>
						<%}else{%><option value="12">December</option>
						<%} 
 		         }%>

				</select> 
				 <script>
                            const mySel = document.getElementById("month");

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
             <div class="col-md-2">
				  <label for="dropdown"><b>Year</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="year" name="year"  onclick="getYear();">
						<%for(int i=yyyy;i>2000;i--){ %>
						<%if(i==year){ %><option value="<%=i%>" selected="selected"><%=i%></option>
						<%}else{ %><option value="<%=i%>"><%=i%></option>
						<%}} %></select>
					
					 <script>
                            const mySel = document.getElementById("year");

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
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1"></div>
		</div>				
	</form>
<br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
					<th>Sr No.</th>
					<th>EmpID</th>
					<th>Emp Name</th>
					<th>Month Days</th>
					<th>HoliDays</th>
					<th>Present<br>Days</th>
					<th>Present Days<br>+Holiday</th>
					<th>Days with<br>8.5 Hrs</th>
					<th>Days without<br>8.5 Hrs</th>
					<th>Leaves<br>Applied</th>
					<th>Leaves <br>Sanctioned</th>
					<th>Sandwich <br>Holiday</th>
				</tr>
</thead>
<tbody>
	<%
	try{
String mon=request.getParameter("month");
int month=Integer.parseInt(request.getParameter("month")); 
int monthdays=0;
DecimalFormat df= new DecimalFormat("#.00");
DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
System.out.println("month"+mon);
switch(month)
{
case 1: case 3: case 5:case 7:case 8: case 10: case 12: 
	monthdays=31;
       break;  
case 2:
	monthdays=28;
       break;
case 4: case 6: case 9: case 11: monthdays=30; 
       break;
}
System.out.println("Monthdays===="+monthdays);
//+++++++++++++++++++++++++++++++++++++++++++++
String sunDate="";

int i=1;String sqlcountsun="";
int counthoilday=0,prestday=0;
String empid="",Name="";
String	sqlData="";
String leaveApply="",leaveApprove="";

String cmpDate="",empName="",inTime="",outTime="",uname="";
String diff="";
String sql="select DISTINCT(EmpID) as EmpID,Name,UName FROM t_leaveadmin where  Status='Yes' order by EmpID";
System.out.println("SQL all $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n"+sql);
ResultSet rs=st1.executeQuery(sql);

while(rs.next())
{ int countw85=0;
  int countwout85=0,countswhoilday=0;;
  int count=0 ;int j=0 ,days=monthdays;
 double daysapplied=0,daysapprove=0;
  System.out.println("days===========================>"+days);
  String startdate=""+year+"-"+mon+"-01";
  String enddate=""+year+"-"+mon+"-"+monthdays+"";
 
	empid=rs.getString("EmpID");
	uname=rs.getString("UName");
	Name=rs.getString("Name");
	System.out.println("======="+i+"========");
	
	//====================== get first checkin date ================
	try{
	    String firstchkin="select checkDate from db_leaveapplication.t_checkinout where EmpID='"+empid+"' and (CheckinType = 'In' or CheckinType = 'OUT') and checkDate between '"+startdate+"' and '"+enddate+"' order by checkDate limit 1 ";
	    ResultSet rsfchkin=st2.executeQuery(firstchkin);
	    System.out.println("firstchkin query  "+firstchkin);
		if(rsfchkin.next())
		{
			startdate=rsfchkin.getString("checkDate");
			days=Integer.parseInt(startdate.substring(startdate.indexOf("-")+4,startdate.lastIndexOf("")));
		}
		else
		{startdate=enddate;}
	    }catch(Exception e){System.out.println("not get first chechin date"+e);}
	  	    
	String sqlpday="SELECT count(DISTINCT(checkDate)) as count,checkDate FROM t_checkinout WHERE `EmpID` ='"+empid+"' AND (CheckinType = 'In' or CheckinType = 'OUT')  and checkDate between '"+startdate+"' and '"+enddate+"'";
	ResultSet rspday=st3.executeQuery(sqlpday);
	while(rspday.next())
	{prestday=rspday.getInt("count");
	}
	//********************* count sunday & hoildays ************
	 	
	for(j=days;j<=monthdays;j++)
	{
	  sqlcountsun="select dayofweek('"+year+"-"+mon+"-"+j+"'),'"+year+"-"+mon+"-"+j+"' as date";
	  ResultSet rs1=st6.executeQuery(sqlcountsun);
	  while(rs1.next())
	  {
		  if(rs1.getInt(1)==1)
		  {count++;
		  }
	     
	}
	}	
	String sqlhoilday="select count(*) from t_hoildays where hoildayDate between '"+startdate+"' and '"+enddate+"'";
		ResultSet rshday=st4.executeQuery(sqlhoilday);
		if(rshday.next())
		{counthoilday=rshday.getInt(1);
		}
		//*************** hoilday + sundays *****************
		counthoilday=counthoilday+count;
  
	//*************** get the  working hours***************
	   sqlData="select a.EmpID,a.EmpName,a.CheckinDateTime,a.checkDate,a.checkTime,a.CheckinType,a.Office,a.Status,a.EntryComments,b.TypeValue,b.Name "+
		"from t_checkinout a "+
		"inner join( "+
		"select * from "+ 
		"t_leaveadmin "+ 
		"where EmpID='"+empid+"') b "+
		"on(b.EmpID = a.EmpID) "+
		"where checkDate>='"+startdate+"' and checkDate<='"+enddate+"' "+
		"group by checkDate, EmpID";
		
		//System.out.println(sqlData);
		ResultSet rs1=st5.executeQuery(sqlData);
		 String t="",chkin="-",chkout="-";
		while(rs1.next())
		{
				empName=rs1.getString("Name");
				cmpDate=rs1.getString("checkDate");
		try{		
	            String sql1="SELECT min(CheckinDateTime) as chkInDateTime FROM t_checkinout WHERE CheckinType='IN' and checkDate='"+cmpDate+"' and EmpId='"+empid+"' group by checkDate";
		ResultSet rs2=st6.executeQuery(sql1);
		if(rs2.next())
		{
	inTime=rs2.getString("chkInDateTime");
	chkin=inTime.substring(11,inTime.length());
	t=inTime.substring(0,10);
		}
		String sql2="SELECT max(CheckinDateTime) as chkOutDateTime FROM t_checkinout WHERE CheckinType='OUT' and checkDate='"+cmpDate+"' and EmpId='"+empid+"' group by checkDate";
		System.out.println(sql2);
		ResultSet rs3=st7.executeQuery(sql2);
		if(rs3.next())
		{
	outTime=rs3.getString("chkOutDateTime");
	System.out.println("checkouttime "+outTime);
	chkout=outTime.substring(11,outTime.length());	
	
	t=outTime.substring(0,10);
		}
		try
		{
	chkin=chkin.substring(0,5);
		}
		catch(Exception e)
		{
	System.out.println(e);
		}
		try
		{
	chkout=chkout.substring(0,5);
		}
		catch(Exception e)
		{
	System.out.println(e);
		}
		System.out.println("====================================>>"+t+" chackout"+chkout+" and chkin"+chkin);
		
		String sqltdiff="select timeDiff('"+chkout+"','"+chkin+"')";
		ResultSet rstdiff=st8.executeQuery(sqltdiff);
		while(rstdiff.next())
		{	
		diff=rstdiff.getString(1);
		}
		if(diff==null || diff.equals("null"))
			diff="NA";
		System.out.println("=============Time diff=======================>>"+diff);
		int hrs=0;
		int min=0;
		try{
		hrs=Integer.parseInt(diff.substring(0,diff.indexOf(":")));
		min=Integer.parseInt(diff.substring(diff.indexOf(":")+1,diff.lastIndexOf(":")));
		min=(hrs*60)+min;
		}catch(Exception e){System.out.println("");}
		if(min<510 || diff.contains("NA") || diff.equals("null"))
		{ countwout85++;
		}
		else
		{
	      countw85++;
		}
		chkout="-";
		chkin="-";
		}catch(Exception e){System.out.println("exception in time"+e);}
		
		}		
	String dateofreporting="",firstdayofleave="";
	try{int mon1=0;
		startdate=""+year+"-"+mon+"-01";
	String sqlleave="select firstdayofleave,dateofreporting,daysapplied from t_leaverequest where emailid='"+uname+"' and "+
					"(status='Pending' or status='Accepted') and `inserteddatetime` between '"+startdate+"' and '"+enddate+"' order by firstdayofleave desc";
	ResultSet rslev=st9.executeQuery(sqlleave);
	while(rslev.next())
	{   
		leaveApply=df.format(Double.parseDouble(rslev.getString("daysapplied")));
		daysapplied=daysapplied + Double.parseDouble(leaveApply);
		
	}
	
	String sqllevApp="select firstdayofleave,dateofreporting,daysapplied from t_leaverequest where emailid='"+uname+"' and status='Accepted' order by firstdayofleave desc";
	ResultSet rslevApp=st10.executeQuery(sqllevApp);
	while(rslevApp.next())
	{
		leaveApprove=df.format(Double.parseDouble(rslevApp.getString("daysapplied")));
		daysapprove=daysapprove+ Double.parseDouble(leaveApply);
	}
	int sandwitchsun=0;	
	String sqlleavepen="select firstdayofleave,dateofreporting,daysapplied from t_leaverequest where emailid='"+uname+"' and "+
			"status='Pending' and `inserteddatetime` between '"+startdate+"' and '"+enddate+"' order by firstdayofleave desc";
	ResultSet rslevPan=st11.executeQuery(sqlleavepen);
		System.out.println("sqlleave "+sqlleavepen);
		while(rslevPan.next())
		{   
		firstdayofleave=rslevPan.getString("firstdayofleave");
		dateofreporting=rslevPan.getString("dateofreporting");
		
		System.out.println(firstdayofleave+"========="+dateofreporting);
		int year1=0,month1=0,day1=0;
		int year2=0,month2=0,day2=0;
		
		year1=Integer.parseInt(firstdayofleave.substring(0,4));
		month1=Integer.parseInt(firstdayofleave.substring(5,7));
		day1=Integer.parseInt(firstdayofleave.substring(8,10));
		
		year2=Integer.parseInt(dateofreporting.substring(0,4));
		month2=Integer.parseInt(dateofreporting.substring(5,7));
		day2=Integer.parseInt(dateofreporting.substring(8,10));
		if(month1==month2)
		{
			days=day1;
			mon1=day2-1;
		}
		
		for(j=days;j<=mon1;j++)
		{
		  sqlcountsun="select dayofweek('"+year+"-"+mon+"-"+j+"'),'"+year+"-"+mon+"-"+j+"' as date";
		  ResultSet rs2=st12.executeQuery(sqlcountsun);
		  while(rs2.next())
		  {
			  if(rs2.getInt(1)==1)
			  {sandwitchsun++;
			   sunDate=rs2.getString("date");
			   System.out.println("date -->"+sunDate);
			  }
		  }
		}
		Calendar cal=Calendar.getInstance();
		DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateofreporting));
		cal.add(Calendar.DATE,-1);
		dateofreporting=df1.format(cal.getTime());
		String sqlhoilday1="select count(*) from t_hoildays where hoildayDate between '"+firstdayofleave+"' and '"+dateofreporting+"'";
		ResultSet rshday1=st13.executeQuery(sqlhoilday1);
		if(rshday1.next())
		{countswhoilday=rshday1.getInt(1);
		}
		//*************** hoilday + sundays *****************
		countswhoilday=countswhoilday+sandwitchsun;
		}
		counthoilday=counthoilday-countswhoilday;
	}
	catch(Exception e)
	{
		System.out.println("exception in  leave result"+e);
	}
%>

				<tr>
					<td class="text-center"><%=i++%></td>
					<td class="text-center"><%=empid%></td>
					<td class="text-left"><%=Name%></td>
					<td class="text-center"><%=monthdays%></td>
					<td class="text-center"><%=counthoilday%></td>
					<td class="text-center"><%=prestday%></td>
					<td class="text-center"><%=counthoilday+prestday%></td>
					<td class="text-center"><%=countw85%></td>
					<td class="text-center"><%=countwout85%></td>
					<td class="text-center"><%=daysapplied%></td>
					<td class="text-center"><%=daysapprove%></td>
					<td class="text-center"><%=countswhoilday%></td>
				</tr>
				<%
}
}
catch(Exception e)
{System.out.println("error "+e);
}
%>
			</table>
		</div>
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
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
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
