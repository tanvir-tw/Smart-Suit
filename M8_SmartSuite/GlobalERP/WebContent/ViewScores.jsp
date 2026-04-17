 <%@page import="java.time.Month"%>
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
<%

 String user=session.getAttribute("EmpName").toString();
String companyMasterId="100000";

 Statement st4 = null;

 Statement st_user_id = null;

 PreparedStatement ps=null; 
 Connection conn = null;
	try {
		conn = connection.getConnect("db_GlobalERP");       
		st4=conn.createStatement();
		st_user_id=conn.createStatement();	
	
	} catch (Exception e) {
		e.printStackTrace();
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

	System.out.println("==in else==");
	
	
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
		
	int cnt = 0;
	String Sesrole1=session.getAttribute("role").toString();
	String sessiondept=session.getAttribute("department").toString(); 
	
	%>
	<input type="hidden" id="HOD" name="HOD" value="<%=Sesrole1 %>">
	<% 
	
	String bt=request.getParameter("button");
	System.out.println("Button := "+bt);
	
	 if(bt==null)
	{
		 dept = sessiondept;
	}else{
		dept = request.getParameter("dept");
			} 
	
	String sql_activenew="";
		if (Sesrole1.equals("HOD"))
		{
			
			System.out.println("Dep :- "+dept);
			dept="All";
			if(dept!=null && dept.equals("AllDept"))
			{
		      sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}
			else
			{if(dept!=null && dept.equals("All"))
			{
				dept="%%";
				
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"' and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}else{
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where (dept = '"+dept+"' or dept = '"+sessiondept+"' ) and ActiveStatus = 'Yes' and dotprojectid!='-' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}
			}
		}
		else 
		{
			if (Sesrole1.equals("Hr"))
			{
				System.out.println("Dep :- "+dept);
				
			  if (dept!=null && dept.equals("AllDept") ) 
				{
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and dotprojectid!='-'  ";
				}
			  else
			  {if(dept!=null && dept.equals("All"))
				{
					dept="%%";
					
					sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"' and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
				}else{
				  sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where (dept = '"+dept+"' or dept = '"+sessiondept+"' ) and ActiveStatus = 'Yes' and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			  }
			  }
			}
			
		}
		if(Sesrole1.equals("-"))
		{
			sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where (dept = '"+dept+"' or dept = '"+sessiondept+"' ) and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}
		
		if(Sesrole1.equals("AllAdmin"))
			
		{
			System.out.println("Dep :- "+dept);
			
			if(dept!=null && dept.equals("All"))
			{
				dept="%%";
				
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"' and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}
			else
			{
				if (dept!=null && dept.equals("AllDept") ) 
				{
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and dotprojectid!='-'  ";
				}
			else
			{
				sql_activenew= "select dotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  (dept = '"+dept+"' or dept = '"+sessiondept+"' ) and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}
			}
		}

	System.out.println("The Dot Id query is ==>>"+sql_activenew);
	ResultSet rs_active = st_user_id.executeQuery(sql_activenew);
	while(rs_active.next()){
		
		++cnt;
		if(cnt == 1)
		{
			
			user_id1 = rs_active.getString("user_id");
			user_id1="\'"+user_id1+"\'";
		}else
		{
			user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
		}
		
	}
		int counter=0;
		
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Employee Score Report</h5>
    </div>
</div>
<form name="indexReport" method="get"  onsubmit="return confirmSubmit()">

		   <div class="row col-12">
		    <div class="col-md-2"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="dept" name="dept"  onchange="consig();">
			             	<option value="Select">Select</option>
			            	<option value="<%=sessiondept%>"><%=sessiondept%></option>
            
            <% if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD"))
            {
            %>
            <option value="AllDept">AllDept</option>
            <%
            }
            String sql1="";
            String department="";
            if (Sesrole1.equals("Hr"))
            {
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and dotprojectid in ("+user_id1+") order by dept";
            }
            else 
            	{
            	if (Sesrole1.equals("HOD")){
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept!='"+sessiondept+"'  and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and dotprojectid in ("+user_id1+") order by dept";
             }
            else
            {
            	if(Sesrole1.equals("AllAdmin"))
            	{
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'   and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+") order by dept ";
            	}
            	else
            	{
            		sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and dotprojectid in ("+user_id1+") order by dept ";
            	}
            }
          }
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			department=rsregno.getString("department");
			%>
			<option value="<%=department%>"><%=department%></option>
	         <%
      }
		dept = session.getAttribute("department").toString();
		
		if(request.getParameter("dept") != null){
		
		 %><option value=<%out.print("dept");%> selected><%=request.getParameter("dept") %></option><%
}
%>
           </select>
		       <script>
                            const mySel = document.getElementById("dept");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                            </script>	
		</div> 
	</div>
			<div class="col-md-2">
				  <label for="dropdown"><b>Employee</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="emps" name="emps">
			               
			               
			               <%	
			               String Bt2=request.getParameter("button");
	      	if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
        	  { %>
           			
           <%} 
            else 
            {
  		String	EmpName1=request.getParameter("emps"); 
  		 System.out.println("User EmpName1 "+EmpName1);
    	    if(Sesrole1.equals("AllAdmin")) {
           %>
            
             		<option value="<%=EmpName1%>"><%=EmpName1%></option>
             
             <%} 
            else
            { %>
            		<option value="<%=EmpName1%>"><%=EmpName1%></option>
            <% }  } %>
						</select>
						<script>
                            const mySel = document.getElementById("emps");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
						</div>
			</div>
	
	<div class="col-md-2">
				  <label for="dropdown"><b>Month</b></label>
						<div class="input-group input-group-merge">
			             <select class="form-select" id="month" name="month">
					  <%
					    String[] months = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
					    String mon = request.getParameter("month");
					
					    // Convert numeric (01..12) to month name if needed
					    if (mon != null && mon.matches("\\d{1,2}")) {
					        int index = Integer.parseInt(mon) - 1;
					        if (index >= 0 && index < 12) {
					            mon = months[index];
					        }
					    }
					  %>
					  
					  <% for (String m : months) { %>
					    <option value="<%=m%>" <%= (m.equals(mon) ? "selected" : "") %>><%=m%></option>
					  <% } %>
					</select>

			<script>
                            const mySel = document.getElementById("month");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
			</div>
		</div>

	<div class="col-md-2">
				  <label for="dropdown"><b>Year</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="year" name="year">
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
						
					</select>
							<script>
                            const mySel = document.getElementById("year");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
					</div>
					</div>
					
					
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return birt()">
			</div>
			<div class="col-md-1">
			</div>		
</div>

</form>

<%!
String datex1, datex2, data1, data2;
String myYear="", myMonth="";
%>
<%
datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
.format(new java.util.Date());
data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
.format(new java.util.Date());

Calendar c = Calendar.getInstance();   // this takes current date
c.set(Calendar.DAY_OF_MONTH, 1);
System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 

datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
System.out.println(" current date1 "+datex1); 

myMonth=datex1.substring(3, 6);
myYear=datex1.substring(7);
System.out.println("month---"+myMonth);
System.out.println("Year---"+myYear);
if (myMonth != null && myMonth.matches("\\d{1,2}")) {
    int monthNum = Integer.parseInt(myMonth); // 1–12
    myMonth = Month.of(monthNum).name().substring(0,3); // e.g. JAN
}

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

%>


<form id="indexcalc" name="indexcalc" method="post" >
<table id="example" class="display" style="width:100%;">   
<thead>
	<tr>
		<th class="col-width-4">SrNo.</th>
		<th>Employee<br>Name</th>
		<th>Year</th>
		<th>Proficiency</th>
		<th>Communication</th>
		<th>Commitment</th>
		<th>Dependability</th>
		<th>TurnOut</th>
		<th>Punctuality</th>
		<th>Calculated</th>
		<th>PI</th>
		<th>Entry By</th>
		<th>Entry</th>
		<th>Updated</th>
		<th>Edit</th>
	</tr>
</thead>
<tbody>
 <%
int count =0;

String qry="";

if(Sesrole1.equals("-"))
{ 
	
	qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' and EmpName = '"+emps+"' and Department ='"+sessiondept+"' and EmpId in (select distinct(EmpCode) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'    and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+")) ";
	System.out.println("1->"+qry);
						
}
else 
{
if((Sesrole1.equals("AllAdmin"))||(sessiondept.equals("Hr")))
{	
	if(dept==null)
	{
	qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' and EmpId in (select distinct(EmpCode) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'    and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+")) ";	
	System.out.println("2->"+qry);
	
	}
	else
	{
		if((dept.equalsIgnoreCase("All"))||(dept.equalsIgnoreCase("AllDept")))
		{
			qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"' and EmpId in (select distinct(EmpCode) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'    and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+")) ";	
			System.out.println("3->"+qry);
		}
		else
		{
			qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"'   and (Department ='"+dept+"' or Department ='"+sessiondept+"' ) and EmpId in (select distinct(EmpCode) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'    and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+")) ";	
			System.out.println("4->"+qry);
		}
	}
}
else
{
	qry="select * from test.EmpPersonalscore where  month='"+month1+"' and year ='"+year1+"'   and (Department ='"+dept+"' or Department ='"+sessiondept+"' ) and EmpId in (select distinct(EmpCode) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'    and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dotprojectid in ("+user_id1+")) ";
	System.out.println("5->"+qry);
}

}
System.out.println("The query is ==>>"+qry);
ResultSet rs = st.executeQuery(qry);
System.out.println("The query is ==>>"+qry);

