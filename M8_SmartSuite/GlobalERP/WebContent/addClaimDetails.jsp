<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%! 
Connection con ;
%>

<%
String comments=request.getParameter("comments");   
String finalComments=request.getParameter("finalComments");
String action=request.getParameter("action");
String claimId=request.getParameter("claimIdentity");
//System.out.println("claimIdentity");

String sqlInsert="";
 
if(action.equals("sanction"))
sqlInsert="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master SET CommentsByHOD='"+comments+"', status='Sanctioned' WHERE status='Pending' AND claimID='"+request.getParameter("claimIdentity")+"'";
else if (action.equals("check"))
sqlInsert="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master SET CommentsCheckedBy='"+comments+"'  , status='Checked' WHERE status='Sanctioned' AND claimID='"+request.getParameter("claimIdentity")+"'";
//AND claimID='"+request.getParameter("claimID")+"'
else if(action.equals("approve"))
sqlInsert="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master SET CommentsByACDepa='"+comments+"'  , status='Approved' WHERE status='Checked' AND claimID='"+request.getParameter("claimIdentity")+"'";
//AND claimID='"+request.getParameter("claimID")+"'
System.out.println(action);

//DisallowedAmountByHOD='"+finalComments+"' 
//,DisallowedAmountByCheckman='"+finalComments+"'
//,DisallowedAmountByACDept='"+finalComments+"'
	
String existedDriver = "";
String msg = "";		
boolean flag=false;
						
try{           
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt=con.createStatement();
Statement stquery=con.createStatement();

stmt.executeUpdate(sqlInsert);
flag=true;

msg = "Data insertion Failed . please try again";
/*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/
if(flag){
msg = "information saved successfully in system";
}
response.sendRedirect("alertGoTo.jsp?msg=Claim updated with ID "+claimId+" &goto=claimAfterSubmit.jsp");
}catch(Exception e){
out.println( "Exception ::"+e );
}

%>