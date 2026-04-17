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

System.out.println("Hiiiiiiiiiiii22222222222ii"+margecmp);
System.out.println("Hiiiiiiiiii44444444ii"+margecode);
System.out.println("value of a"+valueis);

String comcode=session.getAttribute("CompanyMasterID").toString();
String sql1="";
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
		 	
		 	String sqlck="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge where Reason='"+otherreason+"' and Category='Customer'";
		     System.out.println("NON insert for other query"+sqlck);

		 	ResultSet rsck=st.executeQuery(sqlck);
		 	if(rsck.next())
		 	{
		 		
		 	    System.out.println("NON insert for other query");

		 	}
		 	else{
		 	String sqloth="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge(Reason,EntryBy,Category)values('"+otherreason.replaceAll("'"," ")+"','"+entryby+"','Customer')";
		      st1.executeUpdate(sqloth);
		 	
		     System.out.println("insert for other query"+sqloth);
		     }
		 	}
		 else
		 {
		 	otherreason=comment;
		 }





StringTokenizer stm=new StringTokenizer(valueis,"/");
while(stm.hasMoreTokens())
{
	String token=stm.nextToken();
	System.out.println("Token is " +token);
	String cmp=token.substring(0,token.indexOf("*"));
	
	String cmpcode=token.substring(token.indexOf("*")+1);

		//System.out.println("Cmp="+cmp);
		//System.out.println("code="+cmpcode);
		
		

		
		

    sql1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customermargehistory(Date,Oldcustomercode,OldCustomername,Newcustomercode,Newcustomername,ReasonForMerge,MergeBy)values('"+todaysdate+"','"+cmpcode+"','"+cmp+"','"+margecode+"','"+margecmp+"','"+otherreason+"','"+entryby+"')";


		st2.executeUpdate(sql1);
System.out.println("insert 2>>>>>>>>>"+sql1);


String sql2="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet set IsDataValid='0' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"'";
st2.executeUpdate(sql2);
System.out.println("insert sql2>>>>>>>>>"+sql2);

String sql21="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster set IsDataValid='0' where SalesCustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"'";
st2.executeUpdate(sql21);

System.out.println("insert sql21>>>>>>>>>"+sql21);




String sql3="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesenq_det set Newcustomercode='"+margecode+"', Newcompanyname='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"' ";
st3.executeUpdate(sql3);
System.out.println("insert sql3>>>>>>>>>"+sql3);
String sql4="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesquo_det set Newcustomercode='"+margecode+"', Newcompanyname='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"' ";
st3.executeUpdate(sql4);
System.out.println("insert sql4>>>>>>>>>"+sql4);
String sql5="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesorder_det set Newcustomercode='"+margecode+"', Newcompanyname='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"' ";
st2.executeUpdate(sql5);
System.out.println("insert sql5>>>>>>>>>"+sql5);

String sql6="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet set Newcustomercode='"+margecode+"', Newcompanyname='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"' ";
st3.executeUpdate(sql6);
System.out.println("insert sql6>>>>>>>>>"+sql6);
String sql7="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet set Newcustomercode='"+margecode+"', Newcompanyname='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CompanyName='"+cmp+"' ";
st3.executeUpdate(sql7);
System.out.println("insert sql7>>>>>>>>>"+sql7);
String sql8="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set CreditParty='"+margecmp+"' where CustomerCode='"+cmpcode+"' and CreditAmount > 0 ";
st3.executeUpdate(sql8);
System.out.println("insert sql8>>>>>>>>>"+sql8);

String sql9="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set DebitParty='"+margecmp+"' where CustomerCode='"+cmpcode+"' and DebitAmount > 0 ";
st1.executeUpdate(sql9);
System.out.println("insert sql9>>>>>>>>>"+sql9);


String sql10="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set CustomerCode='"+margecode+"' where CustomerCode='"+cmpcode+"'";
st2.executeUpdate(sql10);
System.out.println("insert sql10>>>>>>>>>"+sql10);


String sql11="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccounthistory(Date,Oldcustomercode,Newcustomercode,ReasonForMerge,MergeBy)values('"+todaysdate+"','"+cmpcode+"','"+margecode+"','"+otherreason+"','"+entryby+"')";
st.executeUpdate(sql11);
System.out.println("insert sql11>>>>>>>>>"+sql11);


//String margecmp1=request.getParameter("mergename");
String margecode1=request.getParameter("companyCode");

String sql14="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where salescustomercode='"+margecode1+"'";
ResultSet rs=st.executeQuery(sql14);

System.out.println("update opportunity merge prospectivecust query--------->"+sql14);
if(rs.next())
{
	
	margecode=rs.getString("CustomerCode");
	margecmp=rs.getString("CompanyName");
	
	String sql15="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where salescustomercode='"+cmpcode+"'";
	ResultSet rs1=st.executeQuery(sql15);
	
	System.out.println("update opportunity comp prospectivecust query----->"+sql14);
	
	while(rs1.next())
	{
		cmpcode=rs1.getString("CustomerCode");
		cmp=rs1.getString("CompanyName");
	}
	
	
	String sql13="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster set customer_code='"+margecode+"',customer='"+margecmp+"' where customer_code='"+cmpcode+"' and customer='"+cmp+"' ";
	st2.executeUpdate(sql13);
	
	System.out.println("update opportunity>>>>>>>>>"+sql13);
	
	
	String sql="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup set ProspCustCode='"+margecode+"',ProspCustName='"+margecmp+"' where ProspCustCode='"+cmpcode+"' and ProspCustName='"+cmp+"' ";
	st1.executeUpdate(sql);
	System.out.println("update followup>>>>>>>>>"+sql);
}






	}

String msg = "Customer Marged Successfully";

response.sendRedirect("MergeCustomer.jsp?msg=yes");



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