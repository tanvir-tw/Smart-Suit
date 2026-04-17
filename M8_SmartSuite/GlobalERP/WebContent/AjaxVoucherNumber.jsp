
<%@ include file="conn.jsp" %>
<%@page import="java.util.Date"%>
<%!
Connection con1;
%>

<% 
try {

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;

String sql1="",buffer="---";;
String paymentMode=request.getParameter("paymentMode");
String paymentVoucher="-";
java.text.DecimalFormat df = new java.text.DecimalFormat("000");

if(paymentMode.equalsIgnoreCase("Cheque") || paymentMode.equalsIgnoreCase("DD")
		|| paymentMode.equalsIgnoreCase("Cash") || paymentMode.equalsIgnoreCase("NEFT"))
	paymentVoucher="SMR";
else if( paymentMode.equalsIgnoreCase("Debit Note") ) 
	paymentVoucher="SDN";
else if( paymentMode.equalsIgnoreCase("Credit Note") ) 
	paymentVoucher="SCN";

String date =  new SimpleDateFormat("ddMMyy").format(new Date());

String sql="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"custpymtagainstinv  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
  ResultSet rs=stmt1.executeQuery(sql);
  if(rs.next())
	  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
  else
	  paymentVoucher+=date+"001";
  
   buffer =paymentVoucher;
out.println(buffer);

} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
