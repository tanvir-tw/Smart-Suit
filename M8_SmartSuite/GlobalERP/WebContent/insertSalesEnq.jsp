<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.util.concurrent.CopyOnWriteArrayList"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st=null,st4=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>
<%
boolean isInvoiceSelected=false;
try{
	
 
	
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st=con.createStatement();
	st4=con.createStatement();
	String customerRefNumber="",seRefNo="",dueDate="",enqDate="",enqTime="";
	int salesEnqNo=0;
	String remarks="",companyName="";
	
	
	Date today = new Date();
 
	enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	enqTime=new SimpleDateFormat("HH:mm:ss").format(today);
	
	java.text.DecimalFormat df = new java.text.DecimalFormat("000");
	seRefNo="SE";
	String date =  new SimpleDateFormat("ddMMyy").format(new Date());

	String sql1="SELECT SalesEnqRefNo,SalesEnqNo from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det  where SalesEnqRefNo like ('"+seRefNo+""+date+"%') ORDER BY SalesEnqRefNo DESC LIMIT 1";
	ResultSet rs=st1.executeQuery(sql1);
	if(rs.next())
		  seRefNo=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
	else
		  seRefNo+=date+"001";
	  
	sql1="SELECT max(SalesEnqNo)  from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det ";
	rs=st1.executeQuery(sql1);
	if(rs.next())
	salesEnqNo=rs.getInt(1)+1;
	  
	customerRefNumber=request.getParameter("customerRefNumber");
	dueDate=request.getParameter("fromdate");
	remarks=request.getParameter("remarks");
	if(remarks.length()>255)
		remarks=remarks.substring(0,254);
	
	String Code=request.getParameter("CustCode");
	
	System.out.println("Code :-"+Code);
	
	companyName=request.getParameter("companyName");
	
	//String sqlCustomerDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+companyName+"'";
	String sqlCustomerDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+Code+"'";
	System.out.println(sqlCustomerDetails);
	ResultSet rsCustomerdetails=st1.executeQuery(sqlCustomerDetails);
	rsCustomerdetails.next();
	String custcode=rsCustomerdetails.getString("CustomerCode");
	//custcode=Code;
	companyName=rsCustomerdetails.getString("CompanyName");
   
	
	String contactperson = rsCustomerdetails.getString("contactperson");
	System.out.println("contactperson ->"+contactperson);
	CopyOnWriteArrayList<Character> arrlist = new CopyOnWriteArrayList<Character>();
	   contactperson = contactperson.trim();
	   String cperson1="";
	   if(contactperson.contains("'"))
	   {	  
		      System.out.println("contact person contains single quotes");
	          char[] cp = contactperson.toCharArray();
	          int cntr=0;
	          for(int eye=0; eye<cp.length; eye++)
	          {
		         if(cp[eye]=='\'')
		         {
			       cntr++;  
		         }
	           }	   
	          System.out.println("number of single quotes in string is"+cntr);
	          for(int i=0; i<cp.length; i++)
	          {
		        arrlist.add(cp[i]);	
	          }	   
	          	         
	          StringBuilder builder = new StringBuilder(arrlist.size());
	          
	          for(Character ch: arrlist)
	          {	 		        	 		        	  		        	  
	        	  if(ch=='\'') 		        		 
		             { 
		               	 builder.append('\'');			                	 			                	 
		             }			       		        	  
	        	  builder.append(ch);		        	  		        	 
	          }			      		   
	       cperson1 = builder.toString();
	       System.out.println("contact after conversion is"+cperson1);
	   }		   
	   else
	   {
		   cperson1 = contactperson;
		   System.out.println("contact person doesn't contain single quote");
	   }   
	
  	
	
	String addcode="select AddressCode from "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet where CustomerCode='"+custcode+"'";
	ResultSet rsaddcode=st.executeQuery(addcode);
	rsaddcode.next();
	String addresscode=rsaddcode.getString("AddressCode");
	//System.out.println(salesEnqNo+customerRefNumber+seRefNo+dueDate+endDate+endTime+remarks+companyCity+companyName+companyPerson+companyEmail+companyProduct+companyPhone);
	
	String sqlInsert=" INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det ("+
			 "  SalesEnqNo,	SalesEnqDate,	SalesEnqTime,	SalesEnqDueDate,"+
			 "	CustomerCode,	CustRefNo,	CustRemarks,	SalesEnqType,	"+
			 "  TWEmpName,	SalesEnqClosed,	ReasonForClosing,	AddressCode,"+
			 "	CompanyName,	ContactPerson,	Address,	city,	Zip,	"+
			 "  State,	country,	Phone,	Fax ,	SalesEnqRefNo ) VALUES ("+
			 "	'"+salesEnqNo+"',"+
			 "	'"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enqDate))+"',"+
			 "	'"+enqTime+"',"+
			 "	'"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(dueDate))+"',"+
			 "	'"+custcode+"','"+customerRefNumber+"','"+remarks+"',"+
			 "	'0','"+session.getAttribute("EmpName")+"','0','-','"+addresscode+"',"+
			 "	'"+companyName+"','"+cperson1+"',"+
			 "	'"+rsCustomerdetails.getString("BillingAddress")+"','"+rsCustomerdetails.getString("BillingCity")+"',"+
			 "	'"+rsCustomerdetails.getString("BillingZip")+"','"+rsCustomerdetails.getString("BillingState")+"',"+
			 "	'"+rsCustomerdetails.getString("BillingCountry")+"','"+rsCustomerdetails.getString("BillingPhone")+"' ,"+
			 "	'"+rsCustomerdetails.getString("BillingFax")+"','"+seRefNo+"')";
	System.out.println(sqlInsert);
	st2.executeUpdate(sqlInsert);
	
	String sqlItems="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" "+
	" AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster AS b ON ( a.TheGroup = b.TheGroupCode ) ";
	ResultSet rsItems=st1.executeQuery(sqlItems);
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
		
		int icode=0;
		String item="SELECT itemcode from "+tableToBeAccessed+" WHERE description='"+rsItems.getString("description")+"' and PartNo='"+rsItems.getString("partno")+"' "+compareModel+" LIMIT 1"; 
		System.out.println("ITEM CODE IS >>>  "+item);
		ResultSet rsitm=st2.executeQuery(item);
		rsitm.next();
		icode=rsitm.getInt(1);		
		 
		
		
		String SqlInsertDetails=" INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items (SalesEnqNo , TheGroup ,	Make , ItemCode ,"+
				"	Quantity ,PriceQuoted ,	TheTableToBeAccessed ,	TheOptionNo , InsertOR,Description) VALUES "+
				"	( '"+salesEnqNo+"','"+rsItems.getString("TheGroup")+"','"+rsItems.getString("make")+"',"+
						"'"+icode+"',"+
						" '"+rsItems.getString("quantity")+"','0','"+tableToBeAccessed+"','0','-','"+rsItems.getString("description")+"' )";
		System.out.println(">>>>>   "+SqlInsertDetails);
		st3.executeUpdate(SqlInsertDetails);
		
	}
	    st4.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
		
	    response.sendRedirect("enqdet.jsp?companyName="+companyName+"&SalesEnqRefNo="+seRefNo+"&SalesEnqNo="+salesEnqNo);
        
        con.close();	
 		
}catch(Exception e){
System.out.println( "Exception ::"+e );
response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	
}
%>
