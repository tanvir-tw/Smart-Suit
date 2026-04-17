<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Opportunity Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>


<!-- <style>-->
<!--th-->
<!--{-->
<!--background: #C6DEFF;-->
<!--}-->
<!--</style>-->
<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.categoryform.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["categoryform"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteRow(id)
{
	// alert(id);
	 var id=id;
	 var agree=confirm("Do You Want To Deactivate This Record?");
	 //alert(agree);
	 if(agree)
	 {
	 	 
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(">>>    "+reslt);
				var data=reslt.split("#");
				//alert("<*****  "+data);
				if(data[1].indexOf('Yes')!=-1)
				{alert("De-activated successfully.....");					
			    	window.location.reload();
			    	
				}
			
			} 
		}
		
		var queryString = "?action=delete&Id="+id;
		
		
		ajaxRequest.open("GET", "opportunityCancel.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 }
	 else
	 	 {
	 	 
	 	  return false;
	 }
	 
	
}  


function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,k=1,flag="t";
	var chklength=document.getElementsByName("chkbx");
//	alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
	var i=1,j,cnt=0;
	var id="";
	//alert("hiiiii1");
	
	if(flag == "success")
	{
	for(cnt=0;cnt<chklength.length;cnt++)
	{
		//alert("for"+chklength.length);
		
		if(document.getElementById("chk"+i).checked)
		{
			//alert("if");
			id=id+","+document.getElementById("net_id1"+i).innerHTML;
		}
		i++;
	}
	//alert("check"+id);
	DeleteRow(id);
	}
	else
	{
		alert("Please Select Category For Deactivation");
	}
	
}
function getCustomer(customer){
	alert("hi");
	alert(document.getElementById('customer').value=customer);
}

function allSelected(allVal)
{
	//alert("In AllSelected");
	
	if(document.getElementById("extAll").checked==true)  
	{	
		document.getElementById("frmDT").style.display='none';
    	document.getElementById("toDT").style.display='none';
    }
	else 
	{
		document.getElementById("frmDT").style.display="";
    	document.getElementById("toDT").style.display="";
	}
	
	/* if(document.dateform.extAll.checked) 
	{
		document.getElementById("frmDT").style.display='none';
    	document.getElementById("toDT").style.display='none';
    }
	else 
	{
		document.getElementById("frmDT").style.display="";
    	document.getElementById("toDT").style.display="";
	} */
}
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
function birt()
{
	//alert("HI");
	var a=chk();
	//alert("GetValid------>"+a);
	if(a==true)
		{
		//alert("Hi");
		var Customer= document.getElementById("companyName").value;
		//Customer="%26"+Customer;
		//Customer=Customer.replace(/\'*'/g,'&');
		Customer=Customer.replace(/&/g,'%26');
		//alert("Cust---"+Customer);
		var Load= document.getElementById("loadtype").value;
		//alert("Load---"+Load);
		var Freight= document.getElementById("frttype").value;
		//alert("Freight---"+Freight);
		var Origin= document.getElementById("origin").value;
		//alert("Origin---"+Origin);
		var Destination= document.getElementById("dest").value;
		//alert("Destination---"+Destination);
		//var date1= document.getElementById("date3").value;
		var date1= document.getElementById("data").value;
		//alert(date1);
		
		
		var date2= document.getElementById("data1").value;
		//alert(date2);
		var al=document.getElementById("extAll").checked;
		//alert(al);
		 
		if(al==true)
			{
				al="All";
				
			}
		else
			{
				al="no";			
			}
		
		
		
		
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
		
		var status=document.getElementById("status").value;
		
		formattedDate1=formattedDate1+" 00:00:00";
		formattedDate2=formattedDate2+" 23:59:59";
		//alert("status---"+status);
		
		
		//alert(formattedDate1);
		//alert(formattedDate2);
		
		
		//alert(user);
		
		
		document.getElementById("myIframe").src="http://"+host+"/birt/frameset?__report=Opportunity_Report.rptdesign&Customer="+Customer+"&Load="+Load+"&Freight="+Freight+"&Origin="+Origin+"&Destination="+Destination+"&all="+al+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&Status="+status+"&__showtitle=false";
//		document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
		document.getElementById("reportData").style.display="";
		document.getElementById("footer").style.display="none";
		
		
		return true;
		
		}
	
	else
		{
			return false;
		}
	}



