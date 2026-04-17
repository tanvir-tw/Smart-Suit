<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxClaimEnq.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();
Statement st1 = con1.createStatement();
Statement st2 = con1.createStatement();Statement st4 = con1.createStatement();
ResultSet rs1 = null,rsClaimNo=null;
String buffer = "",SqlUpdate;	
int claimno=0,billid=0;
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String todays=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String srno=" ",amount=" ",billNo=" ",billDate=" ",Comments=" ",category=" ",mode="",city="",comments="",purpose="",remarks="",billAmt="";
String sqlInsert="", sql="",fromplace="",toplace="",fromdate="",todate="",hrs="",hrs1="",min="",min1="",sec="",sec1="",companyname="",fromdate1="",todate1="",origin="",destination="",traveldatetime="",travelhrs="",travelmin="";
String companyname1="",companyname2="",companyname3="",companyname4="",Client="",Frodate="",Todate="",SqlClaimNo="",KmTravel="",travelcategory="",department="",grade="";
String EmpName=session.getAttribute("EmpName").toString();
String billby="",CLMRefNumber="-",SqlMaster="",HodReport="",filebill="",status="";
//System.out.println(">>>>>EmpName:"+EmpName);
ResultSet rs=null;
int Srno=0;
String EMPName=session.getAttribute("EmpName").toString();
System.out.println(">>>>>>>>>>>EMPName:"+EMPName);    
String clmrefno=request.getParameter("clmrefno");
System.out.println(">>>>>>>clmrefno:"+clmrefno);
String ac=request.getParameter("action");
System.out.println(">>>>>>>ac:"+ac);
String SqlEmpDetails="select Dept,TALevel from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EmpName+"'";
ResultSet rsEmpDetails=st4.executeQuery(SqlEmpDetails);
System.out.println("\n>>>>>>>>>>SqlEmpDetails:"+SqlEmpDetails);
//status=request.getParameter("status");
//System.out.println("@@@@@@@ "+status);
filebill=request.getParameter("filebill");

