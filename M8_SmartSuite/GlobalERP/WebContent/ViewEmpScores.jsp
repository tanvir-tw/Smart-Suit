<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@ include file="header.jsp"%>
     
     <%!
Connection con1;
%>
<% 

/* String DB_Driver="com.mysql.cj.jdbc.Driver";
String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
String DB_NAME1="jdbc:mysql:// twdb.fleetview.in/newblankerp"; 

String DB_USERNAME="erp";
String DB_PASSWORD="1@erp"; */

		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		%>
		
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Transworld Technologies LTD, ERP</title>
<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
<script src="sorttable.js" type="text/javascript"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<script>
  
</script>

<script>
            function fetch1(dept) 
            {
        		//alert("fetch()");
        		//alert(dept);
        		/* var dept=document.getElementById("dept");
        		alert(dept); */
        		
        		
        		  $(document).ready(function () {
        		        $("#dept").click(function () {
        		            $('#emps')
        		                .find('option')
        		                .remove();
        		        });
        		    });
        		
        	 	  $.ajax({
                        beforeSend: function() {
                        	//alert("Hi");
                           /*  $('#status').html("Status : Fetching Content"); */
                        },
                      cache:false,
                       type:"post",
                       url:"GetEmp.jsp?dept="+dept,
                        dataType:"json", 
                       success:function(res){
                
                    	   var HOD =  document.getElementById("HOD").value;	
                    		//alert(HOD);
                    		if(HOD=="-")
                    		{
                    	   
                    		}
                    		else
                    		{	
                    	   var data="";
                          $("#emps").append($('<option value="Select">Select </option>')); 
                  		$("#emps").append($('<option value="All">All </option>'));
                    		}
                        
                          for(i=0;i<res.length;i++){
                              var p=JSON.parse(res[i]);
                            //  data+="<tr><td>"+p.EmpCode+"</td><td>"+p.EmpName+"</td></tr>";
                            //  data+="<option value="+p.EmpName+"> "+p.EmpName+" </option>";
                              $("#emps").append($('<option value="' +p.EmpName+ '">' +p.EmpName+ '</option>'));   
                          }
                         // $('#status').html("Status : Content fetched");
                          //$('#emps').html(data);
                       },
                       error:function() {
                        //   $('#status').html("Status : Failed to fetch content");
                       }
                   });
           }
        </script>
<script type="text/javascript">


function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.indexcalc.action ="excel.jsp";
          document.forms["indexcalc"].submit();
}
function confirmSubmit() {

	var dept = document.getElementById("dept").options[document.getElementById("dept").selectedIndex].value;
	if(dept=="select") {
			
			alert("Please select Department!");
		return false;
	}
	//alert("Hi");
	var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
	//alert(month);
	if(month=="Select")
		{
		alert("Please select Month!");
		return false;
		}
	var year=document.getElementById("year").options[document.getElementById("year").selectedIndex].value;
	if(year=="Select")
	{
	alert("Please select Year!");
	return false;
	}
}

