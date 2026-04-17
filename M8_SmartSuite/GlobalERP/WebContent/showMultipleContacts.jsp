<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="css/style2.css" rel="stylesheet" type="text/css"
	media="screen" />
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<link href="css/table.css" rel="stylesheet" type="text/css"
	media="screen" />
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<style>
			body
			{
            margin: 0px;
            padding: 0px;
            }
            
            #divheader
            {
            height:50;
            background:	White;
            }
            
            #header 
            {
            background: #2675a8;
            font:large;
            color:green;
            width: 100%;
            }
            
            #leftcolumn 
            {
            background:#0099CC;
            float: left;
            width: 35%;
            height: 400px;
            }
            
            #content 
            {
            border:medium;
            border-color:blue;
            background: ;
            float: left;
            width: 100%;
            height: 400px;
            /*overflow:scroll;*/
            }
            
            #myfooter 
            {
            background: #df781c;
            clear: both;
            width: 100%;
            }
            #tooltip
            {
  			  	position:relative;
    			font-family:arial,sans-serif;
    			font-size:10px;
    			color:#000;
    			padding:3px;
    			border:1px solid #000;
    			background-color:#ffe;
			}
			table.mysortable
			{
				text-align: left;
				font-family: Arial,Verdana, Geneva , Helvetica, sans-serif ;
				font-weight: normal;
				font-size: 11px;
				color: #fff;
				background-color: #1581AB; <!-- -->
				border: 0px;
				border-collapse: collapse;
				border-spacing: 0px;
			}

			table.mysortable td
			{
				background-color: #F8F8FF;
				color: #000;
				padding: 4px;
				border: 1px #808080 solid;
			}
			table.mysortable th
			{
				background-color: #1581AB;
				color: white;
				padding: 4px;
				border: 1px #808080 solid;
			}

			table.mysortable td.hed
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

			table.mysortable td.hed1
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

</style>

<head>





<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">









<script type="text/javascript">
function openpopup(PageName)
{
	 try{
		 //alert(e);
	 testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"Register Complaint","width=700,height=400,scrollbars=yes");
	 testwindow.moveTo(200,200);
	 }catch(e)
	 {
		 alert(e);
	 }
}
</script>
</head>
<body>
<%
	  	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>

<%!
Connection con1;
%>
<%
        Class.forName(DB_Driver);
        con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
        Statement st=con1.createStatement();
		String sql1="";

		
		
		String PageName=this.getClass().getName();
		String reportno = "";
		PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
		System.out.println(PageName);
		PageName=PageName.replace("_",".");
		PageName=PageName.replace(".005f","_");
		PageName = PageName.replace(".0020"," ");
		System.out.println("PageName   "+PageName);
		String sqlreport = "select ReportNo from t_reportnumber where PageName = '"+PageName+"'";
		ResultSet rsreport = st.executeQuery(sqlreport);
		if(rsreport.next())
		{
			reportno = rsreport.getString("ReportNo");
		}
		System.out.println(reportno);
		
		
		
		
        if(request.getParameter("Type").equals("Customer") )
         {
        	System.out.println("In Customer Details");
		    sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode="+request.getParameter("companyCode")+" AND mobileno <> 'null'  order by firstname,middlename,lastname";				
            System.out.println("customer query---->>"+sql1);
         }
        else
        {
        	System.out.println("In Prospests Details");
        	sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode="+request.getParameter("companyCode")+" AND mobileno <> 'null' order by firstname,middlename,lastname";				
            System.out.println("customer query---->>"+sql1);
        }
            ResultSet rs1= st.executeQuery(sql1);
        %>
           <div>
<a href="#" onclick="openpopup('<%=PageName %>')" title="Register Complaint"><font face="Arial" size="2" color="blue">Register Complaint</font></a>
		 &nbsp;&nbsp;&nbsp;
		<font face="Arial" size="2" color="black"> Report No.: <%=reportno %></font>

</div> 
        <table class="mysortable" style="width:100%;background-color: #457FC2;"><tr><td style="background-color: #457FC2;color:white;border:thin solid white;height:32px;text-align:center;"><h3 style="color:white">Contact List</h4></td></tr></table>
    		
        <div style="overflow:auto;"></div>
        <table class="mysortable"><tr >
        <th style="width:70px;">Sr.No</th>
        <th style="width:500px;">Contact Person</th>
        <th style="width:200px;">Mobile No</th>
        <th style="width:300px;">Email ID</th>
        
        </tr>
        <%
        int i = 1;
        while (rs1.next())
    	{
    		%>
    		<tr>
    		<td align="right">
    		<%=i%>
    		</td>
    		<td align="left">
    		<%=rs1.getString("contactperson") %>
    		</td>
    		<td align="right">
    		<%=rs1.getString("mobileno") %>
    		</td>
    		<td align="left">
    		<%=rs1.getString("email") %>
    		</td>
    		</tr>	
    		<%
    		i++;
    	}
        %>
        </table>
        <br></br>
			<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
</body>
</html>
</jsp:useBean>