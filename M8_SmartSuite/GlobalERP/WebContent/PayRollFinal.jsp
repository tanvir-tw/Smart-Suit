<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="header.jsp"%>
<%@page import="com.erp.beans.*"%>
<title>Insert title here</title>
</head>
<body>

<%

String month=request.getParameter("month");
String year=request.getParameter("Year");

String[] chk=request.getParameterValues("chkbx");




System.out.println("Month is"+month+"Year is"+year);

Connection con=null;

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);


/* Class.forName("com.mysql.cj.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
"jdbc:mysql:// twdb.fleetview.in/student","root","root");   */
Statement local=con.createStatement();
Statement local1=con.createStatement();
Statement local2=con.createStatement();


String EntryBy=session.getAttribute("EmpName").toString();

int EmpId=0;
String Department="",EmpName="",Reason="",EnrtyDate="";


SimpleDateFormat fr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
Date date = new Date();  
System.out.println(fr.format(date));

String abc=",";


for(String empcheck:chk)
{
	
System.out.println("check emp id:"+empcheck);
	
	
	abc=abc+"'"+empcheck+"'"+",";
	
	int payversion=0;
	
	//String versionquery="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMaster where ID='"+empcheck+"'and Month='"+month+"'and Year='"+year+"' order by PayrollVersion desc limit 1";
	
	String versionquery="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where ID='"+empcheck+"'and Month='"+month+"'and Year='"+year+"' order by PayrollVersion desc limit 1";
	
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
	
	
	
	
	//String payInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMaster(ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,PayrollVersion,EntryBy,EntryDate) select ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,'"+payversion+"','"+EntryBy+"','"+fr.format(date)+"' from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where Month='"+month+"' and Year='"+year+"' and ID='"+empcheck+"'";
	
	String payInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew(ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,PreviousPayPlus,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,PayrollVersion,EntryBy,EntryDate) select ID,UserName,Name,Date,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,Month,Year,Present,Late,HalfDay,ApprovedLeave,Absent,OffLeave,OffHalfDay,Holiday,WeekOff,paidleave,Paiddays,Sandwich,Advance,securityDeposit,PreviousPay,PreviousPayPlus,other,RecoveryEntryBy,otherReason,RecoveryVersion,FinalPay,RecoveryEntryDate,Department,VehicleAllowance,MobileAllowance,LaptopAllowance,MobileAllowancesdeduction,KraIndex,PiIndex,afterRecoveryFinalPay,PiAmount,KraAmount,TotalDeduction,BasicPi,BasicKra,TDSAmount,AmountToPay,'"+payversion+"','"+EntryBy+"','"+fr.format(date)+"' from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where Month='"+month+"' and Year='"+year+"' and ID='"+empcheck+"'";
	
	System.out.println(payInsert);
	int i=0;
	i=local.executeUpdate(payInsert);
	
	System.out.println(i);
	

	
	
	
	
	

	

	
	

	
	
	

	

	
	
	
}

System.out.println("Employee id are:"+abc);
abc=abc.substring(1, abc.length());
int index=abc.lastIndexOf(',');
String id123=abc.substring(0, index);
System.out.println(index);
System.out.println("after removing comma"+id123);

PaySlipUpload  pdf =new PaySlipUpload(id123,month,year); 


	/*  out.println("<script type=\"text/javascript\">");
	   out.println("swal('PayRoll Generated','','successfully');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='FinalPayReport.jsp';");
	  
	  
	   out.println("</script>"); */





double Presentdays=0.00,ApprovedLeaves=0.00,PaidDays=0.00,BasicPi=0.00,BasicKra=0.00,PiIndex=0.00;
double KraIndex=0.00,PiAmount=0.00,KraAmount=0.00,VehicleAllowance=0.00,MobileAllowance=0.00,RentAllowance=0.00;
double LaptopAllowance=0.00,Advance=0.00,SecurityDeposit=0.00,PreviousPay=0.00,MobileAllowancededuction=0.00,OtherRecovery=0.00;
double TotalRecovery=0.00,FinalPay=0.00;

String Month="",Year="";



String paidays="0",Approvedays="0",Presentday="0";



