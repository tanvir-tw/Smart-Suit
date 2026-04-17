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

<style>
/* div.dataTables_length {
    padding-left: 2em;
    }ex
    div.dataTables_length,
    div.dataTables_filter {
        padding-top: 0.55em;
    }*/
    
/*   #example td {
  white-space: nowrap;
} */

 #example td {
      max-width: 270px;
       white-space: nowrap;
       text-overflow: ellipsis;
     }
  
/* table th:nth-child(7), td:nth-child(7) {
  display: none;
} */

    
 </style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/responsive/1.0.7/js/dataTables.responsive.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.dataTables.min.css"> 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/v/dt/dt-1.10.12/se-1.2.0/datatables.min.js"></script>
<script src="https://gyrocode.github.io/jquery-datatables-checkboxes/1.1.0/js/dataTables.checkboxes.min.js"></script>
<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>

<script>
var tbl;
$(document).ready(function (){
	
          tbl = $('#example').DataTable({
        	//  "pagingType": "full_numbers",        	  
        	  responsive:true,
        	  /* "columnDefs": [
		            { responsivePriority: 1, targets: 0 },
		            { responsivePriority: 2, targets: 4 }
		        ], */
		        columnDefs: [
		           
		            { targets: 3, width: '5%' }
		        ],
        	  "dom": 'B<"top"lfip<"clear">>rt<"bottom"iflp<"clear">>', 
        	 // "dom":'Bftrip<lf<t>ip>',
        	  //dom: 'Bfrtip',

	        buttons: [
	        	'colvis',
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Pending Task Approval Report '+$("#data").val()+'to'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Pending Task Approval Report '+$("#data").val()+'to'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Pending Task Approval Report '+$("#data").val()+'to'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Pending Task Approval Report '+$("#data").val()+'to'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Pending Task Approval Report '+$("#data").val()+'to'+$("#data1").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	      /*   fixedColumns:   {
	            leftColumns: 2
	        }, */
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
            columnDefs: [{
              targets: 1,
                data: 4,
                'checkboxes': {
                    'selectRow': true
                }
            },
            { "visible": true/* ,"targets": 4  */ }],
            select: {
                style: 'multi'
            },
            
           // order: [[1, 'asc']],
         //iDisplayLength: 10,
          /*   drawCallback: function () {
                var api = this.api();
                var rows = api.rows({ page: 'current' }).nodes();
                var last = null;

                api.column(1, { page: 'current' }).data().each(function (group, i) {
                    if (last !== group) {
                        $(rows).eq(i).before(
                            '<tr class="group"><td colspan="6">' + group + '</td></tr>'
                        );
                        last = group;
                    }
                }); */
//            }
        });
          
          
});
function getSelected(){
	var selectedIds = tbl.columns().checkboxes.selected()[0];
	console.log(selectedIds)
 
	selectedIds.forEach(function(selectedId) {
//    alert(selectedId);
	});
}

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
 var id="";
 var selectedIds = tbl.columns().checkboxes.selected()[0];
	console.log(selectedIds)
if(selectedIds.length>0)
	{
	selectedIds.forEach(function(selectedId) {
 //alert(selectedId);
 id=id+","+selectedId;
 
 
});
	//alert("IDDDDDD"+id);
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
	    	 
	    	//window.location="ApprovedTask.jsp?action=approve&id="+id+"";
	    	
	    	window.location="ActionApprovedTask.jsp?action=approve&id="+id+"";
			
	    }
	    else
	    {
	    	return false;
	    }
 }


function getcheckedrow1()
{
	/* //alert("hiiiii");
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
 */

	
	//alert("flg"+flag+"flg1"+flag1);
	/* if(flag == "success")
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
	 *///	DeleteRow(id,approvalComment);
	 var id="";
	 var cnt=0;
	 var selectedIds = tbl.columns().checkboxes.selected()[0];
		//alert("selectedIds LLLLL"+selectedIds.length);
if(selectedIds.length>0)
	{
			
		selectedIds.forEach(function(selectedId) {
   //   alert(selectedId);
	 id=id+","+selectedId;
	 cnt++;
	 
	});
		//alert(cnt);
	//	alert("IDDDDDD"+id);
		
		DeleteRow1(id,cnt);
	}
	else
	{
		alert("Please Check Task Id ");	
	}
	
	}
	/* else
	{
		alert("Please Check Task Id ");
	} */
	


