<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="header.jsp"%>
<%@ include file="ConnForIncident.jsp"%>

<%@page import="java.util.concurrent.ExecutionException"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import="java.util.*"  import="java.util.Date" errorPage="" %>

<style>

SPAN.searchword {
	background-color: cyan;
}

SPAN.super {
	text-decoration: blink;
	text-align: center;
}

.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; . popupnew { background-color : #98AFC7;
	position: absolute;
	visibility: visible; . popupx { background-color : #98AFC7;
	position: absolute;
	visibility: hidden;
}

BODY {
	bgcolor="#FFE4E1";
}

</style>



	<script type="text/javascript" >

	function toggleDetails(customer,show,row) 
	{
	//	alert(customer);
	//	alert(show);
	//	alert(row);
		var popupx = document.getElementById("popup"+row);
		//alert(popupx+" +++++    "+row);
		if(show=="true") 
		{
			popupx.style.visibility = "visible";
			popupx.setfocus();
		} 
		else 
		{
			popupx.style.visibility = "hidden";
		}
	}
	

	 
	function popUp(webadd,code1,count1,no)
	{
	//alert("IN POPUP   ");
	window.open(webadd+'?Code1='+code1+'&count1='+count1+'&number='+no);
	}
	
	function popUp1(webadd,code1,count1,no,num)
	{
    //alert("IN POPUP   ");
	window.open(webadd+'?repCode='+code1+'&fromDate='+count1+'&toDate='+no+'&Number='+num);
	}
	
	function popUp2(webadd,code1,code2)
	{
    //alert("IN POPUP   ");
	window.open(webadd+'?repCode='+code1+'&EmpName='+code2);
	}
	
	
	function popupindex(webadd,code,name)
	{
		//alert("in fun");
		
		window.open('IndexMarketingDash.jsp'+'?code='+code+'&name='+name,'jav','width=550,height=530,top=30,left=300,resizable=no');
	}
	function showentryform(customer)
	{
	
		window.open('followupEntryForm.jsp'+'?Company='+customer,'jav','width=450,height=800,top=30,left=300,resizable=no');
	}

	function cancelentryform()
	{
		//document.getElementById("followUpTable").style.visibility="hidden";
	}
  
	function getEmp()
	{
		//alert("m shoaib");
		document.getElementById("EmpList").style.display='block';
		var emp=document.getElementById("EmpNames").value;
//		alert(document.getElementById("EmpNames").value);
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
				{session
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
				document.getElementById("EmpList").innerHTML=reslt;
			} 
		}
		var queryString = "?emp=" +emp;
		//alert(""+queryString);
		ajaxRequest.open("GET", "GenericAjaxSearchME.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}

	function showVisitingCardDetails(eName,empMail)
	{
		document.getElementById("EmpNames").value=eName;
		document.getElementById("SelectedEmpMail").value=empMail;
		//alert(document.getElementById("SelectedEmpMail").value=empMail);
		document.getElementById("EmpList").stysessionle.display='none';
	}

	function validate()
	{
		//alert(")  TEWKLNKH ");100035marketingrepmaster
		//alert(document.addFolloUp.myfile.value);
		//alert("Check for Empty Todate"+document.addFolloUp.todate.value);
		if(document.addfollowup.todate.value=='')
		{
			alert("Please Enter Next Follow-Up Date" );
			return false;
		}
	//	alarg0ert("Check for Comments"+document.addFolloUp.comments.value);
		if(document.addfollowup.comments.value=='')
		{
			alert("Please Entstleave1er Comments" );
			return false;
		}

		var userDate = document.addfollowup.fromdate.value;
		var tdy = document.addfollowup.today.value;
		//alert(tdy);
		var ydy = document.addfollowup.yesterday.value;
		//alert(ydy);
		if(userDate != tdy || useDate != ydy)
		{
			alert("Follow-Up For "+userDate+" Is Not Allowed");
			return false;
		}
		
		return true; 
	}
	function EmailSending()
    {
        //alert("in fun");
        var htmlstring=document.getElementById("mailstring").value;
        //alert(document.getElementById("mailstring").value);
        var mailid=document.getElementById("mail").value;
        //alert(mailid);
         if(mailid=="")
         {
          alert("Please Enter E-Mail Id ;");
          return false;
         }
         
      

       if(mailid!=null && htmlstring!=null)
       {
           //alert("In if");
           
           var subject="Marketing DashBoard Activity Report ";
           var numericExpression = /^[0-9]+$/;
           var at="@";
   		   var dot=".";
   		   var lat=mailid.indexOf(at);
   		   var lstr=mailid.length;
   		   var ldot=mailid.indexOf(dot);
   		 if (mailid.indexOf(at)==-1 && mailid!="")
   	   	 {
   		   alert("Please Enter Valid E-Mail ID");
   		   return false;
   		 }
           var ajaxRequest;  // The variable that makes Ajax possible!
   	      try
   	      {
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

   		// Create a function that will receive data sent from the server
   		ajaxRequest.onreadystatechange = function()
   		{
   			if(ajaxRequest.readyState == 4)
   			{
   				var reslt=ajaxRequest.responseText;
   				//alert(">>>    "+reslt);
   				var data=reslt.split("#");
   				//alert("<*****  "+data);
   				if(data[1].indexOf('Yes')!=-1)
   				{					
   			    	//window.location.reload();
   					alert("Email Send Successfully");
   					document.getElementById("mail").value="";
   				}
   				else
   				{
   					alert("Email Not Send Successfully!!!!!!!!!");
   					document.getElementById("mail").value="";
   				}
              
               
               
   			} 
   		}
   		//var fff="<br><h4 align=center> Performance Of D. M. Raut During '01-Apr-2012' To '14-May-2012' </h4><table><tr><th><b>Particulars</b></th><th><b>Weightage</b></th><th><b>Total</b></th><th><b>Target</b></th><th><b>Weighted Index()</b></th><th><b>Index UptoDate ()</b></th></tr></table>";
   		var queryString = "?htmlstring1="+htmlstring+"&mailid="+mailid+"&subject="+subject;

   		//alert(queryString);
   		
   		ajaxRequest.open("GET", "AjaxMailSending.jsp" +queryString, true);
   		ajaxRequest.send(null); 
           
       }
        
    }
	</script>
	</head>
	<body>
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
//++++++++++++++++++Ashutosh Bhardwaj+++++++++++++++++++++++++++++++++
boolean flag_day = false; 
String edate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String l_day =  edate.substring(edate.lastIndexOf("-")+1).trim();
System.out.println("The Last day   =====================>"+edate+"    Last Day of Month  ==>"+l_day);
	
	Calendar cal1 = Calendar.getInstance();
	cal1.setTime(new Date());
	int d11 = cal1.getActualMaximum(Calendar.DAY_OF_MONTH);	
	
	if(Integer.parseInt(l_day) == d11)
	{
		//For Monthly index
		flag_day = true;
	}			

//System.out.println("The d1 in month ===================>"+d11);
//System.out.println("The flag day   =====================>"+flag_day);
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    Connection conn1 = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,stDATE=null,stMaster=null,stweek=null,stweek1=null,stmark=null,stmark1=null,stmark2=null;
    Statement stmrkt=null,stsql7=null;
    String mailid = (String) session.getAttribute("EmpEmail");
   // System.out.println("----------------------------------"+mailid);
    long SQ=0,SO=0;
    String sqlvis1="";
    try {
		conn1 = erp.ReturnConnection();
		st = conn1.createStatement();
		st2 = conn1.createStatement();
		st1 = conn1.createStatement();
		st3 = conn1.createStatement();
		st4 = conn1.createStatement();
		st5 = conn1.createStatement();
		st6 = conn1.createStatement();
		st7 = conn1.createStatement();
		st8 = conn1.createStatement();
		st9 = conn1.createStatement();
		st10 = conn1.createStatement();
		stDATE=conn1.createStatement();
		stMaster=conn1.createStatement();
		stweek=conn1.createStatement();
		stweek1=conn1.createStatement();
		stmark=conn1.createStatement();
		stmark1=conn1.createStatement();
		stmark2=conn1.createStatement();
		stsql7=conn1.createStatement();
		stmrkt=conn1.createStatement();
		
		} catch (Exception e) {
		
			e.printStackTrace();
		}
	
	Date today = new Date();
	Date tomorrow=new Date();
	
	//Date today = new SimpleDateFormat("yyyy-MM-dd").parse("2013-06-30");
	//Date tomorrow = new SimpleDateFormat("yyyy-MM-dd").parse("2013-06-30");
	
	Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	cal.setTime(today);
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	String todaysDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	
	cal.add(Calendar.DAY_OF_MONTH, -1);
	
	Date YesterdaysDateAsDate = cal.getTime();
	String yesterdaysDate=new SimpleDateFormat("yyyy-MM-dd").format(YesterdaysDateAsDate);
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, +1);
	Date  tomorowAsDate=cal.getTime();
	String tomoDate=new SimpleDateFormat("yyyy-MM-dd").format(tomorowAsDate);
	String tomoDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(tomorowAsDate);
//	System.out.println(tomoDateInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	Date sevendaysbefore=new Date();
	cal.add(Calendar.DAY_OF_MONTH, -7);
	sevendaysbefore=cal.getTime();
	String sevenbefore=new SimpleDateFormat("yyyy-MM-dd").format(sevendaysbefore);
	String sevenbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sevendaysbefore);
//	System.out.println(sevenbeforeInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-30);
	Date MonthAsDate=cal.getTime();
	String monthbefore=new SimpleDateFormat("yyyy-MM-dd").format(MonthAsDate);
	String monthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(MonthAsDate);
//	System.out.println(monthbeforeInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-60);
	Date twoMonthAsDate=cal.getTime();
	String twomonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(twoMonthAsDate);
	String twomonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(twoMonthAsDate);
//	System.out.println(twomonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-90);
	Date threeMonthAsDate=cal.getTime();
	String threemonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(threeMonthAsDate);
	
	System.out.println("3 3 3 3  333333 33 333333   "+threemonthbefore);
	String threemonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(threeMonthAsDate);
	//System.out.println(threemonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-180);
	Date sixMonthAsDate=cal.getTime();
	String sixmonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(sixMonthAsDate);
	String sixmonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sixMonthAsDate);
	//System.out.println(sixmonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	now.setTime(today);
		
	String sqlDate="SELECT DAYOFWEEK('"+todaysDate+"')";
	//System.out.println(sqlDate);
	ResultSet rsDate=stDATE.executeQuery(sqlDate);
	int dayOfWeek=1,weekCount=1;
	rsDate.next();
	dayOfWeek=rsDate.getInt(1);
	
	//System.out.println(">>>>>>>>>>dayOfWeek:"+dayOfWeek);
	if(dayOfWeek==1)
		sqlDate="SELECT DATE_SUB( curdate( ) , INTERVAL 6 DAY )  ";
	else
	{
		weekCount=rsDate.getInt(1)-2;
		sqlDate="SELECT DATE_SUB( curdate( ) , INTERVAL "+weekCount+" DAY ) ";
	}
	//System.out.println(sqlDate);
	rsDate=stDATE.executeQuery(sqlDate);
	rsDate.next();
	
	String MondayOfThisWeek=rsDate.getString(1);
	//System.out.println("+*+*+*+*+*+*+*+*MondayOfThisWeek:   "+MondayOfThisWeek);
	String yesterdaysDateInMMMFromat=new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);
	String usermail="";
	String repr="";
	StringBuffer htmlString = new StringBuffer ("");
	StringBuffer followUpData = new StringBuffer ("");
	String headerstring;
	StringBuffer tempData=new StringBuffer("");
	int k;
	int masterCounter=1;
	String sqlFollowup="",fromDate="",toDate="";		
	Date d=new Date();
	double Grandindex=0,P_Grandindex=0;
	Format df1= new SimpleDateFormat("yyyy-MM-dd");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	
	Format d2= new SimpleDateFormat("HH:mm:ss");
	String incdReg=d2.format(d);
	String hrTime=incdReg.substring(0,2);
	String minTime=incdReg.substring(3,5);
	//System.out.println(">>>>>>>>>>>>dtoday:"+dtoday);
	String fromDateCal = "", toDateCal = "", sql = "",mainCustomer="";
	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new java.util.Date());
	String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	DecimalFormat df2 = new DecimalFormat("0.00");
	double Month_index_total=0,Month_Grandindex=0;
	String Performance="";
	StringBuffer htmlstring= new StringBuffer();
	String Colorcode="";
	boolean flag=false;
	Date abcd=new Date();
	Date month1=new Date();
	Date month2=new Date();
    //int performance=0;
