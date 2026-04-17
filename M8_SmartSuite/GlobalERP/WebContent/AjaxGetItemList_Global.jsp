<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.regex.Pattern"%>
<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<%
boolean ex=false;
try {
	String companyid=session.getAttribute("CompanyMasterID").toString();
System.out.println("reach Ajax page");
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
Statement st_po=con1.createStatement();
Statement st_pi=con1.createStatement();
ResultSet rs_pi1=null;
ResultSet rs_pi2=null;
ResultSet rs1=null,rs_po=null,rs2=null;
String sql1="",sql2="";
boolean flag=false;
String CompanyMasterId=(String)session.getAttribute("CompanyMasterID");
String A = request.getParameter("limitcount");
int limit=30;
int ccount=0;
boolean showmore=false;
int countlimit=0;
int count=0,flg=1;
int limitcnt = Integer.parseInt(A);
System.out.println("--limitcnt--"+limitcnt+"-----"+limit);
String item=request.getParameter("item");
String  searchBy=request.getParameter("searchBy");
String fromdate="",todate="",all="";
try{
	fromdate=request.getParameter("fromdate");
	 todate=request.getParameter("todate");
	all=request.getParameter("all");
	System.out.println(fromdate+"----"+todate+"----"+all);
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
	
	if(all.equalsIgnoreCase("true")){
		System.out.println("inside All");
		fromdate="1980-01-01";
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}
	
	System.out.println(fromdate+"----"+todate+"----"+all);
	
}catch(Exception e){ e.printStackTrace(); }
System.out.println(item+"--"+searchBy);
if(searchBy.equalsIgnoreCase("Item")){
	////System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	////System.out.println("limit "+limit);
	
	//System.out.println("1");
// 	  sql1="(SELECT distinct(Description)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('"+item.replace(" ","")+"%') order by Description) "+
// 	  " UNION "+
// 	  " (SELECT distinct(Description)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('%"+item.replace(" ","")+"%') order by Description) limit 50 ";
	sql1=" SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitems where Description like ('%"+item+"%') order by Description limit "+limit+"";
	sql2=" SELECT COUNT(*) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitems where Description like ('%"+item+"%') order by Description ";
}
else if(searchBy.equalsIgnoreCase("Company")){
	System.out.println("Company");
	////System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	////System.out.println("limit "+limit);
	
// 	sql1="(SELECT distinct(makename)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(makename,' ','') like ('"+item+"%') order by makename) "+
// 	  " UNION "+
// 	  " (SELECT distinct(makename)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(makename,' ','') like ('%"+item+"%') order by makename) limit 50 ";
sql1="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  100000searchitems WHERE makename like '%"+item+"%' ORDER BY makename limit "+limit;
sql2="SELECT  COUNT(*)  FROM  100000searchitems WHERE makename like '%"+item+"%' ORDER BY makename";

}
else if(searchBy.equalsIgnoreCase("Model")){
	System.out.println("Model");
	////System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	////System.out.println("limit "+limit);
	
// 	sql1="(SELECT distinct(Model)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Model,' ','') like ('"+item+"%') order by Model) "+
// 	  " UNION "+
// 	  " (SELECT distinct(Model)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Model,' ','') like ('%"+item+"%') order by Model) limit 50 ";
	sql1="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  100000searchitems WHERE Model like '%"+item+"%' ORDER BY Model limit "+limit;
	sql2="SELECT  COUNT(*)  FROM  100000searchitems WHERE Model like '%"+item+"%' ORDER BY Model";
}
else if(searchBy.equalsIgnoreCase("Part")){
	System.out.println("4");
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
// 	sql1="(SELECT distinct(PartNo)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(PartNo,' ','') like ('"+item+"%') order by PartNo) "+
// 	  " UNION "+
// 	  " (SELECT distinct(PartNo)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(PartNo,' ','') like ('%"+item+"%') order by PartNo) limit 50 ";
	sql1="SELECT  makename,makecode,ItemCode,Model,PartNo,groupcode,Description,makedettable  FROM  100000searchitems WHERE PartNo like '%"+item+"%' ORDER BY PartNo limit "+limit;
	sql2="SELECT  COUNT(*)  FROM  100000searchitems WHERE PartNo like '%"+item+"%' ORDER BY PartNo ";
}
else if(searchBy.equalsIgnoreCase("Supplier")){
	System.out.println("5");
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	sql1="(SELECT distinct(SupplierName),SupplierCode  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('"+item+"%') order by SupplierName) "+
	  " UNION "+
	  " (SELECT distinct(SupplierName),SupplierCode  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('%"+item+"%') order by SupplierName) limit  "+limit;
	sql2="(SELECT COUNT(*)  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('"+item+"%') order by SupplierName) "+
			  " UNION "+
			  " (SELECT COUNT(*)  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('%"+item+"%') order by SupplierName) ";
}
else if(searchBy.equalsIgnoreCase("PO")){
System.out.println("krn");
String PONo="";
//System.out.println("limit "+limit);
limit=limit+(10*limitcnt);
//System.out.println("limit "+limit);

if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
	System.out.println("Search by PONo");
	PONo = item;
	ex=true;
    //sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where PONo like ('%"+PONo+"%') limit 50";
	sql1="SELECT * FROM  "+companyid+"purchaseorder  as a INNER JOIN 100000supplierdet as b on (a.Suppliercode = b.SupplierCode) where  PONo like '%"+item+"%' AND PODate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   Order by  a.PODate Desc limit "+limit+"";
	sql2="SELECT COUNT(*) FROM  "+companyid+"purchaseorder  as a INNER JOIN 100000supplierdet as b on (a.Suppliercode = b.SupplierCode) where  PONo like '%"+item+"%' AND PODate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   Order by  a.PODate Desc ";
}else{
	ex=false;
	System.out.println("Search By Supplier");
	//sql1="select a.PONo,a.Total,PODate,b.SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder a,"+session.getAttribute("CompanyMasterID").toString()+"supplierdet b where a.PONo like '%"+item+"%' OR  b.SupplierName like '%"+item+"%' order by PODate  desc  limit 50";
	//sql1="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where  SupplierName like '%"+item+"%'  limit 50";
	sql1="SELECT * FROM  "+companyid+"purchaseorder  as a INNER JOIN 100000supplierdet as b on (a.Suppliercode = b.SupplierCode) where  (SupplierName like '%"+item+"%' OR SentBy like '%"+item+"%')  AND PODate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   Order by  a.PODate Desc limit "+limit+"";
	sql2="SELECT COUNT(*) FROM  "+companyid+"purchaseorder  as a INNER JOIN 100000supplierdet as b on (a.Suppliercode = b.SupplierCode) where  (SupplierName like '%"+item+"%' OR SentBy like '%"+item+"%')  AND PODate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   Order by  a.PODate Desc";
}
}
else if(searchBy.equalsIgnoreCase("PI")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by Eqry number**");
	//sql1="select * from "+CompanyMasterId+"purchaseenq where PurchaseEnqNo like '%"+item+"%'  order by PurEnqDate desc";
	sql1=" SELECT  * FROM  "+companyid+"purchaseenq  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurEnqDate between '"+fromdate+"' and '"+todate+"' AND  a.PurchaseEnqNo like '%"+item+"%'  Order by a.PurEnqDate  Desc limit "+limit;
	sql2=" SELECT  COUNT(*) FROM  "+companyid+"purchaseenq  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurEnqDate between '"+fromdate+"' and '"+todate+"' AND  a.PurchaseEnqNo like '%"+item+"%'  Order by a.PurEnqDate  Desc ";
	}else{
		ex=false;
	System.out.println("Search by Eqry name**");
	sql1=" SELECT  * FROM  "+companyid+"purchaseenq  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurEnqDate between '"+fromdate+"' and '"+todate+"' AND (a.SentBy like '%"+item+"%'  OR  SupplierName like '%"+item+"%') Order by a.PurEnqDate  Desc limit "+limit;
	sql2=" SELECT  COUNT(*) FROM  "+companyid+"purchaseenq  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurEnqDate between '"+fromdate+"' and '"+todate+"' AND (a.SentBy like '%"+item+"%'  OR  SupplierName like '%"+item+"%') Order by a.PurEnqDate  Desc ";
	}
	}