function birt1()
{
	//alert("HI");
	var a=chk();
	//alert("GetValid------>"+a);
	if(a==true)
		{
		//alert("Hi");
		var Customer= document.getElementById("companyName1").value;
		//alert("Customer ---"+Customer);
		//Customer="%26"+Customer;
		//Customer=Customer.replace(/\'*'/g,'&');
		Customer=Customer.replace(/&/g,'%26');
		//alert("Customer ---"+Customer);
		
		var Load= document.getElementById("loadtype").value;
		//alert("Load---"+Load);
		var Freight= document.getElementById("frttype").value;
		//alert("Freight---"+Freight);
		var Origin= document.getElementById("origin").value;
		//alert("Origin---"+Origin);
		var Destination= document.getElementById("dest").value;
		
		
		
		var date1= document.getElementById("data").value;
		//alert(date1);
		
		
		var date2= document.getElementById("data1").value;
		//alert(date2);
		
		
		var status=document.getElementById("status").value;
		
		
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
		
		
		document.getElementById("myIframe").src="http://"+host+"/birt/frameset?__report=Opportunity_Report.rptdesign&Customer="+Customer+"&Load="+Load+"&Freight="+Freight+"&Origin="+Origin+"&Destination="+Destination+"&all=no&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&Status="+status+"&__showtitle=false";
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
	String cmp=request.getParameter("companyname");
	
	
	
	
	
	System.out.println("CompanyName ---->"+cmp);
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
	
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); %>
	 


<%


if(cmp != null)

{
	cmp=cmp.replace("...","&");
	
	String query="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+cmp+"' ";
	 ResultSet rs=st.executeQuery(query);
	if(rs.next()){
		
		 CustomerCode=rs.getString("CustomerCode");
		
	}
%>

<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->
<table  align="center"  style="width: 100%;">
<tr>
<tr align="center">
<td align="center" colspan="13">
<font size="3"><b>Opportunity Report</b></font></td></tr>

<tr>
	
	<td>
         <font size="2">Customer:</font>
           <select name="companyName1" id="companyName1" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%--   <option ><%=cmp %></option>  --%>
           <option value="<%=cmp%>"><%=cmp%></option>
            <%
            String customer="";
       	String sql1 = "SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName";
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			 customer=rsregno.getString("CompanyName");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("Customer-->"+customer);
			%>
			<option value="<%=customer%>"><%=customer%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Load Type:</font>
           <select name="loadtype" id="loadtype" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String load="";
            String load1="''";
       	String sql2 = "SELECT Distinct loadType FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster  order by loadType";
		System.out.println("*******"+sql2);
        ResultSet rs1 = st1.executeQuery(sql2);
		while(rs1.next())
		{
			 
			 load=rs1.getString("loadType");
			// load="'"+load+"'";
			// load1=load1+","+load;
			// System.out.println("Load Type-->"+load);
			// System.out.println("Load 1-->"+load1);
			%>
			<option value="<%=load%>"><%=load%></option>
	         <%
			
      }
		System.out.println("Load 1-->"+load1);
		%>
           </select>
           </td>
           
           
            <td>
         <font size="2">Freight Type:</font>
           <select name="frttype" id="frttype" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String frt="";
       	String sql3 = "SELECT Distinct frttype FROM "+session.getAttribute("CompanyMasterID").toString()+"freightMaster  order by frttype";
		System.out.println("*******"+sql3);
        ResultSet rs2 = st2.executeQuery(sql3);
		while(rs2.next())
		{
			 
			 frt=rs2.getString("frttype");
			 
			 System.out.println("Freight Type-->"+frt);
			%>
			<option value="<%=frt%>"><%=frt%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
            <td>
         <font size="2">Origin:</font>
           <select name="origin" id="origin" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String origin="";
       	String sql4 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql4);
        ResultSet rs3 = st3.executeQuery(sql4);
		while(rs3.next())
		{
			 
			 origin=rs3.getString("City");
			 
			 System.out.println("Origin-->"+origin);
			%>
			<option value="<%=origin%>"><%=origin%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Destination:</font>
           <select name="dest" id="dest" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String dest="";
       	String sql5 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql5);
        ResultSet rs4 = st4.executeQuery(sql5);
		while(rs4.next())
		{
			 
			 dest=rs4.getString("City");
			 
			 System.out.println("Destination-->"+dest);
			%>
			<option value="<%=dest%>"><%=dest%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Status:</font>
           <select name="status" id="status" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option>
            <%
            String status="";
       	String sql6 = "SELECT Distinct Status FROM "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster order by status desc";
		System.out.println("*******"+sql6);
        ResultSet rs5 = st4.executeQuery(sql6);
		while(rs5.next())
		{
			 
			 status=rs5.getString("status");
			 System.out.println("Status-->"+status);
			 
			%>
			<option value="<%=status%>"><%=status%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           <!-- <td align="left"><font face="Arial" color="black" size="2">
			All</font> <input type="checkbox" name="extAll" id="extAll" value="Yes"  onclick="allSelected(this.value);"></input>
				</td> -->
           
          
		<%System.out.println("Date from-"+dtoday);
		System.out.println("Date to-"+dtoday);
		%>
           
           
           <td id="frmDT" align="left" ><font size="2" style="display:'' ">From : </font>&nbsp;&nbsp; <input
			type="text" size="8" id="data" name="data"
			value="<%=fromDate1 %>" size="8" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td id="toDT" align="left" ><font size="2" style="display:''">To : </font>&nbsp;&nbsp; <input
			type="text" size="8" id="data1" name="data1"
			value="<%=dtoday %>" size="8" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td><input type="submit" name="button2" id="button2" value="Submit" onclick=" birt1()"></td>
		
		
	</tr>



</table>
</form>
</div>

<div align="left">
<table width ="100%" border="0">	
<tr align="left"><td><a href="new_opportunityMaster.jsp?companyNames=<%=request.getParameter("companyname")%>&customercode=<%=CustomerCode %>&customertype=<%=request.getParameter("customertype")%>"><b>Add New</b></a></td>

				
		</tr></table>
</div>
<div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>

<%
		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(fromDate1));
		dt=dt+ " 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(dtoday));
		dt1=dt1+ " 23:00:00";
		
		//cmp=cmp.replace("...","&");
		cmp=cmp.replace("&","%26");
		%>
		
		<div id="reportData1">		
<iframe id="myIframe" width="100%" height="850px" src="http://<%=host1%>/birt/frameset?__report=Opportunity_Report.rptdesign&Customer=<%=cmp %>&Load=All&Freight=All&Origin=All&Destination=All&all=no&Date=<%=dt %>&Date1=<%=dt1 %>&dt=<%=fromDate1 %>&dt1=<%=dtoday %>&Status=All&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe> 
</div>
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

%>
<%} 

else{
	
cmp="All";

%>



		

<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->
<table  align="center"  style="width: 100%;">
<tr>
<tr align="center">
<td align="center" colspan="13">
<font size="3"><b>Opportunity Report</b></font></td></tr>

<tr>
	
	<td>
         <font size="2">Customer:</font>
           <select name="companyName" id="companyName" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All"><%=cmp %></option> 
            <%
            String customer="";
       	String sql1 = "SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName";
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			 customer=rsregno.getString("CompanyName");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("Customer-->"+customer);
			%>
			<option value="<%=customer%>"><%=customer%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Load Type:</font>
           <select name="loadtype" id="loadtype" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String load="";
            String load1="''";
       	String sql2 = "SELECT Distinct loadType FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster  order by loadType";
		System.out.println("*******"+sql2);
        ResultSet rs1 = st1.executeQuery(sql2);
		while(rs1.next())
		{
			 
			 load=rs1.getString("loadType");
			// load="'"+load+"'";
			// load1=load1+","+load;
			// System.out.println("Load Type-->"+load);
			// System.out.println("Load 1-->"+load1);
			%>
			<option value="<%=load%>"><%=load%></option>
	         <%
			
      }
		System.out.println("Load 1-->"+load1);
		%>
           </select>
           </td>
           
           
            <td>
         <font size="2">Freight Type:</font>
           <select name="frttype" id="frttype" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String frt="";
       	String sql3 = "SELECT Distinct frttype FROM "+session.getAttribute("CompanyMasterID").toString()+"freightMaster  order by frttype";
		System.out.println("*******"+sql3);
        ResultSet rs2 = st2.executeQuery(sql3);
		while(rs2.next())
		{
			 
			 frt=rs2.getString("frttype");
			 
			 System.out.println("Freight Type-->"+frt);
			%>
			<option value="<%=frt%>"><%=frt%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
            <td>
         <font size="2">Origin:</font>
           <select name="origin" id="origin" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String origin="";
       	String sql4 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql4);
        ResultSet rs3 = st3.executeQuery(sql4);
		while(rs3.next())
		{
			 
			 origin=rs3.getString("City");
			 
			 System.out.println("Origin-->"+origin);
			%>
			<option value="<%=origin%>"><%=origin%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Destination:</font>
           <select name="dest" id="dest" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option> 
            <%
            String dest="";
       	String sql5 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql5);
        ResultSet rs4 = st4.executeQuery(sql5);
		while(rs4.next())
		{
			 
			 dest=rs4.getString("City");
			 
			 System.out.println("Destination-->"+dest);
			%>
			<option value="<%=dest%>"><%=dest%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           
           <td>
         <font size="2">Status:</font>
           <select name="status" id="status" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
           <option value="All">All</option>
            <%
            String status="";
       	String sql6 = "SELECT Distinct Status FROM "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster order by status desc";
		System.out.println("*******"+sql6);
        ResultSet rs5 = st4.executeQuery(sql6);
		while(rs5.next())
		{
			 
			 status=rs5.getString("status");
			 System.out.println("Status-->"+status);
			 
			%>
			<option value="<%=status%>"><%=status%></option>
	         <%
			
      }
		%>
           </select>
           </td>
           <td align="left"><font face="Arial" color="black" size="2">
			All</font> <input type="checkbox" name="extAll" id="extAll" value="Yes"  onclick="allSelected(this.value);"></input>
				</td>
           
          
		<%System.out.println("Date from-"+dtoday);
		System.out.println("Date to-"+dtoday);
		%>
		<td id="frmDT" align="left" ><font size="2" style="display:'' ">From : </font>&nbsp;&nbsp; <input
			type="text" size="8" id="data" name="data"
			value="<%=fromDate1 %>" size="8" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td id="toDT" align="left" ><font size="2" style="display:''">To : </font>&nbsp;&nbsp; <input
			type="text" size="8" id="data1" name="data1"
			value="<%=dtoday %>" size="8" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td><input type="submit" name="button1" id="button1" value="Submit" onclick=" return birt()"></td>
		
		
	</tr>



</table>
</form>
</div>

<div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</div>
<%-- <div>
<table width ="100%" border="0">	
<tr align="left">

<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('dept','tableHTML');"/>

	           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>					
		</tr></table>
</div> --%>

<%
		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(fromDate1));
		dt=dt+ " 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(dtoday));
		dt1=dt1+ " 23:00:00";
		%>
		
		<div id="reportData1">		
<iframe id="myIframe" width="100%" height="850px" src="http://<%= host1 %>/birt/frameset?__report=Opportunity_Report.rptdesign&Customer=All&Load=All&Freight=All&Origin=All&Destination=All&all=no&Date=<%=dt %>&Date1=<%=dt1 %>&dt=<%=fromDate1 %>&dt1=<%=dtoday %>&Status=All&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe> 
</div>
<%

		String Bt=request.getParameter("button1");
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
}
%>


<%-- <form  name="categoryform"id="categoryform" action="" method="post" name="">
<%
String exportFileName="opportunity_report.xls"; 
String company= request.getParameter("companyName");

//System.out.println("company :- "+company);

//String c1="";



//System.out.println("C1-->"+c1);


//String company= session.getAttribute("Company").toString();
//System.out.println("Session Company-->"+session.getValue("Company").toString());
//session.setAttribute("Company", request.getParameter("companyNames"));
//String user=request.getParameter("companyNames");
	//session.setAttribute("Company",user) ; 
System.out.println("Company in Session-->"+session.getAttribute("Company"));
// GIVE YOUR REPORT NAME
%>




		
<div id='dept' align="center" >

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

					
<table align="center" id="reporttbl" class="sortable" border="3" style=" color: black;border-collapse:collapse; width: 100%;" >
<thead>
<tr>
<th><b>Sr.</b></th>
<th><b>Customer Name</b></th>
<th><b>Marketing Rep.Name</b></th>
<th><b>Opportunity Branch</b></th>
<th><b>Billing Branch</b></th>
<th><b>Consignor</b></th>
<th><b>Consignee</b></th>
<th><b>Origin</b></th>
<th><b>Destination</b></th>
<th><b>Freight Type</b></th>
<th><b>Load Type</b></th>
<th><b>Monthly Volume(Tons)</b></th>
<th><b>Products</b></th>
<th><b>Lead Reference</b></th>
<th><b>Existing Transporter Name</b></th>
<th><b>Risk Involved</b></th>
<th><b>Valid From</b></th>
<th><b>Valid To</b></th>
<th><b>Commission</b></th>
<th><b>Remarks</b></th>
<th><b>Entry By</b></th>
<th><b>Entry DateTime</b></th>

</tr>
</thead>


<%
/////////
System.out.println("Hiiiii"); 
 String date="",status1="";
String cust="",date1="",date2="",loadtype="",frttype="",startplace="",endplace="";
String cust1="''",loadtype1="''",frttype1="''",startplace1="''",endplace1="''";
//cust=request.getParameter("companyName");
String chbxAll=request.getParameter("extAll");
		System.out.println("--check box is  ------>>>"+chbxAll);
System.out.println("Compnay Name"+cust);
if (!(null == request.getParameter("data"))) {
	System.out.println("In request get");
	cust=request.getParameter("companyName");
	cust= cust.replaceAll("'", "''");
	if(cust.equals("All")){
		
		 
	       	String sql12 = "SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName";
			System.out.println("*******"+sql12);
	        ResultSet rsregno12 = st5.executeQuery(sql12);
			while(rsregno12.next())
			{
				 
				 customer=rsregno12.getString("CompanyName");
				 customer="'"+customer+"'";
			
				 cust1=cust1+","+customer;
				 //cust1=cust1.replaceAll("'","''");
				
	      }
			
		
	}else{
		cust="'"+cust+"'";
		//cust1=cust1+","+cust;
		cust1=cust;
	//	cust1=cust1.replaceAll("'","''");
	}
	System.out.println("Customer name is"+cust1);
	loadtype=request.getParameter("loadtype");
	if(loadtype.equals("All")){
		String sql21 = "SELECT Distinct loadType FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster  order by loadType";
		System.out.println("*******"+sql21);
        ResultSet rs12 = st6.executeQuery(sql21);
		while(rs12.next())
		{
			 
			 load=rs12.getString("loadType");
			 load="'"+load+"'";
			 loadtype1=loadtype1+","+load;
			 
			
			
      }
	}else {
		loadtype="'"+loadtype+"'";
		//loadtype1=loadtype1+","+loadtype;
		loadtype1=loadtype;
	}
	System.out.println("LoadType->"+loadtype1);
	frttype=request.getParameter("frttype");
	if(frttype.equals("All")){
		String sql31 = "SELECT Distinct frttype FROM "+session.getAttribute("CompanyMasterID").toString()+"freightMaster  order by frttype";
		System.out.println("*******"+sql31);
        ResultSet rs21 = st7.executeQuery(sql31);
		while(rs21.next())
		{
			 
			 frt=rs21.getString("frttype");
			 frt="'"+frt+"'";
			 frttype1=frttype1+","+frt;

      }
	}else{
		frttype="'"+frttype+"'";
		//frttype1=frttype1+","+frttype;
		frttype1=frttype;
	}
	System.out.println("FRTType->"+frttype1);
	startplace=request.getParameter("origin");
	if(startplace.equals("All")){
		String sql41 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql41);
        ResultSet rs31 = st8.executeQuery(sql41);
		while(rs31.next())
		{
			 
			 origin=rs31.getString("City");
			 origin="'"+origin+"'";
			 startplace1=startplace1+","+origin;

			
			
      }
	}else{
		startplace="'"+startplace+"'";
		//startplace1=startplace1+","+startplace;
		startplace1=startplace;
	}
	System.out.println("Origni->"+startplace1);
	endplace=request.getParameter("dest");
	if(endplace.equals("All")){
		String sql51 = "SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City";
		System.out.println("*******"+sql51);
        ResultSet rs41 = st9.executeQuery(sql51);
		while(rs41.next())
		{
			 
			 dest=rs41.getString("City");
			 dest="'"+dest+"'";
			 endplace1=endplace1+","+dest;
			 
		
			
      }
	}else{
		endplace="'"+endplace+"'";
		//endplace1=endplace1+","+endplace;
		endplace1=endplace;
	}
		
	System.out.println("Destination->"+endplace1);
	 date1=request.getParameter("data");
	date2=request.getParameter("data1");

	fromDate = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(date1));
	
	toDate = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(date2));
	
}
	String fromDateTime = fromDate + " " + "00:00:00";
	String toDateTime = toDate + " " + "23:59:59";
	String sql="";	
	if( (cust.equals("All")) && chbxAll==null||  chbxAll==""  ){
		System.out.println("In first Condition");
		sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where  entrydatetime>='"+fromDateTime+ "' and entrydatetime<='"+toDateTime+"' and  loadType in ("+loadtype1+") and frttype in ("+frttype1+") and locationFrom in ("+startplace1+") and locationTo in ("+endplace1+")   and  Status='Yes' order by entrydatetime desc  ";	
	}
	else  if(!(cust.equals("All")) && chbxAll==null){
	  System.out.println("In Second Condition");
	  sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where  (customer in ("+cust1+") Or consigner in ("+cust1+") Or consignee in ("+cust1+")) and entrydatetime>='"+fromDateTime+ "' and entrydatetime<='"+toDateTime+"' and  loadType in ("+loadtype1+") and frttype in ("+frttype1+") and locationFrom in ("+startplace1+") and locationTo in ("+endplace1+")   and  Status='Yes' order by entrydatetime desc  ";
  }
	else if(cust.equals("All") && chbxAll.equals("Yes")){
		System.out.println("In Third Condition");
	//  sql = "select * from  t_opportunitymaster where (customer='"+cust+"' Or consigner='"+cust+"' Or consignee='"+cust+"') and entrydatetime>='"+fromDateTime+ "' and entrydatetime<='"+toDateTime+"' and  loadType='"+loadtype+"' and frttype='"+frttype+"' and locationFrom='"+startplace+"' and locationTo='"+endplace+"'   and  Status='Yes' order by entrydatetime desc  ";\
	  sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where   loadType in ("+loadtype1+") and frttype in ("+frttype1+") and locationFrom in ("+startplace1+") and locationTo in ("+endplace1+")   and  Status='Yes' order by entrydatetime desc  ";
	}else{
		System.out.println("In fourth Condition");
		sql = "select * from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where (customer in ("+cust1+") Or consigner in ("+cust1+") Or consignee in ("+cust1+")) and loadType in ("+loadtype1+") and frttype in ("+frttype1+") and locationFrom in ("+startplace1+") and locationTo in ("+endplace1+")   and  Status='Yes' order by entrydatetime desc  ";
	}
		
 System.out.println("Sql->"+sql);
 ResultSet rs = st1.executeQuery(sql);
 String name="",color="";
 int j=0;
 int i=0;
 while(rs.next())
 {  
	
	j++; 
	 if (rs.getString("Status").equalsIgnoreCase("Yes")) 
	{
		 color = "#FF8080";

		} else 
		{

			color = "#CCFF99";
		}
	 System.out.println("colorrrrrrr"+color);
	 
 %>
 <tr>
 
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= ++i%></td>	
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("customer")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("markRep")%></td>				
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("branchName")%></td>	
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("billBranch")%></td>	
 <td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("consigner")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("consignee")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("locationFrom")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("locationTo")%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("frttype")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("loadType")%></td>		
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("monthVal")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("product")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("loadRef")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("existTrans")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("riskInvolved")%>	</td>					
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("validFrom"))) %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=  new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("validTo"))) %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("commission")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("remark")%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("EntryBy")%></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=  new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rs.getString("entrydatetime"))) %></td>
																			
 <% }%>
 

 </tr>

</table></div></form>
</body> --%>
</html>
</jsp:useBean>
 <%@include file="footer_new.jsp"%> 