if(request.getParameter("action").equals("delete"))
{
	
	System.out.println("IN DELETE   ");
  srno=request.getParameter("srno");
  sql="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Cancel='0' where SrNo='"+srno+"' ";
try{
stmt1.executeUpdate(sql);
System.out.println(">>>>>>>sql:"+sql);
}catch(Exception e){}
//System.out.println("\n>>>>>>>>End of AjaxClaimEnq.jsp>>>>>>>>>>>>>>>>");		


out.println("#Yes");

}
try{
if(filebill.equals("null") || filebill==null)
{
	 filebill="-";
	 
}


System.out.println("333333333333333333333"+filebill);
if(rsEmpDetails.next())
{
	department=rsEmpDetails.getString("Dept");
	grade=rsEmpDetails.getString("TALevel");
	System.out.println(">>>>department:"+department);
	System.out.println(">>>>grade:"+grade);
}
String SqlData="select email,HodReport from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EmpName+"'";
ResultSet rsData=st4.executeQuery(SqlData);
System.out.println(">>>>>>>>SqlData:"+SqlData);
if(rsData.next())
{
	   HodReport=rsData.getString("HodReport");
}
System.out.println(">>>>>>>>>>>>HodReport:"+HodReport);
	
}catch(Exception e ){}
if(request.getParameter("action").equals("add"))
{
	/**********************************************************************************************/
	String claimId="CID";
    java.text.DecimalFormat df = new java.text.DecimalFormat("000");

   String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
     sql="SELECT ClaimID from "+session.getAttribute("CompanyMasterID").toString()+"claim_master  where ClaimID like ('"+claimId+""+idDate+"%') ORDER BY ClaimID DESC LIMIT 1";
    rs=st2.executeQuery(sql);
    if(rs.next())
    claimId=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
    else
    claimId+=idDate+"001";
    Date d1 = new Date();
    if(clmrefno.contains("-"))
    {
      CLMRefNumber="CLM";
      String date =  new SimpleDateFormat("ddMMyy").format(new Date());
      String sql3="SELECT CLMRefNumber  from "+session.getAttribute("CompanyMasterID").toString()+"claim_master  where CLMRefNumber like ('"+CLMRefNumber+""+date+"%') ORDER BY CLMRefNumber DESC LIMIT 1";
      ResultSet rs2=st2.executeQuery(sql3);
      System.out.println(">>>>sql3:"+sql3); 
      if(rs2.next())
      {
        String a=rs2.getString(1);
        System.out.println(">>>>>>>>  "+a);
        System.out.println("IN IF  ");
        CLMRefNumber=rs2.getString(1).substring(0,rs2.getString(1).length()-3)+df.format(Integer.parseInt(rs2.getString(1).substring(rs2.getString(1).length()-3, rs2.getString(1).length()))+1);
        System.out.println("NO IS:  "+CLMRefNumber);
       // status="Open";
       }
       else
       {
          CLMRefNumber+=date+"001";	
        }
       clmrefno=CLMRefNumber;
     //  status="Open";
      }
	   if(clmrefno==null)
	   {
		System.out.println(">>>>>>clmrefno:"+clmrefno);
	   }
	    else
	    {
		String SqlBill="Select 	count(*) as count from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+clmrefno+"' and Cancel='1' ";
		System.out.println(">>>>>>SqlBill:"+SqlBill);
		ResultSet rsBill=st2.executeQuery(SqlBill);
		while(rsBill.next())
		{
			String count=rsBill.getString("count");
			System.out.println(">>>>>>count:"+count);
			if(count=="0")
			{
				billid=1;
			}
			else
			{
			 billid=Integer.parseInt(count)+1;
			}
			
		}
		
		System.out.println(">>>>>>billid:"+billid);
	  }
	
	/***********************************************************************************************/
	int i=1;
	String claimtype=request.getParameter("claimtype");
	System.out.println(">>>>>>claimtype:"+claimtype);
	if(CLMRefNumber!="-")
	{
		String ourcompany=request.getParameter("ourcompany");
		//fromdate1=request.getParameter("fromdate1");
		fromdate1=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate1")));
		//todate1=request.getParameter("todate1");
		todate1=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate1")));
		String advanceTaken=request.getParameter("advanceTaken");
		
		purpose=request.getParameter("purposeheader");
		origin=request.getParameter("origin");
		destination=request.getParameter("destination");
		System.out.println(ourcompany+""+fromdate1+""+todate1+" advanceTaken="+advanceTaken+" purpose="+purpose+"origin="+origin+"destination="+destination);
		SqlMaster="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_master (ClaimID,	CLMRefNumber,ClaimantName,ClaimType,Department,DepartureDateTime,ArrivalDateTime,Purpose,ClaimSubmittedOn,ModeOfSubmition,ClaimReceivedOn,SumOfClaimAmount,AdvanceTaken,CostCenter,Status ,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,Origin,Destination,CommentsByACDepa,Cancel,HodReport)values "+
        " ('"+claimId+"','"+clmrefno+"','"+EMPName+"','"+claimtype+"','"+department+"','"+fromdate1+" 00:00:00','"+todate1+" 00:00:00','"+purpose+"','"+todays+"','Web Site','"+todays+"','0.00','"+advanceTaken+"','"+ourcompany+"','Open','-','-','-','"+origin+"','"+destination+"','-','1','"+HodReport+"')";
		  
		  System.out.println(">>>>>>>>>SqlMaster:"+SqlMaster);
		   st1.executeUpdate(SqlMaster);
	}
	if(claimtype.equals("localclaim"))
	{
	  System.out.println(">>>>>>claimtype:"+claimtype);
	  category=request.getParameter("category");
	  //travelcategory=request.getParameter("travelcategory");
	  if(category.equals("Expense"))
	  {
		  System.out.println(">>>>>>category:"+category);
	    purpose=request.getParameter("purpose");
	    billNo=request.getParameter("billNo");
	    billby=request.getParameter("billby");
	    billAmt=request.getParameter("billAmt");
	    //filebill=request.getParameter("filebill");
	    System.out.println("333333333333333333333"+filebill);
		 System.out.println(">>>>>>>>>>> billAmt:"+ billAmt+" purpose="+purpose);
	    remarks=request.getParameter("remarks");
	    billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));

	    sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_det (ClaimID ,CLMRefNumber,ClaimantName,BillID ,DateTime,Particulars ,ModeOfParticulars,"+
		"CompanyName,BillNo,BillDate ,Amount ,DisallowedAmount ,CheckedBy ,ApprovedBy,SanctionedBy,CommentsByEmp,CommentsByHOD,CommentsByACDepa,CommentsAtApproving,City,Purpose,KmTraveled,Status,Cancel,BillBy,uploadbill) VALUES "+
		"('"+claimId+"','"+clmrefno+"','"+EMPName+"','"+billid+"','"+todaysDateTime+"','"+category+"','-','-','"+billNo+"','"+billDate+"','"+billAmt+"',"+
		" '0','-','-','-','"+remarks+"','-', '-','-','-','"+purpose+"','0','Open','1','"+billby+"','"+filebill+"')";
	      System.out.println(">>>>>>>>>sqlinsert:"+sqlInsert);
	      stmt1.executeUpdate(sqlInsert);
		 // System.out.println(">>>>>>>>>sqlinsert:"+sqlInsert);
	  }
	  else
	  {
		 purpose=request.getParameter("purpose");
		 KmTravel=request.getParameter("KmTravel");
		 billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		 billAmt=request.getParameter("billAmt");
		 remarks=request.getParameter("remarks");
		 mode=request.getParameter("mode");
		 billby=request.getParameter("billby");
		 filebill=request.getParameter("filebill");
		 
		 
			 
		 System.out.println(">>>>>>>>>filebill:"+filebill);
		 sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_det (ClaimID ,CLMRefNumber,ClaimantName,BillID ,DateTime,Particulars ,ModeOfParticulars,"+
			"CompanyName,BillNo,BillDate ,Amount ,DisallowedAmount ,CheckedBy ,ApprovedBy,SanctionedBy,CommentsByEmp,CommentsByHOD,CommentsByACDepa,CommentsAtApproving,City,Purpose,KmTraveled,Status,Cancel,BillBy,uploadbill) VALUES "+
			"('"+claimId+"','"+clmrefno+"','"+EMPName+"','"+billid+"','"+todaysDateTime+"','"+category+"','"+mode+"','-','-','"+billDate+"','"+billAmt+"',"+
			" '0','-','-','-','"+remarks+"','-', '-','-','-','"+purpose+"','"+ KmTravel+"','Open','1','"+billby+"','"+filebill+"')";
		 
		  stmt1.executeUpdate(sqlInsert);
		  System.out.println(">>>>>>>>>sqlinsert:"+sqlInsert);
	  }
	  
	}
	else
	{
	  travelcategory=request.getParameter("travelcategory");
	  if(travelcategory.equals("JourneyFare"))
	  {
	
		//srno=request.getParameter("srno");
		amount=request.getParameter("amount");
		billNo=request.getParameter("billNo");
		//billDate=request.getParameter("billDate");
		billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		remarks=request.getParameter("remarks");
		mode=request.getParameter("mode");
		city=request.getParameter("city");
		origin=request.getParameter("origin");
		destination=request.getParameter("destination");
		fromdate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		System.out.println("\nfromdate:"+fromdate);
		todate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		System.out.println("\ntodate:"+todate);
		hrs=request.getParameter("hrs");
		hrs1=request.getParameter("hrs1");
		min=request.getParameter("min");
		min1=request.getParameter("min1");
		billby=request.getParameter("billby");
		companyname=request.getParameter("companyNames");
		companyname1=request.getParameter("companyNames1");
		companyname2=request.getParameter("companyNames2");
		companyname3=request.getParameter("companyNames3");
		companyname4=request.getParameter("companyNames4");
		if(companyname!="")
		{Client=companyname;}
		if(companyname1!="")
		{Client=Client+","+companyname1;}
		if(companyname2!="")
		{Client=Client+","+companyname2;}
		if(companyname3!="")
		{Client=Client+","+companyname3;}
		if(companyname4!="")
		{Client=Client+","+companyname4;}
		System.out.println(">>>>>>>>>>>>Client:"+Client);
		
		sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_det (ClaimID ,CLMRefNumber,ClaimantName,BillID ,DateTime,Particulars ,ModeOfParticulars,"+
		"CompanyName,BillNo,BillDate ,Amount ,DisallowedAmount ,CheckedBy ,ApprovedBy,SanctionedBy,CommentsByEmp,CommentsByHOD,CommentsByACDepa,CommentsAtApproving,City,Purpose,KmTraveled,FromPlace,ToPlace,FromDateTime,ToDateTime,Status,Cancel,BillBy,uploadbill) VALUES "+
		"('"+claimId+"','"+clmrefno+"','"+EMPName+"','"+billid+"','"+todaysDateTime+"','"+travelcategory+"','"+mode+"','"+Client+"','"+billNo+"','"+billDate+"','"+amount+"',"+
		" '0','-','-','-','"+remarks+"','-', '-','-','"+city+"','-','0','"+origin+"','"+destination+"','"+fromdate+" "+hrs+":"+min+":00','"+todate+" "+hrs1+":"+min1+":00','Open','1','"+billby+"','"+filebill+"')";
	
		System.out.println(">>>>>>>>>sqlinsert:"+sqlInsert);
		stmt1.executeUpdate(sqlInsert);
		  
	  }
	 else
	 {
		//String queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&city="+city+"&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;
		amount=request.getParameter("amount");
		billNo=request.getParameter("billNo");
		billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		remarks=request.getParameter("remarks");
		city=request.getParameter("city");
		traveldatetime=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("traveldatetime")));
		System.out.println("\ntraveldatetime:"+traveldatetime);
		travelhrs=request.getParameter("travelhrs");
		travelmin=request.getParameter("travelmin");
		companyname=request.getParameter("companyNames");
		companyname1=request.getParameter("companyNames1");
		companyname2=request.getParameter("companyNames2");
		companyname3=request.getParameter("companyNames3");
		companyname4=request.getParameter("companyNames4");
		billby=request.getParameter("billby");
		if(companyname!="")
		{Client=companyname;}
		if(companyname1!="")
		{Client=Client+","+companyname1;}
		if(companyname2!="")
		{Client=Client+","+companyname2;}
		if(companyname3!="")
		{Client=Client+","+companyname3;}
		if(companyname4!="")
		{Client=Client+","+companyname4;}
		System.out.println(">>>>>>>>>>>>Client:"+Client);
		
		sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"claim_det (ClaimID ,CLMRefNumber,ClaimantName,BillID ,DateTime,Particulars ,ModeOfParticulars,"+
		"CompanyName,BillNo,BillDate ,Amount ,DisallowedAmount ,CheckedBy ,ApprovedBy,SanctionedBy,CommentsByEmp,CommentsByHOD,CommentsByACDepa,CommentsAtApproving,City,Purpose,KmTraveled,FromPlace,ToPlace,FromDateTime,Status,Cancel,BillBy,uploadbill) VALUES "+
		"('"+claimId+"','"+clmrefno+"','"+EMPName+"','"+billid+"','"+todaysDateTime+"','"+travelcategory+"','-','"+Client+"','"+billNo+"','"+billDate+"','"+amount+"',"+
		" '0','-','-','-','"+remarks+"','-', '-','-','"+city+"','-','0','-','-','"+traveldatetime+" "+travelhrs+":"+travelmin+":00','Open','1','"+billby+"','"+filebill+"')";
	
		System.out.println(">>>>>>>>>sqlinsert:"+sqlInsert);
		stmt1.executeUpdate(sqlInsert);
	
	 }
	}
	//ResultSet rsInsert= stmt1.executeQuery(sqlInsert);
	
 // i++;
