<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>   
<html>
<head>
<script type="text/javascript">
function Redirect()
{
	alert("Record Added Successfully");
	window.location = "BillingDetailsReport.jsp";
	
}

</script>
</head>
<body>

<%
try{
		Connection conn = null;
		
		Class.forName(DB_Driver);
		conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		  
		Statement st = null,st1 = null;
		ResultSet rs=null,rs1=null;
		st=conn.createStatement();
		st1=conn.createStatement();

		
		String companyName="",customerType="",customerCode="",vehlist="",billYear="",billMonth="";

 		companyName=request.getParameter("Company");
 		System.out.println("companyName :-"+companyName);
 		
 		customerType=request.getParameter("Type");
 		System.out.println("customerType :-"+customerType);
 		
 		customerCode=request.getParameter("Code");
 		System.out.println("customerCode :-"+customerCode);
 		
 		vehlist=request.getParameter("vehlst");
 		System.out.println("vehlist :-"+vehlist);
 		
 		 String vehlist1=vehlist.replaceAll(",","','");
 	     
 		 String vehlist2="'"+vehlist1+"'";
 	     
 	     System.out.println("vehlist1:- "+vehlist1);
 	     System.out.println("vehlist2:- "+vehlist2);

 		
 		billYear=request.getParameter("billYear");
 		System.out.println("billYear :-"+billYear);
 		
 		billMonth=request.getParameter("billMonth");
 		System.out.println("billMonth :-"+billMonth);
 
 		String update ="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+billYear+"_"+billMonth+" set ERPCode='"+customerCode+"',ERPCustName='"+companyName+"',GroupName='"+companyName+"',Transporter='"+companyName+"' where vehid in ("+vehlist2+")";       
 		System.out.println("Update Query"+update);
       st.executeUpdate(update);

		out.println("<script>  Redirect();</script>");

 	
 		}
 		catch(Exception e)
 		{
 			e.printStackTrace();

 		}
 		
 		
%>
</body>
</html>