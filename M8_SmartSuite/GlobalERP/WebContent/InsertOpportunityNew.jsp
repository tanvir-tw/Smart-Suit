<%@ include file="conn.jsp"%>
<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"
	import="javax.mail.Session"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page
	import="java.util.Date, 
javax.activation.DataSource,         
javax.activation.FileDataSource,     
javax.mail.Address,                  
javax.mail.BodyPart,                 
javax.mail.Message,                  
javax.mail.Multipart,                
javax.mail.Session,                  
javax.mail.Transport,                
javax.mail.internet.InternetAddress, 
javax.mail.internet.MimeBodyPart,    
javax.mail.internet.MimeMessage,     
javax.mail.internet.MimeMultipart,
 java.io.File,                  
 java.io.FileNotFoundException, 
 java.io.FileOutputStream,      
 java.io.IOException,           
 java.text.ParseException"%>
<%! 
Connection con ;
String custName="";
String CustomerCode="";
%>
<%try{
		int customerCode=0;	
		int customerCons=0;
		
		System.out.println("User->>"+session.getAttribute("EmpName"));
        String repName=request.getParameter("repName");       
        String vendor=request.getParameter("vendorcode");
        System.out.println("VENDOR CODE  IS *****************     "+vendor);
        System.out.println("Repre IS *****************     "+repName);  
        custName=request.getParameter("custName"); 
        custName=custName.replaceAll("'", "''");
        System.out.println("Customer IS *****************     "+custName);
        String companyafteredit=request.getParameter("companyNameafteredit");
        System.out.println("COMPANY AFTER EDIT IS      *****************     "+companyafteredit);
        
        String consigner=request.getParameter("consigner");
        String cosignercontact=request.getParameter("spokento123");
        String cosigneecontact=request.getParameter("spokento12345");
        
        String Liaison=request.getParameter("Liaison");
        String LiaisonContact=request.getParameter("Liaison12345");

        String ELiaison=request.getParameter("editLiaison");
        String ELiaisonContact=request.getParameter("ELiaison12345");
        
       // consigner= consigner.replaceAll("'", "''");
       
       System.out.println("Consignor Contact---------"+cosignercontact+"---------Consignee Contact---------"+cosigneecontact);
        if(consigner==null){
         consigner=request.getParameter("consigner1");
         consigner= consigner.replaceAll("'", "''");
        }
        System.out.println("Consigner  IS*****"+consigner);
        
        String consignee=request.getParameter("consignee");
        if( consignee==null ){
        	 consignee=request.getParameter("consignee1");
        	 consignee= consignee.replaceAll("'", "''");
        }
        
        
        System.out.println("Consignee  IS*****"+consignee);
        
        
        String origin=request.getParameter("origin");
        
        
        if( origin==null){
        	
         origin=request.getParameter("startplace");
         
        }
        String destination=request.getParameter("dest");
        if( destination==null){
        	
         destination=request.getParameter("endplace");
        }
        System.out.println("Origin  IS*****"+origin);
        
        System.out.println("Destination  IS*****"+destination);
        
        
        String frttype=request.getParameter("frt");
        if( frttype==null){
        	
            frttype=request.getParameter("frttype");
            frttype= frttype.replaceAll("'", "''");
           }
        
        System.out.println(" FRT Type *****"+frttype);
        
        
        
        
        String ColloectionStaffName=request.getParameter("collectionstaff");
        System.out.println("ColloectionStaffName--------------------------------------------------------------------------------------" + ColloectionStaffName);
        
        String trans=request.getParameter("trans");
        if(trans==null){
        	trans=request.getParameter("trans1");
        	trans= trans.replaceAll("'", "''");
        }
        
        String Status=request.getParameter("status");
        
        String monthval=request.getParameter("mvt");                  
        String product=request.getParameter("product");
        
        if( product==null )
        {
        	 product=request.getParameter("products");
        	 product= product.replaceAll("'", "''");
        }	
        System.out.println("Product is"+product);
        
     
        String risk=request.getParameter("risk");     
        if( risk==null){
         risk=request.getParameter("riskinv");
         risk= risk.replaceAll("'", "''");
        }
        System.out.println("Risk is"+risk);
        
        String loadRef=request.getParameter("load");
        loadRef= loadRef.replaceAll("'", "''");
        String comm=request.getParameter("comm");
        String remark=request.getParameter("remark");
        remark= remark.replaceAll("'", "''");
        System.out.println("Load Reference is-->"+loadRef);
        System.out.println("Commision  is-->"+comm);
        System.out.println("Remark is-->"+remark);
        
        
        
        String branch=request.getParameter("branch");
        if( branch==null )
        {
        	branch=request.getParameter("branch1");
        	branch= branch.replaceAll("'", "''");
        }	
        
        System.out.println("BranchName"+branch);
        
        String billbranch=request.getParameter("billbranch");
        if( billbranch==null )
        {
        	billbranch=request.getParameter("billbranch1");
        	billbranch= billbranch.replaceAll("'", "''");
        }	
        
        System.out.println("Billing BranchName"+billbranch);
        
        String fromdate=request.getParameter("fromdate");     
        String todate=request.getParameter("todate"); 
        String from = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
        String to = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
    
        System.out.println("Fromdate"+fromdate);
        System.out.println("todate"+todate);
		
        System.out.println("From ->"+from);
        System.out.println("To->"+to);
        String loadType=request.getParameter("loadType");
        if( loadType==null){
            loadType=request.getParameter("loadType1");
           }
        System.out.println("Load Type"+loadType);
		
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		Statement stmt2=con.createStatement();
		Statement stmt3=con.createStatement();
		Statement stmt4=con.createStatement();
		Statement stmt5=con.createStatement();
		Statement stmt6=con.createStatement();
		Statement stmt7=con.createStatement();
		Statement stmt8=con.createStatement();
		Statement stmt9=con.createStatement();
		Statement stmt10=con.createStatement();
		Statement st=con.createStatement();
		Statement st1=con.createStatement();
		Statement st2=con.createStatement();
		Statement st3=con.createStatement();
		Statement st4=con.createStatement();
		Statement st5=con.createStatement();
		Statement st6=con.createStatement();
		Statement st7=con.createStatement();
		Statement st8=con.createStatement();
		Statement st9=con.createStatement();
		ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null;
		String check1="",check2="",check3="",check4="",check5="",check6="",check7="",check8="",check9="",check10="";
		
	/*	if(request.getParameter("empName")!=null)
			repName=request.getParameter("empName"); */
									                         
				
		
		System.out.println("22222222222222222222222  ");
		String repcode="";

		try{
		/* String sqlrepcode="Select MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
		 System.out.println(sqlrepcode);
			 
	     ResultSet rscode=stmt1.executeQuery(sqlrepcode);
	     rscode.next();   
		  repcode=rscode.getInt("MarketingRepCode");				
			System.out.println("233333333333   3333333333  "+repcode);*/
		
}catch(Exception e)
{
	e.printStackTrace();
}
String sqlInsert="",sqlInsert1="",sqlInsert2="",sqlInsert3="",sqlInsert4="",sqlInsert5="",sqlInsert6="",sqlInsert7="",sqlInsert8="",sqlInsert9="",sqlInsert10="",sqlInsert11="";

		
			
			
			
		String id=request.getParameter("Id");	
			
			
			if(request.getParameter("update").equals("update") || request.getParameter("update")=="update" ) 
			{
				
				if(consigner.equals("Select") || consigner == "Select"){
					consigner="-";
					}
				if(ColloectionStaffName.equals("Select") || ColloectionStaffName == "Select"){
					ColloectionStaffName="-";
					}
					if(consignee.equals("Select") || consignee == "Select"){
						consignee="-";
						}
					if(cosignercontact.equals("Select") || cosignercontact == "Select"){
						cosignercontact="-";
						}
					if(cosigneecontact.equals("Select") || cosigneecontact == "Select"){
						cosigneecontact="-";
						}
					if(LiaisonContact.equals("Select") || LiaisonContact == "Select"){
						LiaisonContact="-";
						}
					if(Liaison.equals("Select") || Liaison == "Select"){
						Liaison="-";
						}
					
					if(branch.equals("Select") || branch == "Select"){
						branch="-";
						}
					if(origin.equals("Select") || origin == "Select"){
						origin="-";
						}
					if(destination.equals("Select") || destination == "Select"){
						destination="-";
						}
					if(loadType.equals("Select") || loadType == "Select"){
						loadType="-";
						}
					if(frttype.equals("Select") || frttype == "Select"){
						frttype="-";
						}
					if(product.equals("Select") || product == "Select"){
						product="-";
						}
					if(trans.equals("Select") || trans == "Select"){
						trans="-";
						}
					if(risk.equals("Select") || risk == "Select"){
						risk="-";
						}
				
					/*finding max of customer code for adding consinger as prospect  */
				String sqlCode="SELECT MAX(CustomerCode) as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster ";
				ResultSet rsCode=stmt.executeQuery(sqlCode);
				if(rsCode.next())
					{
					customerCode=rsCode.getInt("a")+1;
					
					}
				
				sqlInsert = "update  "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster set customer='"+custName+"',branchName='"+branch+"',consigner='"+consigner+"',consignee='"+consignee+"',locationFrom='"+origin+"', locationTo='"+destination+"',frttype='"+frttype+"', monthVal='"+monthval+"',product='"+product+"',loadRef='"+loadRef+"',existTrans='"+trans+"', validFrom='"+from+"', validTo='"+to+"',riskInvolved='"+risk+"',markRep='"+repName+"',commission='"+comm+"',remark='"+remark+"',loadType='"+loadType+"',EntryBy='"+session.getAttribute("EmpName")+"',billBranch='"+billbranch+"', ColloectionStaffName='"+ColloectionStaffName+"',ConsignerContact='"+cosignercontact+"',ConsigneeContact='"+cosigneecontact+"',status='"+Status+"',LiaisonContact='"+LiaisonContact+"',LiaisonOfficer='"+Liaison+"' where srno='"+id+"' ";
				System.out.println("sqlUpdate"+sqlInsert);
				stmt.executeUpdate(sqlInsert);
				 check1="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+consigner+"' ";
				 rs=st.executeQuery(check1);
				
				 if(rs.next()){
					
				}else{
					
				sqlInsert1="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CompanyName,CustomerCode) VALUES ('"+consigner+"','"+customerCode+"') ";
				stmt1.executeUpdate(sqlInsert1);
				
				}
				System.out.println("sqlInsert1"+sqlInsert1);
				 check2="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+consignee+"' ";
				 rs1=st1.executeQuery(check2);
				if(rs1.next()){
				}else
				{
					/*finding max of customer code for adding consignee as prospect  */
					String sqlCons="SELECT MAX(CustomerCode) as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster ";
					ResultSet rsCons=stmt.executeQuery(sqlCode);
					if(rsCons.next())
					{
					customerCons=rsCons.getInt("a")+1;
					} 
					
				sqlInsert2="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CompanyName,CustomerCode) VALUES ('"+consignee+"','"+customerCons+"') ";
				stmt2.executeUpdate(sqlInsert2);
				}
				System.out.println("sqlInsert2"+sqlInsert2);
				 check3="select * from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where City='"+origin+"' ";
				 rs2=st2.executeQuery(check3);
				if(rs2.next()){
				}else{
				sqlInsert3="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City) VALUES ('"+origin+"') ";
				stmt3.executeUpdate(sqlInsert3);
				}
				System.out.println("sqlInsert3"+sqlInsert3);
				
				 check4="select * from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where City='"+destination+"' ";
				 rs3=st3.executeQuery(check4);
				if(rs3.next()){
				}else{
				sqlInsert4="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City) VALUES ('"+destination+"') ";
				stmt4.executeUpdate(sqlInsert4);
				}
				System.out.println("sqlInsert4"+sqlInsert4);
				check5="select * from "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster where loadType='"+loadType+"' ";
				 rs4=st4.executeQuery(check5);
				if(rs4.next()){
				}else{
				sqlInsert5="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster(EntryBy,loadType) VALUES ('"+session.getAttribute("EmpName")+"','"+loadType+"') ";
				stmt5.executeUpdate(sqlInsert5);
				}
				System.out.println("sqlInsert5"+sqlInsert5);
				 check6="select * from "+session.getAttribute("CompanyMasterID").toString()+"freightMaster where frtType='"+frttype+"' ";
				 rs5=st5.executeQuery(check6);
				if(rs5.next()){
				
				}else{
				sqlInsert6="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"freightMaster(EntryBy,frtType) VALUES ('"+session.getAttribute("EmpName")+"','"+frttype+"') ";
				stmt6.executeUpdate(sqlInsert6);
				}
				System.out.println("sqlInsert6"+sqlInsert6);
				
				 check7="select * from "+session.getAttribute("CompanyMasterID").toString()+"productMaster where product='"+product+"' ";
				 rs6=st6.executeQuery(check7);
				if(rs6.next()){
				}else{
				sqlInsert7="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"productMaster(EntryBy,product) VALUES ('"+session.getAttribute("EmpName")+"','"+product+"') ";
				stmt7.executeUpdate(sqlInsert7);
				}
				System.out.println("sqlInsert7"+sqlInsert7);
				 check8="select * from "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster where riskInvolved='"+risk+"'";
				 rs7=st7.executeQuery(check8);
				if(rs7.next()){
				}else{
				sqlInsert8="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster(EntryBy,riskInvolved) VALUES ('"+session.getAttribute("EmpName")+"','"+risk+"') ";
				stmt8.executeUpdate(sqlInsert8);
				}
				System.out.println("sqlInsert8"+sqlInsert8);
				
				check9="select * from "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster where BranchName='"+branch+"'";
				rs8=st8.executeQuery(check9);
				if(rs8.next()){
				}else{
					sqlInsert9="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster(EntryBy,BranchName) VALUES ('"+session.getAttribute("EmpName")+"','"+branch+"') ";
				stmt9.executeUpdate(sqlInsert9);
				}
				System.out.println("sqlInsert9"+sqlInsert9);
				
				check10="select * from "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster where BranchName='"+billbranch+"'";
				rs9=st9.executeQuery(check10);
				if(rs9.next()){
				}else{
					sqlInsert10="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster(EntryBy,BranchName) VALUES ('"+session.getAttribute("EmpName")+"','"+billbranch+"') ";
				stmt10.executeUpdate(sqlInsert10);
				}
				System.out.println("sqlInsert10"+sqlInsert10);
				
				
			}
					 
			else
		{ 
			if(consigner.equals("Select") || consigner == "Select"){
			consigner="-";
			}
			if(consignee.equals("Select") || consignee == "Select"){
				consignee="-";
				}
			if(ColloectionStaffName.equals("Select") || ColloectionStaffName == "Select"){
				ColloectionStaffName="-";
				}
			if(cosignercontact.equals("Select") || cosignercontact == "Select"){
				cosignercontact="-";
				}
			if(cosigneecontact.equals("Select") || cosigneecontact == "Select"){
				cosigneecontact="-";
				}
			
			if(LiaisonContact.equals("Select") || LiaisonContact == "Select"){
				LiaisonContact="-";
				}
			if(Liaison.equals("Select") || Liaison == "Select"){
				Liaison="-";
				}
			
			if(branch.equals("Select") || branch == "Select"){
				branch="-";
				}
			if(origin.equals("Select") || origin == "Select"){
				origin="-";
				}
			if(destination.equals("Select") || destination == "Select"){
				destination="-";
				}
			if(loadType.equals("Select") || loadType == "Select"){
				loadType="-";
				}
			if(frttype.equals("Select") || frttype == "Select"){
				frttype="-";
				}
			if(product.equals("Select") || product == "Select"){
				product="-";
				}
			if(trans.equals("Select") || trans == "Select"){
				trans="-";
				}
			if(risk.equals("Select") || risk == "Select"){
				risk="-";
				}
			
			/*finding max of customer code for adding consigner as prospect  */
				/* String sqlCode="SELECT MAX(CustomerCode) as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
				ResultSet rsCode=stmt.executeQuery(sqlCode);
				if(rsCode.next())
				{
					customerCode=rsCode.getInt("a")+1;
					
				} */
				
				
				
				CustomerCode=request.getParameter("customercode1");
				
				sqlInsert = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster(customer,branchName,customer_code,consigner,consignee,locationFrom, locationTo,frttype,monthVal,product,loadRef,existTrans, validFrom, validTo,riskInvolved,markRep,commission,remark,loadType,EntryBy,billBranch, ColloectionStaffName,ConsignerContact,ConsigneeContact,LiaisonOfficer,LiaisonContact) VALUES "+
		        		"	('"+custName+"','"+branch+"','"+CustomerCode+"','"+consigner+"','"+consignee+"','"+origin+"','"+destination+"',"+
		        		"	'"+frttype+"','"+monthval+"','"+product+"','"+loadRef+"','"+trans+"','"+from+"','"+to+"','"+risk+"','"+repName+"',"+
		        		"    '"+comm+"','"+remark+"','"+loadType+"','"+session.getAttribute("EmpName")+"','"+billbranch+"' , '"+ColloectionStaffName+"','"+cosignercontact+"','"+cosigneecontact+"','"+Liaison+"','"+LiaisonContact+"')";
				System.out.println("sqlInsert"+sqlInsert);
				
				stmt.executeUpdate(sqlInsert);
				 check1="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+consigner+"' ";
				 rs=st.executeQuery(check1);
				if(rs.next()){
					
				}else{
				sqlInsert1="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CompanyName,CustomerCode)VALUES ('"+consigner+"','"+customerCode+"') ";
				stmt1.executeUpdate(sqlInsert1);
				}
				System.out.println("sqlInsert1"+sqlInsert1);
				 check2="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+consignee+"' ";
				 rs1=st1.executeQuery(check2);
				if(rs1.next()){
				}else
				{
					
					/*finding max of customer code for adding consignee as prospect  */
					String sqlCons="SELECT MAX(CustomerCode) as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
					ResultSet rsCons=stmt.executeQuery(sqlCons);
					if(rsCons.next())
					{
						customerCons=rsCons.getInt("a")+1;
						
					}
				sqlInsert2="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CompanyName,CustomerCode) VALUES ('"+consignee+"','"+customerCons+"') ";
				stmt2.executeUpdate(sqlInsert2);
				}
				System.out.println("sqlInsert2"+sqlInsert2);
				 check3="select * from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where City='"+origin+"' ";
				 rs2=st2.executeQuery(check3);
				if(rs2.next()){
				}else{
				sqlInsert3="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City) VALUES ('"+origin+"') ";
				stmt3.executeUpdate(sqlInsert3);
				}
				System.out.println("sqlInsert3"+sqlInsert3);
				
				 check4="select * from "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where City='"+destination+"' ";
				 rs3=st3.executeQuery(check4);
				if(rs3.next()){
				}else{
				sqlInsert4="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City) VALUES ('"+destination+"') ";
				stmt4.executeUpdate(sqlInsert4);
				}
				System.out.println("sqlInsert4"+sqlInsert4);
				check5="select * from "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster where loadType='"+loadType+"' ";
				 rs4=st4.executeQuery(check5);
				if(rs4.next()){
				}else{
				sqlInsert5="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster(EntryBy,loadType) VALUES ('"+session.getAttribute("EmpName")+"','"+loadType+"') ";
				stmt5.executeUpdate(sqlInsert5);
				}
				System.out.println("sqlInsert5"+sqlInsert5);
				 check6="select * from "+session.getAttribute("CompanyMasterID").toString()+"freightMaster where frtType='"+frttype+"' ";
				 rs5=st5.executeQuery(check6);
				if(rs5.next()){
				
				}else{
				sqlInsert6="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"freightMaster(EntryBy,frtType) VALUES ('"+session.getAttribute("EmpName")+"','"+frttype+"') ";
				stmt6.executeUpdate(sqlInsert6);
				}
				System.out.println("sqlInsert6"+sqlInsert6);
				
				 check7="select * from "+session.getAttribute("CompanyMasterID").toString()+"productMaster where product='"+product+"' ";
				 rs6=st6.executeQuery(check7);
				if(rs6.next()){
				}else{
				sqlInsert7="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"productMaster(EntryBy,product) VALUES ('"+session.getAttribute("EmpName")+"','"+product+"') ";
				stmt7.executeUpdate(sqlInsert7);
				}
				System.out.println("sqlInsert7"+sqlInsert7);
				 check8="select * from "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster where riskInvolved='"+risk+"'";
				 rs7=st7.executeQuery(check8);
				if(rs7.next()){
				}else{
				sqlInsert8="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster(EntryBy,riskInvolved) VALUES ('"+session.getAttribute("EmpName")+"','"+risk+"') ";
				stmt8.executeUpdate(sqlInsert8);
				}
				System.out.println("sqlInsert8"+sqlInsert8);
				check9="select * from "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster where BranchName='"+branch+"'";
				rs8=st8.executeQuery(check9);
				if(rs8.next()){
				}else{
					sqlInsert9="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster(EntryBy,BranchName) VALUES ('"+session.getAttribute("EmpName")+"','"+branch+"') ";
				stmt9.executeUpdate(sqlInsert9);
				}
				System.out.println("sqlInsert9"+sqlInsert9);
				
				check10="select * from "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster where BranchName='"+billbranch+"'";
				rs9=st9.executeQuery(check10);
				if(rs9.next()){
				}else{
					sqlInsert10="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster(EntryBy,BranchName) VALUES ('"+session.getAttribute("EmpName")+"','"+billbranch+"') ";
				stmt10.executeUpdate(sqlInsert10);
				}
				System.out.println("sqlInsert10"+sqlInsert10);
			
		}
			
			
	  
	        		
       		
       		
       	
	 	 
		
		
		
		
	
		
		
		
	
		

		
	
/*System.out.println(sqlInsert);
System.out.println(sqlInsert1);
System.out.println(sqlInsert2);
System.out.println(sqlInsert3);
System.out.println(sqlInsert4);
System.out.println(sqlInsert5);
System.out.println(sqlInsert6);
System.out.println(sqlInsert7);
System.out.println(sqlInsert8);*/
 









	if(request.getParameter("update")==null) 
	{
		 int addresscode;
		 String sql="SELECT MAX(AddressCode) FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr";
		 ResultSet rsAdd=stmt3.executeQuery(sql);
		 rsAdd.next();
		 addresscode=rsAdd.getInt(1);
		 System.out.println(addresscode);
		 addresscode++;
		 
 /*		 String sqlAddress="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr (Customercode ,AddressCode ,IntrestedProduct ,ContactPerson ,Address, "+
         "City,Zip ,State ,Country ,Phone ,Fax ,EMail ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode)"     +        
         "VALUES('"+customerCode+"','"+addresscode+"','"+product+"','"+logo+" "+contactPerson+"','"+address.replaceAll("'"," ")+"',"+
         "'"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+email.replaceAll("'"," ")+"','"+stdCode+"','"+mobile+"','0','"+alternateNumber+"','0')";
		 stmt.executeUpdate(sqlAddress);   */
		 
		 
	/*		String sqlcon ="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,contactperson,"+
				"mobileno,mobileno1,mobileno2,AlternetNO,email,phone,fax,zipcode"+
				",address,city,state,country,designation) VALUES ('"+customerCode+"','"+logo+" "+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+alternateNumber+"','"+email.replaceAll("'"," ")+"','"+phone+"','"+fax+"','"+zip+"','"+address.replaceAll("'"," ")+"','"+city+"','"+state+"','"+country+"','"+designation+"')";
			stmt.executeUpdate(sqlcon);
			 
			 System.out.println("Insert query is "+sqlcon);
*/			 
	}
 	 
//flag=true;

String numbers="NA",sendEmailTo="-";






//For SMS or Mail sent/////////////////////////////////


/*

if(request.getParameter("update")==null )   
{
try{
	
	String repDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
	System.out.println(repDetails);
	ResultSet rsRepDetails=stmt.executeQuery(repDetails);
	if(rsRepDetails.next())
	{
		String msgid = null, sms = "";
		  numbers = rsRepDetails.getString("MarketingRepPhNo");
			if(numbers.length()>9) 
				{
				String nos=mobile;
				if(!(phone.equalsIgnoreCase("") || phone.equalsIgnoreCase("0")))
					nos+=" , "+phone;
				System.out.println(nos + numbers);
				
				if(assignedBy.equalsIgnoreCase(repName))		
					 sms="New Prospect "+companyName+" is added by you. Please contact "+contactPerson+" on "+nos+" ";
				else
				 sms="New Prospect "+companyName+" is assiged to you by "+session.getAttribute("EmpName")+". Please contact "+contactPerson+" on "+nos+" ";
				
				try {
						String sql1 = "";
						sms = sms.replace("]", " ").replace("'", " ").replace(";", " ").replace("&", " ").replace("@", " ").replace("<>", " ").replace("[", " ");
						sms = URLEncoder.encode(sms);
			/*
						String smsurl = null;
			
						smsurl = "http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&to="
								+ numbers + "&message=" + sms + "&gateway=regular";
						URL url = new URL(smsurl);
						URLConnection connection = url.openConnection();
						connection.connect();
						BufferedReader in = new BufferedReader(
								new InputStreamReader(connection.getInputStream()));
						String line;
						while ((line = in.readLine()) != null) {
							System.out.println(line);
							msgid = line;
						}
							try{
								stsms.executeUpdate("INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"smshistory (SentBy,Msg,DateTime ) VALUES('"+repName+"','"+sms.replace("+"," ")+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')");
							}catch(Exception ee){
								System.out.println("excep in save to "+session.getAttribute("CompanyMasterID").toString()+"smshistory"+ee);
							}
					} catch (Exception e) {
						System.out.println(e);
						out.println("SMS Sending Failed("+numbers+")");
					} finally { }
				}
			
			sendEmailTo=rsRepDetails.getString("MarketingRepEMail");
			addedOn=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(addedOn));
			if(!(sendEmailTo.equalsIgnoreCase("-")))
			{
				System.out.println("Sending email....");
				String Data="";
				if(assignedBy.equalsIgnoreCase(repName))
				{
					 Data = "added by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				else
				{
					Data = "assigned to you by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				String headerString="",htmlString="";
				int i=1;
				Date today = new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(today);
				cal.add(Calendar.DAY_OF_MONTH, -1);
				Date today30 = cal.getTime();
				String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
				String todaysDateFormat=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
				headerString = " "; 
				htmlString = "<html><body><span style='margin-left:5%;'><strong>Please verify following details of New Prospective Customer :-<br><br></stong></span>";
				htmlString = htmlString +"<div><table cellpadding='0' cellspacing='2' style='margin-left:5%; font-family:verdana; font-size:14; border:thin solid; border-color:black; '>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Prospect</td><td style='background-color: #D4EEF5;width:250px;'><strong>"+companyName+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Address:</td><td style='background-color: #D4EEF5;'>"+address+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>City:</td><td style='background-color: #D4EEF5;'> "+city+" - "+zip+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >State :</td><td style='background-color: #D4EEF5;'> "+state+" ["+country+"]</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Phone No:</td><td style='background-color: #D4EEF5;'> <strong>"+stdCode+" - "+phone+"</strong> </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Alternate Number:</td><td style='background-color: #D4EEF5;'>"+alternateNumber+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Website:</td><td style='background-color: #D4EEF5;'> "+website+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Contact Person :</td><td style='background-color: #D4EEF5;'><strong>"+contactPerson+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Mobile no :</td><td style='background-color: #D4EEF5;'>"+mobile+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'  >Email:</td><td style='background-color: #D4EEF5;'><strong>"+email+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Intrested In Product :</td><td style='background-color: #D4EEF5;'> "+product+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Potential Value:</td><td style='background-color: #D4EEF5;'> "+potentialValue+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Weekly Off On:</td><td style='background-color: #D4EEF5;'> "+weeklyOffOn+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Comments:</td><td style='background-color: #D4EEF5;'> "+comments+"</td> </tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2' ></td></tr>";
				htmlString = htmlString +"</tr></table><br>";
				htmlString = htmlString +"<span style='margin-left:5%;'><strong>"+Data+"</stong></span> </div></body></html>";
								i=1;
				int sumFollowUp=0;
 

				Data = htmlString;
	     		Properties props = new Properties();
				String host="smtp.transworld-compressor.com";
				String protocol="smtp";
				String user="tripend@mobile-eye.in"; //jd@mobile-eye.in  tripend@mobile-eye.in
				String pass2="transworld";
				props.put("mail.smtp.starttls.enable","true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.user", "user");
				props.put("mail.smtp.password", "pass");  
				props.put("mail.store.protocol", protocol);
				props.put("mail.smtps.host", host);
				 
				Session session1 = Session.getDefaultInstance(props, null);
				Message msga = new MimeMessage(session1);
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.setSubject("New Lead: "+companyName+" , assigned by "+assignedBy+" ");
				}
				else
				{
					msga.setSubject("New Lead: "+companyName+" added by "+assignedBy+" ");
				}
				msga.setSentDate(new java.util.Date());
				Address recipientAddrs[] = new InternetAddress[1];
				Address recipientAddrsCC[] = new InternetAddress[1];
				recipientAddrs[0] = new InternetAddress(sendEmailTo);
				
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					recipientAddrsCC[0] = new InternetAddress(session.getAttribute("EmpEmail").toString());
				}
				msga.addRecipients(Message.RecipientType.TO,recipientAddrs);
				
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.addRecipients(Message.RecipientType.CC,recipientAddrsCC);
				}
				
				Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld");
				
				msga.setFrom(fromAddress);
				System.out.println(Data);
				msga.setContent(Data,"text/html; charset=ISO-8859-1");
				Transport t = session1.getTransport("smtps");
				msga.saveChanges(); // don't forget this
				try
				{
					t.connect(host, user, pass2);
					System.out.println("SENT*******");
					t.sendMessage(msga, msga.getAllRecipients());
					System.out.println("Your message has been sent");
				}
				catch(Exception e)
				{
					System.out.print("Exception----->"+e);
				} 
				finally 
				{
					t.close();
				} 
				Transport.send(msga);
		}
		else
			sendEmailTo="  (!!! Email Id not available in System.)";
		}	
   }
   catch(Exception e)
   {
		System.out.println(e);	   
   }
}

		msg = "!!!ERROR. Record not saved in system to some problem. Please try again";
 		/*sqlInsert = "update t_followup SET ()*/
		/*if(flag)
		{
			 msg = "Prospect saved successfully in system.\n Details sent to "+repName+" on "+numbers+"  ";
		}
		response.sendRedirect("alert.jsp?msg="+msg);
}
catch(Exception e)
{
	System.out.println(e);
	msg = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	response.sendRedirect("alert.jsp?msg="+msg);
}*/
//if(flag)
{
	//alert("hi");
 //System.out.println("flag is " +flag);


}
//response.sendRedirect("addOpportunity.jsp?ck=yes&companyName="+companyName);
custName=custName.replace("&","...");
CustomerCode=request.getParameter("customercode1");
System.out.println("value-----------+companyname="+custName+"&customercode="+CustomerCode+" ") ;
response.sendRedirect("alertGoTo.jsp?msg=Opportunity Saved Successfully In System &goto=OpportunityReport.jsp?companyname="+custName+"");

}
catch(Exception e)
{
	System.out.println(e);
	String msg1 = "!!!ERROR. Record Not Saved In System Due To Some Problem. Please Try Again";
	custName=custName.replace("&","...");
	response.sendRedirect("alertGoTo.jsp?msg=+"+msg1+" &goto=OpportunityReport.jsp?companyname="+custName+"");
	//response.sendRedirect("alert.jsp?msg="+msg1);
}

%>

