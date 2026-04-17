<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@ page import="java.util.*" %>
     <%@ include file="header.jsp" %>
     <%@ include file="PostgressConn.jsp" %>
<%@ page import="java.util.List" 
    import="java.util.Iterator" import="java.io.File"
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"
	import="org.apache.commons.fileupload.disk.DiskFileItemFactory"
	import="org.apache.commons.fileupload.*" import="java.util.*"
	import="org.json.*" import="java.nio.charset.StandardCharsets"
	import="java.time.LocalDate" import="java.net.*"%>

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
   
  <html> 
<head>

<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">

<script>
function Redirect()
{
	//alert("Hi in Redirect function");
	
	var userId=document.getElementById("userId1").value;
    //alert("userId is --->>" + userId);
    
	var HOD=document.getElementById('HOD1').value;
	//alert("HOD is---->>" + HOD);
	
	var Dept=document.getElementById('Dept1').value;
    //alert("Dept is---->>" + Dept);
	
    var TaskID=document.getElementById('TaskID1').value;
	//alert("TaskID is---->>" + TaskID);
	
	var dd=document.getElementById('datenew1').value;
	//alert("dd  is---->>" + dd);
	
	var dd1=document.getElementById('datenew2').value;
	//alert("dd1  is---->>" + dd1);
	
	var satat=document.getElementById('satat1').value;
	//alert("satat is---->>" + satat);
	
	var Status=document.getElementById('Status1').value;
	//alert("Status is---->>" + Status);
	
	var Role=document.getElementById('Role1').value;
	//alert("Role is---->>" + Role);
	
	var Usern=document.getElementById('Usern1').value;
	//alert("Usern is---->>" + Usern);
	
	
	
	alert("Task Submitted Succesfully");
    location.assign("OPTaskDetReport.jsp?userId="+userId+"&fromdate="+dd+"&todate="+dd1+"&HOD="+HOD+"&Dept="+Dept+"&User="+Usern+"&Status="+Status+"&role="+Role+"");
	
	
   
	
}
</script>

</head>
<body>

<%!
private static final String OPENPROJECT_URL = "http://openproject.mobileeye.in/openproject"; // Replace with your OpenProject URL
private static final String USERNAME = "apikey"; // Replace with your username or API key
private static final String PASSWORD = "5f1f1b61eb8591b360e891b9df8c5d9545d683a6357ef6c21e1a07e2e1ce25c7"; // Replace with your password or API token


//Get the Basic Auth header
private static String getAuthHeader() {
    String credentials = USERNAME + ":" + PASSWORD;
    return "Basic " + Base64.getEncoder().encodeToString(credentials.getBytes(StandardCharsets.UTF_8));
}

// Make an HTTP request
private static String makeHttpRequest(String urlString, String method, String payload) throws IOException {
    URL url = new URL(urlString);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    
    if ("PATCH".equalsIgnoreCase(method)) {
        conn.setRequestProperty("X-HTTP-Method-Override", "PATCH");
        conn.setRequestMethod("POST"); // Use POST as a workaround
    } else {
        conn.setRequestMethod(method);
    }
    
   // conn.setRequestMethod(method);
    conn.setRequestProperty("Authorization", getAuthHeader());
    conn.setRequestProperty("Content-Type", "application/json");

    if (payload != null) {
        conn.setDoOutput(true);
        try (OutputStream os = conn.getOutputStream()) {
            os.write(payload.getBytes(StandardCharsets.UTF_8));
        }
    }

    int responseCode = conn.getResponseCode();
    InputStream is = responseCode >= 200 && responseCode < 300 ? conn.getInputStream() : conn.getErrorStream();
    try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        return response.toString();
    } finally {
        conn.disconnect();
    }
}

// Fetch the current lockVersion of the task
public static Integer getLockVersion(int taskId) {
    try {
        String url = OPENPROJECT_URL + "/api/v3/work_packages/" + taskId;
        String response = makeHttpRequest(url, "GET", null);
        JSONObject responseobj = new JSONObject(response); 
        
        int lockver = responseobj.getInt("lockVersion");
        // Parse "lockVersion" from the JSON response (use Gson or Jackson)
        //return JsonParser.parseLockVersion(response); // Implement this to extract "lockVersion"
        return lockver;
    } catch (IOException e) {
        e.printStackTrace();
        return null;
    }
}



