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
    <link rel="stylesheet" href="cssnew/newentryform.css" />
</head>
 <body style="background-color:azure;">
 <% 
 
	Statement stmt=null,st=null,st1=null;
	Statement stmt1=null;
	Statement stftp=null;
	
	String sql=null;
	
	String chbx=request.getParameter("chbx");
	System.out.println("checked box      "+chbx);

	String emailid="";	
String fileIwrd="",srNoStr="";
String serverid="",usernm="",passwd="";	

String category="",customer="";
try {
	Connection conn = null;
		conn = connection.getConnect("db_leaveapplication");    
		st=conn.createStatement();
		st1=conn.createStatement();
		stmt=conn.createStatement();
		stmt1=conn.createStatement();
		stftp=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

String sqlftp="select * from t_ftpconnection";
ResultSet rsftp=stftp.executeQuery(sqlftp);
rsftp.next();
serverid=rsftp.getString("ServerID");
usernm=rsftp.getString("Username");
passwd=rsftp.getString("Password");
%>
<%
//Variable Declaration
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String datex1 = "",datex2="";
 datex1=request.getParameter("data");
 datex2=request.getParameter("data");
 
System.out.println("DATE NEW  datex1  "+datex1  +"datex2-------- "+datex2);
if(null==datex1)
{
	datex1=todaysDate;
	datex2=todaysDate;
	
	System.out.println("DATE NEW  datex1  "+datex1  +"datex2-------- "+datex2);
}
%>
<%System.out.println(request.getParameter("chbx")+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+request.getParameter("finalidlist")); 
String finalListStr="";
System.out.println("finalidlistAjx........... "+request.getParameter("finalidlistAjx"));
if(null==request.getParameter("finalidlistAjx"))
{
	finalListStr=request.getParameter("serialSelected");
	System.out.println("1111111111   1111111111 iffff condition "+finalListStr);
}
else
{
	finalListStr=request.getParameter("finalidlistAjx");
	System.out.println("else condition finalListStr "+finalListStr);
}
%>
<input type="hidden" name="srNoStr" id="srNoStr" value="<%=finalListStr%>"></input>
<%
//======Get new iwno and iwrefno============================================================================
			
//			String sqlUpload="  select * from t_uploadedFiles where SrNo in("+finalListStr+") ORDER BY FIELD(SrNo,"+finalListStr+")";

			String sqlUpload = "SELECT * FROM t_uploadedFiles WHERE SrNo IN (" + finalListStr + ") ORDER BY FIELD(SrNo," + finalListStr + ")";

			System.out.println(sqlUpload);	
			ResultSet rs1=st1.executeQuery(sqlUpload);
			while(rs1.next())
			{
				if(fileIwrd==null || fileIwrd=="")
				{
					fileIwrd=rs1.getString("FileName");
					//srNoStr=srNo;
				}
				else
				{
					fileIwrd=fileIwrd+","+rs1.getString("FileName");
					//srNoStr=srNoStr+","+srNo;
				}
				category=rs1.getString("Category");
				customer=rs1.getString("CustomerName");
				System.out.println(fileIwrd+" -----   "+category+"    -----------   "+customer);
				
			}
	srNoStr=finalListStr;
System.out.println(fileIwrd+"}}}}}}}}>>"+srNoStr);
String date=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
java.text.DecimalFormat df = new java.text.DecimalFormat("00");
%>
 <div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
   <!--  <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-start mb-0" style="color: #060637">Inward Uploaded Document</h5>
    </div> -->
</div>
<div class="container-fluid mt-2">
  <div class="row">
				<div class="col-md-4" id="leftDiv">
					<form action="testNew.jsp" method="get" name="form1" id="form1">
						<input type="hidden" name="finalidlistAjx" id="finalidlistAjx">
						<input type="hidden" name="chbx" id="chbx" value="<%=chbx%>">
						<input type="hidden" name="serverid" id="serverid" value="<%=serverid %>" /> 
						<input type="hidden" name="username" id="username" value="<%=usernm %>" /> 
						<input type="hidden" name="password" id="password" value="<%=passwd%>" /> 
						<input type="hidden" name="chbx" id="chbx" value="<%=request.getParameter("chbx")%>">
							
						<h5 class="content-header-title text-center mb-3"
							style="color: #060637">Inward Uploaded Document</h5>
						<div class="card shadow-lg mb-4 rounded-3">
							<div class="card-body " >
							 <div class="mx-auto" style="max-width: 600px;">
								<div class="row">
									
										<div class="col-6">
											<div class="input-container">
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" value="Inward"
														name="searchBy" checked> <label
														class="form-check-label">Inward</label>
												</div>

												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio"
														name="searchBy" value="Outward"> <label
														class="form-check-label">Outward</label>
												</div>
											</div>
										</div>
									
								</div>

								<div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="manualref" id="manualref" placeholder=""> <label
												for="manualref" class="floating-label">Ref. No</label>
										</div>
									</div>

								</div>


								<div class="row">
									<div class="col-5 mt-4">
										<label class="tcolor">Category</label> <select
											class="form-select" name="cat" id="cat"
											onchange="getCategory(this.value);">
											<%
        String sqlCat="select distinct(InwrdCategory) from t_InwardCategory";
        ResultSet rsCat=stmt1.executeQuery(sqlCat);
        while(rsCat.next()) {
      %>
											<option value="<%=rsCat.getString("InwrdCategory") %>">
												<%=rsCat.getString("InwrdCategory") %>
											</option>
											<% } %>
										</select>
									</div>
								</div>
								<div id="custLink" style="display: none;"></div>
								<!-- <div id="agrParty" style="display: none;"></div>
								<div id="agrFrom" style="display: none;"></div>
								<div id="agrFrmDt" style="display: none;"></div>
								<div id="agrToDt" style="display: none;"></div> -->
								<!-- FROM (EMPLOYEE) -->
								<div class="row" id="frmParty">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input type="hidden" name="SelectedEmpMail"
												id="SelectedEmpMail"  placeholder=""/> <input
												class="form-control floating-input" type="text" name="from1"
												id="from1" autocomplete="off"  placeholder=""
												onkeyup="if (event.keyCode == 27 || event.keyCode == 13){
               document.getElementById('EmpList').style.display='none';
             } else { getEmp123(); }" />
											<label for="from1" class="floating-label">From</label>
										</div>
										<div style="position: absolute;">
											<div id="EmpList"></div>
										</div>
									</div>
								</div>

								<!-- FROM (MANUAL) -->
								<div class="row" id="frmParty1" style="display: none;">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="from" id="from" />
										</div>
									</div>
								</div>

								<!-- BILL NO -->
								<div class="row" id="billno" style="display: none;">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="blno" id="blno" /> <label for="blno"
												class="floating-label">Bill No</label>
										</div>
									</div>
								</div>

								<!-- BILL AMOUNT -->
								<div class="row" id="billamt" style="display: none;">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="blamt" id="blamt" /> <label for="blamt"
												class="floating-label">Bill Amount</label>
										</div>
									</div>
								</div>

								<!-- BILL DATE -->
								<div class="row" id="billdate" style="display: none;">
									<div class="col-5 mt-4">
										<div class="input-container">
														<label for="bldate"><b>Bill Date</b></label>
										<div class="input-group input-group-merge" >
					<input type="text"name="data" id="data"  class="form-control" value="<%=datex2%>" readonly> 
				</div>
										</div>
									</div>
								</div>

								<!-- BILL DUE DATE -->
							<div class="row" id="billduedate" style="display: none;">
		<div class="col-5 mt-4">
			<div class="input-container">				
				<label for="blduedate"><b> Bill Due Date</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>" readonly> 
				</div>
			
			</div>
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
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>		
<div id="agrParty" style="display:none;">
  <div class="row">
    <div class="col-5 mt-4">
      <div class="input-container">
        <input class="form-control floating-input"
               type="text" name="agrparty" id="agrparty" placeholder="">
        <label for="agrparty" class="floating-label">Agreement Party</label>
      </div>
    </div>
  </div>
