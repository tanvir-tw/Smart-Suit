 <%@ include file="conn.jsp" %>
 <%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>

<%@page import="java.util.Date"%>

<%!
Connection con1;
%>
<% 
try
{
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement stmt1=con1.createStatement();
		ResultSet rs1=null;
		String sql1="";
		//String received_data[]  =request.getParameter("mydata").split("zz",22);
		
	    try
		    {
				//sql1="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr (customercode,contactperson,salutation,"+
				//		"firstname,middlename,lastname,mobileno,email,phone,fax,zipcode"+
				//		",address,city,state,country,companyname,designation) VALUES ('"+request.getParameter("customercode")+"','"+mcontactperson+"','"+request.getParameter("salutation")+"','"+request.getParameter("firstname")+"','"+request.getParameter("middlename")+"','"+request.getParameter("lastname")+"','"+request.getParameter("mobileno")+"','"+request.getParameter("emailids")+"','"+request.getParameter("phoneno")+"','"+request.getParameter("faxno")+"','"+request.getParameter("zipcode")+"','"+request.getParameter("address")+"','"+request.getParameter("city")+"','"+request.getParameter("state")+"','"+request.getParameter("country")+"','"+request.getParameter("companyname")+"','"+request.getParameter("designation")+"')";				
                //System.out.println("insert query---->>"+sql1);
				//stmt1.executeUpdate(sql1);
				
				sql1 = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr (Customercode ,IntrestedProduct ,ContactPerson ,Address, "+
		         "City,Zip ,State ,Country ,Phone ,Fax ,EMail ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode)"     +        
		         "VALUES('"+request.getParameter("customercode")+"','"+request.getParameter("c_product")+"','"+request.getParameter("c_contactperson")+"','"+request.getParameter("address")+"',"+
		         "'"+request.getParameter("city")+"','"+request.getParameter("zipcode")+"','"+request.getParameter("state")+"','"+request.getParameter("country")+"','"+request.getParameter("phoneno")+"','"+request.getParameter("faxno")+"','"+request.getParameter("emailids")+"','"+request.getParameter("stdcode")+"','"+request.getParameter("mobileno")+"','0','"+request.getParameter("alternatenumber")+"','0')";
				System.out.println("insert query---->>"+sql1);
				 stmt1.executeUpdate(sql1);
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
response.sendRedirect("addressdetails.jsp?customercode="+request.getParameter("customercode")+"&companyname="+request.getParameter("companyname"));
%>

