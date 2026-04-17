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


String margeitem=request.getParameter("mergename");
String gCode=request.getParameter("gCode");

String gname=request.getParameter("gname");
String mcode=request.getParameter("mcode");
String itemCode=request.getParameter("itemCode");
String partno=request.getParameter("partno");
String price=request.getParameter("price");







System.out.println("price    >>>>>  of a" +price);

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
		 	
		 	String sqlck="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge where Reason='"+otherreason+"' and Category='Item'";
		     System.out.println("NON insert for other query"+sqlck);

		 	ResultSet rsck=st.executeQuery(sqlck);
		 	if(rsck.next())
		 	{
		 		
		 	    System.out.println("NON insert for other query");

		 	}
		 	else{
		 	String sqloth="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ReasonForMerge(Reason,EntryBy,Category)values('"+otherreason.replaceAll("'"," ")+"','"+entryby+"','Item')";
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
	String gcode1="",gname1="",mcode1="",icode1="",partno1="",price1="";
	
	
	String arr[]=token.split("~");
	
	
	System.out.println("search nm is " +arr[0]);
	
	
	System.out.println("groupcode is " +arr[1]);

	
	System.out.println("grp name is " +arr[2]);
	System.out.println("mk code is " +arr[3]);

	
	System.out.println("item code is " +arr[4]);

	System.out.println("part no  is " +arr[5]);
	System.out.println("price  is " +arr[6]);

	
		String mname="",mtable="",model="",des="",prdate="";
		
		String sql1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where groupcode='"+gCode+"' and GroupName='"+gname+"' and makecode='"+mcode+"' and ItemCode='"+itemCode+"'";
		ResultSet rs=st.executeQuery(sql1);
		if(rs.next())
		{
			mname=rs.getString("makename");
			mtable=rs.getString("makedettable");
			model=rs.getString("Model");
			des=rs.getString("Description");
			try{
			prdate=rs.getString("pricedate");
			}catch(Exception e)
			{
				prdate="0000-00-00";
			}
			
		}

System.out.println("value of price date is " +prdate);


String sql3="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitemstest set Newgroupcode='"+gCode+"', NewGroupName='"+gname+"',Newmakecode='"+mcode+"',Newmakename='"+mname+"',Newmakedettable='"+mtable+"',NewItemCode='"+itemCode+"',NewModel='"+model+"',NewPartNo='"+partno+"',NewDescription='"+des+"',NewPrice='"+price+"',Newpricedate='"+prdate+"' where groupcode='"+arr[1]+"' and GroupName='"+arr[2]+"' and makecode='"+arr[3]+"' and ItemCode='"+arr[4]+"' ";
st3.executeUpdate(sql3);
System.out.println("Final insert query   is " +sql3);


	}

String msg = "Item Marged Successfully";

response.sendRedirect("itemmerging.jsp?msg=yes");



%>

<%
}catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect("alert.jsp?msg=!!! ERROR while merging record in System.Please try  again");

}

%>


</body>
</html>