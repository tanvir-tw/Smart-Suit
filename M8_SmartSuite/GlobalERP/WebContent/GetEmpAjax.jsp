<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>
 --%>
 <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  
<%@ include file="conn.jsp"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>



<%!
Connection con1;
%>
<% 
		
		String html="";
		String DB_Driver1="com.mysql.cj.jdbc.Driver";
		String DB_NAME4="jdbc:mysql://"+host1+"/db_GlobalERP";
		String DB_NAME2="jdbc:mysql://"+host1+"/newblankerp"; 
		String DB_NAME3="jdbc:mysql://"+host1+"/Test";

		String DB_USERNAME1=user1;
		String DB_PASSWORD1=pass1; 
		
		
		
	    	Class.forName(DB_Driver);
			con1 = DriverManager.getConnection(DB_NAME4,DB_USERNAME1,DB_PASSWORD1);
	    
		
		
		Statement st=con1.createStatement();
		Statement st1=con1.createStatement();
		
		
		
		String Sesrole1= session.getAttribute("role").toString();
		String user=session.getAttribute("EmpName").toString();
		String companyMasterId=session.getAttribute("CompanyMasterID").toString();
		
 
    	String sessiondept=session.getAttribute("department").toString();
    	
        String query;
        String sql_active = "";
        String dept=request.getParameter("dept");
       System.out.println(dept);
	        ResultSet rs,rs1;
	        String qryEmp="";		  
			/*   if(Sesrole1.equalsIgnoreCase("-"))
			  {
				  sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and (EmpName='"+user+"')";
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
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" order by EmpName";
			       }
			  }	 */
			  
			  
			       if(dept.equalsIgnoreCase("AllDept") || dept.equalsIgnoreCase("All"))
			       {
			    	   if (Sesrole1.equals("HOD")){
			    		   
							  sql_active = "select distinct(EmpName) as EmpName from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept  like '%%'  and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  order by dept";
			        			
				            	
				             }else{
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept like '%%' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
				             }
			       			//sql_active="select EmpName from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			    	   System.out.println("ajax query in AllDept ELSEEEEE  IFFFFFF\n"+sql_active);
			       }
			       else
			       {if (Sesrole1.equals("HOD") ||  Sesrole1.equals("Hr") || Sesrole1.equals("AllAdmin")){
		    		   
						  sql_active = "select distinct(EmpName) as EmpName from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept= '"+dept+"'  and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  order by dept";
		        			
			            	
			       }else
			             {
			    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and EmpName!='"+user+"'";
			             }
			    	   System.out.println("ajax query in AllDept ELLSSEEEE eLSEEEEEEE\n"+sql_active);
			       }
			  
	        PreparedStatement ps = con1.prepareStatement(sql_active);
	        System.out.println(sql_active);
	        
	        	st1=con1.createStatement();
	        	rs= st1.executeQuery(sql_active);
	        	String ContactPerson="";
	        	System.out.println("Query :- "+sql_active);
	            while(rs.next()){
	        	 ContactPerson=rs.getString("EmpName");
	        	html+="<option>"+ContactPerson+"</option>";
	        }
	            
	            
	            String FinalString=html;
	            st=con1.createStatement();
	        	rs= st.executeQuery(sql_active);
	        	String ContactPerson1="";
	        	System.out.println("Query :- "+sql_active);
	            if(!rs.next()){
	        	 
	        }
	            else{
	            String html1="";
	            if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	            {
	            	html1="<option value='Select' selected='selected'>Select</option> \n <option value='All' selected='selected'>All</option>";
	            	out.println(html1+FinalString);
	            }
	            else
	            {
	            	html1="<option value='Select' selected='selected'>Select</option>";
	            	out.println(html1+FinalString);
	            }
	            }
	            
	        
		
        
        
       
        
%>
</jsp:useBean>
