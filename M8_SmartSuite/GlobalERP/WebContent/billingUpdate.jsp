<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  
    
<script type="text/javascript">
           
function Redirect1(value1,value2)
{
	
	alert('Billing Details Updated Successfully  ','','success');
		  var value1=document.getElementById("company").value;
var value2=document.getElementById("companyCode").value;
window.location.href="billingDetails.jsp?companyName="+value1+"&companyCode="+value2;
	
	 //	window.open("billingDetails.jsp?companyName="+value1+"&companyCode="+value2);
	    
	
}
</script>
<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st5=null,st6=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<input type="hidden" name="companyC" value="123">
	

<%
	
try{	
	
	String CustomerCode = request.getParameter("companyname");
	System.out.println("___________hellooooo-----------"+CustomerCode);
	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st5=con.createStatement();
		st6=con.createStatement();
		
				
		String companyCode=request.getParameter("companyname");
		
		System.out.println("___________companyCode-----------"+ companyCode);	
		
		String company=request.getParameter("companyname1");
		
		System.out.println("___________company-----------"+ company);	
		%>
		<input type="hidden" id="companyCode" name="companyCode" value="<%=companyCode%>">
		
		<input type="hidden" id="company" name="company" value="<%=company%>">
		<%	
		String category=request.getParameter("category");
		
		System.out.println("___________category-----------"+ category);	
		
		String CustomerType=request.getParameter("customertype");
		
		System.out.println("___________CustomerType----------"+ CustomerType);	
		
		
 		String ToId=request.getParameter("email");
		
 		System.out.println("___________ToId******************** "+ ToId);
 		
 		String Frequency=request.getParameter("frequency");
		
 		System.out.println("___________Frequency******************** "+ Frequency);
 		
 		
 		String OperationalStatus=request.getParameter("operationalstatus");
 		System.out.println("___________OperationalStatus-----------"+ OperationalStatus);	
		
 		String Rate = request.getParameter("rate");
 		System.out.println("___________Rate-----------"+ Rate);	
		
 		
 		String ToCc=request.getParameter("email0");
 		
 		System.out.println("___________ToCc************** "+ ToCc);	
		
 		String BillType=request.getParameter("billtype");
 		
 		System.out.println("___________BillType-----------"+ BillType);	
		
		String BillStatus=request.getParameter("billstatus");
		
		System.out.println("___________BillStatus-----------"+ BillStatus);	
		
		
			
		
		String updateSql="Update db_gps.t_transporter SET category='"+category+"' ,CustomerType='"+CustomerType+"',ERPTransporterRate='"+Rate+"',BillFrequency='"+Frequency+"',BillType='"+BillType+"',ToId='"+ToId+"', ToCc='"+ToCc+"', BillStatus='"+BillStatus+"',OperationalStatus='"+OperationalStatus+"' where ERPCode='"+companyCode+"' limit 1";
		   
		st1.executeUpdate(updateSql);
		
		System.out.println("updateSql:---"+updateSql);
		
		//response.sendRedirect("alertGoTo.jsp?msg=Billing Details Updated successfully!!  and saved.&goto=home.jsp ");
out.println("<script>  Redirect1();</script>");

			//		response.sendRedirect("alertGoTo.jsp?msg=Billing Details Updated successfully!!  and saved.&goto=billingDetails.jsp?companyName='"+company+"'&companyCode='"+companyCode+"' ");

	
		}
catch(Exception e)
{
	System.out.println( "Exception ::"+e );
	e.printStackTrace();
	//out.println("<script>  Redirect2();</script>");

	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Updating Record.Please try again.&goto=javascript:history.back()");
}
finally
{
	con.close();
}
%>			
</html>