function DeleteRow1(id,cnt)
{
	//alert("Control inside deldte function"+id);
//alert(id);3
var userName=document.getElementById("userName").value;
//alert(p);
	var agree=confirm("Do You Want To Reject Task ?");
	    //alert(agree);
	    if(agree)
	    {
	    	 
	    	window.location="ApprovedTask.jsp?action=reject&id="+id+"&cnt="+cnt+"";
	    	//alert(id);
	    	
	    	//window.location="ApprovedTask.jsp?action=reject&id="+id+"&cnt="+cnt+"&userName="+userName+"";
			
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
   Statement st = null,st1 = null;
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
String detp123="";


String department="";

Class.forName("com.mysql.cj.jdbc.Driver");
//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");

st=conn.createStatement();
st1=conn.createStatement();

String daydata="select DATE_FORMAT(DATE(NOW() - INTERVAL 1 Month),'%Y-%m-01') as First,LAST_DAY(NOW() - INTERVAL 1 Month) as Last,NOW() As Today";
ResultSet rsdaydata=st1.executeQuery(daydata);
String FirstDay="",LastDay="";
String Curr="",Prev1="",Prev2="",today="";
if(rsdaydata.next())
{
	  FirstDay=rsdaydata.getString("First");
	  LastDay=rsdaydata.getString("Last");
	  today=rsdaydata.getString("Today");
}
System.out.println("The total Tasks is :"+totalTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);

if(datenew1==null){
	
	System.out.println("==in if==");
	//datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(FirstDay);
	//datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(LastDay);
	
	datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(FirstDay));
	datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(LastDay));
	
	tDate1 = datenew1;
	tDate2 = datenew2;
	detp123=request.getParameter("companyName1");
	System.out.println("Dept 123 :- "+detp123);
	if(detp123==null || detp123.equals(null) || detp123.equals("null"))
	{
		System.out.println("Dept 123 In Null :- ");
		
	}
	else
	{
		System.out.println("Dept 123 In Not Null:- ");
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

String Sesrole1=session.getAttribute("role").toString();
System.out.println("Ses role :- "+Sesrole1);
String name=session.getAttribute("EmpName").toString();
String sql1="";

%>
		<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="#737373" size="3"><b>Pending Task Approval Report  <%= tDate1%> to <%=tDate2 %></b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="95%" align="center">
<tr>
<!-- <table align="right" style="width:100%"> -->
<td><input type="button" name="Create Invoice"  value="Approve" onclick="getcheckedrow()" /> 
			
				
 
<input type="button" name="Create Invoice"  value="Reject" onclick="getcheckedrow1()" /> </td>
				


<!-- </table> -->
<td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;" color="#737373"><b>Index</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="Index" id="Index" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%String Index=request.getParameter("Index");
         String Index1="";
    		System.out.println("Selected Index :- "+Index); 
    		if(Index==null)
    		{
    			Index="PI";
    		%>
    		<option value="<%=Index%>"><%=Index%></option>
    		<option value="KRA">KRA</option>
    		<%} else{
    			if(Index.equals("PI"))
    			{
    				Index1="KRA";	
    			}else
    			{
    				Index1="PI";
    			}
    			
    			
    		%>
    		<option value="<%=Index%>"><%=Index%></option>
            <option value="<%=Index1%>"><%=Index1%></option> 
            
            <%} %>
            
            
                      </select>
           </td>


<td>
         <td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;" color="#737373"><b>Department</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="companyName1" id="companyName1" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         <%--   <option ><%=cmp %></option>  --%>
           <!-- <option value="Select">Select</option> -->
           <%if(!(detp123==null || detp123.equals(null) || detp123.equals("null")))
        	   
        	   
        	   {
        	   System.out.println("***IN IF****"+detp123);
        	   System.out.println("***IN IF****");
        	   String dept1=request.getParameter("companyName1");
       		System.out.println("Selected Dept :- "+dept1);
       		%>
     	   
            <option value="<%=dept1%>"><%=dept1%></option>
            <%
       		if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD"))
            	
        	{
            	//sql1 = "select distinct(department) from dotproject.active_users where active_status='Yes' and department='"+session.getAttribute("department").toString()+"' order by department";
            	if(!(dept1==null || dept1.equals(null) || dept1.equals("null")))
            	{
            		
            		
            		
            		sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where HODReport='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dept!='"+dept1+"' and ActiveStatus='Yes' order by dept";
            	}
            	else
            	{
            		sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where HODReport='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"   and ActiveStatus='Yes' order by dept";
            				
            	}
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
        	}
       		
        	   %>
        	   
          
          <% }else
          {
        	   
        	  System.out.println("***IN ELSE****");
            
            
             if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD"))
        	
        	{
            	//sql1 = "select distinct(department) from dotproject.active_users where active_status='Yes' and department='"+session.getAttribute("department").toString()+"' order by department";
            	if(!(detp123==null || detp123.equals(null) || detp123.equals("null")))
            	{
            		
            		sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where HODReport='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and dept!='"+detp123+"' and ActiveStatus='Yes' order by dept";
            	}
            	else
            	{
            		
            		sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where HODReport='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"   and ActiveStatus='Yes' order by dept";	
            	}
        	}
            	
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
          }	%>
           </select>
           </td>
<td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;" color="#737373"><b>From</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;">

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
<td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;" color="#737373"><b>To</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font style=" font-weight: bolder;font-size: small;;font-style: normal;">
		
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
<td bgcolor="#f5f5f5" align="center"><font size="2"><input type="submit" name ="sub" id ="sub" value="Submit" onclick=" return chk()" style="background-color:#f5f5f5; "></input></font></td>
</tr>
</table>
</table>

<!-- <table align="right" style="width:100%">
<tr><td><input type="button" name="Create Invoice"  value="Approve" onclick="getcheckedrow()" /> </td> <td></td><td><td></td> 
<tr><td><input type="button" name="Create Invoice"  value="Approve" onclick="getSelected()" /> </td> <td></td><td><td></td>
			
				
 </tr>
<tr><td><input type="button" name="Create Invoice"  value="Reject" onclick="getcheckedrow1()" /> </td> <td></td><td><td></td>
			
				
</tr> 

</table>
 -->
 	
 
	<br>
		


		
            <table id="example" class="display" cellspacing="0">
                <thead>
                    <tr>
<!--                         <th bgcolor="#1582AB"></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Sr No</font></th>
 	<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">User Id</font></th>
	<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Name</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">ID</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Start</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">End</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Desc.</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Comment</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Status</font></th>
<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Attachment</font></th>


<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Duration</font></th>

<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Mail</font></th>

<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Dept.</font></th>

<th bgcolor="#1582AB"><font size="2" face="Arial" color="white">Approval</font></th>
 -->
                        
<th bgcolor="#c6deff">Sr No</th>
<th bgcolor="#c6deff"></th>
 	<th bgcolor="#c6deff">User Id</th>
	<th bgcolor="#c6deff">Name</th>
<th bgcolor="#c6deff">ID</th>
<th bgcolor="#c6deff">Start</th>
<th bgcolor="#c6deff">End</th>
<th bgcolor="#c6deff">Approval</th>
<th bgcolor="#c6deff">Desc.</th>
<th bgcolor="#c6deff">Comment</th>
<th bgcolor="#c6deff">Status</th>
<th bgcolor="#c6deff">Dept.</th>


<th bgcolor="#c6deff">Duration</th>

<th bgcolor="#c6deff">Mail</th>


<th bgcolor="#c6deff">Attachment</th>


</tr></thead><tbody>
		<%
		String fromDate = request.getParameter("from_date1");
		String toDate = request.getParameter("to_date1");
			
			System.out.println("The from Date is :"+fromDate);
			System.out.println("The to Date is :"+toDate);
			
		if(fromDate !=null && toDate !=null) {
			
			fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDate));
			toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
			
			System.out.println("The from Date is :"+fromDate);
			System.out.println("The to Date is :"+toDate);
			
			String fromDTime =fromDate+" 00:00:00";
			String toDTime =toDate+" 00:00:00";
			
			System.out.println("The from Date Time is :"+fromDTime);
			System.out.println("The to Date time is :"+toDTime);
		
		int cnt = 0;  int s=1;
		int ck=0;
		String  task_id = "",task_name = "",username="",task_owner = "",task_strtDateTime = "",Task_dur = "",taskEndDateTime = "",Task_per_com = "",task_project="";
		String maildatetime="",TaskStatus="",TaskComment="",TaskAttachment="";
		int taskpercent=0;
		String taskpercent1="";
		String taskperStatus="";
		double Task_dur1=0.00;
		//String sql_total ="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where user_id='"+user_id+"' and date(task_end_date)>='"+frmDate+"' AND date(task_end_date)<='"+toTime+"' ";
		String dept1=request.getParameter("companyName1");
		System.out.println("Selected Dept :- "+dept1);
		
		
		
		if(dept1.equals("All"))
		{
			dept1="%%";
		}
		else
		{
			dept1=request.getParameter("companyName1");
		}
		
	String sql_total="";
	
	String IdexType=request.getParameter("Index");
	
	System.out.println("Index Type :- "+IdexType);
	String dotprojectid="";
	if(IdexType.equals("PI"))
	{
		dotprojectid="b.dotprojectid";
	}
	else if(IdexType.equals("KRA"))
	{
		dotprojectid="b.KRAdotprojectid";
	}
		
		if(dept1.equals("All"))
		{
			sql_total="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata a , db_GlobalERP.UserMaster b  where date(a.taskenddate) >='"+fromDTime+"' AND date(a.taskenddate) <='"+toDTime+"' and a.TaskStatus='Pending'  and b.dept='"+dept1+"'  and a.UserId="+dotprojectid+"  and b.HODReport='"+session.getAttribute("EmpName").toString()+"'  and b.ActiveStatus='Yes' order by UserId,TaskStartDate ";
		}
		else
		{
			sql_total="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata a , db_GlobalERP.UserMaster b  where date(a.taskenddate) >='"+fromDTime+"' AND date(a.taskenddate) <='"+toDTime+"' and a.TaskStatus='Pending'  and b.dept like '"+dept1+"'  and a.UserId="+dotprojectid+"  and b.HODReport='"+session.getAttribute("EmpName").toString()+"'  and b.ActiveStatus='Yes' order by UserId,TaskStartDate ";	
		}
		
		ResultSet rs = st.executeQuery(sql_total);
		System.out.println("The query is ==>>"+sql_total);
		DecimalFormat df = new DecimalFormat("0.00");
		while(rs.next()){
/* 			++cnt; */
			ck++;
			task_id = rs.getString("TaskID");
			task_name = rs.getString("TaskName");
			task_owner = rs.getString("TaskCreater");
			TaskComment=rs.getString("a.TaskComment");

			task_strtDateTime = rs.getString("TaskStartDate");
			Task_dur1 = rs.getDouble("AssignedDuration");
			taskEndDateTime = rs.getString("TaskEndDate");
			maildatetime= rs.getString("MailDateTime");
			Task_per_com = rs.getString("UserDepartment");
			task_project=rs.getString("UserId");
			username=rs.getString("EmpName");
			
			TaskStatus=rs.getString("a.TaskStatus");
			TaskAttachment=rs.getString("TaskAttachment");
			System.out.println("TaskAttachment is ------->"+TaskAttachment);
			
			String[] TA=TaskAttachment.split(",");
			System.out.println("TA issssss------->"+TA[0]);
			//System.out.println("Arrays.toString(TA) issssss------->"+ Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1));
			//System.out.println("TaskStatus"+TaskStatus);
			System.out.println("CNTTTTTTTT is"+cnt);
			taskpercent1=rs.getString("TaskPercent");
			if(taskpercent1.equals("-"))
			{
				taskpercent=0;
			}else{
			taskpercent=rs.getInt("TaskPercent");
			}
				
			
			//System.out.println("User------->"+username);
			System.out.println("Task Percent------->"+taskpercent);
			 if(taskpercent==100)
			{
				taskperStatus="Completed";
			}
			if(taskpercent==75||taskpercent==50||taskpercent==25)
			{
				taskperStatus="In Progress";
			} 
		%>



				
				<tr>
				
				
		<td><%= s %></td>
		<td></td>
		<%-- <td><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>"  /></td> --%>
	    <td><%= task_project  %></td>
	    <td><%= username %></td>
	    <td><%=task_id %></td>
	    <td><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(task_strtDateTime)) %></td>
		<td><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(taskEndDateTime))  %></td>
		<td><%=TaskStatus   %></td>
		<td><%= task_name %></td>
		<td><%=TaskComment %></td>
		<td><%=taskperStatus%></td>
	 <td><%= Task_per_com  %></td>	
		
				
		<td><%= df.format(Task_dur1)%></td>
		<td><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(maildatetime))  %></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left">
		
	 <%
	 System.out.println("Lengthhhh"+TA.length);
	 for (int k=0;k<TA.length;k++) {
	 
		 if(TA[k].equals("-"))
		 {
				%>
				-</td> 
				
				<%System.out.println("IN"+TA[k]);

		 }
		 
		 else
		 {
	 
	 %>
	
	 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
				<%}} %>
		</td>
		
		
				
		</tr>


<%

System.out.println("Count of SSSSSS "+s);
s++;
		} %>


</tbody>
<tfoot>
            <tr>
                                    
<th bgcolor="#c6deff">Sr No</th>
<th bgcolor="#c6deff"></th>
 	<th bgcolor="#c6deff">User Id</th>
	<th bgcolor="#c6deff">Name</th>
<th bgcolor="#c6deff">ID</th>
<th bgcolor="#c6deff">Start</th>
<th bgcolor="#c6deff">End</th>
<th bgcolor="#c6deff">Approval</th>
<th bgcolor="#c6deff">Desc.</th>
<th bgcolor="#c6deff">Comment</th>
<th bgcolor="#c6deff">Status</th>
<th bgcolor="#c6deff">Dept.</th>


<th bgcolor="#c6deff">Duration</th>

<th bgcolor="#c6deff">Mail</th>



<th bgcolor="#c6deff">Attachment</th>

            </tr>
        </tfoot>

	
		</table>
		<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
 <input type="hidden" name="userName" id="userName" value="<%=username %>"/> 
		
				
<%-- <%@ include file="footer_new.jsp" %>	 --%>	
	
	
	<%} %>	
		
	
</body>

</html>