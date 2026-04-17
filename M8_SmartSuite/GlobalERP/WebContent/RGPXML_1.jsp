<%@ include file="conn.jsp"%>
<%!
String name="";
String file_name="";
String path="/home/c_kapade/KaranXML/";
//String path="/home/karan/Desktop/karan/";
String desktopPath="";
%>
<%! 
Connection conn=null;
%>
<%
Date date=new Date();
int y=date.getYear();
int m=date.getMonth();
int d=date.getDate();
int h=date.getHours();
int mi=date.getMinutes();
int ss=date.getSeconds();
String sql_date=(y+1900)+"/"+(m+1)+"/"+d;

Format formatter = new SimpleDateFormat("MMMM"); 
String s = formatter.format(new Date());
System.out.println(s);
//file_name="PayRollBulk_"+name.replace(" ","")+"_"+(y+1900)+""+(m+1)+""+d+""+h+"TW";
file_name="RGP"+s+(y+1900)+"_"+h+mi+ss+".xml";
System.out.println("======================================================");
System.out.println("CreateXML page RGP");
Class.forName(DB_Driver);
Class.forName(DB_Driver);
conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
name=(String)session.getAttribute("EmpName");
System.out.println((y+1900)+"--"+(m+1)+"--"+d+"--"+h+"--"+mi+"--"+s+"--"+name);
desktopPath =System.getProperty("user.home") + "\\"+"Desktop";
String s1 = "//KaranXML/";// + desktopPath.replace("\\","\\\\") + "\\\\" +"XML" + "\"";
System.out.println("windows Path  "+s1);
File f1 = new File(s1);
boolean mkdir = f1.mkdir();
System.out.println("  Mkdir   "+mkdir);
System.out.println("  Path   "+path);
System.out.println("from payroll_3.jsp");
File outputFile = new File(path+""+file_name);
outputFile.createNewFile();
FileWriter outfile = new FileWriter(outputFile);
int iLf = 10;
char cLf = (char)iLf;
//outfile.write("<?xml version='1.0' encoding='ISO-8859-1'?>"+cLf);
//out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
HashMap<String,String> al=new HashMap<String,String>(); 
String file=request.getParameter("finalstr");

//System.out.println(file);
String[] data=file.split("@");
int counttw=0;
int countrgp=0;
int countncpl=0;
String strTW="";
String strRGP="";
File outputFile1 = new File(file_name);
outputFile.createNewFile();
FileWriter outfile1 = new FileWriter(outputFile);

outfile1.write("<ENVELOPE>"+cLf);
outfile1.write("<HEADER>"+cLf);
outfile1.write("<TALLYREQUEST>Import Data</TALLYREQUEST>"+cLf);
outfile1.write("</HEADER>"+cLf);
outfile1.write("<BODY>"+cLf);
outfile1.write("<IMPORTDATA>"+cLf);
outfile1.write("<REQUESTDESC>"+cLf);
outfile1.write("<REPORTNAME>All Masters</REPORTNAME>"+cLf);
outfile1.write("<STATICVARIABLES>"+cLf);
outfile1.write("</STATICVARIABLES>"+cLf);
outfile1.write("</REQUESTDESC>"+cLf);
outfile1.write("<REQUESTDATA>"+cLf);
out.println("<ENVELOPE>");
out.println("<HEADER>");
out.println("<TALLYREQUEST>Import Data</TALLYREQUEST>");
out.println("</HEADER>");
out.println("<BODY>");
out.println("<IMPORTDATA>");
out.println("<REQUESTDESC>");
out.println("<REPORTNAME>All Masters</REPORTNAME>");
out.println("<STATICVARIABLES>");
out.println("</STATICVARIABLES>");
out.println("</REQUESTDESC>");
out.println("<REQUESTDATA>");




