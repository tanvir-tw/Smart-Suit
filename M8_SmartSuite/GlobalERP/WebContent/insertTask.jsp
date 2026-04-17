<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@page import="java.util.Date.*"%>
 <script>
function Redirect()
{
	alert("Task Added Successfully");
    window.location="TaskAllocationReport.jsp";
	
}
function Redirect1()
{
	alert("KRA Added Successfully");
    window.location="TaskAllocationReport.jsp";
	
}

</script>
<%

try{	   

	String host = System.getenv("DB_GLOBALERP_HOST");
	String user = System.getenv("DB_GLOBALERP_USER");
	String pass = System.getenv("DB_GLOBALERP_PASS");
	
	         	Connection conn = null;
				 Statement st = null;
				 Statement st1 = null;
				 Statement st2 = null;
				 Statement st3 = null;
				
				 String userid= "";
				
        		try {
        			
						String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
						String MM_dbConn_USERNAME = user;
						String MM_dbConn_PASSWORD = pass;
					//	String MM_dbConn_GPS = "jdbc:mysql://192.168.2.55/dotproject";  
					//	String MM_dbConn_GPS = "jdbc:mysql://173.234.153.82/dotproject";
					  String MM_dbConn_GPS = "jdbc:mysql://"+host+"/dotproject";//means 138*******
			
						Class.forName(MM_dbConn_DRIVER);
						conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
						st=conn.createStatement();
						st1=conn.createStatement();
						st2=conn.createStatement();
						st3=conn.createStatement();
						
						System.out.println("===========connection created=============");
						
				
					} catch (Exception e) {
						System.out.print("GetConnection Exception ---->" + e);
					}
					
				String task = "";
				String project = "";
				String frmDate = "",frmDateft="";
				String toDate = "",toDateft="";
				String task_duration = "";
				String task_percent_complete = "",TaskType="";
				String comletionDate = "";
                String user="",trimmeduser="";
                
				TaskType = request.getParameter("TaskType");
				System.out.println("TaskType"+TaskType);

if(TaskType.equalsIgnoreCase("PI")){
				user = request.getParameter("userId");
				 trimmeduser = user.trim();

				task = request.getParameter("description");
				project = request.getParameter("ProjectId");
			    frmDate = request.getParameter("fromdate");
			    frmDateft=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(frmDate));

			    
				toDate = request.getParameter("todate");
				toDateft=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
			   
				task_duration = request.getParameter("duration");

				
				System.out.println("task"+task);
				System.out.println("project"+project);
				System.out.println("frmDate"+frmDate);
				System.out.println("toDate"+toDate);
				System.out.println("task_duration"+task_duration);
				System.out.println("user"+user);
}
else{
	user = request.getParameter("userId1");
	 trimmeduser = user.trim();

	task = request.getParameter("description1");
	project = request.getParameter("ProjectId1");
    frmDate = request.getParameter("fromdate1");
    frmDateft=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(frmDate));

    
	toDate = request.getParameter("todate1");
	toDateft=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
   
	task_duration = request.getParameter("duration1");

	
	System.out.println("task"+task);
	System.out.println("project"+project);
	System.out.println("frmDate"+frmDate);
	System.out.println("toDate"+toDate);
	System.out.println("task_duration"+task_duration);
	System.out.println("user"+user);
	
	
}
							//Get the  max  task Id
							String taskID = "";
							String maxid = "Select max(task_id) as maxID from dotproject.tasks";
							ResultSet rs = st1.executeQuery(maxid);
							if(rs.next())
							{
								taskID = rs.getString("maxID");
							}
							int newtaskid = Integer.parseInt(taskID) + 1;
							System.out.println("The Max taskId  is :"+taskID);
							System.out.println("The new taskId  is :"+newtaskid);
							 task_percent_complete ="0";
                             userid="693";
                             
								String sql ="insert into dotproject.tasks(task_id,task_name,task_parent,task_project,task_owner,task_start_date,task_duration,task_end_date,task_description,task_creator,task_percent_complete)values('"+newtaskid+"','"+task+"','"+newtaskid+"','"+project+"','"+userid+"','"+frmDateft+" 00:00:00','"+task_duration+"','"+toDateft+" 23:59:59','"+task+"','"+userid+"','"+task_percent_complete+"')";	
	
								System.out.println("The query is :"+sql);
								st.execute(sql);
								int user1 = Integer.parseInt(trimmeduser);

								//insert into user_tasks
								String sql1 ="Insert into dotproject.user_tasks (user_id,task_id) values ('"+user1+"','"+newtaskid+"') ";
	
								System.out.println("The query is :"+sql1);
								st2.executeUpdate(sql1);					
								
								if(TaskType.equalsIgnoreCase("PI")){
									out.println("<script>  Redirect();</script>");

								}else{
									
									out.println("<script>  Redirect1();</script>");
								
								}
		
}catch(Exception e){
	System.out.println("Th exception is >>>>>"+e); 
	
}
%>