</div>

<div id="agrFrom" style="display:none;">
  <div class="row">
    <div class="col-5 mt-4">
      <div class="input-container">
        <input class="form-control floating-input"
               type="text" name="agrfrom" id="agrfrom" placeholder="">
        <label for="agrfrom" class="floating-label">Agreement From</label>
      </div>
    </div>
  </div>
</div>

<div id="agrFrmDt" style="display:none;">
  <div class="row">
    <div class="col-5 mt-4">
      <div class="input-container">
        <label><b>Agreement From Date</b></label>
        <div class="input-group input-group-merge">
          <input type="text"
                 id="agrfrmdate"
                 name="agrfrmdate"
                 class="form-control"
                 value="<%=datex2%>" readonly>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="agrToDt" style="display:none;">
  <div class="row">
    <div class="col-5 mt-4">
      <div class="input-container">
        <label><b>Agreement To Date</b></label>
        <div class="input-group input-group-merge">
          <input type="text"
                 id="agrtodate"
                 name="agrtodate"
                 class="form-control"
                 value="<%=datex2%>" readonly>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
Calendar.setup({
  inputField : "agrfrmdate",
  ifFormat   : "%d-%b-%Y"
});

Calendar.setup({
  inputField : "agrtodate",
  ifFormat   : "%d-%b-%Y"
});
</script>	

	
								<div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="prno" id="prno" placeholder="" required> <label
												for="prno" class="floating-label">Party Ref. No</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<textarea class="form-control floating-input" name="address"
												id="address" rows="1" placeholder=""
												onblur="return reason5();" required></textarea>
											<label for="address" class="floating-label">Address</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="input-container">
										<div class="col-5 mt-4">
											<label class="tcolor" id="custype">Department</label> <select
												name="dept" id="dept" class="form-select"
												onchange="getEmp(this.value);">
												<%
												sql="select distinct(TypeValue) as Dept from t_leaveadmin order by Dept asc" ;
												   ResultSet rst3=stmt.executeQuery(sql);
												    while(rst3.next()) {
												%>
												<option value="<%=rst3.getString("Dept") %>">
													<%=rst3.getString("Dept") %>
												</option>
												<%  } %>
											</select>
										</div>
									</div>
								</div>
								<div class="row">	
										<div class="col-5 mt-4">
										<div class="input-container">
											<label class="tcolor">To</label> <select name="to" id="to"
												class="form-select" 
												onchange="selectoption();">
											</select>
										</div>
									</div>
								</div>
                            <div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												 name="sub" id="sub" placeholder="" required> 
												<label for="sub" class="floating-label">Subject</label>
										</div>
									</div>
								</div>