try{
	

while(rs.next()) {
					String m1=rs.getString("month");
					
					if(m1.equals("01")){m2="JAN";}
					else if(m1.equals("02")){m2="FEB";}
					else if(m1.equals("03")){m2="MAR";}
					else if(m1.equals("04")){m2="APR";}
					else if(m1.equals("05")){m2="MAY";}
					else if(m1.equals("06")){m2="JUN";}
					else if(m1.equals("07")){m2="JLY";}
					else if(m1.equals("08")){m2="AUG";}
					else if(m1.equals("09")){m2="SEPT";}
					else if(m1.equals("10")){m2="OCT";}
					else if(m1.equals("11")){m2="NOV";}
					else if(m1.equals("12")){m2="DEC";}
					
					System.out.println("M1 : "+m1);
					System.out.println("M2 : "+m2);
					
					String y1=rs.getString("year");
					
					 int SrNo=rs.getInt("SrNo");
					String sn=SrNo+"";
					System.out.println("SrNo "+SrNo); 
										
%>
					
					<tr>
						<td class="text-center"><%= ++count%>
						<input type="hidden" id="SrNo1" name="SrNo1" value="<%=rs.getInt("SrNo")%>"/>
						<td class="text-left"><%= rs.getString("EmpName")%></td>
						<td class="text-center"><%= y1%></td>
						<td class="text-center"><%=rs.getString("ProficiencyScore") %></td>
						<td class="text-center"><%=rs.getString("CommunicationScore") %></td>
						<td class="text-center"><%=rs.getString("CommitmentScore") %></td>
						<td class="text-center"><%=rs.getString("DependabilityScore") %></td>
						<td class="text-center"><%=rs.getString("TurnOutScore") %></td>
						<td class="text-center"><%=rs.getString("PunctualityScore") %></td>
						<td class="text-center"><%= rs.getString("CalculatedScores")%></td>
						<td class="text-center"><%=rs.getString("PI") %></td>
						<td class="text-left"><%=rs.getString("EntryBy") %></td>
						<td class="text-right"><%=rs.getString("EntryDate")%></td>
						<td class="text-right"><%=rs.getString("UpdatedDate") %></td>
						<td class="text-center"><a href="EditScoreCardReport1.jsp?SrNo1=<%=rs.getInt(1)%>">update</a></td>
						
					</tr>
		<% 
		}
		%>	
</tbody>
</table>
</form>
</div>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
%>	
 <input type="hidden" id="departmentNew" name="departmentNew" value=""/>
 
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
		                        title: 'Score Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Score Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Score Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Score Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Score Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

<script>


function consig()
{
	var dept=document.getElementById("dept").value;
	$(document).ready(function () {
        $("#dept").click(function () {
            $('#emps')
                .find('option')
                .remove();
        });
    });	
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
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
		   	var reselt=ajaxRequest.responseText;
			var finalres=reselt.split("#");
			document.getElementById("emps").innerHTML=finalres[0];
		}
	
	}
	
	var queryString = "?dept="+dept;
	ajaxRequest.open("GET", "GetEmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
	}

            function fetch(dept) 
            {
        		  $(document).ready(function () {
        		        $("#dept").click(function () {
        		            $('#emps')
        		                .find('option')
        		                .remove();
        		        });
        		    });
        		
        	 	  $.ajax({
                        beforeSend: function() {
                        },
                      cache:false,
                       type:"post",
                       url:"fetch.jsp?dept="+dept,
                        dataType:"json", 
                       success:function(res){
                
                    	   var HOD =  document.getElementById("HOD").value;	
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
                              $("#emps").append($('<option value="' +p.EmpName+ '">' +p.EmpName+ '</option>'));   
                          }
                       },
                       error:function() {
                       }
                   });
           }
        </script>
<script type="text/javascript">

function confirmSubmit() {

	var dept = document.getElementById("dept").options[document.getElementById("dept").selectedIndex].value;
	if(dept=="select") {
			alert("Please select Department!");
		return false;
	}
	var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
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
{
	System.out.println("Birt");
	var HOD = document.getElementById("HOD").value;	
	var dept = document.getElementById("dept").value;
	if(dept=="Select")
	{
			alert("Please select Department!");
		return false;
	}
	var emp=document.getElementById("emps").value;
	if((emp=="Select")||(emp==null))
		{
			alert("Please Select Employee ");
			return false;
		}
	
	var month=document.getElementById("month").value;
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

	}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>