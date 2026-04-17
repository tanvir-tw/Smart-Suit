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
   <%@ page import="java.util.*" %>
   
   <%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
   
  <html> 
<head>
<style>

</style>


<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>


<script >
function Redirect()
{
	
	var itemName2=document.getElementById("itemName2").value;
	//alert("itemName2 is --->>" + itemName2);
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
	////alert("Usern is---->>" + Usern);
	var other=document.getElementById('other123').value;
	////alert("other is---->>" + other);
	var comment=document.getElementById('comment1').value;
	//alert("comment is---->>" + comment);
/* 	var f=document.getElementById('file1').value;
 */
	//alert(Status);
	
	alert("KRA Submitted Succesfully ");
location.assign("TaskDetailsReport.jsp?userId="+userId+"&fromdate="+dd+"&todate="+dd1+"&HOD="+HOD+"&Dept="+Dept+"&User="+Usern+"&Status="+Status+"&Role="+Role+"&itemName2="+itemName2+"");
	
	
<%-- //<a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=rs.getString("Pending")%></a></td>
 --%>
//window.location.reload()
// window.location="TaskDetReport.jsp";
    
	
}
</script>
</head>
<body>



<%
Connection con=null;

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
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
<input type="hidden" name="itemName2" id="itemName2"  value="<%=itemName2%>" >
 
  <input type="hidden" name="userId1" id="userId1"  value="<%=userId1%>" >
  <input type="hidden" name="User1" id="User1" value="<%=User1%>" /></input>  
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



String taskdata="select * from dotproject.tasks a ,dotproject.user_tasks b  where a.task_id='"+TaskID1+"' and a.task_id=b.task_id";

