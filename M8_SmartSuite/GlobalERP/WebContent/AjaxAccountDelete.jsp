<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
	System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxAccountDelete.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();
Statement stmt3 = con1.createStatement();
Statement stmt4 = con1.createStatement();
ResultSet rs1 = null,rsClaimNo=null;
String buffer = "",SqlUpdate;
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxAccountDelete.jsp>>>>>>>>>>>>>>>>"+con1);	




String SqlDeleteMaster="",SqlClaimDet="",sql="",sql1="";
String cmnycode="",empid="",salutation="-",empname="-",deptid="",empemail="",designtion="",fstname="",mddlnm="",lastname="",twempid="",empcntctno="",date_brth="",maart_stts="",DateOfAnniversary="",KidsDetails="",Child1Sex="",Child2Sex="",Child1Name="",Child2Name="",Child1DOB="",Child2DOB="",AddressEmp="",SalaryDetails="",BasicSalarary="",TDS="",	NetPay="",Allowance="",Allowance1="",Allowance2="",Allowance3="",Allowance4="",deduction="",deduction1="",deduction2="",deduction3="",deduction4="",PreviousPay="",AccNo="",BankName="",BankBranch="",IFSC="",PanNo="",	PolicyNo="",NameOfClaimCompany="", 	ExpiryDateClaim="", 	ClaimAmount="", 	ContactImeediate="",ContactNoImmediate="",AddressContact="",RelationShip="",EnterBy="", 	EnteredDateTime="", 	ModifiedBy="",EditDateTime="",DateofJoining="",ContractDate="",ContractExpDate="",MediclaimFileName="", 	ContractFileName="",Status="",Status1="";

String id=request.getParameter("id");
System.out.println(">>>>>>>>id:"+id);
String []arr=id.split(",");
System.out.println("arr length"+arr.length);
for(int i=1;i<arr.length;i++)
{
	System.out.println("arr val"+arr[i]);
}

if(request.getParameter("action").equals("delete"))
{	
	System.out.println("arr val111111");
for(int i=1;i<arr.length;i++)
	{
		System.out.println("arr val"+arr[i]);
		SqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"netbanking SET Status ='Deactivate' WHERE ID='"+arr[i]+"' limit 1 ";
		System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlUpdate);
		stmt1.executeUpdate(SqlUpdate);
		
	}
	  
	//String SqlUpdate1="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"leaveadmin SET Status ='No' WHERE EmpID='"+id+"' limit 1 ";
	//stmt2.executeUpdate(SqlUpdate1);
	out.println("Yes");
	
}

} 
catch (Exception e) {
System.out.println("AjaxAccountDelete.jsp error  table > "+e);
out.println("NO");
} finally {
	con1.close();

}

%>