function birt()
{//alert("Birt");
	var HOD = document.getElementById("HOD").value;	
	//alert("HOD : "+HOD);
	var dept = document.getElementById("dept").value;
	//alert(dept);
	if(dept=="Select")
	{
			alert("Please select Department!");
		return false;
	}
	//alert("Hi");
	var emp=document.getElementById("emps").value;
	//alert("Emp : "+emp);
	if((emp=="Select")||(emp==null))
		{
			alert("Please Select Employee ");
			//alert(emp);
			return false;
		}
	
	var month=document.getElementById("month").value;
	//alert(month);
	if(month=="Select")
		{
		alert("Please select Month!");
		return false;
		}
	var year=document.getElementById("year").value;
	if(year=="Select")
	{
	alert("Please select Year!");
	return false;
	}
	
	//alert(year);
	//document.getElementById("HOD").value;
	//alert(HOD);
	/* var dept = document.getElementById("dept").value;
	
	//alert(dept);
	var month=document.getElementById("month").value;
	//alert(month);
	var year=document.getElementById("year").value; */
	//alert(year);
	
	/* alert(HOD);
	alert(dept);
	alert(emp);
	alert(month); */
	if(HOD=="-")
		{
			//var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month+"' and year ='"+year+"' and EmpName like '%"+emp+"%' and Department like '%"+dept+"%';"
			var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,   EntryDate,  UpdatedDate from test.EmpPersonalscore where  month='"+month+"' and year ='"+year+"' and EmpName = '"+emp+"' and Department = '"+dept+"';"
			//alert("1 : "+qry);
			document.getElementById("myIframe").src="http://"+host1":8080/birt/frameset?__report=ViewScoresNew.rptdesign&Qry="+qry+"&month="+month+"&year="+year+"&__showtitle=false";
			//window.location.replace("ViewScores.jsp?qry="+qry);
		}
	else if(HOD=="AllAdmin")
	{
		if((dept=="All")||(dept=="AllDept"))
		{		
			//var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month+"' and year ='"+year+"' and EmpName like '%%' and Department like '%%';"
			var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,   EntryDate,  UpdatedDate from test.EmpPersonalscore where  month='"+month+"' and year ='"+year+"';"
			//alert("2 : "+qry);
			//window.location.replace("ViewScores.jsp?qry="+qry);
		}
		else
		{	
			var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  EntryDate, UpdatedDate from test.EmpPersonalscore where  month='"+month+"' and year ='"+year+"'  and Department = '"+dept+"';"
			//alert("3 : "+qry);		
			//window.location.replace("ViewScores.jsp?qry="+qry);
		}
	document.getElementById("myIframe").src="http://"+host1+":8080/birt/frameset?__report=ViewScoresNew.rptdesign&Qry="+qry+"&month="+month+"&year="+year+"&__showtitle=false";

	}
	else if(HOD=="HOD")
		{	
		
		if((dept=="All")||(dept=="AllDept"))
		{		
		//	var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month+"' and year ='"+year+"' and EmpName like '%%' and Department like '%%';"
			var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,   EntryDate,  UpdatedDate from test.EmpPersonalscore where month='"+month+"' and year ='"+year+"';"
		//	alert("4 : "+qry);
		//	window.location.replace("ViewScores.jsp?qry="+qry);
		}
		else
		{	
			//var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month+"' and year ='"+year+"' and EmpName like '%%' and Department like '%"+dept+"%';"
			var qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,   EntryDate, UpdatedDate from test.EmpPersonalscore where  month='"+month+"' and year ='"+year+"'  and Department ='"+dept+"';"
		//	alert("5 : "+qry);		
			//window.location.replace("ViewScores.jsp?qry="+qry);
		}
		
	//	alert("6 : "+qry);
		document.getElementById("myIframe").src="http://"+host1+":8080/birt/frameset?__report=ViewScoresEmpNew.rptdesign&Qry="+qry+"&month="+month+"&year="+year+"&__showtitle=false"; 
	//document.getElementById("myIframe").src="http://127.0.0.1:49670/viewer/frameset?__report=ViewScores1.rptdesign&HOD="+HOD+"&month="+month+"&year="+year+"&EmpName="+emp+"&__showtitle=false";
		//window.location.replace("ViewScores.jsp?qry="+qry);
		}
	
	/*	var queryString = "?dept=" +dept;
	
	
	ajaxRequest.open("GET", "fetch.jsp" + queryString, true);
	ajaxRequest.send(null); 


	
	
 var ajaxRequest;  // The variable that makes Ajax possible!

	
	
	
	try
	{
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
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
		{alert("######################### ");
			//var reselt=ajaxRequest.responseText;
// 			document.getElementById("err").innerHTML=reselt; 

 		   var reselt=ajaxRequest.responseText;
		   alert("Original result new"+reselt);
 			var finalres=reselt.split("#");
			//var finalres=reselt.trim();
			//alert("After trim"+finalres[0]);
			var finalrescount=finalres[1].trim();
			//alert("finalrescount"+finalrescount);
			//alert("finalrescount2"+finalrescount[2]);
		if(finalrescount>=1)
		   {
 			alert("Customer Name Already Exists !!You Can Not Add This Customer---->"+finalres[0].trim());
         // alert("Customer Name Is Already Exists! You Can't Add This C!!");
 			document.addCustomer.companyName.value="";
 			//document.getElementById("comlist").style.display='none';
		  }
		 
		}
	
	}
 */	//document.getElementById("myIframe").src="http:// twdb.fleetview.in:8080/birt/frameset?__report=purchaseindentreport.rptdesign&dept="+dept+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&comid="+comid+"&project="+project+"&status="+status+"&role="+role+"&__showtitle=false";

//	document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
	/* document.getElementById("reportData2").style.display="";
	document.getElementById("footer").style.display="none"; */
	
}

