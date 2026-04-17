
<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
boolean flag=false;
String tableName="";

if(request.getParameter("group")!=null)
{
	String[] group=request.getParameter("group").split("::");
	int groupCode=Integer.parseInt(group[0]);
	String groupName=group[1];
	
	 String buffer="<select name='makename' id='makename' style='width: 150px; height:20px;  "+
	 " border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
	 " color: #000000; ' onchange='OnChange1(this);'><option value='0::"+groupCode+"::"+groupName+"::0' >Select</option>"; 
	 int i=1;
	    
	// if(groupCode<5)
	//	{
		/*
			tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
			 sql1="SELECT MakeCode,MakeName from "+tableName.toLowerCase()+" group by MakeName";
			 System.out.println(">>>>>>>>>>sql1:"+sql1);
			   rs1=stmt1.executeQuery(sql1);
			   while(rs1.next())
			   {
			      flag=true;
			      buffer+="<option value='"+rs1.getString(2)+"::"+groupCode+"::"+groupName+"::"+rs1.getString(1)+"'>"+rs1.getString(2)+"</option>";
			        i++;
			   } 
			   */
//		}
	//	else
		{
			tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
			  sql1="SELECT distinct(MakeName) from "+tableName.toLowerCase()+" group by MakeName";
			  System.out.println(">>>>>>>>>>sql1:"+sql1);
			   System.out.println(sql1);
			   rs1=stmt1.executeQuery(sql1);
			   while(rs1.next())
			   {
			      flag=true;
			      buffer+="<option value='"+rs1.getString(1)+"::"+groupCode+"::"+groupName+"::0"+"'>"+rs1.getString(1)+"</option>";
			        i++;
			   } 
		}
	
	   buffer+="</select>";
	out.println(buffer);
	//System.out.println(buffer);

}
con1.close();
} catch(Exception e) {  
	System.out.print(e);
	out.print("<select style='width: 150px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;"+ 
	     " color: #000000; '>");
	
}
finally
{
}

%>