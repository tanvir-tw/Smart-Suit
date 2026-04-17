<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null;
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

		String selmodule=null,txtmake=null,txtmodel=null,txtpart=null,txtdesc=null;
		selmodule=request.getParameter("lblModule");
		txtmake=request.getParameter("make");
		txtmodel=request.getParameter("model");
		txtpart=request.getParameter("part");
		txtdesc=request.getParameter("desc");
		System.out.println("MODULE===="+selmodule+"MAKE===="+txtmake+"MODEL====="+txtmodel+"PARTNO===="+txtpart+"DESCRIPTION===="+txtdesc);
		
String sqllable="update "+session.getAttribute("CompanyMasterID").toString()+"LableMaster set Module='"+selmodule+
	"',Make='"+txtmake+"', Model='"+txtmodel+"', PartNo='"+txtpart+"', Description='"+txtdesc+"'";
	st.execute(sqllable);

System.out.println( "SQL QUERY FOR UPDATION------"+sqllable);
response.sendRedirect("alertGoTo.jsp?msg=Mapping Done Successfully.&goto=home.jsp");	
}catch(Exception e)
{
	System.out.println( "Exception ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
}
finally
{
	//con.close();
}
%>			