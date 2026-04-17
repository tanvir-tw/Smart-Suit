<%@page import="com.erp.beans.ERP"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"/>
<html>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sortable/0.6.0/js/sortable.js"></script>
<script type="text/javascript" src="js/sorttable.js"></script>
<script type="text/javascript" src="js/jquery.tablesorter.pager.js"></script>
<link href="css/table.css" rel="stylesheet" type="text/css" media="screen" />

</head>
<%
Connection conn1=null;
try{

Class.forName(DB_Driver);
conn1=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

String compName="";
String cmpname="";
String collect="";
String[] ftype={"All"};
String buffer="";
String from="";
String to="";
String fromDate=null, toDate=null;
SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd");

//var queryString = "?company="+company+"&companyName="+companyName+"&ftype="+ftype+"&collect="+collect+"&from"+fromdate+"&to="+todate;
 compName=request.getParameter("companyName");
cmpname=request.getParameter("company");
ftype=request.getParameterValues("ftype");
collect=request.getParameter("collect");
from=request.getParameter("from");
to=request.getParameter("to");
//Date fromDate, toDate;
/* 
System.out.println("Company Name from selection list========"+compName);
System.out.println("Company Name from========"+cmpname);
System.out.println("Followup Type========"+ftype);
System.out.println("Collection Staff========"+collect);
 */
try{
fromDate =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(from));
toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(to));
}catch(Exception e)
{
	e.printStackTrace();	
}
	
/* System.out.println("From Date========"+fromDate);
System.out.println("To date========"+toDate);
 */
Statement st = null, st1 = null, st3 = null, st4 = null,st5=null,stcollect=null,stbranch=null;
Statement st2 = null;
st = conn1.createStatement();
st1 = conn1.createStatement();
st2 = conn1.createStatement();
st3= conn1.createStatement();
stcollect=conn1.createStatement();

buffer="<table border='1' class='sortable' id='myTable'>"
 +"<tr><th><b>Sr. No</b></th>"
+"<th><b>Company Name</b></th>"
+"<th><b>Date</b></th>"
+"<th><b>Status</b></th>"
+"<th><b>Type</b></th>"
+"<th><b>Subject</b></th>"
+"<th><b>Comments</b></th>"
+"<th><b>Marketing Representative</b></th>"
+"<th><b> Contact Person</b></th>"
+"<th><b>Spoken To</b></th>"
+"<th><b>Collection Staff</b></th>"
+"<th><b>Remark</b></th>"
+"<th><b>Next Follow-up</b></th>"
+"<th><b> Next Follow-up Type</b></th></tr>";



int i=0;
String id="";
String sql="";
String sql2="";
String AllFoloowup="";
try{
	
	compName=(request.getParameter("companyName").trim()== null || request.getParameter("companyName").trim().equalsIgnoreCase(""))?"":request.getParameter("companyName");
	cmpname=(request.getParameter("company").trim()== null || request.getParameter("company").trim().equalsIgnoreCase("-"))?"":request.getParameter("company");
	/* id=request.getParameter("custcode"); */
}catch(Exception e){}
if(null==request.getParameterValues("ftype"))
{
	/* System.out.println("IN IF FoR Followup"); */
	AllFoloowup="All";
	
}else
{
	/* System.out.println("IN EEEELLLLLSESEES FoR Followup"); */
	AllFoloowup=request.getParameter("ftype");
}

if(null==request.getParameter("collect")||request.getParameter("collect").equalsIgnoreCase("Select"))
{
	collect="";
}else
{
	collect=request.getParameter("collect");
}

/* System.out.println("----------All Followup Type are==============="+AllFoloowup.toString()); */
ResultSet rs=null;
int k=0;
ftype=AllFoloowup.split(",");
/* System.out.println("----------Number of Followup Type"+ftype.length); */

