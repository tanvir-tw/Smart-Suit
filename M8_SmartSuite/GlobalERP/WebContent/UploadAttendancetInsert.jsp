<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.util.Date.*"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFDateUtil"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<script>
function Redirect(Shipment)
{
	
	
	location.assign("UploadAttendance.jsp?msg="+Shipment);


   
	
}

function Redirect1()
{
	
	
	alert("Please Upload Standard Format!!");
	
	location.assign("UploadAttendance.jsp");


   
	
}

</script>
<%
	String file1 = "";
	int saveflag = 1;
	File savedFile = null;
	String[] filepath = new String[10];
	String[] filename = new String[10];
	int count2 = 0, filecount = 0;
	String ShipmentNumber = "";
	String ShipmentNumber1 = "";

	int count = 1;
	String savefilestring = "";
	String uploadedBy = "";

	int count1 = 0;
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	System.out.println("\n\n ismultipart-->>" + isMultipart);
	if (!isMultipart) {
		System.out.println("\n\nin multipart..");
	} else {
		System.out.println("\n\n in else with  multipart..");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
	items = upload.parseRequest(request);
	//      System.out.print("\n\n items==>"+items);
		} catch (FileUploadException e) {
	e.printStackTrace();
		}
		Iterator itr = items.iterator();

		while (itr.hasNext()) {
	FileItem item = (FileItem) itr.next();
	if (item.isFormField()) {
		String name1 = item.getFieldName();
		System.out.print("\n name==>" + name1);
		String value = item.getString();
		System.out.print("\n value==>" + value);

	} else {
		try {

			String itemName = item.getName();
			System.out.print("\n\nitemName==>" + itemName);
			file1 = itemName;
			if (itemName.equalsIgnoreCase("")) {
			} else {

				// savedFile = new File("/home/user/Desktop/TaskReport/"+itemName);  
				savedFile = new File("/home/ctrls/" + itemName);
				//savedFile = new File("/home/ashish/" + itemName);
				System.out.print("\n\nsavedFile==>" + savedFile);
				item.write(savedFile);
				filepath[filecount] = "" + savedFile;

				filename[filecount] = itemName;
				filecount++;
				if (saveflag == 1) {
					savefilestring = "" + savedFile;
					saveflag++;
				} else
					savefilestring = savefilestring + "," + savedFile;
				//out.print("successfully saved the file");
				//File file = new File(savedFile);
				String screenshot = savedFile.getAbsolutePath();
				// System.out.println("\n\nscreenshot--->>>"+screenshot);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		}

	}
	//=============================csv reading code========================
	/* try { */

		//get connection
		String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");
		Connection conne = null;
		Statement stat = null, stat1 = null, stat2 = null;
		String userid = "";String line="",attdate="",indatetime="",outdatetime="",empcode="";
		String Username="",status="",intime="",outtime="";
		boolean msgpgflg = false;
		int i=0;

		String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
		String MM_dbConn_USERNAME = user;
		String MM_dbConn_PASSWORD = pass;
		//String MM_dbConn_STRING = "jdbc:mysql://173.234.153.82:3306/db_gps";
		String MM_dbConn_STRING = "jdbc:mysql://"+host+"/db_gps";

		try {
	Class.forName(MM_dbConn_DRIVER);

	Connection con2 = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME,
			MM_dbConn_PASSWORD);
	stat = con2.createStatement();
	stat1 = con2.createStatement();
	stat2 = con2.createStatement();

		} catch (Exception e) {
	e.printStackTrace();
		}

		//select the taskowner and task creator

		String fname = "/home/ctrls/" + file1;
		//String fname = "/home/ashish/" + file1;
		//String fname = "/home/user/Desktop/TaskReport/"+file1;

		System.out.println("The filename is :" + file1);
		System.out.println("The filepath is :" + fname);

		BufferedReader br = new BufferedReader(new FileReader(fname));
		while ((line = br.readLine()) != null)   //returns a Boolean value  
		{
		if (i == 0) {

			i++;
			continue;
		}

		String[] employee = line.split(","); // use comma as separator  
		//System.out.println("code:" + employee[0] + " inTime:" + employee[1] + " outTime: " + employee[2]+ " date:" + employee[3]);
		empcode=employee[0];
		
		attdate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(employee[3]));

		intime=employee[1]+":00";
		outtime=employee[2]+":00";
		
		indatetime = attdate+" "+intime; //processing for check in
		outdatetime = attdate+" "+outtime; //processing for check out
				
		System.out.println("Recordno: "+i);
		System.out.println("code: " + empcode);
		System.out.println("check in datetime: " + indatetime);
		System.out.println("check out datetime: " + outdatetime);
		i++;

		String sqlactive="select EmpCode as user_id from db_GlobalERP.UserMaster where EmpCode='"+empcode+"' and  ActiveStatus = 'Yes'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";  //check if contract id is active or not				
		ResultSet rsactive=stat1.executeQuery(sqlactive);
		if(rsactive.next()){    //if active
		
			String sql3 = "Select uname,ReportTime,Exittime from db_leaveapplication.t_leaveadmin where empid='" + empcode + "'";
            System.out.println("sql2-->" + sql3);
            final ResultSet rs3 = stat.executeQuery(sql3);
            if (rs3.next()) {
                Username = rs3.getString("uname");
            }
            status = "Approved";
            
            //process attendance for checkin
            String inssql = "select * from db_leaveapplication.t_checkinout where empid='"+empcode+"' and checkindatetime='"+indatetime+"' and checkintype='In'";
			System.out.println("checkin sql:"+inssql);
			ResultSet rstin = stat1.executeQuery(inssql);
			if (rstin.next()) {
				//update 
				System.out.println("Attendace Data Exists :");
				 
				msgpgflg = true;

			} else {

				//insert 
				if(intime.equals("00:00:00") && outtime.equals("00:00:00")){
					System.out.print("Active but absent");
					continue;
				}
				
				String InData="insert into db_leaveapplication.t_checkinout (empid,empname,checkindatetime,checkdate,checktime,Office,Status,checkintype) values ('" + empcode + "','" + Username + "','" + indatetime + "','"+attdate+"','"+intime+"','Attendance Machine','" + status + "','In') ";
				System.out.println("Attendace Data Insertion :"+InData);
				stat2.executeUpdate(InData);
				msgpgflg = true;
			}
			
			//process attendance for checkout
			String outssql = "select * from db_leaveapplication.t_checkinout where empid='"+empcode+"' and checkindatetime='"+outdatetime+"' and checkintype='Out'";
			System.out.println("checkout sql:"+outssql);
			ResultSet rstout = stat1.executeQuery(outssql);
			if(rstout.next()){
				
				System.out.println("Attendace In Data Exists :"); 
				msgpgflg = true;
				
			}else{
			
				if(intime.equals("00:00:00") && outtime.equals("00:00:00")){
					System.out.print("Active but absent");
					continue;
				}
			
				String OutData="insert into db_leaveapplication.t_checkinout (empid,empname,checkindatetime,checkdate,checktime,Office,Status,checkintype) values ('" + empcode + "','" + Username + "','" + outdatetime + "','"+attdate+"','"+outtime+"','Attendance Machine','" + status + "','Out')";
				System.out.println("Attendace Out Data Insertion :"+OutData);
				stat2.executeUpdate(OutData);
				msgpgflg = true;
			}
		
			
		}else{
			System.out.println("inactive contract id"+empcode);
			continue;
		}
			
		
		
	}
	System.out.println("Total Number of Records:"+(i-1));
	if (msgpgflg == false) {
		//session.setAttribute("al",al);
		//response.sendRedirect("alertGoTo.jsp?msg=Tasks with from dates "+rjtask+" were rejected&goto=uploadTask.jsp");
		//response.sendRedirect("alertGoTo.jsp?msg=Please Upload Standard Format!!&goto=UploadShipment.jsp");
		//out.println("<script>  Redirect('"+ShipmentNumber1+"');</script>");
	}
	else
	{
		
		out.println("<script>  Redirect('Done');</script>");
		

	}
	
%>
