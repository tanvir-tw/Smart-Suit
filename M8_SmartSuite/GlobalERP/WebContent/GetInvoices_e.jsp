
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
String mmoneyreceiptno=request.getParameter("myvoucherno");
String sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"collectioninv where moneyreceiptno="+mmoneyreceiptno;
rs1=stmt1.executeQuery(sql1);
String buffer="<table style='background-color: #E1F3F3; font-family:verdana; font-size:xx-small; border: thin solid; border-color: #2077DA; border-collapse:collapse; border-style:outset;' >"; //cellspacing='0' cellpadding='0'
buffer=buffer+"<tr style='border: thin solid; border-color: #2077DA;'><td colspan='4' align='center'><strong>Selected Invoices</strong></td></tr>"+
        "<tr style='border: thin solid; border-color: #2077DA;'>"+
 		"<th style='border: thin solid; border-color: #2077DA;background-color: #0EBEF8;'>Inv No</th>"+
 		"<th style='border: thin solid; border-color: #2077DA;background-color: #0EBEF8;'>Inv Date</th>"+
 		"<th style='border: thin solid; border-color: #2077DA;background-color: #0EBEF8;'>Inv Value</th>"+
 		"<th style='border: thin solid; border-color: #2077DA;background-color: #0EBEF8;'>Amt against Invoice</th>"+
 		"</tr>";
int i=1;
String mTransactiondate="";
while(rs1.next())
{
	    mTransactiondate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TransactionDate")));
    	buffer=buffer+"<tr style='border: thin solid; border-color:#2077DA;' id=tr"+i+">"+
    	"<td align='right' style='border: thin solid; border-color: #2077DA;'>"+rs1.getString("InvRefno")+"</td>"+
    	"<td align='right' style='border: thin solid; border-color: #2077DA;'>"+mTransactiondate+"</td>"+
    	"<td align='right' style='border: thin solid; border-color: #2077DA;'>"+rs1.getString("InvValue")+"</td>"+
    	"<td align='right' style='border: thin solid; border-color: #2077DA;'>"+rs1.getString("AmountPaidAgainstThisInvoice")+"</td>"+
    	"</tr>";
        i++;
        //+new SimpleDateFormat("dd-MMM-yyyy")format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TransactionDate")))+
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
