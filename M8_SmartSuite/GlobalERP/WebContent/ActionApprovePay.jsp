<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<script>
/* function Redirect()
{
	var mon=document.getElementById('mon').value;
	var Year=document.getElementById('Year').value;
	
	var fromaction=document.getElementById('fromaction').value;

	
	alert(" Approved Successfully ");
	
	location.assign("ActionReviseApproval.jsp?month="+mon+"&year="+Year+"");


   // window.location="RevisePayReport.jsp";
	
} */
function Redirect() {
    var monObj = document.getElementById('mon');
    var yearObj = document.getElementById('Year');

    if (monObj && yearObj) {
        var mon = monObj.value;
        var Year = yearObj.value;
        alert(" Approved Successfully ");
        location.assign("ActionReviseApproval.jsp?month=" + mon + "&year=" + Year);
    } else {
        // Fallback if elements aren't found for some reason
        window.location = "RevisePayApproval.jsp";
    }
}
function Redirect1()
{
	alert("Rejected Successfully");
    window.location="RevisePayApproval.jsp";
	
}
function Redirect3()
{
	alert("Reclaculation is Unsuccessfull");
    window.location="RevisePayApproval.jsp";
	
}function Redirect2()
{
	alert("Approval is Unsuccessfull");
    window.location="RevisePayApproval.jsp";
	
}
</script>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
try
{

Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//con = DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/dotproject","erp","1@erp");
Statement stmt=null,stmtc=null,stgroup=null,st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,local1=null;
 Statement st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null,st15=null,st16=null,st17=null,local2=null,local3=null,local4=null;
st1=con.createStatement();
st2=con.createStatement();
st3=con.createStatement();
st4=con.createStatement();
st5=con.createStatement();
st6=con.createStatement();
int k=0;

Statement stmt1 = con.createStatement();
Statement stmt2= con.createStatement();

String problem="",Description="",progess="",taskid="";
int j=0;
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
StringBuffer buffer=new StringBuffer(","); 


/* 
String id=request.getParameter("net_id1");
System.out.println(">>>>>>>>id:"+id);  */

String action="approve";
System.out.println(">>>>>>>>Action:"+action);

String mon=request.getParameter("Month");

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

String Year=request.getParameter("Year");

System.out.println(">>>>>>>>Year:"+Year);

%>

<input type="hidden" name="mon" id="mon" value="<%=finmon %>">
<input type="hidden" name="Year" id="Year" value="<%=Year %>">
<input type="hidden" name="fromaction" id="fromaction" value="yes">


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
%>

<% 
int len=Integer.parseInt(request.getParameter("checkedNumber").toString());
System.out.println("len::"+len);
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));
while( j!=(Integer.parseInt(request.getParameter("checkedNumber").toString())))
{
if(request.getParameter("check"+j)!=null)
buffer.append(j+",");
	j++;
}

String newPiindex="",newKraIndex="",newPaiddays="",IncentiveNew="",PreviousNew="",Othernew="";

int ft=0;

String id="";

String Name="";
String oldPiindex="",newPiindex1="";
String oldKraindex="";
String oldPaiddays="";
String EntryBy="";
String EntryDate="";
String Revision="";
String ContractorId="";
String Month="";

String IncentiveOld="";
String PreviousOld="";
String OtherOld="";

int Revision1=0;

