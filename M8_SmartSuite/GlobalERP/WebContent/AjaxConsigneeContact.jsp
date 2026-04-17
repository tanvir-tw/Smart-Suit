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
		 String maddress="";
	        String mcity="";
	        String mcountry="";
	        String mstate="";
	        String mzip="";
	        String comptype="";
	        String CompName="";
	        String type12="";
	        String Code="",html="";
	        String ContactPerson="";
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
	        
	        if( comptype.equals("Customer"))
	        {
	        	
	           System.out.println("In Customer Details");
	           sql="SELECT DISTINCT(contactperson) as Contact from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode='"+type12+"' AND mobileno <> 'null' order by firstname,middlename,lastname";				
	           System.out.println("customer query----111>>"+sql);
	        }
	        else
	        {
	        	System.out.println("In Prospests Details");
	        	sql="SELECT DISTINCT(contactperson) as Contact from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode='"+Code+"' AND mobileno <> 'null' order by firstname,middlename,lastname";				
	           System.out.println("customer query----111>>"+sql);
	        }
	        	st1=con1.createStatement();
	        	rs= st1.executeQuery(sql);
	            while(rs.next()){
	        	 ContactPerson=rs.getString("Contact");
	        	html+="<option>"+ContactPerson+"</option>";
	        }
	            
	            String FinalString=html+"#"+comptype+"#"+CompName+"#"+Code;
	        out.println("<option value='Select' selected='selected'>Select</option>"+FinalString);
		
        
        
       
        
%>
</jsp:useBean>