// Update the task's status and percentage done
public static void updateTaskStatus(int taskId, int statusId, int percentageDone) {
    Integer lockVersion = getLockVersion(taskId);
    if (lockVersion == null) {
        System.err.println("Could not retrieve lockVersion for task " + taskId + ". Aborting update.");
        return;
    }

    try {
        String url = OPENPROJECT_URL + "/api/v3/work_packages/" + taskId;
        String payload = String.format(
                "{ \"lockVersion\": %d, \"status\": {\"href\": \"/api/v3/statuses/%d\"}, \"percentageDone\": %d }",
                lockVersion, statusId, percentageDone);

        String response = makeHttpRequest(url, "PATCH", payload);
        System.out.println("Task " + taskId + " updated successfully: " + response);
    } catch (IOException e) {
        e.printStackTrace();
    }
}

// Log a time entry for the specified task
public static void logTimeEntry(int taskId, String hours, String comment, String spentOn) {
    if (spentOn == null) {
        spentOn = LocalDate.now().toString(); // Use today's date if not provided
    }

    try {
        String url = OPENPROJECT_URL + "/api/v3/time_entries";
        String payload = String.format( "{ \"workPackage\": {\"href\": \"/api/v3/work_packages/%d\"}, \"hours\": \"%s\", \"comment\": {\"raw\": \"%s\"}, \"spentOn\": \"%s\" }",taskId, hours, comment, spentOn);
        String response = makeHttpRequest(url, "POST", payload);
        System.out.println("Time entry logged successfully for task " + taskId + ": " + response);
    } catch (IOException e) {
        e.printStackTrace();
    }
}
%>

<%
Connection con=null;

con=DriverManager.getConnection(postgresString,postgresUser,postgresPass); //postgresql
Statement stmt1=con.createStatement(); 
Statement stmt2=con.createStatement();
Statement stmt3=con.createStatement();
Statement stmt4=con.createStatement();
Statement stmt5=con.createStatement();

System.out.println("Connection done");

DecimalFormat df = new DecimalFormat("0.00");


SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));
String userId=request.getParameter("userId1");
System.out.println("userId :- "+userId);
/* String userId=request.getParameter("userId1");
System.out.println("userId :- "+userId);

String User1=request.getParameter("User1");
System.out.println("User1 :- "+User1);

String TaskID=request.getParameter("TaskID1");
System.out.println("TaskID :- "+TaskID);

String satat=request.getParameter("satat1");
System.out.println("satat :- "+satat);

String percent=request.getParameter("other123");
System.out.println("percent :- "+percent);
//percent=percent+"%";

String comment=request.getParameter("comment1");
System.out.println("comment:- "+comment);

String Usern=request.getParameter("Usern1");
System.out.println("Usern:- "+Usern);


String fromdate=request.getParameter("datenew1");
System.out.println("fromdate:- "+fromdate);


String Status=request.getParameter("Status1");
System.out.println("Status:- "+Status);


String todate=request.getParameter("datenew2");
System.out.println("todate:- "+todate);


String HOD=request.getParameter("HOD1");
System.out.println("HOD:- "+HOD);


String Role=request.getParameter("Role1");
System.out.println("Role :- "+Role);

String Dept=request.getParameter("Dept1");
System.out.println("Dept :- "+Dept); */

//String lname="";String other123="";String comment1="";String userId1="";String TaskID1="";String satat1="";String datenew1="";String datenew2="";

/* 

String file=request.getParameter("file1");

file = file.replace(".xls", "");


file=userId+"_"+file+"_"+TaskID+".xls";

System.out.println("file :- "+file); */


String task_name="",task_duration="",task_creator="";
Time task_duration1=null;
String  task_start_date1 = "",user_id="";
String  task_end_date1 = "",department="";
Date task_start_date = null;
Date task_end_date = null;
String User1="";String Role="";String Status="";String HOD="";String Usern="";String Dept="";String lname="";String other123="";String comment1="";String userId1="";String TaskID1="";String satat1="";String datenew1="";String datenew2="";String itemName2="";String itemName="";

%>
                       
        
        
<% 

boolean isMultipart = ServletFileUpload.isMultipartContent(request);