</script>

<%
Statement st = null;
Statement stt = null;
Statement sta = null;
Statement stb = null;
Statement stc = null;
Statement std = null;
Statement st_up = null;
Statement st_up1 = null;
Statement st_user_id = null;
Statement st1 = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;
Statement st5 = null;
Statement st6 = null;
Statement st7 = null;
Statement st8 = null;
Statement st9 = null;
Statement st10 = null;
PreparedStatement ps=null; 
 
 String user=session.getAttribute("EmpName").toString();
String companyMasterId="100000";		//session.getAttribute("companyMasterId").toString(); 

/* String user="Reshma Maner"; //session.getAttribute("EmpName").toString();
String companyMasterId="100000";	//session.getAttribute("CompanyMasterID").toString();
 */
try {
		Connection conn = null;
		
		String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
		String MM_dbConn_USERNAME = "fleetview";
		String MM_dbConn_PASSWORD = "1@flv";
		//String MM_dbConn_GPS = "jdbc:mysql://173.234.153.82/dotproject";
		String MM_dbConn_GPS = "jdbc:mysql://173.234.153.82/dotproject";
        //String MM_dbConn_GPS = "jdbc:mysql://192.168.2.55/dotprojectfortesting";
        //String MM_dbConn_GPS = "jdbc:mysql://192.168.2.55/dotproject";
		
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st=conn.createStatement();
		stt=conn.createStatement();
		sta=conn.createStatement();	
		stb=conn.createStatement();	
		stc=conn.createStatement();
		std=conn.createStatement();	
		st_up=conn.createStatement();	
		st_up1=conn.createStatement();
		st_user_id=conn.createStatement();	
		st1=conn.createStatement();
		st2=conn.createStatement();
		st3=conn.createStatement();
		st4=conn.createStatement();
		st5=conn.createStatement();
		st6=conn.createStatement();
		st7=conn.createStatement();
		st8=conn.createStatement();
		st9=conn.createStatement();
		st10=conn.createStatement();
		System.out.println("===========connection created=============");
	
	} catch (Exception e) {
		System.out.print("GetConnection Exception ---->" + e);
	}
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
String m2="";
String y2="";
int k=2000;



dept = session.getAttribute("department").toString();

//System.out.println("==datenew1=="+datenew1+">>datenew2"+datenew2);


	System.out.println("==in else==");
	
	
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
		
	//select the user_ids from active_users table
	int cnt = 0;
	String Sesrole1=session.getAttribute("role").toString();
	String sessiondept=session.getAttribute("department").toString(); 
	
	/* String Sesrole1="AllAdmin";		//session.getAttribute("role").toString();
	String sessiondept="All";			//session.getAttribute("department").toString();
	 */System.out.println("Session Dept :- "+sessiondept);
	System.out.println("Sesrole1 :- "+Sesrole1);
	
	%>
	<input type="hidden" id="HOD" name="HOD" value="<%=Sesrole1 %>">
	<% 
	String sql_active = "";
	//String sql_active = "select user_id from dotproject.active_users where department = '"+dept+"' and Active_Status = 'Yes'";
	
	
	
		if (Sesrole1.equals("HOD"))
		{
			dept = request.getParameter("dept");
			System.out.println("Dep :- "+dept);
			if(dept!=null && dept.equals("AllDept"))
			{
		      sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+"";
			}
			else
			{
				sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+"";
			}
			
		}
		else
		{
			if (Sesrole1.equals("Hr"))
			{
				dept = request.getParameter("dept");
				System.out.println("Dep :- "+dept);
				
			  if (dept!=null && dept.equals("AllDept") ) 
				{
				sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where  companyMasterId="+companyMasterId+" and ActiveStatus = 'Yes' and dotprojectid!='-'  ";
				}
			  else
			  {
				  sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			  }
			}
			
				
			
		}
		if(Sesrole1.equals("-"))
		{
			sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+user+"' and companyMasterId="+companyMasterId+"";
		}
		
		if(Sesrole1.equals("AllAdmin"))
			
		{
			dept = request.getParameter("dept");
			System.out.println("Dep :- "+dept);
			
			if(dept!=null && dept.equals("All"))
			{
				dept="%%";
				
				sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			}
			else
			{
			if(dept!=null)
			{
			sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			}
			else
			{
				sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
			}
			}
		}
	
	/* if (Sesrole1.equals("Hr"))
	{
	sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and companyMasterId="+companyMasterId+" ";
	}
	else
	{
		if (Sesrole1.equals("HOD"))
		{
		sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+"";
		}
		else
		{
			sql_active = "select dotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+user+"' and companyMasterId="+companyMasterId+"";
		}
	} */
	
	System.out.println("The Dot Id query is ==>>"+sql_active);
	
	ResultSet rs_active = st_user_id.executeQuery(sql_active);
	
	while(rs_active.next()){
		++cnt;
		if(cnt == 1)
		{
			user_id1 = rs_active.getString("user_id");
		}else
		{
			user_id1 = user_id1 +","+ rs_active.getString("user_id");
		}
		
	}
	 
