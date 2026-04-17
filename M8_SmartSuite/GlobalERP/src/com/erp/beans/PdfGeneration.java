package com.erp.beans;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.SimpleCell;
import com.lowagie.text.SimpleTable;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;

public class PdfGeneration extends HttpServlet{

	static Connection conn1=null;
	public	static Statement st=null;
	static Statement st1=null;
	static Statement st2=null;
	int i=0;
	String CompanyMID="";
	static Statement st3=null;
	static Statement st4=null;
	static Statement st5=null;
	public	static Statement st6=null;
	static Statement st7=null;
	static Statement st8=null;
	static Statement st9=null;
	static Statement st10=null;
	static Statement st11=null;
	static Statement st12=null;
	static Statement st13=null;
	static Statement st14=null;
	static Statement st_update=null;


	static Statement st15=null;
	static Statement st16=null;
	static Statement st17=null;
	static Statement st18=null;
	static Statement st19=null;
	static Statement st20=null;
	static Statement st21=null;
	static Statement st22=null;
	static Statement st23=null;
	static Statement st24=null;
	public static Connection con=null;
	//	public static Statement st11=null;
	static String sql="";
	static String sql1="";
	static String sql2="";
	static String sql3="";
	static String sql4="";
	static String sql5="";
	static String sql6="";
	static String sql7="";
	static String sql8="";
	static String sql9="";
	static String sql10="";
	static String sql11="";
	static String sql12="";
	static String sql13="";
	static	String filepath1="";
	String Emp_Name="";
	String test="";
	String UNE="";
	String FromDate="";
	String Todate="";
	String Duedate="";
	public PdfGeneration(String CompanyId,String test, String UN)
	{
		this.test=test;
		UNE=UN;
		Emp_Name=test;
		CompanyMID=CompanyId;
	
	}