%>
<form name="addfollowup" method="post" action="addFollowupForDashboard.jsp" onsubmit="return validate();">
<input type="hidden" name="Name" id="Name" value="<%=request.getParameter("")%>">
<table align="center">
<tr>
<td align="center"><div  style="font-DB_sessionUSERNAMEsize: 1.5em;"><a><b> DASH BOARD </b> </a></div>
</td>
</tr>
</table>
<%//------------------------Performance report (Month to date)--------------- %>	 	
<%
String todays=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println(">>>>>>>>>>>todays:"+todays);
String SqlMonth="Select MONTH('"+todays+"')";
ResultSet rsMonth=st5.executeQuery(SqlMonth);
rsMonth.next();
String Month=rsMonth.getString(1);
int mm=Integer.parseInt(Month);
if(mm<10)
{
	  Month="0"+""+Month+"";
}
String SqlYear="Select Year('"+todays+"')";
ResultSet rsYear=st4.executeQuery(SqlYear);
rsYear.next();
String Year=rsYear.getString(1);
fromDate=""+Year+"-"+Month+"-01";
//System.out.println(">>>>>>>>>>>fromDate:"+fromDate);
String SqlLastday="Select LAST_DAY('"+fromDate+"')";
ResultSet rsLastday=st1.executeQuery(SqlLastday);
rsLastday.next();
String LastD=rsLastday.getString(1);
//System.out.println(">>>>>>>>>>>LastD:"+LastD);

String SqlDateDiff="Select DATEDIFF('"+LastD+"','"+fromDate+"')";
ResultSet rsDateDiff=st3.executeQuery(SqlDateDiff);
rsDateDiff.next();
int Datediff=rsDateDiff.getInt(1)+1;
//System.out.println(">>>>>>>>>>>Datediff:"+Datediff);

String SqlDateDiff1="Select DATEDIFF('"+todays+"','"+fromDate+"')";
ResultSet rsDate1=st.executeQuery(SqlDateDiff1);
rsDate1.next();
int DateDiffToday=rsDate1.getInt(1)+1;
//System.out.println(">>>>>>>>>>>DateDiffToday:"+DateDiffToday);
     
String abc1="";
int no=0,visitcounter=0,finalvisits=0;

double diff= ((new Date().getTime()) - (new SimpleDateFormat("yyyy-MM-dd").parse(fromDate).getTime())) / (1000 * 60 * 60 * 24)+1;
System.out.println(">>>>>>>>>>>>>>>>>>diff:"+diff);

//fromDate = "2013-06-01";DB_sessionUSERNAME
//todays = "2013-06-30";

System.out.println("The fromdate ====>"+fromDate);
System.out.println("The todays ====>"+todays);

String EmpCode=session.getAttribute("EmpCode").toString();

String EmpName=session.getAttribute("EmpName").toString();

String role1=session.getAttribute("role").toString();
System.out.println("Role Of HOD>>>>>"+role1);

String companyID=session.getAttribute("CompanyMasterID").toString();

    //fromDate="2012-04-01";toDate="2012-04session-13";
    String sqlRep1="select * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a, "+session.getAttribute("CompanyMasterID").toString()+"security b"
    		+" where b.ActiveStatus='YES' and a.MarketingRepCode=b.EmpCode and b.Dept='Marketing' and a.MarketingRepCode='"+session.getAttribute("EmpCode")+"' order by a.MarketingRepName";