buffer=clmrefno;
out.println(clmrefno+"#Yes");


}

if(request.getParameter("action").equals("update"))
{
	int i=1;
	srno=request.getParameter("srno");
	System.out.println(">>>>>>srno:"+srno);
	String claimtype=request.getParameter("claimtype");
	System.out.println(">>>>>>claimtype:"+claimtype);
	if(claimtype.equals("localclaim"))
	{
	  //System.out.println(">>>>>>claimtype:"+claimtype);
	  category=request.getParameter("category");
	  //travelcategory=request.getParameter("travelcategory");
	  if(category.equals("Expense"))
	  {
		//System.out.println(">>>>>>category:"+category);
	    purpose=request.getParameter("purpose");
	    System.out.println(">>>>>>>>>>> purpose:"+ purpose);
	    billNo=request.getParameter("billNo");
	    System.out.println(">>>>>>>>>>> billNo:"+ billNo);
	    billAmt=request.getParameter("billAmt");
	    System.out.println(">>>>>>>>>>> billAmt:"+ billAmt);
	    remarks=request.getParameter("remarks");
	    System.out.println(">>>>>>>>>>> remarks:"+ remarks);
	    billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
	    System.out.println(">>>>>>>>>>> billDate:"+ billDate);
	    billby=request.getParameter("billby");
	    SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det  Set Purpose='"+purpose+"',BillNo='"+billNo+"',BillDate='"+billDate+"',Amount='"+billAmt+"',CommentsByEmp='"+remarks+"',BillBy='"+billby+"' Where SrNo='"+srno+"' ";
	    System.out.println(">>>>>>>SqlUpdate:"+SqlUpdate);
	    stmt2.executeUpdate(SqlUpdate);
	    
	  }
	  else
	  {
		 purpose=request.getParameter("purpose");
		 KmTravel=request.getParameter("KmTravel");
		 billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		 billAmt=request.getParameter("billAmt");
		 remarks=request.getParameter("remarks");
		 mode=request.getParameter("mode");
		 //mode=request.getParameter("mode");
		 billby=request.getParameter("billby");
		 SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det  Set  ModeOfParticulars='"+mode+"',Purpose='"+purpose+"',KmTraveled='"+KmTravel+"',BillDate='"+billDate+"',Amount='"+billAmt+"',CommentsByEmp='"+remarks+"',BillBy='"+billby+"' Where SrNo='"+srno+"' ";
		 System.out.println(">>>>>>>SqlUpdate:"+SqlUpdate);
		 stmt2.executeUpdate(SqlUpdate);
		
		
	  }
	  
	}
	else
	{
	  travelcategory=request.getParameter("travelcategory");
	  if(travelcategory.equals("JourneyFare"))
	  {
	
		//srno=request.getParameter("srno");
		amount=request.getParameter("amount");
		billNo=request.getParameter("billNo");
		//billDate=request.getParameter("billDate");
		billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		remarks=request.getParameter("remarks");
		mode=request.getParameter("mode");
		city=request.getParameter("city");
		origin=request.getParameter("origin");
		destination=request.getParameter("destination");
		fromdate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		System.out.println("\nfromdate:"+fromdate);
		todate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		System.out.println("\ntodate:"+todate);
		hrs=request.getParameter("hrs");
		hrs1=request.getParameter("hrs1");
		min=request.getParameter("min");
		min1=request.getParameter("min1");
		companyname=request.getParameter("companyNames");
		companyname1=request.getParameter("companyNames1");
		companyname2=request.getParameter("companyNames2");
		companyname3=request.getParameter("companyNames3");
		companyname4=request.getParameter("companyNames4");
		billby=request.getParameter("billby");
		if(companyname!="")
		{Client=companyname;}
		if(companyname1!="")
		{Client=Client+","+companyname1;}
		if(companyname2!="")
		{Client=Client+","+companyname2;}
		if(companyname3!="")
		{Client=Client+","+companyname3;}
		if(companyname4!="")
		{Client=Client+","+companyname4;}
		System.out.println(">>>>>>>>>>>>Client:"+Client);
		
		SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det  Set Particulars='"+travelcategory+"',ModeOfParticulars='"+mode+"',FromPlace='"+origin+"',ToPlace='"+destination+"',FromDateTime='"+fromdate+" "+hrs+":"+min+":00',ToDateTime='"+todate+" "+hrs1+":"+min1+":00',CompanyName='"+Client+"',BillNo='"+billNo+"',BillDate='"+billDate+"',Amount='"+amount+"',CommentsByEmp='"+remarks+"',City='"+city+"',BillBy='"+billby+"' Where SrNo='"+srno+"' ";
		System.out.println(">>>>>>>SqlUpdate:"+SqlUpdate);
		stmt2.executeUpdate(SqlUpdate);
		  
	  }
	 else
	 {
		//String queryString = "?action=add&amount="+amount+"&billNo="+billNo+"&billDate="+billDate+"&remarks="+remarks+"&travelcategory="+travelcategory+"&city="+city+"&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&companyNames="+companyNames+"&companyNames1="+companyNames1+"&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4;
		amount=request.getParameter("amount");
		billNo=request.getParameter("billNo");
		billDate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billDate")));
		remarks=request.getParameter("remarks");
		city=request.getParameter("city");
		traveldatetime=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("traveldatetime")));
		System.out.println("\ntraveldatetime:"+traveldatetime);
		travelhrs=request.getParameter("travelhrs");
		travelmin=request.getParameter("travelmin");
		companyname=request.getParameter("companyNames");
		companyname1=request.getParameter("companyNames1");
		companyname2=request.getParameter("companyNames2");
		companyname3=request.getParameter("companyNames3");
		companyname4=request.getParameter("companyNames4");
		billby=request.getParameter("billby");
		if(companyname!="")
		{Client=companyname;}
		if(companyname1!="")
		{Client=Client+","+companyname1;}
		if(companyname2!="")
		{Client=Client+","+companyname2;}
		if(companyname3!="")
		{Client=Client+","+companyname3;}
		if(companyname4!="")
		{Client=Client+","+companyname4;}
		System.out.println(">>>>>>>>>>>>Client:"+Client);
		
		SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det  Set Particulars='"+travelcategory+"',FromDateTime='"+traveldatetime+" "+travelhrs+":"+travelmin+":00',CompanyName='"+Client+"',BillNo='"+billNo+"',BillDate='"+billDate+"',Amount='"+amount+"',CommentsByEmp='"+remarks+"',City='"+city+"',BillBy='"+billby+"' Where SrNo='"+srno+"' ";
		System.out.println(">>>>>>>SqlUpdate:"+SqlUpdate);
		stmt2.executeUpdate(SqlUpdate);
	
	 }
	}
	out.println("#Yes");
	
}

} catch (Exception e) {
System.out.println("AjaxClaimEnq.jsp insert claim enq in tmp table > "+e);
out.println("#NO");
} finally {
	con1.close();

}
%>
