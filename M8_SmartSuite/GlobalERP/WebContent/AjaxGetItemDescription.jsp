<%@ include file="conn.jsp" %>
<script src="sorttable.js" type="text/javascript"></script>
<%!
Connection con1;
%>

<% 
try {

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql="";
boolean flag=false;

String item=request.getParameter("item");
String  searchBy=request.getParameter("searchBy");
 
   String buffer="<table border='1px'  class='sortable'><tr>"+
   						"<th>Sr no</th>"+
 					   "<th>Desc.</th>"+
					   "<th>Make Name</th>"+
					   "<th>Make Code</th>"+
					   "<th>ItemCode</th>"+
					   "<th>Model</th>"+
					   "<th>Part No</th>"+
					   "</tr>";
		
		   if(searchBy.equalsIgnoreCase("Item"))	   
				sql="SELECT  makename,makecode,ItemCode,Model,PartNo,Description  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE Description='"+item+"' ORDER BY Description";
		   
		   else if(searchBy.equalsIgnoreCase("Company"))
			   sql="SELECT  makename,makecode,ItemCode,Model,PartNo,Description  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE makename='"+item+"' ORDER BY makename ";
			   
   		 	else if(searchBy.equalsIgnoreCase("Model"))
   		 	sql="SELECT  makename,makecode,ItemCode,Model,PartNo,Description  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE Model='"+item+"' ORDER BY Model";
				   
		   else
			   sql="SELECT  makename,makecode,ItemCode,Model,PartNo,Description  FROM  "+session.getAttribute("CompanyMasterID").toString()+"searchitems WHERE PartNo='"+item+"' ORDER BY Partno";
		   
		   
		   ResultSet rs=stmt1.executeQuery(sql);
		   int i=1;
		   while(rs.next())
		   {
			   buffer+="<tr>"+
			   				"<td><div align='left'>"+i+"</div></td>"+
						   "<td align='left'><div align='left'>"+rs.getString("Description")+"</div></td>"+
						   "<td align='left'> <div align='left'>"+rs.getString("makename")+"</div></td>"+
						   "<td align='right'><div align='right'>"+rs.getString("makecode")+"</div></td>"+
						   "<td align='right'><div align='right'>"+rs.getString("ItemCode")+"</div></td>"+
						   "<td align='left'> <div align='left'>"+rs.getString("Model")+"   </div></td>"+
						   "<td align='left'> <div align='left'>"+rs.getString("PartNo")+"  </div></td>"+
						 "</tr>";
			   i++;
		   }
		   		   buffer+="</table>";
		   //System.out.println(buffer);
out.println(buffer);


} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
