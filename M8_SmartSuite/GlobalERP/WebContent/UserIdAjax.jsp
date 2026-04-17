
<%@ include file="conn.jsp"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>

<% 
try{	
			Connection conn=null;
			Statement stmt=null;
			
			Class.forName(DB_Driver);
			conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
			 
		
		
		Statement st=conn.createStatement();
		Statement st1=conn.createStatement();
		    	
        String query="";
        String AssignedTo=request.getParameter("AssignedTo");
        String task=request.getParameter("task");

       System.out.println(AssignedTo);
       System.out.println(task);

	        ResultSet rs,rs1;
			 
	        if(task.equalsIgnoreCase("PI")){
	        query="select dotprojectid from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and EmpName='"+AssignedTo+"'";

	        	rs= st1.executeQuery(query);
	        	
	        	String UserId="";
	        	System.out.println("Query :- "+query);
	            while(rs.next()){
	            	UserId=rs.getString("dotprojectid");
	      
	            }
	            out.println(UserId);
	        }else{
	        	
	        	  query="select KRAdotprojectid from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and EmpName='"+AssignedTo+"'";

		        	rs= st1.executeQuery(query);
		        	
		        	String UserId="";
		        	System.out.println("Query :- "+query);
		            while(rs.next()){
		            	UserId=rs.getString("KRAdotprojectid");
		      
		            }
		            out.println(UserId);
	        	
	        }

}catch(Exception e){
	            	e.printStackTrace();
	            }
        
%>
