<%@ include file="conn.jsp"%>
<script type="text/javascript">
alert("XML Created Successfully at Desktop");
window.location = 'payroll.jsp';
</script>

<%
String com=(String)session.getAttribute("CompanyMasterID");
String name="";
String file_name="";
String path="/home/c_kapade/KaranXML/";
//String path="/home/karan/Desktop/karan/";
String desktopPath="";
Date date=new Date();
int y=date.getYear();
int m=date.getMonth();
int d=date.getDate();
int h=date.getHours();
int mi=date.getMinutes();
int ss=date.getSeconds();
String sql_date=(y+1900)+"/"+(m+1)+"/"+d;
int strlen=0;

String tw;
String rgp;
String ncpl;
%>
<%! 
Connection conn=null;
%>
<%
/* String filemove=request.getParameter("filename");
String str[]=filemove.split("#");
strlen=str.length;
try{
String tw=str[0];
String rgp=str[1];
String ncpl=str[2];
}catch(Exception e){e.printStackTrace();} */
Format formatter = new SimpleDateFormat("MMMM"); 
String s = formatter.format(new Date());
//System.out.println(s);
System.out.println("======================================================");
System.out.println("CreateXML page Completed");
Class.forName(DB_Driver);
Class.forName(DB_Driver);
conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
name=(String)session.getAttribute("EmpName");
//System.out.println((y+1900)+"--"+(m+1)+"--"+d+"--"+h+"--"+mi+"--"+s+"--"+name);
desktopPath =System.getProperty("user.home") + "\\"+"Desktop";
String s1 = "//KaranXML/";// + desktopPath.replace("\\","\\\\") + "\\\\" +"XML" + "\"";
//System.out.println("windows Path  "+s1);
File f1 = new File(s1);
boolean mkdir = f1.mkdir();
System.out.println("  Mkdir   "+mkdir);
System.out.println("  Path   "+path);
int counttw=0;
int countrgp=0;
int countncpl=0;
String strTW="";
String strRGP="";
%>
<%	try{
		Connection con=DriverManager.getConnection("jdbc:mysql://103.8.126.138/db_leaveapplication","erp","1@erp");
		Statement st=con.createStatement();
		FTPClient ftpclient = new FTPClient();
		InputStream inStream = null;
		OutputStream outStream = null;
		FileInputStream fis = null;
		boolean result=false;
		String sql="";
		String ftpServerAddress = "203.199.134.131";
		String userName = "sumedh";
		String password = "789&*(medh";
		ftpclient.connect(ftpServerAddress);
		boolean login = ftpclient.login(userName,password);
		if (login) {
			System.out.println("Login success "+path);
			
			//System.out.println("Fis "+fis);
			ftpclient.setFileType(FTP.BINARY_FILE_TYPE);
		    ftpclient.changeWorkingDirectory("/");
		    File folder = new File(path);
			File[] listOfFiles = folder.listFiles();
			  	
			//System.out.println("length of file --"+listOfFiles.length+"  "+tw+" "+ncpl+" "+rgp);
		    for (int i = 0; i < listOfFiles.length; i++) 
			  	{
		    	if (listOfFiles[i].isFile()) 
				   	{
		    		File file1 = new File(path+""+listOfFiles[i].getName());
		    		String files=listOfFiles[i].getName();
		    		
		    		System.out.println("File Name-"+ files);
		    		String filemove=request.getParameter("filename");
		    		//System.out.println("karan  132 "+filemove);
		    		String str[]=filemove.split("@");
		    		
		    		strlen=str.length;
		    		//System.out.println("karan  length "+strlen);
		    		for(int z=0;z<strlen;z++){
		    			if(str[z].equalsIgnoreCase(files)){
		    			//	System.out.println("karan  length "+str[z]);
		    			//System.out.println("karan   "+str[z]);
		    			//System.out.println("/PayrollXML/"+files);
			    		fis = new FileInputStream(path+""+str[z]);
			    		/* int content=0;
			    		while ((content = fis.read()) != -1) {
							System.out.print((char) content);
						}
			    		
			    		System.out.println("path from fis "+fis.read());
			    		 */
			    		try{
			    		result = ftpclient.storeFile("/PayrollXML/"+files+"", fis);
			    		}catch(Exception e){e.printStackTrace();}
			    		System.out.println("result "+result);
			    		if (result) 
				    		{
				    			System.out.println("File uploaded");
				    			String max_sql="select MAX(SrNo) from "+com+"payrollXML";
				    			System.out.println(max_sql);
				    			Statement st_max=conn.createStatement();
				    			ResultSet rs_max=st_max.executeQuery(max_sql);
				    			String max="";
				    			if(rs_max.next()){
				    				max=rs_max.getString(1);
				    				//System.out.println("Max No is "+max);
				    			}
				    			int max_int=Integer.parseInt(max);
				    			//System.out.println("Max No is "+max_int);
				    			max_int++;
				    			
				    			sql="insert into "+com+"payrollXML(SrNo,filename,generatedby) values('"+max_int+"','"+str[z]+"','"+name+"')";
				    			System.out.println("insert sql "+sql);
				    			
									PreparedStatement psinsert=conn.prepareStatement(sql);
									int x=0;
									try{
									x=psinsert.executeUpdate();
									}catch(Exception e){e.printStackTrace();}
									if(x>0){
										System.out.println("inserted in to DB  ");
									}else{
										System.out.println("not inserted in to DB  ");
									}
								
				    			}
			    		}
		    		}}
			  	}}
		    ftpclient.logout();

		}catch(Exception e){}


%>
<%@page import="org.apache.commons.net.ftp.FTPConnectionClosedException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.commons.net.ftp.FTP"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
