<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st=null,st1=null,st2=null,st3=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String export = request.getParameter("export").trim();

String SystemName = request.getParameter("system");
%>

<%
boolean isInvoiceSelected=false;
try{
	 
	
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	
	String customerRefNumber="",seRefNo="",PenqDate="",PenqTime="";
	String tableToBeAccessed="",itemDiscription="";
	String data="";
	int salesEnqNo=0;
	int number;
	String supname="";
	String TheGroup="",Make="",ItemCode="";
	String PRN_RefNo = "";
	String eachsupplier ="";
	Date today = new Date();
	int count=0;
 	int eachcount=0;
	PenqDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	PenqTime=new SimpleDateFormat("HH:mm:ss").format(today);
	String name = session.getAttribute("EmpName").toString();
	
	String EntryBy = session.getAttribute("EMP_FullNAME").toString();
	
	String specification=request.getParameter("Specifications");
	String model = request.getParameter("model");
	String partNo = request.getParameter("partNo");
	System.out.println("In specification>>>>>>>>   "+specification);
	if(specification==null|| specification.equals("null"))
	{
		specification="-";
	}
	if(model==null || model.equals("null"))
	{
		model="-";
	}
	if(partNo==null || partNo.equals("null"))
	{
		partNo="-";
	}
	
	
	String remark=request.getParameter("remarks");
	//String duedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	
	/* int PEnqNO=0;
	java.text.DecimalFormat df = new java.text.DecimalFormat("000");
	String todaysDate1=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
	String penqno="select MAX(PRNNo) from "+session.getAttribute("CompanyMasterID").toString()+"PRNMaster";
	System.out.println("penqno is :  "+penqno);
	ResultSet rs=st1.executeQuery(penqno);
	rs.next();
		PEnqNO=rs.getInt(1);
		PEnqNO++;

	
	
	if(export.equals("Yes"))
	{
		PRN_RefNo="TW/PS/";
	}else
	{
		PRN_RefNo="TW/PS/";
	}
	PRN_RefNo=PRN_RefNo+""+todaysDate1; */
	String PEnqNO="";
    java.text.DecimalFormat df = new java.text.DecimalFormat("000");

    try{
       
        Date todaysDate1 = new Date();
         
        PEnqNO="PRN";

        String date =  new SimpleDateFormat("ddMMyy").format(new Date());

        String penqno="SELECT PRN_RefNo  from "+session.getAttribute("CompanyMasterID").toString()+"PRNMaster  where PRN_RefNo like ('"+PEnqNO+""+date+"%') ORDER BY PRN_RefNo DESC LIMIT 1";
            ResultSet rs=st1.executeQuery(penqno);
            System.out.println(penqno);    
          if(rs.next())
              PEnqNO=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
          else
              PEnqNO+=date+"001";
         
    }catch(Exception e){
    e.printStackTrace();       
    }
	
	String twrefno1=PRN_RefNo;
	String sup=request.getParameter("supplier");
	System.out.println("SUPPLIERS ARE>>>>>:   "+sup);
	
	StringTokenizer singlesup = null;
	
	data = data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
			"<body><table    border=^0^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
			"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
			"</a></td>"+
			"<td  align = ^right^ ></td></tr></table> <font style=^color: #D8D8D8^>"+
			"<img src=DatabaseAccess?id="+session.getAttribute("CompanyMasterID").toString()+" align=^left^ height=^50^ width=^200^></img>"+
			"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
			""+ new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) +"<br>"+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
			data= data + 
		"<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial><b> Purchase Requisition Entry- "+PEnqNO+" By "+EntryBy+" </b></font></br></td></tr></table></td></tr>"+
		"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=170% border=1 style=^border-collapse: collapse^>"+
		
		"<tr bgcolor=^#ADDFFF^><td align=^center^><font size=^2^ face=^arial^><b>Sr</b></font></td>"+
		"<td align=center><font size=^2^ face=^arial^><b>  Description </b></font></td>"+
		"<td align=center><font size=^2^ face=^arial^><b> Quantity </b></font></td>"+
		"<td align=center><font size=^2^ face=^arial^><b> Project Name  </b></font></td>"+
		
		"</tr>";
	
	
	
	if(sup!=null){
	
	
	singlesup=new StringTokenizer(sup,",");
	count=singlesup.countTokens();
	System.out.println("Count is:   "+count);
	
	}else{
		sup="-";
		eachsupplier="-";
		count=0;
	}
	
	//String insertEnquiry="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNMaster (SupplierName ,PRN_RefNo) values('"+sup+"','"+PEnqNO+"')";
	String insertEnquiry="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNMaster (SupplierName ,PRN_RefNo,EntryBy,System_name,EntryDate) values('"+sup+"','"+PEnqNO+"','"+EntryBy+"','"+SystemName+"',NOW())";
	
	System.out.println(">>>>insertEnquiry:"+insertEnquiry);//TheGroup ,Make ,ItemCode ,Quantity
	int x=st2.executeUpdate(insertEnquiry);
	 System.out.println("executeupdate ================:  "+x);
	
	System.out.println("in for  ==========:  ");
	
	
	
	for(int i=1;i<=count && sup!=null ;i++)
	{	
		
		//eachcount=eachcount+count;
		//count++;
		//PRN_RefNo="";
		System.out.println("COUNT IS  "+i);
		
		
		PRN_RefNo=twrefno1+"/"+i;
		System.out.println("NO IS    *****  "+PRN_RefNo);
		if(singlesup.hasMoreTokens())
		{
			
		try{	
		eachsupplier =singlesup.nextToken();
		System.out.println("Single supplier is:"+eachsupplier);
		
		String sqlcode="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName='"+eachsupplier+"' ";		
		ResultSet rsname=st1.executeQuery(sqlcode);
		rsname.next();
		supname=rsname.getString(1);
		System.out.println(">>>>>>sqlcode:"+sqlcode);
		
		System.out.println("in insert ================:  ");
		
		
		 
		System.out.println("out insert ================:  ");
		
		
		 
		
		}catch(Exception e)
		{
			out.println(e.getMessage());
		}
		}
		
	}
	
	
	    String Specifications ="";
	    int counter=1;

		/*String sqlItems="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" "+
		" AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster AS b ON ( a.TheGroup = b.TheGroupCode ) ";*/
		String sqlItems="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","")+"_PRN "+
				" AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster AS b ON ( a.TheGroup = b.TheGroupCode ) ";
		ResultSet rsItems=st1.executeQuery(sqlItems);
		System.out.println(">>>>sqlItems:"+sqlItems);
		Statement st_del=con.createStatement();
		while(rsItems.next())
			{
			
			    specification = rsItems.getString("Specifications");
			    SystemName = rsItems.getString("System_name");
				
				if(rsItems.getInt("TheGroup")<5)
					tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+rsItems.getString("TheGroupName").substring(0,5).toLowerCase()+"im_make"+rsItems.getString("make")+"";
				else 
					tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+rsItems.getString("TheGroup");
				
				String compareModel= "";
				boolean modelNotKnown=rsItems.getBoolean("modelNotKnown");
				if(!modelNotKnown)
					compareModel=" AND model ='"+rsItems.getString("model")+"'  ";
				
				System.out.println("tableToBeAccessed:"+tableToBeAccessed);
				String itmcd="";
				String item="SELECT itemcode from "+tableToBeAccessed+" WHERE description='"+rsItems.getString("description")+"' "+compareModel+" LIMIT 1";
				System.out.println("item>>>>>>"+item);
				ResultSet rsitm=st2.executeQuery(item);
				if(rsitm.next()){
				itmcd=rsitm.getString(1);
				}
				System.out.println("Beloo");
				
				data= data + "<tr><td align=left><font size=^2^ face=^arial^>"+counter+"</font></td>"+
						         "<td align=right><font size=^2^ face=^arial^>"+rsItems.getString("description")+"</font></td>"+
								 "<td align=left><font size=^2^ face=^arial^>"+rsItems.getString("quantity")+"</font></td>"+
								 "<td align=right><font size=^2^ face=^arial^>"+SystemName+"</font></td></tr>";
					
				counter++;
				
				/* String insertIntoItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster (PRN_RefNo,TheGroup,Make,ItemCode,Model,Partno,Quantity,SupplierName,TheTableToBeAccessed,ItemDescription,Specifications,EntryBy) "+
				"values('"+PRN_RefNo+"','"+rsItems.getString("TheGroup")+"','"+rsItems.getString("make")+"',"+
				" '"+itmcd+"' ,'"+rsItems.getString("model")+"','"+partNo+"' "+
				"'"+rsItems.getString("quantity")+"','"+eachsupplier+"','"+tableToBeAccessed+"','"+rsItems.getString("description")+"','"+specification+"','"+name+"')";
			 */
			 
		//	   String insertIntoItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster(PRN_RefNo,TheGroup,Make,ItemCode,Model,Partno,Quantity,SupplierName,TheTableToBeAccessed,ItemDescription,Specifications,EntryBy,UpdatedDateTime)values('"+PEnqNO+"','"+rsItems.getString("TheGroupName")+"','"+rsItems.getString("make")+"','"+itmcd+"','"+rsItems.getString("model")+"','"+partNo+"','"+rsItems.getString("quantity")+"','"+eachsupplier+"','"+tableToBeAccessed+"','"+rsItems.getString("description")+"','"+specification+"','"+name+"',NOW())";
			//   String insertIntoItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster(PRN_RefNo,TheGroup,Make,ItemCode,Model,Partno,Quantity,SupplierName,TheTableToBeAccessed,ItemDescription,Specifications,EntryBy,System_name)values('"+PEnqNO+"','"+rsItems.getString("TheGroupName")+"','"+rsItems.getString("make")+"','"+itmcd+"','"+rsItems.getString("model")+"','"+partNo+"','"+rsItems.getString("quantity")+"','"+eachsupplier+"','"+tableToBeAccessed+"','"+rsItems.getString("description")+"','"+specification+"','"+EntryBy+"','"+SystemName+"')";
			   String insertIntoItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster(PRN_RefNo,TheGroup,Make,ItemCode,Model,Partno,Quantity,SupplierName,TheTableToBeAccessed,ItemDescription,Specifications,EntryBy,System_name)values('"+PEnqNO+"','"+rsItems.getString("TheGroup")+"','"+rsItems.getString("make")+"','"+itmcd+"','"+rsItems.getString("model")+"','"+partNo+"','"+rsItems.getString("quantity")+"','"+eachsupplier+"','"+tableToBeAccessed+"','"+rsItems.getString("description")+"','"+specification+"','"+EntryBy+"','"+SystemName+"')";
			 System.out.println(">>>>>>>insertIntoItems:"+insertIntoItems);
				
				  x=st3.executeUpdate(insertIntoItems);
		        if(x>0){
					/*String del="delete from "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","")+" where TheGroup="+rsItems.getString("TheGroup")+" AND make="+rsItems.getString("make")+" AND description='"+rsItems.getString("description")+"'";*/
					String del="delete from "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","")+"_PRN where TheGroup="+rsItems.getString("TheGroup")+" AND make="+rsItems.getString("make")+" AND description='"+rsItems.getString("description")+"'";
					System.out.println(del);
					int y=0;
					y=st_del.executeUpdate(del);
					 if(y>0){
						System.out.println("Deleted from tmp table");
					}else{
						System.out.println("Not Deleted from tmp table");
					}
				}
				
				
			/* 	String SqlInsertDetails=" INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items (SalesEnqNo , TheGroup ,	Make , ItemCode ,"+
						"	Quantity ,PriceQuoted ,	TheTableToBeAccessed ,	TheOptionNo , InsertOR,Description) VALUES "+
						"	( '"+salesEnqNo+"','"+rsItems.getString("TheGroup")+"','"+rsItems.getString("make")+"',"+
								"(SELECT itemcode from "+tableToBeAccessed+" WHERE description='"+rsItems.getString("description")+"' "+compareModel+" LIMIT 1),"+
								" '"+rsItems.getString("quantity")+"','0','"+tableToBeAccessed+"','0','-','"+rsItems.getString("description")+"' )";
				System.out.println(">>>>>   "+SqlInsertDetails);
				st3.executeUpdate(SqlInsertDetails);*/
			
			}
		System.out.println("------1st---");
		Statement st4=con.createStatement();
		Statement st5=con.createStatement();
		 x=0;
		 
		    data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";
            data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
			data= data + "</tr></body></html>";
		 
		// x=st4.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
		 x=st4.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"_PRN");
		if(x>0){
			System.out.println("Temp table deleted");
		}
		 System.out.println("------last---"+"TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"_PRN");

		 String sqlinsrt = "insert into db_GlobalERP.t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('TWSupport','Purchase Requisition Entry','" + data + "','Purchase Requisition Entry Intimation','purchase@twtech.in','avlsupport@mobile-eye.in',NOW(),'Pending','Transworld','','')";  
		 System.out.println("insert--->"+sqlinsrt);
		 st5.executeUpdate(sqlinsrt);
	
	response.sendRedirect("alert.jsp?msg=Purchase PRN Enuquiry added successfully in "+"System  .&goto=PurchaseRequisitionEnquiryReport.jsp");
    
	
}catch(Exception e){
	System.out.println( "Exception ::"+e );
	//response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");

	}
finally
{
	con.close();
		
}
	%>

	
	
