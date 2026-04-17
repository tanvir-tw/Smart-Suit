<%@ page contentType="application/vnd.ms-excel; charset=gb2312"
	import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename;
	filename ="Customer_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="
			+ filename);
%>
<%@ include file="conn1.jsp"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,stDATE=null,stMaster=null,stweek=null,stweek1=null;
    try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st2 = conn.createStatement();
		st1 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
		st5 = conn.createStatement();
		stDATE=conn.createStatement();
		stMaster=conn.createStatement();
		stweek=conn.createStatement();
		stweek1=conn.createStatement();
		} catch (Exception e) {
		};
	Date today = new Date();
	Date tomorrow=new Date();
	Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	cal.setTime(today);
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	String todaysDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	  String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	cal.add(Calendar.DAY_OF_MONTH, -1);
	
	Date YesterdaysDateAsDate = cal.getTime();
	String yesterdaysDate=new SimpleDateFormat("yyyy-MM-dd").format(YesterdaysDateAsDate);
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, +1);
	Date  tomorowAsDate=cal.getTime();
	String tomoDate=new SimpleDateFormat("yyyy-MM-dd").format(tomorowAsDate);
	String tomoDateInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(tomorowAsDate);
	System.out.println(tomoDateInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	Date sevendaysbefore=new Date();
	cal.add(Calendar.DAY_OF_MONTH, -7);
	sevendaysbefore=cal.getTime();
	String sevenbefore=new SimpleDateFormat("yyyy-MM-dd").format(sevendaysbefore);
	String sevenbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sevendaysbefore);
	System.out.println(sevenbeforeInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-30);
	Date MonthAsDate=cal.getTime();
	String monthbefore=new SimpleDateFormat("yyyy-MM-dd").format(MonthAsDate);
	String monthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(MonthAsDate);
	System.out.println(monthbeforeInMMM+"())))))))))))))))))))))  ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-60);
	Date twoMonthAsDate=cal.getTime();
	String twomonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(twoMonthAsDate);
	String twomonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(twoMonthAsDate);
	System.out.println(twomonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-90);
	Date threeMonthAsDate=cal.getTime();
	String threemonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(threeMonthAsDate);
	String threemonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(threeMonthAsDate);
	System.out.println(threemonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH,-180);
	Date sixMonthAsDate=cal.getTime();
	String sixmonthbefore=new SimpleDateFormat("yyyy-MM-dd").format(sixMonthAsDate);
	String sixmonthbeforeInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(sixMonthAsDate);
	System.out.println(sixmonthbeforeInMMM+"++++++++++++++++++= ");
	
	cal.setTime(today);
	now.setTime(today);
		
	

	String yesterdaysDateInMMMFromat=new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);
	String usermail="";
	String repr="";
	StringBuffer htmlString = new StringBuffer ("");
	StringBuffer followUpData = new StringBuffer ("");
	String headerstring;
	StringBuffer tempData=new StringBuffer("");
	int k;
	int h=1;
	int masterCounter=1;
	String sqlFollowup="";		
	String fromDateCal = "", toDateCal = "", sql = "",mainCustomer="";
	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String code=request.getParameter("Code1");
	System.out.println("<><><><><><>      "+code);
	
	String mrktName="";
	String sqlMarktRep="Select MarketingRepName  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepCode='"+code+"'";
	
	ResultSet rsMrktRep=stMaster.executeQuery(sqlMarktRep);
	System.out.println(sqlMarktRep);

	while(rsMrktRep.next())
	{
		
		mrktName=rsMrktRep.getString("MarketingRepName");
	}
	
	
	
	
	String Custcount=request.getParameter("count1");
	System.out.println("***********      "+Custcount);
	
	String number=request.getParameter("number");
	System.out.println("**&&&**&*&**&*&*    "+number);
%>

<%
				Date d=new Date();
				Format df1= new SimpleDateFormat("yyyy-MM-dd");
				String dtoday=df1.format(d);
				DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
				DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
				
				Format d2= new SimpleDateFormat("HH:mm:ss");
				String incdReg=d2.format(d);
				String hrTime=incdReg.substring(0,2);
				String minTime=incdReg.substring(3,5);
				System.out.println(">>>>>>>>>>>>dtoday:"+dtoday);
				
				
				String dt1 = request.getParameter("dt1");
				System.out.println("**&&&**&*&**&*&*  date 1   " + dt1);
				String dt2 = request.getParameter("dt2");
				System.out.println("**&&&**&*&**&*&*  date 1   " + dt2);
			//========================================================
 %>
	
	
	
	
	
<table>
<tr>
<td>
	<div align="center" style="font-size: 1.8em; margin-top: 0.5em;margin-bottom: 0.5em;"><a><%= mrktName %> Customers</a>
	</div>
	</td>
	</tr>
	</table>
	
	<table align="center" border=1 class='sortable'>	
				<tr>
				  <th>Sr No</th>
				  <th>Company</th>
				  <th>Contact Person</th>
				  <th>Phone</th>
				  <th>Mobile</th>
				  <th>City</th>
				  <th>FollowUps</th>
				</tr>	
<%

int j=1;String Customer="";

