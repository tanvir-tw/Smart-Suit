<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>  
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.*" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
   <%@ page import = "java.io.FileNotFoundException"%>
   <%@ page import = "java.io.FileOutputStream"%>
   <%@ page import = "java.io.IOException"%>
   <%@ page import="javax.activation.*" %>  
   <%@ page import="java.io.FileInputStream" %>
   <%@ page import="java.math.BigDecimal" %>
   <%@ page import="java.sql.Connection" %>
   <%@ page import="java.sql.DriverManager" %>
   <%@ page import="java.sql.ResultSet" %>
   <%@ page import="java.sql.Statement" %>
   <%@ page import="java.text.SimpleDateFormat" %>
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.StringTokenizer" %>
   <%@ page import="javax.servlet.*" %>
   <%@ page import="javax.servlet.http.*" %>
   <%@ page import="java.net.*" 
            import="org.json.JSONObject"
              %>
    
<%
String file1="";
String reason = "";
int saveflag=1;
File savedFile;
String[] filepath =new String[10];
String[] filename =new String[10];
int  count2 = 0, filecount = 0;;
int count=1;
String savefilestring="";
String uploadedBy = "";
String start_date="",due_date="",project_id="",subject="",description="",assign_to="",type="",status="",duration="";
int dur = 0;
boolean pageflag = true;
int count1=0;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
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
                    if(item.isFormField()) 
                    {
		                    	String name1 = item.getFieldName();
		                        System.out.print("\n name==>"+name1);
		                        String value = item.getString();
		                        System.out.print("\n value==>"+value);
		                        if(name1.equals("uploadedby")) 
		                        {
		                        		uploadedBy = value;
		                                System.out.print("\n title==>"+uploadedBy);		                             
		                               
		                        }
                    } else {
                                   try {

                                         String itemName = item.getName();
                                         System.out.print("\n\nitemName==>"+itemName);
                                         	file1=itemName;
                                          if(itemName.equalsIgnoreCase(""))
                                          {
                                          }
                                        else
                                         {
                                         
                                     		          // savedFile = new File("/home/user/Desktop/TaskReport/"+itemName);  
                                     		           savedFile = new File("/home/javaprg/TaskList/"+itemName);  
                                          
                                         					System.out.print("\n\nsavedFile==>"+savedFile);
                                                            item.write(savedFile);
                                                            filepath[filecount]=""+savedFile;
                                                            
                                                            filename[filecount]=itemName;
                                                            filecount++;
                                                            if(saveflag==1)
                                                            {
                                                             savefilestring=""+savedFile;
                                                             saveflag++;
                                                            }
                                                            else
                                                            savefilestring=savefilestring+","+savedFile;
                                                             //out.print("successfully saved the file");
                                                            //File file = new File(savedFile);
                                                            String screenshot=savedFile.getAbsolutePath();
                                                             // System.out.println("\n\nscreenshot--->>>"+screenshot);
                                                            }
                                                    
                                                    
                                    } catch (Exception e) {
                                            e.printStackTrace();
                                    }
                    }
            }
         
	
 }
        
////////////////////////// EXCEL READING CODE STARTS HERE /////////////////////////////////////        
        
String fname = "/home/javaprg/TaskList/"+file1;

System.out.println("The filename is :"+file1);
System.out.println("The filepath is :"+fname);
List sheetData = new ArrayList();			 
FileInputStream fis = null;
try {
    
    fis = new FileInputStream(fname);			 
    HSSFWorkbook workbook = new HSSFWorkbook(fis);			            
    HSSFSheet sheet = workbook.getSheetAt(0);
    Iterator rows = sheet.rowIterator();
    while (rows.hasNext()) {
        HSSFRow row = (HSSFRow) rows.next();
        Iterator cells = row.cellIterator();

        List data = new ArrayList();
        while (cells.hasNext()) {
            HSSFCell cell = (HSSFCell) cells.next();
            data.add(cell);
            
        }

        sheetData.add(data);
    }
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if (fis != null) {
        fis.close();
    }
}

int cnt=0;
boolean msgpgflg = false;
ArrayList al = new ArrayList();
String rjtask = "";
String seventhdt = "";