//outfile1.write("<Contractor>"+cLf);
//out.println("<Contractor>");
for(int i=0;i<data.length;i++){
	String[] tabdata=data[i].split(",");
	for(int j=0;j<tabdata.length;j++){
		if(tabdata[j].equals("RGP")){
			System.out.println(" "+tabdata[j]);
			/* response.setHeader("Content-Disposition", "Attachment,filename="+file_name);
			response.setContentType("application/xml"); */
			try{
				al.put("Company", tabdata[0]);
				al.put("ContractorID", tabdata[1]);
				al.put("ContractorName", tabdata[2]);
				al.put("Month", tabdata[3]);
				al.put("GP", tabdata[4]);
				al.put("TDS", tabdata[5]);
				al.put("SD", tabdata[6]);
				al.put("Recovery", tabdata[7]);
				al.put("NetPay", tabdata[8]);
				al.put("PayrollDate", tabdata[9]);
			}catch(Exception e){e.printStackTrace();}
			
			Format formatter_1 = new SimpleDateFormat("yyyyMMdd"); 
			String s_d = formatter_1.format(new Date());
			//Date ss=new date();
			String ss_year=s_d.substring(2,4);
			int ss_after=Integer.parseInt(ss_year);
			ss_after=ss_after+1;
			System.out.println("ss_year "+ss_year);
			/* 

<NARRATION>Being SD Deducted from Pooja Khandelwal for Mar2015 Amt. 22034.00</NARRATION>
<EFFECTIVEDATE>20150420</EFFECTIVEDATE>
<ALLLEDGERENTRIES.LIST>
<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>
<LEDGERFROMITEM>No</LEDGERFROMITEM>
<LEDGERNAME>Pooja Khandelwal</LEDGERNAME>
<AMOUNT>-22034.00</AMOUNT>
</ALLLEDGERENTRIES.LIST>
<ALLLEDGERENTRIES.LIST>
<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
<LEDGERFROMITEM>No</LEDGERFROMITEM>
<LEDGERNAME>Pooja Khandelwal Security Deposit</LEDGERNAME>
<AMOUNT>22034.00</AMOUNT>
</ALLLEDGERENTRIES.LIST>
</VOUCHER>
</TALLYMESSAGE>

			*/
			
						
			
			out.println("<TALLYMESSAGE xmlns:UDF='TallyUDF'>");
			out.println("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>");
			out.println("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>");
			out.println("<DATE>" + s_d +"</DATE>");
			out.println("<PARTYLEDGERNAME>" + al.get("ContractorName") +"</PARTYLEDGERNAME>");
			out.println("<NARRATION>Being Contractor Fee Entry of " + al.get("ContractorName") +" for " + al.get("Month") +" Amt. "+al.get("GP")+" </NARRATION>");
			out.println("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>Contractor Fee</LEDGERNAME>");
			out.println("<AMOUNT>-"+al.get("GP")+"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>");
			out.println("<AMOUNT>" + al.get("GP") +"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("</VOUCHER>");
			out.println("</TALLYMESSAGE>");
			
			out.println("<TALLYMESSAGE xmlns:UDF='TallyUDF'>");
			out.println("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>");
			out.println("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>");
			out.println("<DATE>" + s_d +"</DATE>"+cLf);
			out.println("<PARTYLEDGERNAME>TDS Payable "+ss_year +"-"+(ss_after) +"</PARTYLEDGERNAME>");
			out.println("<NARRATION>Being TDS Deducted from "+al.get("ContractorName")+"  for " + al.get("Month") +"  Amt. " + al.get("TDS") +"</NARRATION>");
			out.println("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>");
			out.println("<AMOUNT>-"+al.get("TDS")+"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>TDS Payable "+ss_year +"-"+(ss_after) +"</LEDGERNAME>");
			out.println("<AMOUNT>"+al.get("TDS")+"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("</VOUCHER>");
			out.println("</TALLYMESSAGE>");
			
			out.println("<TALLYMESSAGE xmlns:UDF='TallyUDF'>");
			out.println("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>");
			out.println("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>");
			out.println("<DATE>"+s_d+"</DATE>");
			out.println("<PARTYLEDGERNAME>" + al.get("ContractorName") +" Security Deposit</PARTYLEDGERNAME>");
			out.println("<NARRATION>Being SD Deducted from " + al.get("ContractorName") +" for " + al.get("Month") +" Amt. " + al.get("SD") +"</NARRATION>");
			out.println("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>");
			out.println("<AMOUNT>-"+al.get("SD")+"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("<ALLLEDGERENTRIES.LIST>");
			out.println("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>");
			out.println("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>");
			out.println("<LEDGERFROMITEM>No</LEDGERFROMITEM>");
			out.println("<LEDGERNAME>"+al.get("ContractorName")+" Security Deposit</LEDGERNAME>");
			out.println("<AMOUNT>"+al.get("SD")+"</AMOUNT>");
			out.println("</ALLLEDGERENTRIES.LIST>");
			out.println("</VOUCHER>");
			out.println("</TALLYMESSAGE>");
			
			/*  -----------------------------------  */
			
			
			outfile1.write("<TALLYMESSAGE xmlns:UDF='TallyUDF'>"+cLf);
			outfile1.write("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>"+cLf);
			outfile1.write("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>"+cLf);
			outfile1.write("<DATE>" + s_d +"</DATE>"+cLf);
			outfile1.write("<PARTYLEDGERNAME>" + al.get("ContractorName") +"</PARTYLEDGERNAME>"+cLf);
			outfile1.write("<NARRATION>Being Contractor Fee Entry of " + al.get("ContractorName") +" for " + al.get("Month") +" Amt. "+al.get("GP")+"</NARRATION>"+cLf);
			outfile1.write("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>Contractor Fee</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>-"+al.get("GP")+"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>" + al.get("GP") +"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("</VOUCHER>"+cLf);
			outfile1.write("</TALLYMESSAGE>"+cLf);
			
			outfile1.write("<TALLYMESSAGE xmlns:UDF='TallyUDF'>"+cLf);
			outfile1.write("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>"+cLf);
			outfile1.write("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>"+cLf);
			outfile1.write("<DATE>" + s_d +"</DATE>"+cLf);
			outfile1.write("<PARTYLEDGERNAME>TDS Payable "+ss_year +"-"+(ss_after) +"</PARTYLEDGERNAME>"+cLf);
			outfile1.write("<NARRATION>Being TDS Deducted  from "+al.get("ContractorName")+" for " + al.get("Month") +"  Amt. " + al.get("TDS") +"</NARRATION>"+cLf);
			outfile1.write("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>-"+al.get("TDS")+"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>TDS Payable "+ss_year +"-"+(ss_after) +"</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>"+al.get("TDS")+"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("</VOUCHER>"+cLf);
			outfile1.write("</TALLYMESSAGE>"+cLf);
			
			outfile1.write("<TALLYMESSAGE xmlns:UDF='TallyUDF'>"+cLf);
			outfile1.write("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>"+cLf);
			outfile1.write("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>"+cLf);
			outfile1.write("<DATE>"+s_d+"</DATE>"+cLf);
			outfile1.write("<PARTYLEDGERNAME>" + al.get("ContractorName") +" Security Deposit</PARTYLEDGERNAME>"+cLf);
			outfile1.write("<NARRATION>Being SD Deducted from " + al.get("ContractorName") +" for " + al.get("Month") +" Amt. " + al.get("SD") +"</NARRATION>"+cLf);
			outfile1.write("<EFFECTIVEDATE>"+s_d+"</EFFECTIVEDATE>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>" + al.get("ContractorName") +"</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>-"+al.get("SD")+"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>"+cLf);
			outfile1.write("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>"+cLf);
			outfile1.write("<LEDGERFROMITEM>No</LEDGERFROMITEM>"+cLf);
			outfile1.write("<LEDGERNAME>"+al.get("ContractorName")+" Security Deposit</LEDGERNAME>"+cLf);
			outfile1.write("<AMOUNT>"+al.get("SD")+"</AMOUNT>"+cLf);
			outfile1.write("</ALLLEDGERENTRIES.LIST>"+cLf);
			outfile1.write("</VOUCHER>"+cLf);
			outfile1.write("</TALLYMESSAGE>"+cLf);
			
			
			
			
			/* out.println("<Employee>");
			out.println("<Company>" + al.get("Company") +"</Company>");
			out.println("<ContractorID>" + al.get("ContractorID") +"</ContractorID>");
			 out.print("<ContractorName>" + al.get("ContractorName") +"</ContractorName>");
			 out.print("<Month>" + al.get("Month") +"</Month>");
			 out.print("<GP>" + al.get("GP") +"</GP>");
			 out.print("<TDS>" + al.get("TDS") +"</TDS>");
			 out.print("<SD>" + al.get("SD")+"</SD>");
			 out.print("<Recovery>" + al.get("Recovery") +"</Recovery>");
			 out.print("<NetPay>" + al.get("NetPay") +"</NetPay>");
			 out.print("<PayrollDate>" + al.get("PayrollDate") +"</PayrollDate>");
			 out.println("</Employee>"); */
/* 			 outfile1.write("<Employee>");
			 outfile1.write("<Company>" + al.get("Company") +"</Company>"+cLf);
			 outfile1.write("<ContractorID>" + al.get("ContractorID") +"</ContractorID>"+cLf);
			 outfile1.write("<ContractorName>" + al.get("ContractorName") +"</ContractorName>"+cLf);
			 outfile1.write("<Month>" + al.get("Month") +"</Month>"+cLf);
			 outfile1.write("<GP>" + al.get("GP") +"</GP>"+cLf);
			 outfile1.write("<TDS>" + al.get("TDS") +"</TDS>"+cLf);
			 outfile1.write("<SD>" + al.get("SD")+"</SD>"+cLf);
			 outfile1.write("<Recovery>" + al.get("Recovery") +"</Recovery>"+cLf);
			 outfile1.write("<NetPay>" + al.get("NetPay") +"</NetPay>"+cLf);
			 outfile1.write("<PayrollDate>" + al.get("PayrollDate") +"</PayrollDate>"+cLf);
			 outfile1.write("</Employee>");
 */
			}
	
}}
outfile1.write("</REQUESTDATA>"+cLf);
outfile1.write("</IMPORTDATA>"+cLf);
outfile1.write("</BODY>"+cLf);
outfile1.write("</ENVELOPE>"+cLf);
out.println("</REQUESTDATA>"+cLf);
out.println("</IMPORTDATA>"+cLf);
out.println("</BODY>"+cLf);
out.println("</ENVELOPE>"+cLf);
//out.println("</Contractor>");
//outfile1.write("</Contractor>"+cLf);
%>
<%

outfile1.close();
System.out.println("Calling Method");
//copyToFtp();
System.out.println("After Calling Method");
%>

<%!
public void copyToFtp(){
	try{
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
			System.out.println("Login success "+path+"  file_name "+file_name);
			//File outputFile1 = new File(path+""+file_name);
			try{
			File outputFile1 = new File(file_name);
			
			fis=new FileInputStream(file_name);
			
			}catch(Exception e){e.printStackTrace();}
			System.out.println("Fis "+fis);
			ftpclient.setFileType(FTP.BINARY_FILE_TYPE);
		    ftpclient.changeWorkingDirectory("/");
		    File folder = new File(path);
			File[] listOfFiles = folder.listFiles();
			  	
			  	System.out.println("length of file --"+listOfFiles.length);
		    for (int i = 0; i < listOfFiles.length; i++) 
			  	{
		    	if (listOfFiles[i].isFile()) 
				   	{
		    		//System.out.println("PATH=="+path+""+listOfFiles[i].getName());
		    		File file1 = new File(listOfFiles[i].getName());
		    		String files=listOfFiles[i].getName();
		    		fis = new FileInputStream(file1);
		    		System.out.println("New File Name-"+ files+"   file name="+file_name);
		    		if(file_name.equalsIgnoreCase(files)){
		    			System.out.println("/PayrollXML/"+files);
		    			System.out.println("Match File Found");
		    		System.out.println("/PayrollXML/"+files);
		    		
		    		//result = ftpclient.storeFile("/PayrollXML/"+files+"", fis);
		    		
		    		System.out.println("result  "+result);
			    		if (result) 
			    		{
			    			System.out.println("File uploaded");
			    			String max_sql="select MAX(SrNo) from t_payrollXML";
			    			System.out.println(max_sql);
			    			Statement st_max=conn.createStatement();
			    			ResultSet rs_max=st_max.executeQuery(max_sql);
			    			String max="";
			    			if(rs_max.next()){
			    				max=rs_max.getString(1);
			    				System.out.println("Max No is "+max);
			    			}
			    			int max_int=Integer.parseInt(max);
			    			System.out.println("Max No is "+max_int);
			    			max_int++;
			    			
			    			sql="insert into t_payrollXML(SrNo,filename,generatedby) values('"+max_int+"','"+file_name+"','"+name+"')";
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
		    		
		    		}else{
		    			System.out.println("Not Match File Found");
		    		}
		    		
		    		
				   	}
			  	}
		    ftpclient.logout();
		} 
		}catch(Exception e){}
}

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
<%
String file_move=request.getParameter("filename");
file_move=file_move+"";
String z=file_move+""+file_name;
System.out.println("file mocw "+z);
response.sendRedirect("NCPLXML_1.jsp?finalstr="+file+"&filename1="+z);
%> 