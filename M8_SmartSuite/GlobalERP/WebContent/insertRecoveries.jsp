<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<%@ include file="header.jsp"%>


</head>
<body>



<%
Connection con=null;

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

/* Class.forName("com.mysql.cj.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
"jdbc:mysql:// twdb.fleetview.in/student","root","root");  
//here sonoo is database name, root is username and password   */
Statement stmt=con.createStatement(); 
Statement stmt2=con.createStatement();
Statement stmt3=con.createStatement();

System.out.println("Connection done");

DecimalFormat df = new DecimalFormat("0.00");



String EntryBy=session.getAttribute("EmpName").toString();
String empid=request.getParameter("Empid");
String month=request.getParameter("month");
String year=request.getParameter("year");



double Advance=Double.parseDouble(request.getParameter("advance"));
double sd=Double.parseDouble(request.getParameter("securitydeposite"));
double mobile=Double.parseDouble(request.getParameter("mobile"));
double previouspay=Double.parseDouble(request.getParameter("prepay"));
double otheramount=Double.parseDouble(request.getParameter("otheramount"));
String othercomment=request.getParameter("comments");
String employeename=request.getParameter("Name");
String depart=request.getParameter("depart");
System.out.println("employeename:"+employeename);
System.out.println("employeename:"+depart);




double totaldeduction=Advance+sd+previouspay+mobile+otheramount;


System.out.println("Entry by:"+EntryBy);
System.out.println("Employee idy:"+empid);




System.out.println("For Month:"+month);
System.out.println("Mobile allow:"+mobile);
System.out.println("Year:"+year);
System.out.println("Advance :"+Advance);
System.out.println("Security deposite:"+sd);

System.out.println("Previous pay:"+previouspay);
System.out.println("otheramount:"+otheramount);
System.out.println("othercomments:"+othercomment);

int version1=0;

//String versionquery="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"DeducationMaster where EmpId='"+empid+"' order by RecoveryVersion desc limit 1";

String versionquery="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"DeducationMasterNew where EmpId='"+empid+"' order by RecoveryVersion desc limit 1";

ResultSet rs12=stmt.executeQuery(versionquery);
if(rs12.next())
{
	version1=rs12.getInt("RecoveryVersion");
	version1=version1+1;
	
}
else
{
	version1=version1+1;
}


SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));




//String insertDeduction="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"DeducationMaster(EmpId,EmpName,Department,Month,Year,Advance,securityDeposit,PreviousPay,MobileAllowancesdeduction,other,otherReason,EntryBy,RecoveryVersion,TotalDeduction)values('"+empid+"','"+employeename+"','"+depart+"','"+month+"','"+year+"','"+df.format(Advance)+"','"+df.format(sd)+"','"+df.format(previouspay)+"','"+df.format(mobile)+"','"+df.format(otheramount)+"','"+othercomment+"','"+EntryBy+"','"+version1+"','"+df.format(totaldeduction)+"') ";

String insertDeduction="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"DeducationMasterNew (EmpId,EmpName,Department,Month,Year,Advance,securityDeposit,PreviousPay,MobileAllowancesdeduction,other,otherReason,EntryBy,RecoveryVersion,TotalDeduction)values('"+empid+"','"+employeename+"','"+depart+"','"+month+"','"+year+"','"+df.format(Advance)+"','"+df.format(sd)+"','"+df.format(previouspay)+"','"+df.format(mobile)+"','"+df.format(otheramount)+"','"+othercomment+"','"+EntryBy+"','"+version1+"','"+df.format(totaldeduction)+"') ";

int j=0;

j=stmt.executeUpdate(insertDeduction);




//String insertDedu="insert into attendancesummary(ID,Name,Department,Month,Year,Advance,securityDeposit,MobileAllowancesdeduction,PreviousPay,other,otherReason,RecoveryEntryBy,RecoveryVersion,RecoveryEntryDate)values('"+empid+"','"+employeename+"','"+depart+"','"+month+"','"+year+"','"+Advance+"','"+sd+"','"+mobile+"','"+previouspay+"','"+otheramount+"','"+othercomment+"','"+EntryBy+"','"+version1+"','"+formatter.format(date)+"')";

double amttopay=0.00,TDSAmount=0.00,FinalPay=0.00;
int version2=0;

String getFinalAmount="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where  ID='"+empid+"'and Month='"+month+"'and Year='"+year+"'";
ResultSet rsd=stmt3.executeQuery(getFinalAmount);
if(rsd.next())
{
	amttopay=rsd.getDouble("AmountToPay");
	FinalPay=rsd.getDouble("FinalPay");
	version2=rsd.getInt("ReviseNo");
	version2=version2+1;
	TDSAmount=rsd.getDouble("TDSAmount");
}
else
{
	version2=version2+1;
}



//double TotalAmount=amttopay-totaldeduction;

/* double tds=(totaldeduction/100)*1;

double totaldeduction1=totaldeduction-tds; */

double TotalAmount=amttopay-totaldeduction;


// double tds=totaldeduction/100*1;



//TotalAmount=TotalAmount-tds;

// tds=TDSAmount-tds;




//String updatemain="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary set Advance='"+df.format(Advance)+"',securityDeposit='"+df.format(sd)+"',PreviousPay='"+df.format(previouspay)+"',MobileAllowancesdeduction='"+df.format(mobile)+"',other='"+df.format(otheramount)+"',otherReason='"+othercomment+"',TotalDeduction='"+df.format(totaldeduction)+"',TDSAmount='"+df.format(tds)+"',AmountToPay='"+df.format(TotalAmount)+"',RecoveryEntryBy='"+EntryBy+"',RecoveryEntryDate='"+formatter.format(date)+"',RecoveryVersion='"+version1+"' where ID='"+empid+"'and Month='"+month+"'and Year='"+year+"'";

String updatemain="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew set Advance='"+df.format(Advance)+"',securityDeposit='"+df.format(sd)+"',PreviousPay='"+df.format(previouspay)+"',MobileAllowancesdeduction='"+df.format(mobile)+"',other='"+df.format(otheramount)+"',otherReason='"+othercomment+"',TotalDeduction='"+df.format(totaldeduction)+"',AmountToPay='"+df.format(TotalAmount)+"',RecoveryEntryBy='"+EntryBy+"',RecoveryEntryDate='"+formatter.format(date)+"',RecoveryVersion='"+version1+"',ReviseNo='"+version2+"' where ID='"+empid+"'and Month='"+month+"'and Year='"+year+"'";

System.out.println(updatemain);


int i=0;
i=stmt2.executeUpdate(updatemain);
if(i>0)
{
	System.out.println("Insertion Done");
	out.println("<script type=\"text/javascript\">");
	   out.println("swal('Deduction ','','success');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='PayRollReport2.jsp';");
	   out.println("</script>");
}

%>


</body>
</html>