<%@page import="com.ConnectionClass"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.Date.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.ss.usermodel.*"%>
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
<%@ page import="java.text.*"%>



<script type="text/javascript">
</script>
<%
String file1="";
int saveflag=1;
File savedFile;
String[] filepath =new String[10];
String[] filename =new String[10];
int  count2 = 0, filecount = 0;;
int count=1;
String savefilestring="";
String uploadedBy = "";
java.util.Date curdate=new java.util.Date();
String date1=new SimpleDateFormat("yyyy-MM-dd").format(curdate);
System.out.println("current date"+date1);
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
                                         
                                     		//savedFile = new File("/home/r_lakhote/Desktop/Task_List/"+itemName);  
                                     		savedFile = new File("/usr/share/tomcat6/webapps/TaskList/"+itemName);  
                                         
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
                                                    System.out.println("\n\nscreenshot--->>>"+screenshot);
                                                            }
                                      } catch (Exception e) {
                                            e.printStackTrace();
                                    }
                               }
                           }
	
                     }
   //=============================excel reading code========================
		   
Connection conn=null;
ConnectionClass connection = new ConnectionClass();
Statement st1 = null, st2= null,st3=null,st4=null;
try
{
	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
}
catch(Exception e)
{
	e.printStackTrace();
}
		   