else if(searchBy.equalsIgnoreCase("PQ")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	System.out.println("PQ");
	System.out.println("Search by Eqry name");
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
		System.out.println("Search by number");
		sql1="SELECT * FROM  "+companyid+"purchasequo  as a INNER JOIN "+companyid+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurQuoNo like '%"+item+"%' AND a.PurQuoDate between '"+fromdate+"' and '"+todate+"' order by a.PurQuoDate Desc limit "+limit;
		sql2="SELECT COUNT(*) FROM  "+companyid+"purchasequo  as a INNER JOIN "+companyid+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurQuoNo like '%"+item+"%' AND a.PurQuoDate between '"+fromdate+"' and '"+todate+"' order by a.PurQuoDate Desc ";
	}else{
		ex=false;
		System.out.println("Search by name");
		sql1=" SELECT * FROM  "+companyid+"purchasequo  as a INNER JOIN "+companyid+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where b.SupplierName like '%"+item+"%' AND a.PurQuoDate between '"+fromdate+"' and '"+todate+"' order by a.PurQuoDate Desc limit "+limit;
		sql2=" SELECT COUNT(*) FROM  "+companyid+"purchasequo  as a INNER JOIN "+companyid+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where b.SupplierName like '%"+item+"%' AND a.PurQuoDate between '"+fromdate+"' and '"+todate+"' order by a.PurQuoDate Desc ";
	}
	
}else if(searchBy.equalsIgnoreCase("PIn")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1="SELECT * FROM  "+CompanyMasterId+"purchaseinvoice  as a INNER JOIN "+CompanyMasterId+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurInvoiceNo like '%"+item+"%' AND a.PurInvoiceDate  between '"+fromdate+"' and '"+todate+"' Order By a.PurInvoiceDate Desc limit "+limit;
	sql2="SELECT COUNT(*) FROM  "+CompanyMasterId+"purchaseinvoice  as a INNER JOIN "+CompanyMasterId+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurInvoiceNo like '%"+item+"%' AND a.PurInvoiceDate  between '"+fromdate+"' and '"+todate+"' Order By a.PurInvoiceDate Desc";
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1="SELECT * FROM  "+CompanyMasterId+"purchaseinvoice  as a INNER JOIN "+CompanyMasterId+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where  b.SupplierName like '%"+item+"%' AND a.PurInvoiceDate  between '"+fromdate+"' and '"+todate+"' Order By a.PurInvoiceDate Desc limit "+limit;
	sql2="SELECT COUNT(*) FROM  "+CompanyMasterId+"purchaseinvoice  as a INNER JOIN "+CompanyMasterId+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where  b.SupplierName like '%"+item+"%' AND a.PurInvoiceDate  between '"+fromdate+"' and '"+todate+"' Order By a.PurInvoiceDate Desc";
	//SupplierName
	}
	}
