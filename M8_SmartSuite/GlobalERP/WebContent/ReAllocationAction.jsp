<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<html>
<style type="text/css">

.inputbox {
vertical-align: left;
}


</style>
<body onload="resetAll();" style="font-family:arial;">


<script type="text/javascript">
function Redirect()
{
	alert("ReAllocated Successfully");
	window.open("CustomerMaster1.jsp");
	//window.location="CustomerMaster1.jsp";
	window.close();
	
	//alert(action);
	window.onunload = refreshParent;
	
}
function Redirect1()
{
	alert("Error While ReAllocation !!!");
    window.close();
	
}
</script>
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
		Connection conn = null;
		Statement st = null,st1 = null,st4 = null,st5 = null,st3 = null,st2= null,stlbl=null;
		Format format=new SimpleDateFormat("dd-MMM-yyyy");
		Format parse=new SimpleDateFormat("yyyy-MM-dd");
		String fromDate="",toDate="",fromDateCal="",toDateCal="";
		String companyName="",phone="",contact="",email="",product="",city="";
		Date today = new Date();
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
		String fromDateCal1=new SimpleDateFormat("yyyy-MM-dd").format(today);
 		try 
 		{
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st4 = conn.createStatement();
				st3 = conn.createStatement();
				st5 = conn.createStatement();
				st1 = conn.createStatement();
				stlbl = conn.createStatement();
		} 
 		catch (Exception e) 
 		{
		
 		}
 	
 		String Type=request.getParameter("type");
 		System.out.println("Type :-"+Type);
 		
 		 String representativecode=request.getParameter("representativecode");
 		System.out.println("representative :-"+representativecode); 
 		
 		
 		String Query="";
 		String Update="";
 		String InsertHistory="";
 		
 		
 		
 		
 		try{
 			
 		
 		
 		String comm=request.getParameter("code");
 		System.out.println("comm :-"+comm);
 		
 		String count[]=comm.split(",");
 		
 		for(int h=0;h<count.length;h++)
 		{
 	 		System.out.println("count :-"+count[h]);

 	 		if(count[h].equalsIgnoreCase(""))
 	 		{
 	 	 		System.out.println("yyy");

 	 			
 	 		}
 	 		else
 	 		{
 		
 		 if(Type.equals("Customer"))
 		{
 			Query="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where customercode="+count[h]+"";
 		ResultSet RsQuery=st1.executeQuery(Query);
 			
 			
 			Update="update "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster set Allocatedto='"+representativecode+"' where salescustomercode='"+count[h]+"'";
 			System.out.println("Update :-"+Update);
 	st2.executeUpdate(Update);
 		}
 		else
 		{
 			Query=" select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where customercode="+count[h]+"";
 			ResultSet RsQuery2=st2.executeQuery(Query);
 			
 			Update="update "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster set Allocatedto='"+representativecode+"' where CustomerCode='"+count[h]+"'";
 			System.out.println("Update :-"+Update);
 			st3.executeUpdate(Update);
 		}
 		
 		 String Name=session.getAttribute("EmpName").toString();
 		 ResultSet rsQuery=st4.executeQuery(Query);
 		 String CompanyName="";
 		 if(rsQuery.next())
 		 {
 			CompanyName=rsQuery.getString("CompanyName");
 			
 		 }
 		 
 		 InsertHistory="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReAllocationHistory (CompanyName,CustomerCode,ReAssignedTo,EntryBy,EntryDate) values ('"+CompanyName+"','"+count[h]+"','"+representativecode+"','"+Name+"','"+fromDateCal1+"')";
 		 st5.executeUpdate(InsertHistory);
 		 System.out.println("Insert Query :-"+InsertHistory);
 		}
 		}
 		
			out.println("<script>  Redirect();</script>");

 		}
 		catch(Exception e)
 		{
 			e.printStackTrace();
 			out.println("<script>  Redirect1();</script>");

 		}
 		
 		
%>
</body>
</html>
</jsp:useBean>