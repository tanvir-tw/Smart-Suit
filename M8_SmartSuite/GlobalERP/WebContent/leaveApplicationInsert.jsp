<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ConnectionClass"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>


<%
Connection conn=null;
Statement st1=null, st= null, st4=null;
Statement stmt11=null,stgp=null,strno=null;
ConnectionClass connection= new ConnectionClass();
String reportno = "",reportname="";
try{
	conn = connection.getConnect("db_leaveapplication");
	 st=conn.createStatement();	
	 st1=conn.createStatement();
	 st4=conn.createStatement();
	 stmt11=conn.createStatement();
	 stgp=conn.createStatement();
	 strno = conn.createStatement();

	 String PageName=this.getClass().getName();
	 String sqlreport = "select ReportNo from t_reportnumber where PageName = '"+PageName+"'";
	 ResultSet rsreport = strno.executeQuery(sqlreport);
	 if(rsreport.next())
	 {
	 	reportno = rsreport.getString("ReportNo");
	 	reportname=rsreport.getString("ReportName");
	 }

	 String heading=reportname+" "+reportno;
	 System.out.println("heading Name"+heading);

String DaysApplied=request.getParameter("DaysApplied");
String FirstDayOfLeave=request.getParameter("FirstDayOfLeave");
String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date());
String FirstDayOfLeave1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(FirstDayOfLeave));
String reason=request.getParameter("reason");
if(reason.equals("Local Travel") || reason.equals("Outstation Travel") || reason.equals("Work From Home") ){
	reason="Office Work";
}
String reasonForLeave=request.getParameter("reasonForLeave");
reasonForLeave=reasonForLeave.replace("'","");
String DateOfReporting=request.getParameter("DateOfReporting");
String DateOfReporting1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(DateOfReporting));
String emailAdd=request.getParameter("emailAdd");
String Details=request.getParameter("Details");
String name=request.getParameter("name");
String HODemailAdd=request.getParameter("HODemailAdd");
String empid=request.getParameter("empid");
String typeofleave="";
String URole=session.getAttribute("leaveemprole").toString();
String typevalue=session.getAttribute("leaveempdept").toString();
Boolean innerflag=false;

java.util.Date d= new java.util.Date();
String datetoday=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);

System.out.println("DateOfReporting*********"+DateOfReporting);
String s="select *   from t_leaveadmin  where empid='"+empid+"'  and status='Yes'  ";
ResultSet rss=st.executeQuery(s);
System.out.println("-------s->>"+s);
String name1="";
if(rss.next())
{
	name1=rss.getString("Name");
}

String validleave="select * from t_leaverequest where firstdayofleave='"+FirstDayOfLeave1+"' and dateofreporting='"+DateOfReporting1+"' and name='"+name1+"' and (status='Approved' or status='Pending' )  ";
System.out.println("validleave *********"+validleave);
ResultSet rsvalidleave=st4.executeQuery(validleave);

if(!rsvalidleave.next())
{
	System.out.println("In Valid ");

String Logo1="";
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
java.util.Date date = new java.util.Date();
String Website="http://twtech.in/Transworld/";
String getEmailDetails="SELECT * FROM db_gps.t_EmailReportSettings WHERE `System` = 'ERP'";
ResultSet rs11=stmt11.executeQuery(getEmailDetails);
String q2 = "";
while(rs11.next())
{
	Logo1=rs11.getString("Logo1");
}

String anotherdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(FirstDayOfLeave1));
String lastdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(DateOfReporting1));
System.out.println(FirstDayOfLeave+"    "+anotherdate);
System.out.println(lastdate);
Boolean flag=false;
int days=0;
String noOfDays="";
String sql1="select TO_DAYS('"+FirstDayOfLeave+"')-TO_DAYS('"+datetoday+"') as days";
ResultSet rs=st1.executeQuery(sql1);
if(rs.next()){
	days=rs.getInt("days");
	System.out.println(days);
	if(days>0){
		noOfDays="leave has been applied "+days +" days in advance";
	}else{
		noOfDays="";
	}
}
String sql="insert into t_leaverequest(daysapplied,firstdayofleave,typeofleave,reasonforleave,dateofreporting,emailid,details,status,HOD,name,inserteddatetime,TypeValue,URole) values ('"+DaysApplied+"','"+FirstDayOfLeave1+"','"+reason+"','"+reasonForLeave+"','"+DateOfReporting1+"','"+emailAdd+"','"+Details+"','Pending','"+HODemailAdd+"','"+name+"','"+datetoday+"','"+typevalue+"','"+URole+"')";
System.out.println("Sql ********"+sql);