/*	 if(dept == "Software" || dept.equals("Software")) {
		 user_id1 = "(49,51,59,64,70,72,75,76,77,78,82,83)";
	 }else{
		 user_id1 = "(28,60,62,66,67,74,79,80,81,84,85)";
	 }*/


 
		/* DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2)); */
		int counter=0;
		
%>

<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="black" size="4"><b>Employee Score Report </b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="60%" align="center">
<tr>
<td align="center"><b>Dept</b></td>
<td>
		<div >
			<%-- <select class="element select medium" id="dept" name="dept" style="width: 100px; height: 25px;">
			<%if(dept != null) { 	
				%><option value="select">select</option><%
			}else{
				 %><option value="select" selected>select</option><%
				 %><option value="Software">Software</option><%
				 %><option value="RnD">RnD</option><%
				 %><option value="Accounts">Accounts</option><%
						 %><option value="Hr">Hr</option><%
				 %><option value="Sales">Sales</option><%
				 %><option value="Purchase">Purchase</option><%
				 %><option value="Operation">Operation</option><%
				 %><option value="Marketing">Marketing</option><%
				
			}
			if(dept != null){
			if(dept.equals("Software") || dept == "Software") {	
				 %><option value="Software" selected>Software</option><%
				}else{System.out.println("in else s");
					 %><option value="Software">Software</option><%
				}if(dept.equals("RnD")) 
				{		
				 %><option value="RnD" selected>RnD</option><%
				}else{
					 %><option value="RnD">RnD</option><%
				}if(dept.equals("Accounts")) 
				{		
					 %><option value="Accounts" selected>Accounts</option><%
					}else{
						 %><option value="Accounts">Accounts</option><%
					}if(dept.equals("Hr")) 
					{		
						 %><option value="Hr" selected>Hr</option><%
						}else{
							 %><option value="Hr">Hr</option><%
						}if(dept.equals("Sales")) 
					{		
						 %><option value="Sales" selected>Sales</option><%
						}else{
							 %><option value="Sales">Sales</option><%
						}if(dept.equals("Purchase")) 
						{		
							 %><option value="Purchase" selected>Purchase</option><%
							}else{
								 %><option value="Purchase">Purchase</option><%
							}if(dept.equals("Operation")) 
							{		
								 %><option value="Operation" selected>Operation</option><%
								}else{
									 %><option value="Operation">Operation</option><%
								}
							if(dept.equals("Marketing")) 
							{		
								 %><option value="Marketing" selected>Marketing</option><%
								}else{
									 %><option value="Marketing">Marketing</option><%
								}
			}	
		     %>     		      
		      </select> --%>
		      
		      
		      <!-- <select name="Department" id="Department" style="width: 80px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder;"> -->
		      <select class="element select medium" id="dept" name="dept"  onchange="fetch1(this.value);" style="width: 120px; height: 25px;">
         <%--   <option ><%=cmp %></option>  --%>
            <option value="Select">Select</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            
            <% if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD")||Sesrole1.equals("AllAdmin"))
            {
            %>
            
            <option value="AllDept">AllDept</option>
            
            <%
            }
            String sql1="";
            String department="";
            
            
            if (Sesrole1.equals("Hr"))
            {
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"' and companyMasterId="+companyMasterId+" order by dept asc";
            }
            else 
            	{
            	if (Sesrole1.equals("HOD")){
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept!='"+sessiondept+"'  and (HODReport='"+user+"' OR EmpName='"+user+"') and companyMasterId="+companyMasterId+" order by dept asc ";
            			
            	
             }
            else
            {
            	if(Sesrole1.equals("AllAdmin"))
            	{
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'   and companyMasterId="+companyMasterId+" order by dept asc";
            	}
            	else
            	{
            		sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'  and EmpName='"+user+"' and companyMasterId="+companyMasterId+" order by dept asc ";
            	}
            }
          }
            //	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companyMasterId="+companyMasterId+"  and ActiveStatus='Yes' order by dept";
            
            	 
            	 
            	 
            	 
            	 
            	 
            	 
            	
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
		      
		       
		   
		</div> 
