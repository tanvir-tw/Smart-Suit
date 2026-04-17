<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.net.InetAddress" %>
<%@page import="java.io.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.util.List"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

<%!  
static int nextcount;
static int filecount;

%> 
<%!
public static String getMimeType(String fileUrl)
throws java.io.IOException, MalformedURLException
{
String type = null;
URL u = new URL(fileUrl);
URLConnection uc = null;
uc = u.openConnection();
type = uc.getContentType();
return type;
}

%>
<%
String filenmarr[]={};
System.out.println("\n create net banking text File");
try{
   erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);

	 Connection conn = null;
   Statement st = null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
   try {
	   conn = erp.ReturnConnection();
	   st = conn.createStatement();
	   st1 = conn.createStatement();
	   st2 = conn.createStatement();
	   st3 = conn.createStatement();
	   st4 = conn.createStatement();
	   st5 = conn.createStatement();
	   st6 = conn.createStatement();
   		}
   catch(Exception e)
   {
	  System.out.println(" connection error "+e); 
	   
   }
   
 /*  try {
       InetAddress thisIp = InetAddress.get192.168.2.55();
       System.out.println("IP:" + thisIp.getHostAddress());
   } catch (Exception e) {
       e.printStackTrace();
   }
   */
  	System.out.println("In side Ajax Create File.....");
   String tranType="",tranType1="",benfName="",benfBankName="",accountNo="",ifcCode="",refNo="",category="",comment="";
   String EmpName="",branchname="",email="",Stringtocreatefile="",newstring="",Partname="",date="",user_id="",recordmatter="";
   int amount=0,count=0;
   //static int nextcount=0;
   System.out.println("Ajax11  ");
   String user=session.getAttribute("user").toString();
   String todaysDate=new SimpleDateFormat("MM-dd").format(new java.util.Date());
   System.out.println("MM-dd------------------------------------------> "+todaysDate);
   String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
   String partDate="";
   String ddmm=new SimpleDateFormat("ddMM").format(new java.util.Date());
   System.out.println("ddmm------->"+ddmm+"*** "+todaysDate);
   //Format(Date, "ddmm");
   
    String Flgfnewfile="";
		 Flgfnewfile= request.getParameter("Flgfnewfile");
		 System.out.println("Flgfnewfile " +Flgfnewfile);
   String filenameDate="";
  	System.out.println("222");
 	 user_id=request.getParameter("id");
 	 System.out.println("user id List-------------------"+user_id);
 	String  idlist="";
 	String HDFC_TO_OTHER_250="0";
 	String HDFC_TO_HDFC_250="0";
 	String HDFC_TO_OTHER_3338="0";
 	String HDFC_TO_HDFC_3338="0";
 	 String buffer="No";
 	 String flg1="f";
 	String [] str_array = user_id.split(",");
 	String Recordtype="";
 	//String[] myStringArray = new String[5];

	for(int i = 1; i < str_array.length; i++)
	{
		
        String opt = str_array[i];
        //idlist = idlist+","+opt;
	
 	
 		//System.out.println("idlist---"+idlist);
 	 	String Recordtype1="";
 	 	String distinctRecTypeQry="Select Recordtype  from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where id in ("+opt+")";
 	 	System.out.println(distinctRecTypeQry);
	    ResultSet rs5=st5.executeQuery(distinctRecTypeQry);
	    
	    while(rs5.next())
		   {   
			   Recordtype1 =rs5.getString("Recordtype");
		   }
		   System.out.println("Recordtype---"+Recordtype1);
		   if (Recordtype1.equals("250-HDFC TO OTHER"))
			{
			   HDFC_TO_OTHER_250=HDFC_TO_OTHER_250+","+opt;
			}
			else if(Recordtype1.equals("250-HDFC TO HDFC"))
			{
				HDFC_TO_HDFC_250 = HDFC_TO_HDFC_250+","+opt;
			}
			else if(Recordtype1.equals("3338-HDFC TO OTHER"))
			{
				HDFC_TO_OTHER_3338 = HDFC_TO_OTHER_3338+","+opt;
			}
			else if(Recordtype1.equals("3338-HDFC TO HDFC"))
			{
				HDFC_TO_HDFC_3338 = HDFC_TO_HDFC_3338+","+opt;
			}
		
	 
	}//end of for loop   
	
	   System.out.println("Arrarys--HDFC_TO_OTHER_250->"+HDFC_TO_OTHER_250+"**HDFC_TO_HDFC_250-"+HDFC_TO_HDFC_250+"**HDFC_TO_OTHER_3338"+HDFC_TO_OTHER_3338+"**HDFC_TO_HDFC_3338-"+HDFC_TO_HDFC_3338);
	
	
	   String sqlnextcount="select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where( date_format(`Creationdate`, '%Y-%m-%d')) ='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
	   System.out.println(sqlnextcount);
	   ResultSet rs2=st.executeQuery(sqlnextcount);	  
	   while(rs2.next())
	   {   
	   count =rs2.getInt(1)+1;
	   }
	   nextcount=nextcount+count;
	   System.out.println("conttttttt"+nextcount);
	
	   //1st If Statement  
	
	if(HDFC_TO_OTHER_250!="0")
	{
		System.out.println("1 st IF");
		Partname="TCT0"+ddmm;
		nextcount=nextcount+1;
		
	  	System.out.println("next 1st If file num count "+nextcount);
	 	 DecimalFormat nf3 = new DecimalFormat("#000");
	  	String nextcount1=nf3.format(nextcount).toString();
	  
	  //folder create
	   	Writer output = null;
	   	String userHome="";
	   
	   	File currentDirectory = new File(new File("").getAbsolutePath());
	   	System.out.println("pathhhhhhhhhhhhhhh"+currentDirectory.getCanonicalPath());
	   	System.out.println("pathhhhhh"+currentDirectory.getAbsolutePath());
   
	   	String fileseprator=System.getProperty("file.separator");
	   	System.out.println("file seprator-->"+fileseprator);
	   	
   		//String FileName="/"+Partname+"."+nextcount1+"";
   		String FileName=fileseprator+Partname+"."+nextcount1+"";
   		String bnkfilename=""+Partname+"."+nextcount1;
     	System.out.println("name of File---------"+FileName);
   		String FilePath=currentDirectory.getAbsolutePath();
   		//String FilePath="G:\\software\\apache-tomcat-6.0.35\\apache-tomcat-6.0.35\\netbankingfiles";
   		//String FilePath="E:\\Tomcat1\\apache-tomcat-6.0.35\\apache-tomcat-6.0.35\\webapps\\netbankingfiles";
   		File savedir = new File(FilePath);
	   
   		System.out.println("FILEPATH------------------>"+FilePath);
    	   
    	   
    	   String [] str_array_id =  HDFC_TO_OTHER_250.split(",");
    	   Stringtocreatefile="";
    	   for(int i = 1; i < str_array_id.length; i++)
    		{
    		   String recordMaterQry="Select Recordmatter,id from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where id in ("+str_array_id[i]+") and RecordType='250-HDFC TO OTHER'";
    		   System.out.println(recordMaterQry);
    		   ResultSet rs6=st6.executeQuery(recordMaterQry);
    		   
    		   while(rs6.next())
    		   {   
    			   recordmatter=rs6.getString("Recordmatter");
    			   //recordmatter=recordmatter+"\n";
    			   System.out.println("i value:-->"+i+"file to be write:::"+recordmatter);
    			   
    		  //	newstring=recordmatter;
    			//System.out.println("newstring----------"+newstring);
    			//Stringtocreatefile = Stringtocreatefile+newstring;//+"\n";
    			}//end of while Loop
    			System.out.println("i value:-->"+i+"file to be write2222:::"+recordmatter);
    		   Stringtocreatefile+=recordmatter.trim()+"\n";
    			System.out.println("i value:-->"+i+"filllllll ****"+Stringtocreatefile);
    		}//end of for loop
    		System.out.println("filllllll  2222222222"+Stringtocreatefile);
    		for(int j = 1; j < str_array_id.length; j++)
			{
				
		       	 	String opt = str_array_id[j];
		        	String sqlinsert="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords  SET FileCreatedby='"+user+"',FileCreationDatetime='"+todaysDateTime+"',FileName1='"+FileName+"',RecordStatus='Created'  where id ="+opt+"";
	    		   System.out.println(" Update record netbanking records queryyy-"+sqlinsert+"j value"+j);   
	    		   st1.executeUpdate(sqlinsert);
	    		   //
	    		   String sqlinsertfile="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles SET Createdby='"+user+"',AccoutType='250-HDFC TO OTHER',CreationDate='"+todaysDateTime+"',FileName1='"+FileName+"',FileLocation='"+FilePath+"' where id ="+opt+"";
	    		   System.out.println(" Update t_netbankingfils record queryy"+sqlinsertfile+"j value"+j);   
	    		   st2.executeUpdate(sqlinsertfile);
		       	//UploadStatus
			}
    	   
    	   
	
	   System.out.println("Stringtocreatefile-------------"+Stringtocreatefile);
	   
		
	  
	   System.out.println("folder exisit---true---"+new File(FilePath).exists());
	   System.out.println("Stringtocreatefile22"+Stringtocreatefile);
	   System.out.println("Flgfnewfile----"+Flgfnewfile);
	  //create new file.
	  
   	    
   	   			 FileOutputStream fileOutputStream=null;
   	   		 	if(!new File(FilePath).exists()) 
   		  		{
   		  		 	File  dir = new File(FilePath); // dir.mkdir();
   		  		savedir.mkdirs();
   		 		 }	
   	   		String ffnn="";
					System.out.println("Filename saving on tomcat="+FileName);
					File savefile=null;
					try {
							
							 ffnn=FilePath+FileName+".txt";
					   	 	File file = new File(FilePath+FileName+".txt");
					   	    FileWriter fw = new FileWriter(file,true);
					   	    output = new BufferedWriter(new FileWriter(file));
					   	    output.write(Stringtocreatefile);
					   	    output.close();
							System.out.println("savefile"+file);
							
							//filecount++;
							//filenmarr[filecount++]=ffnn;
							session.setAttribute("filenmarray",ffnn);
							session.setAttribute("filename",bnkfilename);
							System.out.println("file------ for session---->"+ffnn+"ffname"+bnkfilename);
						} catch (IOException e1) 
						  {	
							e1.printStackTrace();
							}
								

   	    System.out.println("New file created ");
	 
   	 	flg1="t";
		//buffer="Yes";
		System.out.println("Ajax Output 1 st"+buffer);
	   	//out.println(buffer);
	System.out.println("----------------------------------------------------------------------------");	
		
	}//end of IF statement
	
	
	/// 2nd If Statement

	if(HDFC_TO_OTHER_3338!="0")
	{
		System.out.println("2nd IF");
		Partname="TCT8"+ddmm;
		///////
		//nextcount=0;
		//String sqlnextcount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
		nextcount=nextcount+1;
		
	  System.out.println("next 2 nd  If file num count "+nextcount);
	  //System.out.println("next count "+nextcount);
	  DecimalFormat nf3 = new DecimalFormat("#000");
	  String nextcount1=nf3.format(nextcount).toString();
	  
	  //folder create
	  
    	   /////
    	   
    	  	 Writer output = null;
	   		String userHome="";
	   		File currentDirectory = new File(new File("").getAbsolutePath());
		   	System.out.println("pathhhhhhhhhhhhhhh"+currentDirectory.getCanonicalPath());
		   	System.out.println("pathhhhhh"+currentDirectory.getAbsolutePath());
		   	
		   	
			String fileseprator=System.getProperty("file.separator");
		   	System.out.println("file seprator-->"+fileseprator);
		   	
	      	String FileName=fileseprator+Partname+"."+nextcount1+"";
	      	String bnkfilename=""+Partname+"."+nextcount1;
     		System.out.println("name of File---------"+FileName);
   			//String FilePath="/home/r_kunjir/Desktop/netbankingfiles";
   			String FilePath=currentDirectory.getAbsolutePath();
   			//String FilePath="E:\\Tomcat1\\apache-tomcat-6.0.35\\apache-tomcat-6.0.35\\webapps\\netbankingfiles";
   		 	File savedir = new File(FilePath);
    	   
    	   
    	   String [] str_array_id =  HDFC_TO_OTHER_3338.split(",");
    	   Stringtocreatefile="";
    	   for(int i = 1; i < str_array_id.length; i++)
    		{
    		   String recordMaterQry="Select Recordmatter,id from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where id in ("+str_array_id[i]+") and RecordType='3338-HDFC TO OTHER'";
    		   System.out.println(recordMaterQry);
    		   ResultSet rs6=st6.executeQuery(recordMaterQry);
    		   
    		   while(rs6.next())
    		   {   
    			   recordmatter=rs6.getString("Recordmatter");
    		  	//newstring=recordmatter;
    			//System.out.println("newstring----------"+newstring);
    			//Stringtocreatefile = Stringtocreatefile+newstring;//+"\n";
    			}//end of while Loop
    		   System.out.println("i value:-->"+i+"file to be write2222:::"+recordmatter);
    		   Stringtocreatefile+=recordmatter.trim()+"\n";
    			System.out.println("i value:-->"+i+"filllllll ****"+Stringtocreatefile);
    		}//end of for loop
    		for(int j = 1; j < str_array_id.length; j++)
			{
				
		       	 	String opt = str_array_id[j];
		        	String sqlinsert="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords  SET FileCreatedby='"+user+"',FileCreationDatetime='"+todaysDateTime+"',FileName1='"+FileName+"',RecordStatus='Created'  where id ="+opt+"";
	    		   System.out.println(" Update record netbanking records queryyy-"+sqlinsert+"j value"+j);   
	    		   st1.executeUpdate(sqlinsert);
	    		   //
	    		   String sqlinsertfile="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles SET Createdby='"+user+"',AccoutType='3338-HDFC TO OTHER',CreationDate='"+todaysDateTime+"',FileName1='"+FileName+"',FileLocation='"+FilePath+"' where id ="+opt+"";
	    		   System.out.println(" Update "+session.getAttribute("CompanyMasterID").toString()+"netbankingfils record"+sqlinsertfile+"j value"+j);   
	    		   st2.executeUpdate(sqlinsertfile);
		       
			}
    	   
    	   
	
	   System.out.println("Stringtocreatefile-------------"+Stringtocreatefile);
	   
		
	   if(!new File(FilePath).exists()) 
	  {
	   File  dir = new File(FilePath);  dir.mkdir();
	  }	
	   System.out.println("folder exisit---true---"+new File(FilePath).exists());
	   System.out.println("Stringtocreatefile22"+Stringtocreatefile);
	   System.out.println("Flgfnewfile----"+Flgfnewfile);
	  //create new file.
	  
	

			 FileOutputStream fileOutputStream=null;
		 	if(!new File(FilePath).exists()) 
	  		{
	  		 	File  dir = new File(FilePath); // dir.mkdir();
	  		savedir.mkdirs();
	 		 }	
			
			System.out.println("Filename saving on tomcat="+FileName);
			File savefile=null;
			try {
					
					String ffnn=FilePath+FileName+".txt";
			   	 	File file = new File(FilePath+FileName+".txt");
			   	    FileWriter fw = new FileWriter(file,true);
			   	    output = new BufferedWriter(new FileWriter(file));
			   	    output.write(Stringtocreatefile);
			   	    output.close();
					System.out.println("savefile"+file);
					session.setAttribute("filenmarray",ffnn);
					session.setAttribute("filename",bnkfilename);
					System.out.println("file------ for session---->"+ffnn);
				} catch (IOException e1) 
				  {	
					e1.printStackTrace();
					}
						

 System.out.println("New file created ");

	flg1="t";
//buffer="Yes";
System.out.println("Ajax Output 2 st"+buffer);
	//out.println(buffer);
System.out.println("----------------------------------------------------------------------------");	
		
	}//end of 2nd IF statement
	//3rd IF Statement 
	if(HDFC_TO_HDFC_250!="0")
	{
		System.out.println("3rd IF");
		Partname="TCT50"+ddmm;
		///////
		//nextcount=0;
		//String sqlnextcount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
		nextcount=nextcount+1;
		
	  System.out.println("next 3rd If file num count "+nextcount);
	 // System.out.println("next count "+nextcount);
	  DecimalFormat nf3 = new DecimalFormat("#000");
	  String nextcount1=nf3.format(nextcount).toString();
	  
	  //folder create
	Writer output = null;
	   	String userHome="";
	   
	   	File currentDirectory = new File(new File("").getAbsolutePath());
	   	System.out.println("pathhhhhhhhhhhhhhh"+currentDirectory.getCanonicalPath());
	   	System.out.println("pathhhhhh"+currentDirectory.getAbsolutePath());
   		
	   	String fileseprator=System.getProperty("file.separator");
	   	System.out.println("file seprator-->"+fileseprator);
   
   		String FileName=fileseprator+Partname+"."+nextcount1+"";
   		String bnkfilename=""+Partname+"."+nextcount1;
     	System.out.println("name of File---------"+FileName);
   		//String FilePath="/home/r_kunjir/Desktop/netbankingfiles";
   			String FilePath=currentDirectory.getAbsolutePath();
   		//String FilePath="E:\\Tomcat1\\apache-tomcat-6.0.35\\apache-tomcat-6.0.35\\webapps\\netbankingfiles";
   		 File savedir = new File(FilePath);
    	   
    	   
    	   String [] str_array_id =  HDFC_TO_HDFC_250.split(",");
    	   Stringtocreatefile="Account no.,C,Amount,Narration\n";
    	   for(int i = 1; i < str_array_id.length; i++)
    		{
    		   String recordMaterQry="Select Recordmatter,id from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where id in ("+str_array_id[i]+") and RecordType='250-HDFC TO HDFC'";
    		   System.out.println(recordMaterQry);
    		   ResultSet rs6=st6.executeQuery(recordMaterQry);
    		   
    		   while(rs6.next())
    		   {   
    			   recordmatter=rs6.getString("Recordmatter");
    		  //	newstring=recordmatter;
    			//System.out.println("newstring----------"+newstring);
    			//Stringtocreatefile = Stringtocreatefile+newstring;//+"\n";
    			}//end of while Loop
    		   System.out.println("i value:-->"+i+"file to be write2222:::"+recordmatter);
    		   Stringtocreatefile+=recordmatter.trim()+"\n";
    			System.out.println("i value:-->"+i+"filllllll ****"+Stringtocreatefile);
    		}//end of for loop
    		for(int j = 1; j < str_array_id.length; j++)
			{
				
		       	 	String opt = str_array_id[j];
		        	String sqlinsert="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords  SET FileCreatedby='"+user+"',FileCreationDatetime='"+todaysDateTime+"',FileName1='"+FileName+"',RecordStatus='Created'  where id ="+opt+"";
	    		   System.out.println(" Update record netbanking records queryyy-"+sqlinsert+"j value"+j);   
	    		   st1.executeUpdate(sqlinsert);
	    		   //
	    		   String sqlinsertfile="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles SET Createdby='"+user+"',AccoutType='250-HDFC TO HDFC',CreationDate='"+todaysDateTime+"',FileName1='"+FileName+"',FileLocation='"+FilePath+"' where id ="+opt+"";
	    		   System.out.println(" Update t_netbankingfils record"+sqlinsertfile+"j value"+j);   
	    		   st2.executeUpdate(sqlinsertfile);
		       
			}
    	   
    	   
	
	   System.out.println("Stringtocreatefile-----h to h--------"+Stringtocreatefile);
	   
		
	   if(!new File(FilePath).exists()) 
	  {
	   File  dir = new File(FilePath);  dir.mkdir();
	  }	
	   System.out.println("folder exisit---true---"+new File(FilePath).exists());
	   System.out.println("Stringtocreatefile22"+Stringtocreatefile);
	   System.out.println("Flgfnewfile----"+Flgfnewfile);
	  //create new file.
	  
	

			 FileOutputStream fileOutputStream=null;
		 	if(!new File(FilePath).exists()) 
	  		{
	  		 	File  dir = new File(FilePath); // dir.mkdir();
	  			savedir.mkdirs();
	 		 }	
			
			System.out.println("Filename saving on tomcat="+FileName);
			File savefile=null;
			try {
					
					String ffnn=FilePath+FileName+".txt";
			   	 	File file = new File(FilePath+FileName+".txt");
			   	    FileWriter fw = new FileWriter(file,true);
			   	    output = new BufferedWriter(new FileWriter(file));
			   	    output.write(Stringtocreatefile);
			   	    output.close();
					System.out.println("savefile"+file);
					session.setAttribute("filenmarray",ffnn);
					session.setAttribute("filename",bnkfilename);
					System.out.println("file------ for session---->"+ffnn);
					
					
				} catch (IOException e1) 
				  {	
					e1.printStackTrace();
					}
						

 System.out.println("New file created ");

	flg1="t";
//buffer="Yes";
System.out.println("Ajax Output 3 st"+buffer);
	//out.println(buffer);
System.out.println("----------------------------------------------------------------------------");	
		
	}//end of 3rd IF statement
	
	
	
	
	//4 th IF Statement 
	if(HDFC_TO_HDFC_3338!="0")
	{
		System.out.println("4rt IF");
		Partname="TCT38"+ddmm;
		///////
		//nextcount=0;
		// String sqlnextcount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
		nextcount=nextcount+1;
		
	  System.out.println("next 4 th If file num count "+nextcount);
	//  System.out.println("next count "+nextcount);
	  DecimalFormat nf3 = new DecimalFormat("#000");
	  String nextcount1=nf3.format(nextcount).toString();
	  
	  //folder create
	   	Writer output = null;
	   	String userHome="";
	   
	   	File currentDirectory = new File(new File("").getAbsolutePath());
	   	System.out.println("pathhhhhhhhhhhhhhh"+currentDirectory.getCanonicalPath());
	   	System.out.println("pathhhhhh"+currentDirectory.getAbsolutePath());
   		
		String fileseprator=System.getProperty("file.separator");
	   	System.out.println("file seprator-->"+fileseprator);
   
   		String FileName=fileseprator+Partname+"."+nextcount1+"";
   		String bnkfilename=""+Partname+"."+nextcount1;
     	System.out.println("name of File---------"+FileName);
   	//	String FilePath="/home/r_kunjir/Desktop/netbankingfiles";
   		String FilePath=currentDirectory.getAbsolutePath();
   	//String FilePath="E:\\Tomcat1\\apache-tomcat-6.0.35\\apache-tomcat-6.0.35\\webapps\\netbankingfiles";
   		 File savedir = new File(FilePath);
    	   
    	   String [] str_array_id =  HDFC_TO_HDFC_3338.split(",");
    	   Stringtocreatefile="Account no.,C,Amount,Narration\n";
    	   for(int i = 1; i < str_array_id.length; i++)
    		{
    		   String recordMaterQry="Select Recordmatter,id from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where id in ("+str_array_id[i]+") and RecordType='3338-HDFC TO HDFC'";
    		   System.out.println(recordMaterQry);
    		   ResultSet rs6=st6.executeQuery(recordMaterQry);
    		   newstring="";
    		   while(rs6.next())
    		   {  
    			   recordmatter=rs6.getString("Recordmatter");
    		   	//recordmatter =rs6.getString("Recordmatter");
    		  	//newstring=newstring+""+recordmatter;
    		  	//newstring=newstring.replace("/^\s+|\s+$/g","");

    			//System.out.println("newstring----------"+newstring);
    			
    			}//end of while Loop
    			 System.out.println("i value:-->"+i+"file to be write2222:::"+recordmatter);
      		   Stringtocreatefile+=recordmatter.trim()+"\n";
      			System.out.println("i value:-->"+i+"filllllll ****"+Stringtocreatefile);
    			//Stringtocreatefile+= newstring;//+"\n";
    		}//end of for loop
    		for(int j = 1; j < str_array_id.length; j++)
			{
				
		       	 	String opt = str_array_id[j];
		        	String sqlinsert="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords  SET FileCreatedby='"+user+"',FileCreationDatetime='"+todaysDateTime+"',FileName1='"+FileName+"',RecordStatus='Created'  where id ="+opt+"";
	    		   System.out.println(" Update record netbanking records queryyy-"+sqlinsert+"j value"+j);   
	    		   st1.executeUpdate(sqlinsert);
	    		   //
	    		   String sqlinsertfile="update  "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles SET Createdby='"+user+"',AccoutType='3338-HDFC TO HDFC',CreationDate='"+todaysDateTime+"',FileName1='"+FileName+"',FileLocation='"+FilePath+"' where id ="+opt+"";
	    		   System.out.println(" Update t_netbankingfils record"+sqlinsertfile+"j value"+j);   
	    		   st2.executeUpdate(sqlinsertfile);
		       
			}
		  
		  
		   
		   
    	   
    	   
	
	   System.out.println("Stringtocreatefile-------------"+Stringtocreatefile);
	   
		
	   if(!new File(FilePath).exists()) 
	  {
	   File  dir = new File(FilePath);  dir.mkdir();
	  }	
	   System.out.println("folder exisit---true---"+new File(FilePath).exists());
	   System.out.println("Stringtocreatefile22"+Stringtocreatefile);
	  // Stringtocreatefile = Stringtocreatefile.replace(' ', '\n');
	   System.out.println("Stringtocreatefile23"+Stringtocreatefile);
	   System.out.println("Flgfnewfile----"+Flgfnewfile);
	  //create new file.
	  
	

			 FileOutputStream fileOutputStream=null;
		 	if(!new File(FilePath).exists()) 
	  		{
	  		 	File  dir = new File(FilePath); // dir.mkdir();
	  			savedir.mkdirs();
	 		 }	
			
			System.out.println("Filename saving on tomcat="+FileName);
			File savefile=null;
			try {
					
					//ServletOutputStream output1 = response.getOutputStream();
					String ffnn=FilePath+FileName+".txt";
			   	 	File file = new File(FilePath+FileName+".txt");
			   	    FileWriter fw = new FileWriter(file,true);
			   	    output = new BufferedWriter(new FileWriter(file));
			   	    output.write(Stringtocreatefile);
			   	 	output.close();
			   		
			   	 	System.out.println("file name to store on machine"+bnkfilename);
			   	 	session.setAttribute("filenmarray",ffnn);
			   	 	session.setAttribute("filename",bnkfilename);
					System.out.println("file------ for session---->"+ffnn);
			   	    
			   	   
			   	   
					//System.out.println("savefile"+file);
				} catch (IOException e1) 
				  {	
					e1.printStackTrace();
					}
						

 System.out.println("New file created ");

	flg1="t";
//buffer="Yes";
System.out.println("Ajax Output 4 st"+buffer);
	//out.println(buffer);
System.out.println("----------------------------------------------------------------------------");	
		
	}//end of 4th IF statement
	
	System.out.println("Flag Report-------"+flg1);
	if(flg1=="t" )
	{
		System.out.println(" Inside success Report  -------");
	buffer="Yes";
	out.println(buffer);
	}else
	{
		System.out.println(" Inside Fail Report  -------");
	out.println(buffer);
	}
	
	
	
	
	
	
	
	
	

    	
}
catch(Exception e)
{
	System.out.println(" error is"+e);   
}
 %> 
   
   

</jsp:useBean>