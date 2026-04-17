<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">
<%!
Connection conn;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null;

%>
<%
try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    
} catch (Exception e) {
    e.printStackTrace();
} 

%>
<%

%>
<% 
String selected=request.getParameter("status");
System.out.println("--------"+selected);

String datex1, datex2, data1, data2;
String departmentNew="";
String ddx = request.getQueryString();

if (ddx == null) {
	
	System.out.println(" In First If  " );
	
	datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new java.util.Date());
	
		
	data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new java.util.Date());

	Calendar c = Calendar.getInstance();   // this takes current date
     c.set(Calendar.DAY_OF_MONTH,1);
    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());

} else {
	
	System.out.println(" In First Else  " );
	
	
	String fromdate=request.getParameter("chkdate");
	String todate=request.getParameter("chkdate1");
	
	System.out.println(" In First Else chkdate  "+fromdate );
	
	System.out.println(" In First Else  chkdate 1"+todate );
	
	
	if(fromdate!=null && todate!=null)
	{
		
		data1 = fromdate;
data2 = todate;




datex1 = fromdate;
datex2 = todate;

		
	}else
	{
		
	
	data1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data")));
	data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data1")));
	
	
	

	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");
	}
}

String Bt=request.getParameter("button");
System.out.println(" Button :- " +Bt);

if(Bt==null || Bt==" " || Bt=="")
{
	
	String fromdate=request.getParameter("chkdate");
	String todate=request.getParameter("chkdate1");
	
    System.out.println(" In Button Null   "+fromdate );
	
	System.out.println(" In Button Null   chkdate 1"+todate );
	
	
	if(fromdate!=null && todate!=null)
	{
	
		datex1 =new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat("yyyy-MM-dd")
		.parse(fromdate));
		
		datex2 = new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat("yyyy-MM-dd")
		.parse(todate));
		
	data1 =  fromdate;
	
	data2 = todate;

	departmentNew=request.getParameter("departmentNew");

	}
	else
	{
		datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
		.format(new java.util.Date());
	data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new java.util.Date());

	Calendar c = Calendar.getInstance();   // this takes current date
	c.set(Calendar.DAY_OF_MONTH, 1);
	System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
	datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
			}
}
else
{
	data1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data")));
data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data1")));




datex1 = request.getParameter("data");
datex2 = request.getParameter("data1");
}

System.out.println(" datex1 "+datex1+" datex2 "+datex2);


String dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));

System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);



String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();



String selected1=request.getParameter("dept");

System.out.println(" selected1 department  :-  "+selected1);