</td>
<td><b>Emp</b></td>
<td><select class="element select medium" id="emps" name="emps"  style="width: 140px; height: 25px;">
		       <!-- 	<option value=" ">Select</option> -->
		       </select>
</td>

<td><b>Month </b></td>
<td><!-- <select name="month" id="month" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" > -->
			<select class="element select medium" id="month" name="month" style="width: 100px; height: 25px;">
<option value="Select">Select</option>
<option value="JAN">JAN</option>
<option value="FEB">FEB</option>
<option value="MAR">MAR</option>
<option value="APR">APR</option>
<option value="MAY">MAY</option>
<option value="JUN">JUN</option>
<option value="JLY">JLY</option>
<option value="AUG">AUG</option>
<option value="SEPT">SEPT</option>
<option value="OCT">OCT</option>
<option value="NOV">NOV</option>
<option value="DEC">DEC</option>

<%
if(request.getParameter("month") != null){
	String mon=request.getParameter("month");
	System.out.println("Month :-"+mon);
	if(mon.equals("01"))
	{
		mon="JAN";
	}else if(mon.equals("02"))
	{
		mon="FEB";
	}else if(mon.equals("03"))
	{
		mon="MAR";
	}
	else if(mon.equals("04"))
	{
		mon="APR";
	}
	else if(mon.equals("05"))
	{
		mon="MAY";
	}
	else if(mon.equals("06"))
	{
		mon="JUN";
	}
	else if(mon.equals("07"))
	{
		mon="JUL";
	}
	else if(mon.equals("08"))
	{
		mon="AUG";
	}
	else if(mon.equals("09"))
	{
		mon="SEP";
	}
	else if(mon.equals("10"))
	{
		mon="OCT";
	}
	else if(mon.equals("11"))
	{
		mon="NOV";
	}
	
	
	else if(mon.equals("12"))
	{
		mon="DEC";
	}
	
		
		
		 %><%-- <option value=<%=mon%> selected><%=mon %></option> --%><%
}
%>
</select></td>
<td><b>Year</b></td>
<td><!-- <select name="year" id="year" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" > -->
			<select class="element select medium" id="year" name="year" style="width: 100px; height: 25px;">
			<option value="Select">Select</option>
<%for(k=2017;k<=2050;k++)
{
%>
<option value="<%=k %>"><%=k %></option>
<%} %>


<%
if(request.getParameter("year") != null){
		
		 %><option value=<%=request.getParameter("year")%> selected><%=request.getParameter("year") %></option><%
}
%>
</select></td>
<td class="element select medium" bgcolor="#f5f5f5" align="center"><font size="2"><input type="submit" name ="sub" id ="sub" value="submit" onclick="return birt()" style="background-color:#f5f5f5; "></input></font></td>
</table>
<table align="center">

</td>
<%-- <td bgcolor="#f5f5f5" align="center"><font size="2"><b>From Date</b></font></td>
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
</td> --%>

<tr></tr>

<!-- <td class="element select medium" bgcolor="#f5f5f5" align="center"><font size="2"><input type="submit" name ="sub" id ="sub" value="submit" onclick="return birt()" style="background-color:#f5f5f5; "></input></font></td> -->
</tr>
</table>
</table>
</form>




<%!
String datex1, datex2, data1, data2;
String myYear="", myMonth="";
%>
<%
 String ddx = request.getQueryString();
	

		datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new java.util.Date());
	
		Calendar c = Calendar.getInstance();   // this takes current date
	    c.set(Calendar.DAY_OF_MONTH, 1);
	    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
	  
	 datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
	    System.out.println(" current date1 "+datex1); 
		
	
	/* } else {
		data1 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("startdate")));
		data2 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("enddate")));
 */
		/* datex1 = request.getParameter("startdate");
		datex2 = request.getParameter("enddate"); */
	//}

