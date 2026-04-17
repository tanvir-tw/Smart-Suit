<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@ include file="header.jsp"%>
     <%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Total Task</title>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<style>
th {
    text-align: center;
}

</style>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function consig()
{
	var dept=document.getElementById("companyName1").value;
	
		
	//alert("Customer---------"+customername);
	var ajaxRequest;  // The variable that makes Ajax possible!

	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	//alert("eeeeeeeeeeeeeeeeeeeeeeeeee");
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		   //alert("Original result"+reselt);
			var finalres=reselt.split("#");
			document.getElementById("EmpName").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
			
			  
		 
		}
	
	}
	
	var queryString = "?dept="+dept;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "EmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}

function chk()
{
//alert('Hiii chk');
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
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }

        //return true;
	
}
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.index_total_cat.action ="excel.jsp";
          document.forms["index_total_cat"].submit();
}
function checkAll()
{

	//alert("ok");
	var field = document.getElementById("checkedNumber").value;

//	var field=document.getElementsByName("chkbx");
//	alert("ok"+field);
	var i, chk=1;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById("chkbx"+chk).checked == false)
		 {
			 document.getElementById("chkbx"+chk).checked = true;
		 }

		 chk++;
		
	}
}catch(e){alert(e);}
}

function unCheckAll()
{

	//alert("ok");
var field = document.getElementById("checkedNumber").value;

//var field=document.getElementsByName("chkbx");
//alert("ok"+field);
var kj=1,i;
try{
for (i = 0; i < field; i++)
{
	
	 if(document.getElementById("chkbx"+kj).checked == true )
	 {
		 document.getElementById("chkbx"+kj).checked = false;
	 }
	 kj++;
}
}catch(e){alert(e);}
}

function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	//var chklength = document.getElementById("checkedNumber").value;
	//alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		//	alert("flag"+flag);
		}
	k++;	
	}


	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		//alert("hiiiii1");
		
		
	//	var chklengthnew = document.getElementById("checkedNumber").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for Length of for==>"+chklengthnew.length);
			
			if(document.getElementById("chkbx"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			//	approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
	//	alert("check"+id);
	//	DeleteRow(id,approvalComment);
		DeleteRow(id);
	}
	else
	{
		alert("Please Check Task Id ");
	}
	
}

function DeleteRow(id)
{
	//alert("Control inside deldte function"+id);

	var agree=confirm("Do You Want To Approve Task ?");
	    //alert(agree);
	    if(agree)
	    {
	    	 
	    	window.location="ApprovedTask.jsp?action=approve&id="+id+"";
			
	    }
	    else
	    {
	    	return false;
	    }
 }


function getcheckedrow1()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	//var chklength = document.getElementById("checkedNumber").value;
	//alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		//	alert("flag"+flag);
		}
	k++;	
	}


	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		//alert("hiiiii1");
		
		
	//	var chklengthnew = document.getElementById("checkedNumber").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for Length of for==>"+chklengthnew.length);
			
			if(document.getElementById("chkbx"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			//	approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
		//alert("check count"+cnt);
	//	DeleteRow(id,approvalComment);
		DeleteRow1(id,cnt);
	}
	else
	{
		alert("Please Check Task Id ");
	}
	
}

function DeleteRow1(id,cnt)
{
	//alert("Control inside deldte function"+id);

	var agree=confirm("Do You Want To Reject Task ?");
	    //alert(agree);
	    if(agree)
	    {
	    	 
	    	window.location="ApprovedTask.jsp?action=reject&id="+id+"&cnt="+cnt+"";
			
	    }
	    else
	    {
	    	return false;
	    }
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
		
		
		var dept=document.getElementById("companyName1").value;
		//alert(dept);
		var comid=document.getElementById("comid").value;
		
		var name=document.getElementById("EmpName").value;
		//alert(name);
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
		
		var role=document.getElementById("role").value;
		var sesname=document.getElementById("sesname").value;
		
		//alert(formattedDate1);
		//alert(formattedDate2);
		
		
		//alert(user);
		
		/* 
		document.getElementById("myIframe").src="http:// twdb.fleetview.in:8080/birt/frameset?__report=TaskApprovalReport.rptdesign&dept="+dept+"&fromdate="+formattedDate1+"&todate="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&comid="+comid+"&name="+name+"&role="+role+"&sesname="+sesname+"&__showtitle=false";
//		document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
		document.getElementById("reportData2").style.display="";
		document.getElementById("footer").style.display="none"; */
		
		return true;
		
	}

