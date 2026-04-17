<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">




		<!-- <script src="ledgerDetails.js" type="text/javascript"></script> -->


	<script language="JavaScript1.2">
	
	
	function chk()
	{

		
		
		var chkf="";
		var chkt="";
		var objFromDate = document.getElementById("data").value;
		var fdate=objFromDate.split("-");
		if(fdate[1]=="Jan")
		{
			chkf="01";
		}
		if(fdate[1]=="Feb")
		{
			chkf="02";
		}
		if(fdate[1]=="Mar")
		{
			chkf="03";
		}
		if(fdate[1]=="Apr")
		{
			chkf="04";
		}
		if(fdate[1]=="May")
		{
			chkf="05";
		}
		if(fdate[1]=="Jun")
		{
			chkf="06";
		}
		if(fdate[1]=="Jul")
		{
			chkf="07";
		}
		if(fdate[1]=="Aug")
		{
			chkf="08";
		}
		if(fdate[1]=="Sep")
		{
			chkf="09";
		}
		if(fdate[1]=="Oct")
		{
			chkf="10";
		}
		if(fdate[1]=="Nov")
		{
			chkf="11";
		}
		if(fdate[1]=="Dec")
		{
			chkf="12";
		}
		var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
	    var objToDate = document.getElementById("data1").value;
	    var tdate=objToDate.split("-");
	    if(tdate[1]=="Jan")
		{
	    	chkt="01";
		}
		if(tdate[1]=="Feb")
		{
			chkt="02";
		}
		if(tdate[1]=="Mar")
		{
			chkt="03";
		}
		if(tdate[1]=="Apr")
		{
			chkt="04";
		}
		if(tdate[1]=="May")
		{
			chkt="05";
		}
		if(tdate[1]=="Jun")
		{
			chkt="06";
		}
		if(tdate[1]=="Jul")
		{
			chkt="07";
		}
		if(tdate[1]=="Aug")
		{
			chkt="08";
		}
		if(tdate[1]=="Sep")
		{
			chkt="09";
		}
		if(tdate[1]=="Oct")
		{
			chkt="10";
		}
		if(tdate[1]=="Nov")
		{
			chkt="11";
		}
		if(tdate[1]=="Dec")
		{
			chkt="12";
		}
	    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
	   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
	     
	    var date1 = new Date(objFromDate1);
	    var date2 = new Date(objToDate1);
	    
	    //alert("from > "+date1+" Todate > "+date2);
	    
	    var date3 = new Date();
	    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
	    var currentDate = new Date(date4);
	     
	        if(date1 > date2)
	        {
	            alert("From Date Should be Less Than To Date");
	            return false; 
	        }
//	         else if(date1 > currentDate)
//	         {
//	             alert("From Date should be less than current date");
//	             return false; 
//	         }
//	         else if(date2 > currentDate) 
//	         {
//	             alert("To Date should be less than current date");
//	             return false; 
//	         }

	        return true;
		
	}


	function birt1()
	{
		//alert("HI");
		
		//alert(Customer)
		
		
		var a=chk();
		//alert(a);
		if(a==true)
		{
		
			
			
			
			var date1= document.getElementById("data").value;
			//alert(date1);
			
			
			var date2= document.getElementById("data1").value;
			//alert(date2);
			
			
			var userid=document.getElementById("userid").value;
			var comid=document.getElementById("comid").value;
			
			
			var date = date1.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++)
			{
			    if(date[1]==months[j])
			    {
			         date[1]=months.indexOf(months[j])+1;
			    }                      
			} 
			if(date[1]<10)
			{
			    date[1]='0'+date[1];
			}                        
			var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
			
			
			
			
			var dat = date2.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++){
			    if(dat[1]==months[j]){
			         dat[1]=months.indexOf(months[j])+1;
			     }                      
			} 
			if(dat[1]<10){
			    dat[1]='0'+dat[1];
			}                        
			var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
			
			
			
			formattedDate1=formattedDate1+" 00:00:00";
			formattedDate2=formattedDate2+" 23:59:59";
			//alert("status---"+status);
			
			
			//alert(formattedDate1);
			//alert(formattedDate2);
			
			
			//alert(user);
			
			
			document.getElementById("myIframe").src="http:// "+host1+":8080/birt/frameset?__report=TaskDurationReport.rptdesign&userid="+userid+"&fromdate="+formattedDate1+"&todate="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&comid="+comid+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("reportData2").style.display="";
			document.getElementById("footer").style.display="none";
			
			return true;
			
		}
	
	else
		{
			return false;
		}
			
		}
	</script>