String Data="";
String subject="";
if(reason.contains("Office work"))
{
	Data = Data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
	"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
	"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
	"<img src="+Logo1+" style=^height: 70px; width: 400px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td></tr></table><font style=^color: #D8D8D8^>"+
	"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
	" <u><a href="+Website+">"+Website+"</a></u>&nbsp;"+ df.format(date) +"<br>"+heading+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
	Data= Data + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial></br>"+name+", has applied for leave to be approved as follows: </font></br></td></tr></table></td></tr>"+
	"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=90% border=1 style=^border-collapse: collapse^>"+
"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Days Applied  </b></font></td>"+
"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b>  First Day Of Travel </b></font></td>"+
"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Type </b></font></td>"+
"<td align=center style=^overflow: auto; width: 25%;height: 50%^><font size=^2^ face=^arial^><b> Reason  </b></font></td>"+
"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Reporting Date  </b></font></td>";

Data= Data + "<tr><td align=right><font size=^2^ face=^arial^>"+DaysApplied+"</font></td>"+
			"<td align=right><font size=^2^ face=^arial^>"+anotherdate+"</font></td>"+
			"<td align=left><font size=^2^ face=^arial^>"+reason+"</font></td>"+
			"<td align=left><font size=^2^ face=^arial^>"+reasonForLeave+"</font></td>"+ 
			"<td align=right><font size=^2^ face=^arial^>"+lastdate+"</font></td>";
Data= Data + "</tr></table><br/></br>";
Data= Data+"</br></br></br></br></br>";
Data = Data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Copyright @2008 by Transworld Technologies Ltd. All Rights Reserved.</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
	
subject="Travel Application of "+name+" on "+df.format(date)+".";
}
else
{
	Data = Data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
	"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
	"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
	"<img src="+Logo1+" style=^height: 70px; width: 400px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td></tr></table><font style=^color: #D8D8D8^>"+
	"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
	" <u><a href="+Website+">"+Website+"</a></u>&nbsp;"+ df.format(date) +"<br>"+heading+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
	Data= Data + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial></br>"+name+", has applied for leave to be approved as follows: </font></br></td></tr></table></td></tr>"+
	"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=90% border=1 style=^border-collapse: collapse^>"+
"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Days Applied  </b></font></td>"+
"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> First Day Of Leave </b></font></td>"+
"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Type Of Leave </b></font></td>"+
"<td align=center style=^overflow: auto; width: 25%;height: 50%^><font size=^2^ face=^arial^><b> Reason For Leave  </b></font></td>"+
"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Reporting Date  </b></font></td>";

Data= Data + "<tr><td align=right><font size=^2^ face=^arial^>"+DaysApplied+"</font></td>"+
			"<td align=right><font size=^2^ face=^arial^>"+anotherdate+"</font></td>"+
			"<td align=left><font size=^2^ face=^arial^>"+reason+"</font></td>"+
			"<td align=left><font size=^2^ face=^arial^>"+reasonForLeave+"</font></td>"+
			"<td align=right><font size=^2^ face=^arial^>"+lastdate+"</font></td>";
Data= Data + "</tr></table><br/></br>";
Data= Data+"</br></br></br></br></br>";
Data = Data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Copyright @2008 by Transworld Technologies Ltd. All Rights Reserved.</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";

subject="Leave Application of "+name+" on "+df.format(date)+".";	
}

System.out.println("Data>>>>>>"+Data);
int i=0;
i=st.executeUpdate(sql);
if(i>0){
	System.out.println("leave added");
	innerflag=true;
	try{

		 flag=false;
		 if(innerflag==true)
		 {
		               try
		               {
		                  q2 = "insert into db_GlobalERP.t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Transworld','Mail for Leave Application','"
									+ Data
									+ "','"
									+ subject
									+ "','"
									+ HODemailAdd
									+ "','"
									+ emailAdd
									+ "','"
									+ CurrentDate + "','Pending','Transworld')";
		                  
		                  System.out.println("q2All_PendingMail>>>> :" + q2);
							stgp.executeUpdate(q2);
							
		                    flag=true;
		               }
		               catch(Exception e)
		               {
		                  e.printStackTrace();
		               } 
		 }//if innerflag
		       
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("leaveapplication.jsp?inserted=yes");
}else{
	response.sendRedirect("leaveapplication.jsp?inserted=no");
}
}else
{
	response.sendRedirect("leaveapplication.jsp?inserted=present");
}

}catch(Exception e){
	e.printStackTrace();
	response.sendRedirect("leaveapplication.jsp?error=true");
}
%>