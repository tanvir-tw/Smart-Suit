<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try {
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement st1 = con1.createStatement();
ResultSet rs1 = null;
String buffer = "";
String sqlUpdate="",sqlUpdateMaster=""; 
String comments=request.getParameter("comments");
String billId=request.getParameter("billId");
String claimrefno=request.getParameter("claimrefno");
String allowedAmount=request.getParameter("allowedAmount");
System.out.println(">>>>>>allowedAmount:"+allowedAmount);
String srno=request.getParameter("srno");
System.out.println(">>>>>>srno:"+srno);
//String approvstatus=request.getParameter("approvstatus");
//System.out.println(">>>>>>approvstatus:"+approvstatus);
/*if(allowedAmount.contains(""))
{
	allowedAmount="0";
}*/
String action=request.getParameter("action");
System.out.println(">>>>>>action:"+action);
//System.out.println(action);
//System.out.println(action);

// if(action.equals("sanction"))
// {
// sqlUpdate = "UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"claim_det set DisallowedAmount=Amount-"+allowedAmount+" ,DisallowedAmountByACDept=Amount-"+allowedAmount+" ,CommentsByACDepa='"+comments+"' ,SanctionedBy='"+session.getAttribute("EmpName").toString()+"' where BillID='"+billId+"' and CLMRefNumber='"+claimrefno+"' and SrNo='"+srno+"'  ";
// }
if(action.equals("check"))
{
 sqlUpdate = "UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"claim_det set DisallowedAmount=Amount-"+allowedAmount+",DisallowedAmountByHOD=Amount-"+allowedAmount+" ,CheckedBy='"+session.getAttribute("EmpName").toString()+"',CommentsByHOD='"+comments+"' where BillID='"+billId+"' and CLMRefNumber='"+claimrefno+"' and SrNo='"+srno+"'  ";
}
else if(action.equals("approve"))
{
sqlUpdate="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"claim_det set  DisallowedAmount=Amount-"+allowedAmount+",DisallowedAmountByACDept=Amount-"+allowedAmount+" ,CommentsByACDepa='"+comments+"' ,ApprovedBy='"+session.getAttribute("EmpName").toString()+"' where BillID='"+billId+"' and CLMRefNumber='"+claimrefno+"' and SrNo='"+srno+"' ";
}
stmt1.executeUpdate(sqlUpdate);
System.out.println(">>>>>>>>>>>>sqlUpdate:"+sqlUpdate);			
/*	 String sqlMaster="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master set ClaimClearedForAmt='"+allowedAmount+"',"+
			 					" DisallowedAmount=SumOfClaimAmount-"+allowedAmount+" ";*/
buffer = "#Yes";
out.println(buffer);
		   

}catch (Exception e) {
System.out.println("update claim info  > "+e);
out.println("#NO");
}finally {
	con1.close();
}

%>      		