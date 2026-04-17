<html>
<head>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@ include file="conn.jsp"%>

<%@page import="java.util.Date"%>
<script>
function Redirect1()
{
	//alert("hhhhh");
	var mon=document.getElementById('mon').value;
	var Year=document.getElementById('Year').value;
	
	var fromaction=document.getElementById('fromaction').value;

	
	alert(" Approved Successfully ");
	
	location.assign("AdminPayrollreport2.jsp?month="+mon+"&year="+Year+"&fromaction="+fromaction+"");

	
}
</script>
<script>

function Redirect2()
{
	alert("Final Pay Roll Generation is Unsuccessfull");
    window.location="RevisePayApproval.jsp";
	
}


</script>
</head>

<body>

<%
String mon=request.getParameter("month");
System.out.println(">>>>>>>>Month:"+mon);

String finmon="";
finmon=mon;
if(finmon.equals("JAN"))
{
	finmon="01";
}
else if(finmon.equals("FEB"))
{
	finmon="02";
}
else if(finmon.equals("MAR"))
{
	finmon="03";
}
else if(finmon.equals("APR"))
{
	finmon="04";
}
else if(finmon.equals("MAY"))
{
	finmon="05";
}
else if(finmon.equals("JUN"))
{
	finmon="06";
}
else if(finmon.equals("JUL"))
{
	finmon="07";
}
else if(finmon.equals("AUG"))
{
	finmon="08";
}
else if(finmon.equals("SEP"))
{
	finmon="09";
}
else if(finmon.equals("OCT"))
{
	finmon="10";
}
else if(finmon.equals("NOV"))
{
	finmon="11";
}
else if(finmon.equals("DEC"))
{
	finmon="12";
}

String year=request.getParameter("year");
System.out.println(">>>>>>>>Year:"+year);
String fromaction="yes";
%>
<input type="hidden" name="fromaction" id="fromaction" value=<%=fromaction %>>


	<input type="hidden" name="mon" id="mon" value=<%=finmon %>>
	<input type="hidden" name="Year" id="Year" value=<%=year %>>

<%
if(mon.equals("01"))
{
	mon="JAN";
}else if(mon.equals("02"))
{
	mon="FEB";
}else if(mon.equals("03"))
{
	mon="MAR";
}
else if(mon.equals("04"))
{
	mon="APR";
}
else if(mon.equals("05"))
{
	mon="MAY";
}
else if(mon.equals("06"))
{
	mon="JUN";
}
else if(mon.equals("07"))
{
	mon="JUL";
}
else if(mon.equals("08"))
{
	mon="AUG";
}
else if(mon.equals("09"))
{
	mon="SEP";
}
else if(mon.equals("10"))
{
	mon="OCT";
}
else if(mon.equals("11"))
{
	mon="NOV";
}


else if(mon.equals("12"))
{
	mon="DEC";
}


System.out.println("Month is"+mon+"Year is"+year);
Connection con=null ;
try
{

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);


	/* Class.forName("com.mysql.cj.jdbc.Driver");  
	Connection con=DriverManager.getConnection(  
	"jdbc:mysql:// twdb.fleetview.in/student","root","root");   */
	Statement local=con.createStatement();
	Statement local1=con.createStatement();
	Statement local2=con.createStatement();


	Statement local11=con.createStatement();
	Statement local12=con.createStatement();
	Statement local13=con.createStatement();
	Statement local14=con.createStatement();


	String EntryBy=session.getAttribute("EmpName").toString();

	String emp_id="";
	String Department="",EmpName="",Reason="",EnrtyDate="";


	SimpleDateFormat fr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	Date date = new Date();  
	System.out.println(fr.format(date));

	String abc=",";

	String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active'";


	ResultSet rs1=local11.executeQuery(empdetails);
	System.out.println("Query is:"+empdetails);


	while(rs1.next())
	{
		System.out.println("Inside while");
	String Depart="",Designation="";
		
		emp_id=rs1.getString("ContractorId");

		
	System.out.println(" emp id:"+emp_id);
		
		
		abc=abc+"'"+emp_id+"'"+",";
		
		int payversion=0;
		
		
		String versionquery="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where ID='"+emp_id+"'and Month='"+mon+"'and Year='"+year+"' order by PayrollVersion desc limit 1";
		System.out.println(" versionquery id:"+versionquery);

		ResultSet rs12=local1.executeQuery(versionquery);
		if(rs12.next())
		{	

			payversion=rs12.getInt("PayRollVersion");
			payversion=payversion+1;
		}
		else
		{
			payversion=payversion+1;
			
			
		}
		
		
		
		
		
		String payInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew(ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,PreviousPayPlus,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,PayrollVersion,EntryBy,EntryDate) select ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,PreviousPayPlus,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,'"+payversion+"','"+EntryBy+"','"+fr.format(date)+"' from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where Month='"+mon+"' and Year='"+year+"' and ID='"+emp_id+"'";
		
		System.out.println(payInsert);
		int i=0;
		i=local.executeUpdate(payInsert);
		
		System.out.println(i);
		

		
		
		
		

		
		
		
	}


	System.out.println("hhhhhh");


	out.println("<script>  Redirect1();</script>");



}

catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect2();</script>");
} 

%>
</body>
</html>




