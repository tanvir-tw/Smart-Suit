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

Statement stmt1=con.createStatement(); 
Statement stmt2=con.createStatement();
Statement stmt3=con.createStatement();
Statement stmt4=con.createStatement();
System.out.println("Connection done");

DecimalFormat df = new DecimalFormat("0.00");
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));

int Revision=1;


String EntryBy=session.getAttribute("EmpName").toString();
String emp_is=request.getParameter("Empid");
String name=request.getParameter("Name");
String dept=request.getParameter("depart");
String month=request.getParameter("month");
String year=request.getParameter("year");
String iincentiveold=request.getParameter("incentiveold");
String incentivenew=request.getParameter("incentivenew");
String comment11=request.getParameter("comment11");
String Previousold=request.getParameter("Previousold");
String PreviousNew=request.getParameter("PreviousNew");
String comment21=request.getParameter("comment21");
String other=request.getParameter("other");
String othernew=request.getParameter("othernew");
String comments31=request.getParameter("comments31");




System.out.println("Emp_id is:"+emp_is);
System.out.println("Emp_id name:"+name);
System.out.println("dept:"+dept);
System.out.println("month:"+month);
System.out.println("year:"+year);
System.out.println("incentiveold:"+iincentiveold);
System.out.println("incentivenew:"+incentivenew);

System.out.println("comment11:"+comment11);

System.out.println("Previousold:"+Previousold);

System.out.println("PreviousNew:"+PreviousNew);
System.out.println("comment21:"+comment21);
System.out.println("other:"+other);
System.out.println("othernew:"+othernew);
System.out.println("comments31:"+comments31);





//String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"0RevisionMaster(Name,EntryBy,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew,IncentiveComment,PreviousPayComment,OtherComment,EntryDate,Revision,ContractorId,Month,Year)values('"+name+"','"+iincentiveold+"','"+incentivenew+"','"+Previousold+"','"+PreviousNew+"','"+other+"','"+othernew+"','"+comment11+"','"+comment21+"','"+comments31+"','"+EntryBy+"','"+formatter.format(date)+"','"+Revision+"','"+emp_is+"','"+month+"','"+year+"')";

String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"0RevisionMasterNew (Name,EntryBy,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew,IncentiveComment,PreviousPayComment,OtherComment,EntryDate,Revision,ContractorId,Month,Year)values('"+name+"','"+iincentiveold+"','"+incentivenew+"','"+Previousold+"','"+PreviousNew+"','"+other+"','"+othernew+"','"+comment11+"','"+comment21+"','"+comments31+"','"+EntryBy+"','"+formatter.format(date)+"','"+Revision+"','"+emp_is+"','"+month+"','"+year+"')";

System.out.println("Query is:"+insertRevision);






int i=0;
i=stmt1.executeUpdate(insertRevision);


if(i>0)
{
	
	//String updateMaster="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary set OtherPlus='"+othernew+"',PreviousPayPlus='"+PreviousNew+"',Incentive='"+incentivenew+"' ,ReviseNo='"+Revision+"' where Id='"+emp_is+"' and Month='"+month+"' and Year='"+year+"'";
	
	double amttopay=0.00;
String getFinalAmount="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where  ID='"+emp_is+"'and Month='"+month+"'and Year='"+year+"'";
ResultSet rsd=stmt3.executeQuery(getFinalAmount);
if(rsd.next())
{
	amttopay=rsd.getDouble("AmountToPay");
}

double incentivenew1=Double.parseDouble(incentivenew);
double prepayplusnew1=Double.parseDouble(PreviousNew);
double othernew1=Double.parseDouble(othernew);

double totaladd=incentivenew1+prepayplusnew1+othernew1;

double TotalAmount=amttopay+totaladd;


double tds=totaladd/100*1;
	
	String updateMaster="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew set TDSAmount='"+df.format(tds)+"',AmountToPay='"+df.format(TotalAmount)+"',OtherPlus='"+othernew+"',PreviousPayPlus='"+PreviousNew+"',Incentive='"+incentivenew+"' ,ReviseNo='"+Revision+"' where Id='"+emp_is+"' and Month='"+month+"' and Year='"+year+"'";

	System.out.println(updateMaster);
	
	int j=0;
	j=stmt2.executeUpdate(updateMaster);
	
	 
	 
	 
	if(j>0)
	{
		System.out.println("Insertion Done in master");
		out.println("<script type=\"text/javascript\">");
		   out.println("swal('Revision ','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='PayRollReport2.jsp';");
		   out.println("</script>");
		
	}

	
	System.out.println("Insertion Done");
}























%>


</body>
</html>