ResultSet rsList=null;
/*
String fdate = new SimpleDateFormat("dd-MMM-yyyy")
.format(new SimpleDateFormat("yyyy-MM-dd")
		.parse(dt2));
String tdate = new SimpleDateFormat("dd-MMM-yyyy")
.format(new SimpleDateFormat("yyyy-MM-dd")
		.parse(dt1));
*/
	if(number.contains("1"))
	{
		System.out.println("IN    1st   IF  All Customer*********");

	    
			
		String sqlList="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  Group By ProspCustName";
			 System.out.println("1st If Query===>"+sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
			 
			 
			 
	}else if(number.contains("2"))
	{
		System.out.println("IN    2nd    IF for followup customer*********");
		
		// String sqlList="select ProspCustName,ContactPerson,Address,City from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  Group By ProspCustName";
		
		String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"
								+ code
								+ "' AND ProspCustName <> '-' AND FollowUpDate < '"
								+ dt1
								+ "' and FollowUpDate > '"
								+ dt2
								+ "' Group By ProspCustName";
		
			 System.out.println(sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
	
		
	}else if(number.contains("3"))
	{
		
		System.out.println("IN    3rd   IF*********");	
		
			String sqlList="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup Group By ProspCustName having max(NextFollowUpDate)  Between '"+dt2+"' AND '"+dt1+"' and MarketingRepcode = '"+code+"'";
			System.out.println("3rd If Qry=====>"+sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 	
	}else if(number.contains("4"))
	{
		System.out.println("IN    4th   IF*********");
		String sqlList="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  FollowUpDate = '"+yesterdaysDate+"' ";
			System.out.println(sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
	}else if(number.contains("5"))
	{
		 
		System.out.println("IN    5th   IF*********");
		
		//String sqlList="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+yesterdaysDate+"' ";
		
		String sqlList="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup Group By ProspCustName having max(NextFollowUpDate)='"+yesterdaysDate+"'  and MarketingRepcode = '"+code+"'";
			System.out.println(sqlList);	
			 rsList=st1.executeQuery(sqlList);
			
	}else if(number.contains("6"))
	{
		 
		System.out.println("IN    5th   IF*********");
		
		String sqlList="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+todaysDate+"' ";
			System.out.println(sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
	}else if(number.contains("7"))
	{
		 
		System.out.println("IN    5th   IF*********");
		
		String sqlList="select ProspCustName,ContactPerson,Address,City,ProspCustCode from "+session.getAttribute("CompanyMasterID").toString()+"followup where MarketingRepcode='"+code+"' AND ProspCustName <> '-'  AND  NextFollowUpDate = '"+tomoDate+"'";
			System.out.println(sqlList);	
			 rsList=st1.executeQuery(sqlList);
			 System.out.println(sqlList);
	}else
	{
		System.out.println("Inside elseee@*@*@*@*@*");
	}
	
	List<String> CustName = new ArrayList<String>();
	
	
	
	
			 while(rsList.next())
			 {
			  Customer=rsList.getString("ProspCustName");
			  
			  String custcode1=rsList.getString("ProspCustCode");
			  System.out.println("CUSTOMER IOS    **********   "+Customer);
			  //
			     
			  if(!Customer.equals("null"))
			  {
				  int count=0;
				  String sqlCount=null;
				  
				 
				  
				  
				  
					  sqlCount="Select ProspCustName from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+Customer+"' AND FollowUpDate < '"+dt1+"' and FollowUpDate > '"+dt2+"'";
					  
					 
				  
				  
				  
				  
				  
				  
				  ResultSet rsCount=st.executeQuery(sqlCount);
				  System.out.println("*********************************      "+sqlCount);
				  while(rsCount.next())
				  {
				 // count=rsCount.getInt(1);
				  count++;
				  String abc=rsCount.getString("ProspCustName");
				  CustName.add(abc);
				  
				  }
				  
				  for (String s : CustName)
					{
					
					  System.out.println("Customer Name===>"+s);
					  
					}
				  System.out.println("CNT******==>>>"+count);
			  
			  ///
			  
			  
			  
			  String phone="",email="",mobile="",City="",Product="",salescode = "",type = "";
			  String sqldata="Select Phone,EMail,MobileNo,SalesCustomerCode,City,IntrestedProduct from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster "+ 
			 					 "where CompanyName='"+Customer.trim()+"'";
			System.out.println(sqldata);	
			  ResultSet rsdata=st.executeQuery(sqldata);
			  if(rsdata.next())
			  {
				   phone=rsdata.getString("Phone");	 
					 email=rsdata.getString("EMail"); 
					 mobile=rsdata.getString("MobileNo");
					 City=rsdata.getString("City");
					 Product=rsdata.getString("IntrestedProduct");
					 salescode=rsdata.getString("SalesCustomerCode");
				 
				 if(salescode == "0" || salescode.equals("0"))
					 type = "Prospect";
				 else
					 type = "Customer";
			  }
			  
			 %>	
			<tr>
				<td align="right"><div style="text-align: right"><%=j%></div></td>
				<td align="right"><div style="text-align: left"><%=Customer%></td>
				<td align="left"><div style="text-align: left"><%=rsList.getString("ContactPerson")%></div></td>
				<td align="right"><div style="text-align: right"><%=phone%></div></td>
				
				<td align="right"><div style="text-align: right"><%=mobile%></div></td>
				
				<td align="left"><div style="text-align: left"><%=rsList.getString("City")%></div></td>
				<td align="right"><div style="text-align: right"><a href="#" onclick="followupPopup('customerFollowupThirdLevel.jsp','<%=Customer %>','<%=rsList.getString("ContactPerson") %>','<%=phone %>','<%=email %>','<%=City %>','<%=Product %>','<%=dt2 %>','<%=dt1 %>')"><%=count%></a></div></td>
			</tr>
				<%
				j++;
				
			     }//end of if
				}//end of while loop
				
	 
				
				%>
		</table>
	

	
	
	

<br><br><br><br><br>
<br><br><br><br><br><br><br><br>        
	<br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>