ResultSet rsRep1=stMaster.executeQuery(sqlRep1);
System.out.println(sqlRep1);
if(rsRep1.next())
{
      String sqlCount="SELECT    count(*) , 'PhoneCall'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 FollowUpType   "+
"       in('phoneCall','Ph Call') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
"       '"+fromDate+"' and '"+todays+"'			 "+
"        union			 "+
"       SELECT    count(*) , 'Visit'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
"       in('Visit') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
"       '"+fromDate+"' and '"+todays+"'			 "+
"       union			 "+
"       SELECT    count(*) , 'Letter'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
"       in('Letter') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
"       '"+fromDate+"' and '"+todays+"'			 "+
"       union			 "+
"       SELECT count(*) , 'Meeting' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
"       in('Meeting') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
"       '"+fromDate+"' and '"+todays+"'			 "+
"       union			 "+
"       SELECT count(*) , 'Email' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
"       in('E-mail','E mail','Mail','Email') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
"       '"+fromDate+"' and '"+todays+"'			 "+
"       union			 "+
"       SELECT    count(*) , 'NoOfProspects'  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where			 "+
"       CustEnteredByRep ='"+rsRep1.getString("MarketingRepName")+"' and	Assighnedby='"+rsRep1.getString("MarketingRepName")+"'	and			 "+
"       ProspCustAddedOn  >= '"+fromDate+" 00:00:00' and  ProspCustAddedOn <= '"+todays+" 23:59:59' "+
"		 UNION "+
"		 SELECT count(*) ,'NoOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsRep1.getString("MarketingRepName")+"' "+
"		 and SalesOrderDate between '"+fromDate+"' and '"+todays+"' and SOCancelled=0"+
"    		 UNION "+
"		 SELECT count(*) ,'NoOfSQ' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where TWEmpName='"+rsRep1.getString("MarketingRepName")+"' "+
"		 and SalesQuoDate between '"+fromDate+" 00:00:00  	' and '"+todays+" 00:00:00  	' and SalesQuoCancelled=0"+
"		 UNION "+
"		 SELECT SUM(Total) ,'SumOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsRep1.getString("MarketingRepName")+"' "+
"		 and SalesOrderDate between '"+fromDate+"' and '"+todays+"' and SOCancelled=0"+
"		 UNION "+
"		SELECT Sum(Total),'TotalSO' FROM `"+session.getAttribute("CompanyMasterID").toString()+"salesquo_det` WHERE TWEmpName='"+rsRep1.getString("MarketingRepName")+"' and SalesQuoCancelled='0' and SalesQuoDate between '"+fromDate+" 00:00:00' and '"+todays+" 00:00:00'";



     ResultSet rsCount=st2.executeQuery(sqlCount);
	System.out.println(">>>Count Query  "+sqlCount);
	 String phoneCalls1=(rsCount.next()?rsCount.getString(1):"0");
	 String visits1=(rsCount.next()?rsCount.getString(1):"0");
	//System.out.println(">>>visits1:  "+visits1);
	 String letters1=(rsCount.next()?rsCount.getString(1):"0");
	 String meetings1=(rsCount.next()?rsCount.getString(1):"0");
	// System.out.println(">>>meetings1:  "+meetings1);
	 String email1=(rsCount.next()?rsCount.getString(1):"0");
	 String numberOfprospects1=(rsCount.next()?rsCount.getString(1):"0");
	 String numberOfSO1=(rsCount.next()?rsCount.getString(1):"0");
	 //String numberOfSQ1=(rsCount.next()?rsCount.getString(1):"0");
	 String numberOfSQ1=(rsCount.next()?rsCount.getString(1):"0");
	 
	 String sumOfSO1=(rsCount.next()?rsCount.getString(1):"0");
	 rsCount.next();
	// System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	 String quoTotal=rsCount.getString(1);
	 if(quoTotal==null)
	 {
		 quoTotal="0";
	 }	 
	 String sqlvis="select ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType "+
		"       in('Visit') and MarketingRepcode='"+rsRep1.getString("MarketingRepCode")+"' and FollowUpDate  between '"+fromDate+"' and '"+todays+"' ";
	
	// System.out.println(sqlvis);
	 ResultSet rstt=st5.executeQuery(sqlvis);
	// System.out.println(sqlvis);
	 while(rstt.next())
	 {
		 abc1=rstt.getString(1);
		 System.out.println("in while  ");
		 String sql55="select OEM from  "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode='"+abc1+"'";
		 ResultSet rs55=st2.executeQuery(sql55);
	//	 System.out.println(sql55);
		 if(rs55.next())
		 no=rs55.getInt("OEM");
	//	 System.out.println(no);
		 if(no == 0)
		 {
			 visitcounter=1;
		 }
		 else
		 {
			 visitcounter=2;
		 }
		 
		 finalvisits=finalvisits+visitcounter;	 
		 
	 }
	 System.out.println("final visits are "+finalvisits);
	 //out.println(finalvisits);
		
	 //long SQcount1=Long.parseLong(quoTotal);
	 double target_visit = 0.0;
	 //long SQcount1=Long.parseLong(quoTotal);
	 String  SQcount1=quoTotal;
	 System.out.println("SQ cunt is   "+SQcount1);
	 sumOfSO1=(sumOfSO1==null?"0":sumOfSO1);
	 int cnt=0;
	 double Month_indexofvisits=0,month_P_indexofvisits=0;
		try{
			
						if(flag_day == true) 
						{
							target_visit = (double)Math.round(((double)rsRep1.getInt("VisitsTarget")*4));
							
						}else
						{
							
							target_visit = (double)Math.round(((double)rsRep1.getInt("VisitsTarget")/(double)7)*diff);
						}
						 double meetings = Double.parseDouble(meetings1);

						    Month_indexofvisits = ((finalvisits + meetings) / target_visit) * 80;

						    Month_indexofvisits = ((finalvisits + meetings) /
						            Math.round(((double) rsRep1.getInt("VisitsTarget") / 7) * Datediff)) * 80;

						    Month_index_total += Month_indexofvisits;

						    month_P_indexofvisits = ((finalvisits + meetings) / target_visit) * 80;

						    month_P_indexofvisits = ((finalvisits + meetings) /
						            Math.round(((double) rsRep1.getInt("VisitsTarget") / 7) * DateDiffToday)) * 80;

						    Month_Grandindex += month_P_indexofvisits;

						    System.out.println("Month_Grandindex :::::::::::;;; " + Month_Grandindex);
         System.out.println("Month_Grandindex :::::::::::;;;"+Month_Grandindex);
		}catch(Exception e){
			System.out.println("llllllllllllllllll"+e);
			}
		
	//	int sum1=finalvisits+Integer.parseInt(meetings1);
		int sum1 = finalvisits + (int) Double.parseDouble(meetings1);
		double target_prospect = 0.0;
		double Month_indexofnewprospect=0,Month_P_indexofnewprospect=0;
		try{
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			if(flag_day == true) 
			{
				target_prospect = (double)Math.round(((double)rsRep1.getInt("NewProspectTarget")*4));						
			}else
			{						
				target_prospect = (double)Math.round(((double)rsRep1.getInt("NewProspectTarget") / (double)7)*diff);
			}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		/* 	Month_indexofnewprospect=((double)(Integer.parseInt(numberOfprospects1))/target_prospect)*20;
			Month_index_total +=Month_indexofnewprospect;
			Month_P_indexofnewprospect=((double)(Integer.parseInt(numberOfprospects1))/target_prospect)*20;
			Month_Grandindex +=Month_P_indexofnewprospect; */
			
			Month_indexofnewprospect = (Double.parseDouble(numberOfprospects1) / target_prospect) * 20;
			Month_index_total += Month_indexofnewprospect;
			Month_P_indexofnewprospect = (Double.parseDouble(numberOfprospects1) / target_prospect) * 20;
			Month_Grandindex += Month_P_indexofnewprospect;
		}catch(Exception e){
			System.out.println("lllllllllllllllllttttttttttttttttttttt"+e);
		}
	
		int Sumtt = (int)Double.parseDouble(phoneCalls1) + (int)Double.parseDouble(email1);
		System.out.println("The total index issubndnrhhch >>>>>>>:"+Sumtt);
		System.out.println("The total index is >>>>>>>:"+Month_Grandindex);
		if(Month_Grandindex >=75.00)
		{
			%>
			<div  style="font-size: 1.5em;margin-left: 90%"><b>Index:</b><a href="#" onclick="popupindex('IndexMarketingDash.jsp','<%= rsRep1.getString("MarketingRepCode")%>','<%= rsRep1.getString("MarketingRepName")%>');" style="font-color:#008000;"><font color="#008000"><%=df2.format(Month_Grandindex) %></font></a></div>
 <%
		}
		else
		{
			%>
			<div  style="font-size: 1.5em;margin-left: 90%"><b>Index:</b><a href="#" onclick="popupindex('IndexMarketingDash.jsp','<%= rsRep1.getString("MarketingRepCode")%>','<%= rsRep1.getString("MarketingRepName")%>');" style="font-color:#008000;"><font color="#FF0000"><%=df2.format(Month_Grandindex) %></font></a></div>
			<%
		}
	
%> 
<%} %>

<table width="100%" border="0">
<tr>
<td align="left" valign="top" style="width: 30%">
<div align="center" style="font-size: 1.2em;font-family: arial;"><b>Data Sheet</b></div>
<%//************************************MAIN QUERY GIVES EMP NAME*********************************************************************************
String sqlRep="select * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a, "+session.getAttribute("CompanyMasterID").toString()+"security b"
		+" where b.ActiveStatus='YES' and a.MarketingRepCode=b.EmpCode and b.Dept='Marketing' and a.MarketingRepCode='"+session.getAttribute("EmpCode")+"' order by a.MarketingRepName";
ResultSet rsRep=stMaster.executeQuery(sqlRep);
System.out.println("New One :- "+sqlRep);
if(rsRep.next())
{			
			masterCounter=1;
			k=0;
			int sumVisits=0,sumPhoneCalls=0,sumLetters=0,sumSalesQuotation=0,sumNewProspects=0;
			usermail=rsRep.getString("MarketingRepEMail"); 
			String	code=rsRep.getString("MarketingRepCode");
			repr=rsRep.getString("MarketingRepName");
			SQ=rsRep.getLong("QuoteValueMonthlyTarget");
			System.out.println(">>>>>SQ:"+SQ);
			SO=rsRep.getLong("OrderValueMonthlyTarget");
			//System.out.println(repr);
			
//********************************** START FOR TOTAL CUSTOMER COUNT **********************************************************************************
			String sqlCustomers="";
			int CountMain=0;int CountInMonth=0,CountInTwoMonth=0,CountIn60To90=0,CountIn90To180=0,CountGrtr180=0,CountYesterDay=0,CountToDay=0,CountTommorow=0;
			sqlCustomers="Select count(Distinct ProspCustName),1 as CountMain from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  "+
			" UNION "+
			"Select count(Distinct ProspCustName),2 as CountInMonth from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate > '"+monthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),3 as CountInTwoMonth from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+monthbefore+"' AND FollowUpDate > '"+twomonthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),4 as CountIn60To90 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+twomonthbefore+"' AND FollowUpDate > '"+threemonthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),5 as CountIn90To180 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND FollowUpDate < '"+threemonthbefore+"' AND FollowUpDate > '"+sixmonthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),6 as CountGrtr180 from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate < '"+sixmonthbefore+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),7 as CountYesterday from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate = '"+yesterdaysDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),8 as CountToday from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+todaysDate+"' "+
			" UNION "+
			"Select count(Distinct ProspCustName),9 as CountTommorow from "+session.getAttribute("CompanyMasterID").toString()+"followup Where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+tomoDate+"'";
			
			System.out.println(">>>>>> ######### "+sqlCustomers);
			ResultSet rsCust=st1.executeQuery(sqlCustomers);
			
			if(rsCust.next())
			CountMain=rsCust.getInt(1);  //getInt(1) because it's first column 
			//System.out.println(CountMain);
			if(rsCust.next())
			CountInMonth=rsCust.getInt(1);            //getInt(1) because it's first column 
			//System.out.println(CountInMonth);
			if(rsCust.next())
			CountInTwoMonth=rsCust.getInt(1);
			//System.out.println(CountInTwoMonth);
			if(rsCust.next())
			CountIn60To90=rsCust.getInt(1);
			//System.out.println(CountIn60To90);
			if(rsCust.next())
			CountIn90To180=rsCust.getInt(1);
			//System.out.println(CountIn90To180);
			if(rsCust.next())
			CountGrtr180=rsCust.getInt(1);
			//System.out.println(CountGrtr180);
			if(rsCust.next())
			CountYesterDay=rsCust.getInt(1);
			//System.out.println(CountYesterDay);
			if(rsCust.next())
			CountToDay=rsCust.getInt(1);
			//System.out.println(CountToDay);
			if(rsCust.next())
			CountTommorow=rsCust.getInt(1);
			//System.out.println(CountTommorow);
			
			
