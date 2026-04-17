
<%@ include file="conn.jsp"%>

<%!
Connection con;

%>
<% 
String tranType=request.getParameter("tranType");
//System.out.println("tranType    "+tranType+" type "+request.getParameter("type"));


try {

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement stmt=null,st=null,st1=null,st2=null;
	stmt=con.createStatement();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();

	ResultSet rs=null;
	String sql="";

	if(request.getParameter("type").equals("quotation"))
	{
		 String name=request.getParameter("name");
		 
		 name=name.replace("..", "&");
		 
		// name=name.replaceAll("."," ");
		// name=name.replaceAll(","," ");
		 System.out.println("nnnmmmmm"+name);

		 //sql="SELECT DISTINCT(BeneficiaryName) FROM "+session.getAttribute("CompanyMasterID").toString()+"netbanking  WHERE BeneficiaryName LIKE('%"+name+"%') ORDER BY BeneficiaryName LIMIT 20 ";
		 
		 
		 
		 sql="SELECT DISTINCT(BeneficiaryName) FROM "+session.getAttribute("CompanyMasterID").toString()+"netbanking  WHERE BeneficiaryName LIKE('%"+name+"%')  and status='-' ORDER BY BeneficiaryName LIMIT 20 ";
	/*	 sql="(SELECT BeneficiaryName FROM "+session.getAttribute("CompanyMasterID").toString()+"netbanking  WHERE BeneficiaryName LIKE('%"+name+"%') and STATUS != 'Deactivate' ORDER BY BeneficiaryName  )"
		 +" union"+"(SELECT BeneficiaryName FROM "+session.getAttribute("CompanyMasterID").toString()+"netbanking  WHERE Replace(Replace(BeneficiaryName,' ',''),'.',' ') LIKE('%"+name+"%') and STATUS != 'Deactivate' ORDER BY BeneficiaryName  )";
	
		 sql1="(SELECT CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName like ('"+company+"')  order by CompanyName )"+
		  " union "+

		  "( SELECT CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where  Replace(Replace(CompanyName,' ',''),'.',' ') like ('"+company+"')  order by CompanyName)";
		*/ 
		 System.out.println("Quotation Query :- "+sql);
		 rs=stmt.executeQuery(sql);
		 
		 String buffer="<div style='height:120px;width:400px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
		 int i=1;
		   while(rs.next())
		   {
		     buffer+="<tr><td><a href='#' onClick='showVisitingName(\""+rs.getString("BeneficiaryName")+"\");'  style='color: black;'>"+rs.getString("BeneficiaryName").replaceAll("(?i)"+name,"<font color=blue><u>"+name.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
		   buffer+="</table></div>";
		out.println(buffer);
	}
	else if(request.getParameter("type").equals("changefield"))
	{  
	String name=request.getParameter("name");
	name=name.replace("..", "&");
	System.out.println("name"+name);
	String buffer = "";
    String sqlbankname="Select BeneBankName from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+name+"' and Status='-' ";
	 System.out.println("bankqry--change Field ->"+sqlbankname);
	 ResultSet rs2=st.executeQuery(sqlbankname);
	 String temp[];
	 String bankname="",accountNo="",ifcCode="",levelLimit="";
	 
	  buffer="";
	 int i=1;
	   while(rs2.next())
	   {
		   buffer+=",";
		  String  bank_name=rs2.getString("BeneBankName");
	     buffer+=bank_name;
	    // buffer="\n";
	        i++;
	   } 
	   
	out.println(buffer);
	/*
    String buffer = "";
    String sqlbankname="Select BeneBankName,IFCCode,BeneficiaryAccountNumber from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+name+"'";
	 System.out.println("bankqry--->"+sqlbankname);
	 ResultSet rs2=st.executeQuery(sqlbankname);
	 String temp[];
	 String bankname="",accountNo="",ifcCode="",levelLimit="";
	 
	  buffer="<option value=\"Select\">Select</option>";
	 int i=1;
	   while(rs2.next())
	   {
		   buffer+=",";
		  String  bank_name=rs2.getString("BeneBankName");
	     buffer+="<option value="+bank_name+">"+bank_name+"</option>";
	    // buffer="\n";
	        i++;
	   } 
	   
	out.println(buffer);
		
		
		  String buffer = "";
		 String name=request.getParameter("name");
		 sql="Select BeneBankName,IFCCode,BeneficiaryAccountNumber,Level1Limit from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+name+"'";
		 System.out.println(sql);
		 ResultSet rs1=st.executeQuery(sql);
		 String temp[];
		 String bankname="",accountNo="",ifcCode="",levelLimit="";
		 int i=1;
			while(rs1.next())
			{ bankname=rs1.getString("BeneBankName");
			  accountNo=rs1.getString("BeneficiaryAccountNumber");
			  ifcCode=rs1.getString("IFCCode");
			  levelLimit=rs1.getString("Level1Limit");
			  
			}
		buffer+=bankname+","+accountNo+","+ifcCode+","+levelLimit;
		System.out.println("buffer "+buffer);
		out.println(buffer);*/
	}
	if(request.getParameter("type").equals("update"))
	{   
		System.out.println("response from 122122");
		String filenameDate=new SimpleDateFormat("MM-yyyy").format(new java.util.Date());
	    String Partname="";
	    int count=0,nextcount=000;
	    tranType=request.getParameter("tranType");
	    System.out.println("tranType    "+tranType);
	    
	    String EmpName=session.getAttribute("EmpName").toString();
	    //get next count **********
	    String sqlnextcount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
	    System.out.println(sqlnextcount);
	    ResultSet rs2=st.executeQuery(sqlnextcount);	  
	    while(rs2.next())
	    {   
	    count =rs2.getInt(1)+1;
	    }
	    nextcount=nextcount+count;
	   System.out.println("next count "+nextcount);
	    
	    
	    String partDate=new SimpleDateFormat("ddMM").format(new java.util.Date());
				if (tranType.equals("250-HDFC TO OTHER"))
				{
					Partname="TCT0"+partDate;
				}
				else if(tranType.equals("250-HDFC TO HDFC"))
				{
					Partname = "TCT50"+partDate;
				}
				else if(tranType.equals("3338-HDFC TO OTHER"))
				{
					 Partname = "TCT8"+partDate;
				}
				else if(tranType.equals("3338-HDFC TO HDFC"))
				{
					Partname = "TCT38"+partDate;
				}
				System.out.println("partname "+Partname);
				
				String userHome = System.getProperty("user.home");
				System.out.println("userHome-"+userHome);
				String FilePath =""+userHome+"/NetbankingFiles"+filenameDate+"";
	    		String FileName="/"+Partname+"."+nextcount+"";
	 
		
		
		 String sqlfile="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles (CreationDate,Createdby,AccoutType,FileName1,FileLocation) values ('"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"','"+EmpName+"','"+tranType+"','"+Partname+"."+nextcount+"','"+FilePath+"' )";
		 System.out.println("sqlfile "+sqlfile);	
		 st1.executeUpdate(sqlfile);
	    	System.out.println("file records inserted");
	    	
	    	String sqlupdate="Update "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords set Filename1='"+Partname+"."+nextcount+"' where Filename1='NA'";
	    	System.out.println("sqlupdate"+sqlupdate);
	    	st2.executeUpdate(sqlupdate);
	    	System.out.println("filename records updated");
	    	
	    	response.sendRedirect("netBanking.jsp?Flgfnewfile=YES");
	}
	


} catch(Exception e) {  
	System.out.println("!!!ERROR!!!  GenericAjaxSearch  ::  "+e);
}
finally
{
	con.close();
}
%>
