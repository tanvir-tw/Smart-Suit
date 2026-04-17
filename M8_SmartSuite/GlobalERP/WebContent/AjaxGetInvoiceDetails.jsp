
<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {
 
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
boolean flag=false;
String company=request.getParameter("company");
StringBuffer InvList=new StringBuffer("(");


String sqlCustomerCode="SELECT CustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+company+"'";
ResultSet rsCustomerCode=stmt1.executeQuery(sqlCustomerCode);
rsCustomerCode.next();
String customerCode=rsCustomerCode.getString(1);
rsCustomerCode=null;

String sqlInvList="SELECT InvRefNo from "+session.getAttribute("CompanyMasterID").toString()+"custpymtagainstinv where CustomerCode ="+customerCode+" " ;
ResultSet rsInvList=stmt1.executeQuery(sqlInvList);
while(rsInvList.next())
	InvList.append("'"+rsInvList.getString(1)+"',");
InvList.append("'0')");

  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode ="+customerCode+"  "+
  "  and TransactionType='Invoice' and "+
  "  TransactionDetail  not in "+InvList+" order by TransactionDate ASC ";
  rs1=stmt1.executeQuery(sql1);

 String buffer="<table style='background-color: white;' border='1'>"; //cellspacing='0' cellpadding='0'
 buffer=buffer+"<tr>"+
 		"<th>Check</th>"+
 		"<th>Inv No</th>"+
 		"<th>Inv Date</th>"+
 		"<th>Inv Value</th>"+
 		"<th>Balance</th>"+
 		"<th>Amt against Invoice</th>"+
 		"<th>Sign</th>"+
 		"</tr>";
 int i=1;
   while(rs1.next())
   {
      flag=true;
      
    	buffer=buffer+"<tr id=tr"+i+"><td><input type='checkbox' name='check"+i+"' id='check"+i+"' value='"+rs1.getString("TransactionDetail")+"' onclick='tallyInvoice("+i+")'></td>"+
    	"<td>"+rs1.getString("TransactionDetail")+"</td>"+
    	"<td>"+new SimpleDateFormat(
		"dd-MMM-yyyy")
		.format(new SimpleDateFormat(
				"yyyy-MM-dd")
				.parse(rs1.getString("TransactionDate")))+"</td>"+
    	"<td align='right'>"+rs1.getString("DebitAmount")+"<input type='hidden' name='invoiceValue"+i+"' id='invoiceValue"+i+"' value='"+rs1.getString("DebitAmount")+"' /></td>"+
    	"<td align='right' id=tdBalance"+i+">"+rs1.getString("Balance")+"</td>"+
    	"<td align='right' id=tdAmountAgainstInvoice"+i+"></td>"+
    	"<td>"+rs1.getString("EmpName")+" <input type='hidden' name='amt"+i+"' id='amt"+i+"' value='0' /></td>"+
    	"</tr>";
        i++;
   } 
  buffer+="<input type='hidden' name='checktotal' id='checktotal' value='"+i+"'>";
   buffer+="</table></div>";
out.println(buffer);

} catch(Exception e) { System.out.print(e); }
finally
{
	con1.close();
}
%>