//Check if Excel sheet is correct
for (int i = 1; i < sheetData.size(); i++) {
	String row="";
    List list = (List) sheetData.get(i);
   
    try{
    	//System.out.println( "IN ntry   ");
    for (int j = 0; j < list.size(); j++) {
        HSSFCell cell = (HSSFCell) list.get(j);
        
       //System.out.println( "The cell type is :"+cell.getCellType());	
        
        if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC) 
        {
        	//System.out.println( "IN IFFFFFFFFF    ");	
        	if(HSSFDateUtil.isCellDateFormatted(cell)){  
        		//System.out.print( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue()) );
        		try{
        		System.out.println( "Cell Date Value >>>> "+cell.getDateCellValue()+" >>>> "+new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue()));
        		
        		if(row.equals("")){
        			//System.out.println( "IN another iff ");
        		    row=new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
        		}else{
        			row=row+"$"+new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
        		}
        		}catch(Exception e){
        			e.printStackTrace();
        			pageflag = false;
        			reason="Error in Date At Row:"+i+" ";
        			break;
        		}
            }else{
            //	System.out.println( "INanothsr    ELS SSSSSSS ");
            	//System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
            	if(row.equals("")){
            	    row=new BigDecimal(cell.getNumericCellValue()).toString();
            	}else{
            		row=row+"$"+new BigDecimal(cell.getNumericCellValue()).toString();
            	}
            }
       
        }
        
        else{  
        	//System.out.println( "IN mainn     ELS SSSSSSS ");
        	    //System.out.print(cell.toString());
        	    
        	    
        	    if(row.equals("")){
        	         row=cell.toString();
        	    }else{
        	    	 row=row+"$"+cell.toString();
        	    }
        }
         
     
    }
    }catch(Exception ioe){
    	System.out.println("The exception is :"+ioe);
    	ioe.printStackTrace();
    }
    
    System.out.println("row:"+row);
    
    StringTokenizer stringTokenizer = new StringTokenizer(row,"$");
	System.out.println("Tokens generated :  " + stringTokenizer.countTokens());
	int countFeild  = stringTokenizer.countTokens();
	
	if(stringTokenizer.countTokens() == 9)
	{
		   start_date = stringTokenizer.nextToken();
		   due_date = stringTokenizer.nextToken();
		   project_id = stringTokenizer.nextToken();
		   subject = stringTokenizer.nextToken();
		   description = stringTokenizer.nextToken();
		   assign_to = stringTokenizer.nextToken();
		   type = stringTokenizer.nextToken();
		   status = stringTokenizer.nextToken();
		   duration = stringTokenizer.nextToken();
		 
		   
		   try{
			      
			   java.util.Date stdate = new SimpleDateFormat("yyyy-MM-dd").parse(start_date);
			   
		   }catch(Exception e){
				   e.printStackTrace();
				   pageflag = false;
				   reason = "Error at Row:"+i+" for start date";
				   break;
			   }
		   
		   try{
			      
			   java.util.Date duedate = new SimpleDateFormat("yyyy-MM-dd").parse(due_date);
			   
		   }catch(Exception e){
				   e.printStackTrace();
				   pageflag = false;
				   reason = "Error at Row:"+i+" for start date";
				   break;
			   }
		   
		   try{
		      int projid = Integer.parseInt(project_id) ;
		   }catch(Exception e){
			   e.printStackTrace();
			   pageflag = false;
			   reason = "Error at Row:"+i+" for ProjectID";
			   break;
		   }
		   
		   try{
			      int assign = Integer.parseInt(assign_to) ;
			   
		   }catch(Exception e){
				   e.printStackTrace();
				   pageflag = false;
				   reason = "Error at Row:"+i+" for AssignTo";
				   break;
			   }
		   
		   try{
			      int typ = Integer.parseInt(type);
			      
			      if(typ==1 || typ==9){   //task or kra
			    	  //okk
			      }else{
			    	  pageflag = false;
					   reason = "Wrong TaskType at Row:"+i+" ";
					   break;
			      }
			      
			   }catch(Exception e){
				   e.printStackTrace();
				   pageflag = false;
				   reason = "Error at Row:"+i+" for TaskType";
				   break;
			   }
		   
		   
		   try{
			      int stat = Integer.parseInt(status) ;
			      
			       if(stat!=1){
			    	   pageflag = false;
					   reason = "Wrong Task Status at Row:"+i+" ";
					   break;
			      }
			      
			   }catch(Exception e){
				   e.printStackTrace();
				   pageflag = false;
				   reason = "Error at Row:"+i+" In Task Status";
				   break;
			   }
		   
		   try{
			   double period = Double.parseDouble(duration);
			   
			   int  hh = (int)period;
		          // Get the fractional part and convert it to minutes
		          int mm = (int) Math.round((period - hh) * 60);
		 	     // System.out.println("taskDurationHrs:"+dur+" hh:"+hh+" mm:"+mm);
		 	    
		 	      duration = "PT"+hh+"H"+mm+"M";
		 	      
		 	     System.out.println("Duration:"+duration);
			   
		   }catch(Exception e){
			   e.printStackTrace();
			   pageflag = false;
			   reason="Error in Task Duration at Row:"+i+" ";
			   break;
		   }
		
		
		pageflag = true;
	
	}else{
		
		pageflag = false;
		reason = "Wrong Column Nos at Row:"+i+" ";
		break;
		
	}
    
    System.out.println("----------------------------------------------------------");
}

System.out.println("Reason:"+reason);

