<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="com.ConnectionClass"%> 
<%!
Connection conn=null;			
Statement st1 = null;
ResultSet rs,rs1;	
%>
<%
String query; String PersonList="";
String dept=request.getParameter("dept");
	System.out.println(dept);
	
try{	
	
	ConnectionClass connection= new ConnectionClass();
               conn = connection.getConnect("db_GlobalERP");    
				st1 = conn.createStatement();
	 
	        query="select EmpName as Name from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and dotprojectid!='-' and Dept='"+dept+"' order by EmpName";

	        	st1=conn.createStatement();
	        	rs= st1.executeQuery(query);
	        	String ConcernPerson="";
	        	System.out.println("Query :- "+query);
	            while(rs.next()){
	            ConcernPerson=rs.getString("Name");
	            PersonList+="<option value='"+ConcernPerson+"'>"+ConcernPerson+"</option>";
	            }
	            System.out.println("PersonList:"+PersonList);
	            out.println("<option value='Select'>Select</option>"+PersonList);

}catch(Exception e){
	            	e.printStackTrace();
	            }
        
%>