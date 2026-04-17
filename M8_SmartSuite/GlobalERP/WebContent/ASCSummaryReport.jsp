<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>ASC Summary Report</title>
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
		
		
		document.getElementById("myIframe").src="http://"+host1+":8080/birt/frameset?__report=Opportunity_Report.rptdesign&Customer="+Customer+"&Load="+Load+"&Freight="+Freight+"&Origin="+Origin+"&Destination="+Destination+"&all="+al+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&Status="+status+"&__showtitle=false";
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
		
		
		document.getElementById("myIframe").src="http://"+host1+":8080/birt/frameset?__report=Opportunity_Report.rptdesign&Customer="+Customer+"&Load="+Load+"&Freight="+Freight+"&Origin="+Origin+"&Destination="+Destination+"&all=no&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&Status="+status+"&__showtitle=false";
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
	String fromDate = "", toDate = "",fromDate1="", toDate1 = "";
	String data2="",data1="";
	String CustomerCode="";
	String tablenamenew="";
	String owner12="";
	String owner23="";
	//String cmp=request.getParameter("companyname");
	
	
	
	
	

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
		toDate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

	} else {
		
		System.out.println("In else ------>");
		
		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		
		fromDate1 =request.getParameter("data");
		
		System.out.println("fromDate1 1-->"+fromDate1);
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		
		toDate1=request.getParameter("data1");
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
		
		System.out.println("toDate1 1-->"+toDate1);

	} //end of else
%>
<%Date d=new Date();
	
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	
	String owner1=request.getParameter("customer");
	String owner=request.getParameter("customer");

	System.out.println("Selected Owner -------------->"+owner);

	 if(owner != null)
	{
		
	} 
	 else
	 {
		 owner="All";
		 
	 }
	
	%>
	 




<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->
<form name="" action="" method="" onsubmit="return chk();">
<table  align="center"  style="width: 100%;">
<tr>
<tr align="center">
<td align="center" colspan="13">
<font size="3"><b>ASC Summary Report</b></font></td></tr>

<tr>
	
	<td>
         <font size="2">Customer:</font>
           <select name="customer" id="customer" style="width: 280px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <!--    <option value='All' selected="selected" >All</option> -->
         
         <option value="<%=owner%>"><%=owner%></option>  
            <%
            String load="";
            
            String load1="";
       	String sql2 = "select distinct ownername from db_gps.t_vehicledetails order by ownername";
		System.out.println("*******"+sql2);
        ResultSet rs1 = st1.executeQuery(sql2);
		while(rs1.next())
		{
			 
			 load=rs1.getString("ownername");
			// load="'"+load+"'";
			// load1=load1+","+load;
			// System.out.println("Load Type-->"+load);
			// System.out.println("Load 1-->"+load1);
			%>
			<option value="<%=load%>"><%=load%> </option>
	         <%
	        // System.out.println("Load 0000--------------->"+load);
      }
		System.out.println("Load 1--------------->"+load);
		%>
           </select>
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
			value="<%=toDate1 %>" size="8" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td align="left"><input type="submit" name="submit" id="submit" value="Submit"></td>
		
		
	</tr>



</table>
</form>
</div>


				
		</tr></table>
</div>
<div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
<% 
String tablename="";
/* String dateselect=request.getParameter("data1");
if(dateselect==null || dateselect.equals(null))
{
	dateselect="01-Jan-2012";
}
System.out.println("Selected Date is before ------------->"+dateselect);

toDate = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(dateselect));
	String fromDateTime = toDate ; */
	
	//System.out.println("Selected Daye is------------->"+fromDateTime);
	//String toDateTime = toDate + " " + "23:59:59";
	
	

String queryString="";
/* if(null!=request.getParameter("sorting") ||""!=request.getParameter("sorting") )
{
Sort=request.getParameter("sorting");
}else
{
	Sort="srno"	;
} */
 owner12=request.getParameter("customer");
 owner23=request.getParameter("customer");