/* String getData="select * from attendancesummary where Month='"+month+"' and Year='"+year+"'" ; */
/* ResultSet rsgetdata=local.executeQuery(getData); */
/* while(rsgetdata.next())
{
	
	
	

	paidays=rsgetdata.getString("Paiddays");
	Approvedays=rsgetdata.getString("ApprovedLeave");
	Presentday=rsgetdata.getString("Present");
	
	
	if(paidays.equals("-"))
	{
		paidays="0";
	}
	if(Approvedays.equals("-"))
	{
		Approvedays="0";
	}
	if(Presentday.equals("-"))
	{
		Presentday="0";
	}
	
	
	
	Presentdays=Double.parseDouble(Presentday);
	ApprovedLeaves=Double.parseDouble(Approvedays);
	PaidDays=Double.parseDouble(paidays);
	
	
 	Presentdays=rsgetdata.getDouble("Present");
	ApprovedLeaves=rsgetdata.getDouble("ApprovedLeave");
	PaidDays=rsgetdata.getDouble("Paiddays");
 
	

	EmpId=Integer.parseInt(rsgetdata.getString("ID"));
	Department=rsgetdata.getString("Department");
	EmpName=rsgetdata.getString("Name");
	
	BasicPi=rsgetdata.getDouble("BasicPi");
	BasicKra=rsgetdata.getDouble("BasicKra");
	PiIndex=rsgetdata.getDouble("PiIndex");
	KraIndex=rsgetdata.getDouble("KraIndex");
	PiAmount=rsgetdata.getDouble("PiAmount");
	KraAmount=rsgetdata.getDouble("KraAmount");
	VehicleAllowance=rsgetdata.getDouble("VehicleAllowance");
	MobileAllowance=rsgetdata.getDouble("MobileAllowance");
	LaptopAllowance=rsgetdata.getDouble("LaptopAllowance");
	Advance=rsgetdata.getDouble("Advance");
	SecurityDeposit=rsgetdata.getDouble("securityDeposit");
	PreviousPay=rsgetdata.getDouble("PreviousPay");
	MobileAllowancededuction=rsgetdata.getDouble("MobileAllowancesdeduction");
	OtherRecovery=rsgetdata.getDouble("other");
	Reason=rsgetdata.getString("otherReason");
	FinalPay=rsgetdata.getDouble("afterRecoveryFinalPay");
	TotalRecovery=rsgetdata.getDouble("TotalDeduction");
	
	
	Month=rsgetdata.getString("Month");
	Year=rsgetdata.getString("year");
			
	int Payrollversion=0;
	String versionquery="select * from PayrollMaster where EmpId='"+EmpId+"'and Month='"+Month+"'and Year='"+Year+"' order by PayRollVersion desc limit 1";

	ResultSet rs12=local1.executeQuery(versionquery);
	if(rs12.next())
	{
		Payrollversion=rs12.getInt("PayRollVersion");
		Payrollversion=Payrollversion+1;
		
	}
	else
	{
		Payrollversion=Payrollversion+1;
	}

	
	
	
String insertdata=" insert into PayrollMaster(EmpId,Department,EmpName,Presentdays,ApprovedLeaves,PaidDays,BasicPi,BasicKra,PiIndex,KraIndex,PiAmount,KraAmount,VehicleAllowance,MobileAllowance,RentAllowance,LaptopAllowance,Advance,SecurityDeposit,PreviousPay,MobileAllowancededuction,OtherRecovery,Reason,TotalRecovery,FinalPay,EntryBy,PayRollVersion,EnrtyDate,Month,Year)"

				+"values('"+EmpId+"','"+Department+"','"+EmpName+"','"+Presentdays+"','"+ApprovedLeaves+"','"+PaidDays+"','"+BasicPi+"','"+BasicKra+"','"+PiIndex+"',"
				+"'"+KraIndex+"','"+PiAmount+"','"+KraAmount+"','"+VehicleAllowance+"','"+MobileAllowance+"',0,'"+LaptopAllowance+"','"+Advance+"','"+SecurityDeposit+"','"+PreviousPay+"','"+MobileAllowancededuction+"','"+OtherRecovery+"','"+Reason+"','"+TotalRecovery+"','"+FinalPay+"','"+EntryBy+"','"+Payrollversion+"','"+fr.format(date)+"','"+month+"','"+year+"' )";
						
	int i=0;
	i=local2.executeUpdate(insertdata);
	
	
	System.out.println(insertdata);
	
	if(i>0)
	{
		System.out.println("Insertion Done");
	}
	
	
}
 */





%>

</body>
</html>