<div class="row">
		<div class="col-5 mt-4">
			<div class="input-container">				
				<label for="data1"><b> Action Date</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" id="actiondate" name="actiondate"  class="form-control" value="<%=datex2%>" required > 
				</div>
			
			</div>
			</div>
		</div>
<script type="text/javascript">    
        Calendar.setup(
     	       {
     	    	   inputField  : "actiondate",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>


								<div class="row"> 
									<div class="col-5 mt-4">
										<div class="input-container">
											<label class="tcolor">Priority</label> <select
												name="priority" id="priority" class="form-select">
												<option value="Low">Low</option>
												<option value="Medium">Medium</option>
												<option value="High">High</option>
											</select>
										</div>
									</div>
								</div>
                 			<div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<input class="form-control floating-input" type="text"
												name="keywords" id="keywords" placeholder="" required> <label
												for="keywords" class="floating-label">Keywords</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-5 mt-4">
										<div class="input-container">
											<textarea class="form-control floating-input" name="remark"  id="remark" rows="1" placeholder=""></textarea>
											<label for="remark" class="floating-label">Remarks</label>
										</div>
									</div>
								</div>

			 <div class="d-flex gap-2 col-3 mx-auto mt-3">
		<button  name="submit" class="btn" type="submit" value="Submit" onclick="this.form.reset()" >Reset</button>
        <button  name="submit" class="btn" type="submit" value="Send" onclick="abc();" >Send</button>    
              </div> 
							</div>
						</div>
						</div>
					</form>
				</div>
							<input type="hidden" name="flag" id="flag" value="false"></input>			
				<div class="col-md-6" id="rightDiv">
				
				<div id="showcontent" style="margin-left:55%; margin-top:4%; height:90%;width:40%; overflow: auto; position:absolute;  border-radius: 12px 12px 12px 12px;" >

<table>
<%
int rwCnt=0,k=0;
String srCnt="";
String sql1="select * from t_uploadedFiles where SrNo in ("+srNoStr+") ORDER BY FIELD(SrNo,"+srNoStr+")";
System.out.println("))))))))))))))"+sql1);
ResultSet rsShow=stmt1.executeQuery(sql1);
while(rsShow.next())
	{
		rwCnt++;
		k++;
		System.out.println(rsShow.getString("FileName"));
   		String w=rsShow.getString("FileName").replace(" ","%");
   		srCnt=rsShow.getString("SrNo");
   		%>
   		
   		<tr>
   			<td>
   			<a href='#' onclick="javascript: try{moveup('up','<%=srNoStr.trim()%>','<%=srCnt.trim()%>');}catch(e){alert(e);}"><img src="images/up.png" height='10' width='10'></img></a>
			<a href='#' onclick="javascript: try{moveup('down','<%=srNoStr.trim()%>','<%=srCnt.trim()%>');}catch(e){alert(e);}"><img src="images/down.png" height='10' width='10'></img></a>
   				<!-- 
   			</td>
    		</tr>
   		
   		
   		
   		<tr>
   		   			
   			<td><div align="left"  >

 -->
<font ><img  name="myimage<%=k%>" id="myimage<%=k%>" src="ftp://<%=usernm %>:<%=passwd %>@<%=serverid %>/test/<%=rsShow.getString("FileName")%>" height='150' width='250' ></img><a href="javascript:toggleDetails(<%=k%>,true);" title="Click To See the Details"><%=rsShow.getString("FileName")%></a> </font><br />
<div class="popup" id="popup<%=k%>" style="visibility: hidden;">
<table border="1" bgcolor="white" cellpadding="0" cellspacing="0">

<tr>
<td>	<a href='#' onclick="getFTPImage('<%=w%>');"><br>Open in Pop up Window</a></td>
      
</tr>
<tr>
<td><a href='#' onclick="getzoomimage('<%=w%>','<%=rsShow.getString("FileName")%>','true','<%=k%>');"><br>Zoom In</a></td>
</tr>
<tr>
<td><a href='#' onclick="getzoomimage('<%=w%>','<%=rsShow.getString("FileName")%>','false','<%=k%>');"><br>Zoom Out</a></td>
</tr>

<tr><td><a href="javascript:toggleDetails(<%=k%>,false);">Close</a></td></tr>
</table>
</div> 
</div></td>
   			
   			
   			
   			
   			
    		</tr>
    	<%
	} //end of while   
%>
</table>
</div>
 </div>
</div>
</div>

</div>

<script >
var detailsWindowTimer;
var detailsWindow;
var crg=null;
 function abc()
 {
	 return validate();
	 
	document.formForAjx.action="http://www.myfleetview.com/FleetView-spring/tripstart1.jsp";	
	document.formForAjx.submit();
	 
 }
    

function toggleDetails(id,show)
{
//	alert("in togel");
    // alert(show);
var popup = document.getElementById("popup"+id);
if (show) {
//alert("in if  "+popup.value);
popup.style.visibility = "visible";

popup.setfocus();

} else {
popup.style.visibility = "hidden";

 }
}

var zoom1 = 0;

function getzoomimage(image,filename,show,id)
{
	//alert(show);
	var serverid=document.getElementById("serverid").value;
	var username=document.getElementById("username").value;
	var password=document.getElementById("password").value;
   if(show=="true")
   {
	// alert("zoom..... in ");
	 //  var i=filename+" "+filename;
	 //  alert(filename);
							
	document.getElementById("myimage"+id).src="ftp://"+username+":"+password+"@"+serverid+"/test/"+filename+"";
    //alert("serverid="+serverid+" password="+password+" username="+username);
    document.getElementById("myimage"+id).width="700";
    document.getElementById("myimage"+id).height="700";
    //  document.myimage1.width = "450";
    //  document.myimage1.height = "350";
   }
   else
   {
//	 alert("zoom..... out ");
     
	  document.getElementById("myimage"+id).src="ftp://"+username+":"+password+"@"+serverid+"/test/"+filename+"";
      //alert(document.myimage.src);
      document.getElementById("myimage"+id).width="250";
      document.getElementById("myimage"+id).height="150";
    }
}

function selectoption()
{
	document.form1.to.focus();
}

function getAddContact()
{
	try
	{
		window.open('contactdetails.jsp','mywindow1','width=1200, height=550, location=0, status=0, menubar=0, resizable=0, scrollbars=yes');
		
	}
	catch(e)
	{
		alert(e);
	}
	//return false;
}
function showVisitingCardDetails(eName,empMail)
{
	document.getElementById("from1").value=eName;
	document.getElementById("SelectedEmpMail").value=empMail;
	document.getElementById("EmpList").style.display='none';
}
function getEmp123()
{
	//alert("============================>>"+crg);
	document.getElementById("EmpList").style.display='block';
	var emp=document.getElementById("from1").value;
	var ajaxRequest;  // The variable that makes Ajax possible!

	try{
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

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("EmpList").innerHTML=reslt;
		} 
	}
	var queryString = "?emp=" +emp+"&crg="+crg;
	ajaxRequest.open("GET", "SearchBoxForFromCategory.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var dm1,dd1,dy1;//,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dm1=date1.substring(5,7);
	dd1=date1.substring(8,10);
    var d1date=date1.substring(0,2);
    var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	return true;
}

function getEmp(deptName)
{	
	deptName=escape(deptName);
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
		  //alert(xmlhttp.responseText);
		  document.getElementById("to").innerHTML=xmlhttp.responseText;
		  }
		}
		xmlhttp.open("GET","getEmployee.jsp?deptName="+deptName,true);
		xmlhttp.send(null);
		
}
function isDecimal(str){
	if(isNaN(str) || str.indexOf(".")<0){
	alert("Enter Decimal Number");
	}
	else{
	str=parseFloat(str);
	alert ("Entered number is decimal");
	}
	}
