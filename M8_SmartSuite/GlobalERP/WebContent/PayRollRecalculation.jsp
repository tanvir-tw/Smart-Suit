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
try{
 Statement stmt=null,stmtc=null,stgroup=null,st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,local1=null;
 Statement st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null,st15=null,st16=null,st17=null,local2=null,local3=null,local4=null;
 Format frt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 Format frt1=new SimpleDateFormat("yyyy-MM-dd");
 Format frt2=new SimpleDateFormat("HH:mm:ss"); 

String month=request.getParameter("month");
String year=request.getParameter("Year");

String[] chk=request.getParameterValues("chkbx");

String mon=month;
if(mon.equalsIgnoreCase("JAN"))
{
	mon="01";
}else if(mon.equalsIgnoreCase("FEB"))
{
	mon="02";
}else if(mon.equalsIgnoreCase("MAR"))
{
	mon="03";
}
else if(mon.equalsIgnoreCase("APR"))
{
	mon="04";
}
else if(mon.equalsIgnoreCase("MAY"))
{
	mon="05";
}
else if(mon.equalsIgnoreCase("JUN"))
{
	mon="06";
}
else if(mon.equalsIgnoreCase("JUL"))
{
	mon="07";
}
else if(mon.equalsIgnoreCase("AUG"))
{
	mon="08";
}
else if(mon.equalsIgnoreCase("SEP"))
{
	mon="09";
}
else if(mon.equalsIgnoreCase("OCT"))
{
	mon="10";
}
else if(mon.equalsIgnoreCase("NOV"))
{
	mon="11";
}


else if(mon.equalsIgnoreCase("DEC"))
{
	mon="12";
}


System.out.println("Month is"+month+"Year is"+year);



Connection con=null;

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);



Statement local=con.createStatement();

stgroup=con.createStatement();
st=con.createStatement();
st1=con.createStatement();
st2=con.createStatement();
st3=con.createStatement();
st4=con.createStatement();
st5=con.createStatement();
st6=con.createStatement();
st7=con.createStatement();
st8=con.createStatement();
st9=con.createStatement();
st10=con.createStatement();
st11=con.createStatement();
st12=con.createStatement();
st13=con.createStatement();
st14=con.createStatement();
st15=con.createStatement();
st16=con.createStatement();
st17=con.createStatement();
local1=con.createStatement();
local2=con.createStatement();
local3=con.createStatement();
local4=con.createStatement();



DecimalFormat df = new DecimalFormat("0.00");

String daydata="select DATE_FORMAT(DATE('"+year+"-"+mon+"-01'),'%Y-%m-01') as First,LAST_DAY('"+year+"-"+mon+"-01') as Last,NOW() As Today";
  
System.out.println("daydata Day:- " + daydata);

  ResultSet rsdaydata=st.executeQuery(daydata);
  
  String FirstDay="",LastDay="" ,today1="";
 
  if(rsdaydata.next())
  {
	  FirstDay=rsdaydata.getString("First");
	  LastDay=rsdaydata.getString("Last");
	  today1=rsdaydata.getString("Today");
  }
  
  
  FirstDay=FirstDay+" 00:00:00";
  LastDay=LastDay+" 23:59:59";
  
 
  
  String FirstDayTime=FirstDay+" 00:00:00";
  String LastDayTime=LastDay+" 23:59:59";
  
  
  

  System.out.println("First Day:- " + FirstDay);
  System.out.println("Last Day:- " + LastDay);

  
  String MonthName="",Year1="";
  String DayName="SELECT DAYNAME('"+LastDay+"') as DayName1,DAYOFMONTH('"+LastDay+"') as DayCnt ,MONTHNAME('"+LastDay+"') as MonthName,YEAR('"+LastDay+"') as Year";
	ResultSet rsDayName=st2.executeQuery(DayName);
	System.out.println("DayName :-"+DayName);
	String NameOfDay="";
	String Sunday="Sunday";
	String DayCnt="";
	if(rsDayName.next())
	{
		
		NameOfDay=rsDayName.getString("DayName1");
		MonthName=rsDayName.getString("MonthName");
		MonthName=MonthName.substring(0, 3);
		Year1=rsDayName.getString("Year");
		
		System.out.println("MonthName :-"+MonthName);
		
		DayCnt=rsDayName.getString("DayCnt");
		
		System.out.println("DayCnt :-"+DayCnt);
		
		System.out.println("Year  :-"+Year1);
	}
	
	String emp_id="",EmpName="",Depart="",Designation="",Basic_Salary="";
	String present="",Approvedleav="",paiddays="";
	
	double Allowances=0.00;
	
