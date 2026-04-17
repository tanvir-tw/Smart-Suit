<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">
<style>
body {

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
            overflow:scroll;
            }
            
            #myfooter 
            {
            background: #df781c;
            clear: both;
            width: 100%;
            }
            
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Deduction Report</title>
</head>

<script type="text/javascript">

function getvalid()
{
	var flag=false;
	var a=new Date();
	var v=document.getElementById("begindate").value;
	var v1=document.getElementById("enddate").value;
	var tod = new Date(v);
	var tod1 = new Date(v1);
	//alert(a);
	if (a>tod)
	{
	//alert("This is a later date");
		if(tod<=tod1){
		//	alert("this is valid");
			flag=true;
		}else{
			alert("Please Enter Valid Date");
			flag=false;
		}
		
	return flag;
	}
	else
	{
	alert("Please Enter Valid Date");
	return false;
	} 	
	
	
}
</script>
<script type="text/javascript">
       var t = new ScrollableTable(document.getElementById('invoice'), 100);
       
       function gotoExcel (elemId, frmFldId)  
       {  
            //alert("*********** ");
                var obj = document.getElementById(elemId);  

                var oFld = document.getElementById(frmFldId); 

                 oFld.value = obj.innerHTML;  

                 document.collectionreport.action ="excel.jsp";     // CHANGE FORM NAME HERE

                 document.forms["collectionreport"].submit();       // CHANGE FORM NAME HERE
       } 
</script>
<form name="collection" method="get" action="" onsubmit="return getvalid()" autocomplete="off">
<%
String condition="";
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();

	String begindate="",enddate="",begindateCal="",enddateCal="";
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df2 = new DecimalFormat( "0.00" );
	java.util.Date d1 = null;
	java.util.Date d2 = null;
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	begindateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	begindateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	enddateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

	if (!(null == request.getParameter("begindate"))) {
	    begindate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("begindate")));
	    begindateCal=request.getParameter("begindate");
	}
	if (!(null == request.getParameter("enddate"))){
    	enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("enddate")));
    	enddateCal=request.getParameter("enddate");
	}
	
	
	
	String mybegindate1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(begindateCal));
	    String myenddate1 = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	condition="where paymentdate between '"+mybegindate1+"' and '"+myenddate1+"' order by a.twempname";
	
//if (request.getQueryString()==null)
//{
%>


	<div id = "main" align="center">
    	 <table align="center" >
	<tr>
	<td colspan="3" align="center"><b>Deduction Report</b></td>
 </tr>
     	<tr>
     	<td style="width: 200px;">
    	<font size=2>Start Date   :</font>
    	
    	<input type="text" id="begindate"
	 	name="begindate" value="<%=begindateCal %>" size="15" readonly
	 	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 	<script type="text/javascript">
			  Calendar.setup(
	    	{
	      inputField  : "begindate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "begindate"       // ID of the button
	    }
	  );
	</script>
	</td>
	<td  style="width: 200px;">
    <font size=2> End Date   :</font>
 
    <input type="text" id="enddate"
	 name="enddate" value="<%=enddateCal %>" size="15" readonly
	 style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 <script type="text/javascript">
		  Calendar.setup(
	    {
	      inputField  : "enddate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "enddate"       // ID of the button
	    }
	  );
	</script>
	</td>
	<td>
	
	
	        		<select name="status">
        	<%
        	
        	String ss="";
        	
        	try{
        		ss=request.getParameter("status");
        		if(ss==null)
        			ss="All";
        	}catch(Exception e){
        		ss="All";
        		out.print(ss+e);
        	}
        	try{
        			if(ss.equalsIgnoreCase("All")){ %>
        			<option value="All" selected>All</option>
        			<%}else{%>
        				<option value="All" >All</option>
        				<%}if(ss.equalsIgnoreCase("TDS")){ %>
        				<option value="TDS" selected> TDS </option>
        				<%}else{%>
        				<option value="TDS"> TDS </option>
        				<%}if(ss.equalsIgnoreCase("Other")){ %>
        				<option value="Other" selected> Other </option>
        				<%}else{%>
        				<option value="Other"> Other </option>
        				<%}if(ss.equalsIgnoreCase("Short")){ %>
        				<option value="Short" selected> Short </option>
        				<%}else{%>
        				<option value="Short"> Short </option>
        				<%} %>
        			
        		</select>
<%}catch(Exception e){out.println(e);} %>	
	
	
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" onclick="makeinvisible()";/></td>
     </tr>
  
     
      </table>
      </div>
      
<!--       <div> -->
<!--       <table> -->
<!--          <tr> -->
<!--      <td> -->
<!--      <div id='accountsList' style="color:green;"> -->
<!-- 	<div style="height: 50px; width: 350px; overflow: auto; border:solid inset;"></div> -->
<!-- 	</div> -->
<!-- 	</td> -->
<!--      </tr> -->
<!--  </table> -->
<!--       </div> -->
      <%
//} %>
<!-- </form> -->
<%
%>
<table align="right" ><tr>	
				<td align="right">