function validate()
{
	
	var val1 = document.getElementById("inno").value;
	var val2 = document.getElementById("inrefno").value;
	var val3 = document.getElementById("from").value;
	var frm = document.getElementById("from1").value;
	var val4 = document.getElementById("prno").value;
	var val8 = document.getElementById("dept").value;
	var val5 = document.getElementById("to").value;//document.to.value;
	var val7 = document.getElementById("sub").value;
	var val9 = document.getElementById("cat").value;
	var actDate= document.getElementById("data").value;
	var priority=document.getElementById("priority").value;
	//var val10 = document.getElementById("fileName").value.replace(/\s+/g,'');

	var bn= document.getElementById("blno").value;
	var bmt= document.getElementById("blamt").value;

	var billdate=document.getElementById("data").value;
	var billduedate=document.getElementById("data").value;
	if(val9=="" || val9=="Select"){
		alert("Please Select Category");
		return false;
	}

	if(val9=="Bills")
	{
		if(bn=="")
		{
			alert("Please Enter Bill No.");
			return false;
		}
		if(bmt=="")
		{
			alert("Please Enter Bill Amt");
			return false;
		}
		else if(isNaN(bmt))
      	{
      		alert("Please Enter Numeric Value For Bill Amount");
      		return false;
      	}
	}
	
	if(val3=="" && frm==""){
		alert("Please Enter Inward From Party Name");
		return false;
	}
	if(val4==""){
		alert("Please Enter Party Ref. No");
		return false;
	}
	if(val8==""){
		alert("Please Enter Department");
		return false;
	}
	if(val5==""){
		alert("Please Select Employee Name");
		return false;
	}
	if(val7==""){
		alert("Please Enter Subject");
		return false;
	}
	
	if(priority=="" || priority=="Select"){
		alert("Please Select Priority");
		return false;
	}
	return true;
}
function getCategory(catgry)
{
	var ct=catgry;
	crg=ct;

	if(crg=="Bills")
	{
		alert("in bills");
		document.getElementById("frmParty1").style.display='none';
		document.getElementById("frmParty").style.display="";
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display="";
		document.getElementById("billamt").style.display="";
		document.getElementById("billdate").style.display="";
		document.getElementById("billduedate").style.display="";
		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agrFrmDt").style.display='none';
		document.getElementById("agrToDt").style.display='none';
	}
	else if(crg=="customer")
	{
		document.getElementById("frmParty1").style.display='none';
		document.getElementById("frmParty").style.display="";
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agrFrmDt").style.display='none';
		document.getElementById("agrToDt").style.display='none';
	}
	else if(crg=="Visiting Card")
	{
		document.getElementById("frmParty1").style.display="";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display="";
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agrFrmDt").style.display='none';
		document.getElementById("agrToDt").style.display='none';
	}
	else if(crg=="Agreement")
	{
		document.getElementById("frmParty1").style.display="";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		document.getElementById("agrParty").style.display="";
		document.getElementById("agrFrom").style.display="";
		document.getElementById("agrFrmDt").style.display="";
		document.getElementById("agrToDt").style.display="";
	}
	else
	{
		document.getElementById("frmParty1").style.display="";
		document.getElementById("frmParty").style.display='none';
		document.getElementById("custLink").style.display='none';
		document.getElementById("billno").style.display='none';
		document.getElementById("billamt").style.display='none';
		document.getElementById("billdate").style.display='none';
		document.getElementById("billduedate").style.display='none';
		document.getElementById("agrParty").style.display='none';
		document.getElementById("agrFrom").style.display='none';
		document.getElementById("agrFrmDt").style.display='none';
		document.getElementById("agrToDt").style.display='none';
	}
}

