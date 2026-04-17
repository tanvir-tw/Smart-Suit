<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>
 --%>
 <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  
<%@ include file="conn.jsp"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>



<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st=con1.createStatement();
		Statement st1=con1.createStatement();//=Customer
		String type1=request.getParameter("save");
		String customername=request.getParameter("customername");
		out.println(""+customername);
		String sql="";
		String type=request.getParameter("Type");
		 String maddress="";
	        String mcity="";
	        String mcountry="";
	        String mstate="";
	        String mzip="";
	        String comptype="";
	        String CompName="";
	        String type12="";
	        String Code="",html="";
	        String CollectionStaff="";
	        ResultSet rs,rs1;
	        
	        System.out.println("Collection Staff query----111>>");
	        
          //System.out.println("In Customer Details");
	        //sql="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where CompanyName='"+customername+"' order by name asc";//test by romil
	        
	        if(customername.equals("") || customername=="")
	        {
	        	
	        }
	        else {
	        
	        
	        sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster order by name asc";
	           System.out.println("Collection Staff query----111>>"+sql);
	        
	           PreparedStatement pstmt = con1.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );

	        	rs= pstmt.executeQuery();
	        	if(rs.previous())
	        	{
	        		CollectionStaff=rs.getString("name");
		        	html+="<option>"+CollectionStaff+"</option>";
	        	}
	            while(rs.next()){
	        	 CollectionStaff=rs.getString("Name");
	        	html+="<option>"+CollectionStaff+"</option>";
	        }
	            
	            String FinalString=html;
	        out.println("<option value='Select' selected='selected'>Select</option>"+FinalString);
		
        
        
       
	        }
%>
</jsp:useBean>
