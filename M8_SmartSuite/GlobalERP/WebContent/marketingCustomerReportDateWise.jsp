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
// Connection Initialization
Connection conn = null;
Statement st1=null,st6=null;
Statement stMaster=null,stMaster1=null,stDATE=null,stweek=null,stweek1=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st6 = conn.createStatement();
    stMaster = conn.createStatement();
    stMaster1 = conn.createStatement();
    stDATE = conn.createStatement();
    stweek = conn.createStatement();
    stweek1 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>
	<%
	String visits="0",phoneCalls="0",letters="0",meetings="0",email="0",numberOfprospects="0",numberOfSQ="0",numberOfSO="0",sumOfSO="0",ActionPoints="0";
	String fromDate="",toDate="",fromDateCal="",toDateCal="",fromdatevdTime="",todatevdTime="";
	double Grandindex=0,P_Grandindex=0,Grandindex1=0,P_Grandindex1=0,Month_index_total=0,Month_Grandindex=0;
	long SQValueMonthly=0,SQValueWeekly=0;
	int visitcounter=0,no=0,finalvisits=0;
	String FollowUpType="",sqlDetails="",newfromdate="",newtodate="", MarktngCode="",customercode=null,custName=null,usermail="",repr="",SQValue="",abc="",divFlag="T";
	
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			DecimalFormat df2 = new DecimalFormat("0.00");
			StringBuffer htmlstring= new StringBuffer();			
	%>
	<%
		Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	 Calendar date = Calendar.getInstance();
     date.set(Calendar.DAY_OF_MONTH, 1);
     DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
      String startDate=df.format(date.getTime());
	
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	System.out.println(">>>>>>>>>fromDate:"+fromDate);
	newfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromdatevdTime=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	else
	{
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(date.getTime());
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(date.getTime());
		System.out.println("======>"+fromDateCal);
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		System.out.println(">>>>>>>>>toDate:"+toDate);
		newtodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));	
		todatevdTime=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	DateFormat formatter1 ; 
	Date from1,to1 ; 
	 formatter1 = new SimpleDateFormat("yyyy-MM-dd");
	 from1 = (Date)formatter1.parse(fromDate);  
	 to1 = (Date)formatter1.parse(toDate);
	 System.out.println(">>>>>>>>>>>>>>>from1 :"+from1 ); 
	 System.out.println(">>>>>>>>>>>>>>>to1 :"+to1);
	  double diff= (to1.getTime() - from1.getTime()) / (1000 * 60 * 60 * 24)+1;
	  System.out.println(">>>>>>>>>>>>>>>>>>diff:"+diff);
	if(!(session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")))
	if (!(null == request.getParameter("custCode"))){
		customercode=request.getParameter("custCode");
	}
	
	if (!(null == request.getParameter("custName"))){
		custName=request.getParameter("custName");
	}
	else
	{
		custName="Select";
	}
	System.out.println("Customer Name==&*&*&*&*&*&&*&**&==>"+custName);
	
try 
{			
					Date tomorrow=new Date();					
					Calendar cal1 = Calendar.getInstance();
					Calendar now = Calendar.getInstance();
					cal1.setTime(today);
					String todaysDateRk=new SimpleDateFormat("yyyy-MM-dd").format(today);
					String todaysDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(today);
					
					cal1.add(Calendar.DAY_OF_MONTH, -1);
					
					Date YesterdaysDateAsDate = cal1.getTime();
					String yesterdaysDate=new SimpleDateFormat("yyyy-MM-dd").format(YesterdaysDateAsDate);
					
					cal1.setTime(today);
					cal1.add(Calendar.DAY_OF_MONTH, +1);
					Date  tomorowAsDate=cal1.getTime();
					String tomoDate=new SimpleDateFormat("yyyy-MM-dd").format(tomorowAsDate);
					String tomoDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(tomorowAsDate);
					
					cal1.setTime(today);
					Date sevendaysbefore=new Date();
					cal1.add(Calendar.DAY_OF_MONTH, -7);
					sevendaysbefore=cal1.getTime();
					String sevenbefore=new SimpleDateFormat("yyyy-MM-dd").format(sevendaysbefore);
					String sevenbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sevendaysbefore);
					
					cal1.setTime(today);
					cal1.add(Calendar.DAY_OF_MONTH,-30);
					Date MonthAsDate=cal1.getTime();
					String monthbefore=new SimpleDateFormat("yyyy-MM-dd").format(MonthAsDate);
					String monthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(MonthAsDate);
					
					cal1.setTime(today);
					cal1.add(Calendar.DAY_OF_MONTH,-60);
					Date twoMonthAsDate=cal1.getTime();
					String twomonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(twoMonthAsDate);
					String twomonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(twoMonthAsDate);
					
					cal1.setTime(today);
					cal1.add(Calendar.DAY_OF_MONTH,-90);
					Date threeMonthAsDate=cal1.getTime();
					String threemonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(threeMonthAsDate);
					
					System.out.println("3 3 3 3  333333 33 333333   "+threemonthbefore);
					String threemonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(threeMonthAsDate);
					
					cal1.setTime(today);
					cal1.add(Calendar.DAY_OF_MONTH,-180);
					Date sixMonthAsDate=cal1.getTime();
					String sixmonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(sixMonthAsDate);
					String sixmonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sixMonthAsDate);
					
					cal1.setTime(today);
					now.setTime(today);
						
					String sqlDate="SELECT DAYOFWEEK('"+todaysDate+"')";
					ResultSet rsDate=stDATE.executeQuery(sqlDate);
					int dayOfWeek=1,weekCount=1;
					rsDate.next();
					dayOfWeek=rsDate.getInt(1);
		%>


<%
//++++++++++++++++++Ravi+++++++++++++++++++++++++++++++++
boolean flag_day = false;
String f_day =  fromDate.substring(fromDate.lastIndexOf("-")+1).trim();
String l_day =  toDate.substring(toDate.lastIndexOf("-")+1).trim();

System.out.println("The fromdate day =====================>"+fromDate+"  First Day of Month ==>"+f_day);
System.out.println("The todate day   =====================>"+toDate+"    Last Day of Month  ==>"+l_day);

int days_of_month = 0;
int d1 = 0;
int ij=1;
if(f_day.equals("01")){
	
	Date d = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
	Calendar cal12= Calendar.getInstance();
	cal12.setTime(d);
	 d1 = cal12.getActualMaximum(Calendar.DAY_OF_MONTH);	

	String sql = "select DATEDIFF('"+toDate+"', '"+fromDate+"') as daydiff";
	ResultSet rs = st6.executeQuery(sql);
	if(rs.next()){
		days_of_month = rs.getInt("daydiff") + 1;
	}
	
	if((Integer.parseInt(l_day) == d1) && (d1 == days_of_month))
	{
		flag_day = true;
	}			
}
System.out.println("The d1 in month ===================>"+d1);
System.out.println("The days in month ===================>"+days_of_month);
System.out.println("The flag day   =====================>"+flag_day);
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%>	

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Follow Up Report From <%=fromDateCal %> To <%=toDateCal %></h5>
    </div>
</div>

<form  name="marketing" action="" method="get" onsubmit="return validate();"  >
		  <div class="row col-12">
		    <div class="col-md-4"></div>	
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="fromdate" id="fromdate"  class="form-control" value="<%=fromDateCal%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="todate" name="todate"  class="form-control" value="<%=toDateCal%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>	
	<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="Marketingsbmt" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-2">
			</div>			
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "fromdate",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "todate",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>	
	
<%		
			 ij=1;
%>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
	            <th class="col-width-4">Index</th>
				<th>Marketing Representative Name</th>
				<th>Total Customers</th>
				<th>Customers  Followed </th>
				<th>Missed Follow Up </th>
				<th>Yesterday's Follow Up </th>
				<th>Yesterday's Missed Follow Up </th>
				<th>Follow Up Scheduled Today</th>
				<th>Follow Up Scheduled Tomorrow</th>
			</tr>
		</thead>
	<%
	String sqlMarktRep="";
	if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){
		
		sqlMarktRep="Select *  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster as tm,"+session.getAttribute("CompanyMasterID").toString()+"security as ts WHERE  tm.username<>'' and tm.password<>'' and (tm.Compressor=1 or tm.DigitalEquipment=1 or tm.DGSet=1 or tm.Endoscope=1 or tm.OtherGroups=1) and ts.activestatus='Yes' and tm.username = ts.username  order by  tm.MarketingRepNAme";
	 
					 }else{
						
						 sqlMarktRep="Select *  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster as tm,"+session.getAttribute("CompanyMasterID").toString()+"security as ts WHERE  tm.username<>'' and tm.password<>'' and (tm.Compressor=1 or tm.DigitalEquipment=1 or tm.DGSet=1 or tm.Endoscope=1 or tm.OtherGroups=1) and ts.activestatus='Yes' and tm.username = ts.username  order by  tm.MarketingRepNAme";
											
						} 