function getFTPImage(ftpFile)
{

	
	try
	{
		var serid=document.getElementById("serverid").value;
		var usrnm=document.getElementById("username").value;
		var paswd=document.getElementById("password").value;
		
	//	alert(escape(ftpFile));
	//	alert(ftpFile);
	//	window.open('showFTP.jsp?ftpFile='+escape(ftpFile)+'','mywindow','width=700, height=700, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
		//window.open('ftp://sumedh:789&*(medh@202.38.172.58/test/'+ftpFile+'','','location=0,menubar=1,resizable=1,width=650,height=750');
		window.open('ftp://'+usrnm+':'+paswd+'@'+serid+'/test/'+ftpFile+'','','location=0,menubar=1,resizable=1,width=650,height=750');

	}
	catch(e)
	{
		alert(e);
	}
} 

function arrangeFiles(name,id,chbx)
{
	try
	{
		detailsWindow = window.open('rearrangeLogic.jsp?id='+id+'&name='+name+'&chbx='+chbx,'mywindow2','width=400, height=400, location=0, status=0, menubar=0, resizable=0, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
}
function moveup(movement, SerialList, srNo)
{
	//alert(movement+"^^^^^"+SerialList+"^^^^^"+srNo);
	
//	var chbx=document.getElementById("chbx12").value;
	var ajaxRequest;  // The variable that makes Ajax possible!

	try{
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

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
		//	alert(reslt);
		//	var mySplitResult = reslt.split("#");
		//	var chk=mySplitResult[0];
		//	var chbxAjx=mySplitResult[1];
			var chk=reslt;
			try
			{
			//	yourStrindocument.myimage.widthg = yourString.replaceAll("\\s+", " ");
			//	chk=chk.replaceAll("\\s+"," ");
			chk=chk.replace(/\s+/g, ' ');
			
				var len=chk.length-2;
				chk=chk.substring(2,len);
			//	alert(chk);
			}
			catch (e) 
			{
				alert(e);	
			}
	//		document.getElementById("id").value=chk;
	//		document.getElementById("chbx").value=chbxAjx;
	//		document.forms["frm1"].submit();
	//		chkAjx(chk,chbxAjx);
			chkAjx(chk);
		}
	}
	var queryString = "?movement="+movement+"&SerialList="+SerialList+"&srNo="+srNo;
	ajaxRequest.open("GET", "rearrangeAjax.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
function chkAjx(v1)
{
//	alert(v1);
	document.getElementById("finalidlistAjx").value=v1;
	document.forms["formForAjx"].submit();
//	document.getElementById("chbx12").value=chbxAjx;
}

function test()
{
try{
	alert("In test functionn ");
	
	
}catch(e){alert(e);}
}
</script> 
 <%@ include file="footer.jsp" %>
 </body>
</html>