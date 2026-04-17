<%@page import="java.util.Date"%>
<%@ page language="java"%>
<%@page import="com.ConnectionClass"%> 
<%@ page language="java" import="java.sql.*" import=" java.text.*"
	import=" java.util.*" errorPage=""%>
<%

System.out.println("CONTROL INSIDE AJAX OF HODID--2222222222222222222------->>");
Connection conn=null;
Statement st2=null;
ConnectionClass connection= new ConnectionClass();

try
{
		conn = connection.getConnect("db_leaveapplication");
		 st2=conn.createStatement();
		
	String deptid="-",hodid="-",unamemailid="",sunday="false";
	String NoDaysApplied=request.getParameter("NoDaysApplied");
	String reporting_date=request.getParameter("v2");
	System.out.println("-------reporting_date-->>"+reporting_date);
	System.out.println("-------NoDaysApplied-->>"+NoDaysApplied);
	System.out.println("-------reporting_date-->>"+reporting_date);
	
	Date  leaveendDate=null;
	try{
	DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
	 leaveendDate = df.parse(reporting_date);
	}catch(Exception e22)
	{
		System.out.println("-------exception in formatting date -->>"+e22);	
	}
	
	System.out.println("-------NoDaysApplied--****************>>"+NoDaysApplied);
	
	if(NoDaysApplied.equalsIgnoreCase("0.5"))
	{
		NoDaysApplied="0";
		
	}
	
	double NoDaysApplied1=Double.parseDouble(NoDaysApplied);
	System.out.println("-------NoDaysApplied1 int vALUEEEEEEEE-->>"+NoDaysApplied1);
	
	try{
	if(NoDaysApplied.contains(".5"))
	{
		System.out.println("---1111---->>"+Integer.parseInt(NoDaysApplied));
		
		NoDaysApplied1=(int)(Integer.parseInt(NoDaysApplied));		
	}else{
		System.out.println("---2222---->>");
		NoDaysApplied1=(Integer.parseInt(NoDaysApplied));		
	}
	
	}catch(Exception e23)
	{
		e23.printStackTrace();		
	}
	System.out.println("-------NoDaysApplied1-&&&&&&&&&&&&->>"+NoDaysApplied1);
	
	Calendar now = Calendar.getInstance();
	now.setTime(leaveendDate); 
	now.add(Calendar.DAY_OF_MONTH, ((int)NoDaysApplied1));
	  System.out.println("NEWWWWW dateeeeee===>"+now.getTime());
	 String  dtupdtrepr= new SimpleDateFormat("dd-MMM-yyyy").format(now.getTime());
	String currentdate=  new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	 System.out.println("dtupdtrepr=========>"+dtupdtrepr);
	 SimpleDateFormat df1 = new SimpleDateFormat("dd-MMM-yyyy");  
	    java.util.Date date = df1.parse(dtupdtrepr);   
	    df1.applyPattern( "EEE" );  
	    String day= df1.format( date ); 
	    if(day.compareTo("Sun")==0)
	    {
	        System.out.println(day+": Weekend");
	        sunday="false";
	    
	        Calendar c = Calendar.getInstance();
	        c.setTime(date);
	        c.add(Calendar.DATE, 1);
	        Date newDate = c.getTime();

	        System.out.println(" NEW DATE+++>"+newDate);
	        
	         dtupdtrepr= new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
	         System.out.println("dtupdtrepr====NEW**** AFTER SUNDAY=====>"+dtupdtrepr);
	        
	    }
	 
	 int datediff1=0;
	 String datediff=" select datediff('"+currentdate+"','"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(dtupdtrepr)) +"') as DateDiff";
	 ResultSet rst=st2.executeQuery(datediff);
	 System.out.println("datediff====**=====>"+datediff);
	 if(rst.next())
	 {
		 datediff1=rst.getInt("DateDiff");
	 }
	 System.out.println("datediff1======***********===>"+datediff1);
	 
	 String reject="-";
	 if(reporting_date.equals(dtupdtrepr) && sunday.equalsIgnoreCase("false"))
	 {
		 System.out.println("INside Halfday***");
		 if(datediff1 > 3)
		 {
			 reject="yes"; 
		 }
		 
	 }else
	 {
	 
		 if(datediff1 > 2)
		 {
			 reject="yes"; 
			 
			 
		 }
	 }
	 
	 String buffer="#";
	System.out.println("-------hodid->>"+hodid);
	System.out.println("-------unamemailid->>"+unamemailid);
	if(reject!="-")
	{
		
		out.print(dtupdtrepr+"#"+reject);
	}else{
		
		out.print(dtupdtrepr+"#");
		
	}

	System.out.println("--------->>"+buffer);
}
catch(Exception e)
{
	System.out.println("Excepton---AjxChkInOutDept--->>"+e);
}
%>