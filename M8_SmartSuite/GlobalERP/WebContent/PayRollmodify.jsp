<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>PayRoll modify</title>
<%@ include file="header.jsp"%>

<script>

function Redirect()
{
	var mon=document.getElementById('month').value;

	var monthMap = {
	    "Jan": "01",
	    "Feb": "02",
	    "Mar": "03",
	    "Apr": "04",
	    "May": "05",
	    "Jun": "06",
	    "Jul": "07",
	    "Aug": "08",
	    "Sep": "09",
	    "Oct": "10",
	    "Nov": "11",
	    "Dec": "12"
	};

	var monthNumber = monthMap[mon];

	//alert(monthNumber); // 👉 03
	
//	alert(mon);
	var Year=document.getElementById('year').value;
	//alert(Year);
	
	alert(" Revised Successfully ");
	
	location.assign("PayRollReport2.jsp?month="+monthNumber+"&year="+Year+"&action=redirect");


   // window.location="RevisePayReport.jsp";
	
}
</script>

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
Statement stmt1=con.createStatement(); 
Statement stmt2=con.createStatement();
Statement stmt3=con.createStatement();
Statement stmt4=con.createStatement();
Statement stmt5=con.createStatement();

System.out.println("Connection done");

DecimalFormat df = new DecimalFormat("0.00");




 String paiddays=request.getParameter("paiddaysnew");
String oldpaid=request.getParameter("oldpaid");
String paidcomment	=request.getParameter("paidcmt");



String otherold=request.getParameter("otherold");
String othernew=request.getParameter("othernew");
String othercomment=request.getParameter("othercomment");
String incentiveold=request.getParameter("incentiveold");
String incentivenew=request.getParameter("incentivenew");
String incentiveComment=request.getParameter("incentiveComment");

String prepayplusold=request.getParameter("prepayplusold");
String prepayplusnew=request.getParameter("prepayplusnew");
String prepaypluscomment=request.getParameter("prepaypluscomment");




System.out.println("otherold------------------>"+otherold);
System.out.println("othernew------------------>"+othernew);
System.out.println("othercomment--------------->"+othercomment);
System.out.println("incentiveold---------------->"+incentiveold);
System.out.println("incentivenew---------------->"+incentivenew);
System.out.println("incentiveComment------------->"+incentiveComment);
System.out.println("prepayplusold----------------->"+prepayplusold);
System.out.println("prepayplusold----------------->"+prepayplusnew);
System.out.println("prepaypluscomment-------------->"+prepaypluscomment);









/*
String specialcomment=request.getParameter("speccmt"); */



String EntryBy=session.getAttribute("EmpName").toString();
String empid=request.getParameter("Empid");
String month=request.getParameter("month");
String year=request.getParameter("year");
String name=request.getParameter("Name");



String oldpi=request.getParameter("oldpi");
String oldkra=request.getParameter("oldkra");
String kraindex=request.getParameter("kraindexnew");
String piindex=request.getParameter("piindexnew");
String picomment=request.getParameter("picmt");
String kracomment=request.getParameter("kracmt");




 System.out.println("paidaysNew:  "+paiddays); 
System.out.println("kraindexNew   "+kraindex);
System.out.println("PiindexNew   "+piindex);
System.out.println("Employee id   "+empid);
System.out.println("month      "+month);
System.out.println("Year     "+year);

System.out.println("oldpI   "+oldpi);
System.out.println("oldKra   "+oldkra);
 System.out.println("oldpaid   "+oldpaid); 
System.out.println("Name     "+name);
 System.out.println("paidcomment    "+paidcomment); 
System.out.println("picomment   "+picomment);
System.out.println("kracomment    "+kracomment);

/* System.out.println("specialcomment   "+specialcomment); */

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));

int Revision=0,SrNo=0;
String Status="";

//String revisioncount="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMaster where ContractorId='"+empid+"' and Month='"+month+"' and Year='"+year+"' order by Revision DESC";

String revisioncount="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where ContractorId='"+empid+"' and Month='"+month+"' and Year='"+year+"' order by Revision DESC limit 1";

ResultSet rs1=stmt1.executeQuery(revisioncount);
if(rs1.next())
{
	Status=rs1.getString("Status");
	SrNo=rs1.getInt("SrNo");
	Revision=rs1.getInt("Revision");
	Revision=Revision+1;
}
else
{
	Revision=1;
}


System.out.println("Revision is:"+Revision);

/* String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"Revision=Master(Name,oldPaiddays,newPaiddays,oldPiindex,newPiindex,oldKraindex,newKraIndex,EntryBy,EntryDate,Revision)values('"+name+"','"+oldpaid+"','"+paiddays+"','"+oldpi+"','"+piindex+"','"+oldkra+"','"+kraindex+"','"+EntryBy+"','"+formatter.format(date)+"') "; */



