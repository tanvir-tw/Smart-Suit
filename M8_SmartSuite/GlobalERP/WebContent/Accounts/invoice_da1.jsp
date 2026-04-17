<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*" import="java.sql.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
    var t = new ScrollableTable(document.getElementById('invoice'), 100);
</script>

<script language="JavaScript1.2">


function popUp(Address,companyName,SalesEnqNo)
{
    //alert("pop");
    window.open(Address+'?companyName='+companyName+'&SalesEnqNo='+SalesEnqNo,'jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');

}

function conformAll() {
    alert("CONFRM");
    alert(document.getElementByName(customername.options[1].value));/*
    while (ob.selectedIndex != -1) {
    if (ob.selectedIndex != 0)
    arSelected.push(ob.options[ob.selectedIndex].value);
    ob.options[ob.selectedIndex].selected = false;
    }*/
}
</script>

<script type="text/javascript" src="scrollabletable.js"></script>

<SCRIPT LANGUAGE="JavaScript">

function checkAll()
{
var field=document.getElementsByName('checkbox1');
var i;
try{
for (i = 0; i < field.length; i++)
field[i].checked = true ;
}catch(e){alert(e);}
}

function unCheckAll()
{
var field=document.getElementsByName('checkbox1');
var i;
try{
for (i = 0; i < field.length; i++)
field[i].checked = false ;
}catch(e){alert(e);}
}

function OnSubmitForm()
{
  if(document.pressed == 'Transfer')
  {
   document.invoice.action ="Invoiceupdate.jsp";
  }
  else
  if(document.pressed == 'Update')
  {
    document.invoice.action ="update.html";
  }
  return true;
}
</script>

<style>
    table
    {
    text-align: left;
    font-size: 14px;
    font-family: verdana;
    background: #c0c0c0;
    }
    table thead  
    {
       cursor: pointer;
    }
    
    table thead tr,
    table tfoot tr {
    background: #c0c0c0;
    }
    
    table tbody tr
    {
    background: #f0f0f0;
    }
    
    td, th
    {
    border: 1px solid white;
    }
</style>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
Statement st=conn.createStatement();

String selectedName;
String FollowUpType="",status="";
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";

Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
if (!(null == request.getParameter("fromdate"))) {
    fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
    fromDateCal=request.getParameter("fromdate");
}
if (!(null == request.getParameter("todate"))){
    toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
    toDateCal=request.getParameter("todate");
}
%>

<div>&nbsp;</div>
<form name="invoice" method="post" onsubmit="return OnSubmitForm();">
    <div align="center">
        <table border="1">
            <tr>
                
                <td align="left">
                    <b> </b>&nbsp;&nbsp;
                    <input type="text" id="fromdate"
                           name="fromdate" value="<%=fromDateCal %>" size="15" 
                           style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
                    
                    <!--<input type="button" name="From Date" value="From Date" id="trigger">-->
                    <script type="text/javascript">
     Calendar.setup(
    {
    inputField  : "fromdate",         // ID of the input field
    ifFormat    : "%d-%b-%Y",     // the date format
    button      : "fromdate"       // ID of the button
    }
    );
                    </script>
                    
                    <b>To </b>&nbsp;&nbsp;
                    <input type="text" id="todate"
                           name="todate" value="<%=toDateCal %>" size="15" 
                           style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
                    
                    <script type="text/javascript">
    Calendar.setup(
    {
    inputField  : "todate",         // ID of the input field
    ifFormat    : "%d-%b-%Y",    // the date format
    button      : "todate"       // ID of the button
    }
    );
                    </script>
                    <input type="submit" name="submit" id="submit" style="border: outset;"
                       value="Go" /></td>
            </tr>
            
    </table></div>
    
    <div>&nbsp;</div>
    
    <table id="invoice" align="center" class='sortable' border="1">
        <tr>
            <th><div><a href="#" onclick="checkAll()">Check All</a> / <a href="#" onclick="unCheckAll()">Uncheck All</a></div></th>
            
            <th>Invoice Date</th>
            <th>Company Name</th>
            <th>City</th>
            <th>Total</th>
            <th>Discount</th>
            <th>C S T</th>
            <th>P F I</th>
            <th>Freight Amount</th>
            <th>Grand Total</th>
        </tr>
        <%
        try
        {
        String sqlEnq="";
        //""+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.PriceQuoted=0 AND a.SalesEnqDate BETWEEN '"+fromDate+"' and '"+toDate+"' GROUP BY a.SalesEnqRefNo, a.SalesEnqDate, a.SalesEnqType, a.CompanyName, a.CustRefNo, a.TWEmpName,a.SalesEnqNo LIMIT 10 ";
        //SalesEnqRefNo,SalesEnqDate,SalesEnqType,CompanyName,CustRefNo,
        //select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode where InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"'  order by InvoiceDate
        //sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet where InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"' order by invoicedate";
        //sqlEnq="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode where InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"'  order by InvoiceDate";
        sqlEnq="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode  INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as c on a.Invoiceno=c.Invoiceno where a.InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"' and a.twempname='Autogenerated'  order by a.InvoiceDate";
        //sqlEnq="SELECT a.SalesEnqRefNo, a.SalesEnqDate, a.SalesEnqType,                                                                                               a.CompanyName, a.CustRefNo, a.TWEmpName ,a.SalesEnqNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items AS b ON ( a.SalesEnqNo = b.SalesEnqNo ) WHERE a.CompanyName in ("+selectedName+") AND b.PriceQuoted =0 AND a.SalesEnqDate BETWEEN '"+fromDate+"'AND '"+toDate+"' GROUP BY a.SalesEnqRefNo, a.SalesEnqDate, a.SalesEnqType, a.CompanyName, a.CustRefNo, a.TWEmpName ,a.SalesEnqNo  LIMIT 10";
        
        System.out.println(sqlEnq);
        ResultSet rsEnq=st.executeQuery(sqlEnq);
        while(rsEnq.next()){
        %>
        <tr>
            <td width=75><div align="left" >
            <input type="checkbox" checked="yes"  name="checkbox1" value="<%=rsEnq.getString("invoiceno")%>" ><%=rsEnq.getString("invoiceno") %></div></td>
            <td><div align="left"><%=rsEnq.getString("InvoiceDate").substring(0,10)%></div></td>
            <td width="400"><div align="left"><%=rsEnq.getString("b.Companyname")%></div></td>
            <td><div align="left"><%=rsEnq.getString("City")%></div></td>
            <td><div align="right"><%=rsEnq.getString("Total")%></div></td>
            <td><div align="right"><%=rsEnq.getString("Discount")%></div></td>
            <td><div align="right"><%=rsEnq.getString("CST")%></div></td>
            <td><div align="right"><%=rsEnq.getString("PFI")%></div></td>
            <td><div align="right"><%=rsEnq.getString("FreightAmt")%></div></td>
            <td><div align="right"><%=rsEnq.getString("Grandtotal")%></div></td>  
        </tr>
        
        <%}
        }
        catch (Exception e)
        {
        e.printStackTrace();
        }
        %>
        <% //out.print(getQuarter(3));
        %>
    </table>
    <input type="submit" name="submit" id="submit" style="border: outset;"
                       value="Transfer" onclick="document.pressed=this.value" />
</form>
</body>
</html>