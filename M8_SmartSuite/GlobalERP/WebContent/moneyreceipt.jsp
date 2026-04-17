<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date.*"%>
<%@ include file="conn.jsp"%>


<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="window.print()">
<style>
			body
			{
            margin: 0px;
            padding: 0px;
            font-family: verdana;
            font-size: small;
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
            border: thin solid;
            border-color:black;
            float: left;
            width: 80%;
            height: auto;
          
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
				font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
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
<%!
final String[] tensNames = {"", "", "Twenty", "Thirty", "Forty","Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
final String[] onesNames = {"", "One", "Two", "Three", "Four","Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve","Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
final int mconst = 1;
String toWords(long number)
{
       
	    System.out.println("I am here first"+mconst);
	    
	    long temp = number;
        long billions = temp/10000000;
        temp %= 10000000;
        long millions = temp/100000;
        temp %= 100000;
        long thousands = temp/1000;
        temp %= 1000;
        long hundreds = temp/100;
        temp %= 100;
       
        StringBuffer result = new StringBuffer(60);
        if (billions > 0) result.append(toWords(billions)+" Crore ");
        if (millions > 0) result.append(toWords(millions)+" Lakh ");
        if (thousands > 0) result.append(toWords(thousands)+" Thousand ");
        if (hundreds > 0) result.append (toWords(hundreds)+" Hundred ");
        if (temp != 0) {
            if (number >= 100) result.append("and ");
            if (0 < temp && temp <= 19) result.append(onesNames[(int)temp]);
            else {
                long tens = temp/10;
                long ones = temp%10;
                result.append(tensNames[(int)tens]+" ");
                result.append(onesNames[(int)ones]);
            }
        }
       
        return result.toString();
    }
%>
<form id="moneyreceipt" name="moneyreceipt" method="post" action="">

<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
		System.out.println("first time");
		String printReport = "moneyreceipt";//request.getParameter("printreport");
		String mmoneyreceiptno=request.getParameter("moneyreceiptno");
		System.out.println("moneyreceiptno"+mmoneyreceiptno);
		SimpleDateFormat format = new SimpleDateFormat("dd-MMM-yyyy"); 
    	String mtoday=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		java.util.Date d1 = null;
  		java.util.Date d2 = null;
        DecimalFormat df2 = new DecimalFormat( "0.00" );
        String voucherdate="",chequedate="";
      
        tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD,SID,PID,CMID);
    	Connection conn = null;
    	Statement st = null;
        conn = tally.ReturnConnection();
    	st = conn.createStatement();
    	String sql="";
    	sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet where ourcompanycode=1 limit 1";
    	ResultSet rs=st.executeQuery(sql);
    	String ourcompanyname="";
    	String ourcompanyaddress="";
    	String phoneno="Ph:";
    	String faxno="Fax:";
    	String email="Email:";
    	String website="Website:";
    	String panno="Pan No:";
    	if (rs.next())
    	{
    		ourcompanyname=rs.getString("ourcompanyname");
        	ourcompanyaddress=rs.getString("ourcompanyaddress");
        	phoneno=phoneno+rs.getString("phoneno");
        	faxno=faxno+rs.getString("faxno");
        	email=email+rs.getString("email");
        	website=website+rs.getString("website");
        	panno=panno+rs.getString("panno");
    	}
		if (printReport.equalsIgnoreCase("moneyreceipt"))
		{
			
			sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"collection as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.customercode=b.customercode where moneyreceiptno="+mmoneyreceiptno+" limit 1";
	    	rs=st.executeQuery(sql);
	    	String mpaymentvoucherno="";
	    	String mCustomername="";
	    	String InvoiceRefno="";
	    	String InvoiceRefDates="";
    		String mpaymentdate="";
    		String mchorddorcreditnoteno="";
    		String mchorddorcreditnotedate="";
    		String mamountpaid="";
    		String minvoiceno="";
    		String mbankname="";
    		String mbranchname="";
    		String mcity="";
    		String mremarks="";
    		String mcustomercode="";
    		String mpaymentmode="";
    		String mtallyrefno="";
    		String mauth_by="";
    		String mauth_on="";
    		String minserdt="";
    		String mtwempname="";
    		String mded_type="";
    		String mded_amount="";
    		String amountRS="";
    		long l=0;
	    	if (rs.next())
	    	{
	    		mpaymentvoucherno = rs.getString("a.paymentvoucherno");
	    		mpaymentdate =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("a.paymentdate")));
	    		mchorddorcreditnoteno = rs.getString("a.chorddorcreditnoteno");
	    		mchorddorcreditnotedate =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("a.chorddorcreditnotedate")));
	    		mamountpaid = rs.getString("a.amountpaid");
	    		l = rs.getLong("a.amountpaid");
	    		minvoiceno = rs.getString("a.invoiceno");
	    		mbankname = rs.getString("a.bankname");
	    		mbranchname = rs.getString("a.branchname");
	    		mcity = rs.getString("a.city");
	    		mremarks = rs.getString("a.remarks");
	    		mcustomercode = rs.getString("a.customercode");
	    		mpaymentmode = rs.getString("a.paymentmode");
	    		mtallyrefno = rs.getString("a.tallyrefno");
	    		mauth_by = rs.getString("a.auth_by");
	    		mauth_on = rs.getString("a.auth_on");
	    		minserdt = rs.getString("a.inserdt");
	    		mtwempname = rs.getString("a.twempname");
	    		mded_type = rs.getString("a.ded_type");
	    		mded_amount = rs.getString("a.ded_amount");
	    		mCustomername=rs.getString("b.companyname");
	    	}
	    	sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"collectioninv where moneyreceiptno="+mmoneyreceiptno;
	    	rs=st.executeQuery(sql);
	    	
	    	while (rs.next())
	    	{
	    		InvoiceRefno=InvoiceRefno+rs.getString("invrefno")+"/";
	    		InvoiceRefDates=InvoiceRefDates+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("transactiondate")))+"/";
	    	}
	    	String mamountinwords="Rupees "+toWords(l)+" only";
	    	String copyflag="Original";
			int i = 1;
			while (i<=2)
			{
				if (i==2)
				{
					copyflag="Office Copy";
				}
				%>
				<div style="width:80%; text-align: right;"><%=copyflag %></div>
				<div id="content">
	    		<table style="border:thin solid;width:100%;">
	    		<tr >
	    		<td style="text-align:center;" >
	    		<span style="font-size:larger;"><b><%=ourcompanyname %></b></span>
		        </td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:center;" >
	     		<%=ourcompanyaddress %>
	     		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:center;" >
	     		<%=phoneno+" "+faxno %>
	     		</td>
	    		</tr>
	    		<tr>
	    		<td style="text-align:center;" >
	     		<%=email+" "+website %>
	     		</td>
	    		</tr>
	    		<tr>
	    		<td style="text-align:center;" >
	     		<%=panno%>
	     		</td>
	    		</tr>
	    		</table>
	    		<table style="border:thin solid;width:100%;">
	    		<tr >
	    		<td colspan="2" style="text-align:center;" >
	     		<span style="font-size:larger;"><b>Money Receipt</b></span>
	     		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:left;" >
	     		</td>
	    		</tr>
	    		<tr>
	    		<td style="text-align:left;width:50%;" >
         		 Date:<%=mpaymentdate%></td>
         		<td style="width:50%;"><b>Receipt No:<%=mpaymentvoucherno %></b>
	     		</td>
	    		</tr>
			    <tr>
	    		<td colspan="2" style="text-align:left;" >
  			    </td>
	    		</tr>
			    <tr >
	    		<td colspan="2" style="text-align:left;" >
	    		 Received with thanks from <b><%=mCustomername%> </b> 
	     		</td>
	    		</tr>
			    <tr >
	    		<td colspan="2" style="text-align:left;" >
         		 sum of  <%=mamountinwords%> [ Rs: <b><%=mamountpaid %></b>/- ]
	     		</td>
	    		</tr>
			    <tr >
	    		<td colspan="2" style="text-align:left;" >
         		towards Invoice No(s): <%=InvoiceRefno %>          dated:  <%=InvoiceRefDates %>         in part / full  
	     		</td>
	    		</tr>
			    <tr >
	    		<td colspan="2" style="text-align:left;" >
         		settlement by Cheque <%=mchorddorcreditnoteno%>     dated<%=mchorddorcreditnotedate %>            drawn on <%=mbankname+" "+mbranchname+" "+mcity%>;   
	     		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:left;" >
			    </td>
	    		</tr>
	     		<tr >
	    		<td style="text-align:left;" >
            	</td>
	    		</tr>
	    		</table>
			    <table style="border:thin solid;width:100%;">
	    		<tr >
	    		<td style="text-align:left;width:50%;" >
         		<div style="border:thin solid;width:30%;height:22'">
         		<b>Rs: <%=mamountpaid %>/-</b>
         		</div>            
	     		</td>
	     		<td style="text-align:right;width:50%;">
	     		<b>AUTHORISED SIGNATORY</b>
	     		</td>
	    		</tr>
	    		<tr >
	    		<td>
          		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:right;" >
        		 </td>
	    		</tr>
	    		<tr>
	    		<td></td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:left;" >
        		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:left;" >
        		</td>
	    		</tr>
	    		<tr >
	    		<td style="text-align:left;" >
        		</td>
	    		</tr>
	    		<tr>
	    		<td style="text-align:left; width:70%" >
         		THIS RECEIPT IS VALID SUBJECT TO REALISATION OF CHEQUE
         		</td>
	    		<td style="text-align:right;" >
	    		<%=session.getAttribute("EmpName") %>
        		 </td>
	    		</tr>	
	    		</table>
	    		</div>
	<%
	        i++;
			}		
		}
		if (printReport.equalsIgnoreCase("creditnote"))
		{
	
	
	
		}

%>

</form>
</body>

</html>
</jsp:useBean>