

<%@ page import = "java.sql.*"%>
<%@ page import = "org.json.*"%>
 <%!
 String host = System.getenv("DB_GLOBALERP_HOST");
 String user = System.getenv("DB_GLOBALERP_USER");
 String pass = System.getenv("DB_GLOBALERP_PASS");
 
Connection con;
 Statement stmt;
 ResultSet result;
%>
<% 
String DB_Driver="com.mysql.cj.jdbc.Driver";
String DB_NAME="jdbc:mysql://"+host+"/db_GlobalERP";
String DB_NAME1="jdbc:mysql://"+host+"/newblankerp"; 
String DB_NAME2="jdbc:mysql://"+host+"/Test";

String DB_USERNAME=user;
String DB_PASSWORD=pass; 

/* String DB_USERNAME="root";
String DB_PASSWORD="root"; */


		     
    try{
    	Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
    }catch(Exception e){}
  
    
    try{
    	/* String Sesrole1= "HOD";		//session.getAttribute("role").toString();
    	String user="Vikram Puri"; //session.getAttribute("EmpName").toString();
    	String companyMasterId="100000";	//session.getAttribute("CompanyMasterID").toString();
 */
	 	String Sesrole1= session.getAttribute("role").toString();
		String user=session.getAttribute("EmpName").toString();
		String companyMasterId=session.getAttribute("CompanyMasterID").toString();
		
 
    	String sessiondept=session.getAttribute("department").toString();
    	
        String query;
        String sql_active = "";
        String dept=request.getParameter("dept");
       System.out.println(dept);
     //   stmt = con.createStatement();
        
      /*   query = "select EmpCode, EmpName from db_GlobalERP.UserMaster where dept="+dept+""; */
      
      
      	/* if (Sesrole1.equals("HOD"))
		{
			dept = request.getParameter("dept");
			System.out.println("Dep :- "+dept);
			if(dept!=null && dept.equals("AllDept"))
			{
				System.out.println("1");
		      sql_active = "select EmpName from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+"";
			
			}
			else
			{
				 System.out.println(Sesrole1);
				System.out.println("1 else");
				sql_active = "select EmpName from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+"";
				 System.out.println(sql_active);
			}
			
		}
		 else
		{
			if (Sesrole1.equals("Hr"))
			{
				System.out.println("2");
				dept = request.getParameter("dept");
				System.out.println("Dep :- "+dept);
				
			  if (dept!=null && dept.equals("AllDept") ) 
				{
				  System.out.println("2  1");
				sql_active = "select EmpName from db_GlobalERP.UserMaster where  companyMasterId="+companyMasterId+" and ActiveStatus = 'Yes' and dotprojectid!='-'  ";
				}
			  else
			  {
				  System.out.println("2 else");
				  sql_active = "select EmpName from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			  }
			} 
		}
       */
       
       String qryEmp="";
		/*   if(session.getAttribute("EmpName").equals("Vikram Puri"))
		  {
			  qryEmp="select EmpName from db_GlobalERP.UserMaster where HODReport like '%%' ";
		  }
		  else 
		  {
		  		qryEmp="select EmpName from db_GlobalERP.UserMaster where HODReport like '"+session.getAttribute("EmpName").toString()+"'"; 
		  		//String qryEmp="select EmpCode, EmpName from db_GlobalERP.UserMaster where HodReport='Reshma Maner'"; 
		  } */
		  
		  if(Sesrole1.equalsIgnoreCase("-"))
		  {
			  sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and EmpName='"+user+"' order by EmpName asc";
		  }
		  else
		  {
		       if(dept.equalsIgnoreCase("AllDept"))
		       {
		    	   sql_active="select EmpName from db_GlobalERP.UserMaster where HODReport like '%%'  and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" order by EmpName asc";
		       			//sql_active="select EmpName from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
		       }
		       else
		       {
		    	   sql_active="select EmpName from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" and EmpName!='"+user+"' order by EmpName asc";
		       }
		  }
        PreparedStatement ps = con.prepareStatement(sql_active);
        System.out.println(sql_active);
       
        result = ps.executeQuery();
        JSONArray array=new JSONArray();
        while(result.next())
        {
        	//System.out.print("Emp ");
        	String empName=result.getString("EmpName");
        	//System.out.print("Emp : "+empName);
        	  JSONObject obj = new JSONObject();
         //	 obj.put("EmpCode",result.getString("EmpCode"));
        	 obj.put("EmpName",result.getString("EmpName"));
        	
        	array.put(obj.toString());
        }
        out.println(array);
    
       /*  if(!result.next()){
        	System.out.print("0");
            out.print("0");
        }else{
        	System.out.print("1");
            JSONArray array=new JSONArray();
            do{
            	System.out.print("2");
                JSONObject obj = new JSONObject();
                obj.put("EmpCode",result.getString("EmpCode"));
                obj.put("EmpName",result.getString("EmpName"));
                String x=result.getString("EmpCode");
                System.out.println("X : "+x);
             
                array.put(obj.toString());
            }while(result.next());
            out.print(array); */
       // }
		//}
     }catch(SQLException e){
        out.print("Exception: "+e); 
    }
    finally{
        if(stmt != null){
            try{
                stmt.close();
            }catch(SQLException e){}
        }
        if(con != null){
            try{
                con.close();
            }catch(SQLException e){}
        }
    }
%>