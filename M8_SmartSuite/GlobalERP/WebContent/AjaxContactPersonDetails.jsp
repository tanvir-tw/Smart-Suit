<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>
 --%>
 <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  
<%@ include file="conn.jsp"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>



<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st=con1.createStatement();
		Statement st1=con1.createStatement();//=Customer
		String type1=request.getParameter("save");
		String customername=request.getParameter("customername");
		customername=customername.replace("*"," ");
		customername=customername.replace("..","&");
		
		out.println(""+customername);
		String sql="";
		String type=request.getParameter("Type");
		
		String ContactPerson=request.getParameter("contactperson");
		
		
		 String maddress="";
	        String mcity="";
	        String mcountry="";
	        String mstate="";
	        String mzip="";
	        String comptype="";
	        String CompName="";
	        String type12="";
	        String Code="",html="";
	        
	        ResultSet rs,rs1;
	        String sqltype="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+customername+"'";
	        //String sqltype="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='Test by chetan'";
	        rs1= st1.executeQuery(sqltype);
	        
	        while(rs1.next())
	        {
	        	
	        	CompName = rs1.getString("CompanyName");
	        	type12 = rs1.getString("SalesCustomerCode");
	        	Code= rs1.getString("CustomerCode");
	        }
	        
	        if(type12.equals("0") || type12=="0")
	        {
	        	  comptype ="Prospect";
	        	 // custcode = rs.getString("CustomerCode");
	        }
	        else	
	        {
	        	   comptype ="Customer";
	        	  // custcode = rs.getString("SalesCustomerCode");
	        }
	        String contact_id="";
	        String mobileno="";
	        String email="";
	        String phone="";
	        String Address="";
	        String city="";
	        String state="";
	        String country="";
	        String zipcode="";
	        String mobileno1 ="";
	        String mobileno2="";
	        String AlternetNO="";
	        String Email1 ="";
	        String Email2="";
	        
	        if( comptype.equals("Customer"))
	        {
	        	
	           System.out.println("In Customer Details");
	           sql="SELECT DISTINCT(contactperson) as Contact,contact_id,mobileno,email,phone,Address,city,state,country,zipcode,mobileno1,mobileno2,AlternetNO,Email1,Email2 from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode ='"+type12+"' AND mobileno <> 'null'  and contactperson='"+ContactPerson+"' order by firstname,middlename,lastname";				
	           System.out.println("customer query----111>>"+sql);
	        }
	        else
	        {
	        	System.out.println("In Prospests Details");
	        	sql="SELECT DISTINCT(contactperson) as Contact,contact_id,mobileno,email,phone,Address,city,state,country,zipcode,mobileno1,mobileno2,AlternetNO,Email1,Email2 from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode='"+Code+"' AND mobileno <> 'null' and contactperson='"+ContactPerson+"' order by firstname,middlename,lastname";				
	           System.out.println("customer query----111>>"+sql);
	        }
	        	st1=con1.createStatement();
	        	rs= st1.executeQuery(sql);
	            if(rs.next()){
	        	 ContactPerson=rs.getString("Contact");
	        	 contact_id=rs.getString("contact_id");
	        	 mobileno=rs.getString("mobileno");
	        	 email=rs.getString("email");
	        	 phone=rs.getString("phone");
	        	 Address=rs.getString("Address");
	        	 city=rs.getString("city");
	        	 state=rs.getString("state");
	        	 country=rs.getString("country");
	        	 zipcode=rs.getString("zipcode");
	        	 mobileno1 =rs.getString("mobileno1");
	        	 mobileno2=rs.getString("mobileno2");
	        	 AlternetNO=rs.getString("AlternetNO");
	        	 Email1 =rs.getString("Email1");
	        	 Email2=rs.getString("Email2");
	        	 
	        	html+="<option>"+ContactPerson+"</option>";
	        }
	            
	            String FinalString=ContactPerson+"#"+mobileno+"#"+email+"#"+phone+"#"+Address+"#"+city+"#"+state+"#"+country+"#"+zipcode+"#"+mobileno1+"#"+mobileno2+"#"+AlternetNO+"#"+Email1+"#"+Email2;
	        out.println(FinalString);
		
        
        
       
        
%>
</jsp:useBean>
