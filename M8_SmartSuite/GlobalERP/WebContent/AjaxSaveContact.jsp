 <%@page import="com.ConnectionClass"%>
<%@ include file="conn.jsp" %>
 <%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>

<%@page import="java.util.Date"%>

<%!
Connection con1;
%>
<% 
	ConnectionClass connection = new ConnectionClass();
try
{
		
		con1 =connection.getConnect("db_GlobalERP");
		Statement stmt1=con1.createStatement();
		ResultSet rs1=null;
		String sql1="";
		//String received_data[]  =request.getParameter("mydata").split("zz",22);
		String mcontactperson=request.getParameter("salutation")+" "+request.getParameter("firstname")+" "+request.getParameter("middlename")+" "+request.getParameter("lastname");
	    try
		    {
	    	System.out.println("Custodtype : "+request.getParameter("CustOfType"));
				if(request.getParameter("CustOfType").equals("Customer"))
				{
					sql1="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"contactdet (salesCustomerCode,contactperson,salutation,"+
					"firstname,middlename,lastname,mobileno,mobileno1,mobileno2,AlternetNO,email,Email1,Email2,phone,fax,zipcode"+
					",address,city,state,country,companyname,designation) VALUES ('"+request.getParameter("customercode")+"','"+mcontactperson+"','"+request.getParameter("salutation")+"','"+request.getParameter("firstname")+"','"+request.getParameter("middlename")+"','"+request.getParameter("lastname")+"','"+request.getParameter("mobileno")+"','"+request.getParameter("mobileno1")+"','"+request.getParameter("mobileno2")+"','"+request.getParameter("alternetno")+"','"+request.getParameter("emailids")+"','"+request.getParameter("emailids1")+"','"+request.getParameter("emailids2")+"','"+request.getParameter("phoneno")+"','"+request.getParameter("faxno")+"','"+request.getParameter("zipcode")+"','"+request.getParameter("address")+"','"+request.getParameter("city")+"','"+request.getParameter("state")+"','"+request.getParameter("country")+"','"+request.getParameter("companyname")+"','"+request.getParameter("designation")+"')";
				}
				else
				{
					sql1="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,contactperson,salutation,"+
					"firstname,middlename,lastname,mobileno,mobileno1,mobileno2,AlternetNO,email,Email1,Email2,phone,fax,zipcode"+
					",address,city,state,country,companyname,designation) VALUES ('"+request.getParameter("customercode")+"','"+mcontactperson+"','"+request.getParameter("salutation")+"','"+request.getParameter("firstname")+"','"+request.getParameter("middlename")+"','"+request.getParameter("lastname")+"','"+request.getParameter("mobileno")+"','"+request.getParameter("mobileno1")+"','"+request.getParameter("mobileno2")+"','"+request.getParameter("alternetno")+"','"+request.getParameter("emailids")+"','"+request.getParameter("emailids1")+"','"+request.getParameter("emailids2")+"','"+request.getParameter("phoneno")+"','"+request.getParameter("faxno")+"','"+request.getParameter("zipcode")+"','"+request.getParameter("address").replaceFirst("'"," ")+"','"+request.getParameter("city")+"','"+request.getParameter("state")+"','"+request.getParameter("country")+"','"+request.getParameter("companyname")+"','"+request.getParameter("designation")+"')";
				}
                
				System.out.println("insert query---->>"+sql1);
				stmt1.executeUpdate(sql1);
				//response.sendRedirect("contactdetails.jsp?Type11=yes");
String isclose=request.getParameter("isclose");
String redirectString="";
if(request.getParameter("CustOfType").equals("Customer"))
{
	System.out.println("Ready To redirect to Customer");
	if(isclose.equalsIgnoreCase("true")){
		redirectString="alert.jsp?msg=Record Saved Successfully&goto=close.jsp";
	}else{
		redirectString="contactdetails.jsp?Type=Customer&save=yes&customercode="+request.getParameter("customercode")+"&companyname="+request.getParameter("companyname");
	}
	
	response.sendRedirect(redirectString);
}
else
{
	if(isclose.equalsIgnoreCase("true")){
		redirectString="alert.jsp?msg=Record Saved Successfully&goto=close.jsp";
	}else{
		redirectString="contactdetails.jsp?Type=Prosp&save=yes&customercode="+request.getParameter("customercode")+"&companyname="+request.getParameter("companyname");
	}
	System.out.println("Ready To redirect to Prospects");
	response.sendRedirect(redirectString);
}

      		}
		    catch(Exception e)
            {
		    	e.printStackTrace();
            }
}
catch(Exception e)
{
	out.print("#noting");
}
finally
{
	con1.close();
}

%>

