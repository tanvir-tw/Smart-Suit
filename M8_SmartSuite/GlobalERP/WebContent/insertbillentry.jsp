<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="com.ConnectionClass"%>
<%@page import="java.util.Date"%>
<%
Connection con = null;
Statement stmt=null,st1=null, st2=null,st3=null,st4=null,sterp=null;
 
 try {
	 ConnectionClass connObj = new ConnectionClass();
	con = connObj.getConnect("db_leaveapplication");   
	System.out.println("con :::::::::::::::::: "+con);
	stmt = con.createStatement();
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();
	st4 = con.createStatement();
	sterp=con.createStatement();
} catch (Exception e) {
   e.printStackTrace();
}
%>

<%
 String refno="",amount="",checkno="",paidby="",dop="",SqlInsert="",SqlInsert1="",SqlUpdate="",SqlUpdate1="",SqlUpdate2="";
 
refno=request.getParameter("refno");
amount=request.getParameter("amount");
checkno=request.getParameter("checkno");
paidby=request.getParameter("paidby");
dop=request.getParameter("dop");
System.out.println("refno===============> :"+refno);
try
{
	dop=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(dop));
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>>>>>>>Exception in date conversion:"+e);
}

try
{
	SqlInsert="Insert into db_leaveapplication.t_billpayment(InwardNo,PaidAmount,PaidBy,CheckNo,DateOfPayment,BillStatus,EnterBy)values('"+refno+"','"+amount+"','"+paidby+"','"+checkno+"','"+dop+"','Paid','"+session.getAttribute("empname").toString()+"')";
	st1.executeUpdate(SqlInsert);
	System.out.println(">>>>>>>>>>>>>>>>>>SqlInsert:"+SqlInsert);
	SqlInsert1="Insert into db_leaveapplication.t_billpaymenthistory(InwardNo,PaidAmount,PaidBy,CheckNo,DateOfPayment,BillStatus,EnterBy)values('"+refno+"','"+amount+"','"+paidby+"','"+checkno+"','"+dop+"','Paid','"+session.getAttribute("empname").toString()+"')";
	st2.executeUpdate(SqlInsert1);
	System.out.println(">>>>>>>>>>>>>>>>>>SqlInsert1:"+SqlInsert1);
	
	SqlUpdate="Update db_leaveapplication.t_inwarddetails Set BillStatus='Paid' where InwardRefNo='"+refno+"'";
	System.out.println(">>>>>>>>>>>>>>>>>>SqlUpdate:"+SqlUpdate);
	st3.executeUpdate(SqlUpdate);
	SqlUpdate1="Update db_leaveapplication.t_inwarddetailshistory Set BillStatus='Paid' where InwardRefNo='"+refno+"'";
	System.out.println(">>>>>>>>>>>>>>>>>>SqlUpdate1:"+SqlUpdate1);
	st4.executeUpdate(SqlUpdate1);
	
	//*************** change the status of t_claim_master of claim module **************
	
	SqlUpdate2="Update twsql_twalldata.t_claim_master Set status='Paid' where CLMRefNumber='"+refno+"'";
	System.out.println(">>>>>>>>>>>>>>>>>>SqlUpdate for claim status :"+SqlUpdate2);
	sterp.executeUpdate(SqlUpdate2);
	
	out.println("Yes");
	//response.sendRedirect("billreport.jsp");
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>>>>>>>Exception Insertion :"+e);
	//response.sendRedirect("billreport.jsp");
	out.println("No");
}
%>