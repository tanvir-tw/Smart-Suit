<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<html>
    <STYLE TYPE="text/css">
      td {font-family: Verdana; font-size: 18pt;}
    </STYLE>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tally Customer</title>
</head>
<body>
        <div>&nbsp;</div>
        <form name="tally" method="post" action="Tallyupdate.jsp"  >
            <table border="1" align="center" >
                <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
                    Statement st1=conn1.createStatement();
                    String sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname IS NULL limit 1";
                    System.out.println(sql1);
                    ResultSet rs1=st1.executeQuery(sql1);
                    String name1;
                    String name2;
                %>
                <%
                while(rs1.next()) {
                        name1= rs1.getString("companyname");
                        name2=rs1.getString("customercode");
                %>
                <td width="400"><%=name2+' '+name1%><input type="hidden" id ="v" name="name2" value="<%=name2%>"/></td>
                <%
                }
                    rs1.close();
                    Statement st2=conn1.createStatement();
                    String sql2="select * from "+session.getAttribute("CompanyMasterID").toString()+"tallycustomer";
                    System.out.println(sql2);
                    ResultSet rs2=st2.executeQuery(sql2);
                %>
                <td width="400"><select name="sel" style = "font-size: 15pt" ><option value="sel">SELECT</option><%
                    while(rs2.next()) {
                        String name = rs2.getString("companyname");
                        String id = rs2.getString("companyname");
                    %><option value="<%=name%>"><%=name%></option>
                    <%
                    }
                %></select></td><%
                } catch(Exception e) {
                    out.println(e);
                }
                %>
                <td><input type="submit" name="submit" id="submit" style="border: outset;" value="Update" /></td>
            </table>
        </form>
        <% 
        String option = request.getParameter("sel");
        if (option==null) {
        } else {
            out.println(option);
        }
        %>
    </body>
</html>
