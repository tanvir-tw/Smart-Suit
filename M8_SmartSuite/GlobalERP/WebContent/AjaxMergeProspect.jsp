 <%@page import="java.io.Flushable"%>
 <%@ include file="conn.jsp" %>

<%@page import="java.util.StringTokenizer"%><html>
<head>

<script type="text/javascript">

</Script>
</head>
<%!
Connection con;
%>

<% 
session.setAttribute("flag","company");
try 
{
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st=con.createStatement();
Statement st1=con.createStatement();
Statement st2=con.createStatement();
Statement st3=con.createStatement();

%>
<body>
<%
String todaysdate="",entryby="";
String valueis=request.getParameter("save");

String margecmp=request.getParameter("mergename");
String margecode=request.getParameter("companyCode");


System.out.println("Hiiiiiiiiiiii22222222222iimargecmp "+margecmp);
System.out.println("Hiiiiiiiiii44444444iimargecmp "+margecode);
System.out.println("value of a"+valueis);

entryby=session.getAttribute("EmpName").toString();
//out.print("Value is "+valueis );
	  java.util.Date NewDate =new java.util.Date();

		 todaysdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(NewDate);
		 String otherreason="";
		 String other=request.getParameter("other");

		 String comment=request.getParameter("comment");

		 
		 if(comment=="Other" || comment.equalsIgnoreCase("Other"))
		 {
		 	otherreason=other;
		 	
		 	String sqlck="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge where Reason='"+otherreason+"' and Category='Prospect'";
		     System.out.println("NON insert for other query"+sqlck);

		 	ResultSet rsck=st.executeQuery(sqlck);
		 	if(rsck.next())
		 	{
		 		
		 	    System.out.println("NON insert for other query");

		 	}
		 	else{
		 	String sqloth="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge(Reason,EntryBy,Category)values('"+otherreason.replaceAll("'"," ")+"','"+entryby+"','Prospect')";
		      st1.executeUpdate(sqloth);
		 	
		     System.out.println("insert for other query"+sqloth);
		     }
		 	}
		 else
		 {
		 	otherreason=comment;
		 }

		 
		 
		 try{
		 
				System.out.println("In try block");

StringTokenizer stm=new StringTokenizer(valueis,"/");
while(stm.hasMoreTokens())
{
	String token=stm.nextToken();
	System.out.println("Token is " +token);
	String cmp=token.substring(0,token.indexOf("*"));
	
	String cmpcode=token.substring(token.indexOf("*")+1);

		System.out.println("Cmp="+cmp);
		System.out.println("code="+cmpcode);
		
		String sql="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup set ProspCustCode='"+margecode+"',ProspCustName='"+margecmp+"' where ProspCustCode='"+cmpcode+"' and ProspCustName='"+cmp+"' ";
		st1.executeUpdate(sql);
		System.out.println("update 2>>>>>>>>>"+sql);
		
		String sql3="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster set customer_code='"+margecode+"',customer='"+margecmp+"' where customer_code='"+cmpcode+"' and customer='"+cmp+"' ";
		st2.executeUpdate(sql3);

		System.out.println("update 3>>>>>>>>>"+sql3);
		
String sql1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"Prospectmargehistory(Date,Oldprospectcode,Oldprospectname,Newprospectcode,Newprospectname,MergeBy,ReasonForMerge)values('"+todaysdate+"','"+cmpcode+"','"+cmp+"','"+margecode+"','"+margecmp+"','"+entryby+"','"+otherreason+"')";
		

		st2.executeUpdate(sql1);
System.out.println("insert 2>>>>>>>>>"+sql1);


String sql2="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster set IsDataValid='0' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"'";
st2.executeUpdate(sql2);




	}

//String msg = "Procpect Marged Successfully";

response.sendRedirect("Mergeprocpect.jsp?msg=yes");

		 }catch(Exception e)
		 {
			 
			 
			 e.printStackTrace();
		 }

%>

<%
}catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect("alert.jsp?msg=!!! ERROR while marging record in System.Please try  again");

}

%>


</body>
</html>