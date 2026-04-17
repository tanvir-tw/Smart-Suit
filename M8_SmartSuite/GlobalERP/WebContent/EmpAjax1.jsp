<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="com.ConnectionClass"%> 

<%!
Connection con1=null;
Statement st1 =null,st=null;
ResultSet rs=null;
%>
<% 
String html="";
String ContactPersonList="",qryEmp="";
String query;
String sql_active = "";

try{
ConnectionClass connection= new ConnectionClass(); 
con1 = connection.getConnect("db_GlobalERP"); 
		st=con1.createStatement();
		st1=con1.createStatement();
	
		String Sesrole1= session.getAttribute("role").toString();
		String user=session.getAttribute("EmpName").toString();
		String companyMasterId=session.getAttribute("CompanyMasterID").toString();
    	String sessiondept=session.getAttribute("department").toString();  	

        String dept=request.getParameter("dept");
       	System.out.println(dept);
	  
			  if(Sesrole1.equalsIgnoreCase("-"))
			  {
				  sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and (EmpName='"+user+"' or HODReport='"+user+"')";
			  }			  
			  else
			  {
			       if(Sesrole1.equalsIgnoreCase("AllAdmin"))
			       {
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+"  order by EmpName";
			       			//sql_active="select EmpName from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			       }
			       else
			       {
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and (EmpName='"+user+"' or HODReport='"+user+"') order by EmpName";
			       }
			  }	        
	        
	        	st1=con1.createStatement();
	        	rs= st1.executeQuery(sql_active);
	        	String ContactPerson="";
	        	System.out.println("Query :- "+sql_active);
	            while(rs.next()){
	        	 ContactPerson=rs.getString("EmpName");
	        	html+="<option>"+ContactPerson+"</option>";
	        	ContactPersonList=ContactPersonList+","+ContactPerson;
	        	
	            System.out.println("ContactPersonList  "+ContactPersonList);

	        }	            	            
	            String FinalString=html;
	            st=con1.createStatement();
	        	rs= st.executeQuery(sql_active);
	        	System.out.println("Query :- "+sql_active);
	            if(!rs.next()){
	        	 
	        }
	            else{
	            String html1="";
	            if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	            {
	            	html1="<option value='Select'>Select</option>";
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