String EntryBy=session.getAttribute("EmpName").toString();

int EmpId=0;
String Department="",Reason="",EnrtyDate="";


SimpleDateFormat fr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
Date date = new Date();  
System.out.println(fr.format(date));

String abc=",";


for(String empcheck:chk)
{
	
System.out.println("check emp id:"+empcheck);
	
	
	abc=abc+"'"+empcheck+"'"+",";
	
	int payversion=0;
	
	
	
	
	
}

System.out.println("Employee id are:"+abc);
abc=abc.substring(1, abc.length());
int index=abc.lastIndexOf(',');
String id123=abc.substring(0, index);
System.out.println(index);
System.out.println("after removing comma"+id123);

 
String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId in ("+id123+") ";

//String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId in ('2082')";



ResultSet rs1=st1.executeQuery(empdetails);
System.out.println("Query is:"+empdetails);
int i=1;


while(rs1.next())
{
  	System.out.println("Inside while");
	//emp_id=rs1.getString("ContractorId");
	//EmpName=rs1.getString("ContractorName");
	
	emp_id=rs1.getString("ContractorId");
	EmpName=rs1.getString("ContractorName");
	
	  String techattenddata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+emp_id+"'";
	  ResultSet rstechattenddata=st15.executeQuery(techattenddata);
	  if(rstechattenddata.next())
	  {
		  Depart=rstechattenddata.getString("Department");
		  Designation=rstechattenddata.getString("Designation");
	  }
	
	double krasalary=0.00,basisSalary=0.00,FixedSalary=0.00,vehilcelAllw=0.00,Mobile=0.00,Laptop=0.00,Rent=0.00,other=0.00,tds=0.00;
	String nav="";
	

	
	
	String cmaster="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster where ContractorId='"+emp_id+"'  ";
	
	ResultSet rs9=st9.executeQuery(cmaster);
	
	if(rs9.next())
	{
		//nav=rs9.getString("EmpName");
		krasalary=rs9.getDouble("KRAFee");
		basisSalary=rs9.getDouble("PIFee");
		FixedSalary=rs9.getDouble("FixedFee");
		vehilcelAllw=rs9.getDouble("VehicleAllowance");
		Mobile=rs9.getDouble("MobileAllowance");
		Laptop=rs9.getDouble("LaptopAllowance");
		Rent=rs9.getDouble("ProximityAllowance");
		other=rs9.getDouble("OtherAllowance");
		tds=rs9.getDouble("TDSPercent");
	}
	
	
	System.out.println("data from contractor master");
	System.out.println(nav);
	System.out.println(krasalary);
	System.out.println(basisSalary);
	System.out.println(vehilcelAllw);
	System.out.println(Mobile);
	System.out.println(Laptop);
	System.out.println(Rent);
	System.out.println(other);
	System.out.println(tds);
	
	
	String piIndex="",KraIndex="";
	double Incentive=0.00;
	
	double PreviousPayPlus=0.00;
	
	double OtherPlus=0.00;
	
	double TotalPayAddtion =0.00;
	
	
	 //String attendances="select ID,Name,Present,ApprovedLeave,Paiddays from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where ID='"+emp_id+"' and Month='"+MonthName+"' and Year='"+Year1+"'";
	 
	 String attendances="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where ID='"+emp_id+"' and Month='"+month+"' and Year='"+year+"' order by ReviseNo desc limit 1";
		
	 System.out.println("Attendance data"+attendances);
	 ResultSet rs4=st4.executeQuery(attendances);
	if(rs4.next())
	{
		present=rs4.getString("Present");
		Approvedleav=rs4.getString("ApprovedLeave");
		paiddays=rs4.getString("Paiddays");
		
		if(paiddays.equals("-"))
		{
			paiddays="0.00";
		}
		
		piIndex=rs4.getString("PiIndex");
		KraIndex=rs4.getString("KraIndex");

		 Incentive=rs4.getDouble("Incentive");
		
		 PreviousPayPlus=rs4.getDouble("PreviousPayPlus");
		
		 OtherPlus=rs4.getDouble("OtherPlus");
		
		 TotalPayAddtion =Incentive+PreviousPayPlus+OtherPlus;
		
		
		
		
	}
	else
	{
		present="0.0";
		Approvedleav="0.00";
		//paiddays="0.00";
	}
	
	
	
	
	
	
		
	
	System.out.println("PI  Index :"+piIndex);
	
	System.out.println("KRA  Index :"+KraIndex);
	
	
	System.out.println("Paiddays Count:"+paiddays);
	
	System.out.println("Incentive :"+Incentive);
	
	System.out.println("PreviousPayPlus :"+PreviousPayPlus);
	
	System.out.println("OtherPlus :"+OtherPlus);
	
	
	int dCount=Integer.parseInt(DayCnt);
	double pday=Double.parseDouble(paiddays);
	
	
	System.out.println(pday);

	System.out.println("basisSalary :"+basisSalary);
	
	System.out.println("dCount :"+dCount);
	
	
	double piamount=0.00;					
									
	double kraindex1=Double.parseDouble(KraIndex);
	
	double piIndex1=Double.parseDouble(piIndex);
	
	System.out.println("piIndex1piIndex1piIndex1piIndex1  in else  :"+piIndex1);
	
	
	// To calculate PI AMOUNT
	
	if(piIndex1>0)
  {
	if(piIndex1>=90)
	{
		piamount=(basisSalary/dCount)*pday;
		
		piamount=(piamount/100)*100;	
		
		System.out.println("piamount in if :"+piamount);
	}
	else
     {
		
			piamount=(basisSalary/dCount)*pday;
			piamount=(piamount/100)*piIndex1;
			
			System.out.println("piamount in else  :"+piamount);
		
	  }
	
	}
	
	
	double kraamount=0.00;
	
	//To calculate KRA INDEX
	if(kraindex1>0)
	{
		if(kraindex1 > 100)
		{
			kraamount=(krasalary/100)*100;
		}
		else
		{
	    	kraamount=(krasalary/100)*kraindex1;
		}
		
	}
	
	
	
	System.out.println("piamount :"+piamount);
	
	System.out.println("kraamount :"+kraamount);
	
	
	
	double Advance=0.00,Sd=0.00,previouspay=0.00,mobile=0.00,other1=0.00;
	double VehicleAllowance=0.00,LaptopAllowance=0.00,MobileAllowance=0.00;
	double present1=0.00;
	String otherReason="-";
	

	
	
	vehilcelAllw=(vehilcelAllw/dCount)*pday;
	Mobile=(Mobile/dCount)*pday;
	
	
	Laptop=(Laptop/dCount)*pday;
	
	System.out.println("Laptop:"+Laptop);

	System.out.println("Present Day :"+pday);
	
	
	Rent=(Rent/dCount)*pday;
	
	
	
	double totalallowances=vehilcelAllw+Mobile+Laptop+Rent+other;
	
	
	
	double totalamount=piamount+kraamount;
	
	double TotalDeduction=rs4.getDouble("TotalDeduction");
	
	//double TotalDeductiontds=(TotalDeduction/100)*1;

	double totaldeduction1=TotalDeduction;

	
	
	//double TotalPayAddtiontds=(TotalPayAddtion/100)*1;
	
	//System.out.println("TotalPayAddtiontds :"+TotalPayAddtiontds);
	
	
	
	System.out.println("FixedSalary :"+FixedSalary);
	
	FixedSalary=(FixedSalary/dCount)*pday;

	System.out.println("FixedSalary After :"+FixedSalary);
	
	present1=Double.parseDouble(present);
	
	if(Designation.equals("Technician"))
	{
		FixedSalary=0.00;
		
		if((present1 >=24))
		{
			
			System.out.println("Technician Present Day  :"+present1);
			
		FixedSalary=present1*75;
		
		System.out.println("Technician FixedSalary After :"+FixedSalary);
		
		totalamount=totalamount+totalallowances+FixedSalary;
		}
		else
		{
			totalamount=totalamount+totalallowances;
		}
	}
	else
	{
		System.out.println("in else ");
		
		System.out.println("Total Amount  Before  :"+totalamount);
		
		System.out.println(" totalallowances   :"+totalallowances);
		
		System.out.println("Total Amount  FixedSalary  :"+FixedSalary);
		
		totalamount=totalamount+totalallowances+FixedSalary;
	}
	
	System.out.println(" totalallowances   :"+totalallowances);
	
	System.out.println("Total PayAddtion  :"+TotalPayAddtion);
	
	System.out.println("TotalDeduction   :"+TotalDeduction);
	
	
	
	totalamount=totalamount+TotalPayAddtion;
	
	System.out.println("Total Amount  Before Tds :"+totalamount);
	
	double tdsamount=(totalamount/100)*tds;
	
	System.out.println("Total Amount  TDS :"+tdsamount);
	
	totalamount=totalamount-tdsamount;
	
	double FinalPay=0.00;
	
	FinalPay=totalamount;
	
	System.out.println("Total Amount After TSD Cut   :"+totalamount);
	
	totalamount=totalamount-totaldeduction1;
	
	//System.out.println("totaldeduction1 :----   :"+totaldeduction1);
	
	
	
	//totalamount=totalamount+TotalPayAddtion-totaldeduction1;
	
	System.out.println("Total Amount  :"+totalamount);
	
	
	
		    		
	
	
	/*double tdsamount=(totalamount/100)*tds;
	
	totalamount=totalamount-tdsamount;*/
	
	
	//double totalallowances=vehilcelAllw+Mobile+Laptop+Rent+other;
	
	String amounttopay="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew set MobileAllowance='"+df.format(Mobile)+"',VehicleAllowance='"+df.format(vehilcelAllw)+"',RentAllowance='"+df.format(Rent)+"',LaptopAllowance='"+df.format(Laptop)+"',AmountToPay='"+df.format(totalamount)+"',PiAmount='"+df.format(piamount)+"',KraAmount='"+df.format(kraamount)+"',FinalPay='"+df.format(FinalPay)+"',Incentive='"+df.format(Incentive)+"',PreviousPayPlus='"+df.format(PreviousPayPlus)+"',OtherPlus='"+df.format(OtherPlus)+"',TotalDeduction='"+df.format(totaldeduction1)+"',TDSAmount='"+df.format(tdsamount)+"' where ID='"+emp_id+"'and Month='"+month+"'and Year='"+year+"'";
	
	int k12=0;
	k12=local4.executeUpdate(amounttopay); 
	System.out.println(k12);
	System.out.println(amounttopay);
	
	
	System.out.println("query to update amountToPay final:"+amounttopay);
	
	
	int Revision=0;
	double oldPaiddays=0.00;
	double oldPiindex=0.00;
	double oldKraindex=0.00;
	double IncentiveOld=0.00;
	double PreviousOld=0.00;
	double OtherOld=0.00;
int SrNo=0;
String Status="";
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
	Date date1 = new Date();  
	System.out.println(formatter.format(date1));
	String revisioncount="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where ContractorId='"+emp_id+"' and Month='"+month+"' and Year='"+year+"' order by Revision DESC limit 1";

	ResultSet rs1234=st17.executeQuery(revisioncount);
	if(rs1234.next())
	{
		SrNo=rs1234.getInt("SrNo");
		Status=rs1234.getString("Status");
		Revision=rs1234.getInt("Revision");
		oldPaiddays=rs1234.getDouble("oldPaiddays");
		oldPiindex=rs1234.getDouble("oldPiindex");
		oldKraindex=rs1234.getDouble("oldKraindex");
		IncentiveOld=rs1234.getDouble("IncentiveOld");
		PreviousOld=rs1234.getDouble("PreviousOld");
		OtherOld=rs1234.getDouble("OtherOld");
		Revision=Revision+1;
	}
	else
	{
		Revision=1;
	}
	
	
	String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew(Name,oldPiindex,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew)values('"+EmpName+"','"+oldPiindex+"','"+piIndex1+"','"+oldKraindex+"','"+kraindex1+"','"+oldPaiddays+"','"+paiddays+"','"+EntryBy+"','"+formatter.format(date1)+"','"+Revision+"','"+emp_id+"','"+month+"','"+year+"','"+IncentiveOld+"','"+df.format(Incentive)+"','"+PreviousOld+"','"+df.format(PreviousPayPlus)+"','"+OtherOld+"','"+df.format(OtherPlus)+"')";
	
	System.out.println("query to insertRevision  : "+insertRevision);
	
	//local1.executeUpdate(insertRevision);
}


	 
	 System.out.println("Re-Calculation Done");
	 
		out.println("<script type=\"text/javascript\">");
		   out.println("swal('Re-Calculation ','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='PayGeneration.jsp';");
		   out.println("</script>");


}catch(Exception e)
{
	
	
	System.out.println("Re-Calculation Not Done");
	 
	out.println("<script type=\"text/javascript\">");
	   out.println("swal('Re-Calculation ','','ERROR !!');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='PayRollRecalculation.jsp';");
	   out.println("</script>");
	   
	   e.printStackTrace();
	
}








%>

</body>
</html>