/* System.out.println(" datex1 "+datex1+" datex2 "+datex2);
String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
	.parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
	.parse(datex2)); */
	myMonth=datex1.substring(3, 6);
	myYear=datex1.substring(7);
/* 	System.out.println("dt---"+dt);
	System.out.println("dt1---"+dt1);
 */	System.out.println("month---"+myMonth);
	System.out.println("Yeat---"+myYear);

	if(myMonth.equals("01"))
	{
		myMonth="JAN";
	}else if(myMonth.equals("02"))
	{
		myMonth="FEB";
	}else if(myMonth.equals("03"))
	{
		myMonth="MAR";
	}
	else if(myMonth.equals("04"))
	{
		myMonth="APR";
	}
	else if(myMonth.equals("05"))
	{
		myMonth="MAY";
	}
	else if(myMonth.equals("06"))
	{
		myMonth="JUN";
	}
	else if(myMonth.equals("07"))
	{
		myMonth="JUL";
	}
	else if(myMonth.equals("08"))
	{
		myMonth="AUG";
	}
	else if(myMonth.equals("09"))
	{
		myMonth="SEP";
	}
	else if(myMonth.equals("10"))
	{
		myMonth="OCT";
	}
	else if(myMonth.equals("11"))
	{
		myMonth="NOV";
	}
	
	
	else if(myMonth.equals("12"))
	{
		myMonth="DEC";
	}
	
/* The from Date Time is :1999-13-01 00:00:00
The to Date time is :null 23:59:59 */


String year1=request.getParameter("year");

if(year1==null)
{
	year1=myYear;
	
}
else 
{
	 year1=request.getParameter("year");
}
String month1=request.getParameter("month");
if(month1==null)
	
{
	
	month1=myMonth;
	
	
}
else
{
	month1=request.getParameter("month");
}
 

System.out.println("Selected Month :- "+month1);
System.out.println("Selected Year :- "+year1);
DecimalFormat df = new DecimalFormat("0.00");

String emps=request.getParameter("emps");


if(emps==null)
{
	emps=user;			//"All";
	
}
else 
{
	 year1=request.getParameter("year");
}
//String fromDate = request.getParameter("from_date1");
//String toDate = request.getParameter("to_date1");

/*if(month1.equals("JAN"))
	{
	month1="01";
	}else if(month1.equals("FEB"))
	{
		month1="02";
	}else if(month1.equals("MAR"))
	{
		month1="03";
	}
	else if(month1.equals("APR"))
	{
		month1="04";
	}
	else if(month1.equals("MAY"))
	{
		month1="05";
	}
	else if(month1.equals("JUN"))
	{
		month1="06";
	}
	else if(month1.equals("JUL"))
	{
		month1="07";
	}
	else if(month1.equals("AUG"))
	{
		month1="08";
	}
	else if(month1.equals("SEP"))
	{
		month1="09";
	}
	else if(month1.equals("OCT"))
	{
		month1="10";
	}
	else if(month1.equals("NOV"))
	{
		month1="11";
	}
	
	
	else if(month1.equals("DEC"))
	{
		month1="12";
	} */


String fromDate = year1+"-"+month1+"-"+"01";
String toDate="";
String toDate1 ="select last_day ('"+fromDate+"') as monthname3";
System.out.println("monthname 1:- "+toDate1);
ResultSet rsmonthname3=st4.executeQuery(toDate1);
rsmonthname3.next();
String mnth3=rsmonthname3.getString("monthname3");
toDate=mnth3;

//String toDate = year1+"-"+month1+"-"+"31";



	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
/* if(fromDate !=null || toDate !=null) {
 */	
	/* fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDate));
	toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate)); */
	
	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
	String fromDTime =fromDate+" 00:00:00";
	String toDTime =toDate+" 23:59:59";
	
	System.out.println("The from Date Time is :"+fromDTime);
	System.out.println("The to Date time is :"+toDTime);
%>
<div align="center">
<form id="indexcalc" name="indexcalc" method="post" >
<%
      //   final String exportFileName="Task_Index_Report_Between_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDTime))+"_And_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDTime))+".xls";  
%>
<table width="85%" border="0" align="center">
		<tr>
			<td>
			 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 			<%-- 	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> --%>  
							
        	</td>
		</tr>
		
</table>