for(i=0;i<ftype.length; i++)
{
/* System.out.println("/////////////////////////////////////////////");
System.out.println(compName+"--"+collect+"---"+ftype[i].toString()); */
if(compName.equals("") && collect.equals("") && ftype[i].equalsIgnoreCase("All"))
{
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"' ";
}else if(((""!=compName ) && (collect.equals("")) && (ftype[i].toString().equals("All")))) 
	{
	/* System.out.println("111111111111"); */
		sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE  ProspCustName='"+compName.trim()+"' And FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"' ";
	}
else if((compName.equals("")) && ((collect.equals("") && "All"!=ftype[i].toString())))
{
	/* System.out.println("222222222"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType='"+ftype[i]+"' and FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";
}
else if((compName.equals("")) && (""!=collect && ftype[i].toString().equals("All")))
{
	/* System.out.println("3333333333"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE  ColloectionStaffName='"+collect+"' and FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";
}
else if((compName.equals("")) && (""!=collect && ftype[i].toString()!="All"))
{
	/* System.out.println("44444444444"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE  ColloectionStaffName='"+collect+"'and  FollowUpType='"+ftype[i]+"' and FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";

}else if((""!=compName && ""!=collect) && (ftype[i].toString().equals("All")))
{
	/* System.out.println("5555555555"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE  ColloectionStaffName='"+collect+"' and ProspCustName='"+compName.trim()+"' and FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";

}else if((""!=compName && ftype[i].toString()!="All") && (collect.equals("")))
{
	/* System.out.println("6666666666666"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE  FollowUpType='"+ftype[i].toString()+"' and ProspCustName='"+compName.trim()+"' and  FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";
}else if((""!=compName && ftype[i].toString()!="All" && ""!=collect))
{
	/* System.out.println("7777777777"); */
	sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE ColloectionStaffName='"+collect+"' and  FollowUpType='"+ftype[i].toString()+"' and ProspCustName='"+compName.trim()+"' and FollowUpDate BETWEEN '"+fromDate+"'AND '"+toDate+"'";
}


/* System.out.println("query=================="+sql); */
	rs=st.executeQuery(sql);
	
	while(rs.next())
	{
		
	String sqlrep="SELECT  *  FROM  "+session.getAttribute("CompanyMasterID").toString()+"security   WHERE EmpCode="+ rs.getString("MarketingRepcode");
	/* System.out.println("Emp IDD issss===" + rs.getString("MarketingRepcode")); */
	System.out.println("Query =>" + sqlrep);
	ResultSet rsRep=st3.executeQuery(sqlrep);
	String RepName="";
	while(rsRep.next()) {
		RepName=rsRep.getString("EmpName");
		/* System.out.println("Query 1111111111=>" +RepName ); */
		k+=1;
		
		
	buffer+="<tr><td style='padding: 4px; width:40px; text-align: right;font:normal 13px Arial,Helvtica,sans-serif;'>"+k+"</td>"
			+"<td style='padding: 4px; width:100px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("ProspCustName")+"</td>"
			+"<td style='padding: 4px; width:60px; text-align:right;font:normal 13px Arial,Helvtica,sans-serif;'>"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("FollowUpDate")))+"</td>"
			+"<td style='padding: 4px; width:60px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("Status")+"</td>"
			+"<td style='padding: 4px; width:60px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("FollowUpType")+"</td>"	
		 	+"<td style='padding: 4px; width:60px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("FollowUpSubject")+"</td>"		
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("Comments")+"</td>"		
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+RepName+"</td>"
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("ContactPerson")+"</td>"
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("SpokenTo")+"</td>"
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("ColloectionStaffName")+"</td>"			
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("Remarks")+"</td>"
			+"<td style='padding: 4px; width:80px; text-align:right;font:normal 13px Arial,Helvtica,sans-serif;'>"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("NextFollowUpDate")))+"</td>"			
			+"<td style='padding: 4px; width:80px; text-align: left;font:normal 13px Arial,Helvtica,sans-serif;'>"+rs.getString("NextFollowUpType")+"</td>";
}
}
}
buffer+="</tr>";

if(k<=0)
{
	buffer+="<tr><td colspan='15'><font size='2'>------------------------No Data Available------------------------</font></td></tr>";
}

buffer+="</table>";
out.println(buffer);
/* System.out.println("Final Result Is"+buffer); */

}catch(Exception e)
{
	
}finally
{
	conn1.close();
}
%>
</body>
</html>