
    <%@page import="com.erp.beans.*"%>
    <%@page import="java.util.Date"%>
    <%@page import="java.io.File"%>
    <%@ include file="conn.jsp"%>
   

 <%
 Connection conn = null,conn1=null;
 Class.forName(DB_Driver);
 //conn=DriverManager.getConnection("jdbc:mysql://203.199.134.131/db_GlobalERP","erp","1@erp");
 /*conn=DriverManager.getConnection("jdbc:mysql://203.199.134.131:3306/db_GlobalERP","erp","1@erp");*/
 //conn1=DriverManager.getConnection("jdbc:mysql://203.199.134.131/db_gps","erp","1@erp");
 /*conn1=DriverManager.getConnection("jdbc:mysql://203.199.134.131:3306/db_gps","erp","1@erp");*/
//conn=DriverManager.getConnection("jdbc:mysql://203.199.134.131/db_GlobalERP","erp","1@erp");
conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
//conn1=DriverManager.getConnection("jdbc:mysql://182.18.129.62/db_gps","erp","1@erp");
 %>
 <%
 	
 	Statement sterp = null, sterp1 = null, stgps = null, stgps1 = null,stgps2=null;
 	Statement sterp2 = null;
 	Statement sterp3=null,sterp4=null,sterp5=null,sterp6=null,sterp7=null,stchk=null, stqr=null;
 	String selectedName,fpreviousmonth="";
 	String FollowUpType = "",Group="", strcustomer = "", strgroupname = "";
 	 String strhtml="";
	 String strhtml1="";
	 String stringtowrite1;
	 String stringtowrite;
