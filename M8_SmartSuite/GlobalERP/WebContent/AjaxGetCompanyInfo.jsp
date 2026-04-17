<%@page import="java.io.Flushable" import="java.util.Date"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@ include file="conn.jsp" %>
<%!
Connection con1=null;
%>



<% 
session.setAttribute("flag","company");
try 
{
	Class.forName(DB_Driver);
	con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement stmt2 = con1.createStatement();
ResultSet rs1 = null;
String newstring = "",contactPerson="",MoNo="", BranchName="",opname="";
boolean flag = false;
String originalcompany=request.getParameter("company");
System.out.println("Company------------->"+originalcompany);
String company = request.getParameter("company").replaceAll(" ","");
company=company.replace(".","");
company=company.replace(" ","");
company=company.replace("-","");
company=company.replace("_","");
String sql2="";
String A = request.getParameter("limitcount");
int limitcnt = 0,count=0,flg=1;
limitcnt = Integer.parseInt(A);
// System.out.println("Ajax Entry");
	  int j = 1;
	  String buf = "<div id='companyinfoid' style='height:100%;width:100%;overflow:auto; align:right;'><table align = 'left' >";
// 	  System.out.println("Ajax Entry 1");
	  if(limitcnt==0)
	  {
// 		  System.out.println("Ajax Entry 2");
		   sql2 = "(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( CompanyName,'.','') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
			  " union "+

			  "( SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1'  order by CompanyName)"+
			   " union "+
			  
			  "(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef, Replace(Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','')  AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') or Replace( Replace( Replace( OpportunityName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
			  " union "+
			  
"(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite,Assighnedby,leadRef, Replace( Replace( Replace( BranchName, '.','') ,' ','') ,'-','') AS com,BranchName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where BranchName like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
" union "+



			  "(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite,Assighnedby,leadRef, Replace( Replace( Replace( MobileNo, '.','') ,' ','') ,'-','') AS com,MobileNo as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%') and IsDataValid='1' order by CompanyName )  limit 0,300";
		   
		   
		   flg=0;
	  }
	  else
	  {
// 		  System.out.println("Ajax Entry 3");
		   sql2 = "( SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1'  order by CompanyName)"+
		   " union "+

		   "( SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName)"+
		   " union "+
		   
		   
		  "(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode, EMail, IntrestedProduct,MobileNo,ContactPerson,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace(ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') or Replace( Replace( Replace(OpportunityName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
		  " union "+
		
"(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite,Assighnedby,leadRef, Replace( Replace( Replace( BranchName, '.','') ,' ','') ,'-','') AS com,BranchName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where BranchName like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+

" union "+

		  "(SELECT OpportunityName,BranchName, Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,CustomerCode,SalesCustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite,Assighnedby,leadRef,Replace( Replace( Replace( MobileNo,'.', '') ,' ','') ,'-','') AS com,MobileNo as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%') and IsDataValid='1' order by CompanyName ) limit 0,"+limitcnt+" ";
		  
	  }
	  
	  System.out.println("Ajax Entry 4 " + sql2);

	  PreparedStatement pstmt = con1.prepareStatement(sql2, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );
	  ResultSet rs = pstmt.executeQuery();

	  if (rs.last()) {
	      count = rs.getRow();
	      rs.beforeFirst();
	  }

	  
	  if (!rs.next()) {
// 		  System.out.println("Ajax Entry 6");
		    buf +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
		    rs.beforeFirst();
		} else {
// 			System.out.println("Ajax Entry 7");
			   if( count >= limitcnt && flg==1)
			  { 
// 				   System.out.println("Ajax Entry 8");
			   	   buf +="<tr ><td ></td><td align='left'><a href='#' onclick='getCompanies(2);' >more..</a></td></tr>";
			  }
			   else 
			  {  
			   	 
			  }
			  do {
		         String type="";
		         String b ="";
		        try
		        {
// 		        	System.out.println("Ajax Entry 9");
		    	newstring = rs.getString("com");
		    	contactPerson=rs.getString("ContactPerson");
		    	opname=rs.getString("OpportunityName");
		    	MoNo=rs.getString("MobileNo");
		    	//BranchName=rs.getString("BranchName");
		    	
				  b = rs.getString("a");
				   type = (rs.getString("SalesCustomerCode") == null || rs.getString("SalesCustomerCode").equalsIgnoreCase("") ) ? "-" : rs.getString("SalesCustomerCode");
				  
		        }catch(Exception e)
		        {
		        	System.out.println("EXC"+e.toString());
		        }
				  
				  String custcode = "";
				  if(type.equals("0") || type == "0")
				  {
					  type = "Prospect";
					  custcode = rs.getString("CustomerCode");
				  }
				  else	
				  {
					   type = "Customer";
					   custcode = rs.getString("SalesCustomerCode");
				  }
				  
				  	if(newstring.toLowerCase().contains(company.toLowerCase()))
				  	{
// 				  		System.out.println("Ajax Entry 10");
				  		try{
				  		buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";
				  		}
				  		catch(Exception ex)
				  		{
				  			System.out.println(ex);
				  		}
				  	}else if(contactPerson.toLowerCase().contains(company.toLowerCase()))
					{
				  		try{
// 				  		System.out.println("Ajax Entry 11");
						buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";
					}
			  		catch(Exception ex)
			  		{
			  			System.out.println(ex);
			  		}
					}
					else if(MoNo.toLowerCase().contains(company.toLowerCase()))
					{
						try{
// 						System.out.println("Ajax Entry 12");
						buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";				
						}
				  		catch(Exception ex)
				  		{
				  			System.out.println(ex);
				  		}
						}
				  	
					else if(BranchName.toLowerCase().contains(company.toLowerCase()))
					{
						try{
 					//	System.out.println(" In Branch Name ");
						buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";				
						}
				  		catch(Exception ex)
				  		{
				  			System.out.println(ex);
				  		}
						}
					
						else if(newstring!="")
				  	{
							try{
// 						System.out.println("Ajax Entry 13");
						buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";
							}
					  		catch(Exception ex)
					  		{
					  			System.out.println(ex);
					  		}
							}
					else
					{
						try{
// 						System.out.println("Ajax Entry 14");
						buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("contactperson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"->"+rs.getString("BranchName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";
						}
				  		catch(Exception ex)
				  		{
				  			System.out.println(ex);
				  		}
						}
				 j++;
// 				 System.out.println("Ajax Entry 15");
		    }while (rs.next());
			  buf+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";
// 			  System.out.println("Ajax Entry 16");
		}
  buf += "</table></div>";
  //System.out.println("Ajax Entry BUf = "+buf);
  out.println(buf);
   
  buf = null;
}
catch(Exception e)
{ 
  out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
}
finally
{
  con1.close();
}
%>
</jsp:useBean>