try
{
for(int h=0;h < len;h++)
{


if(buffer.toString().contains(","+k+","))
{

	newPiindex=request.getParameter("newPiindex"+k) ;
	System.out.println("newPiindex::"+newPiindex);

	 id=request.getParameter("net_id1"+k);
	 System.out.println("id::"+id);

	 


	 newPaiddays=request.getParameter("newPaiddays"+k);
	 System.out.println("newPaiddays::"+newPaiddays);


	 IncentiveNew=request.getParameter("IncentiveNew"+k);
	 System.out.println("IncentiveNew::"+IncentiveNew);


	 PreviousNew=request.getParameter("PreviousNew"+k);
	 System.out.println("PreviousNew::"+PreviousNew);

	 
	 Othernew=request.getParameter("Othernew"+k);
	 System.out.println("Othernew::"+Othernew);

	 newKraIndex=request.getParameter("newKraIndex"+k);
	 System.out.println("newKraIndex::"+newKraIndex);


			
			if(action.equals("approve"))
			{
String sql_total="select Name,oldPiindex,Revision,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where Month='"+mon+"' and Year='"+Year+"' and Status='Pending' and ContractorId='"+id+"'";
System.out.println(">>>>>>>>sql_total:"+sql_total);

ResultSet rs = st4.executeQuery(sql_total);
if(rs.next()){
	

	
	
	Name=rs.getString("Name");
	 System.out.println("Name::"+Name);
	 
	 newPiindex1=rs.getString("newPiindex");
	 System.out.println("newPiindex11::"+newPiindex1);

	oldPiindex=rs.getString("oldPiindex");
	 System.out.println("oldPiindex::"+oldPiindex);

	oldKraindex=rs.getString("oldKraindex");
	 System.out.println("oldKraindex::"+oldKraindex);

	oldPaiddays=rs.getString("oldPaiddays");
	 System.out.println("oldPaiddays::"+oldPaiddays);

	EntryBy=rs.getString("EntryBy");
	 System.out.println("EntryBy::"+EntryBy);

	ContractorId=rs.getString("ContractorId");
	 System.out.println("ContractorId::"+ContractorId);

	Month=rs.getString("Month");
	 System.out.println("Month::"+Month);

	Year=rs.getString("Year");
	 System.out.println("Year::"+Year);

	IncentiveOld=rs.getString("IncentiveOld");
	 System.out.println("IncentiveOld::"+IncentiveOld);


	PreviousOld=rs.getString("PreviousOld");
	 System.out.println("PreviousOld::"+PreviousOld);


	OtherOld=rs.getString("OtherOld");
	 System.out.println("OtherOld::"+OtherOld);


	Revision1=rs.getInt("Revision");
	 System.out.println("Revision1::"+Revision1);

	Revision1=Revision1+1;

	
	
                }

String updatemaster="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew set Paiddays='"+newPaiddays+"', PiIndex='"+newPiindex+"',KraIndex='"+newKraIndex+"',ReviseNo='"+Revision1+"',Incentive='"+IncentiveNew+"',PreviousPayPlus='"+PreviousNew+"',OtherPlus='"+Othernew+"'  where Id='"+id+"'  and Month='"+mon+"' and Year='"+Year+"'";


stmt1.executeUpdate(updatemaster);

System.out.println("----->"+updatemaster);




String approve="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew set Status='Duplicate' where Status='Pending' and ContractorId='"+id+"' and Month='"+mon+"' and Year='"+Year+"' ";

System.out.println("approve  val "+approve);

st1.executeUpdate(approve);


String insertRevision="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew(Name,Status,oldPiindex,newPiindex,oldKraindex,newKraIndex,oldPaiddays,newPaiddays,EntryBy,EntryDate,Revision,ContractorId,Month,Year,PiComment,KraComment,PaidComment,IncentiveOld,IncentiveNew,PreviousOld,PreviousNew,OtherOld,Othernew,IncentiveComment,PreviousPayComment,OtherComment)values('"+Name+"','Approved','"+oldPiindex+"','"+newPiindex+"','"+oldKraindex+"','"+newKraIndex+"','"+oldPaiddays+"','"+newPaiddays+"','"+EntryBy+"','"+formatter.format(date)+"','"+Revision1+"','"+id+"','"+Month+"','"+Year+"','Auto Comment','Auto Comment','Auto Comment','"+IncentiveOld+"','"+IncentiveNew+"','"+PreviousOld+"','"+PreviousNew+"','"+OtherOld+"','"+Othernew+"','Auto Comment','Auto Comment','Auto Comment')";

System.out.println("inser  val "+insertRevision);
st5.executeUpdate(insertRevision);
String fromaction="yes";
%>

<%

try{
 
 Format frt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 Format frt1=new SimpleDateFormat("yyyy-MM-dd");
 Format frt2=new SimpleDateFormat("HH:mm:ss"); 

String month=request.getParameter("Month");
String year=request.getParameter("Year");



String mon1=month;
if(mon1.equalsIgnoreCase("JAN"))
{
	mon1="01";
}else if(mon1.equalsIgnoreCase("FEB"))
{
	mon1="02";
}else if(mon1.equalsIgnoreCase("MAR"))
{
	mon1="03";
}
else if(mon1.equalsIgnoreCase("APR"))
{
	mon1="04";
}
else if(mon1.equalsIgnoreCase("MAY"))
{
	mon1="05";
}
else if(mon1.equalsIgnoreCase("JUN"))
{
	mon1="06";
}
else if(mon1.equalsIgnoreCase("JUL"))
{
	mon1="07";
}
else if(mon1.equalsIgnoreCase("AUG"))
{
	mon1="08";
}
else if(mon1.equalsIgnoreCase("SEP"))
{
	mon1="09";
}
else if(mon1.equalsIgnoreCase("OCT"))
{
	mon1="10";
}
else if(mon1.equalsIgnoreCase("NOV"))
{
	mon1="11";
}
else if(mon1.equalsIgnoreCase("DEC"))
{
	mon1="12";
}


System.out.println("Month is"+month+"Year is"+year);



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

String daydata="select DATE_FORMAT(DATE('"+year+"-"+mon1+"-01'),'%Y-%m-01') as First,LAST_DAY('"+year+"-"+mon1+"-01') as Last,NOW() As Today";
  
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
	
	double Allowances=0.00,PhysicalPresent=0.00;
	
 EntryBy=session.getAttribute("EmpName").toString();

int EmpId=0;
String Department="",Reason="",EnrtyDate="";


SimpleDateFormat fr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  


String abc=",";

String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId in ('"+id+"') ";

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
		PhysicalPresent=rs4.getDouble("PhysicalPresent");
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
		PhysicalPresent=0.00;
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
		
		if((PhysicalPresent >=24))
		{
			
			System.out.println("Technician Present Day  :"+present1);
			
		FixedSalary=1800;
		
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
	
	
	
int SrNo=0;
String Status="";
	SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
	Date date1 = new Date();  
	System.out.println(formatter1.format(date1));
	
	
}


	 
	 System.out.println("Re-Calculation Done");
	 
		


}catch(Exception e)
{
	
	out.println("<script>  Redirect3();</script>");
	
	
}










			}
			
			else
			{
				

		    	String reject="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew set Status='Rejected' where Status='Pending' and ContractorId="+id+" and Month='"+mon+"' and Year='"+Year+"' ";
		    	
		    	System.out.println("reject  val "+reject);
		    	
		    	
		    	st2.executeUpdate(reject);
		    	
				out.println("<script>  Redirect1();</script>");
			
				
			}

}


k++;





}
}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect2();</script>");
}
out.println("<script>  Redirect();</script>");



}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect2();</script>");
} 

%>




