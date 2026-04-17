<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt = 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename=filename.substring(0,cnt-1)+"_ClaimReport.xls";
}
else
{
	filename=session.getAttribute("user").toString()+"_ClaimReport.xls";
}
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>	
<%
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");

String DB_Driver="com.mysql.cj.jdbc.Driver";
String DB_NAME="jdbc:mysql:// "+host+"/db_GlobalERP";
String DB_USERNAME=user;
String DB_PASSWORD=pass;
/*String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
String DB_USERNAME="erp";
String DB_PASSWORD="1@erp";*/
Connection conn = null;
Class.forName(DB_Driver);
Statement st = null, st1 = null,st2=null,st3=null,st4=null;
String selectedName;
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",fromDateCal1="",toDateCal1="",department="",grade="";
String companyName="",phone="",contact="",email="",product="",city="",companyName1="",amount="",billNo="",status="";

String VisitCity="",departureDate="",arrivalDate="",purpose="",origin="",destination="",comments="",advanceTaken="0.00",visitTo="";
String visitTo1="",visitTo2="",visitTo3="",visitTo4="",DateCal="",claimtype="",costcenter="",cost="",Dept="";
fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
String action=request.getParameter("action");
%>
<%
try {
	conn = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();
st4 = conn.createStatement();
}
catch (Exception e)
{
	System.out.println(">>>>>Exception:"+e);
}
%>
<div align="center" style="width: 100%;font-family: Arial;font-size: large;"><b><%=request.getParameter("action").toString().replaceFirst(request.getParameter("action").toString().substring(0,1),request.getParameter("action").toString().substring(0,1).toUpperCase()) %> Claim Report</b></div>
<table align="center" border='' class='sortable'  > 
<tr>
<th>Claim Ref ID</th>
<th>Claimant Name</th>
<th>Origin</th>
<th>Destination</th>
<th>Departure</th>
<th>Arrival</th>
<th>Purpose</th>
<th>Submitted On</th>
<th>Status</th>
<th>Sum Of ClaimAmount</th>
<th>Advance Taken</th>
<th>Comments By HOD</th>
<th>Comments Approved By</th>
<th>Comments By ACCount</th>
</tr>
<% 
String deparetureDateTime="",arrivalDateTime="",claimSubmittedOn="",sqlClaim="",Status="",condition1="";

status=(action.equals("check") ? "Pending" : (action.equals("approve") ? "Checked" : "Approved" ) );	
System.out.println("\n>>>Status is:>>>>>>>>"+status);
String condition="";
String EMPName=session.getAttribute("EmpName").toString();
condition=" AND ClaimSubmittedOn >= '"+fromDate+" 00:00:00' and ClaimSubmittedOn <='"+toDate+" 23:59:59'  and Cancel='1'";
condition1=" AND ClaimSubmittedOn >= '"+fromDate+" 00:00:00' and ClaimSubmittedOn <='"+toDate+" 23:59:59' and Cancel='1'";
System.out.println("condition:"+condition+">>>>>>>>condition1:"+condition1);

if(action.equals("view"))
{
	sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE ClaimantName in ('"+EMPName+"') "+condition1+" ";

}
else if(action.equals("check"))
{
	String SqlDept="select Dept from "+session.getAttribute("CompanyMasterID").toString()+"security where  Level='Level5' and EmpName='"+EMPName+"' ";
	System.out.println(">>>>>>>SqlDept:"+SqlDept);
	ResultSet rsD=st3.executeQuery(SqlDept);
	if(rsD.next())
	{
		Dept=rsD.getString("Dept");
	}
	System.out.println(">>>>>>>Dept:"+Dept);
	if(Dept.contains("Accounts"))
	{
		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE Status in ('"+status+"') "+condition+" ";
	}
	else
	{
		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE Status in ('"+status+"') "+condition+" and Department='"+Dept+"'";
	}
}
else 
{
	sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE Status in ('"+status+"') "+condition+" ";
}
System.out.println(">>>>>>>sqlClaim:"+sqlClaim);
try
{			
ResultSet rsClaim=st.executeQuery(sqlClaim);
while(rsClaim.next())
{
    try
    { 
     if(rsClaim.getString("DepartureDateTime").contains("0000-00-00 00:00:00"))
     {
    	 deparetureDateTime="NA";
    	 System.out.println("In If Loop");
     }
     else
     {
	  deparetureDateTime=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("DepartureDateTime"))); 
     }
    }
    catch(Exception e)
    {   deparetureDateTime="NA";
    	System.out.println(e);
    }
    try
    { 
    	if(rsClaim.getString("ArrivalDateTime").contains("0000-00-00 00:00:00"))
        {
    		arrivalDateTime="NA";
    		System.out.println("In If Loop");
        }
        else
        {	
     arrivalDateTime=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("ArrivalDateTime"))); 
        }
    }catch(Exception e){ arrivalDateTime="NA"; }
    try
    { 
     claimSubmittedOn=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getString("ClaimSubmittedOn"))); 
    }catch(Exception e){ claimSubmittedOn="NA";}
%>
	 
 
	 
	 	       	 
<tr>
<td><div align="left"><%=rsClaim.getString("CLMRefNumber") %> </div></td>				      	
<td><div align="left"><%=rsClaim.getString("ClaimantName") %> </div></td>
<td><div align="left"><%=rsClaim.getString("Origin") %></div></td>
<td><div align="left"><%=rsClaim.getString("Destination") %></div></td>
<td><div align="right"><%=deparetureDateTime %></div></td>
<td><div align="right"><%=arrivalDateTime %></div></td>
<td><div align="left"><%=rsClaim.getString("Purpose") %></div></td>
<td><div align="right"><%=claimSubmittedOn %></div></td>
<td><div align="left"><font color="red"><%=rsClaim.getString("Status") %></font></div></td>
<td><div align="right"><%=rsClaim.getString("SumOfClaimAmount") %></div></td>
<td><div align="right"><%=rsClaim.getString("AdvanceTaken") %></div></td>
<td><div align="left"><%=rsClaim.getString("CommentsByHOD") %></div></td>
<td><div align="left"><%=rsClaim.getString("CommentsApprovedBy") %></div></td>
<td><div align="left"><%=rsClaim.getString("CommentsByACDepa") %></div></td>
</tr>
<%
}
}
catch (Exception e) 
{
 System.out.println("\n>>>>>>>>Exception:"+e);
}
%>
</table>
</div>	
<br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br> 
<div id="footer">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
</div>
<!-- end #footer -->
</jsp:useBean>