try{	   
	   
	   
            
				 String userid= "",sendMsg="";
				 String PayOrderNO="",empId="",contractorName="",month="",year="",payableDays="",basic="",perIndex="",variable="",incentive="";
					String allowance4="",deduction="",deduction1="",deduction2="",deduction3="",deduction4="",PreviousPay="",tds="",DateofJoining="";
					double allowance=0,allowance1=0,allowance2=0,allowance3=0;
					DecimalFormat df=new DecimalFormat("#.00");
					
					//read excel file
					String fname = "/home/r_lakhote/Desktop/Task_List/"+file1;
				//	String fname = "/usr/share/tomcat6/webapps/TaskList/"+file1;
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
			        //show excel data=====
			        	System.out.println("The >>>>>>>>>>>>is :");
			        
			        int cnt=0;
       		// Iterates the data and print it out to the console.	
			        for (int i = 1; i < sheetData.size(); i++) {
			        	cnt++;
			        	String row="";
			            List list = (List) sheetData.get(i);
			           
			            try{
			            	//System.out.println( "IN ntry   ");
			            for (int j = 0; j < list.size(); j++) {
			            	Cell cell = (Cell) list.get(j);
			            	//HSSFCell cell = (HSSFCell) list.get(j);
			                System.out.println( "The cell type is :"+cell.getCellType());	
			                
			                if(cell.getCellType()==Cell.CELL_TYPE_NUMERIC) 
			                {
			                	//System.out.println( "IN IFFFFFFFFF    ");	
			                	if(DateUtil.isCellDateFormatted(cell)){  
			                	//	System.out.print( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue()) );
			                		System.out.println( "hibhihihihih>>>>"+cell.getDateCellValue());
			                		if(row.equals("")){
			                			System.out.println( "IN another iff ");
			                		row=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue());
			                		}else{
			                			row=row+"$"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue());
			                		}
			                    }else{
			                    //	System.out.println( "INanothsr    ELS SSSSSSS ");
			                    	System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
			                    	if(row.equals("")){
			                    	row=new BigDecimal(cell.getNumericCellValue()).toString();
			                    	}else{
			                    		row=row+"$"+new BigDecimal(cell.getNumericCellValue()).toString();
			                    	}
			                    }
			               
			                }
			                
			                else{  
			                	//System.out.println( "IN mainn     ELS SSSSSSS ");
			                	    System.out.print(cell.toString());
			                	    if(row.equals("")){
			                	    row=cell.toString();
			                	    }else{
			                	    	 row=row+"$"+cell.toString();
			                	    }
			                }
			                 
			               
			              
			            }
			            }catch(Exception ioe){
			            	sendMsg="Invalid Excel Format \n Excel format should be save in xls extantion";
			            	System.out.println("The exception is :"+ioe);
			            	ioe.printStackTrace();
			            }
			            //code for row
			            System.out.println("\nThe row is >>  "+row);
			         //   insertToDb(rw);
			            //inset row into database
			            	//String sqlinsert="insert into t_payable (contractorName,month,year,payableDays,basic,allowance,allowance1,allowance2,allowance3,allowance4,deduction,deduction1,deduction2,deduction3,deduction4,Netpay,grosspay,tds,EmpId) values('"+empName+"','"+month+"','"+year+"','"+paydays+"','"+basic+"','"+allow+"','"+allow1+"','"+allow2+"','"+allow3+"','"+allow4+"','"+deduct+"','"+deduct1+"','"+deduct2+"','"+deduct3+"','"+deduct4+"','"+netpay+"','"+gross+"','"+tds+"','"+empId+"')";
	 						int p=0;
							int countFeild=0;
						try
						{
							StringTokenizer stringTokenizer = new StringTokenizer(row,"$");
							System.out.println("The total no. of tokens generated :  " + stringTokenizer.countTokens());
							//countFeild  = stringTokenizer.countTokens();
						
						//	while(stringTokenizer.hasMoreTokens()){
								//	System.out.println(stringTokenizer.nextToken());
									
									PayOrderNO = stringTokenizer.nextToken().trim();
									empId = stringTokenizer.nextToken().trim();
									contractorName = stringTokenizer.nextToken().trim();
									month = stringTokenizer.nextToken().trim();
									year = stringTokenizer.nextToken().trim();
									payableDays = stringTokenizer.nextToken().trim();
									perIndex = stringTokenizer.nextToken().trim();
									allowance4= stringTokenizer.nextToken().trim();
									deduction = stringTokenizer.nextToken().trim();
									deduction1 = stringTokenizer.nextToken().trim();
									deduction2 = stringTokenizer.nextToken().trim();
									deduction3 = stringTokenizer.nextToken().trim();
									PreviousPay = stringTokenizer.nextToken().trim();
									variable = stringTokenizer.nextToken().trim();
									incentive = stringTokenizer.nextToken().trim();
							
							
							System.out.println("The PayOrderNO is :**"+PayOrderNO);
							System.out.println("The empId is **:"+empId);
							System.out.println("The contractorName :**"+contractorName);
							System.out.println("The month :**"+month);
							System.out.println("The year:**"+year);
							System.out.println("The payableDays:**"+payableDays);
							System.out.println("The basic:**"+basic);
							System.out.println("The allowance is :**"+allowance);
							System.out.println("The deduction is :**"+deduction);
							System.out.println("The PreviousPay is :**"+PreviousPay);
							
							//============== get days in a month ================
									double Monthdays=0.0;
									int year1=Integer.parseInt(year);
							boolean isLeapYear = ((year1 % 4 == 0) && (year1 % 100 != 0) || (year1 % 400 == 0));


								switch(Integer.parseInt(month))
								{
								case 1: case 3: case 5:case 7:case 8: case 10: case 12: 
									   Monthdays=31;
								       break;  
								case 2:
										if (isLeapYear)
										{
									    	Monthdays=29;
										} else{
									    Monthdays=28;}
								       break;
								case 4: case 6: case 9: case 11: Monthdays=30; 
								       break;
								}
								System.out.println("Monthdays===="+Monthdays);
							
							
							//==================================================
							// ************** get allow & other details form contractor details *******
							String sqlfeedet="select * from db_leaveapplication.t_employee where EmpID='"+empId+"'";
							ResultSet rsfee=st4.executeQuery(sqlfeedet);
							while(rsfee.next())
							{  	basic = rsfee.getString("BasicSalarary");
								allowance = Double.parseDouble(rsfee.getString("Allowance"));
								allowance1 = Double.parseDouble(rsfee.getString("Allowance1"));
								allowance2 = Double.parseDouble(rsfee.getString("Allowance2"));
								allowance3 = Double.parseDouble(rsfee.getString("Allowance3"));
								tds = rsfee.getString("TDS");
								try{
								DateofJoining = rsfee.getString("DateofJoining");
								}
								catch(Exception e)
								{DateofJoining="-";}
										
							}
						
							allowance=Double.parseDouble(df.format((Double.parseDouble(df.format(allowance/Monthdays)))*Double.parseDouble(payableDays)));
							allowance1=Double.parseDouble(df.format((Double.parseDouble(df.format(allowance1/Monthdays)))*Double.parseDouble(payableDays)));
							allowance2=Double.parseDouble(df.format((Double.parseDouble(df.format(allowance2/Monthdays)))*Double.parseDouble(payableDays)));
							if(Double.parseDouble(payableDays)>=24)
							{allowance3=allowance3;
							}else
								allowance3=0;	
							//*************************************************************************
							//insert into table
							
							String sql="insert into db_leaveapplication.t_payable (contractorName,month,year,payableDays,basic,perIndex,variable,incentive,allowance,allowance1,allowance2,allowance3,allowance4,deduction,deduction1,deduction2,deduction3,tds,EmpId,Netpay,grosspay,PreviousPay) values('"+contractorName+"','"+month+"','"+year+"','"+payableDays+"','"+basic+"','"+perIndex+"','"+variable+"','"+incentive+"','"+ allowance+"','"+allowance1+"','"+allowance2+"','"+allowance3+"','"+allowance4+"','"+deduction+"','"+deduction1+"','"+deduction2+"','"+deduction3+"','"+tds+"','"+empId+"','0','0','"+PreviousPay+"')";
							
							System.out.println("The query is :"+sql);
							st1.execute(sql);
							System.out.println("The number of rows updated :");
							
							 //====================== code for net & gross pay calculation =======================		
									
							String sql1="select * from db_leaveapplication.t_payable where EmpId="+empId+" and month='"+month+"' and year='"+year+"' ";
							ResultSet rs=st1.executeQuery(sql1);
							if(rs.next())
							{
								
								System.out.println(" in side net pay calculation ====== ");
								
								
								double basic1=0.0,allow=0,allow1=0,allow2=0,allow3=0,allow4=0,deduct=0,deduct1=0,deduct2=0,deduct3=0,deduct4=0,tds1=0,incent=0,var=0,PrePay=0,pIndex=0;
								int paydays=0;
								try{
								paydays=rs.getInt("payableDays");
								basic1=Double.parseDouble(rs.getString("basic"));}catch(Exception e){}
								try{tds1=rs.getInt("tds"); 	System.out.println("tds======"+tds1);}catch(Exception e){}
								try{allow=rs.getInt("allowance");}catch(Exception e){}

								try{allow1=rs.getInt("allowance1");}catch(Exception e){}
								try{allow2=rs.getInt("allowance2");}catch(Exception e){}
								try{allow3=rs.getInt("allowance3");}catch(Exception e){}
								try{allow4=rs.getInt("allowance4");}catch(Exception e){}
								try{deduct=rs.getInt("deduction");}catch(Exception e){}
								try{deduct1=rs.getInt("deduction1");}catch(Exception e){}
								try{deduct2=rs.getInt("deduction2");}catch(Exception e){}
								try{deduct3=rs.getInt("deduction3");}catch(Exception e){}
								//try{deduct4=rs.getInt("deduction4");}catch(Exception e){}
								try{incent=rs.getInt("incentive");}catch(Exception e){}
								try{var=rs.getInt("variable");}catch(Exception e){}
								try{pIndex=rs.getDouble("perIndex");}catch(Exception e){}
								try{PrePay=rs.getInt("PreviousPay");}catch(Exception e){}
                                 

								


								try{
									System.out.println("basic1 =="+basic1);
								String perdaypay=df.format(basic1/Monthdays);
								System.out.println("perdaypay =="+perdaypay);
								
								System.out.println("allow =="+allow+" allow1 =="+allow1+ " allow2 =="+allow2+" allow3 =="+allow3);
								double grosspay= Double.parseDouble(df.format(Double.parseDouble(perdaypay)*paydays));

								if(pIndex>=90 || pIndex<=110)
								{grosspay=grosspay;
								}
								if(pIndex < 90 || pIndex >110)
								{ System.out.println((pIndex/100));
								    grosspay=grosspay*(pIndex/100);
								}
								grosspay=Math.round(grosspay);
								System.out.println("grosspay =="+grosspay);
								
								String grosspay1=df.format((grosspay+allow+allow1+allow2+allow3+allow4+incent+var+PrePay)-(deduct+deduct1+deduct2+deduct3+deduct4));
								Long grosspay2=Math.round(Double.parseDouble(grosspay1));

								
								Double tds2=(grosspay2)*(tds1/100);
								System.out.println("tds"+tds1);
								Double netpay1=grosspay2-tds2;
								System.out.println("netpay ============="+netpay1);
								String buffer=""+grosspay1+","+netpay1+"";

								String sqlupdate="update db_leaveapplication.t_payable set Netpay='"+netpay1+"',grosspay='"+grosspay2+"' where EmpId="+empId+"";
								st2.executeUpdate(sqlupdate);
								sendMsg="Excel records inserted successfuly";
								}
								catch(Exception e)
								{
									e.printStackTrace();
								}
								        		

							}
							//endif	
						}catch (Exception e) {
					         sendMsg="Insuficient data some rows are blank ";
							System.out.println("exceptionnnn===>>"+e);
						}
							
					
								            
								            System.out.println("  ");
				}//end of for loop of show excel data
				
				System.out.println("The total number of records in the excel sheet :"+cnt);
				
				//move the excel file in other folder
				//File f = new File("/home/shoaib/Desktop/Task_List/"+file1);
				File f = new File("/usr/share/tomcat6/webapps/TaskList/"+file1);
				/*if(f.renameTo(new File("/home/shoaib/Desktop/Moved_Files/" + file1)))
			    {							
				System.out.println("File is moved successful!");
				}
			*/
			    if(f.renameTo(new File("/usr/share/tomcat6/webapps/TaskListDestination/" + file1)))
				{							
					System.out.println("File is moved successful!");
				}
            
        //=======================================================================   
        		
       
        		
        response.sendRedirect("payableReport.jsp?sendMsg="+sendMsg+"");
}catch(Exception e){
	System.out.println("Th exception is >>>>>"+e);
	
}
%>