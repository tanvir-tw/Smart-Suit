<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.sql.*" import=" java.text.*" import="java.util.*"  import="java.util.Date" errorPage="" %>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.jibble.simpleftp.*"%>
<%@ page language="java"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List"%>

<%@ page language="java" import="java.sql.*" import=" java.text.*"
	import=" java.util.*" errorPage=""%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="javax.mail.*" import="java.util.Properties"
	import="javax.mail.internet.InternetAddress"
	import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.servlet.http.HttpServletRequest"
	import="javax.mail.internet.MimeBodyPart"
	import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.net.URL"%>
   <%@ page import="java.net.*"%>
<%--    <%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%> --%>
   <script src="js/multifile.js"></script>
   
<%!Connection con;%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null, st10=null;
	Statement st11=null,st12=null,st13=null,st14=null,st15=null,st16=null,st17=null,st18=null,st19=null, st20=null;
	Statement st21=null,st22=null,st23=null,st24=null,st25=null,st26=null,st27=null,st28=null,st29=null, st30=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String todaysDateTimeNew=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	System.out.println("*****  ***  "+todaysDateTimeNew);
	String EmpName="-",department="",grade="",fromdate="",todate="",companyName="",hrs="",min="",sec="",hrs1="",min1="",sec1="";
	String comments="",origin="",destination="",amount1="",billNumber="";
	String purpose="",advanceTaken="",sumOfAmount="",visitTo="",costCenter="",visitCity="",Comments="",category="";
	String sqlTmpInsert="",EmpName1="",sqlAmt="", SqlMasterDetails="", sqlItems="",id="";
	ResultSet rsDet;
	String sqlClaim="",Dept="", behalf="", claimant="", behalf1="";
	String companyname="",companyname1="",companyname2="",companyname3="",companyname4="",Client="",SqlClaimNo="";
	String SqlDet="",ourcompany="",claimtype="",ourcompany1="",claimtype1="",origin1="",destination1="",fromdate2="",todate2="",advanceTaken1="";
	double SumOfAmt=0.00,advance=0.00;
	String sqlInsert="",SqlUpdateClaim="",SqlUpdateClaimDet="",claimId="",sql="",CLMRefNumber="CLM",HodReport="";
	
	NumberFormat nf=NumberFormat.getInstance();
	String datesachin1="",datesachin2="";
	StringBuffer htmlstring=new StringBuffer("");
	StringBuffer htmlstring1=new StringBuffer("");
	StringBuffer htmlstringNew=new StringBuffer("");
	StringBuffer filevalues=new StringBuffer("");
	File savedFile;String itemNames ="",button="";
	String SqlAllPendingMail="",filename="",advanceDisp="",status="-";
	String empMail="",Hodmail="",clmrefid="",action="",fromdate1="",todate1="",purpose1="",uploadBill="",uploadBill1="";
	
%>
<%   //************** File Upload Code Start ************
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	System.out.println(!isMultipart);
	if (!isMultipart) {
	} else {
		System.out.println("IN ELSE    +++++   ");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
		items = upload.parseRequest(request);
		} catch (FileUploadException e) {
				e.printStackTrace();
		}
				Iterator itr = items.iterator();
			//  String a[]=request.getParameter("");
				String a = "";
				while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if (item.isFormField()) {
				String name = item.getFieldName();
				System.out.println("   NMAE    "+name);
				String value = item.getString();
				System.out.println("  value     "+value);
				
				if (name.equals("status")) {
					status = value;
					System.out.println(" status     "+status);
				}

				if (name.equals("id")) {
					id = value;
					System.out.println("id is   "+ id);
				}
					
				if (name.equals("ourcompany")) {
					ourcompany = value;
					System.out.println(" insert our com  "+ ourcompany);
				}
				
				if (name.equals("ourcompany1")) {
					ourcompany1 = value;
					System.out.println("update ourcom  "+ ourcompany1);
				}
				

				if (name.equals("claimtype")) {
					claimtype = value;
					System.out.println(" insert type     "+claimtype);
				}

				if (name.equals("claimtype1")) {
					claimtype1 = value;
					System.out.println("update type     "+claimtype1);
				}

				if (name.equals("fromdate1")) {
					fromdate1 = value;
					System.out.println(" insert fromdate "+fromdate1);
				}
               

				if (name.equals("fromdate2")) {
					fromdate2 = value;
					System.out.println(" update fromdate   "+fromdate2);
				}
				
				if (name.equals("todate1")) {
					todate1 = value;
					System.out.println(" insert todate "+todate1);
				}
               

				if (name.equals("todate2")) {
					todate2 = value;
					System.out.println(" update todate   "+todate2);
				}
				
				if (name.equals("advance")) {
					advanceDisp = value;
					System.out.println(" advanceDisp     "+ advanceDisp);
				}

				if (name.equals("advanceTaken")) {
					advanceTaken = value;
					System.out.println("insert advance     "+ advanceTaken);
				}
				
			
						
				if (name.equals("advanceTaken1")) {
					advanceTaken1 = value;
					System.out.println("update advance     "+ advanceTaken1);
				}
				

				
				if (name.equals("purpose")) {
					purpose = value;
					System.out.println("insert purpose "+ purpose);
				}	

				if (name.equals("purpose1")) {
					purpose1 = value;
					System.out.println(" update purpose "+ purpose1);
				}	
				
				if (name.equals("origin")) {
					origin = value;
					System.out.println(" insert origin  "+ origin);
				}

				if (name.equals("origin1")) {
					origin1 = value;
					System.out.println("update origin  "+ origin1);
				}
				
				if (name.equals("destination")) {
					destination = value;
					System.out.println("insert dsetin    "+ destination);
				}

				if (name.equals("destination1")) {
					destination1 = value;
					System.out.println("update dsetin    "+ destination1);
				}

				if (name.equals("button")) {
					button = value;
					System.out.println("button value"+ button);
				}
				
				if (name.equals("action")) {
					action = value;
					System.out.println("action value"+ action);
				}
				
				if (name.equals("bhalf")) {
					behalf = value;
					System.out.println("Behalf value areeeee  ----------"+ behalf);
				}
				
				if (name.equals("bhalf1")) {
					behalf1 = value;
					System.out.println("Behalf FOR UPDATION AAAAAAAAAAAAA  ----------"+ behalf1);
				}
			
			}
		
			else
				{
				try
							{

						 itemNames = item.getName();
						System.out.print("\n\file Name==> " +itemNames);
						String compId = session.getAttribute("CompanyMasterID").toString();


					  //String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
					    String FileUploadPath = "http://twtech.in:8585/TransworldDocs/ERPDocs/"+compId+"/";
					 // String FileUploadPath = "C:\\Users\\Bhagyashri\\Desktop\\All Folders\\";
					  
					   // String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir");
					  // String FileUploadPath ="/home/r_lakhote/transworld/webchart/WebContent/Test";
					    System.out.println("IIIIIII  "+FileUploadPath);
						File uploadDir = new File(FileUploadPath);
						//System.out.println("IIIIIII  "+uploadDir.toString());
						savedFile = new File(FileUploadPath+"/"+itemNames);
						
						//System.out.println("IIIIIII  "+savedFile);
						item.write(savedFile);
						//System.out.println("HHHHHH  "+filevalues);
						System.out.println("Your file has been saved at the loaction:"+FileUploadPath+""+itemNames);
						//System.out.println("HHHHHH  "+filevalues);


					}catch(Exception e)
					{   //String msg="Uploaded File Path Not Found";
						//response.sendRedirect("NewClaim.jsp?id="+clmrefid+"&status="+status+"&rs="+msg+"&action="+action+"");
						//response.sendRedirect("alertGoTo.jsp?msg=Uploaded File Path Not Found&goto=NewClaim.jsp?claimtype="+claimtype+"");
						e.printStackTrace();
					}
				

				}
			}
	}
	 %>