%>
<%
DecimalFormat twoDForm = new DecimalFormat("#.##");
 	String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	int i=1,ck=0;
	int vehid=0;
	int k=2000;
 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
 	try {
 			sterp = conn.createStatement();
 			sterp1 = conn.createStatement();
 			sterp2 = conn.createStatement();
 			sterp3 = conn.createStatement();
 			sterp4 = conn.createStatement();
 			sterp5 = conn.createStatement();
 			sterp6 = conn.createStatement();
 			sterp7 = conn.createStatement();
 			stchk = conn.createStatement();
 			stqr = conn.createStatement();
 		}  
 		catch (Exception e) 
 		{
 			
 		}
 	
 	try{
 	String id=request.getParameter("id");
 	String id1=request.getParameter("id1");

 	//System.out.println(">>>>>>>>id:"+id);
 	
id=id.substring(1);
id1=id1.substring(1);

String []arr=id.split(",");
System.out.println("arr length"+arr.length);

String []arr1=id1.split(",");
System.out.println("arr length"+arr1.length);





 	String year=request.getParameter("year");
 	String Month=request.getParameter("month");
	Format frt1=new SimpleDateFormat("yyyy-MM-dd");
	 
	
    //  strhtml1 = "<HTML><BODY>";
      strhtml1 = strhtml1+"<table align=center  cellpadding=0 cellspacing=0 width=85% border=1 class=mytable>";
      
	
      	//*******calculate week days************************************
		
		//******************************************* 
      
		
	      
	        String MonthName="",Year1="",FirstDayNew="",LastDayNew="";
	        int monthdays=0;
			if(Month.equals("01") || Month.equals("03") || Month.equals("05") ||Month.equals("07") || Month.equals("08") || Month.equals("10") || Month.equals("12") )
			{monthdays=31;}

			if(Month.equals("04") || Month.equals("06") || Month.equals("09") ||Month.equals("11"))
			{monthdays=30;}
			
			
			

			if(Month.equals("02"))
			{monthdays=28;}
			
	        FirstDayNew=year+"-"+Month+"-"+"01";
	        LastDayNew=year+"-"+Month+"-"+monthdays;
		      
		      String FirstDayTimeNew=FirstDayNew+" 00:00:00";
		      String LastDayTimeNew=LastDayNew+" 23:59:59";
			
			String custname="",groupname=""; 
			String FromDate="",ToDate="",DueDate="";
			Double GrandTotal=0.00;
			
			String CustomerCode="",CustomerEmail="";
			
			for(int r=0;r<arr.length;r++)
			{
				System.out.println("arr val"+arr[r]);
				System.out.println("arr val"+arr1[r]);
				
				
				System.out.println(" after Function******");

			
			
			String custcode="select distinct(CustomerCode),EMail from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+arr[r]+"'";
			System.out.println("############ custcode ########### :- "+custcode );
			ResultSet rscustcode=sterp7.executeQuery(custcode);
			if(rscustcode.next())
			{
				CustomerEmail="";
				
				CustomerCode=rscustcode.getString("CustomerCode");
				CustomerEmail=rscustcode.getString("EMail");
				String SPRefNumber = "";
			String AutoInvoice="select distinct(invoiceRefNo) as TWRef,CASE WHEN FromDate ='0000-00-00' THEN '-' ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN '-' ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN '-' ELSE DueDate END as DueDate,GrandTotal,CustomerCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where CustomerCode='"+CustomerCode+"' and invoiceRefNo='"+arr1[r]+"'   and TWEmpName='Autogenerated' and InvoiceCancelled='0' ";
			
			//String AutoInvoice="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where invoicerefno='SP190619001' limit 1 ";
			
			System.out.println("############ AutoInvoice AutoInvoice ########### :- "+AutoInvoice);
			
			ResultSet rsAutoInvoice=sterp4.executeQuery(AutoInvoice);
			
			NumberFormat formatter = new DecimalFormat("#0.00");
			
			if(rsAutoInvoice.next()) {
				
				GrandTotal=rsAutoInvoice.getDouble("GrandTotal");
				SPRefNumber = rsAutoInvoice.getString("TWRef");
				
				FromDate=rsAutoInvoice.getString("FromDate");
				if(FromDate.equals("NULL") || FromDate==null || FromDate.equals("-"))
				{
					FromDate="-";
				}else{
				FromDate = new SimpleDateFormat("dd-MMM-yyyy")
				        .format(new SimpleDateFormat("yyyy-MM-dd")
				                .parse(FromDate));
				}
				
				ToDate=rsAutoInvoice.getString("ToDate");
				
				if(ToDate.equals("NULL") || ToDate==null || ToDate.equals("-"))
				{
					ToDate="-";
				}else{
				ToDate = new SimpleDateFormat("dd-MMM-yyyy")
				        .format(new SimpleDateFormat("yyyy-MM-dd")
				                .parse(ToDate));
				}
				DueDate=rsAutoInvoice.getString("DueDate");
				
				if(DueDate.equals("NULL") || DueDate==null ||  DueDate.equals("-"))
				{
					DueDate="-";
				}else{
				DueDate = new SimpleDateFormat("dd-MMM-yyyy")
				        .format(new SimpleDateFormat("yyyy-MM-dd")
				                .parse(DueDate));
				}		
			String FvERP="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+Month+" where ERPCode='"+rsAutoInvoice.getString("CustomerCode")+"'";
			ResultSet rsFvERP=sterp3.executeQuery(FvERP);
					if(rsFvERP.next())
					{
						custname=rsFvERP.getString("ERPCustName");
						groupname=rsFvERP.getString("GroupName");
					}else{
						custname="";
						groupname="";
					}
					
        String hodMail="";
		//String tocc ="hr2@twtech.in,fleetviewreports@mobile-eye.in";
		String tocc ="accounts@twtech.in,collections@myfleetview.com,sales@myfleetview.com,sales1@myfleetview.com";
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
		
		//String jprgFilePath="/home/c_kapade/VehicleMonthlyInvoices";
		
		String jprgFilePath="";
				
				try {
					jprgFilePath = System.getenv("INVOICE_PATH");
					
					if(jprgFilePath==null) {
						jprgFilePath = "/var/www/html/GLOBALERP/VehicleMonthlyInvoices/";
					}
					
					if(jprgFilePath.equals("")) {
						jprgFilePath = "/var/www/html/GLOBALERP/VehicleMonthlyInvoices/";
					}
					
				}catch(Exception e) {
					jprgFilePath = "/var/www/html/GLOBALERP/VehicleMonthlyInvoices/";
				}
		
		
		//jprgFilePath+="/AutogeneratedInvoice"+year+"_"+Month+"";
		
		String PdfName = SPRefNumber+"_"+year+"_"+Month+".pdf";
		
		String PdfNameMonthly=jprgFilePath+SPRefNumber+"_"+year+"_"+Month+".pdf";
		
		String NameOnly=custname;
        String GNameOnly=groupname;
       
        NameOnly = NameOnly.replace("^","_");
        NameOnly = NameOnly.replace("-"," ");
        
        NameOnly = NameOnly.replace("&","and");
        NameOnly = NameOnly.replace("/",":");
        //NameOnly = NameOnly.replace(" ","\\ ");
       
        GNameOnly = GNameOnly.replace("^","_");
        GNameOnly = GNameOnly.replace("-"," ");
        
        GNameOnly = GNameOnly.replace("&","and");
        GNameOnly = GNameOnly.replace("/",":");
        //GNameOnly = GNameOnly.replace(" ","\\ ");
        
        //String PdfName=NameOnly+" - "+ i +" - "+GNameOnly+"-"+rsAutoInvoice.getString("invoiceRefNo")+".pdf";
        
        //String PdfName=rsAutoInvoice.getString("invoiceRefNo")+".pdf";
       // PdfName=PdfName.replace(" ","\\\\ ");
        
        System.out.println("**********PdfName ************* :- "+PdfName);
        
        
        //  String PdfNameMonthly=jprgFilePath+"/"+rsAutoInvoice.getString("invoiceRefNo")+".pdf";
		
        //PdfNameMonthly=PdfNameMonthly.replace(" ","\\\\ ");
        System.out.println("############ PdfNameMonthly ########### :- "+PdfNameMonthly);
        
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal1 = Calendar.getInstance();
        String DateTime = dateFormat.format(cal1.getTime());
        System.out.println(DateTime);
        String Data="";
         
        AnnexureGeneration annex = new AnnexureGeneration(SPRefNumber,Month,year,session.getAttribute("CompanyMasterID").toString());
		File savedAnnexureFile = annex.CreateAnnexureForSalesProforma();
		
		System.out.println("FileName:"+savedAnnexureFile.getName());
		System.out.println("FullPath:"+savedAnnexureFile.getAbsolutePath());
	      
		String AnnexureFileName = savedAnnexureFile.getName();
		String AnnexureFilePath = savedAnnexureFile.getAbsolutePath();
        
        Data=" "+strhtml+" <br> Dear Customer ,<br><br>Here are your FleetView Access details for the period "+FromDate+" to "+ToDate+". You need to approve and pay an amount of Rs. "+formatter.format(GrandTotal)+" on or before "+DueDate+" to ensure that your services are up and live.<br><br>"+
    				"In case you have paid by NEFT or Electronic Transfer, please reply to this email with the UTR reference number and the name of your bank and exact amount remitted. Going forward, we will be unable to accept cheque payments.<br><br>"+
    				"If you need a hard copy printed invoice,  Please send specific email to ask for this invoice in hard copy  <br><br>"+
    				"Your use, access and charges continue to be covered by the terms and conditons accepted by you whilst logging in to the portal. Should you need any clarification about this payment request or the underlying bill or charges, please reply to this email. For other queries, please feel free to write or call:<br><br><br>"+
    				" 1) L1 Register Complaints/Suggession/Request/On line at FleetView >> Register Complaint <br>"+
    				" 2) L2 Billing and Collections Collections@MyFleetView.com +918669626652 <br>"+
    				" 3) L2 Sales Sales@MyFleetView.com +918669626652 <br>"+
    				" 4) L2 Service AVLSupport@MyFleetView.com +919762007125 and +919762002631 <br>"+
    				"<br>Find out how much more revenue you could have earned in this period. Make full use of the features and facilities you get from the FleetView Portal - schedule a training session by contacting our L2 Sales directly.<br> <br>"+
    				"We are glad to have you on board enjoy the ride! <br>"+
    				"";
        
        if(FromDate.equals("-"))
        {
        	Data=" "+strhtml+" <br> Dear Customer ,<br><br>Here are your FleetView Access details for the period .You need to approve and pay an amount of Rs. "+formatter.format(GrandTotal)+" to ensure that your services are up and live.<br><br>"+
    				"In case you have paid by NEFT or Electronic Transfer, please reply to this email with the UTR reference number and the name of your bank and exact amount remitted. Going forward, we will be unable to accept cheque payments.<br><br>"+
    				"If you need a hard copy printed invoice,  Please send specific email to ask for this invoice in hard copy  <br><br>"+
    				"Your use, access and charges continue to be covered by the terms and conditons accepted by you whilst logging in to the portal. Should you need any clarification about this payment request or the underlying bill or charges, please reply to this email. For other queries, please feel free to write or call:<br><br><br>"+
    				" 1) L1 Register Complaints/Suggession/Request/On line at FleetView >> Register Complaint </b><br>"+
    				" 2) L2 Billing and Collections Collections@MyFleetView.com +918669626652 <br>"+
    				" 3) L2 Sales Sales@MyFleetView.com +918669626652 <br>"+
    				" 4) L2 Service AVLSupport@MyFleetView.com +919762007125 and +919762002631 <br>"+
    				"<br>Find out how much more revenue you could have earned in this period. Make full use of the features and facilities you get from the FleetView Portal - schedule a training session by contacting our L2 Sales directly.<br> <br>"+
    				"We are glad to have you on board enjoy the ride! <br>"+
    				"";
        }
        String body="<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;}</style><title>Mail Body</title></head><body><table border=^18^ bordercolor=^#E6E6FA^ align=^center^ width=^30%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^><table  style=^margin-left: 1em;margin-right: 1em;width: 90%;height: 100%;^><tr><td width=^100%^><a href=^http://www.mobile-eye.in^ target=^_blank^><img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^ title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a><br/><font style=^color: #D8D8D8^>___________________________________________________________________________</font><br/><br/><div>"
			+"<br><div style=^width:90%; margin-left: 5%;^><table align=^left^ border=^0^ cellpadding=^0^ cellspacing=^0^ width=^100%^ style=^background: white;^><tr><td valign=^top^><font size=^3^ face=^Arial^>"+Data+"<br></font></td></tr></table></div><br><br></div>"
			+"<div style=^width:100%; float:left;^><br>The Transworld Team,<br><br>This is a confidential communication and a demand for payment. All communications and services are covered by the online agreement and terms of use, including data use, ownership and confidentiality. The online version of the detailed agreement can be accessed here<br>"
			+"Transworld<br></div></div><font style=^color: #D8D8D8^>___________________________________________________________________________</font><br/><br/><br/></td></tr></table></td></tr></table></body></html>";
	        
	        /*	if(body.contains("^")) {
			String Data1=body.replace("^","'");
			System.out.println("the data change back"+Data1);  
			}*/
        
        	String subject = "FleetView Account Statement for the period "+FromDate+" to "+ToDate+" "+custname+" "+rsAutoInvoice.getString("TWRef")+"";
        			if(FromDate.equals("-"))
        			{
        				subject = "FleetView Account Statement Of "+custname+" "+rsAutoInvoice.getString("TWRef")+"";
        			}
        			
        	String to =CustomerEmail;
        	// to="w_tamboli@transworld-compressor.com";
        	
        	//tocc = "collections@myfleetview.com,sales@myfleetview.com";
        	
        	//String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath)values('TWSupports','Billing Template','"+body+"','"+subject+"','"+to+"','"+tocc+"','"+DateTime+"','Pending','Transworld','"+PdfNameMonthly+"','"+PdfNameMonthly+"')";
        	
        	 
        	 /* to="w_tamboli@transworld-compressor.com";
         	
         	tocc = "t_abhang@twtech.in"; */
         	
        	String q2 = "insert into db_gps.t_allpendingmailtable_multi(MailName,Description,MailBody,subjectline,Toid,tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath)values('TWSupports','Billing Template','"+body+"','"+subject+"','"+to+"','"+tocc+"','"+DateTime+"','Pending','Transworld','"+PdfName+","+AnnexureFileName+"','"+PdfNameMonthly+","+AnnexureFilePath+"')";
        	
            try {
            	sterp3.executeUpdate(q2);
			    System.out.println("q2--->"+q2);
            } catch (Exception e) {
				
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    } 
			}
			}
			
        	out.println("Yes");
        	System.out.println("the record has been successfully inserted into table");
			
 	}
 	catch(Exception e)
 	{
 		e.printStackTrace();
		out.println("NO");

 	}finally {
 		conn.close();

 	}
%>




