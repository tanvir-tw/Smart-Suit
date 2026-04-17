<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
	
try{	
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
		
	String comments=request.getParameter("comments");
	String date=request.getParameter("reconsiledate");
	String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date));
	String customerId=request.getParameter("custCode");
	String company=request.getParameter("company");
	String reconsiledby=request.getParameter("employee");
		
	String sqlInsert="insert into "+session.getAttribute("CompanyMasterID").toString()+"reconsilationdet (CustomerCode,CompanyName,ReconsiledUpto,ReconsiledOn,ReconsiledBy,Comments) "+
					"VALUES('"+customerId+"','"+company+"','"+todaysDate+"','"+fromdate+"','"+reconsiledby+"','"+comments+"')";
	System.out.println(sqlInsert);
	st.executeUpdate(sqlInsert);
	
	response.sendRedirect("alertGoTo.jsp?msg=Record Saved Successfully.&goto=Reconsilation.jsp");
	}
	catch(Exception e)
	{
	System.out.println( "Exception in INSERT QUOTATION ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	finally
	{
	con.close();
	}
%>