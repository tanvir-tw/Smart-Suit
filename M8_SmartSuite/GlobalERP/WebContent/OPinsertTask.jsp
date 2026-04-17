<%@ page import="java.sql.*" 
         import="java.text.*" 
        import="java.util.Date.*"
        import="java.util.Base64"  
        import="java.net.*" 
        import="org.json.JSONObject"
        import="java.io.*" %>

 <script>
function Redirect()
{
	alert("Task Added Successfully");
    window.location="OPTaskAllocationReport.jsp";
	
}
function Redirect1()
{
	alert("KRA Added Successfully");
    window.location="OPTaskAllocationReport.jsp";
	
}

</script>
<%

try{	   
	
	         	
				
				 String userid= "";
				 int type=0;
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
				 type = 1;  //PI
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
	 type=9; //KRA
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

int status =1; // new task


int  hh = (int)Double.parseDouble(task_duration);
// Get the fractional part and convert it to minutes
int mm = (int) Math.round((Double.parseDouble(task_duration) - hh) * 60);
 System.out.println("taskDurationHrs: hh:"+hh+" mm:"+mm);

 String duration = "PT"+hh+"H"+mm+"M";
 
 System.out.println("start:"+frmDateft);
 System.out.println("due:"+frmDateft);
 System.out.println("project_id:"+project);
 System.out.println("subject:"+task);
 System.out.println("description:"+task);
 System.out.println("assigned_to:"+trimmeduser);
 System.out.println("type:"+type);
 System.out.println("status:"+status);
 System.out.println("duration:"+duration);
 
 
 
 JSONObject Description = new JSONObject();
 Description.put("format","markdown");
 Description.put("raw",task);
 
 JSONObject projectjson = new JSONObject(); 
 projectjson.put("href","/api/v3/projects/"+project);
 
 JSONObject assignee = new JSONObject(); 
 assignee.put("href","/api/v3/users/"+trimmeduser);
 
 JSONObject statusjson = new JSONObject(); 
 statusjson.put("href","/api/v3/statuses/"+status);
 
 JSONObject typejson = new JSONObject(); 
 typejson.put("href","/api/v3/types/"+type);
 
 JSONObject JsonMain = new JSONObject();
 
 JsonMain.put("subject",task);
 JsonMain.put("startDate",frmDateft);
 JsonMain.put("dueDate",toDateft);
 JsonMain.put("estimatedTime",duration);
 JsonMain.put("description",Description);
 JsonMain.put("assignee",assignee);
 JsonMain.put("project",projectjson);
 JsonMain.put("status",statusjson);
 JsonMain.put("type",typejson);
 
 System.out.println("RequestBody--->"+JsonMain.toString());
 
 //Fire Create Task API Here
 try{ 
	   
	   String apiUrl = "http://openproject.mobileeye.in/openproject/api/v3/work_packages/";
   
     String username = "apikey";
     String password = "5f1f1b61eb8591b360e891b9df8c5d9545d683a6357ef6c21e1a07e2e1ce25c7";
  
     try {
         // Create URL object
         URL url = new URL(apiUrl);

         // Open connection
         HttpURLConnection connection = (HttpURLConnection) url.openConnection();

         // Set request method to POST
         connection.setRequestMethod("POST");

         // Enable input and output streams
         connection.setDoOutput(true);

         // Add Basic Authentication header
         String auth = username + ":" + password;
         String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
         connection.setRequestProperty("Authorization", "Basic " + encodedAuth);

         // Set Content-Type to JSON
         connection.setRequestProperty("Content-Type", "application/json");

         // Write JSON body to the output stream
         try {
      	   OutputStream os = connection.getOutputStream();
             byte[] input = JsonMain.toString().getBytes("utf-8");
             os.write(input, 0, input.length);
         }catch(Exception ex){
      	   ex.printStackTrace();
         }

         // Get the response code
         int responseCode = connection.getResponseCode();
         System.out.println("Response Code: " + responseCode);

         StringBuffer resp=null;String readLine = null;

         if( responseCode>=200 && responseCode < 202 ) {
         System.out.println("POST request was successful!");
             
             BufferedReader in = new BufferedReader(
			            new InputStreamReader(connection.getInputStream()));
			         resp = new StringBuffer();
			        while ((readLine = in .readLine()) != null) {
			            resp.append(readLine);
			        } in .close();
			        // print result
			        
			        System.out.println("ResponseBody--->" + resp.toString());
         }else {
         	  System.out.println("POST request was failed!");
         }
         

         // Disconnect the connection
         connection.disconnect();
     } catch (Exception e) {
         e.printStackTrace();
     }
  
}catch(Exception e){
	   e.printStackTrace();
}



								
								if(TaskType.equalsIgnoreCase("PI")){
									out.println("<script>  Redirect();</script>");

								}else{
									
									out.println("<script>  Redirect1();</script>");
								
								}
		
}catch(Exception e){
	System.out.println("Th exception is >>>>>"+e); 
	
}
%>