	public PdfGeneration(String EMPNAME, String UN)
	{
		Emp_Name=EMPNAME;
		UNE=UN;
	}
	public  Connection GetConnection() { 
		try {
			
			String host1 = System.getenv("DB_GLOBALERP_HOST");
			String user1 = System.getenv("DB_GLOBALERP_USER");
			String pass1 = System.getenv("DB_GLOBALERP_PASS");
			
			String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
			String MM_dbConn_USERNAME = user1;
			String MM_dbConn_PASSWORD = pass1;

			

		//	String MM_dbConn= "jdbc:mysql://103.241.181.36/twsql_twalldata";

			String MM_dbConn= "jdbc:mysql:// "+host1+"/db_GlobalERP";



			Class.forName(MM_dbConn_DRIVER);
			conn1 = DriverManager.getConnection(MM_dbConn,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
			st =  conn1.createStatement();
			st1 =  conn1.createStatement();
			st2 =  conn1.createStatement();
			st3 =  conn1.createStatement();
			st4 =  conn1.createStatement();
			st5 =  conn1.createStatement();
			st6 =  conn1.createStatement();
			st7 =  conn1.createStatement();
			st8 =  conn1.createStatement();
			st9 =  conn1.createStatement();
			st10 =  conn1.createStatement();
			st11 =  conn1.createStatement();
			st12 =  conn1.createStatement();
			st13 =  conn1.createStatement();
			st14 =  conn1.createStatement();
			st15 =  conn1.createStatement();
			st16 =  conn1.createStatement();
			st17 =  conn1.createStatement();
			st18 =  conn1.createStatement();
			st19 =  conn1.createStatement();
			st20 =  conn1.createStatement();
			st21 =  conn1.createStatement();
			st22 =  conn1.createStatement();
			st23 =  conn1.createStatement();
			st24 =  conn1.createStatement();






			System.out.println("DONE WITH  connection.**************..");
		} catch (Exception e) {
			System.out.println("GetConnection Exception ---->" + e);
			//GetConnection();
		}
		return conn1;
	}
	public  void CloseConnection() { 		try {
			st.close();

			st1.close();
			st2.close();
			st3.close();
			st4.close(); 
			st5.close();
			st6.close();
			st7.close();
			st8.close();
			st9.close();
			st10.close();
			st11.close();
			st12.close();
			st13.close();
			st14.close();
			st15.close();
			st16.close();
			st17.close();
			st18.close();
			st19.close();
			st20.close();
			st21.close();
			st22.close();
			st23.close();
			st24.close();
			


			conn1.close();
		} catch (Exception e) {
			System.out.print("CloseConnection Exception---->" + e);
		}

	}
	
	/************************************************************ End of rupees conversion Logic**************************************************************/	
	private static final String[] lowNames = {
		   "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
		   "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};

		private static final String[] tensNames = {
		   "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};

		private static final String[] bigNames = {
		   "Thousand", "Million", "Billion"};

		/**
		* Converts an integer number into words (american english).
		* @author Christian d'Heureuse, Inventec Infoatik AG, Switzerland, www.source-code.biz
		**/
		public static String convertNumberToWords (int n) {
		   if (n < 0) {
		      return "minus " + convertNumberToWords(-n); }
		   if (n <= 999) {
		      return convert999(n); }
		   String s = null;
		   int t = 0;
		   while (n > 0) {
		      if (n % 1000 != 0) {
		         String s2 = convert999(n % 1000);
		         if (t > 0) {
		            s2 = s2 + " " + bigNames[t-1]; }
		         if (s == null) {
		            s = s2; }
		          else {
		            s = s2 + ", " + s; }}
		      n /= 1000;
		      t++; }
		   return s; }

		// Range 0 to 999.
		private static String convert999 (int n) {
		   String s1 = lowNames[n / 100] + " Hundred";
		   String s2 = convert99(n % 100);
		   if (n <= 99) {
		      return s2; }
		    else if (n % 100 == 0) {
		      return s1; }
		    else {
		      return s1 + " " + s2; }}

		// Range 0 to 99.
		private static String convert99 (int n) {
		   if (n < 20) {
		      return lowNames[n]; }
		   String s = tensNames[n / 10 - 2];
		   if (n % 10 == 0) {
		      return s; }
		   return s + "-" + lowNames[n % 10]; }
		
		/************************************************************ End of rupees conversion Logic**************************************************************/

	//createAnnexture.jsp?cust=<%=rsData.getString("CustomerCode") %>&name=<%=strcustomer %>&year=<%=year %>&month=<%=month %>&group=<%=strgroupname %>&vehiclenos=<%=rsData.getString("NoofVehicles") %>&rateperveh=<%=rsData.getString("Rate") %>&jrmcount=<%=rsData.getString("jrmvehcount") %>&billtype=<%=rsData.getString("BillType") %>&slacount=<%=rsData.getString("SLAPer") %>&billdays=<%=rsData.getString("TotalBilledDays")
	public  void PdfGenerationCall(int LASTDAYCOUNT,String customer,String custname,String year,String month,String groupname,String vehiclenos,String ratepervehicle,String jrmcountNo,String billtype,String slacount,String billdaysAll,String CID) { 
		try {

			//	PdfGeneration getConn=new PdfGeneration();

			System.out.println("Inside PdfGenerationCall");


			Connection conn = null;
		//	Statement st = null, st1 = null, st3 = null, st4 = null;
		//	Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
			Font cat = new Font();
			String tgrp="",tmake="",tmodel="";String a="",b="",c="",j="",m="",n="";

			String fromDateCal = "", toDateCal = "", sql = "";
			 FromDate="";
			 Todate="";
			 Duedate="";
			 
			String todaysTime = new SimpleDateFormat(" HH:mm:ss")
			.format(new java.util.Date());

			Date tdy = new Date();
			Date tomorrow = new Date();
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.setTime(tdy);

			cal.setTime(tdy);
			Date tendays=new Date();
			cal.add(Calendar.DAY_OF_MONTH, +10);
			tendays=cal.getTime();
			String tendaysformat1=new SimpleDateFormat("yyyy-MM-dd").format(tendays);
			String tendaysInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(tendays);

			String todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
			.format(tdy);
			cal.add(Calendar.DAY_OF_MONTH, -1);
			Date YesterdaysDateAsDate = cal.getTime();
			String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
			.format(YesterdaysDateAsDate);

			fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new java.util.Date());
			NumberFormat nf1=NumberFormat.getInstance();
			nf1.setMaximumFractionDigits(2);
			nf1.setMinimumFractionDigits(2);
			DecimalFormat nf=new DecimalFormat("#.##");

			DecimalFormat nfNew=new DecimalFormat("#.##");
		
		//	System.out.println("Customername before conversion"+custname);
			custname = custname.replace("^","&");
		//	System.out.println("Customername after conversion"+custname);
			
		//	System.out.println(year);
			
		//	System.out.println(month);
			
		//	System.out.println("groupname before conversion is"+groupname);
			groupname = groupname.replace("^","&");
		//	System.out.println("groupname after conversion is"+groupname);
			
		//	System.out.println(vehiclenos);
			
			System.out.println("All Vehicle No  =======>"+vehiclenos);
			
			
			Double flratepervehicle = Double.parseDouble(ratepervehicle);
			
			String billvehcount="Select count(distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno)) as vehcount from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode ='"+customer+"'   and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and TotalDays > 0  and TotalDays ='"+LASTDAYCOUNT+"'";
			ResultSet rsbillveh=st.executeQuery(billvehcount);
			
			if(rsbillveh.next())
			{
				vehiclenos=rsbillveh.getString("vehcount");
			}
			
			System.out.println("Vehicle No For Full Days =======>"+vehiclenos);
			//		int jrmcount=0;

			int jrmcount= 0 ;
			
			try {
				jrmcount =   Integer.parseInt(jrmcountNo);
			}catch(Exception e) {
				jrmcount = (int)Double.parseDouble(jrmcountNo);
			}
				
				
			//		System.out.println(request.getParameter("jrmcount"));
			/*	if(jrmcount==null)// || rmcount.equals("null"))
				 	{
				 	jrmcount="0";
				 	}
				 	else 

				jrmcount=Integer.parseInt(jrmcount);

			 */
			System.out.println("jrm count =========> "+jrmcount); 	
			//String billtype=request.getParameter("billtype");
			int salcount=Integer.parseInt(slacount);
			int billdays=Integer.parseInt(billdaysAll);
			String lastdayofmonth="";

			if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") || month.equals("12"))
			{
				lastdayofmonth=year+"-"+month+"-"+LASTDAYCOUNT;	
			}

			if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
			{
				lastdayofmonth=year+"-"+month+"-"+LASTDAYCOUNT;
			}

			if(month.equals("02"))
			{
				lastdayofmonth=year+"-"+month+"-"+LASTDAYCOUNT;
			}

			System.out.println(custname+""+customer+""+year+""+month+""+groupname+""+vehiclenos+""+ratepervehicle+" "+flratepervehicle);
		
			/*  ****************************************** logic for invoice no  ******************************************  */

			Document document = new Document();
			
			try{
				
				ByteArrayOutputStream buffer = new ByteArrayOutputStream();
				
				
				int SINumber;


				String sqldate="select DATEDIFF('"+lastdayofmonth+"','"+year+"-"+month+"-01')";
				ResultSet rsDate=st1.executeQuery(sqldate);
				//System.out.println(sqldate);
				rsDate.next();
				int daysinmonth=rsDate.getInt(1);
				
				//daysinmonth=LASTDAYCOUNT;
				
				daysinmonth=daysinmonth+1;
				
				System.out.println("DAys in MONTH ARE  "+daysinmonth);
				
				
				int SIProNumber;
				String SIProNo="select MAX(InvoiceNo) from "+CID+"performainvoicedet ";
				ResultSet rsPro=st1.executeQuery(SIProNo);
				System.out.println(SIProNo);
				rsPro.next();
					SIProNumber=rsPro.getInt(1);
				SIProNumber++;	
				System.out.println("NONONON   MNOPNPOMKJKK   N "+SIProNumber);
				
				String SPRefNumber="";
				java.text.DecimalFormat df = new java.text.DecimalFormat("000");

					try{
						
						Date today = new Date();
						 
						SPRefNumber="SP";

						String date =  new SimpleDateFormat("ddMMyy").format(new Date());

						String sql4="SELECT invoiceRefNo  from "+CID+"performainvoicedet  where invoiceRefNo like ('"+SPRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
						    ResultSet rs=st3.executeQuery(sql4);
						    System.out.println(sql4);
						  if(rs.next())
							  SPRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
						  else
							  SPRefNumber+=date+"001";
						  
					}catch(Exception e){
					e.printStackTrace();		
					}


				String SIRefNumber="";
				// java.text.DecimalFormat df = new java.text.DecimalFormat("000");
				

				/*try{

					Date today = new Date();

					SIRefNumber="SI";

					String date =  new SimpleDateFormat("ddMMyy").format(new Date());

					String sql3="SELECT invoiceRefNo  from "+CID+"invoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
					ResultSet rs=st2.executeQuery(sql3);
					// System.out.println(sql3);     
					if(rs.next())
						SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
					else
						SIRefNumber+=date+"001";

				}catch(Exception e){
					e.printStackTrace();		
				}
*/				
				System.getProperty("user.home");
				File file = new File(".");
				System.out.println("CURRENT FILE PATH=============>"+file.getCanonicalPath());
				
				File currentDirectory = new File(new File("").getAbsolutePath());
				String FilePath=currentDirectory.getAbsolutePath();
				
				
				
				
				System.out.println("Path============================================================================>"+FilePath);
				
				
				//String jprgFilePath="/home/javaprg/VehicleMonthlyInvoices/";
				//String jprgFilePath="/home/chetan/VehicleMonthlyInvoices";
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
				
				//jprgFilePath+="/AutogeneratedInvoice"+year+"_"+month+"";
				
				System.out.println("Path==============================Current Machine==============================================RRR>"+FilePath);
				System.out.println("Path=================================Javaprg Path===========================================>"+jprgFilePath);
				File dir = new File(jprgFilePath);
		       // dir.mkdir();
		        
		        if (!dir.exists()) {
		    		if (dir.mkdir()) {
		    			System.out.println("Directory is created!");
		    		} else {
		    			System.out.println("Failed to create directory!");
		    		}
		    	}
		        
		        String NameOnly=custname;
		        String GNameOnly=groupname;
		        NameOnly = NameOnly.replace("^","_");
		        NameOnly = NameOnly.replace("-"," ");
		        
		        NameOnly = NameOnly.replace("&","and");
		        NameOnly = NameOnly.replace("/",":");
		        GNameOnly = GNameOnly.replace("^","_");
		        GNameOnly = GNameOnly.replace("-"," ");
		        
		        GNameOnly = GNameOnly.replace("&","and");
		        GNameOnly = GNameOnly.replace("/",":");
		        
		        //String PdfNameMonthly=jprgFilePath+"/"+NameOnly+" - "+ i +" - "+GNameOnly+"-"+SIRefNumber+".pdf";
		        
		        //String PdfNameMonthly=jprgFilePath+"/"+NameOnly+" - "+ i +" - "+GNameOnly+"-"+SPRefNumber+".pdf";
		        
		        String PdfNameMonthly=jprgFilePath+SPRefNumber+"_"+year+"_"+month+".pdf";
		        
		        //SPRefNumber
				i++;
				//String PdfName=jprgFilePath+"/"+custname+"-"+SIRefNumber+".pdf";
				
				
				//String PdfName=jprgFilePath+"/"+custname+"-"+SPRefNumber+".pdf";
				
				//String PdfName=jprgFilePath+"/"+SPRefNumber+"_"+year+"_"+month+".pdf";
				
				PdfWriter writer=PdfWriter.getInstance(document,new FileOutputStream(PdfNameMonthly));
				
				
				//System.out.println("PDF Name=====================WITH PATH=======================================================>"+PdfName);
				
				System.out.println("PDF Name=================Rk ====WITH PATH=======================================================>"+PdfNameMonthly);
				
				
				
				
				document.setPageSize(PageSize.A4);
				document.setMargins(20,20,10,10);
				document.setMarginMirroring(false);

				Font catFont = new Font(Font.TIMES_ROMAN,10,Font.BOLD);
				Font headerFont = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
				Font NormalFont = new Font(Font.TIMES_ROMAN,8,Font.NORMAL);
				Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
				Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
				Font Fontfortable = new Font(Font.TIMES_ROMAN,7,Font.BOLD);
				Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
				Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
				Font smallfont2 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
				Font InvAmtFont= new Font(Font.TIMES_ROMAN,8,Font.BOLD,new Color(13,0,255));


				document.open();

				double invcamount=0;

				
				
				
			

	/*       ******************************************        end of invoice ref no. logic   **************************************************    */


	/*       ******************************************          start of logic for opening balance  ********************************************  */
				String sqlupdate="";
				String sqlBalance="SELECT * FROM  "+CID+"customerledgeraccount where CustomerCode="+customer+" order by TransactionId  DESC limit 1" ;

				ResultSet rsbalance=st1.executeQuery(sqlBalance);
				System.out.println("sql"+sqlBalance);
				double balance = 0;
				double debitamount=0;
				double creditamount=0;
				double transactionid=0;
				if(rsbalance.next())
				{
					transactionid=rsbalance.getDouble("transactionid");
					debitamount=rsbalance.getDouble("debitamount");
					creditamount=rsbalance.getDouble("creditamount");
					balance=rsbalance.getDouble("Balance");

					//balance = balance + debitamount-creditamount;
					//System.out.println(balance);

					
				//	sqlupdate = "UPDATE "+CID+"customerledgeraccount set balance="+balance+" where transactionid="+transactionid;
						//	st2.executeUpdate(sqlupdate);
				}
				else{
					balance=0.00;	
				}



  /*   ***************************************           end of opening balance logic  ***************************************************************  */
				
				
  /*   ***************************************          Pdf for adding Header  ***********************************************************************  */
				
				String companydata="select * from CompanyMaster where companymid="+CID;
				ResultSet rsdata123=st.executeQuery(companydata);
				rsdata123.next();
				
				String companyname=rsdata123.getString("Companyname");
				String address123=rsdata123.getString("address");
				String phone123=rsdata123.getString("phone");
				String mail=rsdata123.getString("emailid");
				String website=rsdata123.getString("website");
				String fax=rsdata123.getString("fax");
				String godownaddress=rsdata123.getString("godownaddress");  
				String GSTINNO=rsdata123.getString("GSTINNO");
				String PANNo=rsdata123.getString("PANNo");
				String BillingState=rsdata123.getString("State");
				
				Paragraph preface = new Paragraph();
				preface.add(new Paragraph(companyname,catFont));
				preface.setAlignment("center");
				preface.add(new Paragraph(address123,NormalFont));
				preface.setAlignment("center");
				preface.add(new Paragraph("Tel: "+phone123+"  Fax: "+fax+"  "+mail+"  "+website+"",NormalFont));
				preface.setAlignment("center");
			
				
				document.add(preface);


				SimpleTable table3211 = new SimpleTable();
				table3211.setWidthpercentage(100f);
				table3211.setBorder(Rectangle.NO_BORDER);
				SimpleCell row1 = new SimpleCell(SimpleCell.ROW);
				SimpleCell cellforname1 = new SimpleCell(SimpleCell.CELL);
				SimpleCell cellforname2 = new SimpleCell(SimpleCell.CELL);

				cellforname1 = new SimpleCell(SimpleCell.CELL);
				cellforname2 = new SimpleCell(SimpleCell.CELL);

				Paragraph Subject12 = new Paragraph();
				Subject12.add(new Paragraph("PROFORMA INVOICE : "+SPRefNumber+" ",catFont));
				Subject12.setAlignment("Left");


				cellforname1.add(Subject12);

				Paragraph Subject21 = new Paragraph();
				Subject21.add(new Paragraph("Date : "+todaysDate+" ",catFont));
				Subject21.setAlignment("Right");

				cellforname2.add(Subject21);
				
				

				cellforname1.setWidth(30f);
				cellforname1.setWidthpercentage(50f);
				cellforname1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				row1.add(cellforname1);
				row1.add(cellforname2);
				table3211.addElement(row1);
				document.add(table3211); 

				

				Paragraph NF1 = new Paragraph();
				NF1.add(new Paragraph("",NF));
				NF1.setAlignment("Right");
				document.add(NF1);			
				
				String address="",country="",zip="",contactperson="",phone="",State="",AddressCode="",BillingCity="";
				String address1="",country2="",zip2="",contactperson3="",phone4="",State5="",AddressCode6="",BillingCity7="";
				String sqldata="select * from "+CID+"custaddrdet where CustomerCode='"+customer+"'";
				ResultSet rsdata=st12.executeQuery(sqldata);
				System.out.println(sqldata);
				if(rsdata.next())
				{
					
					AddressCode=rsdata.getString("AddressCode");
					if(AddressCode.equals("null") || AddressCode==null || AddressCode=="")
					{
						AddressCode=" ";
					}
					
				}
				else
				{
				}
				
				String gstin="select * from "+CID+"customerdet where CustomerCode='"+customer+"' ";
				ResultSet rsgstin=st20.executeQuery(gstin);
				String billgst="";
				String shipgst="";
				if(rsgstin.next())
				{
					billgst=rsgstin.getString("BillingGSTN");
					shipgst=rsgstin.getString("ShippingGSTN");
					address=rsgstin.getString("BillingAddress");
					if(address.equals("null") || address==null || address=="")
					{
						address=" ";
					}
					country=rsgstin.getString("BillingCountry");
					if(country.equals("null") || country==null || country=="")
					{
						country=" ";
					}
					zip=rsgstin.getString("BillingZip");
					if(zip.equals("null") || zip==null || zip=="")
					{
						zip=" ";
					}
					
					contactperson=rsgstin.getString("ContactPerson");
					if(contactperson.equals("null") || contactperson==null || contactperson=="")
					{
						contactperson=" ";
					}
					
					phone=rsgstin.getString("BillingPhone");
					
					if(phone.equals("null") || phone==null || phone=="")
					{
						phone=" ";
					}
					
					State=rsgstin.getString("BillingState");
					
					if(State.equals("null") || State==null || State=="")
					{
						State=" ";
					}
					
					BillingCity=rsgstin.getString("BillingCity");
					if(BillingCity.equals("null") || BillingCity==null || BillingCity=="")
					{
						BillingCity=" ";
					}
					address1=rsgstin.getString("ShippingAddress");
					if(address1.equals("null") || address1==null || address1=="")
					{
						address1=" ";
					}
					country2=rsgstin.getString("ShippingCountry");
					if(country2.equals("null") || country2==null || country2=="")
					{
						country2=" ";
					}
					zip2=rsgstin.getString("ShippingZip");
					if(zip2.equals("null") || zip2==null || zip2=="")
					{
						zip2=" ";
					}
					contactperson3=rsgstin.getString("ContactPerson");
					if(contactperson3.equals("null") || contactperson3==null || contactperson3=="")
					{
						contactperson3=" ";
					}
					phone4=rsgstin.getString("ShippingPhone");
					if(phone4.equals("null") || phone4==null || phone4=="")
					{
						phone4=" ";
					}
					State5=rsgstin.getString("ShippingState");
					if(State5.equals("null") || State5==null || State5=="")
					{
						State5=" ";
					}
					
					
					BillingCity7=rsgstin.getString("ShippingCity");
					if(BillingCity7.equals("null") || BillingCity7==null || BillingCity7=="")
					{
						BillingCity7=" ";
					}
					
				}
				if(billgst.equals("-"))
				{
					billgst="Unregistered / Not Available";
				}
				if(shipgst.equals("-"))
				{
					shipgst="Unregistered / Not Available";
				}
				PdfPTable tableFirst = new PdfPTable(2);

				tableFirst.setWidthPercentage(100);
				tableFirst.getDefaultCell().setBorder(Rectangle.BOX);
				tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);


				PdfPCell firstcell = new PdfPCell();
				firstcell.addElement(new Paragraph("Billing Address " ,catFont));
				firstcell.addElement(new Paragraph(""+custname+" " ,smallfont2));
				firstcell.addElement(new Paragraph(""+address+" " ,NormalFont));
				firstcell.addElement(new Paragraph(BillingCity+" "+country+" " + zip +"",NormalFont));
				firstcell.addElement(new Paragraph(""+phone+"  "+contactperson+"",NormalFont));
				firstcell.addElement(new Paragraph("Billing GSTIN : "+billgst+" ",NormalFont));
				firstcell.addElement(new Paragraph("Billing State : "+State+" ",NormalFont));
				tableFirst.addCell(firstcell);

				PdfPCell firstcell1 = new PdfPCell();
				firstcell1.setFixedHeight(110f);
				firstcell1.addElement(new Paragraph("Shipping Address " ,catFont));
				firstcell1.addElement(new Paragraph(""+custname+"",smallfont2 ));
				firstcell1.addElement(new Paragraph(""+address1+"",NormalFont ));
				firstcell1.addElement(new Paragraph(BillingCity7+" "+country2+" "+zip2+"" ,NormalFont));
				firstcell1.addElement(new Paragraph(""+phone4+"  "+contactperson3+"" ,NormalFont));
				firstcell1.addElement(new Paragraph("Shiping GSTIN : "+shipgst+" ",NormalFont));
				firstcell1.addElement(new Paragraph("Shipping State : "+State5+" ",NormalFont));
				tableFirst.addCell(firstcell1);
				document.add(tableFirst);				
				Paragraph NF12 = new Paragraph();
				NF12.add(new Paragraph("",NF));
				NF12.setAlignment("Right");
				document.add(NF12);
				
				//String dynamicitem="select * from "+CID+"searchitems where TaxCode='440153'";
				
				String dynamicitem="select ItemCode,SACCode,HSNCode,Description,ServiceCategory  from db_GlobalERP."+CID+"searchitems where description='Monthly Data Access Charges - Mobile Eye Standard' and ItemCode=2963";
				
				ResultSet rsdynamicitem=st21.executeQuery(dynamicitem);
				
				String desc="";
				double rate=0.00;
				String TaxCategory="";
				String TaxCode="";
				String itemcode="";
				if(rsdynamicitem.next())
				{
					TaxCode=rsdynamicitem.getString("SACCode");
					TaxCategory=rsdynamicitem.getString("ServiceCategory");
				//	rate=rsdynamicitem.getDouble("TaxRate");
					desc=rsdynamicitem.getString("Description");
					itemcode=rsdynamicitem.getString("ItemCode");
					//desc="Monthly Subscription Charge - Mobile Eye Standard";
				}
				
String dynamictaxrate="select * from db_GlobalERP."+CID+"GSTINRateMaster where Code='"+TaxCode+"' and Category='"+TaxCategory+"' ";
				
				ResultSet rsdynamictaxrate=st22.executeQuery(dynamictaxrate);
				if(rsdynamictaxrate.next())
				{
					rate=rsdynamictaxrate.getDouble("TaxRate");
				}
				
				/*   ************************************* LOGIC TO CALCULATE INVOICE BALANACE  ********************************************** */

				
				
				double grandtotalnew=Integer.parseInt(vehiclenos) * flratepervehicle;
				double BillAmtnew1 =  0;
				BillAmtnew1 =Integer.parseInt(vehiclenos)*flratepervehicle;
				
				/*if(jrmcount>0)
				{
					BillAmtnew1 = BillAmtnew1 + (jrmcount * 100);
					grandtotalnew=grandtotalnew+ (jrmcount * 100);
					
				}*/

				
				String Sqldata11 ="";
				double CapTot1 = 0, OffTot1 = 0,ToTDays1 = 0;
				double diff1=0,Rate11=0;
				if(billtype=="Combined" || billtype.equals("Combined"))
				{
					Sqldata11 = "Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+CID+"billingdetails"+year+"_"+month+"  ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and TotalDays='"+LASTDAYCOUNT+"'";
				}
				else 
				{
					Sqldata11="Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays,jrm from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+" where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and  "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+CID+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and TotalYes+TotalYesStar >=(TotalDays/100)*("+salcount+") and month1='"+year+"-"+month+"-01' and TotalDays='"+LASTDAYCOUNT+"' "; 
				}	

				ResultSet rsSql11=st1.executeQuery(Sqldata11);
				System.out.println(Sqldata11);	
				while(rsSql11.next())
				{
					CapTot1 = CapTot1 + rsSql11.getDouble("CapturedDays");
					OffTot1 = OffTot1 + rsSql11.getDouble("TotalYesStar");
					ToTDays1 = ToTDays1 + rsSql11.getDouble("totalDays");
				}

				System.out.println(CapTot1 +"  "+OffTot1+"====>  "+ToTDays1);
				System.out.println("value  "+(billdays)*(Integer.parseInt(vehiclenos)));
				if((ToTDays1!=(billdays)*(Integer.parseInt(vehiclenos))) && billdays!=0 )
				{
					System.out.println("IN IFF ");
					diff1=(billdays*Integer.parseInt(vehiclenos)) - ToTDays1;
			//		System.out.println(" EXCEPTIotototototottoootototo "+flratepervehicle+"boooooooo"+billdays);
					Rate11 = flratepervehicle / billdays;
					System.out.println(diff1+" diff and rate "+Rate11);
					
				//	System.out.println("AFTERRRRRRRRR EXCEPTIotototototottoootototo ");
				}
				
			//	System.out.println("AFTERRRRRRRRR EXCEPTIotototototottoootototo  without IF LOOP*&*&*&*&*&*&*");

				
				if(billtype=="Combined" || billtype.equals("Combined"))
				{
					BillAmtnew1 = BillAmtnew1 - (diff1*Rate11);
					grandtotalnew=grandtotalnew+(diff1*Rate11);
					System.out.println("bill at adjustment  "+BillAmtnew1);

				}
				
				System.out.println("VALUE OF ======>salcount#$#$#$#$#$#$#$$##$#"+salcount);

				double shortfalldays1=0;
				if(salcount != 0)
				{

					if (CapTot1 + OffTot1 >= ToTDays1 * salcount / 100)
					{
						shortfalldays1 = 0;
					}
					else
					{
						shortfalldays1 = (ToTDays1 * salcount / 100) - (CapTot1 + OffTot1);
					}

					if((shortfalldays1 > 0) && billdays!=0)
					{

						Rate11 = Integer.parseInt(vehiclenos)/billdays;
					}

					BillAmtnew1 = BillAmtnew1 - (shortfalldays1 * Rate11);
					grandtotalnew=grandtotalnew+(shortfalldays1*Rate11);
					System.out.println("Bill amount at volun SLA  "+BillAmtnew1);
				}

				String sqltax1="select * from "+CID+"fv_erp_relation"+year+"_"+month+" where GroupName='"+groupname+"'";
				ResultSet rstax1=st3.executeQuery(sqltax1);
				System.out.println(sqltax1);
				rstax1.next();
				int servicetax1=rstax1.getInt("ST");
				int servicecharge1=rstax1.getInt("SC");

				double InvAmtnew1 = BillAmtnew1;
				System.out.println("INVOICE AMOUNT AT START  "+InvAmtnew1);
				if(servicetax1 > 0)

				{


					InvAmtnew1 = InvAmtnew1 + (BillAmtnew1 * rate / 100);

					grandtotalnew=grandtotalnew+ BillAmtnew1*rate/100;


					InvAmtnew1 = InvAmtnew1+ ((BillAmtnew1 * rate / 100) * 2 / 100);
					grandtotalnew=grandtotalnew+((BillAmtnew1*rate)/100 * 0.2);
				


					InvAmtnew1 = InvAmtnew1 + ((BillAmtnew1 * rate / 100) * 1 / 100);
					grandtotalnew=grandtotalnew+((BillAmtnew1*rate)/100 * 0.1);

				

				}



				if(servicecharge1 > 0)
				{


					InvAmtnew1 = InvAmtnew1 + BillAmtnew1 * rate / 100;
					grandtotalnew=grandtotalnew+(BillAmtnew1 * rate / 100);



				}
				
				

				/* ********************************************* END LOGIC TO CALCULATE INVOICE BALANACE  ************************************************* */

				PdfContentByte canvas1 = writer.getDirectContent();
				Rectangle rect1 = new Rectangle(10, 10, 583, 830);
				rect1.setBorder(Rectangle.BOX);
				rect1.setBorderWidth(1);
				canvas1.rectangle(rect1);

				PdfPTable tableNew = new PdfPTable(6);
				tableNew.setWidthPercentage(100);
				PdfPCell cNew = new PdfPCell(new Phrase("Opening Balance",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("Credits",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("Charges",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("This Invoice",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("Amount Due",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("Due Date",headerFont));
				cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase(""+nf1.format( balance)+"",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("0.00",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase("0.00",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tableNew.addCell(cNew);
				
				//************************************************
				
				double grandtotal123=0;
				grandtotal123=(Integer.parseInt(vehiclenos) * flratepervehicle);
				double BillAmtnew123 =  0;
				BillAmtnew123 =Integer.parseInt(vehiclenos)*flratepervehicle;
				System.out.println("BILL AMONUT 111  "+BillAmtnew123);


				/*if(jrmcount>0)
				{


					BillAmtnew123 = BillAmtnew123 + (jrmcount * 100);
					grandtotal123=grandtotal123+ (jrmcount * 100);
					System.out.println("BIll amount at jrm  "+BillAmtnew1);

				}
*/
				String Sqldata1123 ="";
				double CapTot123 = 0, OffTot123 = 0,ToTDays123 = 0;
				double diff123=0,Rate1123=0;
				
				if(billtype=="Combined" || billtype.equals("Combined"))
				{
					Sqldata1123 = "Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+CID+"billingdetails"+year+"_"+month+"  ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and TotalDays='"+LASTDAYCOUNT+"' ";
				}
				else 
				{
					Sqldata1123="Select distinct("+CID+"billingdetails"+year+"_"+month+" .VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays,jrm from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+" where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and  "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+CID+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and TotalYes+TotalYesStar >=(TotalDays/100)*("+salcount+") and month1='"+year+"-"+month+"-01' and TotalDays='"+LASTDAYCOUNT+"' "; 
				}	 
				

				ResultSet rsSql1123=st1.executeQuery(Sqldata1123);
				System.out.println(Sqldata1123);	
				while(rsSql1123.next())
				{
					CapTot123 = CapTot123 + rsSql1123.getDouble("CapturedDays");
					OffTot123 = OffTot123 + rsSql1123.getDouble("TotalYesStar");
					ToTDays123 = ToTDays123 + rsSql1123.getDouble("totalDays");
				}

				System.out.println(CapTot123 +"  "+OffTot123+"  "+ToTDays123);
				
				System.out.println("value  "+(billdays)*(Integer.parseInt(vehiclenos)));
				if((ToTDays123!=(billdays)*(Integer.parseInt(vehiclenos))) && billdays !=0)
				{
					System.out.println("IN IFF ");
					diff123=(billdays*Integer.parseInt(vehiclenos)) - ToTDays123;
					Rate1123 = flratepervehicle / billdays;
					System.out.println(diff123+" diff and rate "+Rate1123);
				}
				double diffAMT123=0;
				System.out.println("Bill Type   :- "+billtype);
				
				if(billtype=="Combined" || billtype.equals("Combined"))
				{/*

					double perdaycharge123=0, totaldays123=0, SLA123=75;
					int diffDays123=0;
					
					System.out.println("*********Rate for vehicles ="+flratepervehicle);
					System.out.println("*********Total Vehicles ="+vehiclenos);
					System.out.println("*********Total Working Days="+ToTDays123);
					
					int totaldaysin=daysinmonth * Integer.parseInt(vehiclenos);
					System.out.println("************Total Actual Days="+totaldaysin);
					
					perdaycharge123=Double.parseDouble(nf.format(flratepervehicle/daysinmonth));

					System.out.print("Per Day Charge"+ perdaycharge123);
					
					if(totaldaysin > ToTDays123)
					{
						diffDays123=new Double(totaldaysin- ToTDays123).intValue();
						diffAMT123=perdaycharge123*diffDays123;
					}
					else
					{
						diffDays123=0;
					}
					

					grandtotal123=grandtotal123-diffAMT123;
				*/}
				
				System.out.println("Total Invoice Bill Amount  :- "+grandtotal123);

								double shortfalldays123=0;
				
				System.out.println("SLA Value :- "+salcount);
				
				if(salcount != 0)
				{
					
					double perdaycharge123=0, totaldays123=0, SLA123=75;
					int diffDays123=0;
					
					int totaldaysin=daysinmonth * Integer.parseInt(vehiclenos);
					System.out.println("************Total Actual Days="+totaldaysin);
					
					perdaycharge123=Double.parseDouble(nf.format(flratepervehicle/daysinmonth));

					System.out.print("Per Day Charge"+ perdaycharge123);
					
					System.out.println("Total Days In :- "+totaldaysin);
					System.out.println("ToTDays123 :- "+ToTDays123);
					
					double sladays=totaldaysin * salcount/100;
					
					System.out.println("sladays :- "+sladays);
					System.out.println("CapTot123 :- "+CapTot123);
					System.out.println("OffTot123 :- "+OffTot123);
					
					double totcapturedday=CapTot123+OffTot123;
					
					if(totcapturedday > sladays )
					{
						
						diffDays123=0;
					}
					else
					{
						diffDays123=new Double(sladays- totcapturedday).intValue();
						diffAMT123=perdaycharge123*diffDays123;
						
					}
					
					BillAmtnew123=grandtotal123;
					
					System.out.println("Diff :- "+diffAMT123);
					
					grandtotal123=grandtotal123-diffAMT123;
					



					/*if (CapTot123 + OffTot123 >= ToTDays123 * salcount / 100)
					{
						shortfalldays123 = 0;
					}
					else
					{
						shortfalldays123 = (ToTDays123 * salcount / 100) - (CapTot123 + OffTot123);
					}
*/
					/*if((shortfalldays123 > 0) && billdays!=0)
					{

						Rate1123 = Integer.parseInt(vehiclenos)/billdays;
					}*/

					
					/*double shortfallCalcdays123=0.0;
					
					if( CapTot123 + OffTot123 >= ToTDays123 * salcount / 100)
						shortfallCalcdays123 = 0;
					else
						shortfallCalcdays123 = (ToTDays123 * salcount / 100) - (CapTot123 + OffTot123);*/
					
					
					
					/*double short_fallslaNEW=Double.parseDouble(nf.format(flratepervehicle/daysinmonth))*shortfallCalcdays123;
					
					
					if(shortfallCalcdays123 !=0)
					{
					
					BillAmtnew123 = BillAmtnew123 - (short_fallslaNEW);
					grandtotal123=grandtotal123-(short_fallslaNEW);
				}*/
					//System.out.println("Short Fall :- "+short_fallslaNEW);
				}
					

				String sqltax123="select * from "+CID+"fv_erp_relation"+year+"_"+month+" where GroupName='"+groupname+"'";
				ResultSet rstax123=st3.executeQuery(sqltax123);
				System.out.println(sqltax123);
				rstax123.next();
				int servicetax123=rstax123.getInt("ST");
				int servicecharge123=rstax123.getInt("SC");

				double InvAmtnew123 = BillAmtnew123;
				
				/*if(servicetax123 > 0)
				{


					double stval=(grandtotal123*rate)/100;

					InvAmtnew123 = InvAmtnew123 + (grandtotal123 * rate / 100);
					grandtotal123=grandtotal123+ stval;
					
					double eduCess=(stval*0)/100;




					InvAmtnew123 = InvAmtnew123 + ((grandtotal123 * rate / 100) * 2 / 100);
					
					grandtotal123=grandtotal123+eduCess;


					double HighEduCess123=(stval*0)/100;
					InvAmtnew123 = InvAmtnew123 + ((BillAmtnew123 * rate / 100) * 1 / 100);
					grandtotal123=grandtotal123+HighEduCess123;
			}

				System.out.println("servicecharge123  :- "+servicecharge123);

				if(servicecharge123 > 0)
				{
					InvAmtnew123 = InvAmtnew123 + BillAmtnew123 * rate / 100;
					grandtotal123=grandtotal123+(grandtotal123 * rate / 100);
				}
*/
				grandtotal123 =	Math.round(grandtotal123);
				
				System.out.println("Total Invoice Bill Amount  :- "+grandtotal123);
				
				double CGSTRate=0.00;
				double CGSTValue=0.00;
				double SGSTRate=0.00;
				double SGSTValue=0.00;
				double IGSTRate=0.00;
				double IGSTValue=0.00;
				double GST=0.00;
				
				if(State5.equals(" "))
				{
					if(BillingState.equals(State))
					{
						 CGSTRate=rate/2;
						 
						 SGSTRate=rate/2;
						 
						 IGSTRate=0.00;

						CGSTValue=(grandtotal123 * CGSTRate / 100);
						 
						
						
						
						SGSTValue=(grandtotal123 * SGSTRate / 100);

						


						IGSTValue=(grandtotal123 * IGSTRate / 100);
						
						System.out.println("Total CGST :- "+CGSTValue);
						System.out.println("Total IGST :- "+SGSTValue);
						System.out.println("Total SGST :- "+IGSTValue);
						
						
						GST=CGSTValue+SGSTValue+IGSTValue;

						System.out.println("Total GST :- "+GST);
						
						
						
					  
					  
					  
							 
								
							
					}
					else
					{
						 
						 IGSTRate=rate;
						
						
						
						
						
						
						CGSTValue=(grandtotal123 * CGSTRate / 100);
						
						
						SGSTValue=(grandtotal123 * SGSTRate / 100);




						IGSTValue=(grandtotal123 * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						System.out.println("Total CGST :- "+CGSTValue);
						System.out.println("Total IGST :- "+SGSTValue);
						System.out.println("Total SGST :- "+IGSTValue);
						System.out.println("Total GST :- "+GST);
						
						
						
						
						
					}
					
				}
				else
				{
					if(BillingState.equals(State5))
					{
						 CGSTRate=rate/2;
						 
						 SGSTRate=rate/2;
						 
						 IGSTRate=0.00;
						 
						
						
						
						CGSTValue=(grandtotal123 * CGSTRate / 100);
						
						
						
						SGSTValue=(grandtotal123 * SGSTRate / 100);




						IGSTValue=(grandtotal123 * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						
						System.out.println("Total CGST :- "+CGSTValue);
						System.out.println("Total IGST :- "+SGSTValue);
						System.out.println("Total SGST :- "+IGSTValue);
						System.out.println("Total GST :- "+GST);
						
						
						

							 
							 
								
							
					}
					else
					{
						 
						 IGSTRate=rate;
						
						
						
						
						
						
						CGSTValue=(grandtotal123 * CGSTRate / 100);
						

						SGSTValue=(grandtotal123 * SGSTRate / 100);




						IGSTValue=(grandtotal123 * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						
						System.out.println("Total CGST :- "+CGSTValue);
						System.out.println("Total IGST :- "+SGSTValue);
						System.out.println("Total SGST :- "+IGSTValue);
						
						System.out.println("Total GST :- "+GST);
						
						
						
						
						
					}
					
				}
				
				System.out.println("Total GST  :- "+GST);
				
				grandtotal123=grandtotal123+GST;
				
				System.out.println("Total Invoice Bill Amount  :- "+grandtotal123);
				System.out.println("Total Balance  :- "+balance);
				
				
				double dueamt=balance+grandtotal123;
				
				System.out.println("Total Due Amount  :- "+dueamt);
				
				//************************************************
				
				
				

				cNew = new PdfPCell(new Phrase(""+nf1.format(grandtotal123)+"",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase(""+nf1.format((balance+grandtotal123))+"",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tableNew.addCell(cNew);

				cNew = new PdfPCell(new Phrase(""+tendaysInMMM+"",NormalFont));
				cNew.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableNew.addCell(cNew);

				document.add(tableNew);
				Paragraph NF13 = new Paragraph();
				NF13.add(new Paragraph("",NF));
				NF13.setAlignment("Right");
				document.add(NF13);	
				
				Paragraph title = new Paragraph();
				title.add(new Paragraph("Last 3 Transactions",catFont));
				title.setAlignment("LEFT");
				document.add(title);
				
				Paragraph NF14 = new Paragraph();
				NF14.add(new Paragraph("",NF));
				NF14.setAlignment("Right");
				document.add(NF14);	
				
				PdfPTable table = new PdfPTable(6);
				table.setWidthPercentage(100);
				PdfPCell c1 = new PdfPCell(new Phrase("Tr.Date",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);

				c1 = new PdfPCell(new Phrase("Tr.Details",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);

				c1 = new PdfPCell(new Phrase("Tr.Type",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);

				c1 = new PdfPCell(new Phrase("Cr.",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);


				c1 = new PdfPCell(new Phrase("Db.",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);

				c1 = new PdfPCell(new Phrase("Balance",headerFont));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);


				String sql1 = "SELECT TransactionDate,TransactionDetail,TransactionType,CreditAmount,DebitAmount,Balance FROM  "+CID+"customerledgeraccount where CustomerCode='"
					+ customer
					+ "' ORDER BY  concat(TransactionDate , TransactionId ) Desc limit 3";
              PreparedStatement pstmt = conn1.prepareStatement(sql1,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				ResultSet rs1=pstmt.executeQuery();
				if(rs1!=null )
				rs1.afterLast();
				
				while(rs1.previous())
				{
					c1 = new PdfPCell(new Phrase(""+  new SimpleDateFormat("dd-MMM-yyyy")
					.format(new SimpleDateFormat(
					"yyyy-MM-dd").parse(rs1
							.getString(1))) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(c1);


					c1 = new PdfPCell(new Phrase(""+ rs1.getString(2) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(c1);

					c1 = new PdfPCell(new Phrase(""+ rs1.getString(3) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(c1);

					c1 = new PdfPCell(new Phrase(""+ rs1.getString(4) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(c1);

					c1 = new PdfPCell(new Phrase(""+ rs1.getString(5) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(c1);


					c1 = new PdfPCell(new Phrase(""+ rs1.getString(6) +"",NormalFont));
					c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(c1);


				}

				document.add(table);

				Paragraph NF15 = new Paragraph();
				NF15.add(new Paragraph("",NF));
				NF15.setAlignment("Right");
				document.add(NF15);	
				
				int count=0;
				double grandtotal=0;

				float[] widths1 = {0.05f, 0.40f,0.10f, 0.15f, 0.15f,0.15f};
				PdfPTable table3 = new PdfPTable(widths1);
				table3.setWidthPercentage(100);
				PdfPCell c3= new PdfPCell(new Phrase("Sr No",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase("Description",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase("HSN/SAC",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);
				
				c3 = new PdfPCell(new Phrase("Quantity",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);
				
				c3 = new PdfPCell(new Phrase("Rate",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);
				c3 = new PdfPCell(new Phrase("Amount",headerFont));
				c3.setHorizontalAlignment(Element.ALIGN_CENTER);
				table3.addCell(c3);

				/*String sqlcheck="Select * from "+CID+"billingcrossschecking where month1='"+year+"-"+month+"-01' and BillGroup='"+groupname+"'";
				ResultSet rsSqlchk=st3.executeQuery(sqlcheck);*/

				c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(" "+desc+" ",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(" "+TaxCode+" ",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(""+vehiclenos+"",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(""+nf1.format(flratepervehicle)+"",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(""+nf1.format((Integer.parseInt(vehiclenos) * flratepervehicle) ) +"",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);


				grandtotal=(Integer.parseInt(vehiclenos) * flratepervehicle);

				/*String sqlInsert1="Insert Into "+CID+"salesinv_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) values ('"+SINumber+"','3','26','"+itemcode+"','"+vehiclenos+"','"+nf.format(flratepervehicle)+"','100000tbl_digitim_make26','"+count+"','0.0','"+desc+"','"+CGSTRate+"','"+CGSTValue+"','"+SGSTRate+"','"+SGSTValue+"','"+IGSTRate+"','"+IGSTValue+"')";
				st1.executeUpdate(sqlInsert1);
				System.out.println("sqlInsert1=====>"+sqlInsert1);*/
				
				String sqlInsert1="Insert Into "+CID+"performainvoice_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) values ('"+SIProNumber+"','3','26','"+itemcode+"','"+vehiclenos+"','"+nf.format(flratepervehicle)+"','100000tbl_digitim_make26','"+count+"','0.0','"+desc+"','"+CGSTRate+"','"+CGSTValue+"','"+SGSTRate+"','"+SGSTValue+"','"+IGSTRate+"','"+IGSTValue+"')";
				st1.executeUpdate(sqlInsert1);
				System.out.println("sqlInsert1=====>"+sqlInsert1);
				
				

				//count ++;
				double BillAmtnew =  0;
				BillAmtnew =Integer.parseInt(vehiclenos)*flratepervehicle;
				System.out.println("BILL AMONUT 111  "+BillAmtnew);


				/*if(jrmcount>0)
				{

					c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase("JRM - Monthly Road Risk Data Flat Charges",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_LEFT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase(""+jrmcount+"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase("100.00",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase(""+nf1.format((jrmcount * 100))  +"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					BillAmtnew = BillAmtnew + (jrmcount * 100);
					grandtotal=grandtotal+ (jrmcount * 100);
					System.out.println("BIll amount at jrm  "+BillAmtnew);
					String sqlInsert2="Insert into "+CID+"salesinv_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription) values ('"+SINumber+"','3','26','2319','"+jrmcount+"','100.00','100000tbl_digitim_make26','"+count+"','0.0','JRM - Monthly Road Risk Data Flat Charges')";
						  	st2.executeUpdate(sqlInsert2);
					System.out.println("sqlInsert2======>"+sqlInsert2);
				}*/

				int monthdaysnew=0;
				if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") )
				{monthdaysnew=LASTDAYCOUNT;}

				if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
				{monthdaysnew=LASTDAYCOUNT;}

				if(month.equals("02"))
				{
				monthdaysnew=LASTDAYCOUNT;
				}
				
				String Sqldata1 ="";
				double CapTot = 0, OffTot = 0,ToTDays = 0;
				double diff=0,Rate1=0;
				if(billtype=="Combined" || billtype.equals("Combined"))
				{
					Sqldata1 = "Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+CID+"billingdetails"+year+"_"+month+"  ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and TotalDays='"+monthdaysnew+"' ";
				}
				else 
				{
					Sqldata1="Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays,jrm from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+" where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and  "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+CID+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and TotalYes+TotalYesStar >=(TotalDays/100)*("+salcount+") and month1='"+year+"-"+month+"-01' and TotalDays='"+monthdaysnew+"' "; 
					
					
				}
				
				

				ResultSet rsSql1=st1.executeQuery(Sqldata1);
				System.out.println(Sqldata1);	
				while(rsSql1.next())
				{
					CapTot = CapTot + rsSql1.getDouble("CapturedDays");
					OffTot = OffTot + rsSql1.getDouble("TotalYesStar");
					ToTDays = ToTDays + rsSql1.getDouble("totalDays");
				}

				System.out.println(CapTot +"  "+OffTot+"  "+ToTDays);
				System.out.println("value  "+(billdays)*(Integer.parseInt(vehiclenos)));
				
				if((ToTDays!=(billdays)*(Integer.parseInt(vehiclenos))) && billdays !=0)
				{
					System.out.println("IN IFF ");
					diff=(billdays*Integer.parseInt(vehiclenos)) - ToTDays;
					Rate1 = flratepervehicle / billdays;
					System.out.println(diff+" diff and rate "+Rate1);
				}
				
				double diffAMT=0;
				
				double perdaycharge=0,  SLA=75;
				int diffDays=0;
				
				if(salcount != 0)
					
				//if(billtype=="Combined" || billtype.equals("Combined"))
				{

					 double totaldays=0;
					
					System.out.println("*********Rate for vehicles ="+flratepervehicle);
					System.out.println("*********Total Vehicles ="+vehiclenos);
					System.out.println("*********Total Working Days="+ToTDays);
					
					System.out.println("*********Total daysinmonth "+daysinmonth); 
					
					int totaldaysin=daysinmonth * Integer.parseInt(vehiclenos);
					
					System.out.println("************Total Actual Days="+totaldaysin);
					
					perdaycharge=Double.parseDouble(nf.format(flratepervehicle/LASTDAYCOUNT));

					System.out.print("Per Day Charge"+ perdaycharge);
					System.out.print("Per Day Charge"+ perdaycharge);
					
					double sladaycount=0.00;
					
					System.out.print("salcount in SLA Cal :- "+ salcount);
					
					sladaycount=totaldaysin * salcount/100 ;
					
					double totsladay1=0.00;
					
					totsladay1=CapTot+OffTot;
					
					System.out.println(" SLA Day Count :- "+sladaycount);
					System.out.println("totsladay1 :- "+totsladay1);
					
					if(totsladay1 > sladaycount)
					{
						/*diffDays=new Double(sladaycount- ToTDays).intValue();
						diffAMT=perdaycharge*diffDays;*/
						
						diffDays=0;
						
						
						
					}
					else
					{
						System.out.println("In SLA Else");
						diffDays=new Double(sladaycount- totsladay1).intValue();
						
						diffAMT=perdaycharge*diffDays;
						
						
					}
					
					System.out.println("Diff Of SLA Days :- "+diffDays);
					System.out.println("Diff Of SLA Amount :- "+diffAMT);
					
					if(diffDays > 0)
					{
					c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase("Adjustment in Bill Days",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_LEFT);
					table3.addCell(c3);
					
					c3 = new PdfPCell(new Phrase("-",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase(""+ diffDays,NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase(""+nf1.format(perdaycharge),NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase("-"+nf1.format(diffAMT) ,NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);
					
					BillAmtnew = BillAmtnew - (diffAMT);
					grandtotal=grandtotal- (diffAMT);

							  
							  
							  String insert2="Insert into "+CID+"performainvoice_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSrno,STPercent,ItemDescription) values ('"+SIProNumber+"','3','26','2246','-"+diffDays+"','"+nf.format(perdaycharge)+"','100000tbl_digitim_make26','"+count+"','0.0','Adjustment in Bill Days')";
								System.out.println("bill at adjustment  "+insert2);
								st.executeUpdate(insert2);
							  
					}
				}
				
				//Code For Vehicle Added Bill Day Diff Start 
				
				String billdiffday="";
				
				//String billdaydiff="Select IFNULL(SUM(DATEDIFF(VehAddedThisMonth,date_format(now() - INTERVAL 30 DAY ,'%Y-%m-01'))),'0') as DIFF from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+" where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid  and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+CID+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and (VehAddedThisMonth!='No')";
				
				String billdaydiff="Select IFNULL(SUM(TotalDays),0) as DIFF  from "+CID+"billingdetails"+year+"_"+month+" ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode ='"+customer+"'   and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01' and TotalDays > 0  and TotalDays <'"+LASTDAYCOUNT+"'";
				ResultSet rsbilldiff=st.executeQuery(billdaydiff);
				
				if(rsbilldiff.next())
				{
					billdiffday=rsbilldiff.getString("DIFF");
					
					if(billdiffday.equalsIgnoreCase("null") || billdiffday.equalsIgnoreCase("") || billdiffday.equalsIgnoreCase(" ") || billdiffday==null )
					{
						
					}else {
						
						perdaycharge=Double.parseDouble(nf.format(flratepervehicle/daysinmonth));

						System.out.print("Per Day Charge"+ perdaycharge);
						
						diffDays=new Double(billdiffday).intValue();
						
						diffAMT=perdaycharge*diffDays;
						
						System.out.print("Bill Adjust Amount :- "+ diffAMT);
						
						if(diffAMT > 0)
						{
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("Monthly Data Access Charges For The Broken Period - Mobile Eye Standard",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase(" "+TaxCode+" ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+ diffDays,NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format(perdaycharge),NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format(diffAMT) ,NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						BillAmtnew = BillAmtnew + (diffAMT);
						grandtotal=grandtotal+ (diffAMT);

								  
								  
								  String insert2="Insert into "+CID+"performainvoice_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSrno,STPercent,ItemDescription) values ('"+SIProNumber+"','3','26','2964','-"+diffDays+"','"+nf.format(perdaycharge)+"','100000tbl_digitim_make26','"+count+"','0.0','Monthly Data Access Charges For The Broken Period - Mobile Eye Standard')";
									System.out.println("bill at adjustment  "+insert2);
									st.executeUpdate(insert2);
								  
						}
						
					}
				}else {
					
					
				}
				
				//Code For Vehicle Added Bill Day Diff End

				
				
				
				/*double shortfalldays=0;
				if(salcount != 0)
				{


					if (CapTot + OffTot >= ToTDays * salcount / 100)
					{
						shortfalldays = 0;
					}
					else
					{
						shortfalldays = (ToTDays * salcount / 100) - (CapTot + OffTot);
					}

					if((shortfalldays > 0) && billdays!=0)
					{

						Rate1 = Integer.parseInt(vehiclenos)/billdays;
					}

					
					double shortfallCalcdays=0.0;
					
					if( CapTot + OffTot >= ToTDays * salcount / 100)
						shortfallCalcdays = 0;
					else
						shortfallCalcdays = (ToTDays * salcount / 100) - (CapTot + OffTot);
					
					
					double ratefll=Double.parseDouble(nf.format(flratepervehicle/daysinmonth));
					
					double short_fallslaNEW=Double.parseDouble(nf.format(flratepervehicle/daysinmonth))*shortfallCalcdays;
					
					System.out.println("VAL_____________==============>>>>"+shortfallCalcdays);
					
					if(shortfallCalcdays !=0)
					{
					
					c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					c3 = new PdfPCell(new Phrase("Voluntary SLA Adjustment",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_LEFT);
					table3.addCell(c3);
					
					c3 = new PdfPCell(new Phrase("-",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);
					
					c3 = new PdfPCell(new Phrase(""+nf1.format(shortfallCalcdays)+"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);
					c3 = new PdfPCell(new Phrase(""+nf1.format(ratefll)+"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);
					
					c3 = new PdfPCell(new Phrase(""+nf1.format((short_fallslaNEW))+"",NormalFont));
					c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table3.addCell(c3);

					BillAmtnew = BillAmtnew - (short_fallslaNEW);
					grandtotal=grandtotal-(short_fallslaNEW);
					
					System.out.println("Bill amount at volun SLA  "+BillAmtnew);
					String sqlInsert3="Insert into "+CID+"salesinv_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription) values ('"+SINumber+"','3','26','2247','-"+shortfallCalcdays+"','"+ratefll+"','100000tbl_digitim_make26','"+count+"','0.0','Voluntary SLA Adjustment')";
							st3.executeUpdate(sqlInsert3);
					System.out.println("sqlInsert3======>"+sqlInsert3);
					
					
					}
					
				}*/
				
				c3 = new PdfPCell(new Phrase("",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase("Total",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase("",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase("",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);
				
				c3 = new PdfPCell(new Phrase("",NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);

				c3 = new PdfPCell(new Phrase(""+nf1.format(BillAmtnew),NormalFont));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table3.addCell(c3);
				
				System.out.println("grandtotal AFTER SHORT FALL IN SLAAAA==>"+grandtotal);
				
				//double InvAmtnew = grandtotal;
				//System.out.println("INVOICE AMOUNT AT START  "+InvAmtnew);
				
				if(State5.equals(" "))
				{
					if(BillingState.equals(State))
					{
						 CGSTRate=rate/2;
						 
						 SGSTRate=rate/2;
						 
						 IGSTRate=0.00;
						 
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("CGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+CGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * CGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						CGSTValue=(BillAmtnew * CGSTRate / 100);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("SGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+SGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * SGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						SGSTValue=(BillAmtnew * SGSTRate / 100);

						c3 = new PdfPCell(new Phrase("IGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+IGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * IGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);


						IGSTValue=(BillAmtnew * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						System.out.println("Total GST :- "+GST);
						
						
						
					  //grandtotal=grandtotal+(grandtotal * 15 / 100);
					  
					  /*String sqlInsert7="Insert into "+CID+"salesinv_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription) values ('"+SINumber+"','3','26','2617','1','"+nf.format(BillAmtnew * .15)+"','100000tbl_digitim_make26','"+count+"','0.0','Service Charge 15%')";
						System.out.println("sqlInsert7======>"+sqlInsert7);
						
						System.out.println("sqlInsert7======>"+sqlInsert7);
						
							 st7.executeUpdate(sqlInsert7);*/
							 
							 
								
							
					}
					else
					{
						 
						 IGSTRate=rate;
						
						
						
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("CGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+CGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * CGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						CGSTValue=(BillAmtnew * CGSTRate / 100);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("SGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+SGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * SGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						SGSTValue=(BillAmtnew * SGSTRate / 100);

						c3 = new PdfPCell(new Phrase("IGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+IGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * IGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);


						IGSTValue=(BillAmtnew * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						System.out.println("Total GST :- "+GST);
						
						
						
						
						
					}
					
				}
				else
				{
					if(BillingState.equals(State5))
					{
						 CGSTRate=rate/2;
						 
						 SGSTRate=rate/2;
						 
						 IGSTRate=0.00;
						 
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("CGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+CGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * CGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						CGSTValue=(BillAmtnew * CGSTRate / 100);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("SGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+SGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * SGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						SGSTValue=(BillAmtnew * SGSTRate / 100);

						c3 = new PdfPCell(new Phrase("IGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+IGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * IGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);


						IGSTValue=(BillAmtnew * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						System.out.println("Total GST :- "+GST);
						
						
						
					  //grandtotal=grandtotal+(grandtotal * 15 / 100);
					  
					  /*String sqlInsert7="Insert into "+CID+"salesinv_items (InvoiceNo,TheGroup,Make,ItemCode,Quantity,SellingPrice,TheTableToBeAccessed,ItemSRNo,STPercent,ItemDescription) values ('"+SINumber+"','3','26','2617','1','"+nf.format(BillAmtnew * .15)+"','100000tbl_digitim_make26','"+count+"','0.0','Service Charge 15%')";
						System.out.println("sqlInsert7======>"+sqlInsert7);
						
						System.out.println("sqlInsert7======>"+sqlInsert7);
						
							 st7.executeUpdate(sqlInsert7);*/
							 
							 
								
							
					}
					else
					{
						 
						 IGSTRate=rate;
						
						
						
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("CGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+CGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * CGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						CGSTValue=(BillAmtnew * CGSTRate / 100);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("SGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+SGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * SGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase(""+ ++count +"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						SGSTValue=(BillAmtnew * SGSTRate / 100);

						c3 = new PdfPCell(new Phrase("IGST ",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_LEFT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);
						
						c3 = new PdfPCell(new Phrase("",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+IGSTRate+"%",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);

						c3 = new PdfPCell(new Phrase(""+nf1.format( BillAmtnew * IGSTRate / 100)+"",NormalFont));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table3.addCell(c3);


						IGSTValue=(BillAmtnew * IGSTRate / 100);
						
						GST=CGSTValue+SGSTValue+IGSTValue;
						System.out.println("Total GST :- "+GST);
						
						
						
						
						
					}
					
				}
				

				BillAmtnew=BillAmtnew+GST;
				System.out.println("Total Invoice Bill Amount  :- "+GST);



				

				document.add(table3);
				grandtotal=BillAmtnew;
				grandtotal =	Math.round(grandtotal);
				
				System.out.println("FINAL grandtotal=================%$%$%$%$%$%$%&&&&&&grandtotal"+grandtotal);

				Paragraph totalvalue=new Paragraph();
				totalvalue.add(new Paragraph("Grand Total : "+ nf1.format(grandtotal) +"",smallfont2));
				totalvalue.setAlignment("Right");
				document.add(totalvalue);

				
				
				invcamount=grandtotal;
				
				
				
				double invamt=invcamount;
				
				int rsAmt=(int) invamt;
				
				String Amt_Rs=PdfGeneration.convertNumberToWords(rsAmt);
				
				Amt_Rs+=" Only";
				
				System.out.println("FINAL grandtotal=================%$%$%$%$%$%$%&&&&&&RUPEES VALUE==================>"+Amt_Rs);
				

				Paragraph totalvalueInRs=new Paragraph();
				totalvalueInRs.add(new Paragraph("Grand Total (In Words) : "+Amt_Rs+"",smallfont2));
				totalvalueInRs.setAlignment("Right");
				document.add(totalvalueInRs);
				try
				{
				System.out.println("User Name=>>>>>>>"+UNE);
				Image image1=null;
				PreparedStatement ps = conn1.prepareStatement("Select Signature from db_GlobalERP.UserMaster where UserName='"+UNE+"' and companymasterid='"+CID+"' ");

				ResultSet rs = ps.executeQuery();

				if (rs != null)
				{
					System.out.println("RSSSSSS NOOOOTTT Nulll");

					while(rs.next()) 
					{

						image1 = Image.getInstance(rs.getBytes("Signature"));
						
					}
				}
				
				SimpleTable table321 = new SimpleTable();
				table321.setWidthpercentage(100f);
				table321.setBorder(Rectangle.NO_BORDER);
				SimpleCell row = new SimpleCell(SimpleCell.ROW);
				SimpleCell cellforname12 = new SimpleCell(SimpleCell.CELL);
				cellforname12 = new SimpleCell(SimpleCell.CELL);
				cellforname12.setWidth(0.30f);
				cellforname12.add("");
				row.add(cellforname12);
				SimpleCell cellforname123 = new SimpleCell(SimpleCell.CELL);
				cellforname123 = new SimpleCell(SimpleCell.CELL);
				cellforname123.setWidth(0.30f);
				cellforname123.add("");
				row.add(cellforname123);
				SimpleCell cellforname1234 = new SimpleCell(SimpleCell.CELL);
				cellforname1234 = new SimpleCell(SimpleCell.CELL);
				cellforname1234.setWidth(0.30f);
				cellforname1234.add("");
				row.add(cellforname1234);
				
				SimpleCell cellforname = new SimpleCell(SimpleCell.CELL);
				cellforname = new SimpleCell(SimpleCell.CELL);
				cellforname.add(image1);
				cellforname.setWidth(100f);
				cellforname.setWidth(0.10f);
				cellforname.setWidthpercentage(100f);
				cellforname.setHorizontalAlignment(Element.ALIGN_LEFT);
				row.add(cellforname);
				table321.addElement(row);
				document.add(table321);

				}
				catch(Exception ex)
				{
					System.out.print(ex);
					document.add(Chunk.NEWLINE );
					document.add(Chunk.NEWLINE );
					document.add(Chunk.NEWLINE );
					
				}
				
				Paragraph para01=new Paragraph();
				para01.add(new Paragraph(Emp_Name,smallfont2));
				para01.setAlignment("Right");
				document.add(para01);
				
				Paragraph para1=new Paragraph();
				para1.add(new Paragraph("FOR "+companyname,smallfont2));
				para1.setAlignment("Right");
				document.add(para1);
				
				int monthdays=0;
				if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") )
				{monthdays=LASTDAYCOUNT;}

				if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
				{monthdays=LASTDAYCOUNT;}

				if(month.equals("02"))
				{monthdays=LASTDAYCOUNT;}
				
				Paragraph terms=new Paragraph();
				terms.add(new Paragraph("Terms & Conditions :-",smallfont2));
				terms.setAlignment("Left");
				document.add(terms);
				String MN="";
				if(month.equals("01"))
				{
					MN="Jan";
				}
				if(month.equals("02"))
				{
					MN="Feb";
				}
				if(month.equals("03"))
				{
					MN="Mar";
				}
				if(month.equals("04"))
				{
					MN="Apr";
				}
				if(month.equals("05"))
				{
					MN="May";
				}
				if(month.equals("06"))
				{
					MN="Jun";
				}
				if(month.equals("07"))
				{
					MN="Jul";
				}
				if(month.equals("08"))
				{
					MN="Aug";
				}
				if(month.equals("09"))
				{
					MN="Sep";
				}
				if(month.equals("10"))
				{
					MN="Oct";
				}
				if(month.equals("11"))
				{
					MN="Nov";
				}
				if(month.equals("12"))
				{
					MN="Dec";
				}
				
				
				String trmAndCondition="";
				/*if(servicetax!=0)
				{
					Paragraph terms1=new Paragraph();
					terms1.add(new Paragraph("1. Service Tax 15 % Including Swachh Bharat Cess and Krishi Kalyan Cess",NormalFont));
					terms1.add(new Paragraph("2. Payment - 100 % within 10 days from the Invoice date." ,NormalFont));
					terms1.add(new Paragraph("3. Monthly Rental Charges for the Period 01-"+MN+"-"+year+" To "+monthdays+"-"+MN+"-"+year+" " ,NormalFont));
					terms1.add(new Paragraph("4. Usage charges will be billed seperately if any." ,NormalFont));
					terms1.add(new Paragraph("5. Applicable Taxes Included." ,NormalFont));
					terms1.setAlignment("Left");
					document.add(terms1);
					
					trmAndCondition="1. Service Tax 15 % Including Swachh Bharat Cess and Krishi Kalyan Cess \n 2. Payment - 100 % within 10 days from the Invoice date. \n3. Monthly Rental Charges for the Period 01-"+MN+"-"+year+" To "+monthdays+"-"+MN+"-"+year+" \n 4. Usage charges will be billed seperately if any. \n 5. Applicable Taxes Included.";

				}
				else */ 
				double servicecharge=rate;
				if(servicecharge != 0)
				{
					Paragraph terms2=new Paragraph();
					//terms2.add(new Paragraph("1. Service Charge 15 % Including Swachh Bharat Cess and Krishi Kalyan Cess",NormalFont));
				
					terms2.add(new Paragraph("1. Payment - 100 % within 10 days from the ProForma Invoice date." ,NormalFont));
					terms2.add(new Paragraph("2. Applicable Taxes Included." ,NormalFont));
					terms2.add(new Paragraph("3. This proforma invoice is been issued for purposes of better accountability and reconciliation of GST. Final Tax invoice would be dispatched soon after receipt of payment." ,NormalFont));
					terms2.setAlignment("Left");
					document.add(terms2);
					
					trmAndCondition="1. GST rate as per standard. \n2. Payment - 100 % within 10 days from the ProForma Invoice date.\n 3. Monthly Rental Charges for the Period 01-"+MN+"-"+year+" To "+monthdays+"-"+MN+"-"+year+" \n4. Usage charges will be billed seperately if any.\n 5. Applicable Taxes Included. \n 6. This proforma invoice is been issued for purposes of better accountability and reconciliation of GST. Final Tax invoice would be dispatched soon after receipt of payment.";

				}	
				else 
				{
					Paragraph terms3=new Paragraph();
					terms3.add(new Paragraph("1. Payment - 100 % within 10 days from the ProForma Invoice date." ,NormalFont));
					terms3.add(new Paragraph("2. Applicable Taxes Included." ,NormalFont));
					terms3.add(new Paragraph("3. This proforma invoice is been issued for purposes of better accountability and reconciliation of GST. Final Tax invoice would be dispatched soon after receipt of payment." ,NormalFont));
					terms3.setAlignment("Left");
					document.add(terms3);
					
					trmAndCondition="1. Payment - 100 % within 10 days from the ProForma Invoice date.\n 2. Applicable Taxes Included. \n 3. This proforma invoice is been issued for purposes of better accountability and reconciliation of GST. Final Tax invoice would be dispatched soon after receipt of payment.";

				}
				
				Paragraph NF16 = new Paragraph();
				NF16.add(new Paragraph("",NF));
				NF16.setAlignment("Right");
				document.add(NF16);	
				
				Paragraph parabottom5123=new Paragraph();
				parabottom5123.add(new Paragraph("The provision of goods and/or service in governed by the terms and condition of contract. contracts are automatically renewed/extended by your use of the product or service supplied. Please call for a copy of your contract terms by sending an email to legal@twtech.in ",NormalFont));
				parabottom5123.setAlignment("Left");
				document.add(parabottom5123);

				Paragraph NF16c = new Paragraph();
				NF16c.add(new Paragraph("",NF));
				NF16c.setAlignment("Right");
				document.add(NF16c);	
				
				Paragraph parabottom5=new Paragraph();
				parabottom5.add(new Paragraph("Subject To Pune Jurisdiction :-",smallfont2));
				parabottom5.setAlignment("Left");
				document.add(parabottom5);

				Paragraph parabottom6=new Paragraph();
				//parabottom6.add(new Paragraph("MVAT NO. -27530019079V CST NO. - 27530019079C",NormalFont));
				parabottom6.add(new Paragraph("PAN No "+PANNo+" GSTIN No "+GSTINNO+"" ,NormalFont));
				parabottom6.setAlignment("Left");
				document.add(parabottom6);

				Paragraph parabottom3=new Paragraph();
				parabottom3.add(new Paragraph("We are a Small Enterprise Under the Micro Medium and Small Enterprise Act 2006. Govt. of India",NormalFont));
				parabottom3.add(new Paragraph("Queries regarding this Invoice to be addressed to "+mail+" Tel "+phone,NormalFont));
				parabottom3.setAlignment("Left");
				document.add(parabottom3);

				document.add( Chunk.NEWLINE );
				
				PdfContentByte canvas2 = writer.getDirectContent();
				Rectangle rect2 = new Rectangle(10, 10, 583, 830);
				rect2.setBorder(Rectangle.BOX);
				rect2.setBorderWidth(1);
				canvas2.rectangle(rect2);
				
				trmAndCondition+="We are a Small Enterprise Under the Micro Medium and Small Enterprise Act 2006. Govt. of India \n Summary of Bill as per Annexure - I attached for 18 Units.";
				
				
				
				Paragraph para2=new Paragraph();
				para2.add(new Paragraph("Day Wise Bill Report For "+month+"-"+year+" of "+custname+" ",smallfont2));
				para2.setAlignment("Left");
				document.add(para2);

				Paragraph para3=new Paragraph();
				para3.add(new Paragraph("Bill Period 01-"+month+"-"+year+" to "+daysinmonth+"-"+month+"-"+year+" ",smallfont2));
				para3.setAlignment("Left");
				document.add(para3);

				
				PdfContentByte canvas12 = writer.getDirectContent();
				Rectangle rect12 = new Rectangle(10, 10, 583, 830);
				rect12.setBorder(Rectangle.BOX);
				rect12.setBorderWidth(1);
				canvas12.rectangle(rect12);
				
				
				Paragraph annexturetoinvc=new Paragraph();
				annexturetoinvc.add(new Paragraph("Annexture To Invoice "+SPRefNumber+"",smallfont2));
				annexturetoinvc.setAlignment("Left");
				document.add(annexturetoinvc);

				
				
				float[] widthsveh = {0.03f, 0.10f, 0.10f, 0.05f,0.05f,0.05f,0.03f, 0.10f, 0.10f, 0.05f,0.05f,0.05f};
				PdfPTable tableData = new PdfPTable(widthsveh);
				tableData.setWidthPercentage(100);
				

				PdfPCell celldata= new PdfPCell(new Phrase("Sr No",Fontfortable));
				celldata.setFixedHeight(0.45f);
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Veh Reg No",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Inst Dt",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Captured",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Ing. Off",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Total",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);
				
				celldata = new PdfPCell(new Phrase("Sr No",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Veh Reg No",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Inst Dt",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Captured",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Ing. Off",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("Total",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);
				
				
				

				int srnoforveh=1;
				int totaldays=0, captured=0, ingoff=0;
				String sqlVehdata="Select distinct("+CID+"billingdetails"+year+"_"+month+".VehRegno),instdate,"+CID+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+CID+"billingdetails"+year+"_"+month+"  ,"+CID+"fv_erp_relation"+year+"_"+month+"  where "+CID+"billingdetails"+year+"_"+month+".vehid="+CID+"fv_erp_relation"+year+"_"+month+".vehid and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+CID+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01'";
				ResultSet rsveh=st14.executeQuery(sqlVehdata);
				System.out.println("=======..............VEHICLE COUNT QUERY..........==========>"+sqlVehdata);
				//rsveh.isBeforeFirst();
				while(rsveh.next()){
					int count2=1;
					celldata = new PdfPCell(new Phrase(""+ srnoforveh +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);

					celldata = new PdfPCell(new Phrase(""+ rsveh.getString("VehRegno") +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);

					celldata = new PdfPCell(new Phrase(""+new Phrase(""+ new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsveh.getString("InstDate")))) +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);

					celldata = new PdfPCell(new Phrase(""+ rsveh.getString("CapturedDays")  +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);
					
					celldata = new PdfPCell(new Phrase(""+ rsveh.getString("TotalYesStar")  +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);

					

					celldata = new PdfPCell(new Phrase(""+ rsveh.getString("TotalDays")  +"",Fontfortable));
					celldata.setBorder(Rectangle.NO_BORDER);
					celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableData.addCell(celldata);	

					srnoforveh ++;
					totaldays=totaldays+Integer.parseInt(rsveh.getString("TotalDays"));
					captured=captured+Integer.parseInt(rsveh.getString("CapturedDays"));
					ingoff=ingoff+Integer.parseInt(rsveh.getString("TotalYesStar"));
				}
				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);
				
				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);

				

				celldata = new PdfPCell(new Phrase("",Fontfortable));
				celldata.setBorder(Rectangle.NO_BORDER);
				celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableData.addCell(celldata);	

				document.add(tableData);
				
				/*Paragraph NF7 = new Paragraph();
				NF7.add(new Paragraph("",NF));
				NF7.setAlignment("Right");
				document.add(NF7);	
				*/
				Paragraph total=new Paragraph();
				total.add(new Paragraph("Captured : "+ captured +" Ing. off : "+ingoff+" Total : "+totaldays,headerFont));
				total.setAlignment("Right");
				document.add(total);

				if(salcount != 0)
				{
				Paragraph para4=new Paragraph();
				para4.add(new Paragraph("SUMMARY OF BILL   ",headerFont));
				para4.setAlignment("Left");
				document.add(para4);


				Paragraph para5=new Paragraph();
				para5.add(new Paragraph("Amount per vehicle="+nf1.format(flratepervehicle)+"   ",headerFont));
				para5.setAlignment("Left");
				document.add(para5);

				Paragraph para6=new Paragraph();
				para6.add(new Paragraph("Days in Bill Period ="+daysinmonth+"   ",headerFont));
				para6.setAlignment("Left");
				document.add(para6);


				Paragraph para7=new Paragraph();
				para7.add(new Paragraph("Amount For 1 Day ="+nf1.format(flratepervehicle/daysinmonth)+"   ",headerFont));
				para7.setAlignment("Left");
				document.add(para7);
				
				
				trmAndCondition+="a.Amount per vehicle="+nf.format(flratepervehicle)+"\n Days in Bill Period ="+daysinmonth+" \n Amount For 1 Day ="+nf.format(flratepervehicle/daysinmonth)+" \n";

				/*Paragraph para8=new Paragraph();
				para8.add(new Paragraph("SLA=75%   ",headerFont));
				para8.setAlignment("Left");
				document.add(para8);
				
				*/

				/*        ********************************* start of calculations for SLA  ****************************************   */
				
				double shortfall = 0;
				
				if(salcount != 0)
				{

					Paragraph para9=new Paragraph();
					para9.add(new Paragraph("SLA="+salcount+"%   ",headerFont));
					para9.setAlignment("Left");
					document.add(para9);

/*
					Paragraph para10=new Paragraph();
					para10.add(new Paragraph("No of Total Days(TD) in "+month+"-"+year+" ="+totaldays+"  ",headerFont));
					para10.setAlignment("Left");
					document.add(para10);
*/

					Paragraph para11=new Paragraph();
					para11.add(new Paragraph("NO Of Captured Days(CD) for all vehicles (Captured Days+Ignition Off Days)= "+(CapTot+OffTot)+"  ",headerFont));
					para11.setAlignment("Left");
					document.add(para11);


					Paragraph para12=new Paragraph();
					para12.add(new Paragraph("SLA Days=  "+Math.round(ToTDays * salcount/ 100)+"",headerFont));
					para12.setAlignment("Left");
					document.add(para12);


					
					if( CapTot + OffTot >= ToTDays * salcount / 100)
						shortfall = 0;
					else
						shortfall = (ToTDays * salcount / 100) - (CapTot + OffTot);
					
						shortfall=Math.round(shortfall);
						
					//shortfall=nf1.format(shortfall);

					Paragraph para13=new Paragraph();
					para13.add(new Paragraph("Short fall in SLA Days =(CD-SLA Days) or (SLA Days-CD) = "+nf1.format(shortfall)+" ",headerFont));
					para13.setAlignment("Left");
					document.add(para13);
					
					trmAndCondition+="SLA="+salcount+"%  \n NO Of Captured Days(CD) for all vehicles (Captured Days+Ignition Off Days)= "+(CapTot+OffTot)+" SLA Days=  "+(ToTDays * salcount/ 100)+" \n";

				}

				/*        ********************************* start of calculations for SLA  ****************************************   */


				Paragraph td=new Paragraph();
				td.add(new Paragraph("No Of Total Days(TD) in "+month+"-"+year+" = "+totaldays+"",headerFont));
				td.setAlignment("Left");
				document.add(td);


				double ExpTotAmt=(flratepervehicle/daysinmonth) * totaldays;
				Paragraph para14=new Paragraph();
				para14.add(new Paragraph("Expected Total Amount= ("+flratepervehicle+"/"+daysinmonth+") * "+totaldays+" = "+ nf1.format((flratepervehicle/daysinmonth) * totaldays)+"  ",headerFont));
				para14.setAlignment("Left");
				document.add(para14);
				
				
				double short_fallsla=flratepervehicle/daysinmonth*shortfall;
				short_fallsla=Math.round(short_fallsla);
				Paragraph para15=new Paragraph();
				para15.add(new Paragraph("Short fall in SLA Amount=("+nf1.format((flratepervehicle/daysinmonth))+"*"+nf1.format(shortfall)+") ="+nf1.format(short_fallsla)+"  ",headerFont));
				para15.setAlignment("Left");
				document.add(para15);
				
				trmAndCondition+="No Of Total Days(TD) in "+month+"-"+year+" = "+totaldays+"\n Expected Total Amount= ("+flratepervehicle+"/"+daysinmonth+") * "+totaldays+" = "+ (flratepervehicle/daysinmonth) * totaldays+" \n Short fall in SLA Amount=("+flratepervehicle/daysinmonth+"*"+shortfall+") ="+short_fallsla+"\n Expected Total Amount= ("+flratepervehicle+"/"+daysinmonth+") * "+totaldays+" = "+ (flratepervehicle/daysinmonth) * totaldays+"";

				double JRM_Monthly=0.0;
				if(jrmcount>0)
				{	
					Paragraph para16=new Paragraph();
					para16.add(new Paragraph("JRM - Monthly Road Risk Data Flat Charges = "+ jrmcount*100+"  ",headerFont));
					para16.setAlignment("Left");
					document.add(para16);
					JRM_Monthly=jrmcount*100;
					trmAndCondition+="JRM - Monthly Road Risk Data Flat Charges = "+ jrmcount*100+"\n";
				}
				else//jrmcount=0
				{
					Paragraph para17=new Paragraph();
					para17.add(new Paragraph("JRM - Monthly Road Risk Data Flat Charges = Not Applicable"+"  ",headerFont));
					para17.setAlignment("Left");
					document.add(para17);
					trmAndCondition+="JRM - Monthly Road Risk Data Flat Charges = Not Applicable\n";
				}

				double ttlamt = ((flratepervehicle/daysinmonth) * totaldays);

				double nba = (ttlamt+(jrmcount*100));
				double NetBillAmt=ExpTotAmt-short_fallsla+JRM_Monthly;
				String NetBillAmtNew=nf.format(NetBillAmt);
				
				NetBillAmt=Math.round(NetBillAmt);
				

				Paragraph para18=new Paragraph();
				//para18.add(new Paragraph("Net Bill Amount = "+nf1.format(NetBillAmtNew)+"  ",headerFont));
				para18.add(new Paragraph("Net Bill Amount = "+NetBillAmtNew+"  ",headerFont));
				para18.setAlignment("Left");
				document.add(para18);

				
				double netbillamt=NetBillAmt+(NetBillAmt * rate / 100);
				
				netbillamt=Math.round(netbillamt);

				Paragraph para19=new Paragraph();
				para19.add(new Paragraph("Invoice Amount = Net Bill Amt * "+rate+"%Tax = "+ nf1.format(netbillamt)+" ",InvAmtFont));
				para19.setAlignment("Left");
				document.add(para19);
				
				trmAndCondition+="Net Bill Amount = "+NetBillAmtNew+"\n Invoice Amount = Net Bill Amt * "+rate+"%Tax = "+ netbillamt+"";
				
				//Amt_Rs="test";

				}
				
				String PDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todaysDate));
				String InvDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
				
				System.out.println("DATE=====================>>"+PDate);
				
				//PDate+=" 00:00:00";
				
				/****************************************Start of inserting invoice and customer ledger Details Logic *************************************************/
				if(billgst.equals("Unregistered / Not Available"))
				{
					billgst="NA";
				}
				if(shipgst.equals("Unregistered / Not Available"))
				{
					shipgst="NA";
				}
				
				double taxableamt=invamt-GST;
				
				
								/*String sqlmain="INSERT INTO "+CID+"invoicedet " +
				    			"(InvoiceNo ,CustomerCode ,InvoiceDate, TheGroup ,Total ,Discount ,CST ,PFI ,FreightAmt ,GrandTotal,Terms,TotalInWords,PONo,PODate ,DespatchMode ," +
				    			"	FreightType ,PaymentMode ,Insurance, ShippedBy ,ShipmentDate ," +
				    			"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,RevofInvoiceNo ," +
				    			"	NoofRevisions ,ReasonForCancelling ,InvoiceRaisedby," +
				    			"	CurrType,CurrValue,TWEmpName,"+
				    			"	AddressCode,CompanyName,ContactPerson,Address,city," +
				    			"	Zip,State,country,Phone ,Fax,invoiceRefNo, InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue,ShippingGSTIN,BillingGSTIN)Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

							 java.sql.PreparedStatement stmt = conn1.prepareStatement( sqlmain );
						
							
							 stmt.setString(1,Integer.toString(SINumber));
							 stmt.setString(2,customer);
							 stmt.setString(3,InvDate);
							 stmt.setString(4,"3");
							 stmt.setDouble(5,taxableamt);
							 stmt.setString(6,"0");
							 stmt.setString(7,"0");
							 stmt.setString(8,"0");
							 stmt.setString(9,"0");
							 stmt.setDouble(10,invamt);
							 stmt.setString(11,trmAndCondition);
							 stmt.setString(12,Amt_Rs);
							 stmt.setString(13,"Verbel");
							 stmt.setString(14,InvDate);
							 stmt.setString(15,"Surface");
							 stmt.setString(16,"Collect To Pay");
							 stmt.setString(17,"Ins.Cert. Enclosed");
							 stmt.setString(18,"-");
							 stmt.setString(19,"-");
							 stmt.setString(20,"0000-00-00");
							 stmt.setString(21,"-");
							 stmt.setString(22,"-");
							 stmt.setString(23,"-");
							 stmt.setString(24,"0");
							 stmt.setString(25,"0");
							 stmt.setString(26,"0");
							 stmt.setString(27,"0");
							 
							 
							 //Need To CHange in Name
							 stmt.setString(28,"Transworld Compressor Technologies Ltd.");
							 
							 
							 stmt.setString(29,"Rupees");
							 stmt.setString(30,"1");
							 stmt.setString(31,"Autogenerated");
							 stmt.setString(32,AddressCode);
							 stmt.setString(33,custname);
							 stmt.setString(34,contactperson);
							 stmt.setString(35,address);
							 stmt.setString(36,BillingCity);
							 stmt.setString(37,zip);
							 stmt.setString(38,State);
							 stmt.setString(39,country);
							 stmt.setString(40,phone);
							 stmt.setString(41,phone);
							 stmt.setString(42,SIRefNumber);
							 stmt.setString(43,address123);
			                 stmt.setString(44,godownaddress);
			                 stmt.setString(45,"Tel: "+phone123+"  Fax: "+fax+"  "+mail+"  "+website);
			                 stmt.setString(46,companyname);
			                 stmt.setString(47,TaxCode);
			                 stmt.setDouble(48,CGSTRate);
			                 stmt.setDouble(49,CGSTValue);
			                 stmt.setDouble(50,SGSTRate);
			                 stmt.setDouble(51,SGSTValue);
			                 stmt.setDouble(52,IGSTRate);
			                 stmt.setDouble(53,IGSTValue);
			                 stmt.setString(54,shipgst);
			                 stmt.setString(55,billgst);
*/			                 
				
				
				 FromDate=""+year+"-"+month+"-01";
                 Todate=""+year +"-"+month+"-"+monthdays+"";
                
                
			                 
                String DueDateQuery="select DATE(now() + Interval 30 Day) as Duedate";
                ResultSet rsDueDateQuery=st23.executeQuery(DueDateQuery);
                if(rsDueDateQuery.next())
                {
                	Duedate=rsDueDateQuery.getString("Duedate");
                }
                
			                 String sqlmain="INSERT INTO "+CID+"performainvoicedet " +
			             			"(" +
			             			"	InvoiceNo ,CustomerCode ,	InvoiceDate, TheGroup ,Total ," +
			             			"	Discount ,CST ,PFI ,FreightAmt ,GrandTotal, " +
			             			"	Terms, TotalInWords, 	PONo 	,PODate ,	DespatchMode ," +
			             			"	FreightType ,	PaymentMode ,	Insurance, ShippedBy ,ShipmentDate ," +
			             			"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,	RevofInvoiceNo ," +
			             			"	NoofRevisions ,	ReasonForCancelling ,SEandSQRefNo,InvoiceTime,InvoiceRaisedby," +
			             			"	CurrType,CurrValue,TWSalesOrderNo ,DebitNote,TWEmpName, "+
			             			"	AddressCode,CompanyName,ContactPerson,Address,city," +
			             			"	Zip,State,country,Phone ,Fax, "+
			             			"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,InvoiceType , InvoicePrinted, CustPurON, CustPurDT, 				InvRaisedBillAdd,InvRaisedShipAdd,InvRaisedConDet,InvRaisedCompName,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue,ShippingGSTIN,BillingGSTIN,FromDate,ToDate,DueDate"+
			             			"	)"+
			             			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
			             					  "?,?,?,?,?, ?,?,?,?,?,"+
			             					  "?,?,?,?,?, ?,?,?,?,?,"+
			             					  "?,?,?,?,?, ?,?,?,?,?,"+
			             					  "?,?,?,?,?, ?,?,?,?,?,  ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?"+
			             			")";
			                 		
			                 java.sql.PreparedStatement stmt = conn1.prepareStatement( sqlmain );

			             			 stmt.setString(1,Integer.toString(SIProNumber));
			             			 stmt.setString(2,customer);
			             			 stmt.setString(3,InvDate);
			             			 stmt.setString(4,"3");
			             			 stmt.setDouble(5,taxableamt);
			             			 stmt.setString(6,"0");
			             			 stmt.setString(7,"0");
			             			 stmt.setString(8,"0");
			             			 stmt.setString(9,"0");
			             			 stmt.setDouble(10,invamt);
			             			 stmt.setString(11,trmAndCondition);
			             			 stmt.setString(12,"Rupees");
			             			 stmt.setString(13,"Verbal");
			             			 stmt.setString(14,InvDate);
			             			 stmt.setString(15,"Surface");
			             			 stmt.setString(16,"Collect To Pay");
			             			 stmt.setString(17,"Ins.Cert.Enclosed");
			             			 stmt.setString(18,"-");
			             			 stmt.setString(19,"-");
			             			 stmt.setString(20,"0000-00-00");
			             			 stmt.setString(21,"-");
			             			 stmt.setString(22,"-");
			             			 stmt.setString(23,"-");
			             			 stmt.setString(24,"0");
			             			 stmt.setString(25,"0");
			             			 stmt.setString(26,"0");
			             			 stmt.setString(27,"0");
			             			 stmt.setString(28,"0");
			             			 stmt.setString(29,"0");
			             			 stmt.setString(30,"Transworld Compressor Technologies Ltd.");
			             			 stmt.setString(31,"Rupees");
			             			 stmt.setString(32,"1");
			             			 stmt.setString(33,"0");
			             			 stmt.setString(34,"0");
			             			 stmt.setString(35,"Autogenerated");
			             			 stmt.setString(36,AddressCode);
			             			 stmt.setString(37,custname);
			             			 stmt.setString(38,contactperson);
			             			 stmt.setString(39,address);
			             			 stmt.setString(40,BillingCity);
			             			 stmt.setString(41,zip);
			             			 stmt.setString(42,State);
			             			 stmt.setString(43,country);
			             			 stmt.setString(44,phone);
			             			 stmt.setString(45,phone);
			             			 stmt.setString(46,SPRefNumber);
			             			 stmt.setString(47,"-");
			             			 stmt.setString(48,"-");
			             			 stmt.setString(49,"OldTaxPInvoice");
			             			 stmt.setString(50,"No");
			             			 stmt.setString(51,"-");
			             			 stmt.setString(52,"-");
			             			 stmt.setString(53,address);
			             			 stmt.setString(54,godownaddress);
			             			 stmt.setString(55,"Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website);
			             			 stmt.setString(56,companyname);
			             			 stmt.setString(57,TaxCode);
			             			 stmt.setDouble(58,CGSTRate);
			             			 stmt.setDouble(59,CGSTValue);
			             			 stmt.setDouble(60,SGSTRate);
			             			 stmt.setDouble(61,SGSTValue);
			             			 stmt.setDouble(62,IGSTRate);
			             			 stmt.setDouble(63,IGSTValue);
			             			 stmt.setString(64,shipgst);
			             			 stmt.setString(65,billgst);
			             			stmt.setString(66,FromDate);
			             			stmt.setString(67,Todate);
			             			stmt.setString(68,Duedate);

							 
							 System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& =======>"+sqlmain); 
											   stmt.executeUpdate();
				
				
					
					String TransDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todaysDate));
								
								int transactionId;
								String transactionNo="select MAX(TransactionId) from "+CID+"customerledgeraccount";
								ResultSet rsNo=st2.executeQuery(transactionNo);
								rsNo.next();
									transactionId=rsNo.getInt(1);
								transactionId++;
								System.out.println("TRAN   ID   IS "+transactionId);
								System.out.println("+++++++++++++++++++++++++++++++++                 =======================================");
								
								String sqlupdate1="";
								String sqlBalance1="SELECT * FROM  "+CID+"customerledgeraccount where CustomerCode="+customer+" order by TransactionId DESC limit 1";

								ResultSet rsbalance1=st1.executeQuery(sqlBalance1);
								System.out.println("sql"+sqlBalance1);
								double balance1 = 0;
								//double debitamount1=0;
								//double creditamount1=0;
								//double transactionid1=0;
								if(rsbalance1.next())
								{
									//transactionid1=rsbalance.getDouble("transactionid");
									//debitamount1=rsbalance.getDouble("debitamount");
									//creditamount1=rsbalance.getDouble("creditamount");
									balance1=rsbalance1.getDouble("Balance");
									balance1=invcamount+balance1;
																	
								}
								else
								{
									balance1=balance1+invcamount;
								}	
								
									
									String 	sqlAddition="INSERT INTO "+CID+"customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount, "+
											" CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) "+
											
											" VALUES ("+transactionId+",'"+customer+"','Proforma','"+SPRefNumber+"','"+TransDate+"','"+invcamount+"', "+
											" '0','"+balance1+"','Autogenerated','-','"+custname+"' ,'Sales Account' )";
							
							  //  System.out.println(sqlAddition);
								st15.executeUpdate(sqlAddition);
								System.out.println("sqlAddition=======>"+sqlAddition);
							
								
								String updateInvoiceRefNo="update "+CID+"fv_erp_relation"+year+"_"+month+" , "+CID+"billingdetails"+year+"_"+month+" set "+CID+"fv_erp_relation"+year+"_"+month+".InvoiceRefNo='"+SPRefNumber+"' where month1='"+year+"-"+month+"-01' and  "+CID+"fv_erp_relation"+year+"_"+month+".vehID = "+CID+"billingdetails"+year+"_"+month+".VehID  and "+CID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes'  and "+CID+"fv_erp_relation"+year+"_"+month+".ERPCode="+customer+" and "+CID+"fv_erp_relation"+year+"_"+month+".GroupName='"+groupname+"'";
								st24.executeUpdate(updateInvoiceRefNo);
								System.out.println("QUERY===############==>"+updateInvoiceRefNo);								
								/****************************************Start of inserting invoice and customer ledger Details Logic *************************************************/

		
								
								
								
								
								document.add( Chunk.NEWLINE );

								PdfContentByte canvas2new = writer.getDirectContent();
								Rectangle rect2new = new Rectangle(10, 10, 583, 830);
								rect2new.setBorder(Rectangle.BOX);
								rect2new.setBorderWidth(1);
								canvas2new.rectangle(rect2new);
								
								Paragraph parabottom5new=new Paragraph();
								parabottom5new.add(new Paragraph("IMPORTANT NOTICE :-",smallfont2));
								parabottom5new.setAlignment("Left");
								document.add(parabottom5new);
								document.add( Chunk.NEWLINE );
								
								Paragraph parabottom6new=new Paragraph(10);
								
								parabottom6new.add(new Paragraph("1. This is to inform you that certain changes have been made to your contract terms and conditions, especially relating to payment terms, dispute resolution etc. A new set of latest terms and conditions have been forwarded to you and are also available on request. Customers are requested to read the same carefully. These terms have come into effect and are binding from 01 April 2017, with the existing contract being superseded on that day.",NormalFont));
								parabottom6new.add(new Paragraph("2. As intimated to you and where applicable, the monthly charges have been revised with effect from 1st April 2017." ,NormalFont));
								parabottom6new.add(new Paragraph("3. Our charges for Annual Service Contract for on-site support remain at Rs. 2000 / Rs. 3000 / Rs 4000 per annum per vehicle, for installation age <2 years / <5 years / < 7 years, payable in advance for the period, subject to the terms and condition of the ASC have been forwarded to you and also available on request. No ASC is available for ages > 7 years. Customers are encouraged to take on the service package. Customers not opting for an ASC do not get any benefit of deduction as per SLA for vehicles offline and are charged for the month.",NormalFont));
								parabottom6new.add(new Paragraph("4. Customers are requested and advised to keep their payments on schedule to avoid automatic barring of services." ,NormalFont));
								//parabottom6new.add(new Paragraph("5. Charges and invoices are due as specified on their face or as per the terms of the contract. Credit periods, unless specifically contracted for, with an appropriate deposit or other security, are not part of the offering. If you would like to avail of credit facilities, please contact us separately for documentation requirements." ,NormalFont));
								//parabottom6new.add(new Paragraph("6. Customers are requested and advised to keep their payments on schedule to avoid automatic barring of services." ,NormalFont));
								parabottom6new.setAlignment("Left");
								document.add(parabottom6new);
								
								
								
								
								
								
								
								

				
				
				
				document.close();

				//	DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
				byte[] bytes = buffer.toByteArray();
				//	response.setContentLength(bytes.length);
				for(int l = 0; l < bytes.length; l++)
				{
					//	    dataOutput.writeByte(bytes[l]);
				}

			}catch(Exception e)
			{
				e.printStackTrace();
			}
			finally
			{
				//response.getOutputStream().close();
			}	


		} catch (Exception e) {
			System.out.print("PdfGeneration Exception---->" + e);
		}

	}

	public  void PdfGenerationCustomeCode(String year,String month,String cust_id, String GroupName,String CMID, String usr, String UN) {
		CompanyMID=CMID;
		Emp_Name=usr;
		UNE=UN;
		System.out.println("Customer Id====>"+cust_id);
		System.out.println("Group Name====>"+GroupName);

		try {
			PdfGeneration pdfCall =new PdfGeneration(Emp_Name, UNE);

			PdfGeneration getConn=new PdfGeneration(Emp_Name, UNE);

			conn1 = getConn.GetConnection();

			//	String year="2014";
			//	String month="06";

			System.out.println(year+"  "+month);
			int monthdays=0;
			if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") )
			{monthdays=31;}

			if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
			{monthdays=30;}
			
			
			

			if(month.equals("02"))
			{monthdays=28;}

			int smonth = Integer.parseInt(month);
			System.out.println("Selected month in int is "+smonth);
			int syear = Integer.parseInt(year);
			System.out.println("Selected year in int is "+syear);
			int spreviousyear, spreviousmonth;
			if(smonth==1)
			{
				System.out.println("Selected month is 1"); 	 
				spreviousyear=syear-1;
				spreviousmonth=12;
				System.out.println("Selected previous year "+spreviousyear+"Selected previous month"+spreviousmonth);
				//	 	currentmonthcount=12;
			}
			else 
			{
				spreviousyear=syear;
				System.out.println("selected month  is "+smonth);
				spreviousmonth = smonth-1;
				System.out.println("Selected previous year is "+spreviousyear+"selected previous month is "+spreviousmonth);
			}




			Statement sterp = null, sterp1 = null, stgps = null, stgps1 = null,stgps2=null;
			Statement sterp2 = null;
			Statement sterp3=null,sterp4=null,sterp5=null,sterp6=null,sterp7=null,stchk=null, stqr=null;
			String selectedName,fpreviousmonth="";
			String FollowUpType = "",Group="", strcustomer = "", strgroupname = "";

			DecimalFormat twoDForm = new DecimalFormat("#.##");
			String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
			String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			int i=1;
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




			String customer="";
			String custname="";
			String yearNew="";
			String monthNew="";
			String groupname="";
			String vehiclenos="";
			String ratepervehicle="";
			String jrmcountNo="";
			String billtype="";
			String slacount="";
			String billdaysAll="";


			stchk=conn1.createStatement();

			sterp=conn1.createStatement();




			String checktb = "show tables like '"+CompanyMID+"billingdetails"+year+"_"+month+"'";
			System.out.println("Query is"+checktb);
			ResultSet rschk=stchk.executeQuery(checktb);
			//System.out.println("Resultset"+rschk.toString());
			//System.out.println("Resultset is"+rschk.next());
			System.out.println("After rschk"+rschk.next());
			//if(rschk.next())
			//	{

			// String sqldata= Select CustomerNameinERP as Customer,CustomerCodeinERP as CusromerCode,SLA,Amount,Amount/"+monthdays+" as ChargeperDay,count(vehid) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays from "+CompanyMID+"transporterbilldetailsnew  where month1='"+year+"-"+month+"-01' and "+CompanyMID+"billingdetails.Transporter = "+CompanyMID+"transporterbilldetailsnew.Ownername group by  "+CompanyMID+"billingdetails.Transporter;


			//  String sqldata="Select CustomerNameinERP as Customer,CustomerCodeinERP as CusromerCode,SLA,Amount,Amount/"+monthdays+" as ChargeperDay,count(db_gps.t_billingdetails.VehId) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays from db_gps."+CompanyMID+"transporterbilldetailsnew  where month1='"+year+"-"+month+"-01' and db_gps."+CompanyMID+"billingdetails.Transporter = db_gps."+CompanyMID+"transporterbilldetailsnew.Ownername group by  db_gps."+CompanyMID+"billingdetails.Transporter";

/*
			String sqldata="Select ERPCustName as Customer,ERPCode as CustomerCode,SLAPer,Rate,Rate/"+monthdays+" as ChargeperDay,"+
			"count("+CompanyMID+"billingdetails"+year+"_"+month+".vehID) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,"+
			"sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,"+
			"sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays ,"+
			"GroupName,BillType,sum(jrm) as jrmvehcount from "+CompanyMID+"fv_erp_relation"+year+"_"+month+" ,"+CompanyMID+"billingdetails"+year+"_"+month+" "+
			"where month1='"+year+"-"+month+"-01' and  "+CompanyMID+"fv_erp_relation"+year+"_"+month+".vehID = "+CompanyMID+"billingdetails"+year+"_"+month+".VehID  and "+
			""+CompanyMID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' group by   "+CompanyMID+"fv_erp_relation"+year+"_"+month+".ERPCustName,"+CompanyMID+"fv_erp_relation"+year+"_"+month+".groupcode limit 2";
			System.out.println("QUERY=====>"+sqldata);
			
			*/
			

			String sqldata="SELECT DAY(LAST_DAY(now() - INTERVAL 1 MONTH) ) AS 'LASTDAY',ERPCustName as Customer,ERPCode as CustomerCode,SLAPer,Rate,Rate/DAY(LAST_DAY(now() - INTERVAL 1 MONTH) ) as ChargeperDay,"+
			"count(distinct("+CompanyMID+"billingdetails"+year+"_"+month+".vehID)) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,"+
			"sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,"+
			"sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays ,"+
			"GroupName,BillType,sum(jrm) as jrmvehcount from "+CompanyMID+"fv_erp_relation"+year+"_"+month+" ,"+CompanyMID+"billingdetails"+year+"_"+month+" "+
			"where month1='"+year+"-"+month+"-01' and  "+CompanyMID+"fv_erp_relation"+year+"_"+month+".vehID = "+CompanyMID+"billingdetails"+year+"_"+month+".VehID  and "+
			""+CompanyMID+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and  "+CompanyMID+"fv_erp_relation"+year+"_"+month+".ERPCode='"+cust_id+"'    group by   "+CompanyMID+"fv_erp_relation"+year+"_"+month+".ERPCode,GroupName,"+CompanyMID+"fv_erp_relation"+year+"_"+month+".ERPCustName";
			System.out.println("QUERY===############==>"+sqldata);
			
		
		
			ResultSet rsData=sterp.executeQuery(sqldata);
			
int LASTDAYCOUNT=0;

			while(rsData.next())
			{
				
				LASTDAYCOUNT=rsData.getInt("LASTDAY");
				customer=rsData.getString("CustomerCode");
				strcustomer = rsData.getString("Customer");
				System.out.println("Customer before conversion is"+strcustomer);
				/*trptr = trptr.replace("&","^");*/
				strcustomer = strcustomer.replace("&","^");
				System.out.println("Customer after conversion is"+strcustomer);
				strgroupname = rsData.getString("GroupName");
				System.out.println("groupname before conversion is"+strgroupname);
				strgroupname = strgroupname.replace("&","^");
				System.out.println("groupname after conversion is"+strgroupname);
				custname=strcustomer;
				yearNew=year;
				monthNew=month;
				groupname=strgroupname;
				vehiclenos=rsData.getString("NoofVehicles");
				ratepervehicle=rsData.getString("Rate");
				jrmcountNo=rsData.getString("jrmvehcount");
				billtype=rsData.getString("BillType");
				slacount=rsData.getString("SLAPer");
				billdaysAll=rsData.getString("TotalBilledDays");
				
				System.out.println("VEH COUNTTT===>"+vehiclenos);

				pdfCall.PdfGenerationCall(LASTDAYCOUNT,customer, custname, yearNew, monthNew, groupname, vehiclenos, ratepervehicle, jrmcountNo, billtype, slacount, billdaysAll,CompanyMID);

			}

		//	pdfCall.CloseConnection();


			//	}


			System.out.println("Calling Function");
			//pdfCall.PdfGeneration(customer, custname, yearNew, monthNew, groupname, vehiclenos, ratepervehicle, jrmcountNo, billtype, slacount, billdaysAll);


		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	public static void main(String[] args) {

		PdfGeneration getConn=new PdfGeneration();

		conn1 = getConn.GetConnection();



		PdfGeneration pdf =new PdfGeneration();

		String year="2014";
		String month="09";
		pdf.PdfGenerationCustomeCode(year,month);

		getConn.CloseConnection();



	}
	*/

}