if(pageflag){
	//read excel again for data insertion
	for (int i = 1; i < sheetData.size(); i++){
		String row="";
	    List list = (List) sheetData.get(i);
	   
	    try{
	    	//System.out.println( "IN ntry   ");
	    for (int j = 0; j < list.size(); j++) {
	        HSSFCell cell = (HSSFCell) list.get(j);
	        
	       //System.out.println( "The cell type is :"+cell.getCellType());	
	        
	        if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC) 
	        {
	        	//System.out.println( "IN IFFFFFFFFF    ");	
	        	if(HSSFDateUtil.isCellDateFormatted(cell)){  
	        		//System.out.print( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue()) );
	        		//System.out.println( "hibhihihihih>>>>"+cell.getDateCellValue());
	        		if(row.equals("")){
	        			//System.out.println( "IN another iff ");
	        		row=new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
	        		}else{
	        			row=row+"$"+new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
	        		}
	            }else{
	            	//System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
	            	if(row.equals("")){
	            	row=new BigDecimal(cell.getNumericCellValue()).toString();
	            	}else{
	            		row=row+"$"+new BigDecimal(cell.getNumericCellValue()).toString();
	            	}
	            }
	       
	        }
	        
	        else{  
	        	    //System.out.print(cell.toString());
	        	    if(row.equals("")){
	        	       row=cell.toString().replaceAll("'","").replaceAll("`","").replaceAll("'","").replaceAll("&","").replaceAll("|","").replaceAll("\"","");
	        	    }else{
	        	    	 row=row+"$"+cell.toString();
	        	    }
	        }
	         
	     
	    }
	    }catch(Exception ioe){
	    	//System.out.println("The exception is :"+ioe);
	    	ioe.printStackTrace();
	    }
	    
	    StringTokenizer stringTokenizer = new StringTokenizer(row,"$");
		System.out.println("The total no. of tokens generated :  " + stringTokenizer.countTokens());
		int countFeild  = stringTokenizer.countTokens();
		
		if(countFeild==9){
		   start_date="";due_date="";project_id="";subject="";description="";assign_to="";type="";status="";duration="";dur=0;
					 
		   start_date = stringTokenizer.nextToken();
		   due_date = stringTokenizer.nextToken();
		   project_id = stringTokenizer.nextToken();
		   subject = stringTokenizer.nextToken();
		   description = stringTokenizer.nextToken();
		   assign_to = stringTokenizer.nextToken();
		   type = stringTokenizer.nextToken();
		   status = stringTokenizer.nextToken();
		   duration = stringTokenizer.nextToken();
		  
		   
		   
		   
		   start_date = start_date.trim();
		   due_date = due_date.trim();
		   project_id = project_id.trim();
		   subject = subject.trim();
		   description = description.trim();
		   assign_to = assign_to.trim();
		   type = type.trim();
		   status = status.trim();
		   duration = duration.trim();
		   
		   
		   
		   //duration = "PT"+dur+"H";
		   int  hh = (int)Double.parseDouble(duration);
          // Get the fractional part and convert it to minutes
          int mm = (int) Math.round((Double.parseDouble(duration) - hh) * 60);
 	      System.out.println("taskDurationHrs:"+dur+" hh:"+hh+" mm:"+mm);
 	    
 	      duration = "PT"+hh+"H"+mm+"M";
		   
		   System.out.println("start:"+start_date);
		   System.out.println("due:"+due_date);
		   System.out.println("project_id:"+project_id);
		   System.out.println("subject:"+subject);
		   System.out.println("description:"+description);
		   System.out.println("assigned_to:"+assign_to);
		   System.out.println("type:"+type);
		   System.out.println("status:"+status);
		   System.out.println("duration:"+duration);
		   
		   
		   
		   JSONObject Description = new JSONObject();
		   Description.put("format","markdown");
		   Description.put("raw",description);
		   
		   JSONObject project = new JSONObject(); 
		   project.put("href","/api/v3/projects/"+project_id);
		   
		   JSONObject asignee = new JSONObject(); 
		   asignee.put("href","/api/v3/users/"+assign_to);
		   
		   JSONObject statusjson = new JSONObject(); 
		   statusjson.put("href","/api/v3/statuses/"+status);
		   
		   JSONObject typejson = new JSONObject(); 
		   typejson.put("href","/api/v3/types/"+type);
		   
		   JSONObject JsonMain = new JSONObject();
		   
		   JsonMain.put("subject",subject);
		   JsonMain.put("startDate",start_date);
		   JsonMain.put("dueDate",due_date);
		   JsonMain.put("estimatedTime",duration);
		   JsonMain.put("description",Description);
		   JsonMain.put("assignee",asignee);
		   JsonMain.put("project",project);
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

		}
		
		System.out.println("==========================================================================");
		
	}  //end of main for loop
	
	response.sendRedirect("UploadOpenProjectSheet.jsp?msg=1");
}else{
	//redirect to upload page with error message
	response.sendRedirect("alertGoTo.jsp?msg=Please Upload Standard Format!! "+reason+"&goto=UploadOpenProjectSheet.jsp");
}

%>
