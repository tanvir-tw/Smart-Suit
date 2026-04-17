<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@page import="java.util.*" %>
     <%@ include file="header.jsp"%>
     <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.stream.*"%>
   <%@ page import="java.util.*" import="java.util.*"
	import="org.json.*" import="java.nio.charset.StandardCharsets"
	import="java.time.LocalDate" import="java.net.*"%>
      
  <html> 
<head>
<style>

</style>




<script >
function Redirect()
{
	
	
	
	var userId=document.getElementById("userId1").value;
	//alert("userId is --->>" + userId);
		var HOD=document.getElementById('HOD1').value;
		//alert("HOD is---->>" + HOD);
		
		var Dept=document.getElementById('Dept1').value;
	//alert("Dept is---->>" + Dept);
		var TaskID=document.getElementById('TaskID1').value;
	//	alert("TaskID is---->>" + TaskID);
		var dd=document.getElementById('datenew1').value;
	//	alert("dd  is---->>" + dd);
		var dd1=document.getElementById('datenew2').value;
	//	alert("dd1  is---->>" + dd1);

		var Status=document.getElementById('Status1').value;
	//	alert("Status is---->>" + Status);
		var Role=document.getElementById('Role1').value;
	//	alert("Role is---->>" + Role);
		var Usern=document.getElementById('Usern1').value;
	//	alert("Usern is---->>" + Usern);
		

		alert("Task Assigned Succesfully ");
	location.assign("OPTaskDetReport.jsp?userId="+userId+"&fromdate="+dd+"&todate="+dd1+"&HOD="+HOD+"&Dept="+Dept+"&User="+Usern+"&Status="+Status+"&Role="+Role);
		
	
    
	
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

public static void updateTaskDescription(int taskId,String updatedDesc) throws IOException{
	
	Integer lockVersion = getLockVersion(taskId);
    if (lockVersion == null) {
        System.err.println("Could not retrieve lockVersion for task " + taskId + ". Aborting update.");
        return;
    }
	
	String url = OPENPROJECT_URL + "/api/v3/work_packages/" + taskId;
	
	JSONObject payloadobj = new JSONObject();
	
	
	JSONObject desc = new JSONObject();
	desc.put("format","markdown");
	desc.put("raw",updatedDesc);
	
	payloadobj.put("lockVersion",lockVersion);
	payloadobj.put("description",desc);
	
	String payload = payloadobj.toString();
	
	 String response = makeHttpRequest(url, "PATCH", payload);
	
}


%>


<%
DecimalFormat df = new DecimalFormat("0.00");


SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
Date date = new Date();  
System.out.println(formatter.format(date));


String usrid11=request.getParameter("userId1");
System.out.println("usrid11 :- "+usrid11);

String tskid1=request.getParameter("tskid1");
System.out.println("tskid1 :- "+tskid1);

String comments311=request.getParameter("comments311");
System.out.println("comments311 :- "+comments311);

String datefrom=request.getParameter("datefrom");
String dateto=request.getParameter("dateto");
String hod=request.getParameter("hod");
String dep=request.getParameter("dep");
String usr=request.getParameter("usr");
String rol=request.getParameter("rol");
String stst=request.getParameter("stst");


%>
<input type="hidden" name="userId1" id="userId1"  value="<%=usrid11%>" >
<input type="hidden" name="Usern1" id="Usern1" value="<%=usr%>" /></input>   
<input type="hidden" name="TaskID1" id="TaskID1" value="<%=tskid1%>" /></input>
<input type="hidden" name="datenew1" id="datenew1" value="<%=datefrom%>" /></input>  
<input type="hidden" name="datenew2" id="datenew2" value="<%=dateto%>" /></input>
<input type="hidden" name="Status1" id="Status1" value="<%=stst%>" /></input>  
<input type="hidden" name="HOD1" id="HOD1" value="<%=hod%>" /></input>   
<input type="hidden" name="Dept1" id="Dept1" value="<%=dep%>" /></input>   
<input type="hidden" name="Role1" id="Role1" value="<%=rol%>" /></input> 
               
<%
System.out.println("ALL :- "+datefrom+" "+dateto+" "+hod+" "+usr+" "+rol+" "+stst+" "+dep);



	updateTaskDescription(Integer.parseInt(tskid1),comments311);



	 out.println("<script>  Redirect();</script>");



%>
  
                    
</body>
</html>