else
	{
		return false;
	}
		
	}
 
 
</script>

 <script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {

	    	"pagingType": "full_numbers",
	        dom: 'Blfrtip',
	        responsive: true,
	        scrollY:        "400px",
	        scrollX:        true,
	        scrollCollapse: true,
     buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'KRA Task Allocation Report',
	                    },
	                    {
	                        extend: 'pdf',
	                        title: 'KRA Task Allocation Report',
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'KRA Task Allocation Report',
	                    },
	                    {
	                        extend: 'print',
	                        title: 'KRA Task Allocation Report',
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'KRA Task Allocation Report',
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 10]]
	    	
	    } );
	} );

</script>

</head>
<body>
<%!Connection conn = null;
   Statement st = null;
%>
<%
String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String tDate1 = "";
String tDate2 = "";
datenew1 = request.getParameter("from_date1");
datenew2 = request.getParameter("to_date1");
String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
String department="";

Class.forName("com.mysql.cj.jdbc.Driver");
//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");

st=conn.createStatement();

System.out.println("The total Tasks is :"+totalTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);

String Sesrole1=session.getAttribute("role").toString();

%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<%

System.out.println("Ses role :- "+Sesrole1);

if(datenew1==null){
	
	System.out.println("==in if==");
	
	Calendar cal = Calendar.getInstance();
	
	//cal.add(Calendar.DATE, -1);
	
	cal.set(Calendar.DAY_OF_MONTH, 1);	
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data1 = yesterday_dt;
	String temp = data1;
	String fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	Calendar cal2 = Calendar.getInstance();
	cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));

	String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data2 = today_dt;
	temp = data2;
	String toDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String toDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	
	datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	

	
	if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin") || Sesrole1.equalsIgnoreCase("HR"))
	{
		datenew1 = fromDate1;
		datenew2 = ""+toDate1;
	}
	else
	{
	tDate1 = datenew1;
	tDate2 = datenew2;
	}
}
else{
System.out.println("==in else==");
 date1 = datenew1;
 date2 = datenew2;
 
 	tDate1 = date1;
	tDate2 = date2;
}
System.out.println("Date1 :-"+tDate1);
System.out.println("Date2 :-"+tDate2);

DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
String dataDate1=df1234.format(df123.parse(datenew1));
String dataDate2=df1234.format(df123.parse(datenew2));


String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
%>


	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />

		
 <form name="indexReport" method="post"   action="">
<table border="0" align="center" width="50%">
<tr><td align="center"><font color="black" size="3"><b>Task Allocation Report </b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="60%" align="center">
<tr>

<td bgcolor="#f5f5f5" align="center"><font size="2"><b>From</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">

			<input type="text" id="data" name="from_date1" size="12" value="<%=datenew1%>" 
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
			<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>

		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>To</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
		
			<input type="text" id="data1" name="to_date1" size="12" value="<%=datenew2%>"
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
				<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>
		
		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
<!-- <input type="submit" name="button2" id="button2" value="Submit" onclick=" birt1()" style="background-color:#f5f5f5; ">
</input> -->
<input type="submit" name="button2" id="button2" value="Submit" onclick="return chk()"  style="background-color:#f5f5f5; ">
</font></td>
</tr>
</table>
</table>
</form>
	
		<div  style="width:100%;" >	
			
			
			<div align="right"><font size="2">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td> </font>

