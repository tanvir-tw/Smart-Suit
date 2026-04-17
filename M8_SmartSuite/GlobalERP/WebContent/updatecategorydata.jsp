
<%@page import="com.sun.xml.internal.ws.client.SenderException"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null;
//String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";
%>
<%
boolean isInvoiceSelected=false;
try{

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();

	String Empname=session.getAttribute("EmpName").toString();
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String caegory_name=request.getParameter("category_name");
	String Status=request.getParameter("status");
	String limit=request.getParameter("limit");
	String id1=request.getParameter("ID");
	System.out.println("ID--->"+id1);
	int id=1;
	String sql1="select MAX(id) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategoryhistory";
	ResultSet rs1=st3.executeQuery(sql1);
	rs1.next();
	 id=rs1.getInt(1);
	id++;
	
	
	String sqlInsert="Update "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory set Category='"+caegory_name+"',Limit1='"+limit+"',Status='"+Status+"' where id='"+id1+"' ";
	st2.executeUpdate(sqlInsert);
	System.out.println(sqlInsert);
	
	String sqlInsert1="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategoryhistory (id,Category,Limit1,Status) VALUES ('"+id+"','"+caegory_name+"','"+limit+"','"+Status+"')";
	st1.executeUpdate(sqlInsert1);
	System.out.println(sqlInsert1);
	
	

	
	
	response.sendRedirect("alertGoTo.jsp?msg=Record Updated/Deactivated Succssfully In System .&goto=categoryMasterReport.jsp");
	
}
catch (Exception e){e.printStackTrace();}
finally{con.close();}
%>


