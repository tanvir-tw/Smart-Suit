<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
    <body>
        
        <%! 
        String tptext="";
        String tptext1="";
        %>
        <% 
        tptext = request.getParameter("sel");
        out.println(tptext);
        tptext1 = request.getParameter("name2");
        out.println(tptext1);
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
            Statement st1=conn1.createStatement();
            String sql="update "+session.getAttribute("CompanyMasterID").toString()+"customerdet set tallyname='"+tptext+"' where customercode="+tptext1;
            System.out.println(sql);
            st1.executeUpdate(sql);
            
        } catch (SQLException sqlException) {
            System.out.println(sqlException.getMessage());
        }
        
        catch (Exception e) {
        }
        response.sendRedirect("Tally_customer.jsp");
        %>
    </body>
</html>