ResultSet rsMrktRep=stMaster.executeQuery(sqlMarktRep);
System.out.println("New name----------->"+sqlMarktRep);

while(rsMrktRep.next())
{
String aa=rsMrktRep.getString("MarketingRepName");

System.out.println("QRYYYYc For  Marketing Rep**==NAME====>"+aa);

%>
<%//************************************MAIN QUERY GIVES EMP NAME*********************************************************************************
String sqlRep="Select *  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster WHERE  username<>'' and password<>'' and MarketingRepName='"+aa+"'  and (Compressor=1 or DigitalEquipment=1 or DGSet=1 or Endoscope=1 or OtherGroups=1)  order by  MarketingRepNAme";
ResultSet rsRep=stMaster1.executeQuery(sqlRep);
System.out.println("QRYYYYc For  Marketing Rep**======>"+sqlRep);
%>
<tbody>
	<tr>
<%
if(rsRep.next())
{			
			int sumVisits=0,sumPhoneCalls=0,sumLetters=0,sumSalesQuotation=0,sumNewProspects=0;
			usermail=rsRep.getString("MarketingRepEMail"); 
			String	code=rsRep.getString("MarketingRepCode");
			repr=rsRep.getString("MarketingRepName");
		%>
		
		<td class="text-center"><%=ij++%></td>
		<td class="text-center"><%=aa %></td>
		
		<%
			String sqlCustomers="";
			int CountMain=0;int CountInMonth=0,CountInTwoMonth=0,CountIn60To90=0,CountIn90To180=0,CountGrtr180=0,CountYesterDay=0,CountToDay=0,CountTommorow=0,missedCountYesterDay=0;
			
			
			sqlCustomers="Select count(Distinct ProspCustName),1 as CountMain from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  "+
			" UNION "+
			"Select count(Distinct ProspCustName),2 as CountInMonth from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate > '"+monthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),3 as CountInTwoMonth from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+toDate+"' AND FollowUpDate > '"+fromDate+"' AND FollowUpType <> 'Assigned' "+
			" UNION "+
			"Select count(Distinct ProspCustName),4 as CountIn60To90 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+toDate+"' AND FollowUpDate > '"+fromDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),5 as CountIn90To180 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+toDate+"' AND FollowUpDate > '"+fromDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),6 as CountGrtr180 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate < '"+sixmonthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),7 as missCountYesterday from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate = '"+yesterdaysDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),7 as CountYesterday from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+yesterdaysDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),8 as CountToday from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+todaysDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),9 as CountTommorow from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+tomoDate+"'";
			ResultSet rsCust=st1.executeQuery(sqlCustomers);
			if(rsCust.next())
			CountMain=rsCust.getInt(1);  //getInt(1) because it's first column 
			if(rsCust.next())
			CountInMonth=rsCust.getInt(1);            //getInt(1) because it's first column 
			if(rsCust.next())
			CountInTwoMonth=rsCust.getInt(1);
			if(rsCust.next())
			CountIn60To90=rsCust.getInt(1);
			if(rsCust.next())
			CountIn90To180=rsCust.getInt(1);
			if(rsCust.next())
			CountGrtr180=rsCust.getInt(1);
			if(rsCust.next())
			missedCountYesterDay=rsCust.getInt(1);
			if(rsCust.next())
			CountYesterDay=rsCust.getInt(1);
			if(rsCust.next())
			CountToDay=rsCust.getInt(1);
			if(rsCust.next())
			CountTommorow=rsCust.getInt(1);