<body>

<% erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD); %>
<%!
Connection conn=null;
%>

<%
//////////



conn=erp.ReturnConnection();
Statement st=conn.createStatement();
Statement st1=conn.createStatement();
Statement st2=conn.createStatement();
Statement st3=conn.createStatement();
Statement st4=conn.createStatement();
Statement st5=conn.createStatement();
Statement st6=conn.createStatement();
Statement st7=conn.createStatement();
Statement st8=conn.createStatement();
Statement st9=conn.createStatement();
Statement st10=conn.createStatement();
%>

<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String CustomerCode="";
	String dotprojectid="";
	
	String stp="Pending";
	String comid=session.getAttribute("CompanyMasterID").toString();
	
	%>
	<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
	<%
	
	
	//CompanyName ---->null
	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
String user="";
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	
	
	String role=session.getAttribute("role").toString();
	System.out.println("Role :- "+role);
	
	
	
	/* if(role.equals("AllAdmin") || role.equals("HOD"))
			{
	String userdetails="select * from db_GlobalERP.UserMaster where HODreport='"+session.getAttribute("EmpName").toString()+"' ";
			} */
	
	//single user
	/* if(role.equals("-"))
			{
	 user="select dotprojectid from db_GlobalERP.UserMaster where role!='' and activestatus='Yes' and Empname='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	else if(role.equals("AllAdmin") || role.equals("HOD"))
	{
	//HOD
	user="select dotprojectid from db_GlobalERP.UserMaster where role!='' and activestatus='Yes' and HODReport='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	} */
	%>
	
	<input type="hidden" id="userid" name="userid" value="<%=user%>" />
	<% 
	/* ResultSet rs=st.executeQuery(user);
	
	System.out.println("Query :- "+user);
	
	while(rs.next())
	{
		dotprojectid=rs.getString("dotprojectid");
	}
	System.out.println("dotprojectid :- "+dotprojectid); */
	%>
	 








<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->
<table  align="center" >
<tr align="center">

<td>
<font size="3"><b>Task Description Report </b></font></td></tr>
</tabel>
<br></br>
<table  align="center" >
</tr></table></div>
           
           <div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>

<%
		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(fromDate1));
		dt=dt+" 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(dtoday));
		dt1=dt1+" 23:59:59";
		
		System.out.println("dt:- "+dt);
		System.out.println("dt1:- "+dt1);
		System.out.println("fromDate1:- "+fromDate1);
		System.out.println("dtoday:- "+dtoday);
		
		//cmp=cmp.replace("...","&");
		//cmp=cmp.replace("&","%26");
		%>
		
		<%-- <div id="reportData1">		
<iframe id="myIframe" width="100%" height="850px" src="http:// twdb.fleetview.in:8080/ERPTestBirt/frameset?__report=Transaction_report.rptdesign&Date=<%=dt %>&Date1=<%=dt1 %>&dt=<%=fromDate1 %>&dt1=<%=dtoday %>&Payment=All&__showtitle=false">
																												Transaction_report.rptdesign&Payment="+Customer+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&__showtitle=false							
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe> 
</div> --%>
<%

		String Bt=request.getParameter("button2");
System.out.println("----------In Button-------------"+Bt);
		if(Bt=="null")
		{System.out.println("----------In Button-------------");
%>
<div id="reportData">		
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")))%>&date2=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")))%>&drivername=<%= request.getParameter("trNm1")%>";> --%>
	<iframe id="myIframe" width='100%' height='650px' src="">
	</iframe> 
</div>
	
	<%
		
		}
		else
		{
			String POStatus="Pending";
			String userid1=request.getParameter("userid");
			String fromdate11=request.getParameter("fromdate");
			String todate11=request.getParameter("todate");
			System.out.println("drill id :- "+userid1);
			System.out.println("drill from date :- "+fromdate11);
			System.out.println("drill to date :- "+todate11);
		%>
			<div id="reportData1">		
			<iframe id="myIframe" width="100%" height="850px" src="http:// <%= host1 %>:8080/birt/frameset?__report=TaskDescriptionReport.rptdesign&fromdate=<%=fromdate11 %>&todate=<%=todate11 %>&userid=<%=userid1 %>&comid=<%=comid %>&__showtitle=false">
																																						
				<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
				</iframe> 
			</div>
		<% }

%>
           
           </body></jsp:useBean>