if(selected1==null && departmentNew!=null)
{
	selected1=departmentNew;
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Invoice Monthly Detail</h5>
    </div>
</div>

<form name="custreport" id="custreport" method="post">
	  <div class="row col-12">
		    <div class="col-md-4"></div>
		    <div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
			</div>	
			</div>
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>

<%
dept = session.getAttribute("department").toString();

String sessionname=session.getAttribute("EmpName").toString();
System.out.println(dept);
String CustomerCode="",CompanyName="";

ResultSet rs=null;
String custname="",groupname=""; 
String FromDate="",ToDate="",DueDate="",BillFrequency="",BillCategory="",BillDay="";
String NewToDate="",NewFromDate="";
String BillFromDate="",BillToDate="";
String ConractFromDate="",ContractToDate="";
double monthcount=0,monthcount1=0;
double yearcount=0;
int i=1;
String InvoiceFrom="",InvoiceTo="";

String MonthCount1="";
String InvoiceFrom12="",InvoiceTo12="";
String daydataNew111="";
String total="";
System.out.println(dt);
System.out.println(dt1);
String daydataNew1="";
String InvoiceFrom1="",InvoiceTo1="";
String daydataNew="";

String month="",Year="";
String lastday="";

%>




<%
FromDate=dt;
ToDate=dt1;

		NewToDate=ToDate.substring(0, 7);
		NewToDate=NewToDate.replace("-", "");
		NewFromDate=FromDate.substring(0, 7);
		NewFromDate=NewFromDate.replace("-", "");
		
		 MonthCount1="select PERIOD_DIFF('"+NewToDate+"','"+NewFromDate+"') as PeriodCount";
		ResultSet rsMonthCount1=st1.executeQuery(MonthCount1);
		if(rsMonthCount1.next())
		{
			monthcount=rsMonthCount1.getInt("PeriodCount")+1;

		}
		
		System.out.println("monthcount monthcount  :-   "+monthcount);
		%>
	<div class="container" style="width: 80%">
		<div class="text-left mt-4" style="font-size: 10px;">
<label>Note:Report is generated for complete month irrespective of Todate.</label>
</div>
		<table id="example"  class="display" style="width:100%" >  
		<thead>
		<tr>
			<th class="col-width-4">SrNo.</th>
			<th>CustomerCode</th>
			<th>CompanyName</th>
			<th>BranchName</th>
		<%
		int r=0	;		

		
				for(int g=1;g<=monthcount;g++)
				{
				if(r==0)
				{
					 daydataNew1="select DATE_FORMAT(DATE('"+FromDate+"' + INTERVAL 0 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+FromDate+"'+ INTERVAL 0 Month),'%Y-%m-01')) as ToDate ";		
				}
				else
				{
					  daydataNew1="select DATE_FORMAT(DATE('"+FromDate+"' + INTERVAL 1 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+FromDate+"'+ INTERVAL 1 Month),'%Y-%m-01')) as ToDate ";
				}
				
			    ResultSet rsdaydata11=st2.executeQuery(daydataNew1);
			    if(rsdaydata11.next())
			    {
			    	InvoiceFrom1=rsdaydata11.getString("FromDate");
			    			
			    			
			    	InvoiceTo1=rsdaydata11.getString("ToDate");
			    }
			    FromDate=InvoiceFrom1;

			    
String countday="SELECT DAYNAME('"+InvoiceFrom1+"') as DayName1,DAYOFMONTH('"+InvoiceFrom1+"') as DayCnt ,MONTHNAME('"+InvoiceFrom1+"') as MonthName,YEAR('"+InvoiceFrom1+"') as Year,LAST_DAY(DATE('"+InvoiceFrom1+"')) as lastday";
ResultSet rs12=st3.executeQuery(countday);
if(rs12.next())
{
	lastday=rs12.getString("lastday");
	month=rs12.getString("MonthName");
	Year=rs12.getString("Year");
}
month=month.substring(0,3);
String monthyear=month+"-"+Year;

						%><th class="text-right"><%= monthyear%></th><%
								r++;
				}
		%>
</tr>
		</thead>

<tbody>
<%

String branch="";

String data="select distinct(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet where invoicedate >='"+dt+"' and invoicedate <='"+lastday+"' and InvoiceCancelled=0"; 
int p=1;
System.out.println("check-------->"+data);
ResultSet rs21=st4.executeQuery(data);
while(rs21.next())
{
	FromDate=dt;
	ToDate=dt1;
	String eid=rs21.getString("CustomerCode");
//System.out.println("eid-------->"+eid);


String query111="select BranchName  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+eid+"' ";
ResultSet rsMonthCount1111=st5.executeQuery(query111);
System.out.println("111-------->"+query111);


if(rsMonthCount1111.next())
{

  branch=rsMonthCount1111.getString("BranchName");
  if (branch.equals("HO"))
  {
	  branch="HeadOffice";
  }
}
		
	
		//System.out.println("monthcount :-   "+(int)monthcount);
int k=0;
		for(int j=1;j<=monthcount;j++)
		{
			if(k==0)
			{
				 daydataNew="select DATE_FORMAT(DATE('"+FromDate+"' + INTERVAL 0 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+FromDate+"'+ INTERVAL 0 Month),'%Y-%m-01')) as ToDate ";		
			}
			else
			{
				 daydataNew="select DATE_FORMAT(DATE('"+FromDate+"' + INTERVAL 1 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+FromDate+"'+ INTERVAL 1 Month),'%Y-%m-01')) as ToDate ";
			}
			
			//System.out.println("daydataNew :-   "+daydataNew);

		    ResultSet rsdaydata1=st6.executeQuery(daydataNew);
		    if(rsdaydata1.next())
		    {
		    	InvoiceFrom=rsdaydata1.getString("FromDate");
		    			
		    			
		    	InvoiceTo=rsdaydata1.getString("ToDate");
		    }
		    
		    FromDate=InvoiceFrom;
		    
			//System.out.println("InvoiceFrom :-   "+InvoiceFrom);
			//System.out.println("InvoiceTo :-   "+InvoiceTo);
k++;

String query="select CustomerCode,CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet where invoicedate >='"+InvoiceFrom+"' and invoicedate <='"+InvoiceTo+"' and  InvoiceCancelled=0 and CustomerCode='"+eid+"' ";
ResultSet rsMonthCount11=st7.executeQuery(query);
System.out.println("CustomerCode-------->"+query);


if(rsMonthCount11.next())
{

 CustomerCode=rsMonthCount11.getString("CustomerCode");
//System.out.println("CustomerCode-------->"+CustomerCode);
if(CustomerCode==null || CustomerCode.equals("null") || CustomerCode=="null")
{
	CustomerCode="-";
}


 CompanyName=rsMonthCount11.getString("CompanyName");
//System.out.println("CompanyName-------->"+CompanyName);
if(CompanyName==null || CompanyName.equals("null") || CompanyName=="null")
{
	CompanyName="-";
}

}
		}
%>

 <tr>
<td class="text-right"><%=p%></td>
<td class="text-center"><%=CustomerCode%></td>
<td class="text-left"><%=CompanyName%></td>
<td class="text-left"><%=branch%></td>
<%
int k2=0;
//System.out.println("monthcount 1234  :-   "+monthcount);

String f1=dt;


for(int j1=1;j1<=monthcount;j1++)
{
	//FromDate=dt;
	if(k2==0)
	{
		 daydataNew111="select DATE_FORMAT(DATE('"+f1+"' + INTERVAL 0 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+f1+"'+ INTERVAL 0 Month),'%Y-%m-01')) as ToDate ";		
	}
	else
	{
		 daydataNew111="select DATE_FORMAT(DATE('"+f1+"' + INTERVAL 1 Month),'%Y-%m-01') as FromDate,LAST_DAY(DATE_FORMAT(DATE('"+f1+"'+ INTERVAL 1 Month),'%Y-%m-01')) as ToDate ";
	}
	
	//System.out.println("daydataNew :-   "+daydataNew111);
	
	ResultSet rsdaydata123=st8.executeQuery(daydataNew111);
    if(rsdaydata123.next())
    {
    	InvoiceFrom12=rsdaydata123.getString("FromDate");
    			
    			
    	InvoiceTo12=rsdaydata123.getString("ToDate");
    }
    
    f1=InvoiceFrom12;
    k2++;
	////System.out.println("InvoiceFrom :-   "+InvoiceFrom12);
	System.out.println("InvoiceTo :-   "+InvoiceTo12);
	
	String query1="select sum(GrandTotal) as total from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet where invoicedate >='"+InvoiceFrom12+"' and invoicedate <='"+InvoiceTo12+"' and  InvoiceCancelled=0 and CustomerCode='"+eid+"' order by trim(CompanyName) limit 1";
	ResultSet rsMonthCount111=st9.executeQuery(query1);
	System.out.println("CustomerCode-------->"+query1);

	if(rsMonthCount111.next())
	{
		 total=rsMonthCount111.getString("total");
	//	System.out.println("total-------->"+total);
		if(total==null || total.equals("null") || total=="null")
		{
			total="0.00";
		}
	 %>
	<td class="text-center"><%=total%></td>

	<%} 

}

%>
</tr>
<%

p++;
}
		    
		
%>
</tbody>
</table>
</div>
</form>
</div>
<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Invoice Monthly Detail '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Invoice Monthly Detail '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Invoice Monthly Detail '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Invoice Monthly Detail '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Invoice Monthly Detail '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
</body>
<%@ include file="footer.jsp"%>
</html>