<%
boolean isInvoiceSelected=false;
try
{
	System.out.println("\n>>>>>>>>In insertClaim.jsp>>>>>>>>>>>>>>>>");	

	//System.out.println("\n In insertClaim.jsp");
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	//Connection connForMail=DriverManager.getConnection("jdbc:mysql://203.199.134.131/db_leaveapplication","erp","1@erp");
	///Connection connForMail=DriverManager.getConnection("jdbc:mysql://10.0.10.62/db_leaveapplication","erp","1@erp");
	//Statement stformail= connForMail.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	st5=con.createStatement();
	st6=con.createStatement();
	st7=con.createStatement();
	st8=con.createStatement();
	st9=con.createStatement();
	st10=con.createStatement();
	st11=con.createStatement();
	st12=con.createStatement();
	st13=con.createStatement();
	st14=con.createStatement();
	st15=con.createStatement();
	st16=con.createStatement();
	st17=con.createStatement();
	st18=con.createStatement();
	st19=con.createStatement();
	st20=con.createStatement();
	st21=con.createStatement();
	st22=con.createStatement();
	st23=con.createStatement();
	st24=con.createStatement();
	st25=con.createStatement();
	st26=con.createStatement();
	st27=con.createStatement();
	st28=con.createStatement();
	st29=con.createStatement();
	st30=con.createStatement();
	ResultSet rsClaimNo=null;
	//ResultSet rsClaim=null;
	///ResultSet rsClaimDet=null;
	
	if(advanceTaken.equals("null") || advanceTaken==null)
				{advanceTaken="-";}
		
	if(advanceTaken1.equals("null") || advanceTaken1==null)
		{advanceTaken1="-";}
		
	
	System.out.println("ADVANCE   "+advance);
	System.out.println("ADVANCE DISP  "+advanceDisp);
	System.out.println("ADVANCE TAKENN     "+advanceTaken);
	System.out.println("ADVANCE 11111111111  "+advanceTaken1);
	
	
	
	
	int count=0,count1=0;
	EmpName=session.getAttribute("EmpName").toString();
	System.out.println("EMP NAME >>>>>     '"+EmpName.trim()+"'");
	EmpName1=session.getAttribute("EmpName").toString();
	String SqlEmpDetails="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EmpName.trim()+"'";
	
	ResultSet rsEmpDetails=st1.executeQuery(SqlEmpDetails); 
	/* PreparedStatement ps=con.prepareStatement(SqlEmpDetails);
	ps.setString(1, EmpName);
	ResultSet rsEmpDetails=ps.executeQuery(SqlEmpDetails); */
	System.out.println("\n>>>>>>>>>>SqlEmpDetails:"+SqlEmpDetails);
	if(rsEmpDetails.next())
	{
		department=rsEmpDetails.getString("Dept");
		grade=rsEmpDetails.getString("TALevel");
		System.out.println(">>>>department:"+department);
		System.out.println(">>>>grade:"+grade);
		empMail=rsEmpDetails.getString("email");
		   System.out.println(">>>>>>  "+empMail);
		   HodReport=rsEmpDetails.getString("HodReport");
		   System.out.println(">>>>>>> "+Hodmail);
		   Dept=rsEmpDetails.getString("Dept");
	
	}
	  /*  String SqlData="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EmpName+"'";
	   ResultSet rsData=st1.executeQuery(SqlData);
	   System.out.println(">>>>>>>>SqlData:"+SqlData);
	   if(rsData.next())
	   {
		   empMail=rsData.getString("email");
		   System.out.println(">>>>>>  "+empMail);
		   HodReport=rsData.getString("HodReport");
		   System.out.println(">>>>>>> "+Hodmail);
		   Dept=rsData.getString("Dept");
		   
	   } */
	   System.out.println(">>>>>>>>empMail:"+empMail+">>>>>>>>>>>>HodReport:"+HodReport);
	   
	   String SqlHod="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+HodReport.trim()+"'";
	  //  String SqlHod="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where Dept='"+Dept+"' and Level='Level5'";
	  
	   ResultSet rsHod=st2.executeQuery(SqlHod);
	   System.out.println(">>>>>>>>SqlHod:"+SqlHod);
	   if(rsHod.next())
	   {
		   Hodmail=rsHod.getString("email");
	   }
	   empMail=rsEmpDetails.getString("email");
	   System.out.println(">>>>>>  "+empMail);
	   HodReport=rsEmpDetails.getString("HodReport");
	   System.out.println(">>>>>>> "+Hodmail);
	   Dept=rsEmpDetails.getString("Dept");
	   
   
	   System.out.println(">>>>>>>>Hodmail:"+Hodmail);
	if(id.contains("-"))
	{
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
		String sql3="SELECT CLMRefNumber  from "+session.getAttribute("CompanyMasterID").toString()+"claim_master  where CLMRefNumber like ('"+CLMRefNumber+""+date+"%') ORDER BY CLMRefNumber DESC LIMIT 1";
		ResultSet rs2=st3.executeQuery(sql3);
		System.out.println(">>>>sql3:"+sql3); 
		if(rs2.next())
		{
		  String a=rs2.getString(1);
		  System.out.println(">>>>>>>>  "+a);
		  System.out.println("IN IF  ");
		  CLMRefNumber=rs2.getString(1).substring(0,rs2.getString(1).length()-3)+df.format(Integer.parseInt(rs2.getString(1).substring(rs2.getString(1).length()-3, rs2.getString(1).length()))+1);
		  System.out.println("NO IS:  "+CLMRefNumber);

		}
		else
		{
		  CLMRefNumber+=date+"001";	
		}
		clmrefid=CLMRefNumber;
	 fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
	 System.out.println("FROM DATE IS:    "+fromdate);
	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
	 System.out.println("TO  DATE IS:    "+todate);
	 
	 
	    claimId="CID";
		
		
		String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		
		sql="SELECT ClaimID from "+session.getAttribute("CompanyMasterID").toString()+"claim_master  where ClaimID like ('"+claimId+""+idDate+"%') ORDER BY ClaimID DESC LIMIT 1";
		ResultSet rs=st4.executeQuery(sql);
		if(rs.next())
		claimId=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
		else
		claimId+=idDate+"001";
		
		String SqlClaimDet="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefid+"' and Cancel='1'";
		System.out.println(">>>>>>>>SqlClaimDet:"+SqlClaimDet);
		ResultSet rsClaimDet=st5.executeQuery(SqlClaimDet);
		while(rsClaimDet.next())
		{
			  SumOfAmt=SumOfAmt+rsClaimDet.getDouble(1);
		}
		System.out.println(">>>>>>>>SumOfAmt:"+SumOfAmt);
		if(claimtype.contains("localclaim"))
		{
			Client="-";
		}
		else
		{
			String SqlClaim="Select CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefid+"' and Cancel='1' ";
			System.out.println(">>>>>>>>SqlClaim:"+SqlClaim);
			ResultSet rsClaim=st6.executeQuery(SqlClaim);
			while(rsClaim.next())
			{
				   /*if(Client=="")
				   {
					   Client=rsClaim.getString("CompanyName");
				   }
				   else
				   {
					   Client=Client+","+rsClaim.getString("CompanyName");
				   }*/
				 Client=rsClaim.getString("CompanyName");
			}
		}
		System.out.println(">>>>>>>>Client:"+Client);
		 
		
	}
	else
	{
		String SqlClaimDet="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel='1'";
		System.out.println(">>>>>>>>SqlClaimDet:"+SqlClaimDet);
		ResultSet rsClaimDet=st7.executeQuery(SqlClaimDet);
		while(rsClaimDet.next())
		{
			  SumOfAmt=SumOfAmt+rsClaimDet.getDouble(1);
		}
		System.out.println(">>>>>>>>SumOfAmt:"+SumOfAmt);
		if(claimtype.contains("localclaim"))
		{
			Client="-";
		}
		else
		{
			String SqlClaim="Select CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel='1' ";
			System.out.println(">>>>>>>>SqlClaim:"+SqlClaim);
			ResultSet rsClaim=st8.executeQuery(SqlClaim);
			while(rsClaim.next())
			{
				   /*if(Client=="")
				   {
					   Client=rsClaim.getString("CompanyName");
				   }
				   else
				   {
					   Client=Client+","+rsClaim.getString("CompanyName");
				   }*/
				 Client=rsClaim.getString("CompanyName");
			}
		}
		System.out.println(">>>>>>>>Client:"+Client);
	}
	
	int claimno=0;
	//ourcompany=request.getParameter("ourcompany");
////	System.out.println(">>>>ourcompany:"+ourcompany);
	//claimtype=request.getParameter("claimtype");
	//System.out.println(">>>>claimtype:"+claimtype);
////	origin=request.getParameter("origin");
//	System.out.println(">>>>origin:"+origin);
//	destination=request.getParameter("destination");
//	System.out.println(">>>>destination:"+destination);
	////purpose=request.getParameter("purpose");
	//System.out.println(">>>>purpose:"+purpose);
////	advanceTaken=request.getParameter("advanceTaken");
//	System.out.println(">>>>advanceTaken:"+advanceTaken);  
	//String clmrefid=request.getParameter("clmrefid");
	//System.out.println(">>>>>>>>REF ID IS:"+clmrefid);
    try
    {
	
	//************************* Actual Data Saving is Done Here ****************************
	
	if(button.equals("0"))
	{

		if(id.contains("-"))
		{
			sqlClaim="Select count(*) as counter from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefid+"' and Cancel='1' ";
			System.out.println(">>>>>>>>sqlClaim:"+sqlClaim);
			ResultSet rssqlClaim=st9.executeQuery(sqlClaim);
			if(rssqlClaim.next())
			{
				count=rssqlClaim.getInt("counter");
				System.out.println(">>>>>>>>count:"+count);
			}
			/*if(count==0)
			{ String msg="Please Enter Item in Grid";
			    //response.sendRedirect("alertGoTo.jsp?msg=Please Enter Item in Grid &goto=NewClaim.jsp?id=- ");
			    response.sendRedirect("NewClaim.jsp?id=-&status="+status+"&msg="+msg+"&action=update");
			}
			else
			{*/
				
				if(itemNames.equals("null") || itemNames==null)
				{
					itemNames="-";
				}
				System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  "+itemNames);
				System.out.println("IN SAVE   IN SAVE   IN SAVE   ");
				
				
				if(behalf.isEmpty())
				{
					claimant=EmpName;
					System.out.println("CLIAMANT NAME FOR ================="+claimant);
				}else
				{
					claimant=behalf;
					System.out.println("CLIAMANT NAME FOR ===11111111111111=============="+claimant);
				}
				
				String sql_dept="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+claimant+"'";
				Statement st_dept=con.createStatement();
				ResultSet rs_dept=st_dept.executeQuery(sql_dept);
				if(rs_dept.next())
					department=rs_dept.getString("Dept");
				
				System.out.println("Department Name ---*** "+department);
				  sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_master ("+
				  "ClaimID,	CLMRefNumber,ClaimantName,Department,ClaimType,Company,DepartureDateTime,"+
				  "ArrivalDateTime,Purpose,ClaimSubmittedOn,ModeOfSubmition,"+
				  "ClaimReceivedOn,			"+
				  "SumOfClaimAmount,	AdvanceTaken,  "+
				  "CostCenter,Status ,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,Origin,Destination,CommentsByACDepa,Cancel,HodReport,"+
				  "UploadBill,Behalf,EnteredBy"+
				  ") VALUES ("+
				  "'"+claimId+"','"+clmrefid+"','"+claimant+"','"+department+"','"+claimtype+"','"+Client+"','"+fromdate+" 00:00:00',"+
				  "'"+todate+" 00:00:00','"+purpose+"','"+todaysDateTime+"','Web Site','"+todaysDateTime+"', "+
				  ""+ SumOfAmt+" ,"+
				  "'"+advanceTaken+"','"+ourcompany+"','Open','-','-','-','"+origin+"','"+destination+"','-','1','"+HodReport+"','"+itemNames+
				  "','"+behalf+"','"+EmpName+"')";
				
				  System.out.println("@@@@@   "+sqlInsert);
				  st10.executeUpdate(sqlInsert);
				 // String rs="save";
				  //String msg="Claim Saved with Id"+clmrefid+"";
				 response.sendRedirect("NewClaim.jsp?id="+clmrefid+"&status=Open&action=update&btstatus=save");
				 // response.sendRedirect("claimReport.jsp?action=view&bhalf='"+claimant);

           
			
		}
		else
		{
			if(action.contains("update"))
			{
				//ourcompany1=request.getParameter("ourcompany1");
			    fromdate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate2));
			    todate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate2));
                /*origin1=request.getParameter("origin1");
                //claimtype1=request.getParameter("claimtype1");
            	System.out.println(">>>>claimtype1:"+claimtype1);
            	//origin1=request.getParameter("origin1");
            	System.out.println(">>>>origin1:"+origin1);
            	//destination1=request.getParameter("destination1");
            	System.out.println(">>>>destination1:"+destination1);
            	//purpose1=request.getParameter("purpose1");
            	//System.out.println(">>>>purpose1:"+purpose1);
            	advanceTaken1=request.getParameter("advanceTaken1");
            	*/
            	
            	
            	System.out.println("BEHALF FOR UPDATION-------------@@@@@@@@@@@@@"+behalf1);  
            	
            	
            	if(itemNames!=null)
            	{	
            		if(behalf1.isEmpty())
    				{
    					claimant=EmpName.trim();
    					System.out.println("CLIAMANT NAME FOR ================="+claimant);
    				}else
    				{
    					claimant=behalf1;
    					System.out.println("CLIAMANT NAME FOR ===11111111111111=============="+claimant);
    				}
            		
            		SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set ClaimantName='"+claimant+"',SumOfClaimAmount='"+ SumOfAmt+"',ClaimType='"+claimtype1+"',DepartureDateTime='"+fromdate2+" 00:00:00',ArrivalDateTime='"+todate2+" 00:00:00',Purpose='"+purpose1+"',AdvanceTaken='"+advanceTaken1+"',CostCenter='"+ourcompany1+"',Origin='"+origin1+"',Destination='"+destination1+"',Behalf='"+behalf1+"',EnteredBy='"+EmpName.trim()+"',UploadBill='"+itemNames+"' where  CLMRefNumber='"+id+"' and Cancel='1' ";
            	}
            	else
            	{
            		SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set SumOfClaimAmount='"+ SumOfAmt+"',ClaimType='"+claimtype1+"',DepartureDateTime='"+fromdate2+" 00:00:00',ArrivalDateTime='"+todate2+" 00:00:00',Purpose='"+purpose1+"',AdvanceTaken='"+advanceTaken1+"',CostCenter='"+ourcompany1+"',Origin='"+origin1+"',Destination='"+destination1+"',Behalf='"+behalf1+"',EnteredBy='"+EmpName.trim()+"' where  CLMRefNumber='"+id+"' and Cancel='1' ";
                		
            	}
            	System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
				st11.executeUpdate(SqlUpdateClaim);
				
				//SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set CLMRefNumber='"+id+"' where ClaimantName='"+EmpName+"' and Status='Open' and Cancel='1' ";
			    //System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
				//st4.executeUpdate(SqlUpdateClaimDet);
				
				response.sendRedirect("alertGoTo.jsp?msg=Claim Updated with ID "+id+" &goto=claimReport.jsp?action=view ");
				
			}
			else
			{  
				if(itemNames!=null)
				{
				SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set SumOfClaimAmount='"+ SumOfAmt+"',UploadBill='"+itemNames+"' where CLMRefNumber='"+id+"' and Cancel='1' ";
				}
				else
				{SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set SumOfClaimAmount='"+ SumOfAmt+"', where CLMRefNumber='"+id+"' and Cancel='1' ";}
				System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
				st12.executeUpdate(SqlUpdateClaim);
				
				//SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set CLMRefNumber='"+id+"' where ClaimantName='"+EmpName+"' and Status='Open' and Cancel='1' ";
			    //System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
				//st4.executeUpdate(SqlUpdateClaimDet);
				
				response.sendRedirect("alertGoTo.jsp?msg=Claim Saved with ID "+id+" &goto=claimReport.jsp?action=view ");
				
			}
		}
	}
	
	
	/*       *************************coding for submit button  **********************************************   */
	
	
	else
	{    //coding for submit button
		System.out.println("IN SUBMIT  IN SUBMIT     ");
		
			
		//********************  Total claim Amount & paybale Amt ***************	
		double 	ClaimAmount=0;
	    
     	String SqlClaimAmount="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel=1";
     	 ResultSet rsAmount=st13.executeQuery(SqlClaimAmount);
	      System.out.println(">>>>>>>>>SqlClaimAmount:"+SqlClaimAmount);
		   
		   //   get value of advance 
		    String advance1=advanceDisp;
         System.out.println(">>>>>advance1:"+advance1);
         if(rsAmount.next())
	      {
	    	  ClaimAmount=rsAmount.getDouble(1);
	    	  System.out.println(">>>>>>>>>ClaimAmount:"+ClaimAmount);
	    	  
	      }	
			double payAmount= ClaimAmount-Double.parseDouble(advance1); 
	     System.out.println(">>>>>>>>>payAmount:"+payAmount);
	     
	   //******************** End  Total claim Amount & paybale Amt ***************
	     
	     
	     
	     if(id.contains("-"))
		{ 
			sqlClaim="Select count(*) as counter from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefid+"' and Cancel='1'";
			System.out.println(">>>>>>>>sqlClaim:"+sqlClaim);
			ResultSet rssqlClaim=st14.executeQuery(sqlClaim);
			if(rssqlClaim.next())
			{
				count=rssqlClaim.getInt("counter");
				System.out.println(">>>>>>>>count:"+count);
			}
			if(count==0)
			{ String msg="Please Enter Claim Details 123";
			      response.sendRedirect("NewClaim.jsp?id="+id+"&status="+status+"&action="+action+"&msg="+msg+"&porpose="+purpose+"&orign="+origin+"&advanceTaken="+advanceTaken+"&dest="+destination);    
			}
			else
			{
				
				sqlClaim="Select count(*) as counter from "+session.getAttribute("CompanyMasterID").toString()+"claim_master where CLMRefNumber='"+clmrefid+"' and Cancel='1'";
				System.out.println(">>>>>>>>sqlClaim:"+sqlClaim);
				ResultSet rssqlClaimM=st15.executeQuery(sqlClaim);
				if(rssqlClaimM.next())
				{
					count1=rssqlClaimM.getInt("counter");
					System.out.println(">>>>>>>>count1:"+count1);
				}
				if(count1==0)
				{
					 sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_master ("+
					  "ClaimID,	CLMRefNumber,ClaimantName,Department,ClaimType,Company,DepartureDateTime,"+
					  "ArrivalDateTime,Purpose,ClaimSubmittedOn,ModeOfSubmition,"+
					  "ClaimReceivedOn,			"+
					  "SumOfClaimAmount,	AdvanceTaken,  "+
					  "CostCenter,Status ,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,Origin,Destination,CommentsByACDepa,Cancel,HodReport ,UploadBill,Behalf"+
					  ") VALUES ("+
					  "'"+claimId+"','"+clmrefid+"','"+EmpName+"','"+department+"','"+claimtype+"','"+Client+"','"+fromdate+" 00:00:00',"+
					  "'"+todate+" 00:00:00','"+purpose+"','"+todaysDateTime+"','Web Site','"+todaysDateTime+"', "+
					  ""+ SumOfAmt+" ,"+
					  "'"+advanceDisp+"','"+ourcompany+"','Pending','-','-','-','"+origin+"','"+destination+"','-','1','"+HodReport+"','"+itemNames+"','"+behalf+"')";
					
					  System.out.println(">>>>>>>>sqlInsert:"+sqlInsert);
					  st6.executeUpdate(sqlInsert);
					  
					  SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Status='Submit' where CLMRefNumber='"+clmrefid+"' and Cancel='1'";
					  System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
					  st17.executeUpdate(SqlUpdateClaimDet);					  
					  response.sendRedirect("alertGoToClaim.jsp?msg=Claim Generated with ID "+clmrefid+" &goto=claimReport.jsp?action=view ");				
				 }
				else
				{
					SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Status='Pending',UploadBill='"+itemNames+"' SumOfClaimAmount='"+ SumOfAmt+"' where CLMRefNumber='"+clmrefid+"' and Cancel='1' ";
					System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
					st18.executeUpdate(SqlUpdateClaim);
					
					SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Status='Submit' where CLMRefNumber='"+clmrefid+"' and Cancel='1'";
				    System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
					st19.executeUpdate(SqlUpdateClaimDet);
					
					htmlstringNew.append("<table align=center border=15 bordercolor=#C6DEFF width=30% >");
					
					htmlstring.append("<br><div><font size=2 > New Claim From : "+EmpName+"  </b> </font></div><br>" +
									  "<table align=center width=40% border=1 cellpadding=0 cellspacing=0 ><tr><td><font size=2>Claim ID :"+clmrefid+"</font></td><td><font size=2 > Type Of Claim : </font>"+claimtype+"</td></tr>"+
									  "<tr><td><font size=2 > Origin :"+origin+" </font></td><td><font size=2 >Destination :"+destination+"</font> </td></tr>"+
									  "<tr><td><font size=2 > Departure On :"+fromdate1+" </font></td><td><font size=2 >Arrival On: "+todate1+"</font></td></tr>"+
									  "<tr><td><font size=2 > Advance Taken : "+advanceTaken+"0</font></td><td><font size=2 >Status: Pending</font></td><tr>"+
									  "<tr><td><font size=2>Claim Amount:"+nf.format(ClaimAmount)+".00</font></td><td><font size=2 color=red>Payable Amount:"+nf.format(payAmount)+".00</font></td></tr></table>");
					//System.out.println(">>>>>>>>>>htmlstring:"+htmlstring);
					
					response.sendRedirect("alertGoToClaim.jsp?msg=Claim Generated with ID "+clmrefid+" &goto=claimReport.jsp?action=view ");				
					
				}

			}
				
		}
		else
		{
			if(action.contains("update"))
			{
				
				sqlClaim="Select count(*) as counter from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel='1'";
				System.out.println(">>>>>>>>sqlClaim:"+sqlClaim);
				ResultSet rssqlClaim=st20.executeQuery(sqlClaim);
				if(rssqlClaim.next())
				{
					count=rssqlClaim.getInt("counter");
					System.out.println(">>>>>>>>count:"+count);
				}
				if(count==0)
				{
					String msg="Please Enter Claim Details";
					///clmrefid=id;
				      //response.sendRedirect("alertGoTo.jsp?msg=Please Enter Item in Grid &goto=claimReport.jsp?action=view "); 
					 response.sendRedirect("NewClaim.jsp?id="+id+"&status="+status+"&action="+action+"&msg="+msg+"");

				}
				else
				{
					//ourcompany1=request.getParameter("ourcompany1");
					System.out.println("sachin "+fromdate2);
					System.out.println("kapre  "+todate2);
					
					   datesachin1=fromdate2;
					   datesachin2=todate2;
					   
					   
					   
				    fromdate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate2));
				   todate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate2));
				   
			
				  // todate2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate2));
				   
				   
	                /*origin1=request.getParameter("origin1");
	                claimtype1=request.getParameter("claimtype1");
	            	System.out.println(">>>>claimtype1:"+claimtype1);
	            	origin1=request.getParameter("origin1");
	            	System.out.println(">>>>origin1:"+origin1);
	            	destination1=request.getParameter("destination1");
	            	System.out.println(">>>>destination1:"+destination1);
	            	purpose1=request.getParameter("purpose1");
	            	System.out.println(">>>>purpose1:"+purpose1);*/
	            	
	            	System.out.println("after "+fromdate2);
					System.out.println("after  "+todate2);
					
	            	
	            	//advanceTaken1=request.getParameter("advanceTaken1");
	            	//System.out.println(">>>>advanceTaken1:"+advanceTaken1);  
	            	
	            	SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set SumOfClaimAmount='"+ SumOfAmt+"',ClaimType='"+claimtype1+"',DepartureDateTime='"+fromdate2+" 00:00:00',ArrivalDateTime='"+todate2+" 00:00:00',Purpose='"+purpose1+"',AdvanceTaken='"+advanceDisp+"',CostCenter='"+ourcompany1+"',Origin='"+origin1+"',Destination='"+destination1+"',Status='Pending' where  CLMRefNumber='"+id+"' and Cancel='1' ";
					System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
					st21.executeUpdate(SqlUpdateClaim);
					
					
					/*SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Status='Pending' where CLMRefNumber='"+id+"' and Cancel='1' ";
					System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
					st3.executeUpdate(SqlUpdateClaim);*/
					
					SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Status='Submit' where  CLMRefNumber='"+id+"' and Cancel='1' ";
				    System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
					st22.executeUpdate(SqlUpdateClaimDet);
					
					htmlstring.append("<br><div align=center><font size=2 color=black> <b>New Claim From :"+EmpName+" </b> </font></div><br>" +
							  " <table align=center width=40% border=1 cellpadding=0 cellspacing=0 ><tr> <td><font size=2 >Claim ID : "+id+" </font></td><td><font size=2 >Type Of Claim :  "+claimtype1+"</font></td></tr>"+
							  " <tr><td><font size=2 >Origin :"+origin1+"</font> </td><td><font size=2 >Destination :"+destination1+"</font></td></tr> "+
							  " <tr><td> <font size=2 >Departure On :"+datesachin1+" </font></td><td><font size=2 >Arrival On: "+datesachin2+"</font></td></tr>"+
					     	  "<tr><td><font size=2 >Advance Taken : "+advanceDisp+"</font></td><td><font size=2 >Status: Pending</font></td></tr>"+
							  "<tr><td><font size=2 >Claim Amount:"+nf.format(ClaimAmount)+".00</font></td><td><font size=2 color=red>Payable Amount:"+nf.format(payAmount)+".00</font></td></tr></table>");
					
				
				  //System.out.println(">>>>>>>>>>htmlstring:"+htmlstring);
					
					response.sendRedirect("alertGoTo.jsp?msg=Claim Generated with ID "+id+" &goto=claimReport.jsp?action=view ");
				}
				
				
			}
			else
			{
				sqlClaim="Select count(*) as counter from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel='1'";
				System.out.println(">>>>>>>>sqlClaim:"+sqlClaim);
				ResultSet rssqlClaim=st23.executeQuery(sqlClaim);
				if(rssqlClaim.next())
				{
					count=rssqlClaim.getInt("counter");
					System.out.println(">>>>>>>>count:"+count);
				}
				if(count==0)
				{String rs="submit";
					///clmrefid=id;
				      //response.sendRedirect("alertGoTo.jsp?msg=Please Enter Item in Grid &goto=claimReport.jsp?action=view ");    
					 response.sendRedirect("NewClaim.jsp?id="+id+"&status="+status+"&action="+action+"&rs="+rs+"");
				}
				else
				{
				 SqlUpdateClaim=" Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Status='Pending',UploadBill='"+itemNames+"',SumOfClaimAmount='"+SumOfAmt+"' where  CLMRefNumber='"+id+"' and Cancel='1' ";
				 System.out.println(">>>>>>>>SqlUpdateClaim:"+SqlUpdateClaim);
				 st24.executeUpdate(SqlUpdateClaim);
				
				 SqlUpdateClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Status='Submit' where  CLMRefNumber='"+id+"' and Cancel='1' ";
			     System.out.println(">>>>>>>>SqlUpdateClaimDet:"+SqlUpdateClaimDet);
				 st25.executeUpdate(SqlUpdateClaimDet);
				 
				 String EmpClaim="select * from "+session.getAttribute("CompanyMasterID").toString()+"claim_master where  CLMRefNumber='"+id+"' and Cancel='1'";
				 System.out.println(">>>>>>>>>>>EmpClaim:"+EmpClaim);
				 
				  ResultSet rsEmpClaim=st26.executeQuery(EmpClaim);
				  if(rsEmpClaim.next())
				  {
					  String DD=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsEmpClaim.getString("DepartureDateTime")));
					  String AA=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsEmpClaim.getString("ArrivalDateTime")));
					  String SS=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEmpClaim.getString("ClaimSubmittedOn")));
				
						htmlstring.append("<br><div align=center><font size=2 color=black><b>New Claim From :"+EmpName+" </b> </font></div><br>" +
								  " <table align=center width=40% border=1 cellpadding=0 cellspacing=0 ><tr> <td><font size=2 >Claim ID : "+id+"</font> </td><td><font size=2 >Type Of Claim : </font><font size=2 > "+rsEmpClaim.getString("ClaimType")+"</font></td></tr>"+
								  " <tr><td><font size=2 >Origin :</font> <font size=2>"+rsEmpClaim.getString("Origin")+" </font></td><td><font size=2 >Destination :</font><font size=2>"+rsEmpClaim.getString("Destination")+"</font> </td></tr> "+
								  " <tr><td><font size=2 >Departure On :</font>"+DD+"</td><td><font size=2 >Arrival On : "+AA+"</font></td></tr>"+
								  " <tr><td><font size=2 >Advance Taken : "+rsEmpClaim.getString("AdvanceTaken")+"</font></td><td><font size=2 >Status: Pending</font></td></tr>"+
								  " <tr><td><font size=2>Claim Amount:"+nf.format(ClaimAmount)+".00</font></td><td><font size=2 color=red>Payable Amount:"+nf.format(payAmount)+".00</font></td></tr></table>");
					  
					  }
				  response.sendRedirect("alertGoTo.jsp?msg=Claim Generated with ID "+id+" &goto=claimReport.jsp?action=view ");
				 // System.out.println(">>>>>>>>>>htmlstring:"+htmlstring);

				}
			}
			
			
			
		}
	     
	
	       /**    ***************************************** DETAILS OF CLAIM & FORMATE OF MAIL DETAILS.  ***************************     */ 
	       
	       
	       int i=1;
		   String SqlClaimDet="";
		   SqlClaimDet="Select * from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel=1";
	   //    SqlClaimAmount="Select SUM(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+id+"' and Cancel=1";
		   
		   ResultSet rsClaimDet=st27.executeQuery(SqlClaimDet);
		   ResultSet rsClaimDet1=st28.executeQuery(SqlClaimDet);
		   //     GET TOTAL CLAIM AMOUNT & PAYABLE AMOUNT
		   
	      
		   String Date1="-",fromDate="",toDate="";
		  /*    ResultSet rsAmount=st2.executeQuery(SqlClaimAmount);
		      System.out.println(">>>>>>>>>SqlClaimAmount:"+SqlClaimAmount);
			   System.out.println(">>>>>SqlClaimDet:"+SqlClaimDet);
            
			   //   get value of advance 
			   advance1=advanceDisp;
              System.out.println(">>>>>advance1:"+advance1);
              if(rsAmount.next())
		      {
		    	  ClaimAmount=rsAmount.getDouble(1);
		    	  System.out.println(">>>>>>>>>ClaimAmount:"+ClaimAmount);
		    	  
		      }
		  */    
		      //SET VALUE OF FROM DATE & TO DATE 
		  
		      fromDate=toDate=Date1;
		      while(rsClaimDet1.next())
			  {
		    				
		    	 System.out.println("TTTT   sachin");
		    	 try{	
		    	             //System.out.println("22 "+rsClaimDet.getString("FromDateTime"));
		    	 			// System.out.println("33 "+rsClaimDet.getString("ToDateTime"));
		    				  if(rsClaimDet1.getString("Particulars").toString().contains("Expense") || rsClaimDet1.getString("Particulars").toString().contains("Travel")) 
	          						 { 
	        	  						 fromDate=toDate=Date1;
	        	  						 System.out.println("#######from date"+fromDate);
	         						  }
		      				 else
	           				{System.out.println("$$$id else");
	        	 					  if(rsClaimDet1.getString("Particulars").toString().contains("JourneyFare")) 
	             					  {
	        	  					   fromDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime")));
	        						   toDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("ToDateTime")));
	        						   System.out.println("###  if ####from date"+fromDate+ "   todate" +toDate);
	             					  }
	        	  					 else
	        	   					{
	        	 					fromDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime"))); 
	        						toDate=Date1; 
	        						System.out.println("#####  else ##from date"+fromDate+  "to date " +toDate);
	        	  					 }
	        				 }
		    	 }catch(Exception e)
		    			 {e.printStackTrace();}
		       }
	           System.out.println("#######from date"+fromDate);
	           System.out.println("#######To date"+toDate);
	           System.out.println(">>>>>>>>>before pay");
           // double payAmount= ClaimAmount-Double.parseDouble(advance1); 
		    // System.out.println(">>>>>>>>>payAmount:"+payAmount);
			  htmlstring1.append("<div align=center><font size=2 color=black><b> Claim Details </b></font></div>" +
		"<table align=center border=1 cellpadding=0 cellspacing=0>"+
			"<tr bgcolor=#C6DEFF>"+
			"<th><font size=2 color=black>SrNo </font></th>"+
			"<th><font size=2 color=black>Category</font> </th>"+
			"<th><font size=2 color=black>Mode</font></th>"+
			"<th><font size=2 color=black>Origin</font></th>"+
			"<th><font size=2 color=black>Dest</font></th>"+
			"<th><font size=2 color=black>Amount</font></th>"+
			"<th><font size=2 color=black>From</font></th>"+
			"<th><font size=2 color=black>To</font></th>"+
			"<th><font size=2 color=black>Purpose</font></th>"+
			"<th><font size=2 color=black>Km.</font></th>"+
			"<th><font size=2 color=black>City</font></th>"+
			"<th><font size=2 color=black>Bill By</font></th>"+
			"<th><font size=2 color=black>Bill No</font></th>"+
			"<th><font size=2 color=black>Remarks</font></th></tr>");
			while(rsClaimDet.next())
			{
			  htmlstring1.append("<tr>"+
				"<td align=right><font size=2>"+i+++"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("Particulars")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("ModeOfParticulars")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("FromPlace")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("ToPlace")+"</font></td>"+
			    "<td align=right><font size=2>"+nf.format(rsClaimDet.getDouble("Amount"))+".00</font></td>"+
			    "<td align=left><font size=2>"+fromDate+"</font></td>"+
			    "<td align=left><font size=2>"+toDate+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("Purpose")+"</font></td>"+
			    "<td align=right><font size=2>"+rsClaimDet.getString("KmTraveled")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("City")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("BillBy")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("BillNo")+"</font></td>"+
			    "<td align=left><font size=2>"+rsClaimDet.getString("CommentsByEmp")+"</font></td>"+
			"</tr>");
			}
			/*htmlstring1.append("<tr>"+
				"<td colspan=13 align=right><font size=2><b>Claim Amount:</b></font></td>"+
		        "<td align=right><font size=2>"+ClaimAmount+"0</font></td>"+
			"</tr>"+
			"<tr>"+
				"<td colspan=13><div align=right><font size=2><b>Payable Amount:</b></font></br><font size=2>(Claim Amount-AdvanceTaken)</font></div></td>"+
		   		"<td align=right><div align=right></div>"+payAmount+"0</td>"+
			"</tr>");
			*/
			  //End Claim Details
			/*if(rsClaimDet.getString("Particulars").toString().contains("Expense") ||   rsClaimDet.getString("Particulars").toString().contains("Travel")) 
		           {
		        	htmlstring.append(" <td><div align=right>"+Date1+"</div></td>"+ 
		        	 " <td><div align=right>"+Date1+"</div></td>"); 
		            }
		           else
		           {
		        	   if(rsClaimDet.getString("Particulars").toString().contains("JourneyFare")) 
		               {
		        		   htmlstring.append("<td><div align=right>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime")))+"</div></td>"+
		        	   "<td><div align=right>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("ToDateTime")))+"</div></td>");
		        	   }
		        	   else
		        	   {
		        		   htmlstring.append("<td><div align=right>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaimDet.getString("FromDateTime")))+"</div></td>"+ 
		        		//" <td><div align=right>"+Date1+"</div></td>"); 
		        	   // }
		        	   
		           }*/
		   SqlAllPendingMail="insert into  db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SendDateTime,SenderName)values('Claim Mail','-','<br><br><br>"+htmlstring+"<br>"+htmlstring1+"</table><br><br>  "+htmlstringNew+"</table> <br><div align=left> <font size=2 color=black>Thanks & Regards,<br>Accounts Dept,Transworld<br>accounts@transworld-compressor.com</font></div>','Claim Submitted By "+EmpName+"','"+Hodmail+"','"+empMail+"','"+todaysDateTime+"','Pending','"+todaysDateTime+"','"+EmpName+"')";
		   System.out.println(">>>>>>>>SqlAllPendingMail:"+SqlAllPendingMail);
		   st29.executeUpdate(SqlAllPendingMail);
	}
    }
    catch(Exception e)
    {
    	System.out.println( "Exception in Claim Insert ::"+e );
    }

	System.out.println("\n>>>>>>>>End of insertClaim.jsp>>>>>>>>>>>>>>>>");	

}
catch(Exception e)
{
	System.out.println("Exception in Claim Insert ::"+e );
	response.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
}
finally
{
	con.close();	
}

%>