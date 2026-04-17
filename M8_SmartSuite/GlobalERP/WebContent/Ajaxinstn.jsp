<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="conn1.jsp"%>
<%!
Connection con1;
%>

<%
try {
	System.out.println(">>> ajaxinstn>");
	Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
System.out.println("connection----->"+con1);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
String Buffer="",Buffer1="";
ResultSet rs1=null, rs2=null;
String sql1="", sql2="",transporter="",vehiclecode="",instn="",VehicleregNo="";
String ownername=request.getParameter("name");
System.out.println(">>>>>"+ownername);
int Userlimit=0,Unitlimit=0;
int i=1;
try{
sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where Createdby='"+ownername+"'";
rs1=stmt1.executeQuery(sql1);

	System.out.println("Select Queryyy------->"+sql1);

//String userrole=session.getAttribute("userrole").toString();
String html1="";
 html1=html1+"<table border='1'  align='center' class='sortable'  id='txv' style='width: 43em;'>"+
"<tr>"+
"<td><div align= 'center' ><b>Sr.No.</b></div></td>"+
"<td><div align= 'center' ><b> Beneficiary Name</b></div></td>"+

"<td> <div align= 'center' > <b>Beneficiary Account Number</b></div></td>"+
"<td><div align='center' > <b><b><input type=checkbox id='fst' onclick='checkbox();' name='' value='' /> <br /> </b></div></td>"+
"</tr>";
while(rs1.next())
{
	vehiclecode=rs1.getString("BeneficiaryName");
	VehicleregNo=rs1.getString("BeneficiaryAccountNumber");
	//instn= rs1.getString("Instruction");
	//System.out.println(">>>>>>>.");
html1=html1+"<tr>"+
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
html1=html1+"</table>";


System.out.println("content---------------->"+html1);
out.print(html1);
}catch(Exception e) {
	out.println("Exceptttttttt"+e);
}
//System.out.println(Buffer+"#"+Buffer1);
} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}




%>
