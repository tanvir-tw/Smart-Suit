<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<html>
<style type="text/css">

.inputbox {
vertical-align: left;
}


</style>



<script type="text/javascript">


function Redirect1()
{
	alert("Please Select Representative and Check Row ");
	window.open("CustomerMaster1.jsp");
	//window.location="CustomerMaster1.jsp";
	window.close();
	
}

function addRow()
{
	//alert("Hi");
	
	var allocate=document.getElementById("group").value;
	
	//alert("allocate "+allocate);
	
	
	if(allocate=="" || allocate=="Select")
		{
		
		alert("Please Select Marketing Representative");
		
		return false;
		}
	
	
	var representativecode=document.getElementById("group").value;
	var AssignedTo=document.getElementById("AssignedTo").value;
	var company=document.getElementById("company").value;
	var code=document.getElementById("code").value;
	var type=document.getElementById("type").value;
	var comm=document.getElementById("sep").value;

	window.location="ReAllocationAction.jsp?company="+company+"&AssignedTo="+AssignedTo+"&comm="+comm+"&representativecode="+representativecode+"&code="+code+"&type="+type+"";
	
	return true;
}

function calculate(){
	//alert("calculate");
	  var type=document.getElementById("company").value;
	  
	  var code=document.getElementById("type").value;
	  
	//  alert("Type :- "+type);
	//  alert("Code :- "+code);
	  
}

function calculate1(){
	//alert("calculate");
	
	var type=document.getElementById("company").value;
	  
	  var code=document.getElementById("type").value;
	  
	 // var Name=document.getElementById("CompanyName").value;
	  
	 
	  
	  var webadd="CustReallocation.jsp";
	  
	  window.open(webadd+'?Code='+type+'&Type='+code+'','','width=565,height=320,top=200,left=300,resizable=no');
      //window.open("ReAllocationNew.jsp",null,"height=200,width=400,status=yes,toolbar=no,menubar=no,location=no");
}
</script>

<body onload="calculate1()">
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>

<%
		Connection conn = null;
String comm="";
		Statement st = null,st1 = null,st4 = null,stlbl=null;
		Format format=new SimpleDateFormat("dd-MMM-yyyy");
		Format parse=new SimpleDateFormat("yyyy-MM-dd");
		String fromDate="",toDate="",fromDateCal="",toDateCal="";
		String companyName="",phone="",contact="",email="",product="",city="";
		Date today = new Date();
		int k=0;
 		
 		String Query="";
 		String MarkCode="",MarkName="";
 		String Assignto="";
 		String username="",companyname="";
 		String usermaster="";
		StringBuffer buffer=new StringBuffer(","); 
int j=0;
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
 		try 
 		{
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st4 = conn.createStatement();
				stlbl = conn.createStatement();
		} 
 		catch (Exception e) 
 		{
		
 		}
 		String Type=request.getParameter("Type");
 		System.out.println("Type :-"+Type);
 		
 		
 		String no=request.getParameter("checkedNumber");
 		System.out.println("checkedNumber :-"+no);

 		if(Type==null)
 		{
 			out.println("<script>  Redirect1();</script>");
 		}
 		int len=Integer.parseInt(request.getParameter("checkedNumber").toString());
 		System.out.println("len::"+len);
 		
 		if(len==0)
 		{
 			out.println("<script>  Redirect1();</script>");
 		}
 		
 		while( j!=(Integer.parseInt(request.getParameter("checkedNumber").toString())))
 		{
 		if(request.getParameter("check"+j)!=null)
 		buffer.append(j+",");
 		
 		String s=request.getParameter("check"+j);
 		System.out.println("s::"+s);

 			j++;
 		}
 		
 		String Company=request.getParameter("Company");
 		System.out.println("Company :-"+Company);
 		
 		String Code=request.getParameter("Code");
 		System.out.println("Code :-"+Code);
 		
 		for(int h=0;h < len;h++)
 		{


 		if(buffer.toString().contains(","+k+","))
 		{

 			String first=request.getParameter("net_id1"+k) ;
 			System.out.println("first::"+first);
 			
 			comm=comm+","+first;
 			
 			 companyname=request.getParameter("net_id2"+k) ;
 			System.out.println("companyname::"+companyname);

 		
 		if(Type.equals("Customer"))
 		{
 			Query="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where salescustomercode="+first+" order by AllocatedTo desc limit 1";
 			
 		}
 		else
 		{
 			Query=" select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where customercode="+first+" order by AllocatedTo desc limit 1";
 		}
 		
 		ResultSet RsQuery=st1.executeQuery(Query);
 		
 		System.out.println("Query :-"+Query);
 	
 		while(RsQuery.next())
 		{
 			Assignto=RsQuery.getString("AllocatedTo");
 			companyname=RsQuery.getString("CompanyName");
 			
 		}
 		
 		usermaster="select * from UserMaster where EmpCode='"+Assignto+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
 		System.out.println("Query :-"+usermaster);
			ResultSet rsuser=st4.executeQuery(usermaster);
			
			if(rsuser.next())
			{
				username=rsuser.getString("EmpName");
			}
 		}
			System.out.println("omm::"+comm);

 		k++;
 		
 		}
%>

<%			System.out.println("omm::"+comm);
 %>
 
<input type="hidden" name="company" id="company" value=<%=comm %>>
<input type="hidden" name="type" id="type" value=<%=Type %>>
<input type="hidden" name="CompanyName" id="CompanyName" value=<%=Company %>>


<%

//response.sendRedirect("ReAllocationAction.jsp");
//window.open("ReAllocationAction.jsp?+Company="+comm+"&Type="+Type+",width=565,height=320,top=200,left=300,resizable=no");
%>
<!-- <div id="divId" style="display:none;">
<input type="text" value=comm/>
<input type="text" value=type/>

</div>
 -->
 
 </body>
</html>
</jsp:useBean>