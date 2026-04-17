
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String export = request.getParameter("export").trim();
%>

<%
boolean isInvoiceSelected=false;
try{
	 
	
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	
	String customerRefNumber="",seRefNo="",PenqDate="",PenqTime="";
	int salesEnqNo=0;
	int number;
	int supcode=0;
	String remarks="",companyName="";
	String eachsupplier ="";
	Date today = new Date();
	int count=0;
 	int eachcount=0;
	PenqDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	PenqTime=new SimpleDateFormat("HH:mm:ss").format(today);
	
	String remark=request.getParameter("remarks");
	String duedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	
	int PEnqNO;
	String penqno="select MAX(PurchaseEnqNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq";
	System.out.println("penqno is :  "+penqno);
	ResultSet rs=st1.executeQuery(penqno);
	rs.next();
		PEnqNO=rs.getInt(1);
	PEnqNO++;
	
	String twrefno = "";
	if(export.equals("Yes"))
	{
		 twrefno="TW/EXPSE:0/PUR:";
	}else
	{
		 twrefno="TW/SE:0/PUR:";
	}
	
	twrefno+=PEnqNO;
	String twrefno1=twrefno;
	String sup=request.getParameter("supplier");
	System.out.println("SUPPLIERS ARE>>>>>:   "+sup);
	StringTokenizer singlesup=new StringTokenizer(sup,",");
	count=singlesup.countTokens();
	System.out.println("Count is:   "+count);
	
	for(int i=1;i<=count;i++)
	{	
		//eachcount=eachcount+count;
		//count++;
		twrefno="";
		System.out.println("COUNT IS  "+i);
		
		
		twrefno=twrefno1+"/"+i;
		System.out.println("NO IS    *****  "+twrefno);
		if(singlesup.hasMoreTokens())
		{
			
		try{	
		eachsupplier =singlesup.nextToken();
		System.out.println("Single supplier is:"+eachsupplier);
		
		String sqlcode="select SupplierCode from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName='"+eachsupplier+"' ";		
		ResultSet rscode=st1.executeQuery(sqlcode);
		rscode.next();
		supcode=rscode.getInt(1);
		System.out.println(">>>>>>sqlcode:"+sqlcode);
		
		String insertEnquiry="Insert into "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq (PurchaseEnqNo ,Suppliercode ,SalesEnqNo ,TWRefNo ,PurEnqDate ,Remarks ,DueDate ,SentBy ,PurEnqTime ,SalesenqRecvdDate ,SalesenqRecvdTime ,QuoReceived ,PurEnqClosed ,reasonForClosing ,ModeOfDelivery ,DateOfDelivery) "+
							 "values('"+PEnqNO+"','"+supcode+"','0','"+twrefno+"','"+PenqDate+"','"+remark+"','"+duedate+"','"+session.getAttribute("EmpName")+"','"+PenqTime+"','0000-00-00','00:00:00','0','0','-','-','	0000-00-00')";
		System.out.println(">>>>insertEnquiry:"+insertEnquiry);//TheGroup ,Make ,ItemCode ,Quantity
		int x=st2.executeUpdate(insertEnquiry);
		
		}catch(Exception e)
		{
			out.println(e.getMessage());
		}
		
		
		}
	}
	
	
	if(count > 0)
	{	
		String sqlItems="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" "+
		" AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster AS b ON ( a.TheGroup = b.TheGroupCode ) ";
		ResultSet rsItems=st1.executeQuery(sqlItems);
		System.out.println(">>>>sqlItems:"+sqlItems);
		Statement st_del=con.createStatement();
		while(rsItems.next())
			{
				String tableToBeAccessed="";
				if(rsItems.getInt("TheGroup")<5)
				  tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+rsItems.getString("TheGroupName").substring(0,5).toLowerCase()+"im_make"+rsItems.getString("make")+"";
				else 
					tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+rsItems.getString("TheGroup");
				
				String compareModel= "";
				boolean modelNotKnown=rsItems.getBoolean("modelNotKnown");
				if(!modelNotKnown)
					compareModel=" AND model ='"+rsItems.getString("model")+"'  ";
				
				System.out.println("tableToBeAccessed:"+tableToBeAccessed);
				int itmcd=0;
				String item="SELECT itemcode from "+tableToBeAccessed+" WHERE description='"+rsItems.getString("description")+"' "+compareModel+" LIMIT 1";
				System.out.println("item>>>>>>"+item);
				ResultSet rsitm=st2.executeQuery(item);
				if(rsitm.next()){
				itmcd=rsitm.getInt(1);
				}
				System.out.println("Beloo");
				
				String insertIntoItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"enquireditems (PurchaseEnqNo ,TheGroup ,Make ,ItemCode ,Quantity ,RecommendedSupp ,TheTableToBeAccessed) "+
				"values('"+PEnqNO+"','"+rsItems.getString("TheGroup")+"','"+rsItems.getString("make")+"',"+
				" '"+itmcd+"' ,"+
				"'"+rsItems.getString("quantity")+"','-','"+tableToBeAccessed+"')";
				System.out.println(">>>>>>>insertIntoItems:"+insertIntoItems);
		        int x=st3.executeUpdate(insertIntoItems);
		        if(x>0){
					String del="delete from "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","")+" where TheGroup="+rsItems.getString("TheGroup")+" AND make="+rsItems.getString("make")+" AND description='"+rsItems.getString("description")+"'";
					System.out.println(del);
					int y=st_del.executeUpdate(del);
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
		int x=st4.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
		if(x>0){
			System.out.println("Temp table deleted");
		}
		 System.out.println("------last---"+"TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
	}//end of if	
	
	
	response.sendRedirect("alert.jsp?msg=Purchase Enq added successfully in "+
    		"System  .&goto=AllPurchaseModule.jsp");
    
	
}catch(Exception e){
	System.out.println( "Exception ::"+e );
	//response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");

	}
finally
{
	con.close();
		
}
	%>

	
	