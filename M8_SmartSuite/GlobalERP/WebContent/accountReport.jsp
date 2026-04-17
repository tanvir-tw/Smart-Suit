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
	//Connection Initialization
	Connection conn = null;
	Statement st = null, st1 = null;
	ResultSet rs = null;
	int j = 0;
	String date = "", status1 = "", sql = "";
	String name = "", color = "", test="";
    String id, beneName, accNo, ifsc, bankName, branchName, email, enteredBy, levelLimit, category, accountId;
	try {
		conn = connection.getConnect("db_GlobalERP");
		st = conn.createStatement();
		st1 = conn.createStatement();
        sql = "select * from  " + session.getAttribute("CompanyMasterID").toString() + "netbankingcategory  ";
       	rs = st.executeQuery(sql);

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	<%
try{
	
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Net Banking Master</h5>
    </div>
  <br>

 <div class="row align-items-center">

    <!-- Buttons -->
    <div class="col-md-3">
     <div class="d-flex flex-column flex-sm-row gap-2">
            <a href="Accounts.jsp" class="btn btn-primary " id="button" >BACK</a>
            <a href="netbankingentryform.jsp" class="btn btn-primary " id="button" >ADD</a>
            <input type="button"  name="del" id="button" name="button" class="btn btn-primary " value="Deactivate" onclick="getcheckedrow()" />
        </div>
    </div>

    <div class="col-md-6">
    <div class="d-flex flex-column flex-sm-row gap-3 fw-bold justify-content-center text-center">
        <span style="cursor:pointer; color:#000000;"
              onclick="window.location='accountLink.jsp?st=all'">● ALL</span>

        <span style="cursor:pointer; color:#E57386;"
              onclick="window.location='accountLink.jsp?st=deactive1'">● Deactivated Account</span>

        <span style="cursor:pointer; color:#4CAF50;"
              onclick="window.location='accountLink.jsp?st=active1'">● Active Account</span>
    </div>
</div>

     <div class="col-md-3">
     </div>

</div>
 
</div>
<br>
<%
                      	String accountstate ="-";
                        try
                        {
                        	if(null!=request.getQueryString())
                        		{
                        accountstate = request.getParameter("accountstate");
                        		}
                        System.out.println("status of activation*****"+accountstate);
                        }catch(Exception e)
                        {
                        System.out.println(" accnt states"+e.toString());	
                        }
 %>
 <table id="example" class="display" style="width: 100%">  
<thead>
<tr>
<th class="col-width-4">Edit</th>
<th>Select</th>
<th>ID</th>
<th>Beneficiary Name</th>
<th>Account Number</th>
<th>IFSC Code</th>
<th>Bank Name</th>
<th>Branch Name</th>
<th>Email Id</th>
<th>Entered By</th>
<th>Entered On</th>
<th>Category</th>
<th>Emp Id</th>
<th>Status</th>
<th>Level Limit</th>
</tr>
</thead>
<tbody>

<%
 if(accountstate.equalsIgnoreCase("-")){
	 sql = "select * from  "+session.getAttribute("CompanyMasterID").toString()+"netbanking ORDER BY `ID` ASC ";
 }
 else if(accountstate.equalsIgnoreCase("active1"))
 {
	 sql = "select * from  "+session.getAttribute("CompanyMasterID").toString()+"netbanking where Status='-' ORDER BY `ID` ASC ";
 }
 else if(accountstate.equalsIgnoreCase("deactive1"))
 {
	 sql = "select * from  "+session.getAttribute("CompanyMasterID").toString()+"netbanking where Status='Deactivate' ORDER BY `ID` ASC ";
 }else
 {
	 sql = "select * from  "+session.getAttribute("CompanyMasterID").toString()+"netbanking  ORDER BY `ID` ASC ";
 }
   rs = st.executeQuery(sql);
 System.out.println("query for report====>>>"+sql);
 while(rs.next())
 {  
	    id = rs.getString("id");
	    beneName = rs.getString("BeneficiaryName");
	    accNo = rs.getString("BeneficiaryAccountNumber");
	    ifsc = rs.getString("IFCCode");
	    bankName = rs.getString("BeneBankName");
	    branchName = rs.getString("BeneBankBranchName");
	    email = rs.getString("Beneficiaryemailid");
	    enteredBy = rs.getString("EnteredBy");
	    levelLimit = rs.getString("Level1Limit");
	    category = rs.getString("Category");
	    accountId = rs.getString("AccountID");

	 j++;
	 if (rs.getString("Status").equalsIgnoreCase("Deactivate")) {
		 color = "#FAAFBE";
		} else 
		{
			color = "#AEF8B1";
		}
	 System.out.println("colorrrrrrr"+color);
 %>
 <tr style="background: <%=color%>;">
 <td style="background: <%=color%>;"><a href="editnetbankdata.jsp?ID=<%=id%>">
<img src="images/edit1.jpeg" width ="18px" height="18px"></a></td>
 <%status1=rs.getString("Status");	
	if(status1.equalsIgnoreCase("Deactivate") )
	{
		%>
		<td style="background: <%=color%>;" ><div  style="visibility:hidden"><input type="checkbox" name="chkbx" disabled="disabled" id="chk<%=j%>" /></div></td>
		<%
	}else 
	{
		%>
		<td style="background: <%=color%>;" ><input type="checkbox" name="chkbx" id="chk<%=j%>" /></td>
		<%
	}	
	%> 
<td class="text-center" style="background:<%=color%>;" id="net_id<%=j%>"><%= id %></td>
<td class="text-left" style="background:<%=color%>;"><%= beneName %></td>
<td class="text-center" style="background:<%=color%>;"><%= accNo %></td>
<td class="text-left" style="background:<%=color%>;"><%= ifsc %></td>
<td class="text-left" style="background:<%=color%>;"><%= bankName %></td>
<td class="text-left" style="background:<%=color%>;"><%= branchName %></td>
<td class="text-left" style="background:<%=color%>;"><%= email %></td>
<td class="text-center" style="background:<%=color%>;"><%= enteredBy %></td>
 <%

 try
	{
	 test=rs.getString("EnteredOn");
	System.out.println("creationDate======>1111"+test);
	if(test!=null)
	{
		if(test.equalsIgnoreCase("0000-00-00"))
		{
			test="0000-00-00";
		}
		else
		{
		test=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(test));
		}
		System.out.println("creationDate======>"+test);
	}
	else
	{
		test="0000-00-00";
	}
	}catch(Exception e)
	{
		test="0000-00-00";
		System.out.println("date==22=>"+e.toString());
	}
 %> 
 <td class="text-left" style="background: <%=color%>;" ><%=test%></td>
 <td class="text-left" style="background: <%=color%>;" ><%=category%></td>
 <td class="text-right" style="background: <%=color%>;"  ><%=accountId%></td>
 <%
 String status="";
 try{
	 status=rs.getString("Status") ;
	 if(status.equalsIgnoreCase("Deactivate"))
	 {
		 status="Deactive";
	 }
	 else
	 {
		 status="Active";
	 }
 }catch(Exception e)
 {
	 status="test";
	 System.out.println("exception------>"+e);
 } 
 %> 
 <td class="text-left" style="background: <%=color%>;" ><%=status%></td>
 <td class="text-center" style="background: <%=color%>;" ><%=levelLimit%></td>
</tr>
<% }%>
 </tbody>
</table>
</div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>  <script type="text/javascript">
function DeleteRow(id)
{
	var agree=confirm("Do You Want to Deactivate this Record?");
	    if(agree)
	    {
		 var ajaxRequest;  
		    try
		    {	
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
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
				if(ajaxRequest.readyState == 4 )
				{	
				  var reslt=ajaxRequest.responseText;
				  var data=reslt;
				  data=data.replace(/^\s+|\s+$/g,"");
				  var z=data.split("#");
				 	if(data=="Yes")
					{					
                        alert("Record Deactivated Successfully.");
				    	window.location.reload();
					}
					if(data=="No")
					{					
                       alert("Error In Deactivating .");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=delete&id="+id;
			ajaxRequest.open("GET", "AjaxAccountDelete.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	
function getcheckedrow()
{
	var cnt1=0,k=1,flag="t";
	var chklength=document.getElementsByName("chkbx");
	var i=1,j,cnt=0;
	var id="";
    for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
	if(flag == "success")
	{
	for(cnt=0;cnt<chklength.length;cnt++)
	{		
		if(document.getElementById("chk"+i).checked)
		{
			id=id+","+document.getElementById("net_id1"+i).innerHTML;
		}
		i++;
	}
	DeleteRow(id);
	}
	else
	{
		alert("Please Select Account For Deactivation");
	}	
}
</script>
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
	         fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
	        keys: true,  //Keytable
	        stateSave: true,
	       lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
								title: 'Net Bank Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Net Bank Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Net Bank Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Net Bank Report ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Net Bank Report ',
							},
					],
				},
				
           ], 
       
       });
   });
</script>
 <%@ include file="footer.jsp" %>  
</body>
</html>