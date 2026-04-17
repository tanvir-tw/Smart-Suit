
<%@ include file="conn.jsp"%>
<%@page import="java.util.List"%>

<%!
Connection con1;
%>

<%
try {
	System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxAccountDelete.jsp>>>>>>>>>>>>>>>>");	
	Class.forName(DB_Driver);
	con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
String Buffer="",Buffer1="";
ResultSet rs1=null, rs2=null;
String sql1="", sql2="",transporter="",vehiclecode="",instn="",VehicleregNo="";
String Entryname=request.getParameter("name");
System.out.println(">>>>>"+Entryname);
int Userlimit=0,Unitlimit=0;
int i=1;
try{
sql1="Select EnteredBy  from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where OwnerName='"+Entryname+"'";
rs1=stmt1.executeQuery(sql1);

	System.out.println(sql1);

String userrole=session.getAttribute("userrole").toString();
String html="Add Instruction for " +Entryname;
 html=html+"#<table border='0'  align='center' class='sortable'  id='txv' style='width: 43em;'>"+
"<tr   >"+
"<td><div align= 'center' ><b>Sr.No.</b></div></td>"+
"<td><div align= 'center' ><b> Account No </b></div></td>"+
"<td><div align= 'center' ><b> Account No </b></div></td>"+
"<td> <div align= 'center' > <b>Beneficiary Name </b></div></td>"+
"<td><div align='center' > <b><b><input type=checkbox id='fst' onclick='checkbox();' name='' value='' /> <br /> </b></div></td>"+
"</tr>";
while(rs1.next())
{
	vehiclecode=rs1.getString("VehicleCode");
	VehicleregNo=rs1.getString("VehicleRegNumber");
	instn= rs1.getString("Instruction");
	//System.out.println(">>>>>>>.");
html=html+"<tr>"+
	"<td><div align='right' >  "+i+"</div></td>"+
	"<td><div align= 'left'> "+VehicleregNo+"</div></td>"+
	
	"<td><div align='left' >"+instn+"</div></td>"+
	"<td><div align= 'center' >  <input type='checkbox' name='chkbx' id='ab"+i+"'     type='checkbox'   value='"+vehiclecode+"' onclick = 'mychkbx()' /> <br /></div></td>"+
	"</tr>";
	
	i++;
	
	
//	if(Buffer=="" && Buffer1=="")
//	{
//		Buffer = vehiclecode;
	//	Buffer1 =instn;
//	}
//	else
//	{
//		Buffer = Buffer+","+vehiclecode;
//		Buffer1 =Buffer1+","+instn;
//	}
	
}
html=html+
"</table>";


System.out.println(html);
out.print(html);
}catch(Exception e) {
	out.println(e);
}
//System.out.println(Buffer+"#"+Buffer1);
} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>