</div>
<%
	String fromDate = "", toDate = "",fromDate1="",toDate1 = "";
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
		Calendar cal2 = Calendar.getInstance();
		
		cal2.set(Calendar.DAY_OF_MONTH, cal2.getActualMaximum(Calendar.DAY_OF_MONTH));
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal2.getTime());
		data2 = today_dt;
		String temp = data2;
	
		toDate =new SimpleDateFormat("yyyy-MM-dd").format(cal2.getTime());
		toDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal2.getTime());

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
	
	
	
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();

		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		dt=dt+" 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		dt1=dt1+" 23:59:59";
		
		System.out.println("dt:- "+dt);
		System.out.println("dt1:- "+dt1);
		System.out.println("fromDate1:- "+datenew1);
		System.out.println("dtoday:- "+datenew2);
		
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
		String Sesrole2=session.getAttribute("role").toString();
		String Bt=request.getParameter("button2");
		System.out.println("----------In Button-------------"+Bt);
		
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			System.out.println("----------In Button-------------");
			
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			String name13=session.getAttribute("EmpName").toString();
			
			
			System.out.println("Role :- "+Sesrole2);
			
			
			System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
        	
        	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
        	{
        		name13="All";	
        	}
        	else
        	{
        		name13=""+name13;
        	}
        	if(Sesrole2.equals("AllAdmin"))
        			{
        		department="All";
        			}
        	
        	System.out.println("Date :- "+datenew1);
        	System.out.println("Date :- "+datenew2);
        	System.out.println("Name :- "+name13);
		%>
		
		<table id="example"  class="display" style="width:100%"  cellspacing="0" border=""> 
        <thead style="text-align: center;">
            <tr>
            	<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>SrNo</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Id</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>User</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Department</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Assigned</b></th>
            	
            </tr>
        </thead>
        <tbody>
			 <%
			 
			 String UserName="";
			 String EmpCode="";
			 String HOD="";
			 String Dept="";
			 String Assigned="";
			 String UserID="";
			 
			 String DepartmentAll="";
			 String EmpNameAll="";
			 String HODAll="";
			 
			 if(Sesrole2.equals("AllAdmin") || Sesrole2.equalsIgnoreCase("HR")){
				 DepartmentAll="";
				 EmpNameAll="";
				 HODAll="";
				 
			 }
			 else if(Sesrole2.equals("HOD")){
				 DepartmentAll="";
				 EmpNameAll=SesmUsername;
				 HODAll=SesmUsername;
			 }
			

			 String sqlTaskAllocation="select Empname as User,KRAdotprojectid as UserID,empcode,HodReport as HOD "
					 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
							 +"dotproject.tasks a left join dotproject.user_tasks b on " 
							 +"a.task_id=b.task_id  where task_end_date >='"+dt+"' and "
							 +"task_end_date <='"+dt1+"'  and user_id=c.KRAdotprojectid ),0) "
							 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
							 +"and c.companymasterid=100000 and c.dept like '%"+DepartmentAll+"%' and "
							 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

			  System.out.println("Query is : "+sqlTaskAllocation);
			  ResultSet rs = st.executeQuery(sqlTaskAllocation);

		      int i=1;
		      while(rs.next()){
		    	  EmpCode=rs.getString("empcode");
		    	  UserID=rs.getString("UserID");
		    	  UserName=rs.getString("User");
		    	  HOD=rs.getString("HOD");
		    	  Dept=rs.getString("Department");
		    	  Assigned=rs.getString("Assigned");
		    	  int AssignedNew= new Double(Assigned).intValue();
		    	  //System.out.println("Records :- "+EmpCode+" , "+UserName+" , "+HOD+" , "+Dept+" , "+AssignedNew+" , ");
		     
			 %>
			 
			<tr>		
			<td align="right" style="font-size: 12px; face:san-serif; color:black"><%=i%></td>
				<td  align="right" style="font-size: 12px; face:san-serif; color:black"><%=EmpCode%></td>
            	<td style="font-size: 12px; face:san-serif; color:black"><%=UserName%></td>
            	<td style="font-size: 12px; face:san-serif; color:black"><%=Dept%></td>
            	
            	 <td  align="right" style="font-size: 12px; face:san-serif; color:black">
            	<u><a href="TaskDetailsReport.jsp?userid=<%=UserID %>&fromdate=<%=dt %>&todate=<%=dt1 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&Report=KRA&role=<%=Sesrole2%>">
            	 <%=AssignedNew%></a></u></td>
            	
            </tr>
            
             <%
                   i++;      
     			 } 
                  
                 
                  %>     
             </tbody>
      
    </table>
		
		
		<% 
	
	
		
		}
		else
		{System.out.println("----------In Button-------------Else");
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
			%>
			
			
	<table id="example"  class="display" style="width:100%"  cellspacing="0" border=""> 
        <thead style="text-align: center;">
           <div align="right"> <tr>
            	<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>SrNo</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Id</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>User</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Department</b></th>
            	<th align="center" style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;"><b>Assigned</b></th>
            	
            </tr></div>
        </thead>
        <tbody>
			 <%
			 
			 String UserName="";
			 String EmpCode="";
			 String HOD="";
			 String Dept="";
			 String Assigned="";
			 String UserID="";
			 
			 String DepartmentAll="";
			 String EmpNameAll="";
			 String HODAll="";
			 
			 if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HR")){
				 DepartmentAll="";
				 EmpNameAll="";
				 HODAll="";
				 
			 }
			 else if(Sesrole2.equals("HOD")){
				 DepartmentAll="";
				 EmpNameAll=SesmUsername;
				 HODAll=SesmUsername;
			 }
			

			 String sqlTaskAllocation="select Empname as User,KRAdotprojectid as UserID,empcode,HodReport as HOD "
					 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
							 +"dotproject.tasks a left join dotproject.user_tasks b on " 
							 +"a.task_id=b.task_id  where task_end_date >='"+dt+"' and "
							 +"task_end_date <='"+dt1+"'  and user_id=c.KRAdotprojectid ),0) "
							 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
							 +"and c.companymasterid=100000 and c.dept like '%"+DepartmentAll+"%' and "
							 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

			  System.out.println("Query is : "+sqlTaskAllocation);
			  ResultSet rs = st.executeQuery(sqlTaskAllocation);

		      int i=1;
		      while(rs.next()){
		    	  EmpCode=rs.getString("empcode");
		    	  UserID=rs.getString("UserID");
		    	  UserName=rs.getString("User");
		    	  HOD=rs.getString("HOD");
		    	  Dept=rs.getString("Department");
		    	  Assigned=rs.getString("Assigned");
		    	  int AssignedNew= new Double(Assigned).intValue();
		    	  System.out.println("Records :- "+EmpCode+" , "+UserName+" , "+HOD+" , "+Dept+" , "+AssignedNew+" , ");
		     
			 %>
			 
			<tr>		
			<td align="right" style="font-size: 13px; face:san-serif; color:black"><%=i%></td>
				<td align="right" style="font-size: 13px; face:san-serif; color:black"><%=EmpCode%></td>
            	<td style="font-size: 13px; face:san-serif; color:black"><%=UserName%></td>
            	<td style="font-size: 13px; face:san-serif; color:black"><%=Dept%></td>
            	<td  align="right" style="font-size: 12px; face:san-serif; color:black">
            	<u><a href="TaskDetailsReport.jsp?userid=<%=UserID %>&fromdate=<%=dt %>&todate=<%=dt1 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&Report=KRA&role=<%=Sesrole2%>">
            	 <%=AssignedNew%></a></u></td>
            	
            </tr>
            
             <%
                   i++;      
     			 } 
                  
                 
                  %>     
             </tbody>
      
    </table>
		
			 
			 </div>
			
			<% }

%>
	<% %>	
</body>
</html>
<%@ include file="footer_new.jsp"%>	
	


