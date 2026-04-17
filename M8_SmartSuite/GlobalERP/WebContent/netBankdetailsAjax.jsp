
<%@ include file="conn.jsp"%>

<%!
Connection con;

%>
<% 
//String tranType=request.getParameter("tranType");
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

	
		String bank_name=request.getParameter("bankName1");
		String name=request.getParameter("name");
		 name=name.replace("..", "&");
		System.out.println("name"+name+"bankname-->"+bank_name);
		name=name.trim();
		bank_name=bank_name.trim();
		
	    String buffer = "";
	    //String sqlbankname1="Select IFCCode,BeneficiaryAccountNumber,Level1Limit from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+name+"' and BeneBankName='"+bank_name+"'";
	    String sqlbankname1="Select IFCCode,BeneficiaryAccountNumber,Level1Limit from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+name+"' and BeneBankName like '%"+bank_name+"%'";
		 System.out.println("qry--->"+sqlbankname1);
		 ResultSet rs2=st.executeQuery(sqlbankname1);
		 String temp[];
		 String bankname="",accountNo="",ifcCode="",levelLimit="";
		 
		  buffer=",";
		 int i=1;
		   while(rs2.next())
		   {
			   ifcCode=rs2.getString("IFCCode");
			   accountNo=rs2.getString("BeneficiaryAccountNumber");
			   levelLimit=rs2.getString("Level1Limit");
		     	buffer+=ifcCode+","+accountNo+","+levelLimit;
		        i++;
		   } 
		   System.out.println("ifc and acno  and limit-->"+buffer);
		out.println(buffer);
		 
		
		
	


} catch(Exception e) {  
	System.out.println("!!!ERROR!!!  GenericAjaxSearch  ::  "+e);
}
finally
{
	con.close();
}
%>