%>	
		<td class="text-center"><a href="#" onclick="popUp('customerFollowupList.jsp','<%=code %>','<%=CountMain %>','<%= 1%>');"><%=CountMain %></a></td>
		<%
		 int totcount=0;
		String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"
			+ code
			+ "' AND ProspCustName <> '-' AND FollowUpDate < '"
			+ toDate
			+ "' and FollowUpDate > '"
			+ fromDate
			+ "' Group By ProspCustName";

System.out.println(sqlList);	
ResultSet rsList=st1.executeQuery(sqlList);
System.out.println(sqlList);
		 while(rsList.next())
		 {
			 totcount++;
		 }
		 
		 System.out.println("Missed Foll Cont===>"+totcount);
		%>
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=totcount %>','<%=2 %>','<%=toDate %>','<%=fromDate %>');"><%=totcount %></a></td>
		<%
		 int Missedfollowupinlastmonth=0,count=0;
		String missedinlastmonth="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup Group By ProspCustName having max(NextFollowUpDate)  Between '"+fromDate+"' AND '"+toDate+"' and MarketingRepcode = '"+code+"'";
		 System.out.println("missed qry Betwn Date   "+missedinlastmonth);
		 ResultSet rsMissedmonth=st1.executeQuery(missedinlastmonth);
		 while(rsMissedmonth.next())
		 {
			 count++;
		 }
		 System.out.println("Missed Foll Cont===>"+count);
		%>
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=count%>','<%=3 %>','<%=toDate %>','<%=fromDate %>');"><%=count%></a></td>
		
		<%
		String lastweekDate1="",lastweekDate2="";
	    String lastweek="SELECT DATE_SUB( curdate( ) , INTERVAL 7 DAY )";	
		ResultSet rsweek=stweek.executeQuery(lastweek);
		if(rsweek.next())
		{
			 lastweekDate1=rsweek.getString(1);
		}
		String lastweek1="SELECT DATE_SUB( curdate( ) , INTERVAL 1 DAY )";	
		ResultSet rsweek1=stweek1.executeQuery(lastweek1);
		if(rsweek1.next())
		{
			 lastweekDate2=rsweek1.getString(1);
		}
		int followupinlastyesterday=0,countFollNew=0;
		String Folllastyesterday="select * from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate = '"+yesterdaysDate+"' ";
		 System.out.println("missed qry Betwn Date   "+Folllastyesterday);
		 ResultSet rsyesterday=st1.executeQuery(Folllastyesterday);
		 while(rsyesterday.next())
		 {
			 countFollNew++;
		 }
		 
		 System.out.println("Missed Foll Cont===>"+countFollNew);
		 %>
		
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=countFollNew%>','<%=4%>','<%=yesterdaysDate %>','<%=yesterdaysDate %>');"><%=countFollNew%></a></td>
		<%
		int Missedfollowupinlastyesterday=0,countNew=0;
		
		String missedinlastyesterday="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup Group By ProspCustName having max(NextFollowUpDate)='"+yesterdaysDate+"'  and MarketingRepcode = '"+code+"'";
		 System.out.println("missed qry Betwn Date   "+missedinlastyesterday);

		 ResultSet rsMissedyesterday=st1.executeQuery(missedinlastyesterday);
		 while(rsMissedyesterday.next())
		 {
			 countNew++;
		 }
		 System.out.println("Missed Foll Cont===>"+countNew);
		 %>
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=countNew%>','<%=5%>','<%=yesterdaysDate %>','<%=yesterdaysDate %>');"><%=countNew%></a></td>
		
		<%
		int CountToDayNew=0;
		
		String Todayqry="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+todaysDate+"' ";
		 System.out.println("missed qry Betwn Date   "+Todayqry);

		 ResultSet rstoday=st1.executeQuery(Todayqry);
		 while(rstoday.next())
		 {
			 CountToDayNew++;
		 }
		 
		 System.out.println("Missed Foll Cont===>"+countNew);
		 %>
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=CountToDayNew%>','<%=6%>','<%=todaysDate %>','<%=todaysDate %>');"><%=CountToDayNew%></a></td>
		
		<%
		int CountTomorNew=0;
		String Tomorqry="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+tomoDate+"'";
		 System.out.println("missed qry Betwn Date   "+Tomorqry);
		 ResultSet rstom=st1.executeQuery(Tomorqry);
		 while(rstom.next())
		 {
			 CountTomorNew++;
		 }
		 
		 System.out.println("Missed Foll Cont===>"+CountTomorNew);
		 %>
		<td class="text-center"><a href="#" onclick="popUpNew('customerFollowupsecondlevel.jsp','<%=code %>','<%=CountTomorNew%>','<%=7%>','<%=tomoDate %>','<%=tomoDate %>');"><%=CountTomorNew%></a></td>
	<%}
