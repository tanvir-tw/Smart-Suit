<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@ include file="header.jsp"%>
     <%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Total Task</title>
<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
<script src="sorttable.js" type="text/javascript"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function chk()
{

	var dept=document.getElementById("companyName1").value;
	if(dept=="Select")
		{
		
		alert("Please Select Department");
		return false;
		}
	
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

        return true;
	
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
		dept=dept.replace(/&/g,'%26');
		
		//alert(dept);
		
		var comid=document.getElementById("comid").value;
		//alert("Com ID :- "+comid);
		
		var project=document.getElementById("Project").value;
		//alert(" Project :- "+project);
		var status=document.getElementById("Status").value;
		//alert(" Status :- "+status);
		
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
		
		
		
		//alert(formattedDate1);
		//alert(formattedDate2);
		
		
		//alert(user);
		var role=document.getElementById("role").value;
		
		document.getElementById("myIframe").src="http://<%=host1 %>:8080/birt/frameset?__report=purchaseindentreport.rptdesign&dept="+dept+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&comid="+comid+"&project="+project+"&status="+status+"&role="+role+"&__showtitle=false";
//		document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
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

if(datenew1==null){
	
	System.out.println("==in if==");
	datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	
	tDate1 = datenew1;
	tDate2 = datenew2;
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

String Sesrole1=session.getAttribute("role").toString();

%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<%

System.out.println("Ses role :- "+Sesrole1);
String name=session.getAttribute("EmpName").toString();

%>


	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
		
	
	<%
       //  final String exportFileName="Total_Task_Report_of_"+user_name+"_Between_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate))+"_And_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toTime));  
	%>
	<%-- <table align="center" width="100%">
			<tr align="center">
				<td align="center">
					<font size="3"><b>Task Report of <%= user_name %> Between <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate)) %> And <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toTime)) %></b></font>
					<font size="3"><b>Task Report</b></font>
				</td>
			</tr>
		</table> --%>
		
		<!-- <form name="indexReport" method="get"   action=""> -->
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="black" size="3"><b>Purchase Indent Report </b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="60%" align="center">
<tr>

<td>

         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Dept</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="companyName1" id="companyName1" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%--   <option ><%=cmp %></option>  --%>
           <!-- <option value="Select">Select</option> -->
          <option value="All">All</option>
            <%
            String sql1="";
            
             
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  order by dept";
             
            	 
            	 
            	 
            	 
            	 
            	 
            	
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			department=rsregno.getString("department");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("department-->"+department);
			%>
			<option value="<%=department%>"><%=department%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>

<td>
         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Project</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="Project" id="Project" style="width: 100px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%--   <option ><%=cmp %></option>  --%>
         
            <option value="All">All</option>
         
            <%
            String sql2="";
            
             
            	sql2="select distinct(Project) as EmpName  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData  order by Project";
            
            	 
            	 
            	
            	 
            	 
            	 
            	
		System.out.println("*******"+sql2);
        ResultSet rsregno1 = st.executeQuery(sql2);
		while(rsregno1.next())
		{
			 
			department=rsregno1.getString("EmpName");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("department-->"+department);
			%>
			<option value="<%=department%>"><%=department%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>
           
           
           <td>
         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Status</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="Status" id="Status" style="width: 100px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%--   <option ><%=cmp %></option>  --%>
         
            <option value="All">All</option>
          
            <%
            String sql3="";
            
             
            	sql3="select distinct(Status) as EmpName  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData  order by Status";
            
            	 
            	 
            	
            	 
            	 
            	 
            	
		System.out.println("*******"+sql3);
        ResultSet rsregno2 = st.executeQuery(sql3);
		while(rsregno2.next())
		{
			 
			department=rsregno2.getString("EmpName");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("department-->"+department);
			%>
			<option value="<%=department%>"><%=department%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>


<td bgcolor="#f5f5f5" align="center"><font size="2"><b>From Date</b></font></td>
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
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>To Date</b></font></td>
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
<input type="submit" name="button2" id="button2" value="Submit" onclick=" birt1()" style="background-color:#f5f5f5; ">
</input></font></td>
</tr>
</table>
</table>
</form>
		
		
	<table width="100%" border="0" align="center">
			<tr>
				
			</tr>
			
	</table>	
	
	
	<!-- <table align="right" style="width:100%">
<tr><td><input type="button" name="Create Invoice"  value="Approve" onclick="getcheckedrow()" /> </td> <td></td><td><td></td>
			
				
 </tr>
<tr><td><input type="button" name="Create Invoice"  value="Reject" onclick="getcheckedrow1()" /> </td> <td></td><td><td></td>
			
				
</tr> 

</table> -->

	
<br>
		
		<div align="center" style="width:100%;" id="table1">	
		<div align="left">
<table width ="100%" border="0">	
<tr align="left"><td><a href="PurchaseIndentEntryForm.jsp"><b>Add New</b></a></td>

				
		</tr></table>
</div>	
			
			<div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
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
	
	
	
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();

		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		
		dt=dt+" 00:00:00";
		
		//dt="2017-07-21 00:00:00";
		
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

		String Bt=request.getParameter("button2");
System.out.println("----------In Button-------------"+Bt);
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{System.out.println("----------In Button-------------");



			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			String name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			
			System.out.println("Role :- "+Sesrole2);
			
			
			System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
		%>
			<div id="reportData1">		
			<iframe id="myIframe" width="100%" height="850px" src="http://<%=host1 %>:8080/birt/frameset?__report=purchaseindentreport.rptdesign&Date=<%=dt %>&Date1=<%=dt1 %>&dt=<%=datenew1 %>&dt1=<%=datenew2 %>&dept=All&comid=<%=comid2 %>&status=All&project=All&role=<%=Sesrole2 %>&__showtitle=false">
																																						
				<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
				</iframe> 
			</div>
		<% 
	
	
		
		}
		else
		{System.out.println("----------In Button-------------Else");
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
			%>
			<div id="reportData">		
			<%-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")))%>&date2=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")))%>&drivername=<%= request.getParameter("trNm1")%>";> --%>
				<iframe id="myIframe" width='100%' height='650px' src="">
				</iframe> 
			</div>
			<% }

%>
				
		
</div>		
	<%-- <%@ include file="footer_new.jsp" %> --%>		
	
	<% %>	
</body></html>

		
	