//String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMaster(Name,oldPiindex,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,PiComment,KraComment,PaidComment,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew,IncentiveComment,PreviousPayComment,OtherComment)values('"+name+"','"+oldpi+"','"+piindex+"','"+oldkra+"','"+kraindex+"','"+oldpaid+"','"+paiddays+"','"+EntryBy+"','"+formatter.format(date)+"','"+Revision+"','"+empid+"','"+month+"','"+year+"','"+picomment+"','"+kracomment+"','"+paidcomment+"','"+incentiveold+"','"+incentivenew+"','"+prepayplusold+"','"+prepayplusnew+"','"+otherold+"','"+othernew+"','"+incentiveComment+"','"+prepaypluscomment+"','"+othercomment+"')";
if(Status.equals("Pending"))
	{
		String updaterevise="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew set Status='Duplicate' where ContractorId='"+empid+"' and Month='"+month+"' and Year='"+year+"' and SrNo='"+SrNo+"'";
		stmt5.executeUpdate(updaterevise);
		
	}

String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew(Name,oldPiindex,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,PiComment,KraComment,PaidComment,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew,IncentiveComment,PreviousPayComment,OtherComment)values('"+name+"','"+oldpi+"','"+piindex+"','"+oldkra+"','"+kraindex+"','"+oldpaid+"','"+paiddays+"','"+EntryBy+"','"+formatter.format(date)+"','"+Revision+"','"+empid+"','"+month+"','"+year+"','"+picomment+"','"+kracomment+"','"+paidcomment+"','"+incentiveold+"','"+incentivenew+"','"+prepayplusold+"','"+prepayplusnew+"','"+otherold+"','"+othernew+"','"+incentiveComment+"','"+prepaypluscomment+"','"+othercomment+"')";


System.out.println("Query that insert:"+insertRevision); 





int i=0;
 i=stmt2.executeUpdate(insertRevision);
 
 
 
 if(i>0)
 {
	 System.out.println("Insertion Done");

System.out.println("Insertion Done in Revision Master");

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


double incentivenew1=Double.parseDouble(incentivenew);
double prepayplusnew1=Double.parseDouble(prepayplusnew);
double othernew1=Double.parseDouble(othernew);

double totaladd=incentivenew1+prepayplusnew1+othernew1;

//double TotalAmount=FinalPay+totaladd;

System.out.println("Total Add :- "+totaladd);

double tds=(totaladd/100)*1;


System.out.println("Tds On totaladd :- "+tds);

totaladd=totaladd-tds;

tds=TDSAmount+tds;


System.out.println("Final totaladd :- "+totaladd);

System.out.println("Amount To Pay  :- "+amttopay);

double TotalAmount=amttopay+totaladd;
	

System.out.println("TotalAmount To Pay  :- "+TotalAmount);


//String updatemaster="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary set Paiddays='"+paiddays+"', PiIndex='"+piindex+"',KraIndex='"+kraindex+"',ReviseNo='"+Revision+"',Incentive='"+incentivenew+"',PreviousPayPlus='"+prepayplusnew+"',OtherPlus='"+othernew+"' where Id='"+empid+"' and Month='"+month+"' and Year='"+year+"'"; 



/* String updatemaster="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew set Paiddays='"+paiddays+"', TDSAmount='"+df.format(tds)+"',AmountToPay='"+df.format(TotalAmount)+"',PiIndex='"+piindex+"',KraIndex='"+kraindex+"',ReviseNo='"+Revision+"',Incentive='"+incentivenew+"',PreviousPayPlus='"+prepayplusnew+"',OtherPlus='"+othernew+"',ReviseNo='"+version2+"' where Id='"+empid+"' and Month='"+month+"' and Year='"+year+"'";



System.out.println("----->"+updatemaster); */

 int j=0;
 
 //j=stmt3.executeUpdate(updatemaster);
 
 //String udpateindex="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"IndexMasterNew set PerformanceIndex='"+piindex+"',PerformanceKRAIndex='"+kraindex+"' where EmpId='"+empid+"' and Month='"+month+"' and Year='"+year+"'";
 //stmt4.executeUpdate(udpateindex);
 %>
 	<input type="hidden" name="month" id="month" value=<%=month %>>
 	<input type="hidden" name="year" id="year" value=<%=year %>>
 
 <% 
 System.out.println("Insertion Done In Master Table");
	out.println("<script>  Redirect();</script>");

		/* out.println("<script type=\"text/javascript\">");
		//   out.println("swal('Revision ','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		//   out.println("location='PayRollReport2.jsp?&month="+month+"&year="+year+"");
		   out.println("</script>"); */
		   
 if(j>0)
 {
	 
	 
 }
 
 }
 
 



%>


</body>
</html>