System.out.println("isMultipart is----->>>>" + isMultipart);
System.out.println("isMultipartrequest is----->>>>" + request);
if (!isMultipart) {
} else {
	   
	
	   FileItemFactory factory = new DiskFileItemFactory();
	   ServletFileUpload upload = new ServletFileUpload(factory);
	   List items = null; Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		
		System.out.println("today's date is:--->>>>>" + today_dt);
		
	   try {
		   items = upload.parseRequest(request);
	   } catch (FileUploadException e) {
		   e.printStackTrace();
	   }
	   Iterator itr = items.iterator();
	   while (itr.hasNext()) {
	   FileItem item = (FileItem) itr.next();
	   if (item.isFormField()) {
		   String name = item.getFieldName();
			String value = item.getString();
			
			if (name.equals("DeptHidden")) {
				Dept= value;
				System.out.println("depthidden ))))))))))))))))))))))))*"
								+ Dept);
			}
			if (name.equals("UsernHidden")) {
				Usern =  value;
				System.out.println("UsernHidden ))))))))))))))))))))))))*"
								+ Usern);
			}
			if (name.equals("HODHidden")) {
				HOD = value;
				System.out.println("HODHidden ))))))))))))))))))))))))*"
								+ HOD);
			}
			if (name.equals("datenew1Hidden")) {
				datenew1 =  value;
				System.out.println("datenew1Hidden ))))))))))))))))))))))))*"
								+ datenew1);
			}
			if (name.equals("datenew2Hidden")) {
				datenew2 =  value;
				System.out.println("datenew2Hidden ))))))))))))))))))))))))*"
								+ datenew2);
			}
			if (name.equals("StatusHidden")) {
				Status =  value;
				System.out.println("StatusHidden ))))))))))))))))))))))))*"
								+ Status);
			}
			if (name.equals("RoleHidden")) {
				Role =  value;
				System.out.println("Role ))))))))))))))))))))))))*"
								+ Role);
			}
			if (name.equals("usrid1hidden")) {
				userId1 =  value;
				System.out.println("usrid1hidden ))))))))))))))))))))))))*"
								+ userId1);
			}
			if (name.equals("tsk1hidden")) {
				User1 = value;
				System.out.println("tsk1hidden ))))))))))))))))))))))))*"
								+ User1);
			}
			if (name.equals("tskidhidden")) {
				TaskID1 = value;
				System.out.println("tskidhidden ))))))))))))))))))))))))*"
								+ TaskID1);
			}
			if (name.equals("satathidden")) {
				satat1 =  value;
				System.out.println("statushidden ))))))))))))))))))))))))*"
								+ satat1);
			}
			if (name.equals("other12hidden")) {
				other123 =  value;
				System.out.println("other12hidden ))))))))))))))))))))))))*"
								+ other123);
			}
			if (name.equals("comments31hidden")) {
				comment1 =  value;
				System.out.println("comments31hidden ))))))))))))))))))))))))*"
								+ comment1);
			}
			
			
		   System.out.println("item is--->>>>>>>>>>>>>>>>>"+item);
		   System.out.println("item"+item+"+item.getString() *** "+item.getString());
	   } else {
		   try {
			   itemName = item.getName();
			   System.out.println("itemName is-****---->>>>" + itemName+"^^^^^^^^^^");
			   /* String []x=itemName.split("\\s");
			   System.out.println("x is----------****---->>>>" +x);
			   for(String w:x){  
				   System.out.println(w);  
				   }   */
			   if(null!=itemName && itemName.trim() != ""){
				   itemName= itemName.replaceAll("\\s","");
				   itemName = TaskID1+itemName;
				   int lastIndex = itemName.lastIndexOf(".");
				   DateFormat dateFormat = new SimpleDateFormat("ddMMMyyyyHH:mm:ss");
				   Date date1 = new Date();
				  String stre= dateFormat.format(date1);
				  System.out.println("stre is------->>>>>"+stre);
				   System.out.println("date is------->>>>>"+dateFormat.format(date1));
				   if(itemName.indexOf(".")>=0)
				   {
					   System.out.println("itemName.indexOf"+itemName.indexOf("."));
					   itemName = itemName.substring(0, lastIndex) + stre + itemName.substring(lastIndex);
					   System.out.println("REAL itemName is------->>>>>"+itemName);
					   itemName2=itemName2 +"," + itemName;
					   System.out.println("values before---->>> "+ itemName2);
					      }
				   else
				   {
					   itemName = itemName.concat(stre);
					   System.out.println("FAKE itemName is------->>>>>"+itemName);
					   itemName2=itemName2 + ","+itemName +  ",";
					   System.out.println("values before---->>> "+ itemName2);
					   
				   }
				  
			
			   }
			  // File savedFile = new File("/home/twtech/"+ itemName);
				   //File savedFile = new File("/home/javaprg/taskattachment" + itemName.split("\\s"));
				  // File savedFile = new File("/home/twtech/Transworld-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TWERPV21/Accounts/"+ itemName);
				   File savedFile = new File("/home/javaprg/TaskAttachment/"+ itemName);
				// File savedFile = new File("/home/twtech/Desktop/test/"+ itemName);
					
			   item.write(savedFile);  
		      /*  System.out.println("<tr><td><b>Your file has been saved at the location:</b></td></tr><tr><td><b>"+"/home/twtech/Transworld-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TWERPV21/Accounts/"+"\\"+itemName+"</td></tr>");
		      */  System.out.println("<tr><td><b>Your file has been saved at the location:</b></td></tr><tr><td><b>"+"/home/javaprg/TaskAttachment/"+"\\"+itemName+"</td></tr>");

		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		   
		  
	   }/* ---end of else loop*/
	   
	   }/* ---end of while loop*/
	   /* if((null!=itemName && itemName.trim() != "")||(null!=itemName2 && itemName2.trim() != "")){
	   itemName2 = itemName2.substring(1, itemName2.trim().length());
	   System.out.println("values AFTER---->>> "+ itemName2);  }  */
	   
		  
  } /* ---end of MAIN else loop*/

%>

<%
String taskdata="select * from work_packages  where id='"+TaskID1+"'";

ResultSet rs=stmt1.executeQuery(taskdata);
System.out.println("task data :- "+taskdata);
if(rs.next())
     {
  	   task_name=rs.getString("subject");
  	   task_start_date1=rs.getString("start_date");
  	   task_start_date1=task_start_date1+" 00:00:00";
  	   task_end_date1=rs.getString("due_date");
  	   task_end_date1=task_end_date1+" 23:59:59";
  	   task_duration=rs.getString("estimated_hours");
  	   task_creator=rs.getString("author_id");
  	   user_id=rs.getString("assigned_to_id");
  	   
      
     System.out.println("Task Name :- "+task_name);
     System.out.println("Task Start Date :- "+task_start_date1);
     System.out.println("Task End Date :- "+task_end_date1);
     System.out.println("Assigned Task Duration:- "+task_duration);
    // System.out.println("Calculated Task Duration:- "+task_duration1);
   //  System.out.println("Task Creater:- "+task_creator);
  //   System.out.println("Task User Id :- "+user_id);
  //   System.out.println("Task Users Dept  :- "+department);
        
        int taskId = Integer.parseInt(TaskID1); // Replace with your task ID
        int statusId = 12; // Replace with the desired status ID
        int percentageDone = Integer.parseInt(other123); // Replace with percentage done
        String spentTime = "PT"+Integer.parseInt(task_duration)+"H0M"; // Time spent in ISO 8601 duration format
        String spentOn = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()); // Date in "YYYY-MM-DD" format
        
        itemName2="-"; 
        
        System.out.println("/////// Hidden Fields ////////////////////");
        System.out.println("itemName2:"+itemName2);
        System.out.println("userId1:"+userId1);
      //  System.out.println("User1:"+User1);
        System.out.println("TaskID1:"+TaskID1);
        System.out.println("datenew1:"+datenew1);
        System.out.println("datenew2:"+datenew2);
        System.out.println("satat1:"+satat1);
        System.out.println("other123:"+other123);
        System.out.println("comment1:"+comment1);
        System.out.println("HOD1:"+HOD);
        System.out.println("Dept1:"+Dept);
        System.out.println("Usern1:"+Usern);
        System.out.println("Status1:"+Status);
        System.out.println("Role1:"+Role);

        // Update the task's status and percentage done
        updateTaskStatus(taskId, statusId, percentageDone);

        // Log the spent time
        logTimeEntry(taskId, spentTime, comment1, spentOn);
    
       
     
     
     
%>

  <input type="hidden" name="itemName2" id="itemName2"  value="<%=itemName2%>" ></input>
  <input type="hidden" name="userId1" id="userId1"  value="<%=userId1%>" ></input>
  <%-- <input type="hidden" name="User1" id="User1" value="<%=User1%>"></input> --%>  
  <input type="hidden" name="TaskID1" id="TaskID1" value="<%=TaskID1%>" /></input>
  <input type="hidden" name="datenew1" id="datenew1" value="<%=datenew1%>" /></input>  
  <input type="hidden" name="datenew2" id="datenew2" value="<%=datenew2%>" /></input>
  <input type="hidden" name="satat1" id="satat1" value="<%=satat1%>" /></input>  
  <input type="hidden" name="other123" id="other123" value="<%=other123%>" /></input>   
  <input type="hidden" name="comment1" id="comment1" value="<%=comment1%>" /></input>    
  <input type="hidden" name="HOD1" id="HOD1" value="<%=HOD%>" /></input>   
  <input type="hidden" name="Dept1" id="Dept1" value="<%=Dept%>" /></input>   
  <input type="hidden" name="Usern1" id="Usern1" value="<%=Usern%>" /></input>   
  <input type="hidden" name="Status1" id="Status1" value="<%=Status%>" /></input> 
  <input type="hidden" name="Role1" id="Role1" value="<%=Role%>" /></input> 

<%
     out.println("<script>Redirect();</script>");

     }
%>
</body>

</html>