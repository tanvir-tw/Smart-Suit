<%@page import="java.io.Flushable" import="java.util.Date"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@ include file="conn.jsp" %>
<%!
Connection con1=null;
%>

<% 
System.out.println("========In Ajax Get Customer Info=========");
try 
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stcount = con1.createStatement();
Statement stcount1 = con1.createStatement();
ResultSet rs1 = null;
ResultSet rs2 = null;
String sql1 = "";
String newstring = "";
boolean flag = false;
int element = 99; 
String custtype="";
String custcode = request.getParameter("code");
try
{
 custtype = request.getParameter("type");
System.out.println(">>>>>code "+custcode+"  >>>>>> "+custtype);

}catch(Exception e)
{ 
	System.out.println("Inside excpp");
  e.printStackTrace();
}

String PotentialValue="",rep="",code="",contact="",email="",city="",name="",mobile="",product="",off="",website="",fax="",noofunits="", custType = "",custType1 = "",Assighnedby = "", leadRef = "",AddedOnDate = "", opportCount="";


  if(custtype.equals("Prospect") || custtype == "Prospect")
  {
	  sql1="SELECT PotentialValue,Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,AddedOnDate,CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode = '"+custcode+"' and IsDataValid='1' "; 
	  rs1 = stmt1.executeQuery(sql1);
	  System.out.println("query for geting all details===>"+sql1);
	if(rs1.next())
	{
		 if(session.getAttribute("CompanyMasterID").toString().equals("100000"))
		 {
			 String sqlopprtcnt="SELECT count(Opportunitycode) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where  companyname='"+rs1.getString("CompanyName")+"'";
				System.out.println("query for OPPORTUNTY COUNT for transworld opportunity===>"+sqlopprtcnt);
			ResultSet rs5=stcount1.executeQuery(sqlopprtcnt);
				while(rs5.next())
				{
					opportCount=rs5.getString(1);
				}
		 }
		 else
		 {
		
		String sqlopprtcnt="SELECT count(customer_code) FROM "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where  customer='"+rs1.getString("CompanyName")+"'";
		System.out.println("query for OPPORTUNTY COUNT===>"+sqlopprtcnt);
		rs2=stcount.executeQuery(sqlopprtcnt);
		while(rs2.next())
		{
			opportCount=rs2.getString(1);
			
		}
		 }
		System.out.println("OPPORTUNITY COUNT ISSSSSSSSSSS===>"+opportCount);
		
	   rep = (rs1.getString("CustEnteredByRep") == null || rs1.getString("CustEnteredByRep").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustEnteredByRep")  ;
	   code = (rs1.getString("CustomerCode") == null || rs1.getString("CustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustomerCode")  ;
	   contact = (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson")  ;
	   PotentialValue=(rs1.getString("PotentialValue") == null || rs1.getString("PotentialValue").equalsIgnoreCase("") ) ? "-" : rs1.getString("PotentialValue")  ;
	   System.out.println("PotentialValue==>>>" + PotentialValue);
	   
	   Assighnedby = (rs1.getString("Assighnedby") == null || rs1.getString("Assighnedby").equalsIgnoreCase("") ) ? "-" : rs1.getString("Assighnedby")  ;
	   leadRef = (rs1.getString("leadRef") == null || rs1.getString("leadRef").equalsIgnoreCase("") ) ? "-" : rs1.getString("leadRef")  ;
	   try{
		   AddedOnDate = (rs1.getString("AddedOnDate") == null || rs1.getString("AddedOnDate").equalsIgnoreCase("") ) ? "-" : new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("AddedOnDate")))  ;   
	   }catch(Exception e)
	   {
		   AddedOnDate="0000-00-00";
	   }
	   
	   
	   email = (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail")  ;
	   city = (rs1.getString("City") == null || rs1.getString("City").equalsIgnoreCase("Select") ) ? "-" : rs1.getString("City")  ;
	   name = (rs1.getString("CompanyName") == null || rs1.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs1.getString("CompanyName")  ;
	   mobile = (rs1.getString("MobileNo") == null || rs1.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("MobileNo")  ;
	   product = (rs1.getString("IntrestedProduct") == null || rs1.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("IntrestedProduct")  ;
	   off = (rs1.getString("WeeklyOffon") == null || rs1.getString("WeeklyOffon").equalsIgnoreCase("") ) ? "-" : rs1.getString("WeeklyOffon")  ;
	   website = (rs1.getString("WebSite") == null || rs1.getString("WebSite").equalsIgnoreCase("") ) ? "-" : rs1.getString("WebSite")  ;
	   fax = (rs1.getString("Fax") == null || rs1.getString("Fax").equalsIgnoreCase("") ) ? "-" : rs1.getString("fax")  ;
	   noofunits = (rs1.getString("NoOfUnits") == null || rs1.getString("NoOfUnits").equalsIgnoreCase("") ) ? "-" : rs1.getString("NoOfUnits")  ;
	   custType1 = (rs1.getString("SalesCustomerCode") == null || rs1.getString("SalesCustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("SalesCustomerCode")  ;
	  
	   out.print("<input type='hidden' name='RepName' id='RepName' value='"+rep+"'>");
	   out.print("<input type='hidden' name='Name' id='Name' value='"+name+"'>");
	   out.print("<input type='hidden' name='Code' id='Code' value='"+code+"'>");
	   out.print("<input type='hidden' name='ContactPerson' id='ContactPerson' value='"+contact+"'>");
	   out.print("<input type='hidden' name='PotentialValue1' id='PotentialValue1' value='"+PotentialValue+"'>");
	   out.print("<input type='hidden' name='Email' id='Email' value='"+email+"'>");
	   out.print("<input type='hidden' name='City' id='City' value='"+city+"'>");
	   out.print("<input type='hidden' name='Fax' id='Fax' value='"+fax+"'>");
	   out.print("<input type='hidden' name='MobileNo' id='MobileNo' value='"+mobile+"'>");
	   out.print("<input type='hidden' name='WeeklyOff' id='WeeklyOff' value='"+off+"'>");
	   out.print("<input type='hidden' name='WebSite' id='WebSite' value='"+website+"'>");
	   out.print("<input type='hidden' name='IntrestedProduct' id='IntrestedProduct' value='"+product+"'>");
	   out.print("<input type='hidden' name='NoOfUnits' id='NoOfUnits' value='"+noofunits+"'>");
	   out.print("<input type='hidden' name='custtype' id='custtype' value='Prospect'>");
	   out.print("<input type='hidden' name='assignby' id='assignby' value='"+Assighnedby+"'>");
	   out.print("<input type='hidden' name='leadref' id='leadref' value='"+leadRef+"'>");
	   out.print("<input type='hidden' name='addedondate' id='addedondate' value='"+AddedOnDate+"'>");
	   out.print("<input type='hidden' name='oppcount' id='oppcount' value='"+opportCount+"'>");
	
	   /*
	System.out.println("In IF prospect");
	   System.out.println("RepName ARE =====>"+rep);
	   System.out.println("Name ARE =====>"+name);
	   System.out.println("Code ARE  ======>"+code);
	   System.out.println("ContactPerson ARE  ======>"+contact);
	   System.out.println("Email ARE   ======>"+email);
	   System.out.println("City ======>"+city);
	   System.out.println("Fax =====>"+fax);
	   System.out.println("MobileNo =======>"+mobile);
	   System.out.println("WeeklyOff=====>"+off);
	   System.out.println("WebSite ====>"+website);
	   System.out.println("IntrestedProduct ====>"+product);
	   System.out.println("NoOfUnits ====>"+noofunits);
	   System.out.println("assignby ====>"+Assighnedby);
	   System.out.println("leadref ====>"+leadRef);
	   System.out.println("addedOnDate ====>"+AddedOnDate);
	   */
	}//end of while  
	  
  }else //customer
  {
	  sql1="SELECT a.BillingAddress as Address ,a.BillingCity as City ,a.BillingZip as Zip ,a.BillingState as State ,a.BillingCountry as Country,a.BillingPhone as Phone, b.CustEnteredByRep ,a.BillingFax as Fax,b.WeeklyOffon,b.NoOfUnits,b.SalesCustomerCode,a.CustomerCode,a.ContactPerson, a.EMail, a.IntrestedProduct,a.MobileNo,a.WebSite,b.Assighnedby,b.leadRef,a.EnteredOn,a.CompanyName, b.PotentialValue from "+session.getAttribute("CompanyMasterID").toString()+"customerdet a, "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster b where  a.CustomerCode = b.SalesCustomerCode and a.CustomerCode = '"+custcode+"' and a.IsDataValid='1' limit 1"; 
	  System.out.println("The query is ==>"+sql1);
	  rs1 = stmt1.executeQuery(sql1);
	 if(rs1.next())
	 { 
		 if(session.getAttribute("CompanyMasterID").toString().equals("100000"))
		 {
			 String sqlopprtcnt="SELECT count(Opportunitycount) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where  companyname='"+rs1.getString("CompanyName")+"'";
				System.out.println("query for OPPORTUNTY COUNT for transworld opportunity===>"+sqlopprtcnt);
			ResultSet rs5=stcount1.executeQuery(sqlopprtcnt);
				while(rs5.next())
				{
					opportCount=rs5.getString(1);
					
				}
		 }
		 else
		 {
			 
		 
		 String sqlopprtcnt="SELECT count(customer_code) FROM "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where  customer='"+rs1.getString("CompanyName")+"'";
			System.out.println("query for OPPORTUNTY COUNT===>"+sqlopprtcnt);
			rs2=stcount.executeQuery(sqlopprtcnt);
			while(rs2.next())
			{
				opportCount=rs2.getString(1);
				
			}
		 }
			System.out.println("OPPORTUNITY COUNT ISSSSSSSSSSS===>"+opportCount);
		   rep = (rs1.getString("CustEnteredByRep") == null || rs1.getString("CustEnteredByRep").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustEnteredByRep")  ;
		   code = (rs1.getString("CustomerCode") == null || rs1.getString("CustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustomerCode")  ;
		   contact = (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson")  ;
		   PotentialValue=(rs1.getString("PotentialValue") == null || rs1.getString("PotentialValue").equalsIgnoreCase("") ) ? "-" : rs1.getString("PotentialValue")  ;
		   Assighnedby = (rs1.getString("Assighnedby") == null || rs1.getString("Assighnedby").equalsIgnoreCase("") ) ? "-" : rs1.getString("Assighnedby")  ;
		   leadRef = (rs1.getString("leadRef") == null || rs1.getString("leadRef").equalsIgnoreCase("") ) ? "-" : rs1.getString("leadRef")  ;
		   AddedOnDate = (rs1.getString("EnteredOn") == null || rs1.getString("EnteredOn").equalsIgnoreCase("") ) ? "-" : new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("EnteredOn")))  ;
		   email = (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail")  ;
		   city = (rs1.getString("City") == null || rs1.getString("City").equalsIgnoreCase("Select") ) ? "-" : rs1.getString("City")  ;
		   name = (rs1.getString("CompanyName") == null || rs1.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs1.getString("CompanyName")  ;
		   mobile = (rs1.getString("MobileNo") == null || rs1.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("MobileNo")  ;
		   product = (rs1.getString("IntrestedProduct") == null || rs1.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("IntrestedProduct")  ;
		   off = (rs1.getString("WeeklyOffon") == null || rs1.getString("WeeklyOffon").equalsIgnoreCase("") ) ? "-" : rs1.getString("WeeklyOffon")  ;
		   website = (rs1.getString("WebSite") == null || rs1.getString("WebSite").equalsIgnoreCase("") ) ? "-" : rs1.getString("WebSite")  ;
		   fax = (rs1.getString("Fax") == null || rs1.getString("Fax").equalsIgnoreCase("") ) ? "-" : rs1.getString("fax")  ;
		   noofunits = (rs1.getString("NoOfUnits") == null || rs1.getString("NoOfUnits").equalsIgnoreCase("") ) ? "-" : rs1.getString("NoOfUnits")  ;
		   custType1 = (rs1.getString("SalesCustomerCode") == null || rs1.getString("SalesCustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("SalesCustomerCode")  ;
		  
		   out.print("<input type='hidden' name='RepName' id='RepName' value='"+rep+"'>");
		   out.print("<input type='hidden' name='Name' id='Name' value='"+name+"'>");
		   out.print("<input type='hidden' name='Code' id='Code' value='"+code+"'>");
		   out.print("<input type='hidden' name='ContactPerson' id='ContactPerson' value='"+contact+"'>");
		   out.print("<input type='hidden' name='PotentialValue1' id='PotentialValue1' value='"+PotentialValue+"'>");
		   out.print("<input type='hidden' name='Email' id='Email' value='"+email+"'>");
		   out.print("<input type='hidden' name='City' id='City' value='"+city+"'>");
		   out.print("<input type='hidden' name='Fax' id='Fax' value='"+fax+"'>");
		   out.print("<input type='hidden' name='MobileNo' id='MobileNo' value='"+mobile+"'>");
		   out.print("<input type='hidden' name='WeeklyOff' id='WeeklyOff' value='"+off+"'>");
		   out.print("<input type='hidden' name='WebSite' id='WebSite' value='"+website+"'>");
		   out.print("<input type='hidden' name='IntrestedProduct' id='IntrestedProduct' value='"+product+"'>");
		   out.print("<input type='hidden' name='NoOfUnits' id='NoOfUnits' value='"+noofunits+"'>");
		   out.print("<input type='hidden' name='custtype' id='custtype' value='Customer'>");
		   out.print("<input type='hidden' name='assignby' id='assignby' value='"+Assighnedby+"'>");
		   out.print("<input type='hidden' name='leadref' id='leadref' value='"+leadRef+"'>");
		   out.print("<input type='hidden' name='addedondate' id='addedondate' value='"+AddedOnDate+"'>");
		   out.print("<input type='hidden' name='oppcount' id='oppcount' value='"+opportCount+"'>");
		/*  
		System.out.println("RepName ARE =====>"+rep);
		   System.out.println("Name ARE =====>"+name);
		   System.out.println("Code ARE  ======>"+code);
		   System.out.println("ContactPerson ARE  ======>"+contact);
		   System.out.println("Email ARE   ======>"+email);
		   System.out.println("City ======>"+city);
		   System.out.println("Fax =====>"+fax);
		   System.out.println("MobileNo =======>"+mobile);
		   System.out.println("WeeklyOff=====>"+off);
		   System.out.println("WebSite ====>"+website);
		   System.out.println("IntrestedProduct ====>"+product);
		   System.out.println("NoOfUnits ====>"+noofunits);
		   System.out.println("assignby ====>"+Assighnedby);
		   System.out.println("leadref ====>"+leadRef);
		   System.out.println("addedOnDate ====>"+AddedOnDate);
		   */
	 }
	  
		 
  }
  out.println("NO");
   
}catch(Exception e)
{ 
  e.printStackTrace();
}
finally
{
  con1.close();
}
%>
</jsp:useBean>