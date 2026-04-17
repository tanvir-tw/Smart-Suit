<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
System.out.println("reach in searchitem.jsp");
	Connection con1 = null;
%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
String item=request.getParameter("item");
String  searchBy=request.getParameter("searchBy");
Statement st1 = con1.createStatement();
ResultSet rs=null;
String sql="";
String Com=(String)session.getAttribute("CompanyMasterID");
if(searchBy.equalsIgnoreCase("Item"))	   
	sql="SELECT  *  FROM  "+Com+"searchitems WHERE Description='"+item+"' ORDER BY Description LIMIT 1";
System.out.println("sql------"+sql);
rs=st1.executeQuery(sql);
int i=1;
/* make="&group&srno&description=&quantity=&model&modelNotKnown=&specification= */
String make="",model="",itemSelected="",part="",description="",group="";
String groupcode="",makecode="";
while(rs.next())
{
	/* Group 	Make 	Model 	Part No 	Description */
	group=rs.getString("GroupName");
	make=rs.getString("makename");
	itemSelected=rs.getString("ItemCode");
	model=rs.getString("Model");
	groupcode=rs.getString("groupcode");
	makecode=rs.getString("makecode");
	
	
	
	/* if(model.equalsIgnoreCase("-")){
		model="NA";
	} */
	part=rs.getString("PartNo");
	description=rs.getString("Description");
	
	out.print("<input type='hidden' name='groupcode' id='groupcode1' value='"+groupcode+"'>");
	out.print("<input type='hidden' name='makecode' id='makecode1' value='"+makecode+"'>");
	out.print("<input type='hidden' name='groupname' id='groupname1' value='"+group+"'>");
	out.print("<input type='hidden' name='makenew' id='makenew' value='"+make+"'>");
	out.print("<input type='hidden' name='itemSelected' id='itemSelected1' value='"+itemSelected+"'>");
	out.print("<input type='hidden' name='model' id='modelnew' value='"+model+"'>");
	out.print("<input type='hidden' name='part'name='part' id='part' value='"+part+"'>");
	out.print("<input type='hidden' name='description' id='description' value='"+description+"'>");
	System.out.println(group+"+"+make+"+"+itemSelected+"+"+model+"+"+part);
}
%>


</body>
</html>