ResultSet rs=stmt1.executeQuery(taskdata);
System.out.println("task data :- "+taskdata);
if(rs.next())
     {
  	   task_name=rs.getString("task_name");
  	   task_start_date1=rs.getString("task_start_date");
  	   task_start_date1=task_start_date1.substring(0, 19);
  	   task_end_date1=rs.getString("task_end_date");
  	   task_end_date1=task_end_date1.substring(0, 19);
  	   task_duration=rs.getString("task_duration");
  	   task_creator=rs.getString("task_creator");
  	   user_id=rs.getString("b.user_id");
  	   
     
     
     try
     {
	   String sql4 = "select * from db_GlobalERP.UserMaster where KRAdotprojectid='"+user_id+"'";
		ResultSet rsd = stmt2.executeQuery(sql4);
		System.out.println("time diff :- "+sql4);
		if(rsd.next())
		{
			
			department = rsd.getString("dept");
		}
		else
		{
			department ="-";
		}
     }
	   catch(Exception e)
	   {
		   e.printStackTrace();
	   }
 

     
     System.out.println("Task Name :- "+task_name);
     System.out.println("Task Start Date :- "+task_start_date1);
     System.out.println("Task End Date :- "+task_end_date1);
     System.out.println("Assigned Task Duration:- "+task_duration);
    // System.out.println("Calculated Task Duration:- "+task_duration1);
     System.out.println("Task Creater:- "+task_creator);
     System.out.println("Task User Id :- "+user_id);
     System.out.println("Task Users Dept  :- "+department);
     
     try
     {
  	   String check="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='"+TaskID1+"' order by MailDateTime desc ";
  	   ResultSet rscheck=stmt3.executeQuery(check);
  	   System.out.println("Check Query :- "+check);
  	   String status="",updatestatus="",MailDateTime="";
  	   boolean updateflag=false;
  	   boolean insertflag=false;
  	
  	   
  	   if(rscheck.next())
  	   {
  		   status=rscheck.getString("TaskStatus");
  		   MailDateTime=rscheck.getString("MailDateTime");
  		   System.out.println("Status :- "+status);
      	   System.out.println("MailDateTime :- "+MailDateTime);
      	   
  	   
  	   if(status.equals("Rejected"))
  	   {
  		   System.out.println("Status In Rejected");
  		   updateflag=false;
  		   insertflag=true;
  		   status="Pending";
  	   }
  	   else if(status.equals("Approved") || status.equals("Duplicate") )
  	   {
  		   System.out.println("Status In Approved and Duplicate");
  		   updateflag=false;
  		   insertflag=true;
  		   status="Duplicate";
  	   }
  	   else if(status.equals("Pending"))
  	   {
  		   System.out.println("Status In Pending");
  		   updateflag=true;
  		   updatestatus="Duplicate";
  		   insertflag=true;
  		   status="Pending";
  	   }
  	   }
  	   else
  	   {
  		   System.out.println("No Data ");
  		   updateflag=false;
  		   insertflag=true;
  		   status="Pending";
  		  /*  DatabaseTA=rscheck.getString("TaskAttachment");
  		 System.out.println("Database TA is---->>> "+ DatabaseTA); 
	        */
  	   }
  	   
  	     	   
  	   System.out.println("Status :- "+status);
  	   
  	   String dt1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
         System.out.println(" dt1 :-----> " + dt1);
  	   
         String dt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
         System.out.println(" dt2 :-----> " + dt2);
         
         String dt3=dt2.substring(0, 10);
         
         String dt4=dt2.substring(11);
         
         System.out.println(" dt3 :-----> " + dt3);
         
         System.out.println(" dt4 :-----> " + dt4);
        // System.out.println("Database TA is---->>> "+ DatabaseTA); 
	     
        
              
  	   if(updateflag==true)
  	   {
  	   
/*   		   String updatestatus1="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata set TaskStatus='"+updatestatus+"',TaskPercent='"+percent+"',TaskComment='"+comment+"',TaskAttachment='"+file+"' where TaskID='"+TaskID+"' and MailDateTime='"+MailDateTime+"' ";
 */  
 
 
 String checkm="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskID='"+TaskID1+"' order by MailDateTime desc ";
   ResultSet rscheckm=stmt3.executeQuery(checkm);
  //System.out.println("RSCHECKM1 IS------->>" + checkm);
   if(rscheckm.next()) {
	 // System.out.println("values AFTER---->>> "+ itemName2);
   	  if( itemName2.equals(null) || itemName2.equals("")){
    		  // itemName2=rscheckm.getString("TaskAttachment"); 
    		//System.out.println("values AFTER itemName2 issss---->>> "+ itemName2);
   		itemName2="-"; 
    	        }
            else{
        	    if(rscheckm.getString("TaskAttachment").trim().equals(null)||rscheckm.getString("TaskAttachment").trim().equals("")||rscheckm.getString("TaskAttachment").trim().equals("-")){
        	    // itemName2 = itemName2.substring(1, itemName2.trim().length()) + "," +rscheck.getString("TaskAttachment");
        	    // itemName2 = itemName2.substring(0, itemName2.trim().length()-1) ;
          	            itemName2 = itemName2.substring(1, itemName2.trim().length()) ;
        	   
      	       //System.out.println("values AFTER---->>> "+ itemName2); 
        	     }
        	    else{
        	    	System.out.println("TA issss---->>> "+ rscheckm.getString("TaskAttachment")); 
        		// itemName2 = itemName2.substring(1, itemName2.trim().length()) + "," + rscheckm.getString("TaskAttachment");
            	 itemName2 = itemName2.substring(1, itemName2.trim().length()) ;
              	 
          	  //System.out.println("values AFTER---->>> "+ itemName2); 
            
        	      }
             } 
 }
 
   String updatestatus1="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata set TaskStatus='"+updatestatus+"',TaskPercent='"+other123+"',TaskComment='"+comment1+"',TaskAttachment='"+itemName2+"' where TaskID='"+TaskID1+"' and MailDateTime='"+MailDateTime+"' ";

// System.out.println("update -->"+updatestatus1);

 stmt5.executeUpdate(updatestatus1);
 	out.println("<script>  Redirect();</script>");

  	   }
  	   
  	   if(insertflag==true){
  	   if(insertflag==true&&updateflag==false)
  	   {
  		
  		 if( itemName2.equals(null) || itemName2.equals("") || itemName2.equals("-")){
   		  // itemName2=rscheckm.getString("TaskAttachment"); 
   		  itemName2="-"; 
   		//System.out.println("values AFTER itemName2 issss---->>> "+ itemName2);
  		
   	        }
  		 else{
  		 itemName2 = itemName2.substring(1, itemName2.trim().length()) ;
       //System.out.println("values AFTER---->>> "+ itemName2); 
	      

  		 }
 String InsertData="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata (TaskID,TaskPercent,TaskComment,UserId,MailDateTime,maildate,mailtime,TaskName,TaskStartDate,TaskEndDate,AssignedDuration,TaskCreater,UserDepartment,TaskStatus,TaskAttachment) values ("+TaskID1+",'"+other123+"','"+comment1+"',"+user_id+",'"+dt2+"','"+dt3+"','"+dt4+"','"+task_name+"','"+task_start_date1+"','"+task_end_date1+"','"+task_duration+"','"+task_creator+"','"+department+"','"+status+"','"+itemName2+"')";     

 //System.out.println("Before Execution Sql-->"+InsertData);
stmt5.executeUpdate(InsertData);
  //   System.out.println("After Execution Sql-->"+InsertData);
  	 out.println("<script>  Redirect();</script>");

     
  	   }
  	   
  	 if(insertflag==true&&updateflag==true)
	   {
		
		 itemName2 = itemName2.substring(0, itemName2.trim().length()) ;
    //  System.out.println("values AFTER---->>> "+ itemName2); 
	        
	 
   
		 
String InsertData="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata (TaskID,TaskPercent,TaskComment,UserId,MailDateTime,maildate,mailtime,TaskName,TaskStartDate,TaskEndDate,AssignedDuration,TaskCreater,UserDepartment,TaskStatus,TaskAttachment) values ("+TaskID1+",'"+other123+"','"+comment1+"',"+user_id+",'"+dt2+"','"+dt3+"','"+dt4+"','"+task_name+"','"+task_start_date1+"','"+task_end_date1+"','"+task_duration+"','"+task_creator+"','"+department+"','"+status+"','"+itemName2+"')";     

//System.out.println("Before Execution Sql-->"+InsertData);
stmt5.executeUpdate(InsertData);
 // System.out.println("After Execution Sql-->"+InsertData);
	 out.println("<script>  Redirect();</script>");

   }
  	   
  	   
  	   
  	   }

           }
  	   
     
     
     
     catch(Exception e)
     {
  	  e.printStackTrace();
     }
     }


  




%>
  
                    
</jsp:useBean>



</body>

<%@ include file="footer_new.jsp"%>

</html>