System.out.println("Selected Owner -------------->"+owner23);

 if(owner23 != null)
{
	
} 
 else
 {
	 owner23="All";
	 
 }
 System.out.println("Selected Owner after-------------->"+owner23);
 //owner=owner.split(" ").toString();
 
 String head="ASC Summary Report For "+owner+" From "+data1+" To "+data2;
queryString="&fromDateTime="+fromDate+"&CompId="+session.getAttribute("CompanyMasterID").toString()+"&Head="+head+" &dt="+owner+"";	

System.out.println("QueryString is========"+queryString);

String Bt=request.getParameter("submit");

System.out.println("Submit Value --------------->"+Bt);
Bt="Submit";

if(Bt.equals("Submit"))
{
	
	
	String SessionId=session.getId();
	System.out.println("Session ID ------------->"+SessionId);
	tablename="db_GlobalERP.t_temp"+SessionId+"_"+owner;
	toDate1=new SimpleDateFormat("ddMMyyyyHHmmss").format(new java.util.Date());
	tablename=tablename.replaceAll(" ", "");
	
	 tablenamenew="db_GlobalERP.t_temp"+SessionId+"_"+toDate1;

	System.out.println("Table Name--------------->"+tablename);
	
	tablenamenew=tablenamenew.replaceAll(" ", "");
	
	System.out.println("-----------------New Table Name--------------->"+tablenamenew);
	
	String createbillingdetails = "CREATE TABLE IF NOT EXISTS "+tablenamenew+" like db_GlobalERP.t_temp123";
	System.out.println("before executing createbillingdetails "+createbillingdetails);
	  st1.executeUpdate(createbillingdetails);
	  System.out.println("After executing createbillingdetails "+createbillingdetails);
	  
	 String insertdata="select * from "+tablenamenew+"";
	 ResultSet rs123=st.executeQuery(insertdata);
	 System.out.println("Select Query Inside Submit -------------->"+insertdata);
	 
	 if(rs123.next())
	 {
		 String deletedata="delete from "+tablenamenew+"";
		  st1.executeUpdate(deletedata);
		 System.out.println("Delete Query Inside Submit If Data Available For Same Session Table-------------->"+deletedata);
	 }
	 
	 
	 
	 //Query Passing Date is fromDate and toDate
	  
	 // String insertbillingdetails="insert into "+tablename+" (select vehiclecode,substr((replace(a.vehicleregnumber,'del','               ')),1,15) as vehicleNumber,substr((replace(a.ownername,'del','               ')),1,50) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,@todaysdate:='"+fromDate+"' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select x.todate from db_gps.t_amccovered x where substr((replace(a.ownername,'del','               ')),1,15)=x.customername)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:=DATE_ADD(@billfrom, INTERVAL 365 DAY) as billto,@days:=IF(@billable='Yes',(datediff(@billto,@billfrom)),0)as days,@age:=IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0)as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,((@rate/365)*@days) as amount,case when(@age>5) then 2645 when(@age>2 and @age<=5) then 2644 when (@age>0 and @age<=2)then 2643 end as itemcode,(@rate/365) as sellingprice,@itemdescription:=case when(@age>5) then 'ASC-Days - AVL Installation Age 5-7 Years' when(@age>2 and @age<=5) then 'ASC-Days - AVL Installation Age 2-5 Years' when (@age>0 and @age<=2)then 'ASC-Days - AVL Installation Age 0-2 Years' end as  ItemDescription from db_gps.t_vehicledetails a where a.ownername like '"+owner1+"%')";
	 
	//Query Given By Prashant Sir 
	 // String insertbillingdetails="insert into "+tablenamenew+" (select vehiclecode,substr((replace(a.vehicleregnumber,'del',' ')),1,15) as vehicleNumber,substr((replace(a.ownername,'del',' ')),1,50) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,@todaysdate:='"+fromDate+"' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select max(warrantytill) from db_gps.t_amchistory x where a.vehiclecode=x.vehcode)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:='"+toDate+"' as billto,@days:=IF(@newwarranty>@billto,0,IF(@billable='Yes',(datediff(@billto,@billfrom)),0))as days,@age:=IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0)as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,((@rate/365)*@days) as amount,(select itemcode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where @age>k.ascagefrom and @age<=k.ascageto) as itemcode,(@rate/365) as sellingprice,(select itemdescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where @age>= k.ascagefrom and @age<=k.ascageto) as ItemDescription, '"+fromDate+"' as Amcfromdate,'"+toDate+"' as Amctodate from db_gps.t_vehicledetails a where a.ownername='"+owner1+"' )";
	  String insertbillingdetails="insert into "+tablenamenew+" (select vehiclecode,(select vehregno from db_gps.t_unitreplacement m where a.vehiclecode=m.vehcode order by insertedDateTime desc limit 1) as vehicleNumber,substr((replace(a.ownername,'del',' ')),1,50) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,@todaysdate:='"+fromDate+"' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select max(warrantytill) from db_gps.t_amchistory x where a.vehiclecode=x.vehcode)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:='"+toDate+"' as billto,@days:=IF(@newwarranty>@billto,0,IF(@billable='Yes',(datediff(@billto,@billfrom)),0))as days,@age:=cast(IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0) as decimal(11,2)) as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,cast((cast((@rate/365) as decimal (11,2))*@days) as decimal(11,2)) as amount,(select itemcode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where IF(@billable='Yes',(datediff(@todaysdate,a.installeddate)/365),0)>k.ascagefrom and IF(@billable='Yes',(datediff(@todaysdate,a.installeddate)/365),0)<=k.ascageto) as itemcode,cast((@rate/365) as Decimal(11,2)) as sellingprice,(select itemdescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where IF(@billable='Yes',(datediff(@todaysdate,a.installeddate)/365),0)> k.ascagefrom and IF(@billable='Yes',(datediff(@todaysdate,a.installeddate)/365),0)<=k.ascageto) as ItemDescription, '"+fromDate+"' as Amcfromdate,'"+toDate+"' as Amctodate ,'-' as InvoiceStatus ,'-' as InvoiceRefNo from db_gps.t_vehicledetails a where a.ownername='"+owner1+"')";
	  // Query Given By Prashant Sir 
	 //String insertbillingdetails="insert into "+tablename+" (select vehiclecode,substr((replace(a.vehicleregnumber,'del','               ')),1,15) as vehicleNumber,substr((replace(a.ownername,'del','               ')),1,50) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,,@todaysdate:='"+fromDate+"' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select x.todate from db_gps.t_amccovered x where substr((replace(a.ownername,'del','               ')),1,15)=x.customername)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:=DATE_ADD(@billfrom, INTERVAL 365 DAY) as billto,@days:=IF(@billable='Yes',(datediff(@billto,@billfrom)),0)as days,@age:=IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0)as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,((@rate/365)*@days) as amount,case when(@age>5) then 2645 when(@age>2 and @age<=5) then 2644 when (@age>0 and @age<=2)then 2643 end as itemcode,(@rate/365) as sellingprice,@itemdescription:=case when(@age>5) then 'ASC-Days - AVL Installation Age 5-7 Years' when(@age>2 and @age<=5) then 'ASC-Days - AVL Installation Age 2-5 Years' when (@age>0 and @age<=2)then 'ASC-Days - AVL Installation Age 0-2 Years' end as  ItemDescription from db_gps.t_vehicledetails a where a.ownername like '"+owner1+"%',@Amcfromdate:='"+fromDate+"' as Amcfromdate,@Amctodate:='"+toDate+"' as Amctodate )";
	 
	  //String insertbillingdetails="insert into db_GlobalERP.t_temp123 values (select vehiclecode,substr((replace(a.vehicleregnumber,'del','               ')),1,15) as vehicleNumber,substr((replace(a.ownername,'del','               ')),1,15) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,@todaysdate:='2016-04-01' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select x.todate from db_gps.t_amccovered x where substr((replace(a.ownername,'del','               ')),1,15)=x.customername)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:=DATE_ADD(@todaysdate, INTERVAL 365 DAY) as billto,@days:=IF(@billable='Yes',(datediff(@billto,@billfrom)),0)as days,@age:=IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0)as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,((@rate/365)*@days) as amount,case when(@age>5) then 2945 when(@age>2 and @age<=5) then 2944 when (@age>0 and @age<=2)then 2943 end as itemcode,(@rate/@days)as sellingprice,@itemdescription:=case when(@age>5) then 'ASC-Days - AVL Installation Age 5-7 Years' when(@age>2 and @age<=5) then 'ASC-Days - AVL Installation Age 2-5 Years' when (@age>0 and @age<=2)then 'ASC-Days - AVL Installation Age 0-2 Years' end as  ItemDescription from db_gps.t_vehicledetails a where a.ownername='adarsh')";
	  System.out.println("Insert Query Before ---------> "+insertbillingdetails);
	  st.executeUpdate(insertbillingdetails);
	  System.out.println("Insert Query After Execution ---------> "+insertbillingdetails);
	  
	  String NewQuery="select vehiclecode,substr((replace(a.vehicleregnumber,'del',' ')),1,15) as vehicleNumber,substr((replace(a.ownername,'del',' ')),1,50) as Ownername,installeddate,@remove:=(select max(b.entdate) from db_gps.t_unitreplacement b where a.vehiclecode=b.vehcode and a.status<>'-') as removeddate,@remove1:=IF(status<>'-' and @remove is NULL ,a.installeddate,@remove)asnewremove,status,@todaysdate:='"+fromDate+"' as todaysdate,@active:=IF(installeddate<=@todaysdate,'Yes','No')as active,@Exclude:=IF(@remove1<=@todaysdate,'Yes','No')as exclude,@billable:=IF(@active='Yes' and @exclude='No','Yes','No')as billable,@warranty:=DATE_ADD(installeddate, INTERVAL 365 DAY) as warrenty,@amccovered:=(select max(warrantytill) from db_gps.t_amchistory x where a.vehiclecode=x.vehcode)as amccovered,@newwarranty:=IF(@amccovered>=@warranty,@amccovered,@warranty)as newwarranty1, @billfrom:= if(@newwarranty>@todaysdate,@newwarranty,@todaysdate)as billfrom,@billto:='"+toDate+"' as billto,@days:=IF(@newwarranty>@billto,0,IF(@billable='Yes',(datediff(@billto,@billfrom)),0))as days,@age:=IF(@billable='Yes',(datediff(@todaysdate,installeddate)/365),0)as age,@rate:=IF(@age=0,0,IF(@age>5,4000,IF(@age>=2,3000,2000))) as rate,((@rate/365)*@days) as amount,(select itemcode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where @age>k.ascagefrom and @age<=k.ascageto) as itemcode,(@rate/365) as sellingprice,(select itemdescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCItemMaster k where @age>=k.ascagefrom and @age<=k.ascageto) as ItemDescription, '"+fromDate+"' as Amcfromdate,'"+toDate+"' as Amctodate from db_gps.t_vehicledetails a where a.ownername='"+owner1+"'";
	  System.out.println("New Query---------> "+NewQuery);
	  
	  
	if(owner.equals("All"))
	{
		
		System.out.println("--------------Owner All---------------");
	  String deletedata="delete from "+tablenamenew+"";
	  st1.executeUpdate(deletedata);
	 System.out.println("Delete Query Inside Submit -------------->"+deletedata);
	}
	
}
else
{
	
	System.out.println("Inside Button else Value  --------------->"+Bt);
	System.out.println("Inside Button Value  --------------->"+Bt);
	String SessionId=session.getId();
	System.out.println("Session ID ------------->"+SessionId);
	tablename="db_GlobalERP.t_temp"+SessionId+"_All";
	System.out.println("Inside tablename Value  --------------->"+tablename);
	
}
%>

 <iframe id="myframe" style="width: 99.5%; height: 500px;" src="http://twtech.in:8080/ERPTestBirt/frameset?__report=AMC_Report.rptdesign&__showtitle=false&__pageFooterFloatFlag=False&<%=queryString%>&tablename=<%=tablenamenew%>&dt=<%=data1%>&dt1=<%=data2%>"></iframe> 
</body>
</html>
</jsp:useBean>