%>
</tr> 				 			
</tbody>
		<%}
		%>
	</table>
	</div>
		<%
} 
catch (Exception e)
{
	e.printStackTrace();
}
%>
<script type="text/javascript">
function popUp(webadd,code1,count1,no)
{
	window.open(webadd+'?Code1='+code1+'&count1='+count1+'&number='+no);
}
function popUpNew(webadd,code1,count1,no,dt1,dt2)
{
	window.open(webadd+'?Code1='+code1+'&count1='+count1+'&number='+no+'&dt1='+dt1+'&dt2='+dt2);
}

function validate()
{
	if(document.marketing.customer.checked){

	var  a=document.marketing.companyNames.value;
	document.marketing.custName.value="a";
	return true;

	}else if(document.marketing.marketingRep.checked)
	{
		document.marketing.custName.value="select";
		return true;
	}else
	{
		alert("Please Select  Checkbox For Report");
		return false;
	}
	
}
function getCompanies(type)
{
	document.getElementById("companyList").style.display='block';
	var company=document.marketing.companyNames.value;

//alert("COMPPPP"+company);

	if(company.length=="")
	{
		document.getElementById('companyList').style.visibility = 'hidden';
		
	}
	else
	{
		document.getElementById("companyList").style.visibility="visible";
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
			document.getElementById("companyList").innerHTML=reslt;
		} 
	}
	var queryString = "?company=" +company+"&type="+type;
	ajaxRequest.open("GET", "ajaxCustomerFollow.jsp" + queryString, true);
	ajaxRequest.send(null); 

	}//end if else
}

function showCompany(companyName,customerCode){

	//document.getElementById("companyNames").value=companyName;
	document.marketing.companyNames.value=companyName;
	document.marketing.custName.value=companyName;
	
	document.marketing.custCode.value=customerCode;
	
	document.getElementById("companyList").style.display='none';
	document.marketing.isCheckedAll.checked=false;
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
		                        title: 'Follow Up Report From '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Follow Up Report From '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Follow Up Report From '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Follow Up Report From '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Follow Up Report From '+$("#data").val()+' to ' +$("#data1").val(),
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