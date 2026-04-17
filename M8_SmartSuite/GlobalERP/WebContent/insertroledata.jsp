<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@ include file="conn.jsp"%>

<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>

<%
boolean isInvoiceSelected=false;
try{
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
}catch(Exception e){}

try{
String sql1="",eachmodule="";
int count=0,rino,rowid;
boolean flag=false;

String rolename=request.getParameter("rolename");
System.out.println("role name   "+rolename);
String a=request.getParameter("modules");
System.out.println(a);		
String description=request.getParameter("roledesc");

String sqlno="SELECT MAX(RoleID) from "+session.getAttribute("CompanyMasterID").toString()+"roles_master ";
ResultSet rs=st2.executeQuery(sqlno);
System.out.println(sqlno);
rs.next();  
	rino=rs.getInt(1);
	rino++;
System.out.println("&&&&****&& N "+rino);

String sql="Insert into "+session.getAttribute("CompanyMasterID").toString()+"roles_master (RoleID,RoleName,RoleDescription) values ('"+rino+"','"+rolename+"','"+description+"')";
System.out.println(sql);
st1.executeUpdate(sql);




StringTokenizer singlesup=new StringTokenizer(a,",");
count=singlesup.countTokens();
System.out.println("Count is:   "+count);

for(int i=1;i<=count;i++)
{	
if(singlesup.hasMoreTokens())
{
	eachmodule =singlesup.nextToken();
	System.out.println("Single module is:"+eachmodule);
	
	String sqlrd="select RoleID from "+session.getAttribute("CompanyMasterID").toString()+"roles_master where RoleName='"+rolename+"'";
	ResultSet rssql=st2.executeQuery(sqlrd);
	rssql.next();
	String rid=rssql.getString(1);
	
	String sql00="SELECT MAX(Rid) from "+session.getAttribute("CompanyMasterID").toString()+"roles_menumaster";
	ResultSet rs00=st1.executeQuery(sql00);
	System.out.println(sql00);
	rs00.next();  
		rowid=rs00.getInt(1);
		rowid++;
	System.out.println("&&&&****&& N "+rino);
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"roles_menumaster(Rid,RoleID,MenuID) value ('"+rowid+"','"+rid+"','"+eachmodule+"')";
	System.out.println(sqlInsert);	
	st1.executeUpdate(sqlInsert);
}
}

System.out.println("22222222222222222222   ");


out.print("yes");

}catch(Exception e)
{
	System.out.println( "Exception ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again. \n\n \n\n   "+e.toString().replace("'"," --")+"&goto=javascript:history.back()");
	out.print("no");

}

%>	