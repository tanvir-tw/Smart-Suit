             

	
<%@page import="java.util.StringTokenizer"  import="java.sql.*"%>
<%@ include file="header.jsp"%>
	<%@page import="java.util.Date"%>
	 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
<html >
<head>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 







<body>


<%!
Connection con1;


%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con1.createStatement();

Statement st2=con1.createStatement();
ResultSet rs=null;

Statement st12=con1.createStatement();

Statement st13=con1.createStatement();

Statement st14=con1.createStatement();


%>








<%


String dept=session.getAttribute("department").toString();

System.out.println("---->"+dept);

String logname=session.getAttribute("EmpName").toString();
System.out.println("Login Name:"+logname);

String Category=request.getParameter("type");

System.out.println("Category:"+Category);



if(Category.equals("Travel"))
{
String origin[]=request.getParameterValues("origin");
String dest[]=request.getParameterValues("destination");
String typeofexpense[]=request.getParameterValues("TypeOfExpense");
String amount[]=request.getParameterValues("amount");

String mode[]=request.getParameterValues("mode");


//For TypeOfExpense Detail Amount Value

String dAmt[]=new String[amount.length];
double d[]=new double[amount.length];

for(int j=0;j<amount.length;j++)
{
	d[j]=Double.parseDouble(amount[j]);
	
	//System.out.println("Value is:"+d[j]);
	
	dAmt[j]=new DecimalFormat("0.00").format(d[j]);
	
	System.out.println("Expense values:"+dAmt[j]);
	
	
}


//For AdvanceMoneyMaster Amount Value
double total=0.0;
double dmt[]=new double[amount.length];
for(int i=0;i<dAmt.length;i++)
{
	dmt[i]=Double.parseDouble(dAmt[i]);
	
	total+=dmt[i];
	
	
}
System.out.println("ToTal Amount is:"+total);
String finalAmt=new DecimalFormat("0.00").format(total);


System.out.println("Final Amount:"+finalAmt);



/*  for(int i=0;i<origin.length;i++)
{
	


	
	 System.out.println("Origin:"+origin[i]);
	System.out.println("Destination:"+dest[i]);
	System.out.println("TypeOfexpense:"+typeofexpense[i]);
	System.out.println("Amount:"+amount[i]);
	
	
	
	System.out.println("mode:"+mode[i]); 
	
	
	
	} 

 */

 
 

 
 

 int count=0;
String sup=request.getParameter("supplier");
System.out.println("Customers ARE>>>>>:"+sup);

String cname=sup.replaceAll(" ", "");

System.out.println("Removing space:"+sup.replaceAll(" ", ""));

System.out.println(cname.replaceFirst("(?:,)+", ""));


String customerName=cname.replaceFirst("(?:,)+", "");

StringTokenizer singlesup=new StringTokenizer(sup, ",");
count=singlesup.countTokens();


String noofperson=request.getParameter("pTravel");
String purpose=request.getParameter("purpose");
String CostCenter=request.getParameter("costcenter");
String date1=request.getParameter("data");
String date2=request.getParameter("data1");
String comments=request.getParameter("comments");






String formd1= new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
        .parse(date1));


String formd2= new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
        .parse(date2));











System.out.println("Date1:"+formd1);
System.out.println("Date2"+formd2);
System.out.println("No of person:"+noofperson);
System.out.println("Purpose:"+purpose);
System.out.println("CostCenter:"+CostCenter);
System.out.println("Departure Date"+date1);
System.out.println("Return date:"+date2);
System.out.println("Purpose:"+comments);

String date=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());






String query1="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster(Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,EntryBy,DepartureDate,Returndate,EntryDate,Department)Values('"+Category+"','"+noofperson+"','"+CostCenter+"','"+finalAmt+"','"+purpose+"','"+customerName+"','"+logname+"','"+formd1+"','"+formd2+"','"+date+"','"+dept+"')";


int i=st2.executeUpdate(query1);



Statement st4=con1.createStatement();
Statement st3=con1.createStatement();
String srno11="select * from "+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster order by AdvanceId desc limit 1";
ResultSet rssrno11=st3.executeQuery(srno11);
int srno123=0;

if(rssrno11.next())
{
	srno123=rssrno11.getInt("AdvanceID");
	
	 for(int j=0;j<amount.length;j++)
	{
		String expensedetail="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceExpenseDetail(TypeOfExpense,Mode,origin,Destination,Amount,AdvanceId) values('"+typeofexpense[j]+"','"+mode[j]+"','"+origin[j]+"','"+dest[j]+"','"+dAmt[j]+"','"+srno123+"') ";
	
		int k=st4.executeUpdate(expensedetail);
		
	} 
}

else
{
	srno123=1;
}


//AdvanceClaimMasterHistory
String hquery="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMasterHistory(Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,EntryBy,DepartureDate,Returndate,EntryDate,AdvanceMasterId,Department) Values('"+Category+"','"+noofperson+"','"+CostCenter+"','"+finalAmt+"','"+purpose+"','"+customerName+"','"+logname+"','"+formd1+"','"+formd2+"','"+date+"','"+srno123+"','"+dept+"')";

int j=st2.executeUpdate(hquery);

if((i>0)&&(j>0))
{
	System.out.println("Insertion Done");
	
	
	
	 out.println("<script type=\"text/javascript\">");
	   out.println("swal('Data Inserted  ','','success');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='AdvanceClaimReport.jsp';");
	   out.println("</script>");
	
	
}

  
}


else
{
	
	String Amount=request.getParameter("amount1");
	String purpose=request.getParameter("purpose1");
	String date=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
	
	System.out.println("Category:"+Category);	
	System.out.println("date:"+date);
	System.out.println("Purpose:"+purpose);
	System.out.println("logname:"+logname);
	
	Double	Amount1=Double.parseDouble(Amount);
	
	String finalAmt=new DecimalFormat("0.00").format(Amount1);
	
	System.out.println("Amount value:"+finalAmt);
	
	
	
	String query1="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster(Category,Amount,Purpose,EntryBy,EntryDate,Department)values('"+Category+"','"+finalAmt+"','"+purpose+"','"+logname+"','"+date+"','"+dept+"')";
	
	System.out.println("Query is:"+query1);
	
	
	int i=0;
	i=st12.executeUpdate(query1);
	
	/* if(i>0)
	{
		System.out.println("Insertion Done");
	}
	 */
	 String srno="";
	 String srno11="select * from "+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster order by AdvanceId desc limit 1";
	 
	 ResultSet rs2=st14.executeQuery(srno11);
	 
	 if(rs2.next())
	 {
		 srno=rs2.getString("AdvanceID");
	 }
	 
	
	String query2="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMasterHistory(Category,Amount,Purpose,EntryBy,EntryDate,Department,AdvanceMasterId)values('"+Category+"','"+finalAmt+"','"+purpose+"','"+logname+"','"+date+"','"+dept+"','"+srno+"')";
	
	int j=0;
	j=st13.executeUpdate(query2);
	
/* 	if(j>0)
	{
		System.out.println("Insertion Done");
		
	}
	 */
	
	
	if((i>0)&&(j>0))
	{
		System.out.println("Insertion Done");
		
		
		
		 out.println("<script type=\"text/javascript\">");
		   out.println("swal('Data Inserted ','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='AdvanceClaimReport.jsp';");
		   out.println("</script>");
		
		
	}
	
	
	
}


%>


</jsp:useBean>
</body>
</html>
<%@ include file="footer_new.jsp"%>
<%-- <%@ include file="footernew.jsp"%> --%>