<%-- <div style="width:85%;" align="center" id="table1" >
<table border="0" width="100%" align="center" class = "sortable">

<tr >
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Sr<br>No</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Employee<br>Name</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Month</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Proficiency<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Communication<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Commitment<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Dependability<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">TurnOut<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Punctuality<br>Score</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Calculated <br>Scores %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Performance<br>Index %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Entry By</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Entry Date</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">UpdatedDate</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Edit</font></th>

</tr>


 <%
try{
	
int count =0;

String sql = "Select user_id, user_username from dotproject.users where user_id in ('"+user_id1+"') order by user_username ASC";
System.out.println("The query is ==>>"+sql);
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		String user_id = rs.getString("user_id");
		String user_name = rs.getString("user_username");
		
			
		
				double total_task = 0.0,a_cat = 0.0, b_cat = 0.0, c_cat = 0.0, d_cat = 0.0; double a_cat_per = 0.0,b_cat_per = 0.0, c_cat_per = 0.0,d_cat_per = 0.0,per_index = 0.0;
				
				// String sql_total ="select sum(task_duration) as total_tasks from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"' "; */
				String qry="select * from test.EmpPersonalscore where HOD='"+user+"' and month='"+month1+"' and year ='"+year1+"'"; 
				/* String qry="select * from test.PersonalScore where user='R_Maner'"; */
				System.out.println("The Select qry is ==>>"+qry);
				PreparedStatement ps1 = con1.prepareStatement(qry);
				ResultSet rst = ps1.executeQuery();
				//System.out.println("The query is ==>>"+sql_total);
				int total=0;
				float per=0.0F, percent=0.0F;
				if(!rst.next())
				{
					out.println("There is no record for this values");
				}
				while(rst.next())
				{
					String m1=rst.getString("month");
					
					if(m1.equals("1")){m2="JAN";}
					else if(m1.equals("2")){m2="FEB";}
					else if(m1.equals("3")){m2="MAR";}
					else if(m1.equals("4")){m2="APR";}
					else if(m1.equals("5")){m2="MAY";}
					else if(m1.equals("6")){m2="JUN";}
					else if(m1.equals("7")){m2="JLY";}
					else if(m1.equals("8")){m2="AUG";}
					else if(m1.equals("9")){m2="SEPT";}
					else if(m1.equals("10")){m2="OCT";}
					else if(m1.equals("11")){m2="NOV";}
					else if(m1.equals("12")){m2="DEC";}
					
					System.out.println("M1 : "+m1);
					System.out.println("M2 : "+m2);
					
					String y1=rst.getString("year");
					
					 int SrNo=rst.getInt("SrNo");
					String sn=SrNo+"";
					out.println(sn); 
					
					
					%>
					<tr>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%= ++count%></div> </td>
						<input type="hidden" id="SrNo1" name="SrNo1" value="<%=rst.getInt("SrNo")%>"/>
						<td bgcolor="#f5f5f5" align="left"><div align="left"><%= rst.getString("EmpName")%></div></td>
						<td bgcolor="#f5f5f5" align="left"><div align="right"><%= m2%> <%= y1%></div></td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("ProficiencyScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("CommunicationScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("CommitmentScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("DependabilityScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("TurnOutScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("PunctualityScore") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%= rst.getString("CalculatedScores")%></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("PI") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("EntryBy") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("EntryDate") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><%=rst.getString("UpdatedDate") %></div> </td>
						<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="EditScoreCardReport1.jsp?SrNo1=<%=rst.getInt(1)%>">update</a>
					</tr>
					
					<% 
					
					
				}
		}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>			
</table> --%>
<br>
<%
/* } *///end of condition
%>


<div style="text-align: right"> 
                           <%-- <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></div> --%>
        				<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td></div>
<div id="reportData1">		
		<%-- 	<iframe id="myIframe" width="100%" height="850px" src="http:// twdb.fleetview.in:8080/birt/frameset?__report=ViewScores.rptdesign&Hod=<%=user %>&Month=<%=month1 %>&Year=<%=year1 %>&__showtitle=false">
																																					
				<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
				</iframe>  --%>
		<%
		String qry="";
		
		if(Sesrole1.equals("-"))
		{ 
			
		//	qry="select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%"+emps+"%' and Department like '%"+sessiondept+"%';";
			qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' and EmpName = '"+emps+"' and Department ='"+sessiondept+"' order by EmpName asc;";
			System.out.println("1->"+qry);
		%>						
			 <iframe id="myIframe" width="100%" height="850px" src="http://<%=host1 %>:8080/birt/frameset?__report=ViewScoresEmpNew.rptdesign&Qry=<%=qry %>&month=<%=month1 %>&year=<%=year1 %>&__showtitle=false"></iframe> 
			<%
		}
		else 
		{
		if((Sesrole1.equals("AllAdmin"))||(sessiondept.equals("Hr")))
		{	
			if(dept==null)
			{
				if(emps.equalsIgnoreCase("All"))
				{
				qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
				System.out.println("1->"+qry);
				}
				else
				{
					qry="select * from test.EmpPersonalscore where  EmpName='"+emps+"' and month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("2->"+qry);
						
				}
			}
			else
			{
				if((dept.equalsIgnoreCase("All"))||(dept.equalsIgnoreCase("AllDept")))
				{
					if(emps.equalsIgnoreCase("All"))
					{
						qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
						System.out.println("3->"+qry);
					}
					else
					{
						qry="select * from test.EmpPersonalscore where  EmpName='"+emps+"' and month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
						System.out.println("4->"+qry);
						
					}
				}
				else
				{
					if(emps.equalsIgnoreCase("All"))
					{
						qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"'   and Department ='"+dept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
						System.out.println("5->"+qry);
					}
					else
					{
						qry="select * from test.EmpPersonalscore where  EmpName='"+emps+"' and month='"+month1+"' and year ='"+year1+"'   and Department ='"+dept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
						System.out.println("6->"+qry);
						
					}
				}
			}
	}
		else
		{
			if(dept==null)
			{
				if(emps.equalsIgnoreCase("All"))
				{
					qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' and Department ='"+sessiondept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("7->"+qry);
				}
				else
				{
					qry="select * from test.EmpPersonalscore where  EmpName='"+emps+"' and month='"+month1+"' and year ='"+year1+"' and Department ='"+sessiondept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("8->"+qry);
					
				}
			}
			else if((dept.equalsIgnoreCase("All"))||(dept.equalsIgnoreCase("AllDept")))
			{
				if(emps.equalsIgnoreCase("All"))
				{
					qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("9->"+qry);
				}
				else
				{
					qry="select * from test.EmpPersonalscore where  EmpName = '"+emps+"' and month='"+month1+"' and year ='"+year1+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("10->"+qry);
				}
			}
			else
			{
				if(emps.equalsIgnoreCase("All"))
				{
					qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"'   and Department ='"+dept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("11->"+qry);
					
				}
				else
				{
					qry="select * from test.EmpPersonalscore where  EmpName = '"+emps+"' and month='"+month1+"' and year ='"+year1+"'   and Department ='"+dept+"' order by EmpName asc;";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
					System.out.println("12->"+qry);
				}
			}
		/* 	qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"'   and Department ='"+dept+"';";		//"select SrNo, EmpId, EmpName, Department, HOD, month, year, ProficiencyScore, CommunicationScore, CommitmentScore, DependabilityScore, TurnOutScore, PunctualityScore, PI, CalculatedScores, EntryBy,  DATE_FORMAT(EntryDate,'%d-%b-%Y %H:%i') AS EntryDate, DATE_FORMAT(UpdatedDate,'%d-%b-%Y %H:%i') AS UpdatedDate from test.EmpPersonalscore where HOD like '%%' and month='"+month1+"' and year ='"+year1+"' and EmpName like '%%'  and Department like '%"+sessiondept+"%';";
			System.out.println("5->"+qry); */
		}
			
		%>
				 <iframe id="myIframe" width="100%" height="850px" src="http://<%=host1%>:8080/birt/frameset?__report=ViewScoresEmpNew.rptdesign&Qry=<%=qry%>&month=<%=month1 %>&year=<%=year1 %>&__showtitle=false"></iframe> 		
		<% }%><%-- <iframe id="myIframe" width="100%" height="850px" src="http://127.0.0.1:49670/viewer/frameset?__report=ViewScores.rptdesign&Hod=<%=user %>&Month=<%=month1 %>&Year=<%=year1 %>&EmpName=<%=emps %>&__showtitle=false"> --%>																																					
				<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
				
			</div>
<!-- </div>  -->
</div>
</form>
</head></html>
<%-- <%@ include file="footer_new.jsp" %> --%>