else if(searchBy.equalsIgnoreCase("SO")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1="SELECT * FROM "+companyid+"salesorder_det AS a LEFT OUTER JOIN "+companyid+"salesorder_items AS b  ON ( a.SalesOrderNo = b.SalesOrderNo )  WHERE  a.SOCancelled =0 AND a.SalesorderRefNo like '%"+item+"%' AND a.SalesOrderDate BETWEEN '"+fromdate+"' and '"+todate+"'  GROUP BY a.SalesorderRefNo, a.SalesOrderDate, a.OrderType, a.CompanyName, a.TWEmpName,a.SalesOrderNo order by SalesOrderDate desc limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"salesorder_det WHERE  SOCancelled =0 AND SalesorderRefNo like '%"+item+"%' AND SalesOrderDate BETWEEN '"+fromdate+"' and '"+todate+"'  order by SalesOrderDate desc ";
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1="SELECT * FROM "+companyid+"salesorder_det AS a LEFT OUTER JOIN "+companyid+"salesorder_items AS b  ON ( a.SalesOrderNo = b.SalesOrderNo )  WHERE  a.SOCancelled =0 AND (a.CompanyName like '%"+item+"%' OR a.TWEmpName like '%"+item+"%' OR a.CurrType like '%"+item+"%') AND a.SalesOrderDate BETWEEN '"+fromdate+"' and '"+todate+"'  GROUP BY a.SalesorderRefNo, a.SalesOrderDate, a.OrderType, a.CompanyName, a.TWEmpName,a.SalesOrderNo order by SalesOrderDate desc limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"salesorder_det  WHERE  SOCancelled =0 AND (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%' OR CurrType like '%"+item+"%') AND SalesOrderDate BETWEEN '"+fromdate+"' and '"+todate+"'  order by SalesOrderDate desc";
	//SupplierName
	}
}else if(searchBy.equalsIgnoreCase("SE")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1=" SELECT * FROM  "+companyid+"salesenq_det  where SalesEnqRefNo like '%"+item+"%'  AND SalesEnqDate between '"+fromdate+"' and '"+todate+"' order by SalesEnqDate desc limit "+limit;
	sql2=" SELECT COUNT(*) FROM  "+companyid+"salesenq_det  where SalesEnqRefNo like '%"+item+"%'  AND SalesEnqDate between '"+fromdate+"' and '"+todate+"' order by SalesEnqDate desc";
	
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1=" SELECT * FROM  "+companyid+"salesenq_det  where (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND SalesEnqDate between '"+fromdate+"' and '"+todate+"' order by SalesEnqDate desc limit "+limit;
	sql2=" SELECT COUNT(*) FROM  "+companyid+"salesenq_det  where (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND SalesEnqDate between '"+fromdate+"' and '"+todate+"' order by SalesEnqDate desc";
	}
}
else if(searchBy.equalsIgnoreCase("SQ")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1="SELECT * FROM "+companyid+"salesquo_det WHERE  SalesquoRefNo like '%"+item+"%' AND SalesQuoDate BETWEEN '"+fromdate+"' and '"+todate+"' ORDER BY SalesQuoNo DESC limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"salesquo_det WHERE  SalesquoRefNo like '%"+item+"%' AND SalesQuoDate BETWEEN '"+fromdate+"' and '"+todate+"' ORDER BY SalesQuoNo DESC";
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1="SELECT * FROM "+companyid+"salesquo_det WHERE  (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND SalesQuoDate BETWEEN '"+fromdate+"' and '"+todate+"'  ORDER BY SalesQuoNo DESC limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"salesquo_det WHERE  (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND SalesQuoDate BETWEEN '"+fromdate+"' and '"+todate+"'  ORDER BY SalesQuoNo DESC ";
	//SupplierName
	}
}
else if(searchBy.equalsIgnoreCase("SI")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1="SELECT * FROM "+companyid+"invoicedet as a  LEFT OUTER JOIN "+companyid+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo)  where invoiceRefNo like '%"+item+"%' AND  a.InvoiceDate BETWEEN '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' GROUP BY a.invoiceRefNo, a.InvoiceDate, a.CompanyName, a.TWEmpName,a.InvoiceNo Order By a.InvoiceDate Desc limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"invoicedet as a  LEFT OUTER JOIN "+companyid+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo)  where invoiceRefNo like '%"+item+"%' AND  a.InvoiceDate BETWEEN '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  Order By a.InvoiceDate Desc limit "+limit;
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1="SELECT * FROM "+companyid+"invoicedet as a  LEFT OUTER JOIN "+companyid+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) where ( CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND  a.InvoiceDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' GROUP BY a.invoiceRefNo, a.InvoiceDate, a.CompanyName, a.TWEmpName,a.InvoiceNo Order By a.InvoiceDate Desc limit "+limit;
	sql2="SELECT COUNT(*) FROM "+companyid+"invoicedet as a  LEFT OUTER JOIN "+companyid+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) where ( CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND  a.InvoiceDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  Order By a.InvoiceDate Desc ";
	//SupplierName
	}
}
else if(searchBy.equalsIgnoreCase("SPI")){
	System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	System.out.println("limit "+limit);
	if (!(Pattern.matches("[0-9]+", item) == false && item.length() > 2)) {
		ex=true;
	System.out.println("Search by number");
	sql1="SELECT * FROM "+companyid+"performainvoicedet as a  LEFT OUTER JOIN "+companyid+"performainvoice_items as b ON(a.InvoiceNo=b.InvoiceNo)  WHERE a.InvoiceCancelled=0  AND a.invoiceRefNo like '%"+item+"%' AND a.InvoiceDate  between '"+fromdate+"' and '"+todate+"'  GROUP BY a.invoiceRefNo, a.InvoiceDate, a.CompanyName, a.TWEmpName,a.InvoiceNo order by InvoiceDate desc limit "+limit+"";
	sql2="SELECT COUNT(*) FROM "+companyid+"performainvoicedet as a  LEFT OUTER JOIN "+companyid+"performainvoice_items as b ON(a.InvoiceNo=b.InvoiceNo)  WHERE a.InvoiceCancelled=0  AND a.invoiceRefNo like '%"+item+"%' AND a.InvoiceDate  between '"+fromdate+"' and '"+todate+"'   order by InvoiceDate desc";
	sql2="SELECT COUNT(*) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  WHERE InvoiceCancelled=0  AND invoiceRefNo like '%"+item+"%'  AND InvoiceDate BETWEEN '"+fromdate+"' and '"+todate+"'";
	}else{
		ex=false;
	System.out.println("Search by name");
	sql1="SELECT * FROM "+companyid+"performainvoicedet as a  LEFT OUTER JOIN "+companyid+"performainvoice_items as b ON(a.InvoiceNo=b.InvoiceNo)  WHERE a.InvoiceCancelled=0  AND (a.CompanyName like '%"+item+"%' OR a.TWEmpName like '%"+item+"%') AND a.InvoiceDate BETWEEN '"+fromdate+"' and '"+todate+"'  GROUP BY a.invoiceRefNo, a.InvoiceDate, a.CompanyName, a.TWEmpName,a.InvoiceNo order by InvoiceDate desc limit "+limit+"";
	//sql2="SELECT COUNT(*) FROM "+companyid+"performainvoicedet as a  LEFT OUTER JOIN "+companyid+"performainvoice_items as b ON(a.InvoiceNo=b.InvoiceNo)  WHERE a.InvoiceCancelled=0  AND (a.CompanyName like '%"+item+"%' OR a.TWEmpName like '%"+item+"%') AND a.InvoiceDate BETWEEN '"+fromdate+"' and '"+todate+"'  order by InvoiceDate desc";
	sql2="SELECT COUNT(*) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  WHERE InvoiceCancelled=0  AND (CompanyName like '%"+item+"%' OR TWEmpName like '%"+item+"%') AND InvoiceDate BETWEEN '"+fromdate+"' and '"+todate+"'";
	//SupplierName
	}
}
else if(searchBy.equalsIgnoreCase("cust")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	sql1="select * from "+companyid+"prospectivecustmaster where (CompanyName like '%"+item+"%' OR city like '%"+item+"%' OR ContactPerson like '%"+item+"%') AND SalesCustomerCode <>0 order by Updatedatetime desc limit "+limit+"";
	sql2="select COUNT(*) from "+companyid+"prospectivecustmaster where (CompanyName like '%"+item+"%' OR city like '%"+item+"%' OR ContactPerson like '%"+item+"%') AND SalesCustomerCode <>0";
}
else if(searchBy.equalsIgnoreCase("pros")){
	//System.out.println("limit "+limit);
	limit=limit+(10*limitcnt);
	//System.out.println("limit "+limit);
	sql1="select * from "+companyid+"prospectivecustmaster where (CompanyName like '%"+item+"%' OR city like '%"+item+"%' OR ContactPerson like '%"+item+"%') AND SalesCustomerCode=0 order by Updatedatetime desc limit "+limit+"";
	sql2="select COUNT(*) from "+companyid+"prospectivecustmaster where (CompanyName like '%"+item+"%' OR city like '%"+item+"%' OR ContactPerson like '%"+item+"%') AND SalesCustomerCode=0";
}



//SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE  SalesQuoDate BETWEEN '2015-05-30' and '2015-06-29' ORDER BY SalesQuoNo DESC 
	int totalrecords=0;
	System.out.println("---1>>"+sql1);
	System.out.println("---3>>"+sql2);
	try{
	rs1=stmt1.executeQuery(sql1);
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next()){
		totalrecords=rs2.getInt(1);
	}
		System.out.println("---RowCount - >>"+totalrecords );
		if(totalrecords>limit){
	 		showmore=true;
	 		System.out.println("in if");
	 	}
	}catch(Exception e){e.printStackTrace();}

 System.out.println("---2>>"+sql1);
 String buffer="<div style='height:auto;width:100%;overflow:auto;'><table border='1' class='sortable' style='width:100%; overflow:auto;'>";
 int i=1;String val="",val1="";
 String pono="",PODate="";
 String SupplierCode="",SupplierName="";
 String amount="";
 String SupplierSQL="";
 String refno="";
 String total="";
 String sup_name="";
 String pq_no="";
 String pi_date="";
 String Supp="";
 String status="";
 String purdate="";
 String duedate="";
 if(searchBy.equalsIgnoreCase("PO")){
	 System.out.println("-----PO");
	 Statement st_su=con1.createStatement();
	 ResultSet rs_su=null;
//  	 try{
// 		 System.out.println("KK int");
// 		 int kk=rs1.getInt("count");	
// 	 System.out.println("KK "+kk);
// 	 }catch(Exception e){e.printStackTrace();}
//  	try{
// 		 System.out.println("KK string");
// 		 String kk=rs1.getString("count");	
// 	 System.out.println("KK "+kk);
// 	 }catch(Exception e){e.printStackTrace();}
 	
 	
 	
	 if(!rs1.isBeforeFirst())
	 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
	 	else
	 		buffer+="<tr><th>Sr No</th><th>Enquiry Number</th><th>Supplier</th><th>Order Date</th><th>Total</th><th>Sign</th></tr>";
	 while(rs1.next())
	   {
		 System.out.println("---RowCount - >>"+rs1.getFetchSize() );
		   //System.out.println("1");
			  try{
		      val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
			  val1=rs1.getString("a.PONo").replace("\"","`");
			  SupplierName=rs1.getString("SupplierName");
			//  sign=rs1.getString("SentBy");
			 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("PODate"));
// 			 try{
// 			 duedate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("DueDate")));
// 			 }catch(Exception e){
// 				 System.out.println("-----PO");
// 				 e.printStackTrace();
// 				 duedate="00-00-0000"; 
// 			 }
			  	  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showPO(\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+val1.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' onClick='showPO(\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+SupplierName.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td>"+rs1.getString("GrandTotal")+"</td><td><a href='#' onClick='showPO(\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("SentBy").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   
		   //onClick='showPO(\""+pono+"\",\""+searchBy+"\")'
		   
// 		   try{
// 		   SupplierName=rs1.getString("SupplierName");
// 		   amount=rs1.getString("Total");
// 		   System.out.println(SupplierName+"--"+amount);
// 		   }catch(Exception e){/* e.printStackTrace(); */}
// 		   if(ex){ 
// 		   try{
// 		    	System.out.println("inside try");
// 			    amount=rs1.getString("Total");
// 		   		SupplierCode=rs1.getString("SupplierCode");
// 			   SupplierSQL="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode like '%"+SupplierCode+"%' limit 50";
// 			   rs_su=st_su.executeQuery(SupplierSQL);
// 			   if(rs_su.next()){
				   
// 				   SupplierName=rs_su.getString("SupplierName");
// 				   System.out.println(SupplierName);
// 			   }
// 		   }catch(Exception e){}
// 		   }else{
			   
// 			   try{
// 			    	System.out.println("inside try 1");
// 				   //amount=rs1.getString("Total");
// 			  	   //SupplierCode=rs1.getString("SupplierCode");
// 				   SupplierSQL="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like '%"+item+"%' limit 1;";
// 				   rs_su=st_su.executeQuery(SupplierSQL);
// 			    	if(rs_su.next()){
// 					   System.out.println("--CCCCCCC->>");
// 					   SupplierName=rs_su.getString("SupplierName");
// 					   SupplierCode=rs_su.getString("SupplierCode");
// 					   String sql_po="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where SupplierCode='"+SupplierCode+"' order by PODate desc";
// 					   rs_po=st_po.executeQuery(sql_po);
// 					   while(rs_po.next()){
// 					   pono=rs_po.getString("PONo");
// 					   PODate=rs_po.getString("PODate");
// 					   PODate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").parse(PODate));
					   
// 					   buffer+="<tr><td><a href='#' onClick='showPO(\""+pono+"\",\""+searchBy+"\")'  style='color: black;'><b>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue>"+item.toUpperCase()+"</b></font>")+".</a></td><td>  &nbsp;&nbsp;&nbsp; "+pono+" &nbsp;&nbsp;&nbsp; </td><td>&nbsp;&nbsp;&nbsp;"+PODate+" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  "+amount+"</td></tr>";
// 					   //buffer+="<tr><td><a href='#' onClick='showPO(\""+pono+"\",\""+searchBy+"\")'  style='color: black;'><b>"+rs1.getString(1).replaceAll("(?i)"+item,"<font style='font-size:15px;' color=blue>"+item.toUpperCase()+"</b></font>")+".</a>  &nbsp;&nbsp;&nbsp; "+pono+" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;"+PODate+" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  "+amount+"</td></tr>";
// 					  // buffer+="<tr><td>Hello</td></tr>";
					 
					 
// 					   }
// 					   out.println(buffer);
// 					   System.out.println("PPPPPPPPPPPPPP"+SupplierCode);
// 				   }
// 			   }catch(Exception e){}
			   
			   
// 			   System.out.println("--False->>");
// 		   }
// 			   //System.out.println("--->>"+SupplierSQL);
// 	    flag=true;
// 	    val=rs1.getString(1).replace("\"","`");
// 	    val=val.replace("&","~");  
// 	    PODate=rs1.getString("PODate");
// 	   try{
// 		   PODate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").parse(PODate)); 
// 		  }catch(Exception e){e.printStackTrace();};
// 		 buffer+="<tr><td><a href='#' onClick='showPO(\""+val+"\",\""+searchBy+"\")'  style='color: black;'><b>"+rs1.getString(1).replaceAll("(?i)"+item,"<font style='font-size:15px;' color=blue>"+item.toUpperCase()+"</b></font>")+".</a>  &nbsp;&nbsp;&nbsp;           "+SupplierName+" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;"+PODate+" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  "+amount+"</td></tr>";
// 	  i++;
	   }
 } else if((searchBy.equalsIgnoreCase("PI"))){
		 System.out.println("----- PI");
		 SupplierCode="";SupplierName="";
		 String sup_sql="";
		 String pi_no="";
		 String serachByPEN="";
		 ResultSet rs12;
		 Statement stpe=con1.createStatement();
		 ResultSet rs13;
		 String sign="";
		 Statement stsn=con1.createStatement();
			 	i=1;val="";
			 	
			 	if(!rs1.isBeforeFirst())
			 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
			 		else{
			 		 	if(ex)
					 		buffer+="<tr><th>Sr No</th><th>Enquiry Number</th><th>Supplier</th><th>Ref Number</th><th>Enquiry Date</th><th>Due Date</th><th>Sign</th></tr>";
					 	else
					 		buffer+="<tr><th>Sr No</th><th>Supplier</th><th>Enquiry Number</th><th>Ref Number</th><th>Enquiry Date</th><th>Due Date</th><th>Sign</th></tr>";
			 		}
			 	while(rs1.next())
				   {
					   //System.out.println("1");
					  try{
				      val=rs1.getString(1).replace("\"","`");
					  val=val.replace("&","~"); 
					  val1=rs1.getString("PurchaseEnqNo").replace("\"","`");
					  SupplierName=rs1.getString("SupplierName");
					  sign=rs1.getString("SentBy");
					 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("PurEnqDate")));
					 try{
					 duedate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("DueDate")));
					 }catch(Exception e){
						 duedate="00-00-0000"; 
					 }
					 if(ex)
					  	  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showPI(\""+val1+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+val1.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+SupplierName+"</td><td>"+rs1.getString("TWRefNo")+"</td><td>"+purdate+"</td><td>"+duedate+"</td><td><a href='#' onClick='showPI(\""+val1+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+sign.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
					  else
						  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showPI(\""+val1+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+SupplierName.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+val1+"</td><td>"+rs1.getString("TWRefNo")+"</td><td>"+purdate+"</td><td>"+duedate+"</td><td><a href='#' onClick='showPI(\""+val1+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+sign.replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
				      }catch(Exception e){e.printStackTrace();}
				   } 
			 	
		/* 	   if(rs1.next())
			   {
				 if(ex){
					 try{
					    	System.out.println("inside try");
					    	serachByPEN="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq where PurchaseEnqNo like '%"+item+"%'  order by PurEnqDate desc limit 50";
						   rs12=stpe.executeQuery(serachByPEN);
						   if(rs12.next()){
							 refno=rs12.getString("TWRefNo");
							 System.out.println("krn----");
							  //buffer+=refno+"   krn";
							  System.out.println("sql_pisql_pi-------------<<<"+serachByPEN);
						      rs_pi1=st_pi.executeQuery(serachByPEN);
						      while(rs_pi1.next()){
						    	  pi_no=rs_pi1.getString("PurchaseEnqNo");
						    	  refno=rs_pi1.getString("TWRefNo");
						    	  pi_date=rs_pi1.getString("PurEnqDate");
						    	  SupplierCode=rs_pi1.getString("Suppliercode");
						    	  sup_sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where Suppliercode='"+SupplierCode+"'";
						    	  System.out.println("sup_sql-- "+sup_sql);
						    	  rs13=stsn.executeQuery(sup_sql);
						    	  if(rs13.next())
						    		  SupplierName=rs13.getString("SupplierName");
						    	  buffer+="<tr align='center'><td><a href='#' onClick='showPI(\""+pi_no+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+"<font color=blue><u>"+"</u></font>"+""+refno+"  </td><td>  "+SupplierName+" </td><td> "+pi_no+"</a></td><td> "+pi_date+"</td></tr>";
						    	  }
						   }
					   }catch(Exception e){}
					 
					 
					 
				 }else{
				   
				   
					 SupplierName=rs1.getString("SupplierName");
				  val=rs1.getString(1).replace("\"","`");
				  val=val.replace("&","~"); 
				  String sql_pi="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq where Suppliercode="+val+"  order by PurEnqDate desc";
				  System.out.println("sql_pisql_pi-------------<<<"+sql_pi);
			      rs_pi1=st_pi.executeQuery(sql_pi);
			      while(rs_pi1.next()){
			    	  pi_no=rs_pi1.getString("PurchaseEnqNo");
			    	  refno=rs_pi1.getString("TWRefNo");
			    	  pi_date=rs_pi1.getString("PurEnqDate");
			    	  buffer+="<tr align='center'><td><a href='#' onClick='showPI(\""+pi_no+"\",\""+searchBy+"\",\""+SupplierName+"\")'  style='color: black;'>"+"<font color=blue><u>"+"</u></font>"+""+refno+"  </td><td>  "+SupplierName+" </td><td> "+pi_no+"</a></td><td> "+pi_date+"</td></tr>";
			    	  }
				  
				  flag=true;
			     
			     	//buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
			        i++;
			   } } */
	  }
 else if((searchBy.equalsIgnoreCase("PQ"))){
	 System.out.println("----- PQ");
	  refno="";
	  total="";
	  sup_name="";
	  pq_no="";
	  pi_date="";
	  Supp="";
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr align='center'><th>Sr NO</th><th>PurQuo No</th><th>Date</th><th>Supplier</th><th>Currency</th><th>Grand Total</th></tr>";
		    while(rs1.next())
		   {
		    	
		    	try{
		    		Supp=rs1.getString("SupplierName");
		 			   sup_name=rs1.getString("SupplierCode");
		    		pq_no=rs1.getString("PurQuoNo");
	 		    	  refno=rs1.getString("TWRefNo");
     	 		      total=rs1.getString("GrandTotal");
				      val=rs1.getString(1).replace("\"","`");
					  val=val.replace("&","~"); 
					 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("PurQuoDate")));	
					  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showPE(\""+pq_no+"\",\""+searchBy+"\",\""+sup_name+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td><a href='#' onClick='showPE(\""+pq_no+"\",\""+searchBy+"\",\""+sup_name+"\")'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' onClick='showPE(\""+pq_no+"\",\""+searchBy+"\",\""+sup_name+"\")'  style='color: black;'>"+rs1.getString("CurrType").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("GrandTotal")+"</td></tr></td>";
				      }catch(Exception e){e.printStackTrace();}
// 			   Supp=rs1.getString("SupplierName");
// 			   sup_name=rs1.getString("SupplierCode");
			  
// 			  val=rs1.getString(1).replace("\"","`");
// 			  val=val.replace("&","~"); 
// 			  String sql_pq="SELECT * FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasequo  where SupplierCode='"+sup_name+"' order by PurQuoDate desc";
// 			  System.out.println("sql_pQsql_pQ-------------<<<"+sql_pq);
// 		      rs_pi1=st_pi.executeQuery(sql_pq);
// 		      while(rs_pi1.next()){
// 		    	  System.out.println("--KK--");
// 		    	  pq_no=rs_pi1.getString("PurQuoNo");
// 		    	  refno=rs_pi1.getString("TWRefNo");
// 		    	  total=rs_pi1.getString("GrandTotal");
// 		    	  //pi_date=rs_pi1.getString("PurEnqDate");
// 		    	  buffer+="<tr align='center'><td><a href='#' onClick='showPE(\""+pq_no+"\",\""+searchBy+"\",\""+sup_name+"\")'  style='color: black;'><b>"+Supp.replaceAll("(?i)"+item,"<font style='font-size:15px;' color=blue>"+item.toUpperCase()+"</b></font>")+". </td><td>  "+refno+" </td><td> "+pq_no+"</a></td><td> "+total+"</td></tr>";
// 		    	  }
			  
// 			  flag=true;
		     
// 		     	//buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
// 		        i++; 
		   } 
  }
 else if((searchBy.equalsIgnoreCase("PIn"))){
	 System.out.println("----- PIn");
	 
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 	buffer+="<tr align='center'><th>Sr</th><th>Purchase Invoice No</th><th>Purchase Invoice Date</th><th>Supplier</th><th>Total</th></tr>";
		   while(rs1.next())
		   {
			  // System.out.println("1");
			   /* 
			   Supp=rs1.getString("SupplierName");
			   sup_name=rs1.getString("SupplierCode");
			  
			  val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
			  String sql_pq="SELECT * FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasequo  where SupplierCode='"+sup_name+"' order by PurQuoDate desc";
			  System.out.println("sql_pQsql_pQ-------------<<<"+sql_pq);
		      rs_pi1=st_pi.executeQuery(sql_pq);
		      while(rs_pi1.next()){
		    	  System.out.println("--KK--");
		    	  pq_no=rs_pi1.getString("PurQuoNo");
		    	  refno=rs_pi1.getString("TWRefNo");
		    	  total=rs_pi1.getString("GrandTotal");
		    	  //pi_date=rs_pi1.getString("PurEnqDate");
		    	  buffer+="<tr align='center'><td>"+i+++"</td><td><a href='#' onClick='showPE(\""+pq_no+"\",\""+searchBy+"\",\""+sup_name+"\")'  style='color: black;'><b>"+Supp.replaceAll("(?i)"+item,"<font style='font-size:15px;' color=blue>"+item.toUpperCase()+"</b></font>")+". </td><td>  "+refno+" </td><td> "+pq_no+"</a></td><td> "+total+"</td></tr>";
		    	  }
			  
			  flag=true;
		      */
		      try{
		      val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
			  try{
			 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("PurInvoiceDate"));
			  }catch(Exception e){}
			  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showPurIn(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td><a href='#' onClick='showPurIn(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></td><td>"+rs1.getString("GrandTotal")+"</td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   } 
  }
 else if((searchBy.equalsIgnoreCase("SO"))){
	 System.out.println("----- SO");
	 
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 	buffer+="<tr align='center'><th>Sr</th><th>Sales Order No</th><th>Sales Order Date</th><th>Company</th><th>Created By</th><th>Currancy</th><th>Total</th></tr>";
		   while(rs1.next())
		   {
			   //System.out.println("1");
			  try{
		      val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
			 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("SalesOrderDate")));	
			  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSO(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("SalesorderRefNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td><a href='#' onClick='showSO(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' onClick='showSO(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("TWEmpName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' onClick='showSO(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("CurrType").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("Total")+"</td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   } 
  }
 else if((searchBy.equalsIgnoreCase("SE"))){
	 System.out.println("----- SE");
	 
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 	buffer+="<tr align='center'><th>Sr</th><th>Enquiry Ref no</th><th>Enquiry Date</th><th>Due Date</th><th>Customer</th><th>Created By</th></tr>";
		   while(rs1.next())
		   {
			  // System.out.println("1");
			  try{
		      val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
			// purdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("SalesEnqDate")));
			 try{
				 purdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("SalesEnqDate")));
			 	 duedate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:MM:SS").parse(rs1.getString("SalesEnqDueDate")));
			 }catch(Exception e){
				 duedate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("SalesEnqDueDate")));
			 }
			 buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSE(\""+rs1.getString("SalesEnqRefNo")+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("SalesEnqRefNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td>"+duedate+"</td><td><a href='#' onClick='showSE(\""+rs1.getString("SalesEnqRefNo")+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' onClick='showSE(\""+rs1.getString("SalesEnqRefNo")+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("TWEmpName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   } 
  }
 else if((searchBy.equalsIgnoreCase("SQ"))){
	 System.out.println("----- SQ");
	 
		 	i=1;val="";
		 	//Sr no 	Sales Quo Ref no 	SQ Date 	Company 	Status 	TheGroup 	Sign 	Amount
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr align='center'><th>Sr</th><th>Quotation Ref no</th><th>Sales Quotation Date</th><th>Company</th><th>Status</th><th>Sign</th><th>Total</th></tr>";
		   while(rs1.next())
		   {
			   //System.out.println("1");
			  try{
				        
						if(rs1.getInt("ThisIsSalesOrder")==1)
						{status="Ordered";
						}
						else
						{	if(rs1.getInt("SalesQuoCancelled")==0)
								status="Open";
								 else
						    	status="Closed";
						}
		      val=rs1.getString(1).replace("\"","`");
			  val=val.replace("&","~"); 
		try{
			  purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("SalesQuoDate"));
		}catch(Exception e){}
			  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSQ(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("SalesquoRefNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td><a href='#' onClick='showSQ(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+status+"</td><td><a href='#' onClick='showSQ(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("TWEmpName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("GrandTotal")+"</td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   } 
  }
 else if((searchBy.equalsIgnoreCase("SI"))){
	 System.out.println("----- Si");
	 
	 int xx=rs1.getRow();
	 System.out.println("XX  "+xx);
// 	 if(xx==0){
// 		 System.out.println("No Results Found in DB");
// 		   buffer+="<tr><td colspan='7' align='center'>----No Results Found----</td></tr>"; 
// 	 }else{ 
		 	i=1;val="";
		 	//Sr no 	Invoice ref no 	Invoice DateTime 	Total 	GrandTotal 	Currency 	group 	Status 	Company Name 	Sign
		 	//buffer+="<font style='font-size: medium;color: #4A4AD4;font-weight: bold;'>Sales Invoices</font><br>";
		 	System.out.println("--><YY--"+rs1.getRow());
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr align='center'><th>Sr</th><th>Invoice Ref no</th><th>Invoice Date</th><th>Company</th><th>Currency</th><th>Status</th><th>Sign</th><th>Total</th></tr>";
		   while(rs1.next())
		   {
			  // System.out.println("1");
			  try{
				        
				  if(rs1.getInt("InvoiceCancelled")==0)
					{status="Invoiced";
					}
					else
					{	status="Closed";
					}//else end
		      val=rs1.getString("invoiceRefNo").replace("\"","`");
		      val1=rs1.getString("InvoiceNo").replace("\"","`");
			  val=val.replace("&","~"); 
			  purdate=new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("InvoiceDate"));
			  buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSI(\""+val+"\",\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("invoiceRefNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td><a href='#' onClick='showSI(\""+val+"\",\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("CurrType")+"</td><td>"+status+"</td><td><a href='#' onClick='showSI(\""+val+"\",\""+val1+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("TWEmpName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("GrandTotal")+"</td></tr></td>";
		      }catch(Exception e){e.printStackTrace();}
		   }
		
	 } //}
 else if((searchBy.equalsIgnoreCase("SPI"))){
	 System.out.println("----- SPI");
	 
		 	i=1;val="";
			System.out.println("--><YY--"+rs1.isBeforeFirst() );
			 
			if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else 
		 		{
		 		if(ex)
		 		buffer+="<tr align='center'><th>Sr</th><th>Invoice Ref no</th><th>Invoice Date</th><th>Company</th><th>Total</th><th>Sign</th></tr>";
		 	else
		 		buffer+="<tr align='center'><th>Sr</th><th>Company</th><th>Invoice Date</th><th>Invoice Ref no</th><th>Total</th><th>Sign</th></tr>";
		 		}
		   while(rs1.next())
		   {
			//   System.out.println("1");
			  try{
				        
		      val=rs1.getString(1).replace("\"","`");
		      val1=rs1.getString("invoiceRefNo").replace("\"","`");
			  val=val.replace("&","~"); 
			 purdate=	new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("a.InvoiceDate")));	
			if(ex)
				buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSPI(\""+val1+"\",\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("a.invoiceRefNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td>"+rs1.getString("CompanyName")+"</td><td>"+rs1.getString("GrandTotal")+"</td><td>"+rs1.getString("TWEmpName")+"</td></tr></td>";
			else
				buffer+="<tr><td>"+i+++"</td><td><a href='#' onClick='showSPI(\""+val1+"\",\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("a.CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+purdate+"</td><td>"+rs1.getString("invoiceRefNo")+"</td><td>"+rs1.getString("GrandTotal")+"</td><td><a href='#' onClick='showSPI(\""+val1+"\",\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString("TWEmpName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
			  }catch(Exception e){e.printStackTrace();}
			  
		   } 
  }


 else if((searchBy.equalsIgnoreCase("Item"))){
	 System.out.println("----- Item");
		 	i=1;val="";
		 	String itemSelected="";
		 	String tbl="";
		 	String desc="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr><th>Sr.no</th><th>Description</th><th>Make Name</th><th>Make Code</th><th>Item Code</th><th>Model</th><th>Part No</th><tr>";
		   while(rs1.next())
		   {
			   try{
		      flag=true;
		     val=rs1.getString(1).replace("\"","`");
		    val=val.replace("&","~");  
		    itemSelected=rs1.getString("ItemCode");
		    tbl=rs1.getString("makedettable");
		    desc=rs1.getString("Description");
		    //System.out.println(desc+"','"+itemSelected+"','"+tbl);
		    	//Sr no 	Desc. 	Make Name 	Make Code 	ItemCode 	Model 	Part No <td align='left'><a href='#' style='font-weight: bold;' onclick='popUpSupplier('viewSupplierDetails.jsp','"+item+"','"+itemSelected+"','"+tbl+"')'>View Suppliers</a></td> 																																																																					
		    buffer+="<tr><td>"+i+"</td><td><a href='#' style='color: black;'>"+rs1.getString("Description").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("makename")+"</td><td>"+rs1.getString("makecode")+"</td><td>"+rs1.getString("ItemCode")+"</td><td>"+rs1.getString("Model")+"</td><td>"+rs1.getString("PartNo")+"</td><td align='left'><a href='#' onclick=\"popUpSupplier('viewSupplierDetails.jsp','"+desc+"','"+itemSelected+"','"+tbl+"')\">View Suppliers</a></td></tr>";
		   //System.out.println(buffer);
		    // buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr>";
		        i++;
			   }catch(Exception e){ e.printStackTrace();}
		   } 
  }
 else if(searchBy.equalsIgnoreCase("Company") || searchBy.equalsIgnoreCase("Model") || searchBy.equalsIgnoreCase("Part")){
	 System.out.println("-----"+searchBy);
		 	i=1;val="";
		 	String itemSelected="";
		 	String tbl="";
		 	String desc="";
		 	
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr><th>Sr.no</th><th>Description</th><th>Make Name</th><th>Make Code</th><th>Item Code</th><th>Model</th><th>Part No</th><th></th><tr>";
		   while(rs1.next())
		   {
			   try{
		      flag=true;
		     val=rs1.getString(1).replace("\"","`");
		    val=val.replace("&","~");  
		    itemSelected=rs1.getString("ItemCode");
		    tbl=rs1.getString("makedettable");
		    desc=rs1.getString("Description");
		    //System.out.println(desc+"','"+itemSelected+"','"+tbl);
		    	// 	Desc. 	Make Name 	Make Code 	ItemCode 	Model 	Part No   <td align='left'><a href='#' style='font-weight: bold;' onclick='popUpSupplier('viewSupplierDetails.jsp','"+item+"','"+itemSelected+"','"+tbl+"')'>View Suppliers</a></td> 																																																																					
		    if(searchBy.equalsIgnoreCase("Model"))
		    	buffer+="<tr><td>"+i+"</td><td>"+rs1.getString("Description")+"</td><td>"+rs1.getString("makename")+".</a></td><td>"+rs1.getString("makecode")+"</td><td>"+rs1.getString("ItemCode")+"</td><td><a href='#' style='color: black;'>"+rs1.getString("Model").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("PartNo")+"</td><td align='left'><a href='#' onclick=\"popUpSupplier('viewSupplierDetails.jsp','"+desc+"','"+itemSelected+"','"+tbl+"')\">View Suppliers</a></td></tr>";
		    if(searchBy.equalsIgnoreCase("Company"))
			   	buffer+="<tr><td>"+i+"</td><td>"+rs1.getString("Description")+"</td><td><a href='#' style='color: black;'>"+rs1.getString("makename").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td>"+rs1.getString("makecode")+"</td><td>"+rs1.getString("ItemCode")+"</td><td>"+rs1.getString("Model")+"</td><td>"+rs1.getString("PartNo")+"</td><td align='left'><a href='#' onclick=\"popUpSupplier('viewSupplierDetails.jsp','"+desc+"','"+itemSelected+"','"+tbl+"')\">View Suppliers</a></td></tr>";
			if(searchBy.equalsIgnoreCase("Part"))
			   buffer+="<tr><td>"+i+"</td><td>"+rs1.getString("Description")+"</td><td>"+rs1.getString("makename")+"</td><td>"+rs1.getString("makecode")+"</td><td>"+rs1.getString("ItemCode")+"</td><td>"+rs1.getString("Model")+"</td><td><a href='#' style='color: black;'>"+rs1.getString("PartNo").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td align='left'><a href='#' onclick=\"popUpSupplier('viewSupplierDetails.jsp','"+desc+"','"+itemSelected+"','"+tbl+"')\">View Suppliers</a></td></tr>";   	
		  // System.out.println(buffer);
		    // buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr>";
		        i++;
			   }catch(Exception e){ e.printStackTrace();}
		   } 
  }else if(searchBy.equalsIgnoreCase("cust")){
		 System.out.println("--search limit---"+searchBy+"---"+limit+"----"+ccount);
		 	
		 	i=1;val="";
		 	String itemSelected="";
		 	String tbl="";
		 	String desc="";
		 	
		 	
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		 	else
		 		buffer+="<tr><th>Sr.no</th><th>Comapny Name</th><th>City</th><th>Contact Person</th><th>Phone</th><th>Email</th><tr>";
		   int x=0;
		 	while(rs1.next())
		   {
			   System.out.println("-----"+x++);	
			   buffer+="<tr><td>"+i+++"</td><td><a href='#' style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' style='color: black;'>"+rs1.getString("City").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' style='color: black;'>"+(rs1.getString("ContactPerson").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")).replaceAll("null","") +".</a></td><td>"+rs1.getString("Phone")+"</td><td>"+rs1.getString("Email")+"</td><tr>";
		   } 
}else if(searchBy.equalsIgnoreCase("Pros")){
	 System.out.println("-----"+searchBy);
	 	i=1;val="";
	 	String itemSelected="";
	 	String tbl="";
	 	String desc="";
	 	
	 	if(!rs1.isBeforeFirst())
	 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
	 	else
	 		buffer+="<tr><th>Sr.no</th><th>Comapny Name</th><th>City</th><th>Contact Person</th><th>Phone/Email</th><th>Email</th><tr>";
	   
	 	while(rs1.next())
	   {
	 		try{
		   buffer+="<tr><td>"+i+++"</td><td><a href='#' style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' style='color: black;'>"+rs1.getString("City").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></td><td><a href='#' style='color: black;'>"+(rs1.getString("ContactPerson").replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")).replaceAll("null","") +".</a></td><td>"+rs1.getString("Phone")+"</td><td>"+rs1.getString("Email")+"</td><tr>";
	 		}catch(Exception e){}
	   } 
}
 else if(!(searchBy.equalsIgnoreCase("Supplier"))){
	 System.out.println("----- ! Supplier");
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		   while(rs1.next())
		   {
		      flag=true;
		     val=rs1.getString(1).replace("\"","`");
		    val=val.replace("&","~");  
		     buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
  }
 else 
  {
	  System.out.println("----- Any"); 
		 	i=1;val="";
		 	if(!rs1.isBeforeFirst())
		 		buffer+="<tr align='center'><th>---Data Not Found---</th></tr>";
		   while(rs1.next())
		   {
		      flag=true;
		    val=rs1.getString(1).replace("\"","?");  
		     buffer+="<tr><td><a href='#' onClick='showSupplier(\""+rs1.getString(2)+"\",\""+val+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
  }
 ++limitcnt;
 if(showmore)
   buffer+="</table><a href='#more' id='more' onclick='timer1("+limitcnt+")'>More</a></div>";
 else
	 buffer+="</table></div>";
out.println(buffer);

//System.out.println("TTTTTTTTTTT--------"+countlimit+"--"+ limitcnt);



} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
