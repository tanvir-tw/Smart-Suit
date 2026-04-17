
<%@page import="com.sun.xml.internal.ws.client.SenderException"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%@ include file="ConnForIncident.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
Statement stmt=null;
String user=session.getAttribute("user").toString();
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";
System.out.println("user-->"+user+"date"+todaysDate);
%>
<%
boolean isInvoiceSelected=false;
try{

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	
	String caegory_name=request.getParameter("category_name");
	String limit=request.getParameter("limit");
	int id=0,id1=0;
	

	
	
	
	System.out.println("limit---->"+limit);
	System.out.println("testtt 1");
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory (Category,Limit1) VALUES ('"+caegory_name+"','"+limit+"')";
	st1.executeUpdate(sqlInsert);
	System.out.println("category query"+sqlInsert);

 


	
	response.sendRedirect("alertGoTo.jsp?msg=Data Inserted Succssfully In System .&goto=categoryMasterReport.jsp");
	
}
catch (Exception e){e.printStackTrace();}
finally{con.close();}
%>


