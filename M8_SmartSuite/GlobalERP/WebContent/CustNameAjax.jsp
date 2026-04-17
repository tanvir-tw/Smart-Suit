<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="com.ConnectionClass"%> 
<%!
Connection con1=null;
Statement st1=null;
ResultSet rs=null;
%>
<% 
String query = null,PersonList="",customername="";
try{				

	ConnectionClass connection= new ConnectionClass();	
		con1 = connection.getConnect("db_GlobalERP"); 
		 st1=con1.createStatement();

        String type=request.getParameter("type");
       	System.out.println(type);
        			  
	        if(type=="Internal" || type.equalsIgnoreCase("Internal")){
	        	
	            customername="Transworld";
	            System.out.println("customername..."+customername);
	            PersonList+="<option value='"+customername+"'>"+customername+"</option>";
	        }
	        else{
	        	
		        query="select distinct(TypeValue) as Name from db_gps.t_transporter where OperationalStatus ='Active' order by typevalue";
		        System.out.println(query);
	        	
	        	rs= st1.executeQuery(query);
	        	System.out.println("Query :- "+query);
	            while(rs.next()){
	            customername=rs.getString("Name");	         
	            PersonList+="<option value='"+customername+"'>"+customername+"</option>";
	            }
	      
	            }
	          //  System.out.print("PersonList:"+PersonList);
	            out.println("<option value='Select'>Select</option>"+PersonList);


}catch(Exception e){
	            	e.printStackTrace();
	            }
        
%>
