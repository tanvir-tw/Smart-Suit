<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="com.ConnectionClass"%> 

<%!
Connection conn = null;
Statement st = null,st1 =null;
ResultSet rs=null;
%>
<% 	
String html="", sql_active = ""; 
String ContactPersonList="", ContactPerson="";

try{
ConnectionClass connection= new ConnectionClass();
conn = connection.getConnect("db_GlobalERP");
		 st=conn.createStatement();
		 st1=conn.createStatement();
		
		String Sesrole1= session.getAttribute("role").toString();
		String user=session.getAttribute("EmpName").toString();
		String companyMasterId=session.getAttribute("CompanyMasterID").toString();
    	String sessiondept=session.getAttribute("department").toString();
        String dept=request.getParameter("dept");
       	System.out.println(dept);
	      		  
			  if(Sesrole1.equalsIgnoreCase("-"))
			  {
				  sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and (dotprojectid!='-' or KRAdotprojectid!='-') and companyMasterId="+companyMasterId+" and (EmpName='"+user+"' or HODReport='"+user+"')";
			  }			  
			  else
			  {
			       if(Sesrole1.equalsIgnoreCase("AllAdmin"))
			       {
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and (dotprojectid!='-' or KRAdotprojectid!='-') and companyMasterId="+companyMasterId+"  order by EmpName";
			       }
			       else
			       {
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and (dotprojectid!='-' or KRAdotprojectid!='-') and companyMasterId="+companyMasterId+" and (EmpName='"+user+"' or HODReport='"+user+"') order by EmpName";
			       }
			  }	        
	        
	        	rs= st1.executeQuery(sql_active);
	        	
	        	System.out.println("in empajax.jsp page :- ");
	        	System.out.println("Query :- "+sql_active);
	            while(rs.next()){
	        	 ContactPerson=rs.getString("EmpName");
	        	html+="<option>"+ContactPerson+"</option>";
	        	ContactPersonList=ContactPersonList+","+ContactPerson;
	        	
	            System.out.println("ContactPersonList  "+ContactPersonList);

	        }	            	            
	            String FinalString=html;
	        	rs= st.executeQuery(sql_active);
	        	System.out.println("Query :- "+sql_active);
	            if(!rs.next()){
	        	 
	        }
	            else{
	            String html1="";
	            if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	            {
	            	html1="<option value='Select'>Select</option><option value='All'>All</option>";
	            	session.setAttribute("emplist",FinalString);
	            	session.setAttribute("EmployeeList",html1+FinalString);
	            	session.setAttribute("ContactPersonList",ContactPersonList);
	            	out.println(html1+FinalString);
	            }
	            else
	            {
	            	html1="<option value='Select'>Select</option>";
	            	session.setAttribute("EmployeeList",html1+FinalString);
	            	out.println(html1+FinalString);
	            }
	            }
}catch(Exception e){
	e.printStackTrace();
}
%>