%>		
       
		<table class="sortable" style="width: 100%;font-size: 8;font-family: arial;margin-top: 0.5em;margin-bottom: 0.5em;" >
		<tr>
		<th>Index</th>
		<th>Title</th>
		<th>Followed</th>
		<th>Not Followed</th>
		
		</tr>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Your Total Customers :</div></td>
		<td><div align="right">
				 <a href="#" onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountMain %>','<%= 1%>');"><%=CountMain %></a>
		</div></td>
		<td><div align="right">NA</div></td>
		</tr>
		<%masterCounter++; %>	
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Customers In Last Month:</div></td>
		<td><div align="right">
			 <a href="#" onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountInMonth %>','<%=2 %>');"><%=CountInMonth %></a>
		</div></td>
		<%

		 int Missedfollowupinlastmonth=0;
		 String missedinlastmonth="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '"+monthbefore+"' AND '"+todaysDate+"'  AND FollowUpType <> 'Assigned'";
		// System.out.println("missed in last month   "+missedinlastmonth);

		 ResultSet rsMissedmonth=st1.executeQuery(missedinlastmonth);
		 while(rsMissedmonth.next())
		 {
			 String followupdate1=rsMissedmonth.getString("NextFollowUpDate");
			// System.out.println("  "+followupdate1);
			 String custcode1=rsMissedmonth.getString("ProspCustCode");
			// System.out.println("  "+custcode1);
			 
			 String lastmonthmissed="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate Between '"+monthbefore+"' AND '"+todaysDate+"' AND ProspCustCode='"+custcode1+"'  AND FollowUpType <> 'Assigned'";
			// System.out.println("  "+lastmonthmissed);
			 ResultSet rsmissedlastmonth=st.executeQuery(lastmonthmissed);
			 if(rsmissedlastmonth.next())
			 {
				 int count=rsmissedlastmonth.getInt(1);
			//	 System.out.println("  "+count);
				 if(count==0)
				 {
					 Missedfollowupinlastmonth +=1;
			//		 System.out.println("  "+Missedfollowupinlastmonth);
				 }
			 }
			 
		 }
		%>
		<td><div align="right"><%=Missedfollowupinlastmonth %></a></div></td>
		</tr>
		<%masterCounter++; %>	
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
        <td><div align="left">Customers In Last 30 To 60 Days:</div></td>
        <td><div align="right">
		  <a href="#" onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountInTwoMonth %>','<%=3 %>');"><%=CountInTwoMonth %></a>
		</div></td>
		<%
		int Missedfollowup30to60=0;
		 String missedin30to60="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '"+twomonthbefore+"' AND '"+monthbefore+"'  AND FollowUpType <> 'Assigned'";
		// System.out.println("missed in last 2 month   "+missedin30to60);

		 ResultSet rsMissed30to60=st1.executeQuery(missedinlastmonth);
		 while(rsMissed30to60.next())
		 {
			 String followupdate2=rsMissed30to60.getString("NextFollowUpDate");
		//	 System.out.println("  "+followupdate2);
			 String custcode2=rsMissed30to60.getString("ProspCustCode");
			// System.out.println("  "+custcode2);
			 
			 String missed30to60="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate Between '"+twomonthbefore+"' AND '"+monthbefore+"' AND ProspCustCode='"+custcode2+"'  AND FollowUpType <> 'Assigned'";
			// System.out.println("  "+missed30to60);
			 ResultSet rsmissedin30to60=st2.executeQuery(missed30to60);
			 if(rsmissedin30to60.next())
			 {
				 int count00=rsmissedin30to60.getInt(1);
			//	 System.out.println("  "+count00);
				 if(count00==0)
				 {
					 Missedfollowup30to60 +=1;
			//		 System.out.println("  "+Missedfollowup30to60);
				 }
			 }
			 
		 }
		%>
			<td><div align="right"><%=Missedfollowup30to60 %></a></div></td>
		</tr>
		<%masterCounter++; %>	
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Customers In Last 60 To 90 Days:</div></td>
		<td><div align="right">
		<a href="#" onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountInTwoMonth %>','<%=4 %>');"><%= CountIn60To90 %></a>
		</div></td>
		
		<%
		int Missedfollowup60to90=0;
		String missedin60to90="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '"+threemonthbefore+"' AND '"+twomonthbefore+"'  AND FollowUpType <> 'Assigned'";
		//System.out.println("missed in last 60 90 month   "+missedin60to90);

		ResultSet rsMissed60to90=st.executeQuery(missedinlastmonth);
		while(rsMissed60to90.next())
		{
			 String followupdate3=rsMissed60to90.getString("NextFollowUpDate");
			// System.out.println("  "+followupdate3);
			 String custcode3=rsMissed60to90.getString("ProspCustCode");
			// System.out.println("  "+custcode3);
			 
			 String missed60to90="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate Between '"+threemonthbefore+"' AND '"+twomonthbefore+"' AND ProspCustCode='"+custcode3+"'  AND FollowUpType <> 'Assigned'";
			// System.out.println("  "+missed60to90);
			 ResultSet rsmissedin60to90=st1.executeQuery(missed60to90);
			 if(rsmissedin60to90.next())
			 {
				 int count2=rsmissedin60to90.getInt(1);
			//	 System.out.println("  "+count2);
				 if(count2==0)
				 {
					 Missedfollowup60to90 +=1;
			//		 System.out.println("  "+Missedfollowup60to90);
				 }
			 }
			 
		}
		%>

		<td><div align="right"><%=Missedfollowup60to90 %></a></div></td>
		</tr>
		<%masterCounter++; %>	
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Customers In Last 90 To 180 Days:</div></td>
		<td><div align="right">
		<a href="#" onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountIn90To180%>','<%=5 %>');"><%=CountIn90To180%></a>
		</div>	</td>
		
		<%
		int Missedfollowup90to180=0;
		String missedin90to180="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '"+sixmonthbefore+"' AND '"+threemonthbefore+"' AND FollowUpType <> 'Assigned' ";
		//System.out.println("missed in last 60 90 month   "+missedin90to180);

		ResultSet rsMissed90to180=st2.executeQuery(missedinlastmonth);
		while(rsMissed90to180.next())
		{
			 String followupdate4=rsMissed90to180.getString("NextFollowUpDate");
		//	 System.out.println("  "+followupdate4);
			 String custcode4=rsMissed90to180.getString("ProspCustCode");
		//	 System.out.println("  "+custcode4);
			 
			 String missed90to180="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate Between '"+sixmonthbefore+"' AND '"+threemonthbefore+"' AND ProspCustCode='"+custcode4+"'  AND FollowUpType <> 'Assigned'";
		//	 System.out.println("  "+missed90to180);
			 ResultSet rsmissedin90to180=st1.executeQuery(missed90to180);
			 if(rsmissedin90to180.next())
			 {
				 int count9=rsmissedin90to180.getInt(1);
		//		 System.out.println("  "+count9);
				 if(count9==0)
				 {
					 Missedfollowup90to180 +=1;
		//			 System.out.println("  "+Missedfollowup90to180);
				 }
			 }
			 
		}
		%>
		
		
		<td><div align="right"><%= Missedfollowup90to180%></a></div></td>
		</tr>
		<%masterCounter++;%>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Customers > 180 Days:</div></td>
		<td><div align="right">
		 <a href="#"  onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=CountGrtr180 %>','<%=6 %>');"><%=CountGrtr180 %></a>
		</div></td>
		
		<%
		int Missedfollowupgrtr180=0;
		String missedin180="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate < '"+sixmonthbefore+"' AND FollowUpType <> 'Assigned' ";
	//	System.out.println("missed in last 60 90 month   "+missedin180);

		ResultSet rsMissed180=st2.executeQuery(missedinlastmonth);
		while(rsMissed180.next())
		{
			 String followupdate5=rsMissed180.getString("NextFollowUpDate");
	//		 System.out.println("  "+followupdate5);
			 String custcode5=rsMissed180.getString("ProspCustCode");
	//		 System.out.println("  "+custcode5);
			 
			 String missed180="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate < '"+sixmonthbefore+"'  AND ProspCustCode='"+custcode5+"'  AND FollowUpType <> 'Assigned'";
		//	 System.out.println("  "+missed180);
			 ResultSet rsmissedin180=st1.executeQuery(missed180);
			 if(rsmissedin180.next())
			 {
				 int count8=rsmissedin180.getInt(1);
		//		 System.out.println("  "+count8);
				 if(count8==0)
				 {
					 Missedfollowupgrtr180 +=1;
		//			 System.out.println("  "+Missedfollowupgrtr180);
				 }
			 }
			 
		}
		%>
		
		<td><div align="right"><div align="right">
		 <%=Missedfollowupgrtr180 %></div></div></td>
		</tr>
		<%masterCounter++; %>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Missed Contact last 7 days:</div></td>
		<%
		String lastweekDate1="",lastweekDate2="";
	    String lastweek="SELECT DATE_SUB( curdate( ) , INTERVAL 7 DAY )";	
		ResultSet rsweek=stweek.executeQuery(lastweek);
		if(rsweek.next())
		{
			 lastweekDate1=rsweek.getString(1);
		//	 System.out.println(">>>>>>>>>>lastweekDate1:"+lastweekDate1);
		}
		String lastweek1="SELECT DATE_SUB( curdate( ) , INTERVAL 1 DAY )";	
		ResultSet rsweek1=stweek1.executeQuery(lastweek1);
		if(rsweek1.next())
		{
			 lastweekDate2=rsweek1.getString(1);
	//		 System.out.println(">>>>>>>>>>lastweekDate2:"+lastweekDate2);
		}
		int MissedCount=0;
		String missed="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '"+lastweekDate1+"' AND '"+lastweekDate2+"'  AND FollowUpType <> 'Assigned'";
	//	System.out.println(">>>>>>>>>>missed:"+missed);

		 ResultSet rsMissed=st.executeQuery(missed);
		 while(rsMissed.next())
		 {
			 String followupdate=rsMissed.getString("NextFollowUpDate");
		//	 System.out.println(">>>>>>>>>>followupdate:"+followupdate);
			 String custcode=rsMissed.getString("ProspCustCode");
		//	 System.out.println(">>>>>>>>>>custcode:"+custcode);
			 
			 String missed1="SELECT count(*) FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND FollowUpDate Between '"+lastweekDate1+"' AND '"+lastweekDate2+"' AND ProspCustCode='"+custcode+"'  AND FollowUpType <> 'Assigned'";
		//	 System.out.println(">>>>>>>>>>missed1:"+missed1);
			 ResultSet rsmissed1=st1.executeQuery(missed1);
			 if(rsmissed1.next())
			 {
				 int coun=rsmissed1.getInt(1);
		//		 System.out.println(">>>>>>>>>>coun:"+coun);
				 if(coun==0)
				 {
					 MissedCount +=1;
			//		 System.out.println(">>>>>>>>>>MissedCount:"+MissedCount);
				 }
			 }
			 
		 }
		%>
		<td><div align="right">
		  <a href="#"  onclick="popUp('DashBoardDetails.jsp','<%=code %>','<%=MissedCount %>','<%=7 %>');"><%=MissedCount %></a>
		</div></td>
		<td><div align="right">NA</div></td>
		</tr>
		<%masterCounter++;
		  String currentdate="select CURDATE()";
		  String ydate="SELECT DATE_SUB( curdate( ) , INTERVAL 1 DAY ) as yest";
		  String ydate1="";
		  ResultSet RS2=st6.executeQuery(ydate);
		  while(RS2.next())
		  {
			  ydate1=RS2.getString("yest");
		  }
		  
		  String num="8";
		  %>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Yesterday's Follow Up Report:</div></td>
		<td><div align="right">
		 
		 <a href="#"  onclick="popUp1('marketingDetReport.jsp','<%=EmpCode %>','<%=ydate1 %>','<%=ydate1 %>','<%=num %>');"><%=CountYesterDay %></a>
		</div></td>
		<td><div align="right">NA</div></td>
		</tr>
		<%masterCounter++;
		  String todaydate="select curdate() as tday";
		  String todaydate1="";
		  ResultSet RS8=st7.executeQuery(todaydate);
		  while(RS8.next())
		  {
			  todaydate1=RS8.getString("tday");
		  }
		  String num1="9";
		  %>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Follow Up Scheduled Today:</div></td>
		<td><div align="right">
		 <a href="#"  onclick="popUp1('marketingDetReport.jsp','<%=EmpCode %>','<%=todaydate1%>','<%=todaydate1 %>','<%=num1%>');"><%=CountToDay %></a>
		</div></td>
		<td><div align="right">NA</div></td>
		</tr>
		<%masterCounter++;
		  String tomorrowdate="select DATE_ADD(CURDATE() ,Interval 1 Day) as trday";
		  String tomorrowdate1="";
		  ResultSet RS4=st6.executeQuery(tomorrowdate);
		  while(RS4.next())
		  {
			  tomorrowdate1=RS4.getString("trday");
		  }
		  String num2="10";
		  %>
		<tr>
		<td><div align="right"><%=masterCounter %></div></td>
		<td><div align="left">Follow Up Scheduled TOMORROW:</div></td>
		<td><div align="right">
		 <a href="#"  onclick="popUp1('marketingDetReport.jsp','<%=EmpCode %>','<%=tomorrowdate1 %>','<%=tomorrowdate1 %>','<%=num2 %>');"><%=CountTommorow %></a>
		</div></td>
		<td><div align="right">NA</div></td>
		</tr>	
		
		</table>
		
		</td>
    			
    	<td style="margin-left: 50px;" align="center" valign="top" style="width: 50%"> 
    
       	
    	<!--   *************************************************   start of new table ***************************************************** -->
    	<table>
    	<tr>
    	
    	
    	
    	<td>
    	
    	<div align="center" style="font-size: 1.2em;font-family: arial;"><a> <b>Missed Contacts</b> </a></div>
    	
    	
    	<table class="sortable">
    	 
    	 <tr>
    	 <th>Sr No</th>
    	 <th>Customer </th>	
	     <th>Contact Person</th>			
		 <th>Phone</th>
       	 <th>Schedule Followup date</th>
    	 </tr>	
    	<% 
    	int misscountall=1;
    	int MissedCount1=0;
        String nextdate="";
    	String missedall="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between '2012-01-01' AND '"+lastweekDate1+"'  AND FollowUpType <> 'Assigned'";
		ResultSet rsMissedall=st2.executeQuery(missedall);
		System.out.println("new query  "+missedall);
		while(rsMissedall.next())
		{
			 String followupdate1=rsMissedall.getString("NextFollowUpDate");
		//	 System.out.println(">>>>>>>>>>followupdate:"+followupdate1);
			 String custcode1=rsMissedall.getString("ProspCustCode");
		//	 System.out.println(">>>>>>>>>>custcode:"+custcode1);
			 
			 String missed1="SELECT FollowUpDate FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"'  AND FollowUpDate Between '2012-01-01' AND '"+lastweekDate1+"'  AND ProspCustCode='"+custcode1+"'  AND FollowUpType <> 'Assigned'";
			 ResultSet rsmissed1=st1.executeQuery(missed1);
		//	 System.out.println("ALl  "+missed1);
			 if(rsmissed1.next())
			 {
				 nextdate=rsmissed1.getString(1);

				 
				abcd=new SimpleDateFormat("yyyy-MM-dd").parse(nextdate);
					 MissedCount1 +=1;
					month2= new SimpleDateFormat("yyyy-MM-dd").parse(monthbefore);
					 month1=new SimpleDateFormat("yyyy-MM-dd").parse(sevenbefore);
					 
			 }
			 else
			 {
			//	 System.out.println("in else ");
					String abc="select CompanyName,ContactPerson,Phone from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where  CustomerCode ='"+custcode1+"'";
					ResultSet rsabc=st.executeQuery(abc);
					//System.out.println(abc);
					while(rsabc.next())
					{
						
		%>
		<%if(abcd.before(month1) && abcd.after(month2) ){ %>
		<tr>
    	<td style="background-color: #F7FE2E;"><div align="right"><%=misscountall %></div></td>
    	<td style="background-color: #F7FE2E;"><div align="left"><a href="#"  onclick=""><a href="javascript:toggleDetails('<%= rsabc.getString("CompanyName")%>','true','<%=misscountall %>')" /><%= rsabc.getString("CompanyName")%></div>
    	
    		<div align="right" class="popup" id="popup<%=misscountall %>">
			    <table width="70%" align="right" border="1"   cellpadding="0" cellspacing="0" style="position: absolute;">
				    <tr><td><div align="center"><a href="javascript:showentryform('<%=rsabc.getString("CompanyName")%>')"/>Enter Followup</a></div></td></tr>
				    <tr><td><div align="center"><a href="customerDetails.jsp?companyName=<%=rsabc.getString("CompanyName")%>"/>Show Details</a></div></td></tr>
				   <tr><td><div align="center"><a href="javascript:toggleDetails('<%=rsabc.getString("CompanyName")%>','false','<%=misscountall%>')" />close</a></div></td></tr>
				</table>
				</div>
    	
    	</td>
    	<td style="background-color: #F7FE2E;"><div align="left"><%= rsabc.getString("ContactPerson")%></div></td>
    	<td style="background-color: #F7FE2E;"><div align="right"><%= rsabc.getString("Phone")%></div></td>
    	<%if(nextdate=="0000-00-00" || nextdate=="" )
    	{
    	
    	%>
    	<td style="background-color: #F7FE2E;"><div align="right">NA</div></td>
		<%
    	}
    	else
    	{
    		
%>
    		<td style="background-color: #F7FE2E;"><div align="right"><%= new SimpleDateFormat(
    		"dd-MMM-yyyy")
    		.format(new SimpleDateFormat(
    				"yyyy-MM-dd")
    				.parse(nextdate)) %></div></td>
    	
    			<% }%>
    	</tr>
    	<%}
		else
		{
		%>
				<tr >
    	<td style="background-color: #F3E2A9"><div align="right"><%=misscountall %></div></td>
    	<td style="background-color: #F3E2A9"><div align="left"><a href="#"  onclick=""><a href="javascript:toggleDetails('<%= rsabc.getString("CompanyName")%>','true','<%=misscountall %>')" /><%= rsabc.getString("CompanyName")%></div>
    	
    		<div align="right" class="popup" id="popup<%=misscountall %>">
			    <table width="70%" align="right" border="1"   cellpadding="0" cellspacing="0" style="position: absolute;">
				    <tr><td><div align="center"><a href="javascript:showentryform('<%=rsabc.getString("CompanyName")%>')"/>Enter Followup</a></div></td></tr>
				    <tr><td><div align="center"><a href="customerDetails.jsp?companyName=<%=rsabc.getString("CompanyName")%>"/>Show Details</a></div></td></tr>
				   <tr><td><div align="center"><a href="javascript:toggleDetails('<%=rsabc.getString("CompanyName")%>','false','<%=misscountall%>')" />close</a></div></td></tr>
				</table>select distinct(salescustomercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo = '"+mktcode+"' order by CompanyName
				</div>
    	
    	</td>
    	<td style="background-color: #F3E2A9"><div align="left"><%= rsabc.getString("ContactPerson")%></div></td>
    	<td style="background-color: #F3E2A9"><div align="right"><%= rsabc.getString("Phone")%></div></td>
    	<%if(nextdate=="0000-00-00" || nextdate=="" )
    	{
    	
    	%>
    	<td style="background-color: #F3E2A9"><div align="right">NA</div></td>
		<%
    	}
    	else
    	{
    		
%>
    		<td style="background-color: #F3E2A9"> <div align="right"><%= new SimpleDateFormat(
    		"dd-MMM-yyyy")
    		.format(new SimpleDateFormat(
    				"yyyy-MM-dd")
    				.parse(nextdate)) %></div></td>
    	
    			<% }%>
    	</tr>
		<%
		}%>
		
		<%
					
				 }
					misscountall++;
			 }
			//System.out.println("OUT OUT ");
	 }

	 if(misscountall==1) 
	 {
		%>
		<tr><td colspan="5"><b>No Miss Contact Data Available </b></td></tr>
		<%
	 }

	 %>
		
		
    		
    	</table>
    	</td>
    	</tr>
    	</table>
    	
    	<br></br>
    	
    	<!-- ******************************************************** end of new table  ********************************************************* -->
    	
    	
    	<table border="0">
    	<tr>
    	<td>
    	<%
    	try{
			String sqlFollowuptoday="",Customer=""; 
			//sqlFollowuptoday="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup  WHERE MarketingRepcode='"+code+"' AND NextFollowUpDate = '"+todaysDate+"' ";  //'2012-01-18' ";****earlier
			//sqlFollowuptoday= "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' AND NextFollowUpDate Between (select curdate()) AND (SELECT DATE_SUB( curdate( ) , INTERVAL 30 DAY )) and FollowUpType <> 'Assigned'";
			// sqlFollowuptoday="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' and NextFollowUpDate Between (SELECT DATE_SUB( curdate( ) , INTERVAL 30 DAY )) AND (select curdate()) and FollowUpType <> 'Assigned'";
			 sqlFollowuptoday="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepcode = '"+code+"' and NextFollowUpDate Between (SELECT DATE_SUB( curdate( ) , INTERVAL 30 DAY )) AND (select curdate())";
			ResultSet rsFollowuptoday=st1.executeQuery(sqlFollowuptoday);
			int abc=1;
			System.out.println("qry========================================>"+sqlFollowuptoday);
			if(rsFollowuptoday.next())
			{
				
				//System.out.println("qry============");
				
		  %>	
				
				<div align="center" style="font-size: 1.2em;font-family: arial;"><a><b>Last 30 Days Task</b></a></div>
				<table border=1 class='sortable'  style="width:60%;font-size: 8;font-family: arial;"> 
				<tr>
				<th>Sr No</th>
				<th>Customer </th>	
				<th>Contact Person</th>			
				<th>Phone</th>
				<th>Email</th>										
				<th>Mobile</th>
				<th>City</th>
				<th>Follow up Type</th>
				
				</tr>
				<% 	
				do
				{
					
					Customer=rsFollowuptoday.getString("ProspCustName");
					String phone="",email="",mobile="";
					String sqldata1="Select Phone,EMail,MobileNo from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+Customer+"' ";
					ResultSet rsdata1=st.executeQuery(sqldata1);
					//System.out.println(""+sqldata1);
					if(rsdata1.next())
					{
						 phone=rsdata1.getString("Phone");	 
						 email=rsdata1.getString("EMail"); 
						 mobile=rsdata1.getString("MobileNo");
					}
					//System.out.println(phone+" "+email+" "+mobile);
				%>
				<tr>
				<td align=left><div align="right"><%=abc++%> </div></td> 
				<td align=left><div align="left"><a href="#"  onclick="showentryform('<%=Customer%>');"><%=Customer%></a></div></td> 
				<td align=left><div align="left"><%=rsFollowuptoday.getString("ContactPerson") %></div></td>
				<td align=left><div align="right"><%=phone%></div></td> 
				<td align=left><div align="left"><%=email%></div></td> 
				<td align=left><div align="right"><%=mobile%></div></td> 
				<td align=left><div align="left"><%=rsFollowuptoday.getString("City") %></div></td> 
				<td align=left><div align="left"><%=rsFollowuptoday.getString("FollowUpType") %></div></td> 
				</tr>
				
				<%
					
			//	System.out.println("value of i "+abc);
				}
				while(rsFollowuptoday.next());
				%>
				</table>
				<%
				}
				else 
				{
					System.out.println("sachin kapre ");
					%>
			<div align="center" style="font-size: 1.2em;font-family: arial;"><b>No Task For Today </b></div>
			<% 
			}
    	}catch(Exception e)
    	{e.printStackTrace();}
			//System.out.println("sachin kapre 22222");
			masterCounter++;
// ************************************************ END OF today's FOLLOWUP ******************************************************
%>
		</td>
		</tr>

    	</table>
    	</td>
    	<%
    	System.out.println("sachin kapre 33333 ");
    	String EmpId="";
    	String EmpNm=session.getAttribute("EmpName").toString().trim();
    	System.out.println("------------*************----------------"+EmpNm);
    	int attendancecount=0;
    	Statement stleave=conn.createStatement();
    	Statement stleave1=conn.createStatement();
    	//System.out.println("sachin kapre 4444444");
    	 String SqlEmpId="Select * from db_leaveapplication.t_leaveadmin where Name='"+EmpNm+"'";
    	// System.out.println("------------*************----------------"+SqlEmpId);
    	ResultSet rsemp=st6.executeQuery(SqlEmpId);
    	System.out.println(" "+SqlEmpId);
    	
    	while(rsemp.next())
    	{
    		EmpId=rsemp.getString("EmpID");
    		//EmpId="252";
    		System.out.println(">>>>>>>EmpId:"+EmpId);
    		
    		 String SqlAttendance="select count(distinct a.CheckinType) from  db_leaveapplication.t_checkinout a inner join( select * from  db_leaveapplication.t_leaveadmin where EmpID='"+EmpId+"') b on(b.EmpID = a.EmpID) where checkDate>='"+fromDate+"' and checkDate<='"+todays+"' and a.CheckinType='IN' group by a.checkDate, a.EmpID";
        	System.out.println(">>>>>>>SqlAttendance:"+SqlAttendance);
            ResultSet rsattendance=st7.executeQuery(SqlAttendance);
            System.out.println(">>>>>>>SqlAttendance1111123333:"+SqlAttendance);
            while(rsattendance.next())
            {
            	attendancecount=attendancecount+rsattendance.getInt(1);
            	//System.out.println(">>>>>>>attendancecount:"+attendancecount);
            } 
 
 		     	System.out.println("last last ");
    	%>
    	<td valign="top" style="width: 20%">
    	<div align="center" style="font-size: 1.2em;font-family: arial;color: white;">Go To</div>
    	<table border=1 class='sortable'  style="width:100%;font-size: 8;font-family: arial;">
    	<tr>
    	<td><b>Attendance Till Today:</b></td><td><b><%= attendancecount%></b></td>
    	</tr>
    	<tr>
    	<td><b>Sales Target Monthly:</b></td><td><b><%= rsRep.getLong("OrderValueMonthlyTarget")%></b></td>
    	</tr>
    	<tr>
    	<td><b>Leave Balance:</b></td><td><a href="#">Under Construction</a></td></tr>
    	<tr>
    	<%-- <td><b>Apply Leave</b></td><td><a href="#" onclick="javascript:window.open('http://www.myfleetview.com/Transworld/loginChk.jsp?username=<%=rsemp.getString("UName") %>&pass=<%=rsemp.getString("pass") %>')">Click Here</a></td></tr> --%>
    	<tr>
    	<td><b>New Claim:</b></td><td><a href="#" onclick="javascript:window.open('NewClaim.jsp?id=-')">Claim</a></td></tr>
    	</table>
    	</td>	
    	<%} %>
    	</tr>
    	<%
    	  String sqlCount="SELECT    count(*) , 'PhoneCall'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 FollowUpType   "+
    	  "       in('phoneCall','Ph Call') and MarketingRepcode='"+rsRep.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
    	  "       '"+fromDate+"' and '"+todays+"'			 "+
    	  "        union			 "+
    	  "       SELECT    count(*) , 'Visit'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
    	  "       in('Visit') and MarketingRepcode='"+rsRep.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
    	  "       '"+fromDate+"' and '"+todays+"'			 "+
    	  "       union			 "+
    	  "       SELECT    count(*) , 'Letter'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
    	  "       in('Letter') and MarketingRepcode='"+rsRep.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
    	  "       '"+fromDate+"' and '"+todays+"'			 "+
    	  "       union			 "+
    	  "       SELECT count(*) , 'Meeting' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
    	  "       in('Meeting') and MarketingRepcode='"+rsRep.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
    	  "       '"+fromDate+"' and '"+todays+"'			 "+
    	  "       union			 "+
    	  "       SELECT count(*) , 'Email' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
    	  "       in('E-mail','E mail','Mail','Email') and MarketingRepcode='"+rsRep.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
    	  "       '"+fromDate+"' and '"+todays+"'			 "+
    	  "       union			 "+
    	  "       SELECT    count(*) , 'NoOfProspects'  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where			 "+
    	  "       CustEnteredByRep ='"+rsRep.getString("MarketingRepName")+"' and	Assighnedby='"+rsRep.getString("MarketingRepName")+"'	and	 "+
    	  "       ProspCustAddedOn  >= '"+fromDate+" 00:00:00' and  ProspCustAddedOn <= '"+todays+" 23:59:59' "+
    	  "		 UNION "+
    	  "		 SELECT count(*) ,'NoOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsRep.getString("MarketingRepName")+"' "+
    	  "		 and SalesOrderDate between '"+fromDate+"' and '"+todays+"' and SOCancelled=0"+
    	  "    		 UNION "+
    	  "		 SELECT count(*) ,'NoOfSQ' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where TWEmpName='"+rsRep.getString("MarketingRepName")+"' "+
    	  "		 and SalesQuoDate between '"+fromDate+" 00:00:00  	' and '"+todays+" 00:00:00  	' and SalesQuoCancelled=0"+
    	  "		 UNION "+
    	  "		 SELECT SUM(Total) ,'SumOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsRep.getString("MarketingRepName")+"' "+
    	  "		 and SalesOrderDate between '"+fromDate+"' and '"+todays+"' and SOCancelled=0"+
    	  "		 UNION "+
    	  "		SELECT Sum(Total),'TotalSO' FROM `"+session.getAttribute("CompanyMasterID").toString()+"salesquo_det` WHERE TWEmpName='"+rsRep.getString("MarketingRepName")+"' and SalesQuoCancelled='0' and SalesQuoDate between '"+fromDate+" 00:00:00' and '"+todays+" 00:00:00'";



    	       ResultSet rsCount=st2.executeQuery(sqlCount);
    	  	// System.out.println(">>>  "+sqlCount);
    	  	 String phoneCalls1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 String visits1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 //System.out.println(">>>visits1:  "+visits1);
    	  	 String letters1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 String meetings1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 //System.out.println(">>>meetings1:  "+meetings1);
    	  	 String email1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 String numberOfprospects1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 String numberOfSO1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 //String numberOfSQ1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 String numberOfSQ1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 
    	  	 String sumOfSO1=(rsCount.next()?rsCount.getString(1):"0");
    	  	 rsCount.next();
    	  	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    	  	 String quoTotal=rsCount.getString(1);
    	  	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>Count"+quoTotal);
    	  	 
    	  	 if(quoTotal==null)
    	  	 {
    	  		 quoTotal="0";
    	  	 }
    	  	// System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>"+quoTotal);
    	  	 //long SQcount1=Long.parseLong(quoTotal);
    	  	 
    	  	 
    	  	 System.out.println("here here");
    	  	 /*   start  of  new logic for visit count   */
    	  	 
    	  	String abc11=""; 
    	  	 int no1=0,countervisit=0,visitsfinal=0;
    	  	System.out.println("there there");
    	  // System.out.println(rsRep1.getString("MarketingRepCode"));
    		System.out.println("there22 there22");
    	   System.out.println(fromDate);
    		System.out.println("there33 there33");
    	   System.out.println(todays);
    		System.out.println("there44 there44");
     	   try{
        	  	sqlvis1="select ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType in('Visit') and MarketingRepcode='"+code+"' and FollowUpDate  between '"+fromDate+"' and '"+todays+"' ";
   	 		System.out.println("attt  last "+sqlvis1);
   	 		ResultSet rstt1=st4.executeQuery(sqlvis1);
        	   
   	 System.out.println(sqlvis1);
   	 while(rstt1.next())
   	 {
   		 abc11=rstt1.getString(1);
   		 System.out.println("in while  ");
   		 String sqlnew="select OEM from  "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode='"+abc11+"'";
   		 ResultSet rsnew=st3.executeQuery(sqlnew);
   		 System.out.println(sqlnew);
   		 if(rsnew.next())
   		 no1=rsnew.getInt("OEM");
   		 System.out.println(no1);
   		 if(no1 == 0)
   		 {
   			 countervisit=1;
   		 }
   		 else
   		 {
   			countervisit=2;
   		 }
   		 
   		/* if(no1 > 0 && no1 < 100)
   		 {
   			 countervisit=1;
   		 }
   		 
   		 if(no > 100 && no < 300)
   		 {
   			 visitcounter=2;
   		 }
   		 
   		 if(no1 > 300 && no1 < 500)
   		 {
   			 countervisit=3;
   		 }
   		 
   		 if(no1 > 500 )
   		 {
   			 countervisit=4;
   		 }*/
   		 
   		 visitsfinal=visitsfinal+countervisit;	 
   		 
   	 }
   	// System.out.println("final visits are  at the end   "+visitsfinal);
       	  	 
       	  	 /*   end of new logic for visit count */
       	  	 
       	   }catch(Exception e)
       	   {e.printStackTrace();} 
    	  	 
    	  	 
    	  	 //long SQcount1=Long.parseLong(quoTotal);
    	  	// String SQcount1=""+quoTotal;
    	  double 	SQcount1=Double.parseDouble(quoTotal);
    	 	 System.out.println("SQ cunt is   "+SQcount1);
    	  	 sumOfSO1=(sumOfSO1==null?"0":sumOfSO1);
    	  	 int cnt=0;
    	  	 double Month_indexofvisits=0,month_P_indexofvisits=0;
    	  		try{
    	  			Month_indexofvisits = (Double.parseDouble(meetings1) /
    	  			        Math.round(((double) rsRep.getInt("VisitsTarget") / 7) * Datediff)) * 35;

    	  			Month_index_total += Month_indexofvisits;

    	  			month_P_indexofvisits = (Double.parseDouble(meetings1) /
    	  			        Math.round(((double) rsRep.getInt("VisitsTarget") / 7) * DateDiffToday)) * 35;

    	  			Month_Grandindex += month_P_indexofvisits;
    	           
    	  		}catch(Exception e){System.out.println(e);}
    	  	//	int sum1=visitsfinal+Integer.parseInt(meetings1);
    	  		int sum1 = finalvisits + (int) Double.parseDouble(meetings1);
    	  		double Month_indexofsalesquo=0,Month_P_indexofsalesquo=0, TotalTarget=0;
    	  		try{
    	  			Month_indexofsalesquo=((double)((SQcount1))/(double)Math.round(((double)rsRep.getInt("QuoteValueMonthlyTarget")/(double)7)*Datediff))*35;
    	  			TotalTarget=rsRep.getDouble("QuoteValueWeeklyTarget")*4;
    	  			Month_index_total +=Month_indexofsalesquo;
    	  			Month_Grandindex +=Month_P_indexofsalesquo;
    	  			
    	  		}catch(Exception e){System.out.println(e);}
    	  		double Month_indexofnewprospect=0,Month_P_indexofnewprospect=0;
    	  		try{

    	  		    double prospects = Double.parseDouble(numberOfprospects1);

    	  		    Month_indexofnewprospect =
    	  		        (prospects /
    	  		        Math.round(((double) rsRep.getInt("NewProspectTarget") / 7) * Datediff)) * 20;

    	  		    Month_index_total += Month_indexofnewprospect;

    	  		    Month_P_indexofnewprospect =
    	  		        (prospects /
    	  		        Math.round(((double) rsRep.getInt("NewProspectTarget") / 7) * DateDiffToday)) * 20;

    	  		    Month_Grandindex += Month_P_indexofnewprospect;

    	  		}catch(Exception e){
    	  		    System.out.println(e);
    	  		}
    	  		double Month_indexofphonecalls=0,Month_P_indexofphonecalls=0;
    	  		try{

    	  		    double phone = Double.parseDouble(phoneCalls1);
    	  		    double email = Double.parseDouble(email1);

    	  		    Month_indexofphonecalls =
    	  		        ((phone + email) /
    	  		        Math.round(((double)(rsRep.getInt("CallsTarget")+rsRep.getInt("LettersTarget"))/7) * Datediff)) * 10;

    	  		    Month_index_total += Month_indexofphonecalls;

    	  		    Month_P_indexofphonecalls =
    	  		        ((phone + email) /
    	  		        Math.round(((double)(rsRep.getInt("CallsTarget")+rsRep.getInt("LettersTarget"))/7) * DateDiffToday)) * 10;

    	  		    Month_Grandindex += Month_P_indexofphonecalls;

    	  		}catch(Exception e){
    	  		    System.out.println(e);
    	  		}
    	
    	%>
    	<tr>
    	<td style="width: 30%">
    	<div align="center" style="font-size: 1.2em;font-family: arial;"><b>Short Fall</b></div>
    	<table border=1 class='sortable'  style="width:100%;font-size: 8;font-family: arial;">
    	<tr>
    	<th>Title</th>
    	<th>Customer Cotact</th>
    	<th>Visits</th>
    	<th>Sales Quotation</th>
    	<th>New Prospect</th>
    	</tr>
    	<tr>
    	<%
double phone = (phoneCalls1 != null && !phoneCalls1.isEmpty()) ? Double.parseDouble(phoneCalls1) : 0;
double email = (email1 != null && !email1.isEmpty()) ? Double.parseDouble(email1) : 0;
double visits = (visits1 != null && !visits1.isEmpty()) ? Double.parseDouble(visits1) : 0;
double meetings = (meetings1 != null && !meetings1.isEmpty()) ? Double.parseDouble(meetings1) : 0;
double prospects = (numberOfprospects1 != null && !numberOfprospects1.isEmpty()) ? Double.parseDouble(numberOfprospects1) : 0;
%>

<td><div align="left"><b>Total</b></div></td>
<td><div align="right"><%=(int)(phone+email)%></div></td>
<td><div align="right"><%=(int)(visits+meetings)%></div></td>
<td><div align="right"><%=SQcount1%></div></td>
<td><div align="right"><%=(int)prospects%></div></td>
    	</tr>
    	<tr>
    	<td><div align="left"><b>Target</b></div></td>
    	<td><div align="right"><%=(rsRep.getInt("CallsTarget")+rsRep.getInt("LettersTarget"))*4 %></div></td>
    	<td><div align="right"><%=rsRep.getInt("VisitsTarget")*4 %></div></td>
    	<td><div align="right"><%=rsRep.getInt("QuoteValueWeeklyTarget")*4 %></div></td>
    	<td><div align="right"><%=rsRep.getInt("NewProspectTarget")*4 %></div></td>
    	</tr>
    	<tr>
    	<td><div align="left"><b>ShortFall</b></div></td>

<td>
<div align="right">
<%=((rsRep.getInt("CallsTarget")+rsRep.getInt("LettersTarget"))*4)
   - ((int)Double.parseDouble(phoneCalls1) + (int)Double.parseDouble(email1))%>
</div>
</td>

<td>
<div align="right">
<%=(rsRep.getInt("VisitsTarget")*4)
   - ((int)Double.parseDouble(visits1) + (int)Double.parseDouble(meetings1))%>
</div>
</td>

<td>
<div align="right">
<%=(rsRep.getInt("QuoteValueWeeklyTarget")*4) - SQcount1 %>
</div>
</td>

<td>
<div align="right">
<%=(rsRep.getInt("NewProspectTarget")*4)
   - (int)Double.parseDouble(numberOfprospects1)%>
</div>
</td>
    	</tr>
    	</table>
    	</td>
    	<td style="width: 50%">
    	
    	
    	</td>
    	<td style="width: 20%"></td>
    	</tr>
    	<%
    	String sql3="select (select CURDATE()) as CURDATE,(select DATE_SUB( ((select DATE_SUB((SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY)) ,INTERVAL 30 DAY))),INTERVAL 30 Day)) as 3Month, (select DATE_SUB((SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY)) ,INTERVAL 30 DAY)) as 2Month,(SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY)) as 1Month";
        ResultSet RS1=stmark1.executeQuery(sql3);
        String b_date="";
        String c_date="";
        String d_date="";
        String a_date="";
        String mktcode="";
        String mktRepName="";
        
        while(RS1.next())
        {    a_date=RS1.getString("CURDATE");
        	 b_date=RS1.getString("1Month");
        	 c_date=RS1.getString("2Month");
        	 d_date=RS1.getString("3Month");
        }
        
        String DashBord="DashBoard";
        
    	//String sql2="select (select  sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet  where TWEmpName like '%"+EmpName+"%' order by CompanyName) and InvoiceDate>='2018-01-01' and a.customercode=b.customercode and  InvoiceDate <='2018-01-31') as Month1,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='2018-01-01' and InvoiceDate <='2018-02-28') as Month2,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='2018-01-01' and InvoiceDate <='2018-03-31') as Month3 from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet limit 1 ";
    	
    	// Below is the correct query
    	//String sql2="select  (select  sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet  where TWEmpName like '%"+EmpName+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.customercode and  InvoiceDate <='"+a_date+"') as Month1,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"') as Month2,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"') as Month3,TWEmpName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName='"+EmpName+"' limit 1 ";
    	
    	//Newly added for greater than 90 days
    	//String sql2="select  (select  sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet  where TWEmpName like '%"+EmpName+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.customercode and  InvoiceDate <='"+a_date+"') as Month1,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"') as Month2,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"') as Month3,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%Monika Barmukh%' order by CompanyName) and a.customercode=b.customercode  and InvoiceDate<'"+d_date+"') as Month4,TWEmpName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName='"+EmpName+"' limit 1 ";
    	
    	//Newly added for closed invoice
    	if(role1.equalsIgnoreCase("HOD"))
    	{
    		
    		
    		%>
	     	
	     	<tr>
	     	<td style="width: 30%">
	     	<div align="center" style="font-size: 1.2em;font-family: arial;"><b>Collection Details</b></div>
	     	<table border=1 class='sortable'  style="width:100%;font-size: 8;font-family: arial;">
	     	
	     	<tr>
	     	<th>Executive Name</th>
	     	<th>Total Outstanding</th>
	     	<th>within 30 Days</th>
	     	<th>31 to 60 Days</th>
	     	<th>61 to 90 Days</th>
	     	<th>Greater than 90 Days</th>
	     	</tr>
	     	
	     	<%
    		//String sql4="select a.MarketingRepCode as MarketingRepCode ,a.MarketingRepName as MarketingRepName from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a, "+session.getAttribute("CompanyMasterID").toString()+"security b where b.ActiveStatus='YES' and a.MarketingRepCode=b.EmpCode and b.Dept='Marketing'  order by a.MarketingRepName";
	     	String sqlmrkt="",HODRoleStatus="",EmpName1="";
	     	String amount="";
	     	//String sql4="select distinct( a.MarketingRepCode) as MarketingRepCode ,a.MarketingRepName as MarketingRepName from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a, UserMaster b where b.ActiveStatus='YES' and a.MarketingRepCode=b.EmpCode and b.Dept='Marketing' and (HODReport='"+session.getAttribute("EmpName").toString()+"' or EmpName='"+session.getAttribute("EmpName").toString()+"') order by a.MarketingRepName";
	     	String sql4="select distinct( a.MarketingRepCode) as MarketingRepCode ,a.MarketingRepName as MarketingRepName from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a, UserMaster b where b.ActiveStatus='YES' and b.companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and a.MarketingRepCode=b.EmpCode and b.Dept='Marketing' order by a.MarketingRepName";
    	    ResultSet RS3=stmark2.executeQuery(sql4);
    	    System.out.println("Query For Marketing code>>>>"+sql4);
    	    while(RS3.next())
    	    {
    	    	 mktcode=RS3.getString("MarketingRepCode");
    	    	 mktRepName=RS3.getString("MarketingRepName");
    	    	 
    	    	 String Cust="select distinct(salescustomercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo = '"+mktcode+"' and salescustomercode!='0' order by CompanyName";
						ResultSet rscust=st8.executeQuery(Cust);
						System.out.println("Cust :- "+Cust);
						String CustCode="";
						double TotalOutStanding=0.00;
						while(rscust.next())
						{
						    CustCode=rscust.getString("Customercode");
						
						String balance="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where customercode in ('"+CustCode+"') order by TransactionId desc limit 1";
						System.out.println("Balance :- "+balance);
						ResultSet rsbalance=st9.executeQuery(balance);
						
						double bal=0.00;
							if(rsbalance.next())
							{
							    bal=rsbalance.getDouble("Balance");
							}
							
							System.out.println("bal :- "+bal);
							TotalOutStanding=TotalOutStanding+bal;
							
							}
						 amount=new DecimalFormat("0.00").format(TotalOutStanding);  
						System.out.println("TotalOutStanding :- "+amount);
					
						
						
    	    	 

					    
						
						
    	    	 //End outstanding logic 
    	    	
    	    	 // String sql2="select  (select  sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"customerdet b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet  where TWEmpName like '%"+mktRepName+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.customercode and  InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+mktRepName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+mktRepName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+mktRepName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4,TWEmpName from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName='"+mktRepName+"' limit 1";
                 //  String sql2="select  (select  sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1 ";
                 //   String sql2="select  (select  IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+mktcode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1";
                      String sql2="select  (select  IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo ='"+mktcode+"' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+mktcode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+mktcode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+mktcode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1";
    	     	System.out.println("Query "+sql2);
    	     	ResultSet RS=stmark.executeQuery(sql2);
    	     	
    	     	while(RS.next())
    	     	{String a1=RS.getString(1);
    	     	 String a2=RS.getString(2);
    	     	 String a3=RS.getString(3);
    	     	 String a4=RS.getString(4);
    	     	 %>
    	     	
    	     	<tr>
    	     	<td><div align="left"><b><%=mktRepName %></b></div></td>
    	     	<td><div align="right"><a href="#"  onclick="popUp2('DashBoardOutstanding.jsp','<%=mktcode %>','<%=mktRepName %>');"><%=amount %></a></div></td>
    	     	<td><div align="right"><%=a1 %></div></td>
    	     	<td><div align="right"><%=a2 %></div></td>
    	     	<td><div align="right"><%=a3 %></div></td>
    	     	<td><div align="right"><%=a4 %></div></td>
    	     	</tr>
    	     	
    	      	<%	}
    	    		
    	    		 }
    	    	 
    	      	 %> 
    	     	
    	     	</table>
    	    
    	     	</td>
    	     	<td style="width: 50%">
    	     	
    	     	
    	     	</td>
    	     	<td style="width: 20%"></td>
    	     	</tr>
    	     	
    	 <%-- 	<%} %> --%>
    	 	
    	     	</table>
    	     	
    	     	<%}else{
    	        	
    	     		
    	     		//Outstanding Code 
    	     		
    	     		
    	     		//String Cust="select distinct(salescustomercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+EmpCode+"%' order by CompanyName";
                      String Cust="select distinct(salescustomercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo = '"+EmpCode+"' and salescustomercode!='0' order by CompanyName";
						ResultSet rscust=st8.executeQuery(Cust);
						System.out.println("Cust :- "+Cust);
						String CustCode="";
						double TotalOutStanding=0.00;
						while(rscust.next())
						{
						    CustCode=rscust.getString("Customercode");
						
						String balance="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where customercode in ('"+CustCode+"') order by TransactionId desc limit 1";
						System.out.println("Balance :- "+balance);
						ResultSet rsbalance=st9.executeQuery(balance);
						
						double bal=0.00;
							if(rsbalance.next())
							{
							    bal=rsbalance.getDouble("Balance");
							}
							
							System.out.println("bal :- "+bal);
							TotalOutStanding=TotalOutStanding+bal;
							
							}
						
						String amount=new DecimalFormat("0.00").format(TotalOutStanding);  
						System.out.println("TotalOutStanding :- "+amount);
						
    	     		


    	     		//End Outstanding code 
    	        	
    	        	//String sql2="select  (select  sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet  where TWEmpName like '%"+EmpName+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.customercode and  InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName like '%"+EmpName+"%' order by CompanyName) and a.customercode=b.customercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4,TWEmpName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where TWEmpName='"+EmpName+"' limit 1";
                   // String sql2="select  (select  sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select sum(a.GrandTotal) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1";
                   //   String sql2="select  (select  sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select sum(a.GrandTotal) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1 ";
    	        	//  String sql2="select  (select  IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo like '%"+EmpCode+"%' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1";
                     String sql2="select  (select  IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a ,"+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo ='"+EmpCode+"' order by CompanyName) and InvoiceDate>='"+b_date+"' and a.customercode=b.salescustomercode and InvoiceDate <='"+a_date+"' and InvoiceCancelled=0) as Month1,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+EmpCode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+c_date+"' and InvoiceDate <='"+b_date+"' and InvoiceCancelled=0) as Month2,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+EmpCode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate>='"+d_date+"' and InvoiceDate <='"+c_date+"' and InvoiceCancelled=0) as Month3,(select IFNULL(sum(a.GrandTotal),0) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where b.customercode in (select distinct(Customercode) as Customercode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where AllocatedTo ='"+EmpCode+"' order by CompanyName) and a.customercode=b.salescustomercode and InvoiceDate<'"+d_date+"' and InvoiceCancelled=0) as Month4 from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster limit 1";
    	        	  System.out.println("Query "+sql2);
    	        	ResultSet RS=stmark.executeQuery(sql2); %>		
    	 			 
    
    	
    	<tr>
    	<td style="width: 30%">
    	<div align="center" style="font-size: 1.2em;font-family: arial;"><b>Collection Details</b></div>
    	<table border=1 class='sortable'  style="width:100%;font-size: 8;font-family: arial;">
    	
    	<tr>
    	<th>Executive Name</th>
    	<th>Total Outstanding</th>
    	<th>within 30 Days</th>
    	<th>31 to 60 Days</th>
    	<th>61 to 90 Days</th>
    	<th>Greater than 90 Days</th>
    	</tr>
    	
    	<%while(RS.next())
    	{String a1=RS.getString(1);
    	 String a2=RS.getString(2);
    	 String a3=RS.getString(3);
    	 String a4=RS.getString(4);
    	 
    	 %>
    	
    	<tr>
    	<td><div align="left"><b><%=EmpName %></b></div></td>
    	<td><div align="right"><a href="#"  onclick="popUp2('DashBoardOutstanding.jsp','<%=EmpCode %>','<%=EmpName %>');"><%=amount %></a></div></td>
    	<td><div align="right"><%=a1 %></div></td>
    	<td><div align="right"><%=a2 %></div></td>
    	<td><div align="right"><%=a3 %></div></td>
    	<td><div align="right"><%=a4 %></a></div></td>
    	</tr>
    	
     	<%	}%>  
    	
    	</table>
   
    	</td>
    	<td style="width: 50%">
    	
    	
    	</td>
    	<td style="width: 20%"></td>
    	</tr>
    	
	<%} %> 
	
    	</table>
    	<%} %>		
		
		
	</div>
<br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br>
	<%@include file="footer_new.jsp"%>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>