<!-- 						<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('collection','tableHTML');"> -->
<!-- 							     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img> -->
<!-- 			            </a> -->
<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				</td>
				</tr>
				</table>
<!-- <form name="collectionreport" method="post" action="" autocomplete="off"> -->

	  <%
String exportFileName="collectionreport_det.xls";   // GIVE YOUR REPORT NAME
%>
<div id='collection'>
<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<!--      <table class="sortable"> -->
<!--      <tr> -->
<!--      <td colspan = "12" width="100%" align="center"> -->
<%--      <h3>Collection Report From: <%=request.getParameter("begindate")%> to <%=request.getParameter("enddate")%></h3> --%>
<!--      </td> -->
<!--      </tr> -->
<!--      	<tr> -->
<!--      		<th width="50"><div>Payment Mode</div></th> -->
<!--             <th><div>VoucherNo</div></th> -->
<!--             <th><div align="left">Receipt-Date</div></th> -->
<!--             <th width="400"><div align="left">Received From</div></th> -->
<!--             <th><div align="left">Cheque No</div></th> -->
<!--             <th><div align="left">Cheque Date</div></th> -->
<!--             <th><div align="right">Amount</div></th> -->
<!--             <th><div align="left">Invoice No</div></th> -->
<!--             <th><div align="left">Tally Ref No.</div></th> -->
<!--         </tr> -->
	    <%
        try
        {
        	
        	
        	
        	tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD, SID,PID,CMID);
        	String mybegindate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("begindate")));
     	    String myenddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("enddate")));
        	Connection conn = null;
        	Connection conn1 = null;
        	Statement st = null;
        	Statement st1 = null;
        	Statement st2 = null;
        	String todaydate="";
        	String a=""; 
        	double totalamount=0;
	        todaydate=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
	        conn = tally.ReturnConnection();
	        conn1 = tally.ReturnConnection();
        	st = conn.createStatement();
        	st1 = conn1.createStatement();
        	st2 = conn1.createStatement();
        	String sql="";
        	String sql1="";
        	
        	String Status="";
			try{
				condition="where tallyrefno = '' AND paymentdate between '"+mybegindate+"' and '"+myenddate+"' order by paymentdate";
        		Status=request.getParameter("status");
        		if(Status==null){
        			condition="where tallyrefno = '' AND paymentdate between '"+mybegindate+"' and '"+myenddate+"' order by paymentdate";
        		}
        		if(Status.equalsIgnoreCase("TDS")){
        			condition="where tallyrefno = '' AND paymentdate between '"+mybegindate+"' and '"+myenddate+"' and a.ded_type ='TDS'  order by a.twempname";
        		}
        		if(Status.equalsIgnoreCase("Short")){
        			condition="where tallyrefno = '' AND paymentdate between '"+mybegindate+"' and '"+myenddate+"' and a.ded_type ='Short'  order by a.twempname";
        		}
        		if(Status.equalsIgnoreCase("Other")){
        			condition="where tallyrefno = '' AND paymentdate between '"+mybegindate+"' and '"+myenddate+"' and a.ded_type ='Other'  order by a.twempname";
        		}
		%>        		
<%
        		
        		
        	}catch(Exception e){
        		out.println(e);
        	}
        	
        	
        	
        	
        	//Status="cleared";
        	//condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and tallyrefno ='' group by a.twempname order by a.twempname";
        	//condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and tallyrefno !=''  order by a.twempname";
        	
        	//if(request.getParameter("all_pending")!=null)
        	//{
        		sql="select DISTINCT twempname from "+session.getAttribute("CompanyMasterID").toString()+"collection"; // as a inner join "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.customercode=b.customercode where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and tallyrefno !='    ' group by a.twempname order by a.twempname ";
        	//}
        	//else
        	//{
        	//	sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"collection as a inner join "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.customercode=b.customercode where tallyrefno = '  ' order by paymentdate";
        	//}
        	//out.println(condition+"-----------"+Status);
        		%>
        		
<!-- 				<div id="reportData"> -->
<%-- 			<iframe id="myIframe" width="100%" height="850px" src="http://twtech.in:8080/ERPTestBirt/frameset?__report=collectionreport.rptdesign&conditions=<%=  condition%>&Status=<%=condition%>&companyid=<%=session.getAttribute("CompanyMasterID").toString() %>&__showtitle=false"> --%>
<!-- 			</iframe>  -->
<!-- 			</div> -->
			<%
        	
        %>
	
	</form>

        		
				
			<%
        }catch(Exception e){
        	
        }

%>
<div id="reportData">
			<iframe id="myIframe" width="100%" height="850px" src="http://twtech.in:8080/ERPTestBirt/frameset?__report=deductionReport.rptdesign&conditions=<%=  condition%>&Status=<%=condition%>&companyid=<%=session.getAttribute("CompanyMasterID").toString() %>&__showtitle=false">
			</iframe> 
			</div>
<!-- 			 <div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!--            	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	</body>
</html>
</jsp:useBean>